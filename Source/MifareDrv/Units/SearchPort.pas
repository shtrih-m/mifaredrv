unit SearchPort;

interface

uses
  // VCL
  Windows, SysUtils, Classes, ComObj, ActiveX, SyncObjs,
  // This
  NotifyThread, MifareLib_TLB;

type
  { TSearchPortRec }

  TSearchPortRec = record
    PortName: string;
    PortNumber: Integer;
  end;

  TSearchPort = class;

  { TSearchPorts }

  TSearchPorts = class
  private
    FList: TList;
    FLock: TCriticalSection;

    procedure InsertItem(AItem: TSearchPort);
    procedure RemoveItem(AItem: TSearchPort);

    function GetCount: Integer;
    function GetItem(Index: Integer): TSearchPort;
    function ValidIndex(AIndex: Integer): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Lock;
    procedure Unlock;
    procedure ClearState;
    function Add: TSearchPort;
    function Completed: Boolean;
    function ItemByID(AID: Integer): TSearchPort;
    function ItemByIndex(AIndex: Integer): TSearchPort;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TSearchPort read GetItem; default;
  end;

  { TSearchPort }

  TSearchPort = class
  private
    FID: Integer;
    FText: string;
    FStopFlag: Boolean;
    FSelected: Boolean;
    FBaudRate: Integer;
    FDeviceFound: Boolean;
    FParamsText: string;
    FOwner: TSearchPorts;
    FData: TSearchPortRec;
    FCompleted: Boolean;
    FThread: TNotifyThread;

    function GetText: string;
    function GetParamsText: string;
    procedure ThreadProc(Sender: TObject);
    procedure SetText(const Value: string);
    procedure SetOwner(AOwner: TSearchPorts);
    procedure SetData(const Value: TSearchPortRec);
    procedure SetParamsText(const Value: string);
    procedure SearchByBaudRates(Driver: TMifareDrv);
  public
    constructor Create(AOwner: TSearchPorts);
    destructor Destroy; override;

    procedure Start;
    procedure Stop;

    procedure Lock;
    procedure Unlock;
    procedure ClearState;
    procedure SearchDevice;

    property ID: Integer read FID;
    property BaudRate: Integer read FBaudRate;
    property Completed: Boolean read FCompleted;
    property PortName: string read FData.PortName;
    property Text: string read GetText write SetText;
    property PortNumber: Integer read FData.PortNumber;
    property Data: TSearchPortRec read FData write SetData;
    property Selected: Boolean read FSelected write FSelected;
    property DeviceFound: Boolean read FDeviceFound write FDeviceFound;
    property ParamsText: string read GetParamsText write SetParamsText;
  end;

implementation

resourcestring
  SDeviceNotFound = 'не найдено';
  SSearchIsInProgress = 'идет поиск...';

const
  E_NOHARDWARE = -1;

  BaudRates: array [0..6] of Integer = (
  2400,
  4800,
  9600,
  19200,
  38400,
  57600,
  115200);

const
  ParityList: array [0..1] of Integer = (NOPARITY, EVENPARITY);


function GetParityText(Parity: Integer): string;
begin
  case Parity of
    NOPARITY   : Result := 'нет';
    ODDPARITY  : Result := 'нечетный';
    EVENPARITY : Result := 'четный';
    MARKPARITY : Result := 'установлен';
    SPACEPARITY: Result := 'сброшен';
  else
    Result := 'нет';
  end;
end;

{ TSearchPorts }

constructor TSearchPorts.Create;
begin
  inherited Create;
  FList := TList.Create;
  FLock := TCriticalSection.Create;
end;

destructor TSearchPorts.Destroy;
begin
  Clear;
  FList.Free;
  FLock.Free;
  inherited Destroy;
end;

procedure TSearchPorts.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TSearchPorts.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TSearchPorts.GetItem(Index: Integer): TSearchPort;
begin
  Result := FList[Index];
end;

procedure TSearchPorts.InsertItem(AItem: TSearchPort);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TSearchPorts.RemoveItem(AItem: TSearchPort);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

procedure TSearchPorts.Lock;
begin
  FLock.Enter;
end;

procedure TSearchPorts.Unlock;
begin
  FLock.Leave;
end;

function TSearchPorts.ItemByID(AID: Integer): TSearchPort;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    Result := Items[i];
    if Result.ID = AID then Exit;
  end;
  Result := nil;
