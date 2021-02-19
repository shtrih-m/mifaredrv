unit MifareDevice;

interface

Uses
  // VCL
  Windows, Classes, SysUtils,
  // This
  NotifyThread, untError, SerialParams, CardReaderInterface, untUtil,
  LogFile, MifareLib_TLB, MFRC500Reader, OmnikeyCardReader,
  OmnikeyCardReader5422, CardReaderEmulator;

type
  TMifareDevice = class;

  { TCardFoundEventRec }

  TCardFoundEventRec = record
    CardUIDHex: string;
    PortNumber: Integer;
  end;

  { TPollErrorEventRec }

  TPollErrorEventRec = record
    ErrorText: string;
    ErrorCode: Integer;
    PortNumber: Integer;
  end;

  TPollErrorEvent = procedure(ASender: TObject; const Event: TPollErrorEventRec) of object;
  TCardFoundEvent = procedure(ASender: TObject; const Event: TCardFoundEventRec) of object;

  { TMifareDevices }

  TMifareDevices = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TMifareDevice;
    procedure Clear;
    procedure InsertItem(AItem: TMifareDevice);
    procedure RemoveItem(AItem: TMifareDevice);
  public
    constructor Create;
    destructor Destroy; override;

    function Add(PortNumber: Integer): TMifareDevice;
    function ItemByPortNumber(PortNumber: Integer): TMifareDevice;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TMifareDevice read GetItem; default;
  end;

  { TMifareDevice }

  TMifareDevice = class
  private
    FStopFlag: Boolean;
    FPortNumber: Integer;
    FPollStarted: Boolean;
    FThread: TNotifyThread;
    FOwner: TMifareDevices;
    FParams: TSerialParams;
    FOnCardFound: TCardFoundEvent;
    FOnPollError: TPollErrorEvent;

    procedure PollProc(Sender: TObject);
    procedure SleepEx(Interval: Integer);
    procedure SetOwner(AOwner: TMifareDevices);
    procedure PollErrorEvent(AErrorCode, APortNumber: Integer;
      const AErrorText: string);
    procedure CardFoundEvent(const CardUIDHex: string);
    function CreateCardReader: ICardReader;
    procedure SetParams(const Value: TSerialParams);
  public
    constructor Create(AOwner: TMifareDevices; APortNumber: Integer);
    destructor Destroy; override;

    procedure PollStop;
    procedure PollStart;

    property PortNumber: Integer read FPortNumber;
    property PollStarted: Boolean read FPollStarted;
    property Params: TSerialParams read FParams write SetParams;
    property OnCardFound: TCardFoundEvent read FOnCardFound write FOnCardFound;
    property OnPollError: TPollErrorEvent read FOnPollError write FOnPollError;
  end;

implementation

{ TMifareDevices }

constructor TMifareDevices.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TMifareDevices.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TMifareDevices.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TMifareDevices.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TMifareDevices.GetItem(Index: Integer): TMifareDevice;
begin
  Result := FList[Index];
end;

procedure TMifareDevices.InsertItem(AItem: TMifareDevice);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TMifareDevices.RemoveItem(AItem: TMifareDevice);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TMifareDevices.Add(PortNumber: Integer): TMifareDevice;
begin
  Result := TMifareDevice.Create(Self, PortNumber);
end;

function TMifareDevices.ItemByPortNumber(
  PortNumber: Integer): TMifareDevice;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    Result := Items[i];
    if Result.PortNumber = PortNumber then Exit;
  end;
  Result := nil;
end;

{ TMifareDevice }

constructor TMifareDevice.Create(AOwner: TMifareDevices; APortNumber: Integer);
begin
  inherited Create;
  FPortNumber := APortNumber;
  FParams := TSerialParams.Create;
  SetOwner(AOwner);
end;

destructor TMifareDevice.Destroy;
begin
  SetOwner(nil);
  PollStop;
  FThread.Free;
  FParams.Free;
  inherited Destroy;
end;

procedure TMifareDevice.SetOwner(AOwner: TMifareDevices);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

