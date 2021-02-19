unit OmnikeyReader;

interface

uses
  // VCL
  Windows, Classes, SysUtils,
  // This
  SCardSyn, SCardUtil, WinSCard, WinSmCrd, SCardErr, LogFile, untError,
  untUtil, MifareLib_TLB;

const
  /////////////////////////////////////////////////////////////////////////////
  // CM_IOCTL_SIGNAL constants

  PAYPASS_SIGNAL             = $20; // Complete PayPass Audio and Visual Sequence
  PAYPASS_SIGNAL_MAINLED     = $21; // Control of Main LED
  PAYPASS_SIGNAL_ADDLED      = $22; // Control of additional PayPass LED 2-4
  ACOUSTIC_SIGNAL_BEEPER_ON  = $10; // Control of PayPass Audio Tone ON
  ACOUSTIC_SIGNAL_BEEPER_OFF = $11; // Control of PayPass Audio Tone OFF

  /////////////////////////////////////////////////////////////////////////////
  // CM_IOCTL_SET_OPERATION_MODE constants

  OPERATION_MODE_RFID_ISO     = $10;
  OPERATION_MODE_RFID_PAYPASS = $11;

type
  { TSmartCardReader }

  TOmnikeyReader = class
  private
    FATR: string;
    FCard: Longint;
    FState: Longint;
    FProtocol: DWORD;
    FReaderName: string;
    FContext: SCARDCONTEXT;
    FCurrentState: DWORD;
    FCardName: string;
    FCardCode: Integer;
    FCardType: TCardType;
    FOnStateChanged: TNotifyEvent;
    CM_IOCTL_SIGNAL: DWORD;
    CM_IOCTL_SET_OPERATION_MODE: DWORD;


    procedure FreeContext;
    procedure Check(Code: Integer);
    procedure SetCurrentState(Value: DWORD);
    function SCardGetAttribute(AttrId: DWORD): string;

    property Context: SCARDCONTEXT read FContext;
  protected
    function GetCard: Longint;
    procedure RaiseReaderError(Code: Integer; const Text: string);
    function IsCommandFailed(Code: Integer): Boolean;
    function SendCommand(const TxData: string): Integer; overload;
    function GetAnswerCode(const Answer: string): Integer;
    procedure SendCommand(const TxData: string; var RxData: string); overload;
    procedure CheckAnswerLength(const Data: string; MinLength: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Connect;
    procedure GetStatus;
    procedure BeeperOn;
    procedure BeeperOff;
    procedure SetPayPassMode;
    function Connected: Boolean;
    function ReadUID: string;
    function ListCards: string;
    function ListReaders: string;
    function Disconnect: Integer;
    function ListReaderGroups: string;
    function SCardGetVendorName: string;
    function GetFirmwareVersion: string;
    function WaitForCard(Timeout: Integer): Boolean;
    function WaitForCardRemoved(Timeout: Integer): Boolean;
    function GetStatusChange(Timeout: Integer): Integer;
    function GetStateText(State: DWORD): string;
    function ReadBinary(BlockNumber: Integer): string;

    procedure WriteKeyToReader(
      KeyNumber: Integer;
      const KeyData: string;
      SecuredTransmission: Boolean;
      EncryptionKeyNumber: Integer);

    procedure DoSCardControl(Code: Integer);
    procedure Authenticate(BlockNumber, MifareAuthMode, KeyNumber: Integer);
    procedure AuthenticateKey(BlockNumber, AuthMode: Integer; const Data: string);
    procedure WriteBinary(BlockNumber: Integer; const BlockData: string);
    procedure MifareIncrement(BlockNumber, Value: Integer);
    procedure MifareDecrement(BlockNumber, Value: Integer);
    procedure MifareTransfer(BlockNumber, TransBlockNumber, Value, Address: Integer);
    procedure MifareRestore(BlockNumber, TransBlockNumber, Value, Address, AuthType, KeyNumber: Integer);
    procedure ControlLED(RedLED, GreenLED, BlueLED, YellowLed: Boolean);

    property ATR: string read FATR;
    property State: Longint read FState;
    property Protocol: DWORD read FProtocol;
    property CardName: string read FCardName;
    property CardType: TCardType read FCardType;
    property CurrentState: DWORD read FCurrentState;
    property ReaderName: string read FReaderName write FReaderName;
    property OnStateChanged: TNotifyEvent read FOnStateChanged write FOnStateChanged;
  end;

  { EScardException }

  EScardException = class(Exception)
  private
    FCode: Integer;
  public
    constructor Create(ACode: Integer; const AMsg: string);
    property Code: Integer read FCode;
  end;

function SCardGetReaderNames: string;

implementation

const
  KEY_STRUCTURE_CARDKEY   = $00;
  KEY_STRUCTURE_READERKEY = $80;

  KEY_STRUCTURE_PLAIN_TRANSMITTION = 0;
  KEY_STRUCTURE_SECURED_TRANSMITTION = $40;

  KEY_STRUCTURE_VOLATILE_MEMORY = 0;
  KEY_STRUCTURE_NONVOLATILE_MEMORY = $20;


function SCardGetReaderNames: string;
var
  Device: TOmnikeyReader;
begin
  Result := '';
  try
    Device := TOmnikeyReader.Create;
    try
      Result := Device.ListReaders;
    finally
      Device.Free;
    end;
  except
    { !!! }
  end;
end;

function Replace0(const Text: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Text) do
  begin
    if Text[i] = #0 then Result := Result + #13#10
    else Result := Result + Text[i];
  end;
end;

{ EScardException }

constructor EScardException.Create(ACode: Integer; const AMsg: string);
begin
  inherited Create(AMsg);
  FCode := ACode;
end;

{ TOmnikeyReader }

constructor TOmnikeyReader.Create;
begin
  inherited Create;
  CM_IOCTL_SIGNAL := SCARD_CTL_CODE(3058);
  CM_IOCTL_SET_OPERATION_MODE := SCARD_CTL_CODE(3107);
  Check(SCardEstablishContext(SCARD_SCOPE_USER, nil, nil, @FContext));
end;

destructor TOmnikeyReader.Destroy;
begin
  Disconnect;
  FreeContext;
  inherited Destroy;
end;

function TOmnikeyReader.GetAnswerCode(const Answer: string): Integer;
var
  L: Integer;
begin
  L := Length(Answer);
  CheckAnswerLength(Answer, 2);
  Result := (Ord(Answer[L-1]) shl 8) + Ord(Answer[L]);
end;

procedure TOmnikeyReader.CheckAnswerLength(const Data: string; MinLength: Integer);
begin
  if Length(Data) < MinLength then
    RaiseReaderError(E_ANSWER_LENGTH, S_ANSWER_LENGTH);
end;

function TOmnikeyReader.IsCommandFailed(Code: Integer): Boolean;
begin
  Result := Code <> $9000;
end;

procedure TOmnikeyReader.RaiseReaderError(Code: Integer; const Text: string);
begin
  raise Exception.CreateFmt('Error: 0x%.4X, %s', [Code, Text]);
end;

procedure TOmnikeyReader.Check(Code: Integer);
begin
  if Code <> SCARD_S_SUCCESS then
  begin
    if Code = Integer(SCARD_W_REMOVED_CARD) then
    begin
      Disconnect;
    end;

    Logger.Debug(SCardGetErrorMessage(Code));
    if Code = Integer(SCARD_W_REMOVED_CARD) then
    begin
      RaiseError(E_REMOVED_CARD, 'Ошибок нет, карта отсутствует');
    end else
    begin
      RaiseReaderError(Code, SCardGetErrorMessage(Code));
    end;
  end;
end;

procedure TOmnikeyReader.FreeContext;
begin
  if FContext <> 0 then
    SCardReleaseContext(FContext);
end;

function TOmnikeyReader.GetCard: Longint;
begin
  if FCard = 0 then
    Connect;
  Result := FCard;
end;

function TOmnikeyReader.ListReaders: string;
var
  Text: string;
  BufSize: Longint;
begin
  Result := '';
  Check(SCardListReadersA(Context, nil, nil, BufSize));
  if BufSize > 0 then
  begin
    SetLength(Text, BufSize);
    Check(SCardListReadersA(Context, nil, @Text[1], BufSize));
    Result := Replace0(Trim(Text));
  end;
end;

function TOmnikeyReader.ListCards: string;
var
  Atr: Byte;
  Text: string;
  BufSize: Longint;
begin
  Atr := 0;
  Result := '';
  Check(SCardListCardsA(Context, @Atr, nil, 0, nil, BufSize));
  if BufSize > 0 then
  begin
    SetLength(Text, BufSize);
    Check(SCardListCardsA(Context, @Atr, nil, 0, @Text[1], BufSize));
    Result := Replace0(Trim(Text));
  end;
end;

function TOmnikeyReader.ListReaderGroups: string;
var
  Text: string;
  BufSize: Longint;
begin
  Result := '';
  Check(SCardListReaderGroupsA(Context, nil, BufSize));
  if BufSize > 0 then
  begin
    SetLength(Text, BufSize);
    Check(SCardListReaderGroupsA(Context, @Text[1], BufSize));
    Result := Replace0(Trim(Text));
  end;
end;

function TOmnikeyReader.WaitForCard(
  Timeout: Integer): Boolean;
var
  TickCount: Integer;
  ResultCode: DWORD;
begin
  Result := True;
  TickCount := GetTickCount;
  repeat
    Disconnect;
    ResultCode := SCardConnectA(Context, PChar(ReaderName),
      SCARD_SHARE_SHARED, SCARD_PROTOCOL_T0 + SCARD_PROTOCOL_T1,
      FCard, @FProtocol);

    case ResultCode of
      SCARD_S_SUCCESS: Exit;
      SCARD_E_NO_SMARTCARD: ; //
      SCARD_W_REMOVED_CARD: ;
    else
      Check(ResultCode);
    end;
  until (Integer(GetTickCount) - TickCount) > Timeout;
  Result := False;
end;

function TOmnikeyReader.WaitForCardRemoved(Timeout: Integer): Boolean;
var
  TickCount: Integer;
  ResultCode: DWORD;
begin
  Result := True;

  TickCount := GetTickCount;
  repeat
    Disconnect;
    ResultCode := SCardConnectA(Context, PChar(ReaderName),
      SCARD_SHARE_EXCLUSIVE, SCARD_PROTOCOL_T0 + SCARD_PROTOCOL_T1,
      FCard, @FProtocol);

    case ResultCode of
      SCARD_S_SUCCESS: ;
      SCARD_E_NO_SMARTCARD: ; //
      SCARD_W_REMOVED_CARD: Exit;
    else
      Check(ResultCode);
    end;
  until (Integer(GetTickCount) - TickCount) > Timeout;
  Result := False;
end;

function TOmnikeyReader.Connected: Boolean;
begin
  Result := FCard <> 0;
end;

function TOmnikeyReader.Disconnect: Integer;
begin
  Result := SCARD_S_SUCCESS;
  if Connected then
  begin
    Result := SCardDisconnect(FCard, SCARD_LEAVE_CARD);
    FCard := 0;
  end;
end;

procedure TestState(Value, State: Integer;
  const StateText: string; var Result: string);
begin
  if (Value and State) <> 0 then
  begin
    if Result <> '' then Result := Result + ', ';
    Result := Result + StateText;
  end;
end;

function TOmnikeyReader.GetStateText(State: DWORD): string;
begin
  Result := '';
  TestState(State, SCARD_STATE_IGNORE, 'SCARD_STATE_IGNORE', Result);
  TestState(State, SCARD_STATE_CHANGED, 'SCARD_STATE_CHANGED', Result);
  TestState(State, SCARD_STATE_UNKNOWN, 'SCARD_STATE_UNKNOWN', Result);
  TestState(State, SCARD_STATE_UNAVAILABLE, 'SCARD_STATE_UNAVAILABLE', Result);
  TestState(State, SCARD_STATE_EMPTY, 'SCARD_STATE_EMPTY', Result);
  TestState(State, SCARD_STATE_PRESENT, 'SCARD_STATE_PRESENT', Result);
  TestState(State, SCARD_STATE_ATRMATCH, 'SCARD_STATE_ATRMATCH', Result);
  TestState(State, SCARD_STATE_EXCLUSIVE, 'SCARD_STATE_EXCLUSIVE', Result);
  TestState(State, SCARD_STATE_INUSE, 'SCARD_STATE_INUSE', Result);
  TestState(State, SCARD_STATE_MUTE, 'SCARD_STATE_MUTE', Result);
  TestState(State, SCARD_STATE_UNPOWERED, 'SCARD_STATE_UNPOWERED', Result);
end;

procedure TOmnikeyReader.SetCurrentState(Value: DWORD);
begin
  if Value <> FCurrentState then
  begin
    FCurrentState := Value;
    if Assigned(FOnStateChanged) then
      FOnStateChanged(Self);
  end;
end;

function TOmnikeyReader.GetStatusChange(Timeout: Integer): Integer;
var
  P: SCARD_READERSTATEA;
begin
  FillChar(P, Sizeof(P), 0);
  P.szReader := PChar(ReaderName);
  P.dwCurrentState := CurrentState;
  P.dwEventState := SCARD_STATE_EMPTY;
  Result := SCardGetStatusChangeA(Context, Timeout, @P, 1);
  if Result = SCARD_S_SUCCESS then
  begin
    Logger.Debug(Format('State   : 0x%.8xh, %s', [P.dwEventState, GetStateText(P.dwEventState)]));
    SetCurrentState(P.dwEventState);
  end else
  begin
    Logger.Debug('SCardGetStatusChange: ' + SCardGetErrorMessage(Result));
  end;
end;

procedure TOmnikeyReader.Connect;
begin
  Disconnect;
  Check(SCardConnectA(Context, PChar(ReaderName),
    SCARD_SHARE_SHARED, SCARD_PROTOCOL_T0 + SCARD_PROTOCOL_T1,
    FCard, @FProtocol));
end;

function TOmnikeyReader.SendCommand(const TxData: string): Integer;
var
  RxData: string;
begin
  SendCommand(TxData, RxData);
  CheckAnswerLength(RxData, 2);
  Result := (Ord(RxData[1]) shl 8) + Ord(RxData[2]);
end;

procedure TOmnikeyReader.SendCommand(const TxData: string; var RxData: string);
var
  RecvBuffer: string;
  RecvLength: Integer;
  pioSendPci: SCARD_IO_REQUEST;
  pioRecvPci: SCARD_IO_REQUEST;
begin
  pioRecvPci.dwProtocol := SCARD_PROTOCOL_T1;
  pioRecvPci.dbPciLength := 8;
  pioSendPci.dwProtocol := SCARD_PROTOCOL_T1;
  pioSendPci.dbPciLength := 8;

  RecvLength := $FF;
  SetLength(RecvBuffer, RecvLength);
  Check(SCardTransmit(GetCard, @pioSendPci, @TxData[1], Length(TxData),
    @pioRecvPci, @RecvBuffer[1], @RecvLength));
  SetLength(RecvBuffer, RecvLength);
  RxData := RecvBuffer;
end;

procedure TOmnikeyReader.WriteKeyToReader(
  KeyNumber: Integer;
  const KeyData: string;
  SecuredTransmission: Boolean;
  EncryptionKeyNumber: Integer);

  // Error codes on key write command
  function GetErrorText(Code: Integer): string;
  begin
    case Code of
      $6300: Result := 'No information is given';
      $6982: Result := 'Card key not supported';
      $6983: Result := 'Reader key not supported';
      $6984: Result := 'Plain transmission not supported';
      $6985: Result := 'Secured transmission not supported';
      $6986: Result := 'Volatile memory is not available';
      $6987: Result := 'Non volatile memory is not available';
      $6988: Result := 'Key number not valid';
      $6989: Result := 'Key length is not correct';
    else
      Result := 'Unknown error code';
    end;
  end;

var
  Code: Integer;
  Command: string;
  KeyStructure: Byte;
begin
  if SecuredTransmission then
  begin
    KeyStructure :=
      KEY_STRUCTURE_CARDKEY +
      KEY_STRUCTURE_NONVOLATILE_MEMORY +
      KEY_STRUCTURE_SECURED_TRANSMITTION +
      (EncryptionKeyNumber and $0F);
  end else
  begin
    KeyStructure :=
      KEY_STRUCTURE_CARDKEY +
      KEY_STRUCTURE_NONVOLATILE_MEMORY;
  end;

  Command := #$FF#$82 + Chr(KeyStructure) + Chr(KeyNumber) +
    Chr(Length(KeyData)) + KeyData;
  Code := SendCommand(Command);
  if IsCommandFailed(Code) then
    RaiseReaderError(Code, GetErrorText(Code));
end;

function TOmnikeyReader.ReadUID: string;

  function GetErrorText(Code: Integer): string;
  var
    Le: Integer;
  begin
    case Code of
      $6700: Result := 'Wrong length';
      $6800: Result := 'Class byte is not correct';
      $6281: Result := 'Part of returned data may be corrupted.';
      $6282: Result := 'End of file reached before reading expected number of bytes.';
      $6981: Result := 'Command incompatible.';
      $6982: Result := 'Security status not satisfied.';
      $6986: Result := 'Command not allowed.';
      $6A81: Result := 'Function not supported.';
      $6A82: Result := 'File not found / Addressed block or byte does not exist.';
      $6B00: Result := 'Wrong parameter P1-P2';
    else
      if Hi(Code) = $6C then
      begin
        Le := Lo(Code);
        Result := Format('Wrong length (Le=%d)', [Le]);
      end else
      begin
        Result := 'Unknown error code';
      end;
    end;
  end;

var
  Code: Integer;
  Answer: string;
  Command: string;
begin
  Command := #$FF#$CA#$00#$00#$00;
  SendCommand(Command, Answer);
  Code := GetAnswerCode(Answer);
  if IsCommandFailed(Code) then
    RaiseReaderError(Code, GetErrorText(Code));
  Result := Copy(Answer, 1, Length(Answer)-2);
end;

procedure TOmnikeyReader.Authenticate(
  BlockNumber, MifareAuthMode, KeyNumber: Integer);

  function GetErrorText(Code: Integer): string;
  begin
    case Code of
      $6300: Result := 'No information is given';
      $6581: Result := 'Memory failure, addressed by P1-P2 is does not exist';
      $6982: Result := 'Security status not satisfied';
      $6983: Result := 'Authentication cannot be done';
      $6984: Result := 'Reference key not useable';
      $6986: Result := 'Key type not known';
      $6988: Result := 'Key number not valid';
    else
      Result := 'Unknown error code';
    end;
  end;

var
  Code: Integer;
  Command: string;
begin
  Command := #$FF#$86#$00#$00#$05#$01 +
    Chr(Hi(BlockNumber)) +
    Chr(Lo(BlockNumber)) +
    Chr(MifareAuthMode) +
    Chr(KeyNumber);

  Code := SendCommand(Command);
  if IsCommandFailed(Code) then
    RaiseReaderError(Code, GetErrorText(Code));
end;

procedure TOmnikeyReader.AuthenticateKey(
  BlockNumber, AuthMode: Integer; const Data: string);
begin
  // 1 Write key to reader volatile memory

end;

function TOmnikeyReader.ReadBinary(BlockNumber: Integer): string;

  function GetErrorText(Code: Integer): string;
  var
    Le: Integer;
  begin
    case Code of
      $6700: Result := 'Wrong length';
      $6800: Result := 'Class byte is not correct';
      $6281: Result := 'Part of returned data may be corrupted.';
      $6282: Result := 'End of file reached before reading expected number of bytes.';
      $6981: Result := 'Command incompatible.';
      $6982: Result := 'Security status not satisfied.';
      $6986: Result := 'Command not allowed.';
      $6A81: Result := 'Function not supported.';
      $6A82: Result := 'File not found / Addressed block or byte does not exist.';
      $6B00: Result := 'Wrong parameter P1-P2';
    else
      if Hi(Code) = $6C then
      begin
        Le := Lo(Code);
        Result := Format('Wrong length (Le=%d)', [Le]);
      end else
      begin
        Result := 'Unknown error code';
      end;
    end;
  end;

var
  Code: Integer;
  Answer: string;
  Command: string;
begin
  Command := #$FF#$B0 + Chr(Hi(BlockNumber)) + Chr(Lo(BlockNumber)) + #$00;
  SendCommand(Command, Answer);
  Code := GetAnswerCode(Answer);
  if IsCommandFailed(Code) then
    RaiseReaderError(Code, GetErrorText(Code));
  Result := Copy(Answer, 1, Length(Answer)-2);
end;

procedure TOmnikeyReader.WriteBinary(BlockNumber: Integer;
  const BlockData: string);

  function GetErrorText(Code: Integer): string;
  begin
    case Code of
      $6700: Result := 'Wrong length';
      $6800: Result := 'Class byte is not correct';
      $6281: Result := 'Part of returned data may be corrupted.';
      $6282: Result := 'End of file reached before reading expected number of bytes.';
      $6581: Result := 'Memory failure, addressed by P1-P2 is does not exist';
      $6981: Result := 'Command incompatible.';
      $6982: Result := 'Security status not satisfied.';
      $6986: Result := 'Command not allowed.';
      $6A81: Result := 'Function not supported.';
      $6A82: Result := 'File not found / Addressed block or byte does not exist.';
    else
      Result := 'Unknown error code';
    end;
  end;

var
  Code: Integer;
  Answer: string;
  Command: string;
begin
  Command := #$FF#$D6 + Chr(Hi(BlockNumber)) + Chr(Lo(BlockNumber)) +
  Chr(Length(BlockData)) + BlockData;

  SendCommand(Command, Answer);
  Code := GetAnswerCode(Answer);
  if IsCommandFailed(Code) then
    RaiseReaderError(Code, GetErrorText(Code));
end;

function TOmnikeyReader.SCardGetAttribute(AttrId: DWORD): string;
var
  P: PByte;
  cByte: Longint;
begin
  Result := '';
  cByte := Longint(SCARD_AUTOALLOCATE);
  Check(SCardGetAttrib(GetCard, AttrId, P, cByte));
  if cByte > 0 then
  begin
    SetLength(Result, cByte);
    Move(P^, Result[1], cByte);
    Result := Result;
  end;
  SCardFreeMemory(Context, P);
end;

procedure TOmnikeyReader.GetStatus;
var
  Len: Longint;
  ATRLen: Longint;
  Protocol: Integer;
  ReaderBuf: PChar;
  ATRBuf: array[0..35] of Char;
begin
  if not Connected then
  begin
    Connect;
  end;

  Len := 0;
  ATRLen := Sizeof(ATRBuf);
  SCardStatusA(GetCard, nil, Len, FState, @Protocol, @ATRBuf, ATRLen);
  GetMem(ReaderBuf, Len);
  Check(SCardStatusA(GetCard, ReaderBuf, Len, FState, @Protocol,
    @ATRBuf, ATRLen));

  SetString(FATR, ATRBuf, ATRLen);
  FreeMem(ReaderBuf);

  FCardCode := ATRToCardCode(ATR);
  FCardName := GetCardName(FCardCode);
  FCardType := CardCodeToCardType(FCardCode);

  Logger.Debug('Status: ' + IntToStr(FState));
end;

function TOmnikeyReader.GetFirmwareVersion: string;
begin
  Result :=
    PChar(SCardGetAttribute(SCARD_ATTR_VENDOR_NAME)) + ' ' +
    PChar(SCardGetAttribute(SCARD_ATTR_VENDOR_IFD_TYPE));
end;

function TOmnikeyReader.SCardGetVendorName: string;
begin
  Result := SCardGetAttribute(SCARD_ATTR_VENDOR_NAME);
end;

procedure TOmnikeyReader.MifareDecrement(BlockNumber, Value: Integer);
var
  Data: string;
begin
  Data := IntToBin(Value, 4);
  Check(SCardCLMifareStdDecrementVal(GetCard, BlockNumber,
    PUChar(Data), Length(Data)));
end;

procedure TOmnikeyReader.MifareIncrement(BlockNumber, Value: Integer);
var
  Data: string;
begin
  Data := IntToBin(Value, 4);
  Check(SCardCLMifareStdIncrementVal(GetCard, BlockNumber,
    PUChar(Data), Length(Data)));
end;

procedure TOmnikeyReader.MifareTransfer(BlockNumber, TransBlockNumber, Value,
  Address: Integer);
var
  Data: string;
  RxDataLen: ULONG;
  RxData: array [0..100] of UChar;
begin
  Data := IntToBin(Value, 4);
  Check(SCardCLICCTransmit(GetCard, PUChar(Data), Length(Data),
    @RxData[0], @RxDataLen));
end;

procedure TOmnikeyReader.MifareRestore(BlockNumber, TransBlockNumber, Value,
  Address, AuthType, KeyNumber: Integer);
begin
  Check(SCardCLMifareStdRestoreVal(GetCard, BlockNumber, TransBlockNumber, True,
    AuthType, MIFARE_KEYNR_INPUT, KeyNumber, nil, 0));
end;

procedure TOmnikeyReader.DoSCardControl(Code: Integer);
var
  BytesReturned: LongInt;
  InBuffer: array [0..3] of Byte;
begin
  Move(Code, InBuffer, Sizeof(Code));
  Check(SCardControl(GetCard, CM_IOCTL_SIGNAL, @InBuffer[0], Sizeof(InBuffer),
    nil, 0, BytesReturned));
end;

procedure TOmnikeyReader.BeeperOn;
begin
  DoSCardControl(ACOUSTIC_SIGNAL_BEEPER_ON);
end;

procedure TOmnikeyReader.BeeperOff;
begin
  DoSCardControl(ACOUSTIC_SIGNAL_BEEPER_OFF);
end;

procedure TOmnikeyReader.SetPayPassMode;
var
  InBuffer: Byte;
  BytesReturned: LongInt;
begin
  InBuffer := OPERATION_MODE_RFID_PAYPASS;
  Check(SCardControl(GetCard, CM_IOCTL_SET_OPERATION_MODE, @InBuffer,
    Sizeof(InBuffer), nil, 0, BytesReturned));
end;

procedure TOmnikeyReader.ControlLED(RedLED, GreenLED,
  BlueLED, YellowLed: Boolean);
var
  BytesReturned: LongInt;
  InBuffer: array [0..3] of Byte;
begin
  InBuffer[0] := PAYPASS_SIGNAL_MAINLED;
  InBuffer[1] := 1; // USB Pipe Control
  if GreenLED then
  begin
    InBuffer[2] := 1; // bicolor green LED on
  end else
  begin
    InBuffer[2] := 0; // bicolor green LED on
  end;
  InBuffer[3] := 3; // application controlled
  Check(SCardControl(GetCard, CM_IOCTL_SIGNAL, @InBuffer[0], Sizeof(InBuffer),
    nil, 0, BytesReturned));
end;

end.
