unit untDriver;

interface

uses
  // VCL
  Windows, SysUtils, Registry, ShellAPI, IniFiles, Classes, ExtCtrls, SyncObjs,
  // This
  CardReaderInterface, untError, untConst, MifareLib_TLB, Directory, CardField,
  CardSector, COMPort, untUtil, NotifyThread, MFRC500Reader, OmnikeyCardReader,
  OmnikeyCardReader5422, LogFile, SerialParams, DriverEvent, CardReaderEmulator,
  MethodSynchronizer, VersionInfo, MifareDevice, untTypes;

const
  KEY_HEADER = 'HEADER';
  KEY_CATALOG = 'CATAL.';
  KEY_MIKLESOFT = #$00#$00#$00#$00#$00#$00;
  KEY_STANDARD = #$FF#$FF#$FF#$FF#$FF#$FF;

type
  TMifareDrvEvent = procedure(Sender: TObject; EventID: Integer) of object;

  { TDriver }

  TDriver = class
  private
    FID: Integer;
    FCardReader: ICardReader;
    FEvent: TDriverEventRec;
    FParentWnd: Integer;
    FFields: TCardFields;
    FResultCode: Integer;
    FCS: TCriticalSection;
    FSectors: TCardSectors;
    FResultDescription: string;
    FDirectory: TCardDirectory;
    FOnCard: TMifareDrvCardFound;
    FOnPollError: TMifareDrvPollError;
    FRedLED: Boolean;
    FGreenLED: Boolean;
    FBlueLED: Boolean;
    FYellowLed: Boolean;
    FButtonState: Boolean;
    FEvents: TDriverEvents;
    FEventID: Integer;
    FEventsEnabled: Boolean;
    FOnEvent: TMifareDrvEvent;
    FDevices: TMifareDevices;
    FSAMVersion: TSAMVersion;
    FParams: TSerialParams;
    FSendEvents: Boolean;
    FSynchronizer: TMethodSynchronizer;

    procedure DrvConnect;
    procedure DrvOpenPort;
    function GetUIDHex: string;
    function GetBlockDataHex: string;
    procedure SetUIDHex(const Value: string);
    procedure SetBlockDataHex(const Value: string);

    function GetSectorCount: Integer;
    procedure FindAppBlock;
    procedure CheckFieldIndex;
    function AuthByKey(const KeyData: string): Integer;
    procedure Lock;
    procedure Unlock;
    function GetRxData: string;
    function GetRxDataHex: string;
    function GetTxData: string;
    function GetTxDataHex: string;
    function GetCardReader: ICardReader;
    function GetKeyUncoded: string;
    procedure SetKeyUncoded(const Value: string);
    function GetKeyEncoded: string;
    procedure SetKeyEncoded(const Value: string);
    function GetKeyA: string;
    function GetKeyB: string;
    procedure SetKeyA(const Value: string);
    procedure SetKeyB(const Value: string);
    function GetNewKeyA: string;
    function GetNewKeyB: string;
    procedure SetNewKeyA(const Value: string);
    procedure SetNewKeyB(const Value: string);
    function BinToData(const Value: string): string;
    function DataToBin(const Value: string): string;
    function GetLogEnabled: Boolean;
    function GetLogFileName: string;
    procedure SetLogEnabled(const Value: Boolean);
    procedure SetLogFileName(const Value: string);
    procedure DeliverEvents;
    function Get_EventCount: Integer;
    function Get_Connected: Boolean;
    function Get_ErrorText: string;
    procedure WriteLogHeader;
    function GetNotDeliveredEvent(var EventData: TDriverEventRec): Boolean;
    function GetPollStarted: Boolean;
    function CreateCardReader(AParams: TSerialParams): ICardReader;
    procedure CardFoundEvent(ASender: TObject; const Event: TCardFoundEventRec);
    procedure PollErrorEvent(ASender: TObject; const Event: TPollErrorEventRec);
    function GetSAMVersionData: string;
    function GetLogFilePath: string;
    procedure SetLogFilePath(const Value: string);
    function GetSerialNumberHex: string;
    procedure SetSerialNumberHex(const Value: string);
    procedure DoLoadParams;
    function GetKeyTypeText: string;
    function GetParity: Integer;
    procedure SetParity(const Value: Integer);
    function GetTimeout: Integer;
    procedure SetTimeout(const Value: Integer);
    function GetPortNumber: Integer;
    procedure SetPortNumber(const Value: Integer);
    function GetPortBaudRate: Integer;
    procedure SetPortBaudRate(const Value: Integer);
    function GetBaudRate: TBaudRate;
    procedure SetBaudRate(const Value: TBaudRate);
    function GetReaderName: string;
    procedure SetReaderName(const Value: string);
    function GetPollInterval: Integer;
    procedure SetPollInterval(const Value: Integer);
    function GetPollAutoDisable: Boolean;
    procedure SetPollAutoDisable(const Value: Boolean);
    procedure CorruptedValueBlock;
    function GetSAMHWVendorID: Integer;
    function GetSAMHWVendorName: string;
    function GetSAMHWType: Integer;
    function GetSAMHWSubType: Integer;
    function GetSAMHWMajorVersion: Integer;
    function GetSAMHWMinorVersion: Integer;
    function GetSAMHWProtocol: Integer;
    function GetSAMHWStorageSize: Integer;
    function GetSAMHWStorageSizeCode: Integer;
    function GetSAMSWMajorVersion: Integer;
    function GetSAMSWMinorVersion: Integer;
    function GetSAMSWProtocol: Integer;
    function GetSAMSWStorageSize: Integer;
    function GetSAMSWStorageSizeCode: Integer;
    function GetSAMSWSubType: Integer;
    function GetSAMSWType: Integer;
    function GetSAMSWVendorID: Integer;
    function GetSAMSWVendorName: string;
    function GetSAMMode: Integer;
    function GetSAMModeName: string;
    function Get_SAMMDBatchNo: Integer;
    function Get_SAMMDGlobalCryptoSettings: Integer;
    function Get_SAMMDProductionDay: Integer;
    function Get_SAMMDProductionMonth: Integer;
    function Get_SAMMDProductionYear: Integer;
    function Get_SAMMDUID: Int64;
    function Get_SAMMDUIDHex: WideString;
    function Get_SAMMDUIDStr: WideString;
    function GetPollActivateMethod: TPollActivateMethod;
    procedure SetPollActivateMethod(const Value: TPollActivateMethod);
    function GetDeviceType: TDeviceType;
  private
    FSAK: Byte;
    FUIDLen: Byte;
    FCardType: TCardType;
    FPcdFwVersion: string;
    FPcdRicVersion: string;
    FPasswordHeader: string;
    FDirectoryVersion: Byte;
    function GetFieldCount: Integer;
    function GeTDirectoryStatusText: string;
    function GeTDirectoryStatus: TDirectoryStatus;
    procedure SetDeviceType(Value: TDeviceType);
  protected
    FATQ: WORD;
    FKeyA: string;
    FKeyB: string;
    FNewKeyA: string;
    FNewKeyB: string;
    FKeyUncoded: string;
    FKeyEncoded: string;

    procedure SetCardType(Value: TCardType); virtual;
    property Fields: TCardFields read FFields;
  public
    UID: string;
    AccessMode0: Integer; // Биты доступа блока 0
    AccessMode1: Integer; // Биты доступа блока 1
    AccessMode2: Integer; // Биты доступа блока 2
    AccessMode3: Integer; // Биты доступа блока 3 (трейлера)
    Block: string;
    BlockCount: Integer;
    BlockData: string; //данные в двоичном виде
    BlockAddr: Integer;
    BlockValue: Integer;
    ReqCode: Integer;
    TmoVal: DWORD;
    BitCount: Integer;
    KeyType: Integer;
    KeyNumber: Integer;
    TransAddr: Integer;
    DataLength: Integer;
    LibInfoKey: Integer;
    BlockNumber: Integer;
    RfResetTime: Integer;
    TransTime: Cardinal;
    ExecutionTime: DWORD;
    RICValue: Integer;
    BeepTone: Integer;
    TransBlockNumber: Integer;
    DeltaValue: DWORD;
    BlockAuthResult: Integer;
    BlockReadResult: Integer;
    BlockSectorNumber: Integer;
    BlockIndexInSector: Integer; // Номер блока в секторе
    FileName: string;
    CardIndex: Integer;
    Command: Integer;
    ValueOperation: Integer; // Тип операции
    SelectCode: TSelectCode;
    SectorNumber: Integer;
    AppCode: Integer;
    FirmCode: Integer;
    SectorIndex: Integer;
    FieldType: TFieldType;
    FieldValue: string;
    FieldIndex: Integer;
    FieldSize: Integer;
    UpdateTrailer: Boolean;
    DataAuthMode: TDataAuthMode;
    DataFormat: TDataFormat;
    KeyPosition: Integer;
    KeyVersion: Integer;
    ParamsRegKey: string;
    KeyEntryNumber: Integer;
    KeyVersion0: Integer;
    KeyVersion1: Integer;
    KeyVersion2: Integer;
    SerialNumber: string;
    ErrorOnCorruptedValueBlock: Boolean;
    IsValueBlockCorrupted: Boolean;
    ReceiveDivisor: Integer;
    SendDivisor: Integer;
    AuthType: Integer;
    NewBaudRate: Integer;
    Protocol: Integer;
    EncryptionEnabled: Boolean; // Настройка обмена, шифрование
    AnswerSignature: Boolean;   // Настройка обмена, подпись ответа
    CommandSignature: Boolean;  // Настройка обмена, подпись команды

    constructor Create;
    destructor Destroy; override;


    procedure AuthBlock;
    function Connect: Integer;
    function OpenPort: Integer;
    function PiccRead: Integer;
    function PiccHalt: Integer;
    function PiccAuth: Integer;
    function PiccWrite: Integer;
    function ClosePort: Integer;
    function Disconnect: Integer;
    function SaveParams: Integer;
    function LoadParams: Integer; virtual;
    function SetDefaults: Integer;
    function PcdConfig: Integer;
    function PiccAuthE2: Integer;
    function PiccSelect: Integer;
    function EncodeKey: Integer;
    function RequestAll: Integer;
    function RequestIdle: Integer;
    function PiccAuthKey: Integer;
    function PcdLoadKeyE2: Integer;
    function PiccAnticoll: Integer;
    function PiccCommonRead: Integer;
    function PiccCascSelect: Integer;
    function PiccCommonWrite: Integer;
    function PiccCascAnticoll: Integer;
    function PiccActivateIdle: Integer;
    function PiccCommonRequest: Integer;
    function PiccActivateWakeup: Integer;
    function PcdSetDefaultAttrib: Integer;
    function InterfaceSetTimeout: Integer;
    function PcdSetTmo: Integer;
    function PcdGetSerialNumber: Integer;
    function PcdGetFwVersion: Integer;
    function PcdGetRicVersion: Integer;
    function PcdReadE2: Integer;
    function PcdWriteE2: Integer;
    function PcdRfReset: Integer;
    function StartTransTimer: Integer;
    function StopTransTimer: Integer;
    function PcdReset: Integer;
    function PcdBeep: Integer;
    function EncodeValueBlock: Integer;
    function DecodeValueBlock: Integer;
    function PiccValue: Integer;
    function PiccValueDebit: Integer;
    function FindDevice: Integer;
    function AuthStandard: Integer;
    function ClearBlock: Integer;
    procedure FindFreeSector;
    function SetSectorParams: Integer;
    function GetSectorParams: Integer;
    function PortOpened: Shortint;
    function DeleteSector: Integer;
    function ResetCard: Integer;
    procedure WriteAppBlock;
    procedure ClearFields;
    function AddField: Integer;
    function PollStop: Integer;
    function LoadValue: Integer;
    function PollStart: Integer;
    function ClearResult: Integer;
    function DeleteField: Integer;
    function GetFieldParams: Integer;
    function SetFieldParams: Integer;
    function DeleteAllFields: Integer;
    function SaveFieldsToFile: Integer;
    function ClearFieldValues: Integer;
    function LoadFieldsFromFile: Integer;
    procedure Check(ResultCode: Integer);
    function ShowConnectionProperties: Integer;
    function HandleException(E: Exception): Integer;
    function AuthByKeys(const Keys: array of string): Integer;
    function AuthorizeByKeys(const KeyA, KeyB: string): Integer;
    function AuthorizeByKeys2(const KeyA, KeyB: string): Integer;
    function WriteBlock(BlockNum: Integer; const Data: string): Integer;
    function WriteTrailer(Address, C0, C1, C2, C3: Byte; const KeyA, KeyB: string): Integer;
    function SleepMode: Integer;
    function PcdControlLEDAndPoll: Integer;
    function PcdControlLED: Integer;
    function PcdPollButton: Integer;

    function FindEvent: Integer;
    function DeleteEvent: Integer;
    function Get_EventsEnabled: Boolean;
    procedure Set_EventsEnabled(Value: Boolean);
    function SendEvent: Integer;
    function ClearEvents: Integer;
    function TestBit(AValue, ABitIndex: Integer): Boolean;
    function LockReader: Integer;
    function UnlockReader: Integer;
    function SAM_GetVersion: Integer;
    function SAM_WriteKey: Integer;
    function SAM_AuthKey: Integer;

    function SAM_GetKeyEntry: Integer;
    function SAM_WriteHostAuthKey: Integer;
    function ReadFullSerialNumber: Integer;
    function SAM_SetProtection: Integer;
    function SAM_SetProtectionSN: Integer;
    function WriteConnectionParams: Integer;
    function UltralightRead: Integer;
    function UltralightAuth: Integer;
    function UltralightCompatWrite: Integer;
    function UltralightWrite: Integer;
    function UltralightWriteKey: Integer;
    function MifarePlusWritePerso: Integer;
    function MifarePlusWriteParameters: Integer;
    function MifarePlusCommitPerso: Integer;
    function MifarePlusAuthSL1: Integer;
    function MifarePlusAuthSL2: Integer;
    function MifarePlusAuthSL3: Integer;
    function MifarePlusDecrement: Integer;
    function MifarePlusDecrementTransfer: Integer;
    function MifarePlusIncrement: Integer;
    function MifarePlusIncrementTransfer: Integer;
    function MifarePlusMultiblockRead: Integer;
    function MifarePlusMultiblockWrite: Integer;
    function MifarePlusRead: Integer;
    function MifarePlusWrite: Integer;
    function MifarePlusReadValue: Integer;
    function MifarePlusResetAuthentication: Integer;
    function MifarePlusRestore: Integer;
    function MifarePlusTransfer: Integer;
    function MifarePlusWriteValue: Integer;
    function EnableCardAccept: Integer;
    function DisableCardAccept: Integer;
    function HoldCard: Integer;
    function IssueCard: Integer;
    function ReadLastAnswer: Integer;
    function ReadStatus: Integer;
    function SAMAV2WriteKey: Integer;
    function MifarePlusMultiblockReadSL2: Integer;
    function MifarePlusMultiblockWriteSL2: Integer;
    function MifarePlusAuthSL2Crypto1: Integer;
    function WriteEncryptedData: Integer;

    property ID: Integer read FID;
    property DriverID: Integer read FID;
    property EventType: Integer read FEvent.EventType;
    property EventDriverID: Integer read FEvent.DriverID;
    property EventID: Integer read FEventID write FEventID;
    property EventErrorCode: Integer read FEvent.ErrorCode;
    property EventPortNumber: Integer read FEvent.PortNumber;
    property EventErrorText: string read FEvent.ErrorText;
    property EventCardUIDHex: string read FEvent.CardUIDHex;
    property EventsEnabled: Boolean read Get_EventsEnabled write Set_EventsEnabled;
    property EventCount: Integer read Get_EventCount;

    property ATQ: WORD read FATQ;
    property SAK: Byte read FSAK;
    property UIDLen: Byte read FUIDLen;
    property TxData: string read GetTxData;
    property RxData: string read GetRxData;
    property TxDataHex: string read GetTxDataHex;
    property RxDataHex: string read GetRxDataHex;
    property CardType: TCardType read FCardType;
    property Sectors: TCardSectors read FSectors;
    property Directory: TCardDirectory read FDirectory;
    property PcdFwVersion: string read FPcdFwVersion;
    property FieldCount: Integer read GetFieldCount;
    property SectorCount: Integer read GetSectorCount;
    property PcdRicVersion: string read FPcdRicVersion;
    property CardReader: ICardReader read GetCardReader;
    property PasswordHeader: string read FPasswordHeader;
    property DirectoryVersion: Byte read FDirectoryVersion;
    property UIDHex: string read GetUIDHex write SetUIDHex;
    property DirectoryStatusText: string read GeTDirectoryStatusText;
    property DirectoryStatus: TDirectoryStatus read GeTDirectoryStatus;
    property BlockDataHex: string read GetBlockDataHex write SetBlockDataHex;
    property ResultDescription: string read FResultDescription;
    property ResultCode: Integer read FResultCode;
    property PollStarted: Boolean read GetPollStarted;
    property ParentWnd: Integer read FParentWnd write FParentWnd;
    property DeviceType: TDeviceType read GetDeviceType write SetDeviceType;
    property PollAutoDisable: Boolean read GetPollAutoDisable write SetPollAutoDisable;
    property OnCard: TMifareDrvCardFound read FOnCard write FOnCard;
    property OnPollError: TMifareDrvPollError read FOnPollError write FOnPollError;

    property KeyABin: string read FKeyA;
    property KeyBBin: string read FKeyB;
    property KeyA: string read GetKeyA write SetKeyA;
    property KeyB: string read GetKeyB write SetKeyB;
    property Parity: Integer read GetParity write SetParity;
    property Timeout: Integer read GetTimeout write SetTimeout;
    property NewKeyA: string read GetNewKeyA write SetNewKeyA;
    property NewKeyB: string read GetNewKeyB write SetNewKeyB;
    property BaudRate: TBaudRate read GetBaudRate write SetBaudRate;
    property ReaderName: string read GetReaderName write SetReaderName;
    property PortNumber: Integer read GetPortNumber write SetPortNumber;
    property PortBaudRate: Integer read GetPortBaudRate write SetPortBaudRate;
    property KeyUncoded: string read GetKeyUncoded write SetKeyUncoded;
    property KeyEncoded: string read GetKeyEncoded write SetKeyEncoded;
    property LogEnabled: Boolean read GetLogEnabled write SetLogEnabled;
    property LogFileName: string read GetLogFileName write SetLogFileName;
    property LogFilePath: string read GetLogFilePath write SetLogFilePath;
    property RedLED: Boolean read FRedLED write FRedLED;
    property GreenLED: Boolean read FGreenLED write FGreenLED;
    property BlueLED: Boolean read FBlueLED write FBlueLED;
    property YellowLED: Boolean read FYellowLED write FYellowLED;
    property ButtonState: Boolean read FButtonState;
    property OnEvent: TMifareDrvEvent read FOnEvent write FOnEvent;
    property Connected: Boolean read Get_Connected;
    property ErrorText: string read Get_ErrorText;
    property Devices: TMifareDevices read FDevices;
    property SAMVersion: TSAMVersion read FSAMVersion;
    property SAMVersionData: string read GetSAMVersionData;
    property SerialNumberHex: string read GetSerialNumberHex
      write SetSerialNumberHex;
    property KeyTypeText: string read GetKeyTypeText;
    property PollInterval: Integer read GetPollInterval write SetPollInterval;

    property SAMHWVendorID: Integer read GetSAMHWVendorID;
    property SAMHWVendorName: string read GetSAMHWVendorName;
    property SAMHWType: Integer read GetSAMHWType;
    property SAMHWSubType: Integer read GetSAMHWSubType;
    property SAMHWMajorVersion: Integer read GetSAMHWMajorVersion;
    property SAMHWMinorVersion: Integer read GetSAMHWMinorVersion;
    property SAMHWStorageSize: Integer read GetSAMHWStorageSize;
    property SAMHWProtocol: Integer read GetSAMHWProtocol;
    property SAMHWStorageSizeCode: Integer read GetSAMHWStorageSizeCode;

    property SAMSWVendorID: Integer read GetSAMSWVendorID;
    property SAMSWVendorName: string read GetSAMSWVendorName;
    property SAMSWType: Integer read GetSAMSWType;
    property SAMSWSubType: Integer read GetSAMSWSubType;
    property SAMSWMajorVersion: Integer read GetSAMSWMajorVersion;
    property SAMSWMinorVersion: Integer read GetSAMSWMinorVersion;
    property SAMSWStorageSize: Integer read GetSAMSWStorageSize;
    property SAMSWProtocol: Integer read GetSAMSWProtocol;
    property SAMSWStorageSizeCode: Integer read GetSAMSWStorageSizeCode;
    property SAMMode: Integer read GetSAMMode;
    property SAMModeName: string read GetSAMModeName;
    property SAMMDUID: Int64 read Get_SAMMDUID;
    property SAMMDUIDStr: WideString read Get_SAMMDUIDStr;
    property SAMMDUIDHex: WideString read Get_SAMMDUIDHex;
    property SAMMDBatchNo: Integer read Get_SAMMDBatchNo;
    property SAMMDProductionDay: Integer read Get_SAMMDProductionDay;
    property SAMMDProductionMonth: Integer read Get_SAMMDProductionMonth;
    property SAMMDProductionYear: Integer read Get_SAMMDProductionYear;
    property SAMMDGlobalCryptoSettings: Integer read Get_SAMMDGlobalCryptoSettings;
    property PollActivateMethod: TPollActivateMethod read GetPollActivateMethod
    write SetPollActivateMethod;
  end;