procedure TMifareDevice.PollStart;
begin
  PollStop;
  FStopFlag := False;
  FPollStarted := True;
  FThread := TNotifyThread.CreateThread(PollProc);
end;

procedure TMifareDevice.PollStop;
begin
  FStopFlag := True;
  FThread.Free;
  FThread := nil;
  FPollStarted := False;

end;

procedure TMifareDevice.SleepEx(Interval: Integer);
var
  TickCount: Integer;
begin
  TickCount := GetTickCount;
  repeat
    Sleep(20);
  until FStopFlag or ((Integer(GetTickCount) - TickCount) > Interval);
end;

procedure TMifareDevice.CardFoundEvent(const CardUIDHex: string);
var
  Data: TCardFoundEventRec;
begin
  if Assigned(FOnCardFound) then
  begin
    Data.CardUIDHex := CardUIDHex;
    Data.PortNumber := PortNumber;
    FOnCardFound(Self, Data);
  end;
end;

procedure TMifareDevice.PollErrorEvent(AErrorCode, APortNumber: Integer;
  const AErrorText: string);
var
  Data: TPollErrorEventRec;
begin
  if Assigned(FOnPollError) then
  begin
    Data.ErrorText := AErrorText;
    Data.ErrorCode := AErrorCode;
    Data.PortNumber := APortNumber;
    FOnPollError(Self, Data);
  end;
end;

procedure TMifareDevice.PollProc(Sender: TObject);
var
  CardSAK: Byte;
  CardATQ: WORD;
  CardUID: string;
  CardUIDLen: Byte;
  CardUIDHex: string;
  AErrorText: string;
  AErrorCode: Integer;
  Reader: ICardReader;
  DriverError: EDriverError;
begin
  try
    Reader := CreateCardReader;
    repeat
      try
        Reader.Lock;
        try
          Reader.OpenPort;
          if FParams.PollActivateMethod = POLL_ACTIVATE_IDLE then
          begin
            Reader.Mf500PiccActivateIdle(FParams.CardBaudrate, CardATQ,
              CardSAK, CardUIDLen, CardUID);
          end else
          begin
            Reader.Mf500PiccActivateWakeup(FParams.CardBaudrate, CardATQ,
              CardSAK, CardUID, CardUIDLen);
          end;
          CardUIDHex := untUtil.BinToHex(CardUID, Length(CardUID));
          CardFoundEvent(CardUIDHex);
          Reader.Mf500PiccHalt;
          Reader.ClosePort;
          if FParams.PollAutoDisable then Exit;
        finally
          Reader.Unlock;
        end;
      except
        on E: EDriverError do
        begin
          if E.ErrorCode < 0 then
          begin
            PollErrorEvent(E.ErrorCode, PortNumber, E.Message);
            Logger.Error('Poll thread error: ' + E.Message);
          end;
        end;
      end;
      if FStopFlag then Exit;
      SleepEx(FParams.PollInterval);
    until FStopFlag;
  except
    on E: Exception do
    begin
      Logger.Error('TDriver.PollProc: ' + E.Message);

      AErrorText := E.Message;
      if E is EDriverError then
      begin
        DriverError := E as EDriverError;
        AErrorCode := DriverError.ErrorCode;
      end else
      begin
        AErrorCode := Integer(E_UNKNOWN);
      end;
      PollErrorEvent(AErrorCode, PortNumber, AErrorText);
    end;
  end;
end;

function TMifareDevice.CreateCardReader: ICardReader;
begin
  case FParams.DeviceType of
    dtMiReader    : Result := TMFRC500Reader.Create(Params);
    dtCardman5321 : Result := TOmnikeyCardReader.Create(Params);
    dtEmulator    : Result := TCardReaderEmulator.Create;
    dtOmnikey5422 : Result := TOmnikeyCardReader5422.Create(Params);
  else
    Result := TOmnikeyCardReader.Create(Params);
  end;
end;

procedure TMifareDevice.SetParams(const Value: TSerialParams);
begin
  FParams.Assign(Value);
end;

end.
