unit OmnikeyReader5422;

interface

uses
  // VCL
  Windows, Classes, SysUtils, StrUtils,
  // 3'd
  DCPrijndael,
  // This
  SCardUtil,
  WinSCard, WinSmCrd, SCardErr, LogFile, untError, untUtil, MifareLib_TLB;

type
  MifareKeyType = Integer;

const
  /////////////////////////////////////////////////////////////////////////////
  // MifareKeyType constants

  MifareKeyA = $60;
  MifareKeyB = $61;

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
  TReaderSharingMode = (
    Exclusive,  // Exclusive mode only
    Shared,     // Shared mode only
    Direct);    // Raw mode only

    { TNamedFlag }

    TNamedFlag = record
      Text: string;
      Value: Integer;
    end;
    TNamedFlags = array of TNamedFlag;

const
  // Enabled features
  Felica = $0001;
  EMVCoCL = $0002;
  CalypsoSupport = $0004;
  NfcP2p = $0008;
  SioProcessor = $0010;
  Sdr = $0020;
  NativeFWSecureEngine = $0040;
  Cl = $0080;
  Iso14443a = $0100;
  Iso14443b = $0200;
  Iso15693 = $0400;
  PicoPass15693 = $0800;
  PicoPass14443b = $1000;
  PicoPass14443a = $2000;
  Rfu1 = $4000;
  Rfu2 = $8000;

  EnabledCLFeatures: array [0..15] of TNamedFlag = (
    (Text: 'Felica Support Available'; Value: $0001),
    (Text: 'EMVco Support Available'; Value: $0002),
    (Text: 'Calypso Support Available'; Value: $0004),
    (Text: 'NFC P2P Support Available'; Value: $0008),
    (Text: 'SIO Processor Available'; Value: $0010),
    (Text: 'SDR (LF Processor) Available'; Value: $0020),
    (Text: 'Native FW Secure Engine Available'; Value: $0040),
    (Text: 'T = CL Support Available'; Value: $0080),
    (Text: 'ISO 14443 Type A Support Available'; Value: $0100),
    (Text: 'ISO 14443 Type B Support Available'; Value: $0200),
    (Text: 'ISO 15693 Support Available'; Value: $0400),
    (Text: 'PicoPass 15693-2 Support Available'; Value: $0800),
    (Text: 'PicoPass 14443B-2 Support Available'; Value: $1000),
    (Text: 'Picopass 14443B-3 support available'; Value: $2000),
    (Text: 'Reserved For Future Use'; Value: $4000),
    (Text: 'Reserved For Future Use'; Value: $8000)
  );

  // HostInterfaceFlags
  HostInterfaceFlags: array [0..4] of TNamedFlag = (
    (Text: 'Ethernet Available'; Value: $01),
    (Text: 'USB Available'; Value: $02),
    (Text: 'Serial RS232 Available'; Value: $04),
    (Text: 'SPI Available'; Value: $08),
    (Text: 'I2C Available'; Value: $10)
  );

  // HumanInterfaceFlags
  HumanInterfaceFlags: array [0..5] of TNamedFlag = (
    (Text: 'KeyPad Available'; Value: $01),
    (Text: 'KeyWedge Available'; Value: $02),
    (Text: 'Display Available'; Value: $04),
    (Text: 'Buzzer Available'; Value: $08),
    (Text: 'Web Interface Available'; Value: $10),
    (Text: 'LED Available'; Value: $20)
    );

  // ExchangeLevelFlags
  ExchangeLevelFlags: array [0..2] of TNamedFlag = (
    (Text: 'TPDU Level Exchange with CCID'; Value: $01),
    (Text: 'Short APDU Level Exchange with CCID'; Value: $02),
    (Text: 'Extended APDU Level Exchange with CCID'; Value: $04)
    );

  /////////////////////////////////////////////////////////////////////////////
  // ConnectionMode constants

  ConnectionModeCard    = 0;
  ConnectionModeDirect  = 1;
  ConnectionModeNone    = -1;

  /////////////////////////////////////////////////////////////////////////////
  // OMNIKEY 5422 key slot and key size constants

  MifareKeyLastSlot             = 31;
  iClassNonvolatileKeyLastSlot  = 63;
  iClassDESKeySlot              = 64;
  iClassVolatileKeyLastSlot     = 66;
  iClass3DESKeySlot             = 67;
  SecureSessionLastKeySlot      = 73;

  MifareKeySize                 = 6;
  iClassNonvolatileKeySize      = 8;
  iClassDESKeySize              = 8;
  iClassVolatileKeySize         = 8;
  iClass3DESKeySize             = 16;
  SecureSessionKeySize          = 16;

  // Synchronus2WBP control byte
  cbReadMainMemory            = $30;
  cbUpdateMainMemory          = $38;
  cbReadProtectionMemory      = $34;
  cbWriteProtectionMemory     = $3C;
  cbReadSecurityMemory        = $31;
  cbUpdateSecurityMemory      = $39;
  cbCompareVerificationData   = $33;

  // Synchronus3WBP control byte
  cbWriteProtectBitWithDataComparison       = $30;
  cbWriteAndEraseWithProtectBit             = $31;
  cbWriteAndEraseWithoutProtectBit          = $33;
  cbRead9BitsDataWithProtectBit             = $0C;
  cbRead8BitsDataWithoutProtectBit          = $0E;
  cbReadErrorCounter                        = $CE;
  cbWriteErrorCounter                       = $F2;
  cbResetErrorCounter                       = $F3;
  cbVerifyPinByte                           = $CD;