implementation

function Int2Hex(Value, Len: Integer): string;
begin
  Result := Format('0x%.*x', [Len, Value]);
end;

function Min(I1, I2: Integer): Integer;
begin
  if I1 < I2 then Result := I1 else Result := I2;
end;

// Atq 68, Sak 8.


function GetBlockCount(CardType: TCardType): Integer;
begin
  case CardType of
    ctMifareUltraLight: Result := 16;
    ctMifare1K: Result := 64;
    ctMifare4K: Result := 256;
  else
    Result := 0;
  end;
end;

function GetBlockNumber(CardType: TCardType; Index: Integer): Integer;
begin
  Result := 0;
  case CardType of

    ctMifare1K:
      begin
        Result := Index mod 4;
      end;

    ctMifare4K:
      begin
        if Index < 128 then Result := Index mod 4
        else Result := Index mod 16;
      end;
  end;
end;

function GetSectorNumber(CardType: TCardType; Index: Integer): Integer;
begin
  Result := 0;
  case CardType of
    ctMifare1K:
      begin
        Result := Index div 4;
      end;
    ctMifare4K:
      begin
        if Index < 128 then Result := Index div 4
        else Result := Index div 16;
      end;
  end;
end;

function GetBlockData(const S: string; L: Integer): string;
begin
  Result := Copy(S, 1, L);
  Result := Result + StringOfChar(#0, L - Length(Result));
end;

function BufToUID(var Buf: array of Byte; Count: Integer): string;
begin
  Result := '';
  if Count = 0 then Exit;

  SetLength(Result, Count);
  Move(Buf, Result[1], Count);
end;

procedure UIDToBuf(const UID: string; var Buf: array of Byte);
begin
  if Length(UID) > 0 then
  begin
    FillChar(Buf, 256, 0);
    Move(UID[1], Buf, Min(Length(UID), 256))
  end;
end;

procedure CheckInt(Value, MinValue, MaxValue: Integer; const PropName: string);
begin
  if (Value < MinValue) or (Value > MaxValue) then
    RaiseError(E_INVALID_VALUE, 'Неверное значение свойства ' + PropName);
end;

{ TDriver }

constructor TDriver.Create;
const
  LastID: Integer = 0;
begin
  inherited Create;
  FSendEvents := True;
  FParams := TSerialParams.Create;
  FParams.Mode := MODE_RS232;
  ParamsRegKey := 'Params';
  Inc(LastID); FID := LastID;
  FFields := TCardFields.Create;
  FEvents := TDriverEvents.Create;
  FCS := TCriticalSection.Create;
  FSectors := TCardSectors.Create(nil);
  FDirectory := TCardDirectory.Create;
  FDevices := TMifareDevices.Create;

  FPasswordHeader := KEY_HEADER;
  KeyType := ktKeyA;
  PollAutoDisable := True;
  FEventsEnabled := True;
  FSynchronizer := TMethodSynchronizer.Create;

  SetDefaults;
  LoadParams;
  Logger.Debug('TDriver.Create, ID: ' + IntToStr(FID));
end;

destructor TDriver.Destroy;
begin
  Logger.Debug('TDriver.Destroy, ID: ' + IntToStr(FID));
  FSendEvents := False;
  SaveParams;
  FDevices.Free;
  FSynchronizer.Free;
  FCS.Free;
  FFields.Free;
  FEvents.Free;
  FSectors.Free;
  FDirectory.Free;
  FParams.Free;
  inherited Destroy;
end;

function TDriver.BinToData(const Value: string): string;
begin
  if DataFormat = dfHex then Result := StrToHex(Value)
  else Result := Value;
end;

function TDriver.DataToBin(const Value: string): string;
begin
  try
    if DataFormat = dfHex then
      Result := HexToStr(Value)
    else
      Result := Value;
  except
    Result := '';
  end;
end;

function TDriver.GetCardReader: ICardReader;
begin
  if FCardReader = nil then
    FCardReader := CreateCardReader(FParams);
  Result := FCardReader;
end;

function TDriver.CreateCardReader(AParams: TSerialParams): ICardReader;
begin
  case DeviceType of
    dtMiReader    : Result := TMFRC500Reader.Create(AParams);
    dtCardman5321 : Result := TOmnikeyCardReader.Create(AParams);
    dtEmulator    : Result := TCardReaderEmulator.Create;
    dtOmnikey5422 : Result := TOmnikeyCardReader5422.Create(AParams);
  else
    Result := TOmnikeyCardReader.Create(AParams);
  end;
end;

procedure TDriver.Lock;
begin
  FCS.Enter;
end;

procedure TDriver.Unlock;
begin
  FCS.Leave;
end;

function TDriver.ClearResult: Integer;
begin
  Result := SUCCESS;
  FResultCode := SUCCESS;
  FResultDescription := S_SUCCESS;
end;

function TDriver.HandleException(E: Exception): Integer;
var
  CustomError: EDriverError;
begin
  FResultDescription := E.Message;
  if E is EDriverError then
  begin
    CustomError := E as EDriverError;
    FResultCode := CustomError.ErrorCode;
  end else
    FResultCode := Integer(E_UNKNOWN);
  Result := FResultCode;
end;

procedure TDriver.Check(ResultCode: Integer);
begin
  if (ResultCode <> 0) and (ResultCode <> MI_POLLING) then
    RaiseError(ResultCode, GetResultDescription(ResultCode));
end;

procedure TDriver.DrvOpenPort;
begin
  if PortOpened = 0 then Exit;
  CardReader.OpenPort;
end;

function TDriver.SaveParams: Integer;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := RegRootKey;
    if Reg.OpenKey(REGSTR_KEY_DRV + ParamsRegKey, True) then
    begin
      Reg.WriteInteger(REGSTR_VAL_TIMEOUT, Timeout);
      Reg.WriteInteger(REGSTR_VAL_PARITY, Parity);
      Reg.WriteInteger(REGSTR_VAL_BAUDRATE, PortBaudRate);
      Reg.WriteInteger(REGSTR_VAL_PORTNUMBER, PortNumber);
      Reg.WriteInteger(REGSTR_VAL_DEVICETYPE, DeviceType);
      Reg.WriteString(REGSTR_VAL_READERNAME, ReaderName);
      Reg.WriteBool(REGSTR_VAL_LOGENABLED, LogEnabled);
      Reg.WriteString(REGSTR_VAL_LOGFILENAME, LogFileName);
      Reg.WriteBool(REGSTR_VAL_ERROR_ON_CORRUPTED, ErrorOnCorruptedValueBlock);
      Reg.WriteInteger(REGSTR_VAL_POLL_ACTIVATE_METHOD, PollActivateMethod);
    end;
    Result := ClearResult;
  except
    on E: Exception do
    begin
      Result := HandleException(E);
    end;
  end;
  Reg.Free;
end;

function TDriver.LoadParams: Integer;
begin
  try
    DoLoadParams;
    Result := ClearResult;
  except
    on E: Exception do
    begin
      Result := HandleException(E);
    end;
  end;
end;

procedure TDriver.DoLoadParams;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := RegRootKey;
    if Reg.OpenKey(REGSTR_KEY_DRV + ParamsRegKey, False) then
    begin
      if Reg.ValueExists(REGSTR_VAL_TIMEOUT) then
        Timeout := Reg.ReadInteger(REGSTR_VAL_TIMEOUT);

      if Reg.ValueExists(REGSTR_VAL_PARITY) then
        Parity := Reg.ReadInteger(REGSTR_VAL_PARITY);

      if Reg.ValueExists(REGSTR_VAL_PORTNUMBER) then
        PortNumber := Reg.ReadInteger(REGSTR_VAL_PORTNUMBER);

      if Reg.ValueExists(REGSTR_VAL_BAUDRATE) then
        PortBaudRate := Reg.ReadInteger(REGSTR_VAL_BAUDRATE);

      if Reg.ValueExists(REGSTR_VAL_DEVICETYPE) then
        DeviceType := Reg.ReadInteger(REGSTR_VAL_DEVICETYPE);

      if Reg.ValueExists(REGSTR_VAL_READERNAME) then
        ReaderName := Reg.ReadString(REGSTR_VAL_READERNAME);

      if Reg.ValueExists(REGSTR_VAL_LOGFILENAME) then
        LogFileName := Reg.ReadString(REGSTR_VAL_LOGFILENAME);

      if Reg.ValueExists(REGSTR_VAL_LOGENABLED) then
        LogEnabled := Reg.ReadBool(REGSTR_VAL_LOGENABLED);

      if Reg.ValueExists(REGSTR_VAL_ERROR_ON_CORRUPTED) then
        ErrorOnCorruptedValueBlock := Reg.ReadBool(REGSTR_VAL_ERROR_ON_CORRUPTED);

      if Reg.ValueExists(REGSTR_VAL_POLL_ACTIVATE_METHOD) then
        PollActivateMethod := Reg.ReadInteger(REGSTR_VAL_POLL_ACTIVATE_METHOD);
    end;
  finally
    Reg.Free;
  end;
end;

procedure TDriver.DrvConnect;
var
  ResultCode: Integer;
begin
  ResultCode := CardReader.GetOnlineStatus;
  if ResultCode = 0 then Exit;
  CardReader.OpenPort;
  CardReader.Mf500PcdConfig;
end;

function TDriver.StartTransTimer: Integer;
begin
  TransTime := GetTickCount;
  Result := ClearResult;
end;

function TDriver.StopTransTimer: Integer;
begin
  TransTime := GetTickCount - TransTime;
  Result := ClearResult;
end;

function TDriver.PcdConfig: Integer;
begin
  try
    DrvOpenPort;
    CardReader.Mf500PcdConfig;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PiccHalt: Integer;
begin
  Lock;
  try
    DrvConnect;
    CardReader.Mf500PiccHalt;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
  Unlock;
end;

function TDriver.PiccCommonRequest: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccRequest(ReqCode, FATQ);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.RequestAll: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccRequest(PICC_REQALL, FATQ);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.RequestIdle: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccRequest(PICC_REQIDL, FATQ);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PiccAnticoll: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccAnticoll(BitCount, UID);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PiccCascAnticoll: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccCascAnticoll(SelectCode, BitCount, UID);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdSetDefaultAttrib: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PcdSetDefaultAttrib;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

{******************************************************************************}
{
{       PICC Select Command
{       Ф-ция выбора карты с указаным номером. В случае успеха, возвращает в
{       sak тип карты (в соотв-ии с AnswerToSelect стандарта ISO)
{
{******************************************************************************}

function TDriver.PiccCascSelect: Integer;
var
  Buf: string;
begin
  try
    DrvConnect;
    Buf := UID;
    CardReader.Mf500PiccCascSelect(SelectCode, Buf, FSAK);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

{******************************************************************************}
{
{       PICC Select Command
{       Ф-ция выбора карты с указаным номером. В случае успеха, возвращает в
{       sak тип карты (в соотв-ии с AnswerToSelect стандарта ISO)
{
{******************************************************************************}

function TDriver.PiccSelect: Integer;
var
  Buf: string;
begin
  try
    DrvConnect;
    Buf := UID;
    CardReader.Mf500PiccSelect(Buf, FSAK);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PiccActivateIdle: Integer;
begin
  Lock;
  try
    DrvConnect;
    CardReader.Mf500PiccActivateIdle(Baudrate, FATQ, FSAK, FUIDLen, UID);
    SetCardType(CardReader.CardType);

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
  Unlock;
end;

function TDriver.PiccActivateWakeup: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccActivateWakeup(Baudrate, FATQ, FSAK, UID, FUIDLen);
    SetCardType(CardReader.CardType);
    BlockCount := GetBlockCount(FCardType);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

{******************************************************************************
*
*
*       MIFARE Authentication
*
*       Авторизация доступа к карте
*       KeyType - тип ключа: PICC_AUTHENT1A или PICC_AUTHENT1B
*       KeyNumber - адрес ключа в EEPROM микросхемы mfrc500
*       BlockNumber - номер сектора, к которому происходит авторизация
*
******************************************************************************}

function TDriver.PiccAuth: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccAuth(KeyType, KeyNumber, BlockNumber);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PiccAuthE2: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccAuth(KeyType, KeyNumber, BlockNumber);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

(*
Записывает 6-байтовый (некодированный) ключ во внутреннюю защищенную EEPROM ридера.

Входные параметры:
  KeyType - тип ключа (ключ А или ключ Б): PICC_AUTHENT1A или PICC_AUTHENT1B
  KeyNumber - номер сектора в памяти (0..15), куда записывается ключ
  KeyValue - указатель на 6-байтовый ключ в некодированном виде
*)

function TDriver.PcdLoadKeyE2: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PcdLoadKeyE2(KeyType, KeyNumber, FKeyUncoded);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PiccAuthKey: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccAuthKey(KeyType, UID, FKeyEncoded, BlockNumber);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

/// PICC Read Block of variable length
/// читает блок произвольной длины, но для mifare classic длина д.б. 16
/// Т.е. предпочтительней использовать Mf500PiccRead

function TDriver.PiccCommonRead: Integer;
begin
  try
    DrvConnect;
    if DataLength > 0 then
    begin
      CardReader.Mf500PiccCommonRead(Command, BlockNumber, DataLength, BlockData);
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

/// PICC Read Block
/// Читает 16-байтовый блок данных с номером addr с карты
/// Перед вызовом необходимо авторизоваться

function TDriver.PiccRead: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccRead(BlockNumber, BlockData);
   Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

/// PICC Write Block of variable length
/// пишет блок произвольной длины на карту. Для MifClassic, д.б. 16 байт
/// т.о. нет смысла ее использовать, надо пользовать Mf500PiccWrite

function TDriver.PiccCommonWrite: Integer;
var
  Data: string;
begin
  try
    DrvConnect;
    if DataLength > 0 then
    begin
      Data := GetBlockData(BlockData, Datalength);
      CardReader.Mf500PiccCommonWrite(Command, BlockNumber, DataLength, Data);
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

/// PICC Write Block
/// Пишет 16-байтовый блок данных с номером addr на карту
/// Перед вызовом необходимо авторизоваться
/// будьте внимательны при записи Sector Trailer

function TDriver.PiccWrite: Integer;
var
  Data: string;
begin
  try
    DrvConnect;
    Data := GetBlockData(BlockData, 16);
    CardReader.Mf500PiccWrite(BlockNumber, Data);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

/// PICC Value Block Operation
/// Работа с value-полями (для работы блок с номером addr должен иметь верный формат)
/// dd_mode: PICC_DECREMENT - декремент значения
/// dd_mode: PICC_INCREMENT - инкремент значения
/// dd_mode: PICC_TRANSFER - запись значения (бэкап)
/// dd_mode: PICC_RESTORE - запись значения (восстановление)
/// addr - номер блока, с которым работаем
/// trans_addr - номер блока "бэкапа"

function TDriver.PiccValue: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500PiccValue(ValueOperation, BlockNumber, TransBlockNumber,
      DeltaValue, BlockAddr, KeyType, KeyNumber);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PiccValueDebit: Integer;
var
  S: string;
begin
  try
    DrvConnect;
    SetLength(S, 4);
    Move(DeltaValue, S[1], 4);
    CardReader.Mf500PiccValueDebit(ValueOperation, BlockNumber, S);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdSetTmo: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdSetTmo(TmoVal);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdGetSerialNumber: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdGetSnr(UID);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdGetFwVersion: Integer;
begin
  try
    DrvConnect;
    FPcdFWVersion := CardReader.PcdGetFwVersion;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdGetRicVersion: Integer;
var
  S: string;
begin
  try
    DrvConnect;
    CardReader.PcdGetRicVersion(S);
    FPcdRicVersion := StrToHex(S);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdReadE2: Integer;
begin
  try
    DrvConnect;
    if DataLength > 0 then
    begin
      CardReader.PcdReadE2(BlockNumber, DataLength, BlockData);
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdWriteE2: Integer;
var
  Data: string;
begin
  try
    DrvConnect;
    if DataLength > 0 then
    begin
      Data := GetBlockData(BlockData, DataLength);
      CardReader.PcdWriteE2(BlockNumber, DataLength, Data);
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdRfReset: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdRfReset(RfResetTime);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

// Get information about the connection status of the device.

function TDriver.PortOpened: Shortint;
begin
  Result := CardReader.GetOnlineStatus;
end;

// Reset the reader ic

function TDriver.PcdReset: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdReset;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdBeep: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdBeep(BeepTone);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.InterfaceSetTimeout: Integer;
begin
  try
    DrvConnect;
    CardReader.Mf500InterfaceSetTimeout(Timeout);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.EncodeKey: Integer;
begin
  FKeyEncoded := StringOfChar(#0, 12);
  CardReader.Mf500HostCodeKey(FKeyUncoded, FKeyEncoded);
  Result := ClearResult;
end;

function TDriver.OpenPort: Integer;
begin
  try
    DrvOpenPort;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.ClosePort: Integer;
begin
  try
    CardReader.Mf500InterfaceClose;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SetDefaults: Integer;
begin
  ReaderName := '';
  PortNumber := 1;
  BaudRate := CBR_57600;
  Timeout := 1000;
  Parity := EVENPARITY;
  PortBaudRate := CBR_57600;
  DeviceType := dtOmnikey5422;
  LogEnabled := False;
  LogFileName := ChangeFileExt(GetLongFileName(GetModuleFileName), '.log');
  Result := ClearResult;
end;

function TDriver.Connect: Integer;
begin
  ClosePort;
  Result := OpenPort;
  if Result <> SUCCESS then Exit;
  Result := PcdConfig;
end;

function TDriver.Disconnect: Integer;
begin
  PollStop;
  Result := ClosePort;
end;

{ Формирование блока-значения }

function TDriver.EncodeValueBlock: Integer;
begin
  try
    CheckInt(BlockAddr, 0, $FF, 'BlockAddr');

    BlockData :=
      IntToBin(BlockValue, 4) +
      IntToBin(not BlockValue, 4) +
      IntToBin(BlockValue, 4) +
      Chr(BlockAddr) +
      Chr(not BlockAddr) +
      Chr(BlockAddr) +
      Chr(not BlockAddr);

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.DecodeValueBlock: Integer;
var
  V: Integer;
  i, j: Integer;
  CorrectValue: Boolean;
  BlockAddrs: array[0..3] of Byte;
  BlockValues: array[0..2] of Integer;
const
  DefaultBlockData =
  #$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF#$FF;
begin
  try
    IsValueBlockCorrupted := False;
    if Length(BlockData) < 16 then
      RaiseError(E_INVALID_DATA_LENGTH, S_INVALID_DATA_LENGTH);

    BlockValues[0] := BinToInt(BlockData, 1, 4);
    BlockValues[1] := not BinToInt(BlockData, 5, 4);
    BlockValues[2] := BinToInt(BlockData, 9, 4);
    BlockAddrs[0] := Ord(BlockData[13]);
    BlockAddrs[1] := not Ord(BlockData[14]);
    BlockAddrs[2] := Ord(BlockData[15]);
    BlockAddrs[3] := not Ord(BlockData[16]);
    // BlockValue
    CorrectValue := False;
    for i := 0 to 1 do
    begin
      V := BlockValues[i];
      for j := i + 1 to 2 do
      begin
        if V = BlockValues[j] then
        begin
          BlockValue := V;
          CorrectValue := True;
        end else
        begin
          CorruptedValueBlock;
        end;
      end;
    end;
    if not CorrectValue then
      RaiseError(E_BLOCKDATA, S_BLOCKDATA);

    // BlockAddr
    CorrectValue := False;
    for i := 0 to 2 do
    begin
      V := BlockAddrs[i];
      for j := i + 1 to 3 do
      begin
        if V = BlockAddrs[j] then
        begin
          BlockAddr := V;
          CorrectValue := True;
        end else
        begin
          CorruptedValueBlock;
        end;
      end;
    end;
    if not CorrectValue then
      RaiseError(E_BLOCKDATA, S_BLOCKDATA);

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

procedure TDriver.CorruptedValueBlock;
begin
  IsValueBlockCorrupted := True;
  if ErrorOnCorruptedValueBlock then
    RaiseError(E_VALUE_BLOCK_CORRUPTED, S_VALUE_BLOCK_CORRUPTED);
end;

function TDriver.FindDevice: Integer;
var
  i: Integer;
  StartPortNumber: Integer;
begin
  StartPortNumber := PortNumber;
  Result := PcdGetFwVersion;
  if Result = 0 then Exit;

  for i := 1 to MAX_PORT_NUMBER do
  begin
    if i <> StartPortNumber then
    begin
      PortNumber := i;
      Result := PcdGetFwVersion;
      if Result = 0 then Exit;
      Disconnect;
    end;
  end;
  PortNumber := StartPortNumber;
end;

function TDriver.GetUIDHex: string;
begin
  Result := BinToHex(UID, Length(UID));
end;

procedure TDriver.SetUIDHex(const Value: string);
begin
  UID := HexToStr(Value);
end;

function TDriver.GetBlockDataHex: string;
begin
  Result := StrToHex(BlockData);
end;

procedure TDriver.SetBlockDataHex(const Value: string);
begin
  BlockData := HexToStr(Value);
end;

{ Авторизация со стандартным ключом }

function TDriver.AuthStandard: Integer;
begin
  KeyNumber := 0;
  KeyType := ktKeyA;
  FKeyUncoded := KEY_STANDARD;
  Result := PcdLoadKeyE2;
  if Result <> SUCCESS then Exit;
  Result := PiccAuth;
end;

function TDriver.WriteTrailer(Address, C0, C1, C2, C3: Byte;
  const KeyA, KeyB: string): Integer;
var
  Byte6: Integer;
  Byte7: Integer;
  Byte8: Integer;
begin
  // Byte6
  Byte6 := 0;
  if not TestBit(C0, 0) then SetBit(Byte6, 0);
  if not TestBit(C1, 0) then SetBit(Byte6, 1);
  if not TestBit(C2, 0) then SetBit(Byte6, 2);
  if not TestBit(C3, 0) then SetBit(Byte6, 3);
  if not TestBit(C0, 1) then SetBit(Byte6, 4);
  if not TestBit(C1, 1) then SetBit(Byte6, 5);
  if not TestBit(C2, 1) then SetBit(Byte6, 6);
  if not TestBit(C3, 1) then SetBit(Byte6, 7);
  // Byte7
  Byte7 := 0;
  if not TestBit(C0, 2) then SetBit(Byte7, 0);
  if not TestBit(C1, 2) then SetBit(Byte7, 1);
  if not TestBit(C2, 2) then SetBit(Byte7, 2);
  if not TestBit(C3, 2) then SetBit(Byte7, 3);
  if TestBit(C0, 0) then SetBit(Byte7, 4);
  if TestBit(C1, 0) then SetBit(Byte7, 5);
  if TestBit(C2, 0) then SetBit(Byte7, 6);
  if TestBit(C3, 0) then SetBit(Byte7, 7);
  // Byte8
  Byte8 := 0;
  if TestBit(C0, 1) then SetBit(Byte8, 0);
  if TestBit(C1, 1) then SetBit(Byte8, 1);
  if TestBit(C2, 1) then SetBit(Byte8, 2);
  if TestBit(C3, 1) then SetBit(Byte8, 3);
  if TestBit(C0, 2) then SetBit(Byte8, 4);
  if TestBit(C1, 2) then SetBit(Byte8, 5);
  if TestBit(C2, 2) then SetBit(Byte8, 6);
  if TestBit(C3, 2) then SetBit(Byte8, 7);
  // Data
  BlockNumber := Address;
  BlockData := Add0(KeyA, 6) + Chr(Byte6) + Chr(Byte7) + Chr(Byte8) + #0 + Add0(KeyB, 6);
  Result := PiccWrite;
end;

function TDriver.WriteBlock(BlockNum: Integer; const Data: string): Integer;
begin
  BlockData := Data;
  BlockNumber := BlockNum;
  Result := PiccWrite;
end;

{ Перезапустить карту }

function TDriver.ResetCard: Integer;
begin
  RfResetTime := 10;
  Result := PcdRfReset;
  if Result <> SUCCESS then Exit;
  Result := PiccActivateWakeUp;
end;

{ Чтение каталога MikleSoft }

{ Запись каталога }

function TDriver.ClearBlock: Integer;
begin
  BlockData := '';
  Result := PiccWrite;
end;

procedure TDriver.FindFreeSector;
var
  i: Integer;
  Sector: TCardSector;
begin
  for i := 0 to Directory.Sectors.Count - 1 do
  begin
    Sector := Directory.Sectors[i];
    if Sector.IsFree then
    begin
      SectorNumber := Sector.Number;
      Exit;
    end;
  end;
  RaiseError(E_DIRECTORY_NOSECTOR, S_DIRECTORY_NOSECTOR);
end;

function TDriver.GetSectorParams: Integer;
var
  Sector: TCardSector;
begin
  try
    CheckInt(SectorIndex, 0, SectorCount - 1, 'SectorIndex');
    Sector := Directory.Sectors[SectorIndex];
    SectorNumber := Sector.Number;
    AppCode := Sector.AppCode;
    FirmCode := Sector.FirmCode;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SetSectorParams: Integer;
var
  Sector: TCardSector;
begin
  try
    CheckInt(SectorIndex, 0, SectorCount - 1, 'SectorIndex');
    Sector := Directory.Sectors[SectorIndex];
    SectorNumber := Sector.Number;
    Sector.AppCode := AppCode;
    Sector.FirmCode := FirmCode;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.GetSectorCount: Integer;
begin
  Result := Directory.Sectors.Count;
end;

function TDriver.GeTDirectoryStatus: TDirectoryStatus;
begin
  Result := Directory.Status;
end;

function TDriver.GeTDirectoryStatusText: string;
begin
  Result := Directory.StatusText;
end;

{ Очистка сектора по номеру }

function TDriver.DeleteSector: Integer;
begin
  Result := ClearResult;
end;

{ Очистка сектора по номеру }

procedure TDriver.FindAppBlock; { !!! }
var
  i: Integer;
begin
  for i := 0 to Directory.Sectors.Count-1 do
  begin
    //Sector := Directory.Sectors[i];
    //if Sector.
  end;
end;

{ Запись блока для приложения }

procedure TDriver.WriteAppBlock; { !!! }
begin
  FindAppBlock;
  PiccWrite;
end;

function TDriver.AddField: Integer;
var
  Field: TCardField;
begin
  try
    Field := Fields.Add;
    Field.Size := FieldSize;
    Field.Value := FieldValue;
    Field.FieldType := FieldType;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

procedure TDriver.ClearFields; { !!! }
begin
  Fields.Clear;
end;

procedure TDriver.CheckFieldIndex;
begin
  if (FieldIndex < 0)or(FieldIndex >= Fields.Count) then
    RaiseError(E_FIELD_INDEX, 'Неверный индекс поля');
end;

function TDriver.DeleteField: Integer;
begin
  try
    CheckFieldIndex;
    Fields[FieldIndex].Free;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.DeleteAllFields: Integer;
begin
  try
    Fields.Clear;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

procedure TDriver.SetCardType(Value: TCardType);
begin
  FCardType := Value;
end;

function TDriver.LoadFieldsFromFile: Integer;
begin
  try
    Fields.LoadFromFile(FileName);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SaveFieldsToFile: Integer;
begin
  try
    Fields.SaveToFile(FileName);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.GetFieldParams: Integer;
var
  Field: TCardField;
begin
  try
    CheckFieldIndex;
    Field := Fields[FieldIndex];
    FieldSize := Field.Size;
    FieldValue := Field.Value;
    FieldType := Field.FieldType;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SetFieldParams: Integer;
var
  Field: TCardField;
begin
  try
    CheckFieldIndex;
    Field := Fields[FieldIndex];
    Field.Size := FieldSize;
    Field.Value := FieldValue;
    Field.FieldType := FieldType;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.ClearFieldValues: Integer;
begin
  try
    Fields.ClearValues;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.GetFieldCount: Integer;
begin
  Result := Fields.Count;
end;

function TDriver.AuthByKeys(const Keys: array of string): Integer;
var
  i: Integer;
begin
  try
    DrvConnect;
    Result := 0;
    for i := Low(Keys) to High(Keys) do
    begin
      Result := AuthByKey(Keys[i]);
      if Result = 0 then Exit;
    end;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.AuthorizeByKeys2(const KeyA, KeyB: string): Integer;
begin
  KeyType := ktKeyA;
  Result := AuthByKeys([KeyA, KEY_STANDARD]);
  if Result <> 0 then
  begin
    KeyType := ktKeyB;
    Result := AuthByKeys([KeyB, KEY_STANDARD]);
  end;
end;


function TDriver.PollStart: Integer;
var
  Device: TMifareDevice;
begin
  try
    Device := Devices.ItemByPortNumber(PortNumber);
    if Device = nil then
      Device := Devices.Add(PortNumber);

    Device.Params := FParams;
    Device.OnCardFound := CardFoundEvent;
    Device.OnPollError := PollErrorEvent;
    Device.PollStart;

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PollStop: Integer;
var
  Device: TMifareDevice;
begin
  try
    Device := Devices.ItemByPortNumber(PortNumber);
    if Device <> nil then
    begin
      Device.PollStop;
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

procedure TDriver.CardFoundEvent(ASender: TObject; const Event: TCardFoundEventRec);
var
  DriverEvent: TDriverEventRec;
begin
  Logger.Debug('CardFoundEvent');
  if not FSendEvents then Exit;

  DriverEvent.DriverID := FID;
  DriverEvent.ErrorText := '';
  DriverEvent.EventType := EVENT_TYPE_CARD_FOUND;
  DriverEvent.ErrorCode := 0;
  DriverEvent.PortNumber := Event.PortNumber;
  DriverEvent.CardUIDHex := Event.CardUIDHex;

  FEvents.Lock;
  try
    FEvents.Add(DriverEvent);
  finally
    FEvents.Unlock;
  end;
  FSynchronizer.Synchronize(DeliverEvents);
end;

procedure TDriver.PollErrorEvent(ASender: TObject;
  const Event: TPollErrorEventRec);
var
  DriverEvent: TDriverEventRec;
begin
  Logger.Debug('DoPollError');
  if not FSendEvents then Exit;

  DriverEvent.DriverID := FID;
  DriverEvent.ErrorCode := Event.ErrorCode;
  DriverEvent.ErrorText := Event.ErrorText;
  DriverEvent.EventType := EVENT_TYPE_POLL_ERROR;
  DriverEvent.PortNumber := Event.PortNumber;
  DriverEvent.CardUIDHex := '';

  FEvents.Lock;
  try
    FEvents.Add(DriverEvent);
  finally
    FEvents.Unlock;
  end;
  FSynchronizer.Synchronize(DeliverEvents);
end;

function TDriver.AuthByKey(const KeyData: string): Integer;
begin
  try
    Result := PiccActivateWakeup;
    if Result <> 0 then Exit;

    FKeyUncoded := KeyData;
    Result := EncodeKey;
    if Result <> 0 then Exit;

    Result := PiccAuthKey;

  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

{ Авторизация к блоку BlockNumber с ключами KeyA или KeyB }

function TDriver.AuthorizeByKeys(const KeyA, KeyB: string): Integer;
begin
  KeyType := ktKeyA;
  Result := AuthByKey(KeyA);
  if Result = 0 then
  begin
    KeyType := ktKeyB;
    Result := AuthByKey(KeyB);
  end else
  begin
    KeyType := ktKeyA;
    Result := AuthByKey(KEY_STANDARD);
  end;
end;

// 000000000000 FF0780F0 FFFFFFFFFFFF - default
// 000000000000 78778800 484541444552 - 0x48 0x45 0x41 0x44 0x45 0x52
// 000000000000 78778800 434154414C2E - 0x43 0x41 0x54 0x41 0x4С 0x2E

// 0111 1000 0111 0111 1000 1000 0000 0000
// 1111 1111 0000 0111 1000 0000 1111 0000

function TDriver.LoadValue: Integer;
begin
  Result := PiccRead;
  if Result <> 0 then Exit;

  Result := DecodeValueBlock;
end;

function TDriver.GetDeviceType: TDeviceType;
begin
  Result := FParams.DeviceType;
end;

procedure TDriver.SetDeviceType(Value: TDeviceType);
begin
  FParams.DeviceType := Value;
end;

function TDriver.ShowConnectionProperties: Integer;
begin
  CardReader.ShowConnectionProperties(ParentWnd);
  Result := ClearResult;
end;

function TDriver.GetRxData: string;
begin
  Result := CardReader.RxData;
end;

function TDriver.GetRxDataHex: string;
begin
  Result := StrToHexText(CardReader.RxData);
end;

function TDriver.GetTxData: string;
begin
  Result := CardReader.TxData;
end;

function TDriver.GetTxDataHex: string;
begin
  Result := StrToHexText(CardReader.TxData);
end;

function TDriver.SleepMode: Integer;
begin
  try
    CardReader.SleepMode;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

procedure TDriver.AuthBlock;
begin
  if DataAuthMode = dmAuthByKey then
  begin
    Check(AuthorizeByKeys2(KeyABin, KeyBBin));
  end else
  begin
    Check(PiccAuth);
  end;
end;

function TDriver.GetKeyUncoded: string;
begin
  Result := BinToData(FKeyUncoded);
end;

procedure TDriver.SetKeyUncoded(const Value: string);
begin
  FKeyUncoded := DataToBin(Value);
end;

function TDriver.GetKeyEncoded: string;
begin
  Result := BinToData(FKeyEncoded);
end;

procedure TDriver.SetKeyEncoded(const Value: string);
begin
  FKeyEncoded := DataToBin(Value);
end;

function TDriver.GetKeyA: string;
begin
  Result := BinToData(FKeyA);
end;

function TDriver.GetKeyB: string;
begin
  Result := BinToData(FKeyB);
end;

procedure TDriver.SetKeyA(const Value: string);
begin
  FKeyA := DataToBin(Value);
end;

procedure TDriver.SetKeyB(const Value: string);
begin
  FKeyB := DataToBin(Value);
end;

function TDriver.GetNewKeyA: string;
begin
  Result := BinToData(FNewKeyA);
end;

function TDriver.GetNewKeyB: string;
begin
  Result := BinToData(FNewKeyB);
end;

procedure TDriver.SetNewKeyA(const Value: string);
begin
  FNewKeyA := DataToBin(Value);
end;

procedure TDriver.SetNewKeyB(const Value: string);
begin
  FNewKeyB := DataToBin(Value);
end;

function TDriver.GetLogEnabled: Boolean;
begin
  Result := Logger.Enabled;
end;

procedure TDriver.WriteLogHeader;
begin
  Logger.Debug('*************************************************************');
  Logger.Debug('       Драйвер считывателей Mifare, ШТРИХ-М, 2014');
  Logger.Debug('       Версия: ' + GetFileVersionInfoStr);
  Logger.Debug('*************************************************************');
end;

procedure TDriver.SetLogEnabled(const Value: Boolean);
begin
  if Value <> LogEnabled then
  begin
    Logger.Enabled := Value;
    if Value then WriteLogHeader;
  end;
end;

function TDriver.GetLogFilePath: string;
begin
  Result := Logger.FilePath;
end;

procedure TDriver.SetLogFilePath(const Value: string);
begin
  if Value <> LogFileName then
  begin
    Logger.FilePath := Value;
    WriteLogHeader;
  end;
end;

function TDriver.GetLogFileName: string;
begin
  Result := '';
end;

procedure TDriver.SetLogFileName(const Value: string);
begin
end;

function TDriver.PcdControlLEDAndPoll: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdControlLEDAndPoll(FRedLED, FGreenLED, FBlueLED, FYellowLed,
      FButtonState);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdControlLED: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdControlLED(FRedLED, FGreenLED, FBlueLED, FYellowLed);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.PcdPollButton: Integer;
begin
  try
    DrvConnect;
    CardReader.PcdPollButton(FButtonState);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.DeleteEvent: Integer;
begin
  try
    FEvents.Lock;
    try
      FEvents.ItemByID(FEventID).Free;
    finally
      FEvents.Unlock;
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.FindEvent: Integer;
var
  Event: TDriverEvent;
begin
  try
    FEvents.Lock;
    try
      Event := FEvents.ItemByID(FEventID);
      if Event <> nil then
      begin
        FEvent := Event.Data;
        Result := ClearResult;
      end else
      begin
        FResultCode := Integer(E_EVENT_NOT_FOUND);
        FResultDescription := 'Event not found';
        Result := FResultCode;
      end;
    finally
      FEvents.Unlock;
    end;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.Get_EventsEnabled: Boolean;
begin
  Result := FEventsEnabled;
end;

function TDriver.GetNotDeliveredEvent(var EventData: TDriverEventRec): Boolean;
var
  i: Integer;
  Event: TDriverEvent;
begin
  Result := False;
  FEvents.Lock;
  try
    for i := 0 to FEvents.Count-1 do
    begin
      Event := FEvents[i];
      Result := not Event.Delivered;
      if Result then
      begin
        Event.Delivered := True;
        EventData := Event.Data;
        EventData.ID := Event.ID;
        Break;
      end;
    end
  finally
    FEvents.Unlock;
  end;
end;

procedure TDriver.DeliverEvents;
var
  Event: TDriverEventRec;
begin
  if not FEventsEnabled then Exit;

  if GetNotDeliveredEvent(Event) then
  begin
    if Assigned(FOnEvent) then
      FOnEvent(Self, Event.ID);

    case Event.EventType of
      EVENT_TYPE_CARD_FOUND:
      begin
        if Assigned(FOnCard) then
          FOnCard(Self, Event.CardUIDHex);
      end;

      EVENT_TYPE_POLL_ERROR:
      begin
        if Assigned(FOnPollError) then
          FOnPollError(Self, Event.ErrorCode, Event.ErrorText);
      end;
    end;
  end;
end;

procedure TDriver.Set_EventsEnabled(Value: Boolean);
begin
  FEventsEnabled := Value;
  DeliverEvents;
end;

function TDriver.SendEvent: Integer;
var
  DriverEvent: TDriverEventRec;
begin
  UIDHex := '01020300405';
  DriverEvent.DriverID := FID;
  DriverEvent.ErrorText := '';
  DriverEvent.EventType := EVENT_TYPE_CARD_FOUND;
  DriverEvent.ErrorCode := 0;
  DriverEvent.PortNumber := PortNumber;
  DriverEvent.CardUIDHex := UIDHex;
  FEvents.Lock;
  try
    FEvents.Add(DriverEvent);
  finally
    FEvents.Unlock;
  end;
  DeliverEvents;
  Result := ClearResult;
end;

function TDriver.ClearEvents: Integer;
begin
  FEvents.Lock;
  try
    FEvents.Clear;
    Result := ClearResult;
  finally
    FEvents.Unlock;
  end;
end;

function TDriver.Get_EventCount: Integer;
begin
  FEvents.Lock;
  try
    Result := FEvents.Count;
  finally
    FEvents.Unlock;
  end;
end;

function TDriver.TestBit(AValue: Integer; ABitIndex: Integer): Boolean;
begin
  Result := untUtil.TestBit(AValue, ABitIndex);
end;

function TDriver.Get_Connected: Boolean;
begin
  Result := PortOpened = 0;
end;

function TDriver.Get_ErrorText: string;
begin
  Result := Format('(%d) %s', [ResultCode, ResultDescription]);
end;

function TDriver.GetPollStarted: Boolean;
var
  Device: TMifareDevice;
begin
  Result := False;
  Device := Devices.ItemByPortNumber(PortNumber);
  if Device <> nil then
    Result := Device.PollStarted;
end;

function TDriver.LockReader: Integer;
begin
  try
    CardReader.Lock;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.UnlockReader: Integer;
begin
  try
    CardReader.Unlock;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SAM_GetVersion: Integer;
begin
  try
    FSAMVersion := CardReader.SAM_GetVersion;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.GetSAMVersionData: string;
begin
  Result := FSAMVersion.Data;
end;

function TDriver.SAM_WriteKey: Integer;
var
  Data: TSAMKey;
begin
  try
    Data.KeyNumber := KeyNumber;
    Data.KeyPos := KeyPosition;
    Data.KeyVersion := KeyVersion;
    Data.KeyA := FKeyA;
    Data.KeyB := FKeyB;

    CardReader.SAM_WriteKey(Data);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SAM_AuthKey: Integer;
var
  Data: TSAMKeyInfo;
begin
  try
    Data.KeyType := KeyType;
    Data.KeyNumber := KeyNumber;
    Data.KeyVersion := KeyVersion;
    Data.BlockNumber := BlockNumber;

    CardReader.SAM_AuthKey(Data);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SAM_GetKeyEntry: Integer;
var
  Data: TSAMKeyEntry;
begin
  try
    Data := CardReader.SAM_GetKeyEntry(KeyEntryNumber);
    KeyType := Data.KeyType;
    KeyNumber := Data.KeyNumber;
    KeyVersion0 := Data.KeyVersion0;
    KeyVersion1 := Data.KeyVersion1;
    KeyVersion2 := Data.KeyVersion2;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SAM_WriteHostAuthKey: Integer;
begin
  try
    CardReader.SAM_WriteHostAuthKey(KeyUncoded);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.ReadFullSerialNumber: Integer;
begin
  try
    SerialNumber := CardReader.ReadFullSerialNumber;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SAM_SetProtection: Integer;
begin
  try
    CardReader.SAM_SetProtection;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SAM_SetProtectionSN: Integer;
begin
  try
    CardReader.SAM_SetProtectionSN(SerialNumber);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.GetSerialNumberHex: string;
begin
  Result := StrToHex(SerialNumber);
end;

procedure TDriver.SetSerialNumberHex(const Value: string);
begin
  try
    SerialNumber := HexToStr(Value);
  except
    { !!! }
  end;
end;

function TDriver.GetKeyTypeText: string;
begin
  Result := KeyTypeToStr(KeyType);
end;

function TDriver.GetParity: Integer;
begin
  Result := FParams.Parity;
end;

procedure TDriver.SetParity(const Value: Integer);
begin
  FParams.Parity := Value;
end;

function TDriver.GetTimeout: Integer;
begin
  Result := FParams.Timeout;
end;

procedure TDriver.SetTimeout(const Value: Integer);
begin
  FParams.Timeout := Value;
end;

function TDriver.GetPortNumber: Integer;
begin
  Result := FParams.PortNumber;
end;

procedure TDriver.SetPortNumber(const Value: Integer);
begin
  FParams.PortNumber := Value;
end;

function TDriver.GetPortBaudRate: Integer;
begin
  Result := FParams.BaudRate;
end;

procedure TDriver.SetPortBaudRate(const Value: Integer);
begin
  FParams.BaudRate := Value;
end;

function TDriver.GetBaudRate: TBaudRate;
begin
  Result := FParams.CardBaudRate;
end;

procedure TDriver.SetBaudRate(const Value: TBaudRate);
begin
  FParams.CardBaudRate := Value;
end;

function TDriver.GetReaderName: string;
begin
  Result := FParams.ReaderName;
end;

procedure TDriver.SetReaderName(const Value: string);
begin
  FParams.ReaderName := Value;
end;

function TDriver.GetPollInterval: Integer;
begin
  Result := FParams.PollInterval;
end;

procedure TDriver.SetPollInterval(const Value: Integer);
begin
  FParams.PollInterval := Value;
end;

function TDriver.GetPollAutoDisable: Boolean;
begin
  Result := FParams.PollAutoDisable;
end;

procedure TDriver.SetPollAutoDisable(const Value: Boolean);
begin
  FParams.PollAutoDisable := Value;
end;

function TDriver.WriteConnectionParams: Integer;
begin
  try
    CardReader.WriteConnectionParams(NewBaudRate);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.UltralightAuth: Integer;
begin
  try
    CardReader.UltralightAuth(KeyNumber, KeyVersion);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.UltralightCompatWrite: Integer;
begin
  try
    CardReader.UltralightCompatWrite(BlockNumber, BlockData);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.UltralightRead: Integer;
begin
  try
    BlockData := CardReader.UltralightRead(BlockNumber);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.UltralightWrite: Integer;
begin
  try
    CardReader.UltralightWrite(BlockNumber, BlockData);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.UltralightWriteKey: Integer;
begin
  try
    CardReader.UltralightWriteKey(KeyNumber, KeyPosition, KeyVersion, BlockData);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusCommitPerso: Integer;
begin
  try
    CardReader.MifarePlusCommitPerso;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusWriteParameters: Integer;
begin
  try
    CardReader.MifarePlusWriteParameters(ReceiveDivisor, SendDivisor);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusWritePerso: Integer;
begin
  try
    CardReader.MifarePlusWritePerso(BlockNumber, BlockData);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusAuthSL1: Integer;
var
  P: TMifarePlusAuth;
begin
  try
    P.AuthType := AuthType;
    P.Protocol := Protocol;
    P.BlockNumber := BlockNumber;
    P.KeyNumber := KeyNumber;
    P.KeyVersion := KeyVersion;
    CardReader.MifarePlusAuthSL1(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusAuthSL2: Integer;
var
  P: TMifarePlusAuth;
begin
  try
    P.AuthType := AuthType;
    P.Protocol := Protocol;
    P.BlockNumber := BlockNumber;
    P.KeyNumber := KeyNumber;
    P.KeyVersion := KeyVersion;
    CardReader.MifarePlusAuthSL2(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusAuthSL3: Integer;
var
  P: TMifarePlusAuth;
begin
  try
    P.AuthType := AuthType;
    P.Protocol := Protocol;
    P.BlockNumber := BlockNumber;
    P.KeyNumber := KeyNumber;
    P.KeyVersion := KeyVersion;
    CardReader.MifarePlusAuthSL3(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusDecrement: Integer;
var
  P: TMifarePlusDecrement;
begin
  try
    P.BlockNumber := BlockNumber;
    P.DeltaValue := DeltaValue;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusDecrement(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusDecrementTransfer: Integer;
var
  P: TMifarePlusDecrement;
begin
  try
    P.BlockNumber := BlockNumber;
    P.DeltaValue := DeltaValue;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusDecrementTransfer(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusIncrement: Integer;
var
  P: TMifarePlusIncrement;
begin
  try
    P.BlockNumber := BlockNumber;
    P.DeltaValue := DeltaValue;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusIncrement(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusIncrementTransfer: Integer;
var
  P: TMifarePlusIncrement;
begin
  try
    P.BlockNumber := BlockNumber;
    P.DeltaValue := DeltaValue;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusIncrementTransfer(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusMultiblockRead: Integer;
var
  P: TMifarePlusMultiblockRead;
begin
  try
    P.BlockNumber := BlockNumber;
    P.BlockCount := BlockCount;
    P.Encryption := EncryptionEnabled;
    P.AnswerSignature := AnswerSignature;
    P.CommandSignature := CommandSignature;
    BlockData := CardReader.MifarePlusMultiblockRead(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusMultiblockWrite: Integer;
var
  P: TMifarePlusMultiblockWrite;
begin
  try
    P.BlockNumber := BlockNumber;
    P.BlockCount := BlockCount;
    P.BlockData := BlockData;
    P.Encryption := EncryptionEnabled;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusMultiblockWrite(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusRead: Integer;
var
  P: TMifarePlusReadValue;
begin
  try
    P.BlockNumber := BlockNumber;
    P.Encryption := EncryptionEnabled;
    P.AnswerSignature := AnswerSignature;
    P.CommandSignature := CommandSignature;
    CardReader.MifarePlusRead(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusWrite: Integer;
var
  P: TMifarePlusWrite;
begin
  try
    P.BlockNumber := BlockNumber;
    P.BlockData := BlockData;
    P.Encryption := EncryptionEnabled;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusWrite(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusReadValue: Integer;
var
  P: TMifarePlusReadValue;
begin
  try
    P.BlockNumber := BlockNumber;
    P.Encryption := EncryptionEnabled;
    P.AnswerSignature := AnswerSignature;
    P.CommandSignature := CommandSignature;
    CardReader.MifarePlusReadValue(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusWriteValue: Integer;
var
  P: TMifarePlusWriteValue;
begin
  try
    P.BlockNumber := BlockNumber;
    P.BlockValue := BlockValue;
    P.Encryption := EncryptionEnabled;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusWriteValue(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusResetAuthentication: Integer;
begin
  try
    CardReader.MifarePlusResetAuthentication;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusRestore: Integer;
var
  P: TMifarePlusRestore;
begin
  try
    P.BlockNumber := BlockNumber;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusRestore(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusTransfer: Integer;
var
  P: TMifarePlusTransfer;
begin
  try
    P.BlockNumber := BlockNumber;
    P.AnswerSignature := AnswerSignature;
    CardReader.MifarePlusTransfer(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.GetSAMHWVendorID: Integer;
begin
  Result := SAMVersion.HardwareInfo.VendorID;
end;

function TDriver.GetSAMHWVendorName: string;
begin
  Result := SAMVersion.HardwareInfo.VendorName;
end;

function TDriver.GetSAMHWType: Integer;
begin
  Result := SAMVersion.HardwareInfo.RType;
end;

function TDriver.GetSAMHWSubType: Integer;
begin
  Result := SAMVersion.HardwareInfo.SubType;
end;

function TDriver.GetSAMHWMajorVersion: Integer;
begin
  Result := SAMVersion.HardwareInfo.MajorVersion;
end;

function TDriver.GetSAMHWMinorVersion: Integer;
begin
  Result := SAMVersion.HardwareInfo.MinorVersion;
end;

function TDriver.GetSAMHWProtocol: Integer;
begin
  Result := SAMVersion.HardwareInfo.Protocol;
end;

function TDriver.GetSAMHWStorageSize: Integer;
begin
  Result := SAMVersion.HardwareInfo.StorageSize;
end;

function TDriver.GetSAMHWStorageSizeCode: Integer;
begin
  Result := SAMVersion.HardwareInfo.StorageSizeCode;
end;

function TDriver.GetSAMSWMajorVersion: Integer;
begin
  Result := SAMVersion.SoftwareInfo.MajorVersion;
end;

function TDriver.GetSAMSWMinorVersion: Integer;
begin
  Result := SAMVersion.SoftwareInfo.MinorVersion;
end;

function TDriver.GetSAMSWProtocol: Integer;
begin
  Result := SAMVersion.SoftwareInfo.Protocol;
end;

function TDriver.GetSAMSWStorageSize: Integer;
begin
  Result := SAMVersion.SoftwareInfo.StorageSize;
end;

function TDriver.GetSAMSWStorageSizeCode: Integer;
begin
  Result := SAMVersion.SoftwareInfo.StorageSizeCode;
end;

function TDriver.GetSAMSWSubType: Integer;
begin
  Result := SAMVersion.SoftwareInfo.SubType;
end;

function TDriver.GetSAMSWType: Integer;
begin
  Result := SAMVersion.SoftwareInfo.RType;
end;

function TDriver.GetSAMSWVendorID: Integer;
begin
  Result := SAMVersion.SoftwareInfo.VendorID;
end;

function TDriver.GetSAMSWVendorName: string;
begin
  Result := SAMVersion.SoftwareInfo.VendorName;
end;

function TDriver.GetSAMMode: Integer;
begin
  Result := SAMVersion.Mode;
end;

function TDriver.GetSAMModeName: string;
begin
  Result := SAMVersion.ModeName;
end;

function TDriver.Get_SAMMDBatchNo: Integer;
begin
  Result := SAMVersion.ManufacturingData.BatchNo;
end;

function TDriver.Get_SAMMDGlobalCryptoSettings: Integer;
begin
  Result := SAMVersion.ManufacturingData.GlobalCryptoSettings;
end;

function TDriver.Get_SAMMDProductionDay: Integer;
begin
  Result := SAMVersion.ManufacturingData.ProductionDay;
end;

function TDriver.Get_SAMMDProductionMonth: Integer;
begin
  Result := SAMVersion.ManufacturingData.ProductionMonth;
end;

function TDriver.Get_SAMMDProductionYear: Integer;
begin
  Result := SAMVersion.ManufacturingData.ProductionYear;
end;

function TDriver.Get_SAMMDUID: Int64;
begin
  Result := SAMVersion.ManufacturingData.UID;
end;

function TDriver.Get_SAMMDUIDHex: WideString;
begin
  Result := SAMVersion.ManufacturingData.UIDHex;
end;

function TDriver.Get_SAMMDUIDStr: WideString;
begin
  Result := IntToStr(SAMVersion.ManufacturingData.UID);
end;

function TDriver.EnableCardAccept: Integer;
begin
  try
    CardReader.EnableCardAccept;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.DisableCardAccept: Integer;
begin
  try
    CardReader.DisableCardAccept;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.HoldCard: Integer;
begin
  try
    CardReader.HoldCard;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.IssueCard: Integer;
begin
  try
    CardReader.IssueCard;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.ReadLastAnswer: Integer;
begin
  try
    BlockData := CardReader.ReadLastAnswer;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.ReadStatus: Integer;
begin
  try
    CardReader.ReadStatus;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.SAMAV2WriteKey: Integer;
var
  P: TSAMAV2Key;
begin
  try
    P.KeyEntry := KeyEntryNumber;
    P.KeyPosition := KeyPosition;
    P.KeyVersion := KeyVersion;
    P.KeyData := BlockData;
    CardReader.SAMAV2WriteKey(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusMultiblockReadSL2: Integer;
var
  P: TMifarePlusMultiblockReadSL2;
begin
  try
    P.BlockNumber := BlockNumber;
    P.BlockCount := BlockCount;
    BlockData := CardReader.MifarePlusMultiblockReadSL2(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusMultiblockWriteSL2: Integer;
var
  P: TMifarePlusMultiblockWriteSL2;
begin
  try
    P.BlockNumber := BlockNumber;
    P.BlockCount := BlockCount;
    P.BlockData := BlockData;
    CardReader.MifarePlusMultiblockWriteSL2(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.MifarePlusAuthSL2Crypto1: Integer;
var
  P: TMifarePlusAuthSL2Crypto1;
begin
  try
    P.BlockNumber := BlockNumber;
    P.KeyType := KeyType;
    P.KeyNumber := KeyNumber;
    P.KeyVersion := KeyVersion;
    P.UID := UID;
    CardReader.MifarePlusAuthSL2Crypto1(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

(******************************************************************************

  Команда 26h "Запись зашифрованных AES128 ключом данных на карты"
  Записывает на карту блок данных, предварительно расшифровав его
  указанным AES ключом.

  Сообщение к считывателю
  Длина сообщения: 22 байт.
  №	Описание	Размер, байт
  1	Код команды: 26h	1
  2	Протокол, используемый для записи:
  0x00 - ISO14443-3 (для карт Mifare Classic)
  0x01 - ISO14443-4 (для карт Mifare Plus)	1
  3	Номер блока для записи	2
  4	Номер записи (Key Entry) с ключом AES для дешифрования блока	1
  5	Версия ключа	1
  6	Данные	16

  Ответ от считывателя
  Длина сообщения: 1 байт.
  №	Описание	Размер, байт
  1	Код ошибки	1

******************************************************************************)

function TDriver.WriteEncryptedData: Integer;
var
  P: TWriteEncryptedDataRec;
begin
  try
    P.Protocol := Protocol;
    P.BlockNumber := BlockNumber;
    P.KeyNumber := KeyNumber;
    P.KeyVersion := KeyVersion;
    P.BlockData := BlockData;
    CardReader.WriteEncryptedData(P);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TDriver.GetPollActivateMethod: TPollActivateMethod;
begin
  Result := FParams.PollActivateMethod;
end;

procedure TDriver.SetPollActivateMethod(const Value: TPollActivateMethod);
begin
  FParams.PollActivateMethod := Value;
end;

end.