end;

function TSearchPorts.ValidIndex(AIndex: Integer): Boolean;
begin
  Result := (AIndex >= 0)and(AIndex < Count);
end;

function TSearchPorts.ItemByIndex(AIndex: Integer): TSearchPort;
begin
  Result := nil;
  if ValidIndex(AIndex) then
    Result := Items[AIndex];
end;

function TSearchPorts.Add: TSearchPort;
begin
  Result := TSearchPort.Create(Self);
end;

procedure TSearchPorts.ClearState;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].ClearState;
end;

function TSearchPorts.Completed: Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Count-1 do
  begin
    Result := Items[i].Completed;
    if not Result then Break;
  end;
end;

{ TSearchPort }

constructor TSearchPort.Create(AOwner: TSearchPorts);
const
  LastID: Integer = 0;
begin
  inherited Create;
  SetOwner(AOwner);
  Inc(LastID); FID := LastID;
end;

destructor TSearchPort.Destroy;
begin
  Stop;
  FThread.Free;
  SetOwner(nil);
  inherited Destroy;
end;

procedure TSearchPort.SetOwner(AOwner: TSearchPorts);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

procedure TSearchPort.Lock;
begin
  FOwner.Lock;
end;

procedure TSearchPort.Unlock;
begin
  FOwner.Unlock;
end;

procedure TSearchPort.SetData(const Value: TSearchPortRec);
begin
  Lock;
  try
    FData := Value;
  finally
    Unlock;
  end;
end;

function TSearchPort.GetText: string;
begin
  Lock;
  try
    Result := FText;
  finally
    Unlock;
  end;
end;

procedure TSearchPort.SetText(const Value: string);
begin
  Lock;
  try
    FText := Value;
  finally
    Unlock;
  end;
end;

procedure TSearchPort.ClearState;
begin
  Text := '';
  FCompleted := False;
  ParamsText := '';
  DeviceFound := False;
end;

function TSearchPort.GetParamsText: string;
begin
  Lock;
  try
    Result := FParamsText;
  finally
    Unlock;
  end;
end;

procedure TSearchPort.SetParamsText(const Value: string);
begin
  Lock;
  try
    FParamsText := Value;
  finally
    Unlock;
  end;
end;

procedure TSearchPort.SearchDevice;
var
  Driver: TMifareDrv;
begin
  if not Selected then Exit;
  FStopFlag := False;
  Driver := TMifareDrv.Create(nil);
  try
    Text := SSearchIsInProgress;
    Driver.PortNumber := PortNumber;
    SearchByBaudRates(Driver);
  finally
    Driver.Free;
  end;
end;

procedure TSearchPort.SearchByBaudRates(Driver: TMifareDrv);
var
  i: Integer;
  ResultCode: Integer;
  ParityIndex: Integer;
begin
  DeviceFound := False;
  for i := Low(BaudRates) to High(BaudRates) do
  begin
    if FStopFlag then
      raise EAbort.Create(SDeviceNotFound);

    for ParityIndex := Low(ParityList) to High(ParityList) do
    begin
      FBaudRate := BaudRates[i];
      Driver.PortBaudRate := FBaudRate;
      Driver.Parity := ParityList[ParityIndex];
      ParamsText := IntToStr(FBaudRate);
      Driver.Disconnect;
      ResultCode := Driver.Connect;
      if ResultCode = 0 then
        ResultCode := Driver.PcdGetFwVersion;

      DeviceFound := ResultCode >= E_NOERROR;
      case ResultCode of
        E_NOHARDWARE  : Text := SDeviceNotFound;
        E_NOERROR     : Text := TrimRight(Driver.PcdFwVersion);
      else
        Text := Format('%d: %s', [ResultCode, Driver.ResultDescription]);
      end;
      if DeviceFound then Exit;
    end;
  end;
end;

procedure TSearchPort.Start;
begin
  ClearState;
  FThread.Free;
  FThread := TNotifyThread.CreateThread(ThreadProc);
end;

procedure TSearchPort.ThreadProc(Sender: TObject);
begin
  try
    OleCheck(CoInitialize(nil));
    try
      SearchDevice;
   finally
      CoUninitialize;
    end;
  except
    on E: Exception do
    begin
      Text := E.Message;
    end;
  end;
  FCompleted := True;
end;

procedure TSearchPort.Stop;
begin
  FStopFlag := True;
end;

end.