type
  TOperatingModeFlags = (Iso7816, EMVCo);
  TVoltageFlag = (None, Low, Mid, High);
  TVoltageSequenceFlags = array [0..2] of TVoltageFlag;



  { TSmartCardReader }

  TOmnikeyReader5422 = class
  private
    FATR: string;
    FCard: Longint;
    FState: Longint;
    FProtocol: DWORD;
    FRxData: string;
    FTxData: string;
    FReaderName: string;
    FContext: SCARDCONTEXT;
    FCurrentState: DWORD;
    FCardName: string;
    FCardCode: Integer;
    FCardType: TCardType;
    FConnectionMode: Integer;
    FConnectionStatus: Integer;
    FOnStateChanged: TNotifyEvent;
  public
    procedure ConnectCard;
    procedure ConnectDirect;
    procedure SCardCheck(Code: DWORD);
    procedure SetCurrentState(Value: DWORD);
    function SCardGetAttribute(AttrId: DWORD): string;

    property Context: SCARDCONTEXT read FContext;
    property ConnectionStatus: Integer read FConnectionStatus;
  public
    function GetErrorText(Code: Integer): string;
    procedure CheckCode(Code: Integer);
    function IsSucceeded(Code: Integer): Boolean;
    procedure WaitDeviceUp;
    procedure ConnectTimeout(Mode, Timeout: Integer);
    procedure SetConnectionMode(const Value: Integer);
    function Control(const TxData: string; var RxData: string): Integer;
    function Transmit(const TxData: string; var RxData: string): Integer;
    function GetCard: Longint;
    procedure RaiseReaderError(Code: Integer; const Text: string);
    function IsFailed(Code: Integer): Boolean;
    function CardCommand2(const TxData: string): Integer;
    function GetAnswerCode(const Answer: string): Integer;
    function CardCommand(const TxData: string): Integer; overload;
    function CardCommand(const TxData: string; var RxData: string): Integer; overload;
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

    // Capabilities
    function ReadTlvVersion: Integer;
    function ReadDeviceId: string;
    function ReadProductName: string;
    function ReadProductPlatform: string;
    function ReadFirmwareVersion: string;
    function ReadHfControllerVersion: string;
    function ReadHardwareVersion: string;
    function ReadEnabledClFeatures: Integer;
    function ReadHostInterfaces: Integer;
    function ReadNumberOfContactlessSlots: Integer;
    function ReadNumberOfAntennas: Integer;
    function ReadHumanInterfaces: Integer;
    function ReadVendorName: string;
    function ReadExchangeLevel: Integer;
    function ReadSerialNumber: string;
    function ReadHfControllerType: string;
    function ReadSizeOfUserEEPROM: Integer;
    function ReadFirmwareLabel: string;
    function ReadStringAPDU(const APDU: string): string;
    function ReaderCommand(const TxData: string): string;
    // EEPROM
    function ReadEEPROM(Offset, Size: Integer): string;
    procedure WriteEEPROM(Offset: Integer; const Data: string);
    // Configuration
    procedure ApplySettings;
    procedure ResotoreFactoryDefaults;
    procedure RebootReader;
    // Contactless slot configuration
    function ReadIso14443TypeAEnable: Boolean;
    procedure WriteIso14443TypeAEnable(Enable: Boolean);
    function ReadMifareKeyCache: Boolean;
    procedure WriteMifareKeyCache(Value: Boolean);
    function ReadMifarePreferred: Boolean;
    procedure WriteMifarePreferred(Value: Boolean);
    function ReadIso14443TypeARxTxBaudRate: Integer;
    procedure WriteIso14443TypeARxTxBaudRate(Value: Integer);
    function ReadIso14443TypeBEnable: Boolean;
    procedure WriteIso14443TypeBEnable(Value: Boolean);
    function ReadIso14443TypeBRxTxBaudRate: Integer;
    procedure WriteIso14443TypeBRxTxBaudRate(Value: Integer);
    function ReadIso15693Enable: Boolean;
    procedure WriteIso15693Enable(Value: Boolean);
    // Contact slot configuration
    function ReadContactSlotEnable: Boolean;
    function ReadOperatingMode: TOperatingModeFlags;
    function ReadVoltageSequence: TVoltageSequenceFlags;
    procedure WriteContactSlotEnable(Value: Boolean);
    procedure WriteOperatingMode(Value: TOperatingModeFlags);
    procedure WriteVoltageSequence(Value: TVoltageSequenceFlags);
    procedure SetAutomaticSequenceVoltageSequence;
    // Mifare
    procedure LoadKey(keySlot: Byte; const Key: string);
    function MifareAuth(address: Byte; keyType: MifareKeyType; keySlot: Byte): Integer;
    procedure TerminateSecureSession;
    // Contact card
    procedure ResetErrorCounter;
    procedure WriteErrorCounter(bitMask: Byte);
    procedure VerifyFirstPinByte(firstPinByte: Byte);
    procedure VerifySecondPinByte(secondPinByte: Byte);
    function ReadErrorCounter: Integer;
    function Synchronus2WBP(control, address, data: Byte): string;
    function Synchronus3WBP(control, address, data: Integer): string;


    property ATR: string read FATR;
    property State: Longint read FState;
    property RxData: string read FRxData;
    property TxData: string read FTxData;
    property Protocol: DWORD read FProtocol;
    property CardName: string read FCardName;
    property CardCode: Integer read FCardCode;
    property CardType: TCardType read FCardType;
    property CurrentState: DWORD read FCurrentState;
    property ReaderName: string read FReaderName write FReaderName;
    property OnStateChanged: TNotifyEvent read FOnStateChanged write FOnStateChanged;
    property ConnectionMode: Integer read FConnectionMode write SetConnectionMode;
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
  BoolToInt: array[Boolean] of Integer = (0, 1);

const
  KEY_STRUCTURE_CARDKEY   = $00;
  KEY_STRUCTURE_READERKEY = $80;

  KEY_STRUCTURE_PLAIN_TRANSMITTION = 0;
  KEY_STRUCTURE_SECURED_TRANSMITTION = $40;

  KEY_STRUCTURE_VOLATILE_MEMORY = 0;
  KEY_STRUCTURE_NONVOLATILE_MEMORY = $20;


function CM_IOCTL_GET_FW_VERSION: DWORD;
begin
   Result := SCARD_CTL_CODE(3001);
end;

function CM_IOCTL_SIGNAL: DWORD;
begin
   Result := SCARD_CTL_CODE(3058);
end;

function CM_IOCTL_RFID_GENERIC: DWORD;
begin
   Result := SCARD_CTL_CODE(3105);
end;

function CM_IOCTL_SET_OPERATION_MODE: DWORD;
begin
   Result := SCARD_CTL_CODE(3107);
end;

function CM_IOCTL_GET_MAXIMUM_RFID_BAUDRATE: DWORD;
begin
   Result := SCARD_CTL_CODE(3208);
end;

function CM_IOCTL_SET_RFID_CONTROL_FLAGS: DWORD;
begin
   Result := SCARD_CTL_CODE(3213);
end;

function CM_IOCTL_GET_SET_RFID_BAUDRATE: DWORD;
begin
   Result := SCARD_CTL_CODE(3215);
end;

function CM_IOCTL_GET_FEATURE_REQUEST: DWORD;
begin
   Result := SCARD_CTL_CODE(3400);
end;

function IOCTL_CCID_ESCAPE: DWORD;
begin
   Result := SCARD_CTL_CODE(3500);
end;



function SCardGetReaderNames: string;
var
  Device: TOmnikeyReader5422;
begin
  Result := '';
  try
    Device := TOmnikeyReader5422.Create;
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

{ TOmnikeyReader5422 }

constructor TOmnikeyReader5422.Create;
begin
  inherited Create;
  ConnectionMode := ConnectionModeCard;
end;

destructor TOmnikeyReader5422.Destroy;
begin
  Disconnect;
  inherited Destroy;
end;

procedure TOmnikeyReader5422.SetConnectionMode(const Value: Integer);
begin
  if Value <> ConnectionMode then
    Disconnect;
  FConnectionMode := Value;
end;


// Error codes on key write command
function TOmnikeyReader5422.GetErrorText(Code: Integer): string;
begin
  case Code of
    $6281: Result := 'Part of returned data may be corrupted.';
    $6282: Result := 'End of file reached before reading expected number of bytes.';
    $6300: Result := 'No information is given';
    $6400: Result := 'No respone from media';
    $6581: Result := 'Memory failure, addressed by P1-P2 is does not exist';
    //$6581: Result := 'Illegal block number (out of memory space);
    $6700: Result := 'Wrong APDU length';

    $6800: Result := 'Class byte is not correct';
    $6981: Result := 'Command incompatible.';
    $6982: Result := 'Card key not supported';

    $6983: Result := 'Reader key not supported';
    $6984: Result := 'Reference key not useable';
    $6985: Result := 'Secured transmission not supported';
    $6986: Result := 'Volatile memory is not available';
    $6987: Result := 'Non volatile memory is not available';
    $6988: Result := 'Key number not valid';
    $6989: Result := 'Key length is not correct';
    $6990: Result := 'Security error';

    $6A81: Result := 'Function not supported.';
    $6A82: Result := 'File not found / Addressed block or byte does not exist.';
    $6B00: Result := 'Wrong parameter P1-P2';
    $6F00: Result := 'Operation failed';


  else
    if Hi(Code) = $6C then
    begin
      Result := Format('Wrong length (Le=%d)', [Lo(Code)]);
    end else
    begin
      Result := 'Unknown error code';
    end;
  end;
end;

function TOmnikeyReader5422.GetAnswerCode(const Answer: string): Integer;
var
  L: Integer;
begin
  L := Length(Answer);
  CheckAnswerLength(Answer, 2);
  Result := (Ord(Answer[L-1]) shl 8) + Ord(Answer[L]);
end;

procedure TOmnikeyReader5422.CheckAnswerLength(const Data: string; MinLength: Integer);
begin
  if Length(Data) < MinLength then
    RaiseReaderError(E_ANSWER_LENGTH, S_ANSWER_LENGTH);
end;

function TOmnikeyReader5422.IsFailed(Code: Integer): Boolean;
begin
  Result := Code <> $9000;
end;

function TOmnikeyReader5422.IsSucceeded(Code: Integer): Boolean;
begin
  Result := Code = $9000;
end;

procedure TOmnikeyReader5422.RaiseReaderError(Code: Integer; const Text: string);
begin
  raise Exception.CreateFmt('Error: 0x%.4X, %s', [Code, Text]);
end;

procedure TOmnikeyReader5422.SCardCheck(Code: DWORD);
begin
  if Code <> SCARD_S_SUCCESS then
  begin
    if Code = SCARD_W_REMOVED_CARD then
    begin
      Disconnect;
    end;

    Logger.Debug(SCardGetErrorMessage(Code));
    if Code = SCARD_W_REMOVED_CARD then
    begin
      RaiseError(E_REMOVED_CARD, 'Ошибок нет, карта отсутствует');
    end else
    begin
      RaiseReaderError(Code, SCardGetErrorMessage(Code));
    end;
  end;
end;

function TOmnikeyReader5422.GetCard: Longint;
begin
  if FCard = 0 then
    Connect;
  Result := FCard;
end;

function TOmnikeyReader5422.ListReaders: string;
var
  Text: string;
  BufSize: Longint;
begin
  Result := '';
  SCardCheck(SCardListReadersA(Context, nil, nil, BufSize));
  if BufSize > 0 then
  begin
    SetLength(Text, BufSize);
    SCardCheck(SCardListReadersA(Context, nil, @Text[1], BufSize));
    Result := Replace0(Trim(Text));
  end;
end;

function TOmnikeyReader5422.ListCards: string;
var
  Text: string;
  BufSize: Longint;
begin
  Result := '';
  SCardCheck(SCardListCardsA(Context, nil, nil, 0, nil, BufSize));
  if BufSize > 0 then
  begin
    SetLength(Text, BufSize);
    SCardCheck(SCardListCardsA(Context, nil, nil, 0, @Text[1], BufSize));
    Result := Replace0(Trim(Text));
  end;
end;

function TOmnikeyReader5422.ListReaderGroups: string;
var
  Text: string;
  BufSize: Longint;
begin
  Result := '';
  SCardCheck(SCardListReaderGroupsA(Context, nil, BufSize));
  if BufSize > 0 then
  begin
    SetLength(Text, BufSize);
    SCardCheck(SCardListReaderGroupsA(Context, @Text[1], BufSize));
    Result := Replace0(Trim(Text));
  end;
end;

function TOmnikeyReader5422.WaitForCard(
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
      SCardCheck(ResultCode);
    end;
  until (Integer(GetTickCount) - TickCount) > Timeout;
  Result := False;
end;

function TOmnikeyReader5422.WaitForCardRemoved(Timeout: Integer): Boolean;
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
      SCardCheck(ResultCode);
    end;
  until (Integer(GetTickCount) - TickCount) > Timeout;
  Result := False;
end;

function TOmnikeyReader5422.Connected: Boolean;
begin
  Result := FCard <> 0;
end;

function TOmnikeyReader5422.Disconnect: Integer;
begin
  Result := SCARD_S_SUCCESS;
  if Connected then
  begin
    Result := SCardDisconnect(FCard, SCARD_UNPOWER_CARD);
    SCardReleaseContext(FContext);
    FCard := 0;
    FContext := 0;
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

function TOmnikeyReader5422.GetStateText(State: DWORD): string;
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

procedure TOmnikeyReader5422.SetCurrentState(Value: DWORD);
begin
  if Value <> FCurrentState then
  begin
    FCurrentState := Value;
    if Assigned(FOnStateChanged) then
      FOnStateChanged(Self);
  end;
end;

function TOmnikeyReader5422.GetStatusChange(Timeout: Integer): Integer;
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

procedure TOmnikeyReader5422.Connect;
begin
  ConnectTimeout(ConnectionMode, 0);
end;

procedure TOmnikeyReader5422.ConnectTimeout(Mode, Timeout: Integer);
var
  rc: DWORD;
  TickCount: Integer;
begin
  Disconnect;

  TickCount := GetTickCount;
  SCardCheck(SCardEstablishContext(SCARD_SCOPE_USER, nil, nil, @FContext));
  while True do
  begin
    if Mode = ConnectionModeDirect then
    begin
      rc := SCardConnectA(Context, PChar(ReaderName),
        SCARD_SHARE_DIRECT, SCARD_PROTOCOL_UNDEFINED,
        FCard, @FProtocol);
    end else
    begin
      rc := SCardConnectA(Context, PChar(ReaderName),
        SCARD_SHARE_EXCLUSIVE, SCARD_PROTOCOL_T0 + SCARD_PROTOCOL_T1,
        FCard, @FProtocol);
    end;
    if (Timeout = 0)or((rc <> ERROR_GEN_FAILURE)and(rc <> SCARD_E_UNKNOWN_READER)) then
    begin
      SCardCheck(rc);
      FConnectionStatus := ConnectionMode;
      Break;
    end;
    Sleep(100);
    if Integer(GetTickCount) > (TickCount + Timeout) then
      raise Exception.Create('Device connection timeout');
  end;
end;

procedure TOmnikeyReader5422.ConnectCard;
begin
  if Connected and (ConnectionStatus <> ConnectionModeCard) then
  begin
    Disconnect;
  end;
  ConnectTimeout(ConnectionModeCard, 0);
end;

procedure TOmnikeyReader5422.ConnectDirect;
begin
  if not Connected then
  begin
    ConnectTimeout(ConnectionModeDirect, 0);
  end;
end;

function TOmnikeyReader5422.CardCommand2(const TxData: string): Integer;
var
  RxData: string;
begin
  CardCommand(TxData, RxData);
  CheckAnswerLength(RxData, 2);
  Result := (Ord(RxData[1]) shl 8) + Ord(RxData[2]);
end;

function TOmnikeyReader5422.Control(const TxData: string; var RxData: string): Integer;
var
  RecvBuffer: string;
  RecvLength: LongInt;
begin
  FTxData := TxData;
  RecvLength := $FF;
  SetLength(RecvBuffer, RecvLength);
  SCardCheck(SCardControl(GetCard, IOCTL_CCID_ESCAPE, @TxData[1], Length(TxData),
    @RecvBuffer[1], RecvLength, RecvLength));

  SetLength(RecvBuffer, RecvLength);
  RxData := RecvBuffer;
  FRxData := RxData;
  Result := GetAnswerCode(RxData);
end;

function TOmnikeyReader5422.Transmit(const TxData: string; var RxData: string): Integer;
var
  RecvBuffer: string;
  RecvLength: Integer;
  pioSendPci: SCARD_IO_REQUEST;
  pioRecvPci: SCARD_IO_REQUEST;
begin
  FTxData := TxData;
  pioRecvPci.dwProtocol := SCARD_PROTOCOL_T1;
  pioRecvPci.dbPciLength := 8;
  pioSendPci.dwProtocol := SCARD_PROTOCOL_T1;
  pioSendPci.dbPciLength := 8;

  RecvLength := $FF;
  SetLength(RecvBuffer, RecvLength);
  SCardCheck(SCardTransmit(GetCard, @pioSendPci, @TxData[1], Length(TxData),
    @pioRecvPci, @RecvBuffer[1], @RecvLength));
  SetLength(RecvBuffer, RecvLength);
  RxData := RecvBuffer;
  FRxData := RxData;
  Result := GetAnswerCode(RxData);
end;

function TOmnikeyReader5422.CardCommand(const TxData: string; var RxData: string): Integer;
begin
  if ConnectionMode = ConnectionModeDirect then
  begin
    Result := Control(TxData, RxData);
  end else
  begin
    Result := Transmit(TxData, RxData);
  end;
end;

function TOmnikeyReader5422.CardCommand(const TxData: string): Integer;
var
  RxData: string;
begin
  Result := CardCommand(TxData, RxData);
end;


procedure TOmnikeyReader5422.WriteKeyToReader(
  KeyNumber: Integer;
  const KeyData: string;
  SecuredTransmission: Boolean;
  EncryptionKeyNumber: Integer);
var
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
  CheckCode(CardCommand2(Command));
end;

procedure TOmnikeyReader5422.CheckCode(Code: Integer);
begin
  if IsFailed(Code) then
    RaiseReaderError(Code, GetErrorText(Code));
end;

function TOmnikeyReader5422.ReadUID: string;
var
  Answer: string;
  Command: string;
begin
  Command := #$FF#$CA#$00#$00#$00;
  CheckCode(CardCommand(Command, Answer));
  Result := Copy(Answer, 1, Length(Answer)-2);
end;

procedure TOmnikeyReader5422.Authenticate(
  BlockNumber, MifareAuthMode, KeyNumber: Integer);
var
  Command: string;
begin
  Command := #$FF#$86#$00#$00#$05#$01 +
    Chr(Hi(BlockNumber)) +
    Chr(Lo(BlockNumber)) +
    Chr(MifareAuthMode) +
    Chr(KeyNumber);

   CheckCode(CardCommand2(Command));
end;


procedure TOmnikeyReader5422.AuthenticateKey(
  BlockNumber, AuthMode: Integer; const Data: string);
begin
  // 1 Write key to reader volatile memory
end;

function TOmnikeyReader5422.ReadBinary(BlockNumber: Integer): string;
var
  Answer: string;
  Command: string;
begin
  Command := #$FF#$B0 + Chr(Hi(BlockNumber)) + Chr(Lo(BlockNumber)) + #$00;
  CardCommand(Command, Answer);
  CheckCode(GetAnswerCode(Answer));
  Result := Copy(Answer, 1, Length(Answer)-2);
end;

procedure TOmnikeyReader5422.WriteBinary(BlockNumber: Integer;
  const BlockData: string);
var
  Answer: string;
  Command: string;
begin
  Command := #$FF#$D6 + Chr(Hi(BlockNumber)) + Chr(Lo(BlockNumber)) +
  Chr(Length(BlockData)) + BlockData;

  CardCommand(Command, Answer);
  CheckCode(GetAnswerCode(Answer));
end;

function TOmnikeyReader5422.SCardGetAttribute(AttrId: DWORD): string;
var
  P: PByte;
  cByte: Longint;
begin
  Result := '';
  cByte := Longint(SCARD_AUTOALLOCATE);
  SCardCheck(SCardGetAttrib(GetCard, AttrId, P, cByte));
  if cByte > 0 then
  begin
    SetLength(Result, cByte);
    Move(P^, Result[1], cByte);
    Result := Result;
  end;
  SCardFreeMemory(Context, P);
end;

procedure TOmnikeyReader5422.GetStatus;
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
  SCardCheck(SCardStatusA(GetCard, ReaderBuf, Len, FState, @Protocol,
    @ATRBuf, ATRLen));

  SetString(FATR, ATRBuf, ATRLen);
  FreeMem(ReaderBuf);

  FCardCode := ATRToCardCode(ATR);
  FCardName := GetCardName(FCardCode);
  FCardType := CardCodeToCardType(FCardCode);

  Logger.Debug('Status: ' + IntToStr(FState));
end;

function TOmnikeyReader5422.GetFirmwareVersion: string;
begin
  Result := Format('%s %s, FW: %s, HW: %s',[SCardGetVendorName,
    ReadProductName, ReadFirmwareVersion, ReadHardwareVersion]);
end;

function TOmnikeyReader5422.SCardGetVendorName: string;
begin
  Result := SCardGetAttribute(SCARD_ATTR_VENDOR_NAME);
end;

procedure TOmnikeyReader5422.MifareTransfer(BlockNumber, TransBlockNumber, Value,
  Address: Integer);
begin
  raise Exception.Create('Not supported');
end;

procedure TOmnikeyReader5422.MifareRestore(BlockNumber, TransBlockNumber, Value,
  Address, AuthType, KeyNumber: Integer);
begin
  raise Exception.Create('Not supported');
end;

procedure TOmnikeyReader5422.DoSCardControl(Code: Integer);
var
  BytesReturned: LongInt;
  InBuffer: array [0..3] of Byte;
begin
  Move(Code, InBuffer, Sizeof(Code));
  SCardCheck(SCardControl(GetCard, CM_IOCTL_SIGNAL, @InBuffer[0], Sizeof(InBuffer),
    nil, 0, BytesReturned));
end;

procedure TOmnikeyReader5422.BeeperOn;
begin
  DoSCardControl(ACOUSTIC_SIGNAL_BEEPER_ON);
end;

procedure TOmnikeyReader5422.BeeperOff;
begin
  DoSCardControl(ACOUSTIC_SIGNAL_BEEPER_OFF);
end;

procedure TOmnikeyReader5422.SetPayPassMode;
var
  InBuffer: Byte;
  BytesReturned: LongInt;
begin
  InBuffer := OPERATION_MODE_RFID_PAYPASS;
  SCardCheck(SCardControl(GetCard, CM_IOCTL_SET_OPERATION_MODE, @InBuffer,
    Sizeof(InBuffer), nil, 0, BytesReturned));
end;

procedure TOmnikeyReader5422.ControlLED(RedLED, GreenLED,
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
  SCardCheck(SCardControl(GetCard, CM_IOCTL_SIGNAL, @InBuffer[0], Sizeof(InBuffer),
    nil, 0, BytesReturned));
end;

function TOmnikeyReader5422.ReaderCommand(const TxData: string): string;
var
  RxData: string;
begin
  ConnectDirect;
  CheckCode(Control(HexToStr(TxData), RxData));
  Result := StrToHex(RxData);
end;

function TOmnikeyReader5422.ReadTlvVersion: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A002800000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD038001')and (RightStr(S, 4) = '9000') then
    Result := HexToInt(Copy(S, 9, 2));
end;

function TOmnikeyReader5422.ReadDeviceId: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A002810000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD048102')and (RightStr(S, 4) = '9000') then
    Result := Copy(S, 9, 4);
end;

function TOmnikeyReader5422.ReadProductName: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A002820000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 2) = 'BD')and (RightStr(S, 4) = '9000') then
  begin
    S := HexToStr(S);
    Result := Copy(S, 5, Ord(S[4])-1);
  end;
end;

function TOmnikeyReader5422.ReadProductPlatform: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A002830000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 2) = 'BD')and (RightStr(S, 4) = '9000') then
    Result := HexToStr(Copy(S, 9, Length(S)-14));
end;

function TOmnikeyReader5422.ReadFirmwareVersion: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A002850000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD058503')and (RightStr(S, 4) = '9000') then
  begin
    Result := Format('%d.%d.%d', [HexToInt(Copy(S, 9, 2)),
      HexToInt(Copy(S, 11, 2)), HexToInt(Copy(S, 13, 2))]);
  end;
end;

function TOmnikeyReader5422.ReadHfControllerVersion: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A002880000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD038801')and (RightStr(S, 4) = '9000') then
  begin
    Result := IntToStr(HexToInt(Copy(S, 9, 2)));
  end;
end;

function TOmnikeyReader5422.ReadHardwareVersion: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A002890000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 2) = 'BD')and (RightStr(S, 4) = '9000') then
  begin
    S := HexToStr(S);
    Result := Copy(S, 5, Ord(S[4])-1);
  end;
end;

function TOmnikeyReader5422.ReadEnabledClFeatures: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A002840000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD048402')and (RightStr(S, 4) = '9000') then
  begin
    Result := HexToInt(Copy(S, 9, 4));
  end;
end;

function TOmnikeyReader5422.ReadHostInterfaces: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A0028A0000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD038A01')and (RightStr(S, 4) = '9000') then
  begin
    Result := HexToInt(Copy(S, 9, 2));
  end;
end;

function TOmnikeyReader5422.ReadNumberOfContactlessSlots: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A0028C0000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD038C01')and (RightStr(S, 4) = '9000') then
  begin
    Result := HexToInt(Copy(S, 9, 2));
  end;
end;

function TOmnikeyReader5422.ReadNumberOfAntennas: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A0028D0000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD038D01')and (RightStr(S, 4) = '9000') then
  begin
    Result := HexToInt(Copy(S, 9, 2));
  end;
end;

function TOmnikeyReader5422.ReadHumanInterfaces: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A0028E0000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 12) = 'BD058E038001')and (RightStr(S, 4) = '9000') then
  begin
    Result := HexToInt(Copy(S, 13, 2));
  end;
end;

function TOmnikeyReader5422.ReadVendorName: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A0028F0000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 2) = 'BD')and (RightStr(S, 4) = '9000') then
  begin
    S := HexToStr(S);
    Result := Copy(S, 5, Ord(S[4])-1);
  end;
end;

function TOmnikeyReader5422.ReadExchangeLevel: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A002910000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD039101')and (RightStr(S, 4) = '9000') then
  begin
    Result := HexToInt(Copy(S, 9, 2));
  end;
end;

function TOmnikeyReader5422.ReadSerialNumber: string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand('FF70076B08A206A004A002920000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 2) = 'BD')and (RightStr(S, 4) = '9000') then
  begin
    S := HexToStr(S);
    Result := Copy(S, 5, Ord(S[4])-1);
  end;
end;

function TOmnikeyReader5422.ReadStringAPDU(const APDU: string): string;
var
  S: string;
begin
  Result := '';
  S := ReaderCommand(APDU);
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 2) = 'BD')and (RightStr(S, 4) = '9000') then
  begin
    S := HexToStr(S);
    Result := Copy(S, 5, Ord(S[4])-1);
  end;
end;

function TOmnikeyReader5422.ReadHfControllerType: string;
begin
  Result := ReadStringAPDU('FF70076B08A206A004A002930000');
end;

function TOmnikeyReader5422.ReadSizeOfUserEEPROM: Integer;
var
  S: string;
begin
  Result := 0;
  S := ReaderCommand('FF70076B08A206A004A002940000');
  S := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  if (LeftStr(S, 8) = 'BD049402')and (RightStr(S, 4) = '9000') then
  begin
    Result := HexToInt(Copy(S, 9, 4));
  end;
end;

function TOmnikeyReader5422.ReadFirmwareLabel: string;
begin
  Result := ReadStringAPDU('FF70076B08A206A004A002960000');
end;

const
  Minoffset = $0000;
  Maxoffset = $03FF;

function TOmnikeyReader5422.ReadEEPROM(Offset, Size: Integer): string;
var
  Command: string;
  Answer: string;
begin
  if (Offset > Maxoffset) then
    raise Exception.CreateFmt('Offset > MaxOffset, 0x%.8X > %.8X', [
      Offset, Maxoffset]);

  if ((Offset + Size) > Maxoffset) then
    raise Exception.Create('Attempt to read data out of user eeprom space');

  Command := Format('FF70076B0DA20BA009A7078102%.4X8201%.2X00', [Offset, Size]);
  Answer := HexToStr(ReaderCommand(Command));
  Result := Copy(Answer, Length(Answer)-Size-1, Size);
end;

///////////////////////////////////////////////////////////////////////////////
// 9D009000 - OK
// 6700 - Invalid command

procedure TOmnikeyReader5422.WriteEEPROM(Offset: Integer; const Data: string);
var
  Command: string;
  dataLength: Integer;
begin
  if (Offset > Maxoffset) then
    raise Exception.CreateFmt('Offset > MaxOffset, 0x%.8X > %.8X', [
      Offset, Maxoffset]);

  if (Offset + Length(Data)) > Maxoffset then
    raise Exception.Create('Attempt to write data out of user eeprom space');

  if ((Length(Data) + 16) > 256) then
    raise Exception.Create('EEPROM write apdu cannot have more then 255 bytes');

  Command := 'FF70076B';
  // Select data field length encoding
  dataLength := Length(data);
  if (dataLength + 12) < 128 then
  begin
    Command := Command + Format('%.2XA2%.2XA1%.2XA7%.2X8102%.4X83%.2X%s00',
      [dataLength+12, dataLength+10, dataLength+8, dataLength+6, Offset,
       dataLength, StrToHex(Data)]);
  end else
  begin
    if (dataLength + 16) < 256 then
    begin
      Command := Command + Format('%.2XA281%.2XA181%.2XA781%.2X8102%.4X8381%.2X%s00',
        [dataLength+16, dataLength+13, dataLength+10, dataLength+7, Offset,
         dataLength, StrToHex(Data)]);
    end;
  end;
  ReaderCommand(Command);
end;

procedure TOmnikeyReader5422.RebootReader;
begin
  ReaderCommand('FF70076B08A206A104A902830000');
  WaitDeviceUp;
end;

procedure TOmnikeyReader5422.ApplySettings;
begin
  ReaderCommand('FF70076B08A206A104A902800000');
  WaitDeviceUp;
end;

procedure TOmnikeyReader5422.ResotoreFactoryDefaults;
begin
  ReaderCommand('FF70076B08A206A104A902810000');
  WaitDeviceUp;
end;

procedure TOmnikeyReader5422.WaitDeviceUp;
begin
  Sleep(300);
  ConnectTimeout(ConnectionModeDirect, 3000);
end;

procedure TOmnikeyReader5422.LoadKey(keySlot: Byte; const Key: string);
var
  Command: string;
  keyLength: Byte;
  isCardKey: Boolean;
  keyStructure: Byte;
  isStoredInVolatileMemory: Boolean;
begin
  keyStructure := 0;
  if (keySlot <= MifareKeyLastSlot) then
  begin
    keyLength := MifareKeySize;
    isCardKey := True;
    isStoredInVolatileMemory := False;
   end else
   begin
     if (keySlot <= iClassNonvolatileKeyLastSlot) then
     begin
       keyLength := iClassNonvolatileKeySize;
       isCardKey := true;
       isStoredInVolatileMemory := false;
     end else
     begin
       if (keySlot <= iClassDESKeySlot) then
       begin
         keyLength := iClassDESKeySize;
         isCardKey := false;
         isStoredInVolatileMemory := false;
       end else
       begin
         if (keySlot <= iClassVolatileKeyLastSlot) then
         begin
           keyLength := iClassVolatileKeySize;
           isCardKey := true;
           isStoredInVolatileMemory := true;
         end else
         begin
            if (keySlot <= iClass3DESKeySlot) then
            begin
              keyLength := iClass3DESKeySize;
              isCardKey := false;
              isStoredInVolatileMemory := false;
            end else
            begin
              if (keySlot <= SecureSessionLastKeySlot) then
              begin
                keyLength := SecureSessionKeySize;
                isCardKey := false;
                isStoredInVolatileMemory := false;
              end else
                raise Exception.CreateFmt('KeySlot parameter, %d > maximum, %d',
                  [KeySlot, SecureSessionLastKeySlot]);
            end;
         end;
       end;
     end;
  end;

  if not isCardKey then
      keyStructure := keyStructure or $80;

  if not isStoredInVolatileMemory then
      keyStructure := keyStructure or $20;

  if Length(key) <> keyLength then
    raise Exception.CreateFmt('Invalid key length (%d <> %d)', [
      Length(key), keyLength]);

  Command := Format('FF82%.2X%.2X%.2X%s', [keyStructure, keySlot, keyLength,
    StrToHex(key)]);
  ReaderCommand(Command);
end;

procedure TOmnikeyReader5422.MifareIncrement(BlockNumber, Value: Integer);
var
  Data: string;
  Command: string;
begin
  Data := IntToBin(Value, 4);
  Command := Format('FFD400%.2X04%s', [BlockNumber, StrToHex(data)]);
  CheckCode(CardCommand(HexToStr(Command)));
end;

procedure TOmnikeyReader5422.MifareDecrement(BlockNumber, Value: Integer);
var
  Data: string;
  Command: string;
begin
  Data := IntToBin(Value, 4);
  Command := Format('FFD800%.2X04%s', [BlockNumber, StrToHex(Data)]);
  CheckCode(CardCommand(HexToStr(Command)));
end;


function TOmnikeyReader5422.MifareAuth(address: Byte; keyType: MifareKeyType;
  keySlot: Byte): Integer;
var
  Command: string;
begin
  Command := Format('FF860000050100%.2X%.2X%.2X', [address, keyType, keySlot]);
  Result := CardCommand(HexToStr(Command));
end;

// ISO 14443 Type A
function TOmnikeyReader5422.ReadIso14443TypeAEnable: Boolean;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A404A202800000'));
  Result := Ord(Answer[5]) <> 0;
end;

procedure TOmnikeyReader5422.WriteIso14443TypeAEnable(Enable: Boolean);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A405A2038001%.2X00', [BoolToInt[Enable]]);
  ReaderCommand(Command);
end;


function TOmnikeyReader5422.ReadMifareKeyCache: Boolean;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A404A202830000'));
  Result := Ord(Answer[5]) <> 0;
end;

procedure TOmnikeyReader5422.WriteMifareKeyCache(Value: Boolean);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A405A2038301%.2X00', [BoolToInt[Value]]);
  ReaderCommand(Command);
end;

function TOmnikeyReader5422.ReadMifarePreferred: Boolean;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A404A202840000'));
  Result := Ord(Answer[5]) <> 0;
end;

procedure TOmnikeyReader5422.WriteMifarePreferred(Value: Boolean);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A405A2038401%.2X00', [BoolToInt[Value]]);
  ReaderCommand(Command);
end;

function TOmnikeyReader5422.ReadIso14443TypeARxTxBaudRate: Integer;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A404A202810000'));
  Result := Ord(Answer[5]);
end;

procedure TOmnikeyReader5422.WriteIso14443TypeARxTxBaudRate(Value: Integer);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A405A2038101%.2X00', [Value]);
  ReaderCommand(Command);
end;

function TOmnikeyReader5422.ReadIso14443TypeBEnable: Boolean;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A404A302800000'));
  Result := Ord(Answer[5]) <> 0;
end;

procedure TOmnikeyReader5422.WriteIso14443TypeBEnable(Value: Boolean);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A405A3038001%.2X00', [BoolToInt[Value]]);
  ReaderCommand(Command);
end;

function TOmnikeyReader5422.ReadIso14443TypeBRxTxBaudRate: Integer;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A404A302810000'));
  Result := Ord(Answer[5]);
end;

procedure TOmnikeyReader5422.WriteIso14443TypeBRxTxBaudRate(Value: Integer);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A405A3038101%.2X00', [Value]);
  ReaderCommand(Command);
end;

// 9E02 00 03 9000
function TOmnikeyReader5422.ReadIso15693Enable: Boolean;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A404A402800000'));
  Result := Ord(Answer[5]) <> 0;
end;

procedure TOmnikeyReader5422.WriteIso15693Enable(Value: Boolean);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A405A4038001%.2X00', [BoolToInt[Value]]);
  ReaderCommand(Command);
end;

// Terminates established secure channel
procedure TOmnikeyReader5422.TerminateSecureSession;
begin
  ReaderCommand('FF70076B08A206A004A002800000');
end;

function TOmnikeyReader5422.ReadContactSlotEnable: Boolean;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A304A002850000'));
  Result := Ord(Answer[5]) <> 0;
end;

procedure TOmnikeyReader5422.WriteContactSlotEnable(Value: Boolean);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A305A0038501%.2X00', [BoolToInt[Value]]);
  ReaderCommand(Command);
end;

function TOmnikeyReader5422.ReadOperatingMode: TOperatingModeFlags;
var
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A304A002830000'));
  Result := TOperatingModeFlags(Answer[5]);
end;

procedure TOmnikeyReader5422.WriteOperatingMode(Value: TOperatingModeFlags);
var
  Command: string;
begin
  Command := Format('FF70076B0BA209A107A305A0038301%.2X00', [Ord(Value)]);
  ReaderCommand(Command);
end;

function TOmnikeyReader5422.ReadVoltageSequence: TVoltageSequenceFlags;
var
  V: Byte;
  Answer: string;
begin
  Answer := HexToStr(ReaderCommand('FF70076B0AA208A006A304A002820000'));
  V := Ord(Answer[5]);
  Result[0] := TVoltageFlag(V and 3);
  Result[1] := TVoltageFlag((V shr 2) and 3);
  Result[2] := TVoltageFlag((V shr 4) and 3);
end;

procedure TOmnikeyReader5422.WriteVoltageSequence(Value: TVoltageSequenceFlags);
var
  V: Byte;
  Answer: string;
  Command: string;
begin
  V := Ord(Value[0]) + (Ord(Value[1]) shl 2) + (Ord(Value[2]) shl 4);
  Command := Format('FF70076B0BA209A107A305A0038201%.2X00', [Ord(V)]);
  Answer := ReaderCommand(Command);
end;

procedure TOmnikeyReader5422.SetAutomaticSequenceVoltageSequence;
begin
  ReaderCommand('FF70076B0BA209A107A305A00382010000');
end;

function TOmnikeyReader5422.Synchronus2WBP(control, address, data: Byte): string;
var
  Command: string;
begin
  Command := Format('FF70076B07A605A003%.2X%.2X%.2X00', [control, address, data]);
  Result := ReaderCommand(Command);
end;

function TOmnikeyReader5422.Synchronus3WBP(control, address, data: Integer): string;
var
  Command: string;
  fullControlByte: Byte;
begin
  fullControlByte := control;
  case control of
    cbWriteAndEraseWithProtectBit,
    cbWriteAndEraseWithoutProtectBit,
    cbWriteProtectBitWithDataComparison,
    cbRead9BitsDataWithProtectBit,
    cbRead8BitsDataWithoutProtectBit:
      fullControlByte := fullControlByte or Byte(((1 shl 9 or 1 shl 8) and address) shr 2);

    cbReadErrorCounter:
    begin
      address := $FD;
      data := $00;
    end;

    cbVerifyPinByte:
      if not ((address = $03FE)or(address = $03FF)) then
      begin
        Result := '';
        Exit;
      end;
    end;
    Command := Format('FF70076B07A605A103%.2X%.2X%.2X00', [
      fullControlByte, address, data]);
  Result := ReaderCommand(Command);
end;

procedure TOmnikeyReader5422.WriteErrorCounter(bitMask: Byte);
begin
  Synchronus3WBP(cbWriteErrorCounter, $FD, bitMask);
end;

procedure TOmnikeyReader5422.ResetErrorCounter;
begin
  Synchronus3WBP(cbResetErrorCounter, $FD, $FF);
end;

// 9E0200019000

function TOmnikeyReader5422.ReadErrorCounter: Integer;
var
  Answer: string;
begin
  Answer := Synchronus3WBP(cbReadErrorCounter, $FD, $00);
  Result := Ord(HexToStr(Answer)[3]);
end;


procedure TOmnikeyReader5422.VerifyFirstPinByte(firstPinByte: Byte);
begin
  Synchronus3WBP(cbVerifyPinByte, $03FE, firstPinByte);
end;

procedure TOmnikeyReader5422.VerifySecondPinByte(secondPinByte: Byte);
begin
  Synchronus3WBP(cbVerifyPinByte, $03FF, secondPinByte);
end;

function AesEncrypt(key, iv, data: string): string;
var
  cipher: TDCP_rijndael;
begin
  SetLength(Result, Length(data));
  cipher := TDCP_rijndael.Create(nil);
  try
    cipher.Init(key[1], Length(key), @iv[1]);
    cipher.EncryptECB(data[1], Result[1]);
  finally
    cipher.Free;
  end;
end;

(*

    public class SynchronusI2C
    {
        public enum MemorySize
        {
            _256    = 0x000100,
            _512    = 0x000200,
            _1024   = 0x000400,
            _2048   = 0x000800,
            _4096   = 0x001000,
            _8192   = 0x002000,
            _16384  = 0x004000,
            _32768  = 0x008000,
            _65536  = 0x010000,
            _131072 = 0x020000,
        };
        public string GetReadCommandApdu(MemorySize cardMemorySize, int address, byte numberOfBytesToRead)
        {
            if ((int) cardMemorySize <= address)
                throw new ArgumentOutOfRangeException(nameof(address), address, $"Address out of card memory address range, selected card memory size: {(int) cardMemorySize} bytes");

            var i2CCommand = string.Empty;
            byte numberOfAddressBytes;
            const byte readFlag = 0x01;
            byte deviceAddress;
            byte subAddress1;
            byte subAddress2;

            switch (cardMemorySize)
            {
                case MemorySize._256:
                    numberOfAddressBytes = 2;
                    deviceAddress = (byte) (0xA0 | readFlag);
                    subAddress1 = (byte) (address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._512:
                    numberOfAddressBytes = 2;
                    deviceAddress = (byte) (0xA0 | readFlag | ((address & 0x000100) >> 7));
                    subAddress1 = (byte) (address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._1024:
                    numberOfAddressBytes = 2;
                    deviceAddress = (byte) (0xA0 | readFlag | ((address & 0x000300) >> 7));
                    subAddress1 = (byte) (address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._2048:
                    numberOfAddressBytes = 2;
                    deviceAddress = (byte) (0xA0 | readFlag | ((address & 0x000700) >> 7));
                    subAddress1 = (byte) (address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._4096:
                case MemorySize._8192:
                case MemorySize._16384:
                case MemorySize._32768:
                case MemorySize._65536:
                    numberOfAddressBytes = 3;
                    deviceAddress = (byte) (0xA0 | readFlag);
                    subAddress1 = (byte) ((address & 0xFF00) >> 8);
                    subAddress2 = (byte) (address & 0x00FF);
                    break;
                case MemorySize._131072:
                    numberOfAddressBytes = 3;
                    deviceAddress = (byte) (0xA0 | readFlag | ((address & 0x010000) >> 15));
                    subAddress1 = (byte) ((address & 0xFF00) >> 8);
                    subAddress2 = (byte) (address & 0x00FF);
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(cardMemorySize), cardMemorySize, null);
            }
            i2CCommand = numberOfAddressBytes.ToString("X2") + numberOfBytesToRead.ToString("X2") + deviceAddress.ToString("X2") + subAddress1.ToString("X2") + subAddress2.ToString("X2");
            var len = i2CCommand.Length / 2;
            return "FF70076B" + (len + 4).ToString("X2") + "A6" + (len + 2).ToString("X2") + "A2" + len.ToString("X2") + i2CCommand + "00";
        }
        public string GetWriteCommandApdu(MemorySize cardMemorySize, int address, byte numberOfBytesToWrite, string dataOctetString)
        {
            if ((int)cardMemorySize <= address)
                throw new ArgumentOutOfRangeException(nameof(address), address, $"Address out of card memory address range, selected card memory size: {(int)cardMemorySize} bytes");

            var i2CCommand = string.Empty;
            byte numberOfAddressBytes;
            byte deviceAddress;
            byte subAddress1;
            byte subAddress2;

            switch (cardMemorySize)
            {
                case MemorySize._256:
                    numberOfAddressBytes = 2;
                    deviceAddress = 0xA0;
                    subAddress1 = (byte)(address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._512:
                    numberOfAddressBytes = 2;
                    deviceAddress = (byte)(0xA0 | ((address & 0x000100) >> 7));
                    subAddress1 = (byte)(address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._1024:
                    numberOfAddressBytes = 2;
                    deviceAddress = (byte)(0xA0 | ((address & 0x000300) >> 7));
                    subAddress1 = (byte)(address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._2048:
                    numberOfAddressBytes = 2;
                    deviceAddress = (byte)(0xA0 | ((address & 0x000700) >> 7));
                    subAddress1 = (byte)(address & 0x00FF);
                    subAddress2 = 0x00;
                    break;
                case MemorySize._4096:
                case MemorySize._8192:
                case MemorySize._16384:
                case MemorySize._32768:
                case MemorySize._65536:
                    numberOfAddressBytes = 3;
                    deviceAddress = 0xA0;
                    subAddress1 = (byte)((address & 0xFF00) >> 8);
                    subAddress2 = (byte)(address & 0x00FF);
                    break;
                case MemorySize._131072:
                    numberOfAddressBytes = 3;
                    deviceAddress = (byte)(0xA0 | ((address & 0x010000) >> 15));
                    subAddress1 = (byte)((address & 0xFF00) >> 8);
                    subAddress2 = (byte)(address & 0x00FF);
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(cardMemorySize), cardMemorySize, null);
            }

            if (dataOctetString.Length % 2 != 0)
                throw new ArgumentOutOfRangeException(nameof(dataOctetString), dataOctetString, "String length not even.");

            for (int i = 0; i < dataOctetString.Length / 2; i++)
            {
                byte data;
                if (!byte.TryParse(dataOctetString.Substring(2 * i, 2), NumberStyles.HexNumber, CultureInfo.CurrentCulture, out data))
                    throw new ArgumentOutOfRangeException(nameof(dataOctetString), dataOctetString, "String can contain only hex numbers.");
            }
            
            i2CCommand = numberOfAddressBytes.ToString("X2") + numberOfBytesToWrite.ToString("X2") + deviceAddress.ToString("X2") + subAddress1.ToString("X2") + subAddress2.ToString("X2") + dataOctetString;
            var len = i2CCommand.Length / 2;
            return "FF70076B" + (len + 4).ToString("X2") + "A6" + (len + 2).ToString("X2") + "A2" + len.ToString("X2") + i2CCommand + "00";
        }
        public string GetApdu(string i2CCommand)
        {
            i2CCommand = i2CCommand.Replace(" ", "").Replace("-", "");
            var len = i2CCommand.Length / 2;
            return "FF70076B" + (len + 4).ToString("X2") + "A6" + (len + 2).ToString("X2") + "A2" + len.ToString("X2") +
                   i2CCommand + "00";
        }

*)

end.
