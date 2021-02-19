unit oleMain;

interface

uses
  // VCL
  Windows, ComObj, ActiveX, StdVcl, ComServ, AxCtrls, SysUtils, Variants,
  // This
  MifareLib_TLB, CardDriver, VersionInfo, fmuAbout, fmuPage,
  untConst, untError, fmuCatalog, fmuFirms, untUtil, fmuDeviceSearch,
  fmuTrailer, LogFile, untCtrl;

type
  { TMifareDrv }

  TMifareDrv = class(TActiveXControl, IMifareDrv, IMifareDrv1,
    IMIfareDrv2, IMIfareDrv3)
  private
    FID: Integer;
    FDriver: TCardDriver;
    FLockDevices: Boolean;
    FIsShowProperties: Boolean;
    FEvents: IMifareDrvEvents;
    function GetDriver: TCardDriver;
    function ClearResult: Integer; safecall;
    function HandleException(E: Exception): Integer;
    procedure LogMethodName(const MethodName: string);
    procedure LogMethodValue(const MethodName: string; Value: Variant);

    property Driver: TCardDriver read GetDriver;
  protected
    FIsClient1C: Boolean;
    procedure DriverOnEvent(Sender: TObject; EventID: Integer); virtual;
    procedure CardEvent(Sender: TObject; const CardUIDHex: WideString); virtual;
    procedure PollError(Sender: TObject; ErrorCode: Integer;
      const ErrorText: WideString); virtual;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_PollStarted: WordBool; safecall;
    function Get_PollInterval: Integer; safecall;
    procedure Set_PollInterval(Value: Integer); safecall;
    function Get_Data: WideString; safecall;
    procedure Set_Data(const Value: WideString); safecall;
    function Get_DataSize: Integer; safecall;
    procedure Set_DataSize(Value: Integer); safecall;
    function Get_DataMode: TDataMode; safecall;
    procedure Set_DataMode(Value: TDataMode); safecall;
    function ShowTrailerDlg: Integer; safecall;
    function Get_AccessMode0: Integer; safecall;
    procedure Set_AccessMode0(Value: Integer); safecall;
    function Get_AccessMode1: Integer; safecall;
    function Get_AccessMode2: Integer; safecall;
    function Get_AccessMode3: Integer; safecall;
    procedure Set_AccessMode1(Value: Integer); safecall;
    procedure Set_AccessMode2(Value: Integer); safecall;
    procedure Set_AccessMode3(Value: Integer); safecall;
    function DecodeTrailer: Integer; safecall;
    function EncodeTrailer: Integer; safecall;
    function ReadTrailer: Integer; safecall;
    function WriteTrailer: Integer; safecall;
    function Get_NewKeyA: WideString; safecall;
    function Get_NewKeyB: WideString; safecall;
    procedure Set_NewKeyA(const Value: WideString); safecall;
    procedure Set_NewKeyB(const Value: WideString); safecall;
    function Get_DeviceType: TDeviceType; safecall;
    procedure Set_DeviceType(Value: TDeviceType); safecall;
    function ShowConnectionPropertiesDlg: Integer; safecall;
    function Get_PortBaudRate: Integer; safecall;
    procedure Set_PortBaudRate(Value: Integer); safecall;
    function Get_Parity: Integer; safecall;
    procedure Set_Parity(Value: Integer); safecall;
    function MksFindCard: Integer; safecall;
    function MksReadCatalog: Integer; safecall;
    function MksReopen: Integer; safecall;
    function MksWriteCatalog: Integer; safecall;
    function Get_CardATQ: Integer; safecall;
    procedure Set_CardATQ(Value: Integer); safecall;
    function Get_ReaderName: WideString; safecall;
    procedure Set_ReaderName(const Value: WideString); safecall;
    function Get_DataAuthMode: TDataAuthMode; safecall;
    procedure Set_DataAuthMode(Value: TDataAuthMode); safecall;
    function Get_UpdateTrailer: WordBool; safecall;
    procedure Set_UpdateTrailer(Value: WordBool); safecall;
    function Get_DataFormat: TDataFormat; safecall;
    procedure Set_DataFormat(Value: TDataFormat); safecall;
    function Get_LogEnabled: WordBool; safecall;
    function Get_LogFileName: WideString; safecall;
    procedure Set_LogEnabled(Value: WordBool); safecall;
    procedure Set_LogFileName(const Value: WideString); safecall;
    function PcdControlLED: Integer; safecall;
    function PcdPollButton: Integer; safecall;
    function Get_DriverID: Integer; safecall;
    function LockReader: Integer; safecall;
    function UnlockReader: Integer; safecall;
    function Get_YellowLED: WordBool; safecall;
    procedure Set_YellowLED(Value: WordBool); safecall;
    function SAM_GetVersion: Integer; safecall;
    function Get_SAMVersion: TSAMVersion; safecall;
    function SAM_WriteKey: Integer; safecall;
    function SAM_AuthKey: Integer; safecall;
    function Get_ParamsRegKey: WideString; safecall;
    procedure Set_ParamsRegKey(const Value: WideString); safecall;
    function SAM_GetKeyEntry: Integer; safecall;
    function SAM_WriteHostAuthKey: Integer; safecall;
    function ReadFullSerialNumber: Integer; safecall;
    function SAM_SetProtection: Integer; safecall;
    function SAM_SetProtectionSN: Integer; safecall;
    function Get_KeyEntryNumber: Integer; safecall;
    procedure Set_KeyEntryNumber(Value: Integer); safecall;
    function Get_KeyVersion0: Integer; safecall;
    function Get_KeyVersion1: Integer; safecall;
    function Get_KeyVersion2: Integer; safecall;
    function Get_SerialNumber: WideString; safecall;
    function Get_SerialNumberHex: WideString; safecall;
    procedure Set_SerialNumber(const Value: WideString); safecall;
    procedure Set_SerialNumberHex(const Value: WideString); safecall;
    function Get_KeyTypeText: WideString; safecall;
    function UltralightRead: Integer; safecall;
    function UltralightAuth: Integer; safecall;
    function UltralightCompatWrite: Integer; safecall;
    function UltralightWrite: Integer; safecall;
    function UltralightWriteKey: Integer; safecall;
    function MifarePlusWritePerso: Integer; safecall;
    function MifarePlusWriteParameters: Integer; safecall;
    function MifarePlusCommitPerso: Integer; safecall;
    function Get_ReceiveDivisor: Integer; safecall;
    function Get_SendDivisor: Integer; safecall;
    procedure Set_ReceiveDivisor(Value: Integer); safecall;
    procedure Set_SendDivisor(Value: Integer); safecall;
    function Get_AuthType: Integer; safecall;
    procedure Set_AuthType(Value: Integer); safecall;
    function Get_BlockCount: Integer; safecall;
    procedure Set_BlockCount(Value: Integer); safecall;
    function MifarePlusWrite: Integer; safecall;
    function Get_NewBaudRate: Integer; safecall;
    procedure Set_NewBaudRate(Value: Integer); safecall;
    function Get_SAMHWVendorID: Integer; safecall;
    function Get_SAMHWVendorName: WideString; safecall;
    function Get_SAMHWType: Integer; safecall;
    function Get_SAMHWSubType: Integer; safecall;
    function Get_SAMHWMajorVersion: Integer; safecall;
    function Get_SAMHWMinorVersion: Integer; safecall;
    function Get_SAMHWProtocol: Integer; safecall;
    function Get_SAMHWStorageSize: Integer; safecall;
    function Get_SAMHWStorageSizeCode: Integer; safecall;
    function Get_SAMSWMajorVersion: Integer; safecall;
    function Get_SAMSWMinorVersion: Integer; safecall;
    function Get_SAMSWProtocol: Integer; safecall;
    function Get_SAMSWStorageSize: Integer; safecall;
    function Get_SAMSWStorageSizeCode: Integer; safecall;
    function Get_SAMSWSubType: Integer; safecall;
    function Get_SAMSWType: Integer; safecall;
    function Get_SAMSWVendorID: Integer; safecall;
    function Get_SAMSWVendorName: WideString; safecall;
    function Get_SAMMode: Integer; safecall;
    function Get_SAMModeName: WideString; safecall;
    function Get_SAMMDBatchNo: Integer; safecall;
    function Get_SAMMDGlobalCryptoSettings: Integer; safecall;
    function Get_SAMMDProductionDay: Integer; safecall;
    function Get_SAMMDProductionMonth: Integer; safecall;
    function Get_SAMMDProductionYear: Integer; safecall;
    function Get_SAMMDUID: Integer; safecall;
    function Get_SAMMDUIDHex: WideString; safecall;
    function Get_SAMMDUIDStr: WideString; safecall;
    function EnableCardAccept: Integer; safecall;
    function DisableCardAccept: Integer; safecall;
    function HoldCard: Integer; safecall;
    function IssueCard: Integer; safecall;
    function ReadLastAnswer: Integer; safecall;
    function ReadStatus: Integer; safecall;
    function Get_Protocol: Integer; safecall;
    procedure Set_Protocol(Value: Integer); safecall;
    function MifarePlusAuthSL2: Integer; safecall;
    function Get_AnswerSignature: WordBool; safecall;
    function Get_CommandSignature: WordBool; safecall;
    function Get_EncryptionEnabled: WordBool; safecall;
    procedure Set_AnswerSignature(Value: WordBool); safecall;
    procedure Set_CommandSignature(Value: WordBool); safecall;
    procedure Set_EncryptionEnabled(Value: WordBool); safecall;
  public
    procedure Initialize; override;
    procedure AboutBox; safecall;
    function SendEvent: Integer; safecall;
    function PollStart: Integer; safecall;
    function PollStop: Integer; safecall;
    function ClosePort: Integer; safecall;
    function Connect: Integer; safecall;
    function DecodeValueBlock: Integer; safecall;
    function Disconnect: Integer; safecall;
    function EncodeKey: Integer; safecall;
    function EncodeValueBlock: Integer; safecall;
    function InterfaceSetTimeout: Integer; safecall;
    function LoadParams: Integer; safecall;
    function OpenPort: Integer; safecall;
    function PcdBeep: Integer; safecall;
    function PcdConfig: Integer; safecall;
    function PcdGetFwVersion: Integer; safecall;
    function PcdGetRicVersion: Integer; safecall;
    function PcdGetSerialNumber: Integer; safecall;
    function PcdLoadKeyE2: Integer; safecall;
    function PcdReadE2: Integer; safecall;
    function PcdReset: Integer; safecall;
    function PcdRfReset: Integer; safecall;
    function PcdSetDefaultAttrib: Integer; safecall;
    function PcdSetTmo: Integer; safecall;
    function PcdWriteE2: Integer; safecall;
    function PiccActivateIdle: Integer; safecall;
    function PiccActivateWakeup: Integer; safecall;
    function PiccAnticoll: Integer; safecall;
    function PiccAuth: Integer; safecall;
    function PiccAuthE2: Integer; safecall;
    function PiccAuthKey: Integer; safecall;
    function PiccCascAnticoll: Integer; safecall;
    function PiccCascSelect: Integer; safecall;
    function PiccCommonRead: Integer; safecall;
    function PiccCommonRequest: Integer; safecall;
    function PiccCommonWrite: Integer; safecall;
    function PiccHalt: Integer; safecall;
    function PiccRead: Integer; safecall;
    function PiccSelect: Integer; safecall;
    function PiccValue: Integer; safecall;
    function PiccValueDebit: Integer; safecall;
    function PiccWrite: Integer; safecall;
    function PortOpened: Integer; safecall;
    function RequestAll: Integer; safecall;
    function RequestIdle: Integer; safecall;
    function SaveParams: Integer; safecall;
    function SetDefaults: Integer; safecall;
    function ShowProperties: Integer; safecall;
    function ShowSearchDlg: Integer; safecall;
    function StartTransTimer: Integer; safecall;
    function StopTransTimer: Integer; safecall;
    function Get_ATQ: Word; safecall;
    function Get_BaudRate: TBaudRate; safecall;
    procedure Set_BaudRate(Value: TBaudRate); safecall;
    function Get_BeepTone: Integer; safecall;
    procedure Set_BeepTone(Value: Integer); safecall;
    function Get_BitCount: Integer; safecall;
    procedure Set_BitCount(Value: Integer); safecall;
    function Get_BlockAddr: Integer; safecall;
    procedure Set_BlockAddr(Value: Integer); safecall;
    function Get_BlockData: WideString; safecall;
    procedure Set_BlockData(const Value: WideString); safecall;
    function Get_BlockDataHex: WideString; safecall;
    procedure Set_BlockDataHex(const Value: WideString); safecall;
    function Get_BlockNumber: Integer; safecall;
    procedure Set_BlockNumber(Value: Integer); safecall;
    function Get_BlockValue: Integer; safecall;
    procedure Set_BlockValue(Value: Integer); safecall;
    function Get_Command: TDataCommand; safecall;
    procedure Set_Command(Value: TDataCommand); safecall;
    function Get_Connected: WordBool; safecall;
    function Get_DataLength: Integer; safecall;
    procedure Set_DataLength(Value: Integer); safecall;
    function Get_ValueOperation: TValueOperation; safecall;
    procedure Set_ValueOperation(Value: TValueOperation); safecall;
    function Get_DeltaValue: Integer; safecall;
    procedure Set_DeltaValue(Value: Integer); safecall;
    function Get_ErrorText: WideString; safecall;
    function Get_ExecutionTime: Integer; safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const Value: WideString); safecall;
    function Get_IsClient1C: WordBool; safecall;
    function Get_IsShowProperties: WordBool; safecall;
    function Get_KeyEncoded: WideString; safecall;
    procedure Set_KeyEncoded(const Value: WideString); safecall;
    function Get_KeyNumber: Integer; safecall;
    procedure Set_KeyNumber(Value: Integer); safecall;
    function Get_KeyType: TKeyType; safecall;
    procedure Set_KeyType(Value: TKeyType); safecall;
    function Get_KeyUncoded: WideString; safecall;
    procedure Set_KeyUncoded(const Value: WideString); safecall;
    function Get_LibInfoKey: Integer; safecall;
    procedure Set_LibInfoKey(Value: Integer); safecall;
    function Get_LockDevices: WordBool; safecall;
    procedure Set_LockDevices(Value: WordBool); safecall;
    function Get_ParentWnd: Integer; safecall;
    procedure Set_ParentWnd(Value: Integer); safecall;
    function Get_PcdFwVersion: WideString; safecall;
    function Get_PcdRicVersion: WideString; safecall;
    function Get_PortNumber: Integer; safecall;
    procedure Set_PortNumber(Value: Integer); safecall;
    function Get_ReqCode: TReqCode; safecall;
    procedure Set_ReqCode(Value: TReqCode); safecall;
    function Get_ResultCode: Integer; safecall;
    function Get_ResultDescription: WideString; safecall;
    function Get_RfResetTime: Integer; safecall;
    procedure Set_RfResetTime(Value: Integer); safecall;
    function Get_RICValue: Integer; safecall;
    procedure Set_RICValue(Value: Integer); safecall;
    function Get_SAK: Byte; safecall;
    function Get_SelectCode: TSelectCode; safecall;
    procedure Set_SelectCode(Value: TSelectCode); safecall;
    function Get_Timeout: Integer; safecall;
    procedure Set_Timeout(Value: Integer); safecall;
    function Get_TransBlockNumber: Integer; safecall;
    procedure Set_TransBlockNumber(Value: Integer); safecall;
    function Get_TransTime: Integer; safecall;
    procedure Set_TransTime(Value: Integer); safecall;
    function Get_UID: WideString; safecall;
    procedure Set_UID(const Value: WideString); safecall;
    function Get_UIDHex: WideString; safecall;
    procedure Set_UIDHex(const Value: WideString); safecall;
    function Get_UIDLen: Byte; safecall;
    function Get_Version: WideString; safecall;
    function Get_CardType: TCardType; safecall;
    function Get_CardDescription: WideString; safecall;
    function FindDevice: Integer; safecall;
    function ReadDirectory: Integer; safecall;
    function AuthStandard: Integer; safecall;
    function ClearBlock: Integer; safecall;
    function Get_SectorCount: Integer; safecall;
    function Get_SectorIndex: Integer; safecall;
    procedure Set_SectorIndex(Value: Integer); safecall;
    function GetSectorParams: Integer; safecall;
    function SetSectorParams: Integer; safecall;
    function Get_AppCode: Integer; safecall;
    function Get_FirmCode: Integer; safecall;
    function Get_SectorNumber: Integer; safecall;
    procedure Set_AppCode(Value: Integer); safecall;
    procedure Set_FirmCode(Value: Integer); safecall;
    procedure Set_SectorNumber(Value: Integer); safecall;
    function WriteDirectory: Integer; safecall;
    function ShowDirectoryDlg: Integer; safecall;
    function Get_DirectoryStatus: TDirectoryStatus; safecall;
    function Get_DirectoryStatusText: WideString; safecall;
    function DeleteSector: Integer; safecall;
    function Get_PasswordHeader: WideString; safecall;
    function ShowFirmsDlg: Integer; safecall;
    function ResetCard: Integer; safecall;
    function AddField: Integer; safecall;
    function DeleteAllFields: Integer; safecall;
    function DeleteField: Integer; safecall;
    function Get_FieldIndex: Integer; safecall;
    function Get_FieldType: Integer; safecall;
    function Get_FieldValue: WideString; safecall;
    function LoadFieldsFromFile: Integer; safecall;
    function ReadFields: Integer; safecall;
    function SaveFieldsToFile: Integer; safecall;
    function WriteFields: Integer; safecall;
    procedure Set_FieldIndex(Value: Integer); safecall;
    procedure Set_FieldType(Value: Integer); safecall;
    procedure Set_FieldValue(const Value: WideString); safecall;
    function GetFieldParams: Integer; safecall;
    function SetFieldParams: Integer; safecall;
    function Get_FieldSize: Integer; safecall;
    procedure Set_FieldSize(Value: Integer); safecall;
    function ClearFieldValues: Integer; safecall;
    function Get_FieldCount: Integer; safecall;
    function Get_KeyA: WideString; safecall;
    function Get_KeyB: WideString; safecall;
    procedure Set_KeyA(const Value: WideString); safecall;
    procedure Set_KeyB(const Value: WideString); safecall;
    function  DeleteAppSectors: Integer; safecall;
    function  TestBit(AValue: Integer; ABitIndex: Integer): WordBool; safecall;
    function WriteData: Integer; safecall;
    function ReadData: Integer; safecall;
    function  LoadValue: Integer; safecall;
    // IMifareDrv1
    function Get_TxData: WideString; safecall;
    function Get_TxDataHex: WideString; safecall;
    function Get_RxData: WideString; safecall;
    function Get_RxDataHex: WideString; safecall;
    function SleepMode: Integer; safecall;
    function Get_PollAutoDisable: WordBool; safecall;
    procedure Set_PollAutoDisable(Value: WordBool); safecall;
    //
    function Get_RedLED: WordBool; safecall;
    procedure Set_RedLED(Value: WordBool); safecall;
    function Get_GreenLED: WordBool; safecall;
    procedure Set_GreenLED(Value: WordBool); safecall;
    function Get_BlueLED: WordBool; safecall;
    procedure Set_BlueLED(Value: WordBool); safecall;
    function Get_ButtonState: WordBool; safecall;
    function PcdControlLEDAndPoll: Integer; safecall;
    function Get_LogFilePath: WideString; safecall;
    procedure Set_LogFilePath(const Value: WideString); safecall;
  public
    // IMifareDrv3
    function Get_EventID: Integer; safecall;
    procedure Set_EventID(Value: Integer); safecall;
    function Get_EventDriverID: Integer; safecall;
    function Get_EventType: Integer; safecall;
    function Get_EventPortNumber: Integer; safecall;
    function Get_EventErrorCode: Integer; safecall;
    function Get_EventErrorText: WideString; safecall;
    function Get_EventCardUIDHex: WideString; safecall;
    function FindEvent: Integer; safecall;
    function DeleteEvent: Integer; safecall;
    function Get_EventsEnabled: WordBool; safecall;
    procedure Set_EventsEnabled(Value: WordBool); safecall;
    function ClearEvents: Integer; safecall;
    function Get_EventCount: Integer; safecall;
    function Get_KeyPosition: Integer; safecall;
    procedure Set_KeyPosition(Value: Integer); safecall;
    function Get_KeyVersion: Integer; safecall;
    procedure Set_KeyVersion(Value: Integer); safecall;
    function WriteConnectionParams: Integer; safecall;
    function Get_ErrorOnCorruptedValueBlock: WordBool; safecall;
    procedure Set_ErrorOnCorruptedValueBlock(Value: WordBool); safecall;
    function Get_IsValueBlockCorrupted: WordBool; safecall;
    // MIfarePlus
    function MifarePlusAuthSL1: Integer; safecall;
    function MifarePlusAuthSL3: Integer; safecall;
    function MifarePlusDecrement: Integer; safecall;
    function MifarePlusDecrementTransfer: Integer; safecall;
    function MifarePlusIncrement: Integer; safecall;
    function MifarePlusIncrementTransfer: Integer; safecall;
    function MifarePlusMultiblockRead: Integer; safecall;
    function MifarePlusMultiblockWrite: Integer; safecall;
    function MifarePlusRead: Integer; safecall;
    function MifarePlusReadValue: Integer; safecall;
    function MifarePlusResetAuthentication: Integer; safecall;
    function MifarePlusRestore: Integer; safecall;
    function MifarePlusTransfer: Integer; safecall;
    function MifarePlusWriteValue: Integer; safecall;
    function SAMAV2WriteKey: Integer; safecall;
    function MifarePlusMultiblockReadSL2: Integer; safecall;
    function MifarePlusMultiblockWriteSL2: Integer; safecall;
    function MifarePlusAuthSL2Crypto1: Integer; safecall;
    function WriteEncryptedData: Integer; safecall;

    function Get_PollActivateMethod: TPollActivateMethod; safecall;
    procedure Set_PollActivateMethod(Value: TPollActivateMethod); safecall;
  public
    destructor Destroy; override;
    procedure DefinePropertyPages(Proc: TDefinePropertyPage); override;
    function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HResult; override;
  end;

implementation

function VarToString(Value: Variant): string;
const
  BoolToStr: array [Boolean] of string = ('0', '1');
begin
  if VarType(Value) = varBoolean then
    Result := BoolToStr[Boolean(Value)]
  else
    Result := VarToStr(Value);
end;

{ TMifareDrv }

procedure TMifareDrv.Initialize;
const
  LastID: Integer = 0;
begin
  inherited Initialize;
  Inc(LastID); FID := LastID;
  Logger.Debug('TMifareDrv.Initialize, ID: ' + IntToStr(FID));
  GetDriver;
end;

destructor TMifareDrv.Destroy;
begin
  Logger.Debug('TMifareDrv.Destroy, ID: ' + IntToStr(FID));
  FDriver.Free;
  inherited Destroy;
end;

procedure TMifareDrv.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := nil;
  if EventSink <> nil then
    EventSink.QueryInterface(IMifareDrvEvents, FEvents);
end;

procedure TMifareDrv.DriverOnEvent(Sender: TObject; EventID: Integer);
begin
  Logger.Debug(Format('TMifareDrv.DriverOnEvent(%d)', [EventID]));
  if FEvents <> nil then
  begin
    FEvents.DriverEvent(EventID);
  end;
end;

procedure TMifareDrv.CardEvent(Sender: TObject; const CardUIDHex: WideString);
begin
  Logger.Debug(Format('TMifareDrv.CardEvent(%s)', [CardUIDHex]));

  if FEvents <> nil then
  begin
    FEvents.CardFound(CardUIDHex);
  end;
end;

procedure TMifareDrv.PollError(Sender: TObject; ErrorCode: Integer;
  const ErrorText: WideString);
begin
  Logger.Debug(Format('TMifareDrv.PollError(%d, %s)', [ErrorCode, ErrorText]));

  if FEvents <> nil then
  begin
    FEvents.PollError(ErrorCode, ErrorText);
  end;
end;

function TMifareDrv.ClearResult: Integer;
begin
  Result := Driver.ClearResult;
end;

procedure TMifareDrv.DefinePropertyPages(Proc: TDefinePropertyPage);
begin
  Proc(Class_fmPage);
end;

function TMifareDrv.HandleException(E: Exception): Integer;
begin
  Logger.Error('TMifareDrv.HandleException: ' + E.Message);
  Result := Driver.HandleException(E);
end;

function TMifareDrv.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HResult;
begin
  Logger.Debug('TMifareDrv.SafeCallException');

  Result := S_OK;
  if ExceptObject is Exception then
    HandleException(ExceptObject as Exception);
end;

function TMifareDrv.ShowProperties: Integer;

  procedure CoFreeMem(P: Pointer);
  begin
    if P <> nil then CoTaskMemFree(P);
  end;

var
  Unknown: IUnknown;
  Pages: TCAGUID;
begin
  FIsShowProperties := True;
  OleCheck(GetPages(Pages));
  try
    if Pages.cElems > 0 then
    begin
      Unknown := Self;
      OleCheck(OleCreatePropertyFrame(GetActiveWindow, 16, 16,
        nil,
        1, @Unknown, Pages.cElems, Pages.pElems,
        GetSystemDefaultLCID, 0, nil));
    end;
  finally
    FIsShowProperties := False;
    CoFreeMem(pages.pElems);
  end;
end;

function TMifareDrv.ShowSearchDlg: Integer;
begin
  try
    Disconnect;
    ShowFindDlg(Driver.ParentWnd, Self);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TMifareDrv.ShowDirectoryDlg: Integer;
begin
  try
    ShowDirectory(Driver.ParentWnd, Self);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TMifareDrv.ShowFirmsDlg: Integer;
begin
  try
    ShowFirmsDialog(Driver.ParentWnd, Driver);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TMifareDrv.ShowTrailerDlg: Integer;
begin
  try
    ShowTrailer(Driver.ParentWnd, Self);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TMifareDrv.ShowConnectionPropertiesDlg: Integer;
begin
  try
    Driver.ShowConnectionProperties;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

procedure TMifareDrv.AboutBox;
var
  DrvVer: string;
begin
  LogMethodName('AboutBox');

  DrvVer := 'Версия драйвера: ' + GetFileVersionInfoStr;
  ShowAboutBox(GetActiveWindow, S_DriverName, [DrvVer]);
end;

procedure TMifareDrv.LogMethodName(const MethodName: string);
begin
  Logger.Debug(Format('[%.4d] %s', [FID, MethodName]));
end;

procedure TMifareDrv.LogMethodValue(const MethodName: string; Value: Variant);
begin
  Logger.Debug(Format('[%.4d] %s: %s', [FID, MethodName, VarToString(Value)]));
end;

function TMifareDrv.GetDriver: TCardDriver;
begin
  if FDriver = nil then
  begin
    FDriver := TCardDriver.Create;
    FDriver.OnCard := CardEvent;
    FDriver.OnPollError := PollError;
    FDriver.OnEvent := DriverOnEvent;
  end;
  Result := FDriver;
end;

function TMifareDrv.AddField: Integer;
begin
  LogMethodName('AddField');
  Result := Driver.AddField;
  LogMethodValue('AddField', Result);
end;

function TMifareDrv.AuthStandard: Integer;
begin
  LogMethodName('AuthStandard');
  Result := Driver.AuthStandard;
  LogMethodValue('AuthStandard', Result);
end;

function TMifareDrv.ClearBlock: Integer;
begin
  LogMethodName('ClearBlock');
  Result := Driver.ClearBlock;
  LogMethodValue('ClearBlock', Result);
end;

function TMifareDrv.ClearFieldValues: Integer;
begin
  LogMethodName('ClearFieldValues');
  Result := Driver.ClearFieldValues;
  LogMethodValue('ClearFieldValues', Result);
end;

function TMifareDrv.ClosePort: Integer;
begin
  LogMethodName('ClosePort');
  Result := Driver.ClosePort;
  LogMethodValue('ClosePort', Result);
end;

function TMifareDrv.Connect: Integer;
begin
  LogMethodName('Connect');
  Result := Driver.Connect;
  LogMethodValue('Connect', Result);
end;

function TMifareDrv.DecodeTrailer: Integer;
begin
  LogMethodName('DecodeTrailer');
  Result := Driver.DecodeTrailer;
  LogMethodValue('DecodeTrailer', Result);
end;

function TMifareDrv.DecodeValueBlock: Integer;
begin
  LogMethodName('DecodeValueBlock');
  Result := Driver.DecodeValueBlock;
  LogMethodValue('DecodeValueBlock', Result);
end;

function TMifareDrv.DeleteAllFields: Integer;
begin
  LogMethodName('DeleteAllFields');
  Result := Driver.DeleteAllFields;
  LogMethodValue('DeleteAllFields', Result);
end;

function TMifareDrv.DeleteAppSectors: Integer;
begin
  LogMethodName('DeleteAppSectors');
  Result := Driver.DeleteAppSectors;
  LogMethodValue('DeleteAppSectors', Result);
end;

function TMifareDrv.DeleteField: Integer;
begin
  LogMethodName('DeleteField');
  Result := Driver.DeleteField;
  LogMethodValue('DeleteField', Result);
end;

function TMifareDrv.DeleteSector: Integer;
begin
  LogMethodName('DeleteSector');
  Result := Driver.DeleteSector;
  LogMethodValue('DeleteSector', Result);
end;

function TMifareDrv.Disconnect: Integer;
begin
  LogMethodName('Disconnect');
  Result := Driver.Disconnect;
  LogMethodValue('Disconnect', Result);
end;

function TMifareDrv.EncodeKey: Integer;
begin
  LogMethodName('EncodeKey');
  Result := Driver.EncodeKey;
  LogMethodValue('EncodeKey', Result);
end;

function TMifareDrv.EncodeTrailer: Integer;
begin
  LogMethodName('EncodeTrailer');
  Result := Driver.EncodeTrailer;
  LogMethodValue('EncodeTrailer', Result);
end;

function TMifareDrv.EncodeValueBlock: Integer;
begin
  LogMethodName('EncodeValueBlock');
  Result := Driver.EncodeValueBlock;
  LogMethodValue('EncodeValueBlock', Result);
end;

function TMifareDrv.FindDevice: Integer;
begin
  LogMethodName('FindDevice');
  Result := Driver.FindDevice;
  LogMethodValue('FindDevice', Result);
end;

function TMifareDrv.GetFieldParams: Integer;
begin
  LogMethodName('GetFieldParams');
  Result := Driver.GetFieldParams;
  LogMethodValue('GetFieldParams', Result);
end;

function TMifareDrv.GetSectorParams: Integer;
begin
  LogMethodName('GetSectorParams');
  Result := Driver.GetSectorParams;
  LogMethodValue('GetSectorParams', Result);
end;

function TMifareDrv.InterfaceSetTimeout: Integer;
begin
  LogMethodName('InterfaceSetTimeout');
  Result := Driver.InterfaceSetTimeout;
  LogMethodValue('InterfaceSetTimeout', Result);
end;

function TMifareDrv.LoadFieldsFromFile: Integer;
begin
  LogMethodName('LoadFieldsFromFile');
  Result := Driver.LoadFieldsFromFile;
  LogMethodValue('LoadFieldsFromFile', Result);
end;

function TMifareDrv.LoadParams: Integer;
begin
  LogMethodName('LoadParams');
  Result := Driver.LoadParams;
  LogMethodValue('LoadParams', Result);
end;

function TMifareDrv.LoadValue: Integer;
begin
  LogMethodName('LoadValue');
  Result := Driver.LoadValue;
  LogMethodValue('LoadValue', Result);
end;

function TMifareDrv.OpenPort: Integer;
begin
  LogMethodName('OpenPort');
  Result := Driver.OpenPort;
  LogMethodValue('OpenPort', Result);
end;

function TMifareDrv.PcdBeep: Integer;
begin
  LogMethodName('PcdBeep');
  Result := Driver.PcdBeep;
  LogMethodValue('PcdBeep', Result);
end;

function TMifareDrv.PcdConfig: Integer;
begin
  LogMethodName('PcdConfig');
  Result := Driver.PcdConfig;
  LogMethodValue('PcdConfig', Result);
end;

function TMifareDrv.PcdGetFwVersion: Integer;
begin
  LogMethodName('PcdGetFwVersion');
  Result := Driver.PcdGetFwVersion;
  LogMethodValue('PcdGetFwVersion', Result);
end;

function TMifareDrv.PcdGetRicVersion: Integer;
begin
  LogMethodName('PcdGetRicVersion');
  Result := Driver.PcdGetRicVersion;
  LogMethodValue('PcdGetRicVersion', Result);
end;

function TMifareDrv.PcdGetSerialNumber: Integer;
begin
  LogMethodName('PcdGetSerialNumber');
  Result := Driver.PcdGetSerialNumber;
  LogMethodValue('PcdGetSerialNumber', Result);
end;

function TMifareDrv.PcdLoadKeyE2: Integer;
begin
  LogMethodName('PcdLoadKeyE2');
  Result := Driver.PcdLoadKeyE2;
  LogMethodValue('PcdLoadKeyE2', Result);
end;

function TMifareDrv.PcdReadE2: Integer;
begin
  LogMethodName('PcdReadE2');
  Result := Driver.PcdReadE2;
  LogMethodValue('PcdReadE2', Result);
end;

function TMifareDrv.PcdReset: Integer;
begin
  LogMethodName('PcdReset');
  Result := Driver.PcdReset;
  LogMethodValue('PcdReset', Result);
end;

function TMifareDrv.PcdRfReset: Integer;
begin
  LogMethodName('PcdRfReset');
  Result := Driver.PcdRfReset;
  LogMethodValue('PcdRfReset', Result);
end;

function TMifareDrv.PcdSetDefaultAttrib: Integer;
begin
  LogMethodName('PcdSetDefaultAttrib');
  Result := Driver.PcdSetDefaultAttrib;
  LogMethodValue('PcdSetDefaultAttrib', Result);
end;

function TMifareDrv.PcdSetTmo: Integer;
begin
  LogMethodName('PcdSetTmo');
  Result := Driver.PcdSetTmo;
  LogMethodValue('PcdSetTmo', Result);
end;

function TMifareDrv.PcdWriteE2: Integer;
begin
  LogMethodName('PcdWriteE2');
  Result := Driver.PcdWriteE2;
  LogMethodValue('PcdWriteE2', Result);
end;

function TMifareDrv.PiccActivateIdle: Integer;
begin
  LogMethodName('PiccActivateIdle');
  Result := Driver.PiccActivateIdle;
  LogMethodValue('PiccActivateIdle', Result);
end;

function TMifareDrv.PiccActivateWakeup: Integer;
begin
  LogMethodName('PiccActivateWakeup');
  Result := Driver.PiccActivateWakeup;
  LogMethodValue('PiccActivateWakeup', Result);
end;

function TMifareDrv.PiccAnticoll: Integer;
begin
  LogMethodName('PiccAnticoll');
  Result := Driver.PiccAnticoll;
  LogMethodValue('PiccAnticoll', Result);
end;

function TMifareDrv.PiccAuth: Integer;
begin
  LogMethodName('PiccAuth');
  Result := Driver.PiccAuth;
  LogMethodValue('PiccAuth', Result);
end;

function TMifareDrv.PiccAuthE2: Integer;
begin
  LogMethodName('PiccAuthE2');
  Result := Driver.PiccAuthE2;
  LogMethodValue('PiccAuthE2', Result);
end;

function TMifareDrv.PiccAuthKey: Integer;
begin
  LogMethodName('PiccAuthKey');
  Result := Driver.PiccAuthKey;
  LogMethodValue('PiccAuthKey', Result);
end;

function TMifareDrv.PiccCascAnticoll: Integer;
begin
  LogMethodName('PiccCascAnticoll');
  Result := Driver.PiccCascAnticoll;
  LogMethodValue('PiccCascAnticoll', Result);
end;

function TMifareDrv.PiccCascSelect: Integer;
begin
  LogMethodName('PiccCascSelect');
  Result := Driver.PiccCascSelect;
  LogMethodValue('PiccCascSelect', Result);
end;

function TMifareDrv.PiccCommonRead: Integer;
begin
  LogMethodName('PiccCommonRead');
  Result := Driver.PiccCommonRead;
  LogMethodValue('PiccCommonRead', Result);
end;

function TMifareDrv.PiccCommonRequest: Integer;
begin
  LogMethodName('PiccCommonRequest');
  Result := Driver.PiccCommonRequest;
  LogMethodValue('PiccCommonRequest', Result);
end;

function TMifareDrv.PiccCommonWrite: Integer;
begin
  LogMethodName('PiccCommonWrite');
  Result := Driver.PiccCommonWrite;
  LogMethodValue('PiccCommonWrite', Result);
end;

function TMifareDrv.PiccHalt: Integer;
begin
  LogMethodName('PiccHalt');
  Result := Driver.PiccHalt;
  LogMethodValue('PiccHalt', Result);
end;

function TMifareDrv.PiccRead: Integer;
begin
  LogMethodName('PiccRead');
  Result := Driver.PiccRead;
  LogMethodValue('PiccRead', Result);
end;

function TMifareDrv.PiccSelect: Integer;
begin
  LogMethodName('PiccSelect');
  Result := Driver.PiccSelect;
  LogMethodValue('PiccSelect', Result);
end;

function TMifareDrv.PiccValue: Integer;
begin
  LogMethodName('PiccValue');
  Result := Driver.PiccValue;
  LogMethodValue('PiccValue', Result);
end;

function TMifareDrv.PiccValueDebit: Integer;
begin
  LogMethodName('PiccValueDebit');
  Result := Driver.PiccValueDebit;
  LogMethodValue('PiccValueDebit', Result);
end;

function TMifareDrv.PiccWrite: Integer;
begin
  LogMethodName('PiccWrite');
  Result := Driver.PiccWrite;
  LogMethodValue('PiccWrite', Result);
end;

function TMifareDrv.PollStart: Integer;
begin
  LogMethodName('PollStart');
  Result := Driver.PollStart;
  LogMethodValue('PollStart', Result);
end;

function TMifareDrv.PollStop: Integer;
begin
  LogMethodName('PollStop');
  Result := Driver.PollStop;
  LogMethodValue('PollStop', Result);
end;

function TMifareDrv.PortOpened: Integer;
begin
  LogMethodName('PortOpened');
  Result := Driver.PortOpened;
  LogMethodValue('PortOpened', Result);
end;

function TMifareDrv.ReadData: Integer;
begin
  LogMethodName('ReadData');
  Result := Driver.ReadData;
  LogMethodValue('ReadData', Result);
end;

function TMifareDrv.ReadDirectory: Integer;
begin
  LogMethodName('ReadDirectory');
  Result := Driver.ReadDirectory;
  LogMethodValue('ReadDirectory', Result);
end;

function TMifareDrv.ReadFields: Integer;
begin
  LogMethodName('ReadFields');
  Result := Driver.ReadFields;
  LogMethodValue('ReadFields', Result);
end;

function TMifareDrv.ReadTrailer: Integer;
begin
  LogMethodName('ReadTrailer');
  Result := Driver.ReadTrailer;
  LogMethodValue('ReadTrailer', Result);
end;

function TMifareDrv.RequestAll: Integer;
begin
  LogMethodName('RequestAll');
  Result := Driver.RequestAll;
  LogMethodValue('RequestAll', Result);
end;

function TMifareDrv.RequestIdle: Integer;
begin
  LogMethodName('RequestIdle');
  Result := Driver.RequestIdle;
  LogMethodValue('RequestIdle', Result);
end;

function TMifareDrv.ResetCard: Integer;
begin
  LogMethodName('ResetCard');
  Result := Driver.ResetCard;
  LogMethodValue('ResetCard', Result);
end;

function TMifareDrv.SaveFieldsToFile: Integer;
begin
  LogMethodName('SaveFieldsToFile');
  Result := Driver.SaveFieldsToFile;
  LogMethodValue('SaveFieldsToFile', Result);
end;

function TMifareDrv.SaveParams: Integer;
begin
  LogMethodName('SaveParams');
  Result := Driver.SaveParams;
  LogMethodValue('SaveParams', Result);
end;

function TMifareDrv.SendEvent: Integer;
begin
  LogMethodName('SendEvent');
  Result := Driver.SendEvent;
  LogMethodValue('SendEvent', Result);
end;

function TMifareDrv.SetDefaults: Integer;
begin
  LogMethodName('SetDefaults');
  Result := Driver.SetDefaults;
  LogMethodValue('SetDefaults', Result);
end;

function TMifareDrv.SetFieldParams: Integer;
begin
  LogMethodName('SetFieldParams');
  Result := Driver.SetFieldParams;
  LogMethodValue('SetFieldParams', Result);
end;

function TMifareDrv.SetSectorParams: Integer;
begin
  LogMethodName('SetSectorParams');
  Result := Driver.SetSectorParams;
  LogMethodValue('SetSectorParams', Result);
end;

function TMifareDrv.StartTransTimer: Integer;
begin
  LogMethodName('StartTransTimer');
  Result := Driver.StartTransTimer;
  LogMethodValue('StartTransTimer', Result);
end;

function TMifareDrv.StopTransTimer: Integer;
begin
  LogMethodName('StopTransTimer');
  Result := Driver.StopTransTimer;
  LogMethodValue('StopTransTimer', Result);
end;

function TMifareDrv.TestBit(AValue: Integer; ABitIndex: Integer): WordBool;
begin
  LogMethodName('TestBit');
  Result := Driver.TestBit(AValue, ABitIndex);
  LogMethodValue('TestBit', Result);
end;

function TMifareDrv.WriteData: Integer;
begin
  LogMethodName('WriteData');
  Result := Driver.WriteData;
  LogMethodValue('WriteData', Result);
end;

function TMifareDrv.WriteDirectory: Integer;
begin
  LogMethodName('WriteDirectory');
  Result := Driver.WriteDirectory;
  LogMethodValue('WriteDirectory', Result);
end;

function TMifareDrv.WriteFields: Integer;
begin
  LogMethodName('WriteFields');
  Result := Driver.WriteFields;
  LogMethodValue('WriteFields', Result);
end;

function TMifareDrv.WriteTrailer: Integer;
begin
  LogMethodName('WriteTrailer');
  Result := Driver.WriteTrailer;
  LogMethodValue('WriteTrailer', Result);
end;

function TMifareDrv.Get_AccessMode0: Integer;
begin
  LogMethodName('Get_AccessMode0');
  Result := Driver.AccessMode0;
  LogMethodValue('Get_AccessMode0', Result);
end;

procedure TMifareDrv.Set_AccessMode0(Value: Integer);
begin
  LogMethodName('Set_AccessMode0');
  Driver.AccessMode0 := Value;
  LogMethodValue('Set_AccessMode0', Value);
end;

function TMifareDrv.Get_AccessMode1: Integer;
begin
  LogMethodName('Get_AccessMode1');
  Result := Driver.AccessMode1;
  LogMethodValue('Get_AccessMode1', Result);
end;

procedure TMifareDrv.Set_AccessMode1(Value: Integer);
begin
  LogMethodName('Set_AccessMode1');
  Driver.AccessMode1 := Value;
  LogMethodValue('Set_AccessMode1', Value);
end;

function TMifareDrv.Get_AccessMode2: Integer;
begin
  LogMethodName('Get_AccessMode2');
  Result := Driver.AccessMode2;
  LogMethodValue('Get_AccessMode2', Result);
end;

procedure TMifareDrv.Set_AccessMode2(Value: Integer);
begin
  LogMethodName('Set_AccessMode2');
  Driver.AccessMode2 := Value;
  LogMethodValue('Set_AccessMode2', Value);
end;

function TMifareDrv.Get_AccessMode3: Integer;
begin
  LogMethodName('Get_AccessMode3');
  Result := Driver.AccessMode3;
  LogMethodValue('Get_AccessMode3', Result);
end;

procedure TMifareDrv.Set_AccessMode3(Value: Integer);
begin
  LogMethodName('Set_AccessMode3');
  Driver.AccessMode3 := Value;
  LogMethodValue('Set_AccessMode3', Value);
end;

function TMifareDrv.Get_AppCode: Integer;
begin
  LogMethodName('Get_AppCode');
  Result := Driver.AppCode;
  LogMethodValue('Get_AppCode', Result);
end;

procedure TMifareDrv.Set_AppCode(Value: Integer);
begin
  LogMethodName('Set_AppCode');
  Driver.AppCode := Value;
  LogMethodValue('Set_AppCode', Value);
end;

function TMifareDrv.Get_ATQ: Word;
begin
  LogMethodName('Get_ATQ');
  Result := Driver.ATQ;
  LogMethodValue('Get_ATQ', Result);
end;

function TMifareDrv.Get_BaudRate: TBaudRate;
begin
  LogMethodName('Get_BaudRate');
  Result := Driver.BaudRate;
  LogMethodValue('Get_BaudRate', Result);
end;

procedure TMifareDrv.Set_BaudRate(Value: TBaudRate);
begin
  LogMethodName('Set_BaudRate');
  Driver.BaudRate := Value;
  LogMethodValue('Set_BaudRate', Value);
end;

function TMifareDrv.Get_BeepTone: Integer;
begin
  LogMethodName('Get_BeepTone');
  Result := Driver.BeepTone;
  LogMethodValue('Get_BeepTone', Result);
end;

procedure TMifareDrv.Set_BeepTone(Value: Integer);
begin
  LogMethodName('Set_BeepTone');
  Driver.BeepTone := Value;
  LogMethodValue('Set_BeepTone', Value);
end;

function TMifareDrv.Get_BitCount: Integer;
begin
  LogMethodName('Get_BitCount');
  Result := Driver.BitCount;
  LogMethodValue('Get_BitCount', Result);
end;

procedure TMifareDrv.Set_BitCount(Value: Integer);
begin
  LogMethodName('Set_BitCount');
  Driver.BitCount := Value;
  LogMethodValue('Set_BitCount', Value);
end;

function TMifareDrv.Get_BlockAddr: Integer;
begin
  LogMethodName('Get_BlockAddr');
  Result := Driver.BlockAddr;
  LogMethodValue('Get_BlockAddr', Result);
end;

procedure TMifareDrv.Set_BlockAddr(Value: Integer);
begin
  LogMethodName('Set_BlockAddr');
  Driver.BlockAddr := Value;
  LogMethodValue('Set_BlockAddr', Value);
end;

function TMifareDrv.Get_BlockData: WideString;
begin
  LogMethodName('Get_BlockData');
  Result := Driver.BlockData;
  LogMethodValue('Get_BlockData', Result);
end;

procedure TMifareDrv.Set_BlockData(const Value: WideString);
begin
  LogMethodName('Set_BlockData');
  Driver.BlockData := Value;
  LogMethodValue('Set_BlockData', Value);
end;

function TMifareDrv.Get_BlockDataHex: WideString;
begin
  LogMethodName('Get_BlockDataHex');
  Result := Driver.BlockDataHex;
  LogMethodValue('Get_BlockDataHex', Result);
end;

procedure TMifareDrv.Set_BlockDataHex(const Value: WideString);
begin
  LogMethodName('Set_BlockDataHex');
  Driver.BlockDataHex := Value;
  LogMethodValue('Set_BlockDataHex', Value);
end;

function TMifareDrv.Get_BlockNumber: Integer;
begin
  LogMethodName('Get_BlockNumber');
  Result := Driver.BlockNumber;
  LogMethodValue('Get_BlockNumber', Result);
end;

procedure TMifareDrv.Set_BlockNumber(Value: Integer);
begin
  LogMethodName('Set_BlockNumber');
  Driver.BlockNumber := Value;
  LogMethodValue('Set_BlockNumber', Value);
end;

function TMifareDrv.Get_BlockValue: Integer;
begin
  LogMethodName('Get_BlockValue');
  Result := Driver.BlockValue;
  LogMethodValue('Get_BlockValue', Result);
end;

procedure TMifareDrv.Set_BlockValue(Value: Integer);
begin
  LogMethodName('Set_BlockValue');
  Driver.BlockValue := Value;
  LogMethodValue('Set_BlockValue', Value);
end;

function TMifareDrv.Get_CardDescription: WideString;
begin
  LogMethodName('Get_CardDescription');
  Result := Driver.CardDescription;
  LogMethodValue('Get_CardDescription', Result);
end;

function TMifareDrv.Get_CardType: TCardType;
begin
  LogMethodName('Get_CardType');
  Result := Driver.CardType;
  LogMethodValue('Get_CardType', Result);
end;

function TMifareDrv.Get_Command: TDataCommand;
begin
  LogMethodName('Get_Command');
  Result := Driver.Command;
  LogMethodValue('Get_Command', Result);
end;

procedure TMifareDrv.Set_Command(Value: TDataCommand);
begin
  LogMethodName('Set_Command');
  Driver.Command := Value;
  LogMethodValue('Set_Command', Value);
end;

function TMifareDrv.Get_Connected: WordBool;
begin
  LogMethodName('Get_Connected');
  Result := Driver.Connected;
  LogMethodValue('Get_Connected', Result);
end;

function TMifareDrv.Get_Data: WideString;
begin
  LogMethodName('Get_Data');
  Result := Driver.Data;
  LogMethodValue('Get_Data', Result);
end;

procedure TMifareDrv.Set_Data(const Value: WideString);
begin
  LogMethodName('Set_Data');
  Driver.Data := Value;
  LogMethodValue('Set_Data', Value);
end;

function TMifareDrv.Get_DataLength: Integer;
begin
  LogMethodName('Get_DataLength');
  Result := Driver.DataLength;
  LogMethodValue('Get_DataLength', Result);
end;

procedure TMifareDrv.Set_DataLength(Value: Integer);
begin
  LogMethodName('Set_DataLength');
  Driver.DataLength := Value;
  LogMethodValue('Set_DataLength', Value);
end;

function TMifareDrv.Get_DataMode: TDataMode;
begin
  LogMethodName('Get_DataMode');
  Result := Driver.DataMode;
  LogMethodValue('Get_DataMode', Result);
end;

procedure TMifareDrv.Set_DataMode(Value: TDataMode);
begin
  LogMethodName('Set_DataMode');
  Driver.DataMode := Value;
  LogMethodValue('Set_DataMode', Value);
end;

function TMifareDrv.Get_DataSize: Integer;
begin
  LogMethodName('Get_DataSize');
  Result := Driver.DataSize;
  LogMethodValue('Get_DataSize', Result);
end;

procedure TMifareDrv.Set_DataSize(Value: Integer);
begin
  LogMethodName('Set_DataSize');
  Driver.DataSize := Value;
  LogMethodValue('Set_DataSize', Value);
end;

function TMifareDrv.Get_DeltaValue: Integer;
begin
  LogMethodName('Get_DeltaValue');
  Result := Driver.DeltaValue;
  LogMethodValue('Get_DeltaValue', Result);
end;

procedure TMifareDrv.Set_DeltaValue(Value: Integer);
begin
  LogMethodName('Set_DeltaValue');
  Driver.DeltaValue := Value;
  LogMethodValue('Set_DeltaValue', Value);
end;

function TMifareDrv.Get_DirectoryStatus: TDirectoryStatus;
begin
  LogMethodName('Get_DirectoryStatus');
  Result := Driver.DirectoryStatus;
  LogMethodValue('Get_DirectoryStatus', Result);
end;

function TMifareDrv.Get_DirectoryStatusText: WideString;
begin
  LogMethodName('Get_DirectoryStatusText');
  Result := Driver.DirectoryStatusText;
  LogMethodValue('Get_DirectoryStatusText', Result);
end;

function TMifareDrv.Get_ErrorText: WideString;
begin
  LogMethodName('Get_ErrorText');
  Result := Driver.ErrorText;
  LogMethodValue('Get_ErrorText', Result);
end;

function TMifareDrv.Get_ExecutionTime: Integer;
begin
  LogMethodName('Get_ExecutionTime');
  Result := Driver.ExecutionTime;
  LogMethodValue('Get_ExecutionTime', Result);
end;

function TMifareDrv.Get_FieldCount: Integer;
begin
  LogMethodName('Get_FieldCount');
  Result := Driver.FieldCount;
  LogMethodValue('Get_FieldCount', Result);
end;

function TMifareDrv.Get_FieldIndex: Integer;
begin
  LogMethodName('Get_FieldIndex');
  Result := Driver.FieldIndex;
  LogMethodValue('Get_FieldIndex', Result);
end;

procedure TMifareDrv.Set_FieldIndex(Value: Integer);
begin
  LogMethodName('Set_FieldIndex');
  Driver.FieldIndex := Value;
  LogMethodValue('Set_FieldIndex', Value);
end;

function TMifareDrv.Get_FieldSize: Integer;
begin
  LogMethodName('Get_FieldSize');
  Result := Driver.FieldSize;
  LogMethodValue('Get_FieldSize', Result);
end;

procedure TMifareDrv.Set_FieldSize(Value: Integer);
begin
  LogMethodName('Set_FieldSize');
  Driver.FieldSize := Value;
  LogMethodValue('Set_FieldSize', Value);
end;

function TMifareDrv.Get_FieldType: Integer;
begin
  LogMethodName('Get_FieldType');
  Result := Driver.FieldType;
  LogMethodValue('Get_FieldType', Result);
end;

procedure TMifareDrv.Set_FieldType(Value: Integer);
begin
  LogMethodName('Set_FieldType');
  Driver.FieldType := Value;
  LogMethodValue('Set_FieldType', Value);
end;

function TMifareDrv.Get_FieldValue: WideString;
begin
  LogMethodName('Get_FieldValue');
  Result := Driver.FieldValue;
  LogMethodValue('Get_FieldValue', Result);
end;

procedure TMifareDrv.Set_FieldValue(const Value: WideString);
begin
  LogMethodName('Set_FieldValue');
  Driver.FieldValue := Value;
  LogMethodValue('Set_FieldValue', Value);
end;

function TMifareDrv.Get_FileName: WideString;
begin
  LogMethodName('Get_FileName');
  Result := Driver.FileName;
  LogMethodValue('Get_FileName', Result);
end;

procedure TMifareDrv.Set_FileName(const Value: WideString);
begin
  LogMethodName('Set_FileName');
  Driver.FileName := Value;
  LogMethodValue('Set_FileName', Value);
end;

function TMifareDrv.Get_FirmCode: Integer;
begin
  LogMethodName('Get_FirmCode');
  Result := Driver.FirmCode;
  LogMethodValue('Get_FirmCode', Result);
end;

procedure TMifareDrv.Set_FirmCode(Value: Integer);
begin
  LogMethodName('Set_FirmCode');
  Driver.FirmCode := Value;
  LogMethodValue('Set_FirmCode', Value);
end;

function TMifareDrv.Get_IsClient1C: WordBool;
begin
  LogMethodName('Get_IsClient1C');
  Result := FIsClient1C;
  LogMethodValue('Get_IsClient1C', Result);
end;

function TMifareDrv.Get_IsShowProperties: WordBool;
begin
  LogMethodName('Get_IsShowProperties');
  Result := FIsShowProperties;
  LogMethodValue('Get_IsShowProperties', Result);
end;

function TMifareDrv.Get_KeyA: WideString;
begin
  LogMethodName('Get_KeyA');
  Result := Driver.KeyA;
  LogMethodValue('Get_KeyA', Result);
end;

procedure TMifareDrv.Set_KeyA(const Value: WideString);
begin
  LogMethodName('Set_KeyA');
  Driver.KeyA := Value;
  LogMethodValue('Set_KeyA', Value);
end;

function TMifareDrv.Get_KeyB: WideString;
begin
  LogMethodName('Get_KeyB');
  Result := Driver.KeyB;
  LogMethodValue('Get_KeyB', Result);
end;

procedure TMifareDrv.Set_KeyB(const Value: WideString);
begin
  LogMethodName('Set_KeyB');
  Driver.KeyB := Value;
  LogMethodValue('Set_KeyB', Value);
end;

function TMifareDrv.Get_KeyEncoded: WideString;
begin
  LogMethodName('Get_KeyEncoded');
  Result := Driver.KeyEncoded;
  LogMethodValue('Get_KeyEncoded', Result);
end;

procedure TMifareDrv.Set_KeyEncoded(const Value: WideString);
begin
  LogMethodName('Set_KeyEncoded');
  Driver.KeyEncoded := Value;
  LogMethodValue('Set_KeyEncoded', Value);
end;

function TMifareDrv.Get_KeyNumber: Integer;
begin
  LogMethodName('Get_KeyNumber');
  Result := Driver.KeyNumber;
  LogMethodValue('Get_KeyNumber', Result);
end;

procedure TMifareDrv.Set_KeyNumber(Value: Integer);
begin
  LogMethodName('Set_KeyNumber');
  Driver.KeyNumber := Value;
  LogMethodValue('Set_KeyNumber', Value);
end;

function TMifareDrv.Get_KeyType: TKeyType;
begin
  LogMethodName('Get_KeyType');
  Result := Driver.KeyType;
  LogMethodValue('Get_KeyType', Result);
end;

procedure TMifareDrv.Set_KeyType(Value: TKeyType);
begin
  LogMethodName('Set_KeyType');
  Driver.KeyType := Value;
  LogMethodValue('Set_KeyType', Value);
end;

function TMifareDrv.Get_KeyUncoded: WideString;
begin
  LogMethodName('Get_KeyUncoded');
  Result := Driver.KeyUncoded;
  LogMethodValue('Get_KeyUncoded', Result);
end;

procedure TMifareDrv.Set_KeyUncoded(const Value: WideString);
begin
  LogMethodName('Set_KeyUncoded');
  Driver.KeyUncoded := Value;
  LogMethodValue('Set_KeyUncoded', Value);
end;

function TMifareDrv.Get_LibInfoKey: Integer;
begin
  LogMethodName('Get_LibInfoKey');
  Result := Driver.LibInfoKey;
  LogMethodValue('Get_LibInfoKey', Result);
end;

procedure TMifareDrv.Set_LibInfoKey(Value: Integer);
begin
  LogMethodName('Set_LibInfoKey');
  Driver.LibInfoKey := Value;
  LogMethodValue('Set_LibInfoKey', Value);
end;

function TMifareDrv.Get_LockDevices: WordBool;
begin
  LogMethodName('Get_LockDevices');
  Result := FLockDevices;
  LogMethodValue('Get_LockDevices', Result);
end;

procedure TMifareDrv.Set_LockDevices(Value: WordBool);
begin
  LogMethodName('Set_LockDevices');
  FLockDevices := Value;
  LogMethodValue('Set_LockDevices', Value);
end;

function TMifareDrv.Get_NewKeyA: WideString;
begin
  LogMethodName('Get_NewKeyA');
  Result := Driver.NewKeyA;
  LogMethodValue('Get_NewKeyA', Result);
end;

procedure TMifareDrv.Set_NewKeyA(const Value: WideString);
begin
  LogMethodName('Set_NewKeyA');
  Driver.NewKeyA := Value;
  LogMethodValue('Set_NewKeyA', Value);
end;

function TMifareDrv.Get_NewKeyB: WideString;
begin
  LogMethodName('Get_NewKeyB');
  Result := Driver.NewKeyB;
  LogMethodValue('Get_NewKeyB', Result);
end;

procedure TMifareDrv.Set_NewKeyB(const Value: WideString);
begin
  LogMethodName('Set_NewKeyB');
  Driver.NewKeyB := Value;
  LogMethodValue('Set_NewKeyB', Value);
end;

function TMifareDrv.Get_ParentWnd: Integer;
begin
  LogMethodName('Get_ParentWnd');
  Result := Driver.ParentWnd;
  LogMethodValue('Get_ParentWnd', Result);
end;

procedure TMifareDrv.Set_ParentWnd(Value: Integer);
begin
  LogMethodName('Set_ParentWnd');
  Driver.ParentWnd := Value;
  LogMethodValue('Set_ParentWnd', Value);
end;

function TMifareDrv.Get_PasswordHeader: WideString;
begin
  LogMethodName('Get_PasswordHeader');
  Result := Driver.PasswordHeader;
  LogMethodValue('Get_PasswordHeader', Result);
end;

function TMifareDrv.Get_PcdFwVersion: WideString;
begin
  LogMethodName('Get_PcdFwVersion');
  Result := Driver.PcdFwVersion;
  LogMethodValue('Get_PcdFwVersion', Result);
end;

function TMifareDrv.Get_PcdRicVersion: WideString;
begin
  LogMethodName('Get_PcdRicVersion');
  Result := Driver.PcdRicVersion;
  LogMethodValue('Get_PcdRicVersion', Result);
end;

function TMifareDrv.Get_PollInterval: Integer;
begin
  LogMethodName('Get_PollInterval');
  Result := Driver.PollInterval;
  LogMethodValue('Get_PollInterval', Result);
end;

procedure TMifareDrv.Set_PollInterval(Value: Integer);
begin
  LogMethodName('Set_PollInterval');
  Driver.PollInterval := Value;
  LogMethodValue('Set_PollInterval', Value);
end;

function TMifareDrv.Get_PollStarted: WordBool;
begin
  LogMethodName('Get_PollStarted');
  Result := Driver.PollStarted;
  LogMethodValue('Get_PollStarted', Result);
end;

function TMifareDrv.Get_PortNumber: Integer;
begin
  LogMethodName('Get_PortNumber');
  Result := Driver.PortNumber;
  LogMethodValue('Get_PortNumber', Result);
end;

procedure TMifareDrv.Set_PortNumber(Value: Integer);
begin
  LogMethodName('Set_PortNumber');
  Driver.PortNumber := Value;
  LogMethodValue('Set_PortNumber', Value);
end;

function TMifareDrv.Get_ReqCode: TReqCode;
begin
  LogMethodName('Get_ReqCode');
  Result := Driver.ReqCode;
  LogMethodValue('Get_ReqCode', Result);
end;

procedure TMifareDrv.Set_ReqCode(Value: TReqCode);
begin
  LogMethodName('Set_ReqCode');
  Driver.ReqCode := Value;
  LogMethodValue('Set_ReqCode', Value);
end;

function TMifareDrv.Get_ResultCode: Integer;
begin
  LogMethodName('Get_ResultCode');
  Result := Driver.ResultCode;
  LogMethodValue('Get_ResultCode', Result);
end;

function TMifareDrv.Get_ResultDescription: WideString;
begin
  LogMethodName('Get_ResultDescription');
  Result := Driver.ResultDescription;
  LogMethodValue('Get_ResultDescription', Result);
end;

function TMifareDrv.Get_RfResetTime: Integer;
begin
  LogMethodName('Get_RfResetTime');
  Result := Driver.RfResetTime;
  LogMethodValue('Get_RfResetTime', Result);
end;

procedure TMifareDrv.Set_RfResetTime(Value: Integer);
begin
  LogMethodName('Set_RfResetTime');
  Driver.RfResetTime := Value;
  LogMethodValue('Set_RfResetTime', Value);
end;

function TMifareDrv.Get_RICValue: Integer;
begin
  LogMethodName('Get_RICValue');
  Result := Driver.RICValue;
  LogMethodValue('Get_RICValue', Result);
end;

procedure TMifareDrv.Set_RICValue(Value: Integer);
begin
  LogMethodName('Set_RICValue');
  Driver.RICValue := Value;
  LogMethodValue('Set_RICValue', Value);
end;

function TMifareDrv.Get_SAK: Byte;
begin
  LogMethodName('Get_SAK');
  Result := Driver.SAK;
  LogMethodValue('Get_SAK', Result);
end;

function TMifareDrv.Get_SectorCount: Integer;
begin
  LogMethodName('Get_SectorCount');
  Result := Driver.SectorCount;
  LogMethodValue('Get_SectorCount', Result);
end;

function TMifareDrv.Get_SectorIndex: Integer;
begin
  LogMethodName('Get_SectorIndex');
  Result := Driver.SectorIndex;
  LogMethodValue('Get_SectorIndex', Result);
end;

procedure TMifareDrv.Set_SectorIndex(Value: Integer);
begin
  LogMethodName('Set_SectorIndex');
  Driver.SectorIndex := Value;
  LogMethodValue('Set_SectorIndex', Value);
end;

function TMifareDrv.Get_SectorNumber: Integer;
begin
  LogMethodName('Get_SectorNumber');
  Result := Driver.SectorNumber;
  LogMethodValue('Get_SectorNumber', Result);
end;

procedure TMifareDrv.Set_SectorNumber(Value: Integer);
begin
  LogMethodName('Set_SectorNumber');
  Driver.SectorNumber := Value;
  LogMethodValue('Set_SectorNumber', Value);
end;

function TMifareDrv.Get_SelectCode: TSelectCode;
begin
  LogMethodName('Get_SelectCode');
  Result := Driver.SelectCode;
  LogMethodValue('Get_SelectCode', Result);
end;

procedure TMifareDrv.Set_SelectCode(Value: TSelectCode);
begin
  LogMethodName('Set_SelectCode');
  Driver.SelectCode := Value;
  LogMethodValue('Set_SelectCode', Value);
end;

function TMifareDrv.Get_Timeout: Integer;
begin
  LogMethodName('Get_Timeout');
  Result := Driver.Timeout;
  LogMethodValue('Get_Timeout', Result);
end;

procedure TMifareDrv.Set_Timeout(Value: Integer);
begin
  LogMethodName('Set_Timeout');
  Driver.Timeout := Value;
  LogMethodValue('Set_Timeout', Value);
end;

function TMifareDrv.Get_TransBlockNumber: Integer;
begin
  LogMethodName('Get_TransBlockNumber');
  Result := Driver.TransBlockNumber;
  LogMethodValue('Get_TransBlockNumber', Result);
end;

procedure TMifareDrv.Set_TransBlockNumber(Value: Integer);
begin
  LogMethodName('Set_TransBlockNumber');
  Driver.TransBlockNumber := Value;
  LogMethodValue('Set_TransBlockNumber', Value);
end;

function TMifareDrv.Get_TransTime: Integer;
begin
  LogMethodName('Get_TransTime');
  Result := Driver.TransTime;
  LogMethodValue('Get_TransTime', Result);
end;

procedure TMifareDrv.Set_TransTime(Value: Integer);
begin
  LogMethodName('Set_TransTime');
  Driver.TransTime := Value;
  LogMethodValue('Set_TransTime', Value);
end;

function TMifareDrv.Get_UID: WideString;
begin
  LogMethodName('Get_UID');
  Result := Driver.UID;
  LogMethodValue('Get_UID', Result);
end;

procedure TMifareDrv.Set_UID(const Value: WideString);
begin
  LogMethodName('Set_UID');
  Driver.UID := Value;
  LogMethodValue('Set_UID', Value);
end;

function TMifareDrv.Get_UIDHex: WideString;
begin
  LogMethodName('Get_UIDHex');
  Result := Driver.UIDHex;
  LogMethodValue('Get_UIDHex', Result);
end;

procedure TMifareDrv.Set_UIDHex(const Value: WideString);
begin
  LogMethodName('Set_UIDHex');
  Driver.UIDHex := Value;
  LogMethodValue('Set_UIDHex', Value);
end;

function TMifareDrv.Get_UIDLen: Byte;
begin
  LogMethodName('Get_UIDLen');
  Result := Driver.UIDLen;
  LogMethodValue('Get_UIDLen', Result);
end;

function TMifareDrv.Get_ValueOperation: TValueOperation;
begin
  LogMethodName('Get_ValueOperation');
  Result := Driver.ValueOperation;
  LogMethodValue('Get_ValueOperation', Result);
end;

procedure TMifareDrv.Set_ValueOperation(Value: TValueOperation);
begin
  LogMethodName('Set_ValueOperation');
  Driver.ValueOperation := Value;
  LogMethodValue('Set_ValueOperation', Value);
end;

function TMifareDrv.Get_Version: WideString;
begin
  LogMethodName('Get_Version');
  Result := GetFileVersionInfoStr;
  LogMethodValue('Get_Version', Result);
end;

// IMifareDrv1

function TMifareDrv.MksFindCard: Integer;
begin
  LogMethodName('MksFindCard');
  Result := Driver.MksFindCard;
  LogMethodValue('MksFindCard', Result);
end;

function TMifareDrv.MksReadCatalog: Integer;
begin
  LogMethodName('MksReadCatalog');
  Result := Driver.MksReadCatalog;
  LogMethodValue('MksReadCatalog', Result);
end;

function TMifareDrv.MksReopen: Integer;
begin
  LogMethodName('MksReopen');
  Result := Driver.MksReopen;
  LogMethodValue('MksReopen', Result);
end;

function TMifareDrv.MksWriteCatalog: Integer;
begin
  LogMethodName('MksWriteCatalog');
  Result := Driver.MksWriteCatalog;
  LogMethodValue('MksWriteCatalog', Result);
end;

function TMifareDrv.Get_CardATQ: Integer;
begin
  LogMethodName('Get_CardATQ');
  Result := Driver.CardATQ;
  LogMethodValue('Get_CardATQ', Result);
end;

procedure TMifareDrv.Set_CardATQ(Value: Integer);
begin
  LogMethodName('Set_CardATQ');
  Driver.CardATQ := Value;
  LogMethodValue('Set_CardATQ', Value);
end;

function TMifareDrv.Get_DeviceType: TDeviceType;
begin
  LogMethodName('Get_DeviceType');
  Result := Driver.DeviceType;
  LogMethodValue('Get_DeviceType', Result);
end;

procedure TMifareDrv.Set_DeviceType(Value: TDeviceType);
begin
  LogMethodName('Set_DeviceType');
  Driver.DeviceType := Value;
  LogMethodValue('Set_DeviceType', Value);
end;

function TMifareDrv.Get_Parity: Integer;
begin
  LogMethodName('Get_Parity');
  Result := Driver.Parity;
  LogMethodValue('Get_Parity', Result);
end;

procedure TMifareDrv.Set_Parity(Value: Integer);
begin
  LogMethodName('Set_Parity');
  Driver.Parity := Value;
  LogMethodValue('Set_Parity', Value);
end;

function TMifareDrv.Get_PortBaudRate: Integer;
begin
  LogMethodName('Get_PortBaudRate');
  Result := Driver.PortBaudRate;
  LogMethodValue('Get_PortBaudRate', Result);
end;

procedure TMifareDrv.Set_PortBaudRate(Value: Integer);
begin
  LogMethodName('Set_PortBaudRate');
  Driver.PortBaudRate := Value;
  LogMethodValue('Set_PortBaudRate', Value);
end;

function TMifareDrv.Get_RxData: WideString;
begin
  LogMethodName('Get_RxData');
  Result := Driver.RxData;
  LogMethodValue('Get_RxData', Result);
end;

function TMifareDrv.Get_RxDataHex: WideString;
begin
  LogMethodName('Get_RxDataHex');
  Result := Driver.RxDataHex;
  LogMethodValue('Get_RxDataHex', Result);
end;

function TMifareDrv.Get_TxData: WideString;
begin
  LogMethodName('Get_TxData');
  Result := Driver.TxData;
  LogMethodValue('Get_TxData', Result);
end;

function TMifareDrv.Get_TxDataHex: WideString;
begin
  LogMethodName('Get_TxDataHex');
  Result := Driver.TxDataHex;
  LogMethodValue('Get_TxDataHex', Result);
end;

function TMifareDrv.SleepMode: Integer;
begin
  LogMethodName('SleepMode');
  Result := Driver.SleepMode;
  LogMethodValue('SleepMode', Result);
end;

function TMifareDrv.Get_PollAutoDisable: WordBool;
begin
  LogMethodName('Get_PollAutoDisable');
  Result := Driver.PollAutoDisable;
  LogMethodValue('Get_PollAutoDisable', Result);
end;

procedure TMifareDrv.Set_PollAutoDisable(Value: WordBool);
begin
  LogMethodName('Set_PollAutoDisable');
  Driver.PollAutoDisable := Value;
  LogMethodValue('Set_PollAutoDisable', Value);
end;

// IMIfareDrv2

function TMifareDrv.Get_ReaderName: WideString;
begin
  LogMethodName('Get_ReaderName');
  Result := Driver.ReaderName;
  LogMethodValue('Get_ReaderName', Result);
end;

procedure TMifareDrv.Set_ReaderName(const Value: WideString);
begin
  LogMethodName('Set_ReaderName');
  Driver.ReaderName := Value;
  LogMethodValue('Set_ReaderName', Value);
end;

function TMifareDrv.Get_DataAuthMode: TDataAuthMode;
begin
  LogMethodName('Get_DataAuthMode');
  Result := Driver.DataAuthMode;
  LogMethodValue('Get_DataAuthMode', Result);
end;

procedure TMifareDrv.Set_DataAuthMode(Value: TDataAuthMode);
begin
  LogMethodName('Set_DataAuthMode');
  Driver.DataAuthMode := Value;
  LogMethodValue('Set_DataAuthMode', Value);
end;

function TMifareDrv.Get_UpdateTrailer: WordBool;
begin
  LogMethodName('Get_UpdateTrailer');
  Result := Driver.UpdateTrailer;
  LogMethodValue('Get_UpdateTrailer', Result);
end;

procedure TMifareDrv.Set_UpdateTrailer(Value: WordBool);
begin
  LogMethodName('Set_UpdateTrailer');
  Driver.UpdateTrailer := Value;
  LogMethodValue('Set_UpdateTrailer', Value);
end;

function TMifareDrv.Get_DataFormat: TDataFormat;
begin
  LogMethodName('Get_DataFormat');
  Result := Driver.DataFormat;
  LogMethodValue('Get_DataFormat', Result);
end;

procedure TMifareDrv.Set_DataFormat(Value: TDataFormat);
begin
  LogMethodName('Set_DataFormat');
  Driver.DataFormat := Value;
  LogMethodValue('Set_DataFormat', Value);
end;

function TMifareDrv.Get_LogEnabled: WordBool;
begin
  LogMethodName('Get_LogEnabled');
  Result := Driver.LogEnabled;
  LogMethodValue('Get_LogEnabled', Result);
end;

procedure TMifareDrv.Set_LogEnabled(Value: WordBool);
begin
  LogMethodName('Set_LogEnabled');
  Driver.LogEnabled := Value;
  LogMethodValue('Set_LogEnabled', Value);
end;

function TMifareDrv.Get_LogFileName: WideString;
begin
  LogMethodName('Get_LogFileName');
  Result := Driver.LogFileName;
  LogMethodValue('Get_LogFileName', Result);
end;

procedure TMifareDrv.Set_LogFileName(const Value: WideString);
begin
  LogMethodName('Set_LogFileName');
  Driver.LogFileName := Value;
  LogMethodValue('Set_LogFileName', Value);
end;

function TMifareDrv.Get_RedLED: WordBool;
begin
  LogMethodName('Get_RedLED');
  Result := Driver.RedLED;
  LogMethodValue('Get_RedLED', Result);
end;

procedure TMifareDrv.Set_RedLED(Value: WordBool);
begin
  LogMethodName('Set_RedLED');
  Driver.RedLED := Value;
  LogMethodValue('Set_RedLED', Value);
end;

function TMifareDrv.Get_GreenLED: WordBool;
begin
  LogMethodName('Get_GreenLED');
  Result := Driver.GreenLED;
  LogMethodValue('Get_GreenLED', Result);
end;

procedure TMifareDrv.Set_GreenLED(Value: WordBool);
begin
  LogMethodName('Set_GreenLED');
  Driver.GreenLED := Value;
  LogMethodValue('Set_GreenLED', Value);
end;

function TMifareDrv.Get_BlueLED: WordBool;
begin
  LogMethodName('Get_BlueLED');
  Result := Driver.BlueLED;
  LogMethodValue('Get_BlueLED', Result);
end;

procedure TMifareDrv.Set_BlueLED(Value: WordBool);
begin
  LogMethodName('Set_BlueLED');
  Driver.BlueLED := Value;
  LogMethodValue('Set_BlueLED', Value);
end;

function TMifareDrv.Get_ButtonState: WordBool;
begin
  LogMethodName('Get_ButtonState');
  Result := Driver.ButtonState;
  LogMethodValue('Get_ButtonState', Result);
end;

function TMifareDrv.PcdControlLEDAndPoll: Integer;
begin
  LogMethodName('PcdControlLEDAndPoll');
  Result := Driver.PcdControlLEDAndPoll;
  LogMethodValue('PcdControlLEDAndPoll', Result);
end;

function TMifareDrv.PcdControlLED: Integer;
begin
  LogMethodName('PcdControlLED');
  Result := Driver.PcdControlLED;
  LogMethodValue('PcdControlLED', Result);
end;

function TMifareDrv.PcdPollButton: Integer;
begin
  LogMethodName('PcdPollButton');
  Result := Driver.PcdPollButton;
  LogMethodValue('PcdPollButton', Result);
end;

// IMifareDrv3

function TMifareDrv.Get_EventID: Integer;
begin
  LogMethodName('Get_EventID');
  Result := Driver.EventID;
  LogMethodValue('Get_EventID', Result);
end;

procedure TMifareDrv.Set_EventID(Value: Integer);
begin
  LogMethodName('Set_EventID');
  Driver.EventID := Value;
  LogMethodValue('Set_EventID', Value);
end;

function TMifareDrv.Get_EventDriverID: Integer;
begin
  LogMethodName('Get_EventDriverID');
  Result := Driver.EventDriverID;
  LogMethodValue('Get_EventDriverID', Result);
end;

function TMifareDrv.Get_EventType: Integer;
begin
  LogMethodName('Get_EventType');
  Result := Driver.EventType;
  LogMethodValue('Get_EventType', Result);
end;

function TMifareDrv.Get_EventPortNumber: Integer;
begin
  LogMethodName('Get_EventPortNumber');
  Result := Driver.EventPortNumber;
  LogMethodValue('Get_EventPortNumber', Result);
end;

function TMifareDrv.Get_EventErrorCode: Integer;
begin
  LogMethodName('Get_EventErrorCode');
  Result := Driver.EventErrorCode;
  LogMethodValue('Get_EventErrorCode', Result);
end;

function TMifareDrv.Get_EventErrorText: WideString;
begin
  LogMethodName('Get_EventErrorText');
  Result := Driver.EventErrorText;
  LogMethodValue('Get_EventErrorText', Result);
end;

function TMifareDrv.Get_EventCardUIDHex: WideString;
begin
  LogMethodName('Get_EventCardUIDHex');
  Result := Driver.EventCardUIDHex;
  LogMethodValue('Get_EventCardUIDHex', Result);
end;

function TMifareDrv.FindEvent: Integer;
begin
  LogMethodName('FindEvent');
  Result := Driver.FindEvent;
  LogMethodValue('FindEvent', Result);
end;

function TMifareDrv.DeleteEvent: Integer;
begin
  LogMethodName('DeleteEvent');
  Result := Driver.DeleteEvent;
  LogMethodValue('DeleteEvent', Result);
end;

function TMifareDrv.Get_EventsEnabled: WordBool;
begin
  LogMethodName('Get_EventsEnabled');
  Result := Driver.EventsEnabled;
  LogMethodValue('Get_EventsEnabled', Result);
end;

procedure TMifareDrv.Set_EventsEnabled(Value: WordBool);
begin
  LogMethodName('Set_EventsEnabled');
  Driver.EventsEnabled := Value;
  LogMethodValue('Set_EventsEnabled', Value);
end;

function TMifareDrv.ClearEvents: Integer;
begin
  LogMethodName('ClearEvents');
  Result := Driver.ClearEvents;
  LogMethodValue('ClearEvents', Result);
end;

function TMifareDrv.Get_EventCount: Integer;
begin
  LogMethodName('Get_EventCount');
  Result := Driver.EventCount;
  LogMethodValue('Get_EventCount', Result);
end;

function TMifareDrv.Get_DriverID: Integer;
begin
  LogMethodName('Get_DriverID');
  Result := Driver.DriverID;
  LogMethodValue('Get_DriverID', Result);
end;

function TMifareDrv.LockReader: Integer;
begin
  LogMethodName('LockReader');
  Result := Driver.LockReader;
  LogMethodValue('LockReader', Result);
end;

function TMifareDrv.UnlockReader: Integer;
begin
  LogMethodName('UnlockReader');
  Result := Driver.UnlockReader;
  LogMethodValue('UnlockReader', Result);
end;

function TMifareDrv.Get_YellowLED: WordBool;
begin
  LogMethodName('Get_YellowLED');
  Result := Driver.YellowLED;
  LogMethodValue('Get_YellowLED', Result);
end;

procedure TMifareDrv.Set_YellowLED(Value: WordBool);
begin
  LogMethodName('Set_YellowLED');
  Driver.YellowLED := Value;
  LogMethodValue('Set_YellowLED', Value);
end;

function TMifareDrv.SAM_GetVersion: Integer;
begin
  LogMethodName('SAM_GetVersion');
  Result := Driver.SAM_GetVersion;
  LogMethodValue('SAM_GetVersion', Result);
end;

function TMifareDrv.Get_SAMVersion: TSAMVersion;
begin
  LogMethodName('Get_SAMVersion');
  Result := Driver.SAMVersion;
  LogMethodValue('Get_SAMVersion', '');
end;

function TMifareDrv.SAM_WriteKey: Integer;
begin
  LogMethodName('SAM_WriteKey');
  Result := Driver.SAM_WriteKey;
  LogMethodValue('SAM_WriteKey', Result);
end;

function TMifareDrv.Get_KeyPosition: Integer;
begin
  LogMethodName('Get_KeyPosition');
  Result := Driver.KeyPosition;
  LogMethodValue('Get_KeyPosition', Result);
end;

function TMifareDrv.Get_KeyVersion: Integer;
begin
  LogMethodName('Get_KeyVersion');
  Result := Driver.KeyVersion;
  LogMethodValue('Get_KeyVersion', Result);
end;

procedure TMifareDrv.Set_KeyPosition(Value: Integer);
begin
  LogMethodName('Set_KeyPosition');
  Driver.KeyPosition := Value;
  LogMethodValue('Set_KeyPosition', Value);
end;

procedure TMifareDrv.Set_KeyVersion(Value: Integer);
begin
  LogMethodName('Set_KeyVersion');
  Driver.KeyVersion := Value;
  LogMethodValue('Set_KeyVersion', Value);
end;

function TMifareDrv.SAM_AuthKey: Integer;
begin
  LogMethodName('SAM_AuthKey');
  Result := Driver.SAM_AuthKey;
  LogMethodValue('SAM_AuthKey', Result);
end;

function TMifareDrv.Get_LogFilePath: WideString;
begin
  LogMethodName('Get_LogFilePath');
  Result := Driver.LogFilePath;
  LogMethodValue('Get_LogFilePath', Result);
end;

procedure TMifareDrv.Set_LogFilePath(const Value: WideString);
begin
  LogMethodName('Set_LogFilePath');
  Driver.LogFilePath := Value;
  LogMethodValue('Set_LogFilePath', Value);
end;

function TMifareDrv.Get_ParamsRegKey: WideString;
begin
  LogMethodName('Get_ParamsRegKey');
  Result := Driver.ParamsRegKey;
  LogMethodValue('Get_ParamsRegKey', Result);
end;

procedure TMifareDrv.Set_ParamsRegKey(const Value: WideString);
begin
  LogMethodName('Set_ParamsRegKey');
  Driver.ParamsRegKey := Value;
  LogMethodValue('Set_ParamsRegKey', Value);
end;

function TMifareDrv.SAM_GetKeyEntry: Integer;
begin
  LogMethodName('SAM_GetKeyEntry');
  Result := Driver.SAM_GetKeyEntry;
  LogMethodValue('SAM_GetKeyEntry', Result);
end;

function TMifareDrv.SAM_WriteHostAuthKey: Integer;
begin
  LogMethodName('SAM_WriteHostAuthKey');
  Result := Driver.SAM_WriteHostAuthKey;
  LogMethodValue('SAM_WriteHostAuthKey', Result);
end;

function TMifareDrv.ReadFullSerialNumber: Integer;
begin
  LogMethodName('ReadFullSerialNumber');
  Result := Driver.ReadFullSerialNumber;
  LogMethodValue('ReadFullSerialNumber', Result);
end;

function TMifareDrv.SAM_SetProtection: Integer;
begin
  LogMethodName('SAM_SetProtection');
  Result := Driver.SAM_SetProtection;
  LogMethodValue('SAM_SetProtection', Result);
end;

function TMifareDrv.SAM_SetProtectionSN: Integer;
begin
  LogMethodName('SAM_SetProtectionSN');
  Result := Driver.SAM_SetProtectionSN;
  LogMethodValue('SAM_SetProtectionSN', Result);
end;

function TMifareDrv.Get_KeyEntryNumber: Integer;
begin
  LogMethodName('Get_KeyEntryNumber');
  Result := Driver.KeyEntryNumber;
  LogMethodValue('Get_KeyEntryNumber', Result);
end;

procedure TMifareDrv.Set_KeyEntryNumber(Value: Integer);
begin
  LogMethodName('Set_KeyEntryNumber');
  Driver.KeyEntryNumber := Value;
  LogMethodValue('Set_KeyEntryNumber', Value);
end;

function TMifareDrv.Get_KeyVersion0: Integer;
begin
  LogMethodName('Get_KeyVersion0');
  Result := Driver.KeyVersion0;
  LogMethodValue('Get_KeyVersion0', Result);
end;

function TMifareDrv.Get_KeyVersion1: Integer;
begin
  LogMethodName('Get_KeyVersion1');
  Result := Driver.KeyVersion1;
  LogMethodValue('Get_KeyVersion1', Result);
end;

function TMifareDrv.Get_KeyVersion2: Integer;
begin
  LogMethodName('Get_KeyVersion2');
  Result := Driver.KeyVersion2;
  LogMethodValue('Get_KeyVersion2', Result);
end;

function TMifareDrv.Get_SerialNumber: WideString;
begin
  LogMethodName('Get_SerialNumber');
  Result := Driver.SerialNumber;
  LogMethodValue('Get_SerialNumber', Result);
end;

function TMifareDrv.Get_SerialNumberHex: WideString;
begin
  LogMethodName('Get_SerialNumberHex');
  Result := Driver.SerialNumberHex;
  LogMethodValue('Get_SerialNumberHex', Result);
end;

procedure TMifareDrv.Set_SerialNumber(const Value: WideString);
begin
  LogMethodName('Set_SerialNumber');
  Driver.SerialNumber := Value;
  LogMethodValue('Set_SerialNumber', Value);
end;

procedure TMifareDrv.Set_SerialNumberHex(const Value: WideString);
begin
  LogMethodName('Set_SerialNumberHex');
  Driver.SerialNumberHex := Value;
  LogMethodValue('Set_SerialNumberHex', Value);
end;

function TMifareDrv.Get_KeyTypeText: WideString;
begin
  LogMethodName('Get_KeyTypeText');
  Result := Driver.KeyTypeText;
  LogMethodValue('Get_KeyTypeText', Result);
end;

function TMifareDrv.WriteConnectionParams: Integer;
begin
  LogMethodName('WriteConnectionParams');
  Result := Driver.WriteConnectionParams;
  LogMethodValue('WriteConnectionParams', Result);
end;

function TMifareDrv.Get_ErrorOnCorruptedValueBlock: WordBool;
begin
  LogMethodName('Get_ErrorOnCorruptedValueBlock');
  Result := Driver.ErrorOnCorruptedValueBlock;
  LogMethodValue('Get_ErrorOnCorruptedValueBlock', Result);
end;

procedure TMifareDrv.Set_ErrorOnCorruptedValueBlock(Value: WordBool);
begin
  LogMethodName('Set_ErrorOnCorruptedValueBlock');
  Driver.ErrorOnCorruptedValueBlock := Value;
  LogMethodValue('Set_ErrorOnCorruptedValueBlock', Value);
end;

function TMifareDrv.Get_IsValueBlockCorrupted: WordBool;
begin
  LogMethodName('Get_IsValueBlockCorrupted');
  Result := Driver.IsValueBlockCorrupted;
  LogMethodValue('Get_IsValueBlockCorrupted', Result);
end;

function TMifareDrv.UltralightRead: Integer;
begin
  LogMethodName('UltralightRead');
  Result := Driver.UltralightRead;
  LogMethodValue('UltralightRead', Result);
end;

function TMifareDrv.UltralightAuth: Integer;
begin
  LogMethodName('UltralightAuth');
  Result := Driver.UltralightAuth;
  LogMethodValue('UltralightAuth', Result);
end;

function TMifareDrv.UltralightCompatWrite: Integer;
begin
  LogMethodName('UltralightCompatWrite');
  Result := Driver.UltralightCompatWrite;
  LogMethodValue('UltralightCompatWrite', Result);
end;

function TMifareDrv.UltralightWrite: Integer;
begin
  LogMethodName('UltralightWrite');
  Result := Driver.UltralightWrite;
  LogMethodValue('UltralightWrite', Result);
end;

function TMifareDrv.UltralightWriteKey: Integer;
begin
  LogMethodName('UltralightWriteKey');
  Result := Driver.UltralightWriteKey;
  LogMethodValue('UltralightWriteKey', Result);
end;

function TMifareDrv.MifarePlusWritePerso: Integer;
begin
  LogMethodName('MifarePlusWritePerso');
  Result := Driver.MifarePlusWritePerso;
  LogMethodValue('MifarePlusWritePerso', Result);
end;

function TMifareDrv.MifarePlusWriteParameters: Integer;
begin
  LogMethodName('MifarePlusWriteParameters');
  Result := Driver.MifarePlusWriteParameters;
  LogMethodValue('MifarePlusWriteParameters', Result);
end;

function TMifareDrv.MifarePlusCommitPerso: Integer;
begin
  LogMethodName('MifarePlusCommitPerso');
  Result := Driver.MifarePlusCommitPerso;
  LogMethodValue('MifarePlusCommitPerso', Result);
end;

function TMifareDrv.Get_ReceiveDivisor: Integer;
begin
  LogMethodName('Get_ReceiveDivisor');
  Result := Driver.ReceiveDivisor;
  LogMethodValue('Get_ReceiveDivisor', Result);
end;

function TMifareDrv.Get_SendDivisor: Integer;
begin
  LogMethodName('Get_SendDivisor');
  Result := Driver.SendDivisor;
  LogMethodValue('Get_SendDivisor', Result);
end;

procedure TMifareDrv.Set_ReceiveDivisor(Value: Integer);
begin
  LogMethodName('Set_ReceiveDivisor');
  Driver.ReceiveDivisor := Value;
  LogMethodValue('Set_ReceiveDivisor', Value);
end;

procedure TMifareDrv.Set_SendDivisor(Value: Integer);
begin
  LogMethodName('Set_SendDivisor');
  Driver.SendDivisor := Value;
  LogMethodValue('Set_SendDivisor', Value);
end;

function TMifareDrv.MifarePlusAuthSL1: Integer;
begin
  LogMethodName('MifarePlusAuthSL1');
  Result := Driver.MifarePlusAuthSL1;
  LogMethodValue('MifarePlusAuthSL1', Result);
end;

function TMifareDrv.MifarePlusAuthSL3: Integer;
begin
  LogMethodName('MifarePlusAuthSL3');
  Result := Driver.MifarePlusAuthSL3;
  LogMethodValue('MifarePlusAuthSL3', Result);
end;

function TMifareDrv.MifarePlusDecrement: Integer;
begin
  LogMethodName('MifarePlusDecrement');
  Result := Driver.MifarePlusDecrement;
  LogMethodValue('MifarePlusDecrement', Result);
end;

function TMifareDrv.MifarePlusDecrementTransfer: Integer;
begin
  LogMethodName('MifarePlusDecrementTransfer');
  Result := Driver.MifarePlusDecrementTransfer;
  LogMethodValue('MifarePlusDecrementTransfer', Result);
end;

function TMifareDrv.MifarePlusIncrement: Integer;
begin
  LogMethodName('MifarePlusIncrement');
  Result := Driver.MifarePlusIncrement;
  LogMethodValue('MifarePlusIncrement', Result);
end;

function TMifareDrv.MifarePlusIncrementTransfer: Integer;
begin
  LogMethodName('MifarePlusIncrementTransfer');
  Result := Driver.MifarePlusIncrementTransfer;
  LogMethodValue('MifarePlusIncrementTransfer', Result);
end;

function TMifareDrv.MifarePlusMultiblockRead: Integer;
begin
  LogMethodName('MifarePlusMultiblockRead');
  Result := Driver.MifarePlusMultiblockRead;
  LogMethodValue('MifarePlusMultiblockRead', Result);
end;

function TMifareDrv.MifarePlusMultiblockWrite: Integer;
begin
  LogMethodName('MifarePlusMultiblockWrite');
  Result := Driver.MifarePlusMultiblockWrite;
  LogMethodValue('MifarePlusMultiblockWrite', Result);
end;

function TMifareDrv.MifarePlusRead: Integer;
begin
  LogMethodName('MifarePlusRead');
  Result := Driver.MifarePlusRead;
  LogMethodValue('MifarePlusRead', Result);
end;

function TMifareDrv.MifarePlusReadValue: Integer;
begin
  LogMethodName('MifarePlusReadValue');
  Result := Driver.MifarePlusReadValue;
  LogMethodValue('MifarePlusReadValue', Result);
end;

function TMifareDrv.MifarePlusResetAuthentication: Integer;
begin
  LogMethodName('MifarePlusResetAuthentication');
  Result := Driver.MifarePlusResetAuthentication;
  LogMethodValue('MifarePlusResetAuthentication', Result);
end;

function TMifareDrv.MifarePlusRestore: Integer;
begin
  LogMethodName('MifarePlusRestore');
  Result := Driver.MifarePlusRestore;
  LogMethodValue('MifarePlusRestore', Result);
end;

function TMifareDrv.MifarePlusTransfer: Integer;
begin
  LogMethodName('MifarePlusTransfer');
  Result := Driver.MifarePlusTransfer;
  LogMethodValue('MifarePlusTransfer', Result);
end;

function TMifareDrv.MifarePlusWriteValue: Integer;
begin
  LogMethodName('MifarePlusWriteValue');
  Result := Driver.MifarePlusWriteValue;
  LogMethodValue('MifarePlusWriteValue', Result);
end;

function TMifareDrv.Get_AuthType: Integer;
begin
  LogMethodName('Get_AuthType');
  Result := Driver.AuthType;
  LogMethodValue('Get_AuthType', Result);
end;

procedure TMifareDrv.Set_AuthType(Value: Integer);
begin
  LogMethodName('Set_AuthType');
  Driver.AuthType := Value;
  LogMethodValue('Set_AuthType', Value);
end;

function TMifareDrv.Get_BlockCount: Integer;
begin
  LogMethodName('Get_BlockCount');
  Result := Driver.BlockCount;
  LogMethodValue('Get_BlockCount', Result);
end;

procedure TMifareDrv.Set_BlockCount(Value: Integer);
begin
  LogMethodName('Set_BlockCount');
  Driver.BlockCount := Value;
  LogMethodValue('Set_BlockCount', Value);
end;

function TMifareDrv.MifarePlusWrite: Integer;
begin
  LogMethodName('MifarePlusWrite');
  Result := Driver.MifarePlusWrite;
  LogMethodValue('MifarePlusWrite', Result);
end;

function TMifareDrv.Get_NewBaudRate: Integer;
begin
  LogMethodName('Get_NewBaudRate');
  Result := Driver.NewBaudRate;
  LogMethodValue('Get_NewBaudRate', Result);
end;

procedure TMifareDrv.Set_NewBaudRate(Value: Integer);
begin
  LogMethodName('Set_NewBaudRate');
  Driver.NewBaudRate := Value;
  LogMethodValue('Set_NewBaudRate', Value);
end;

function TMifareDrv.Get_SAMHWVendorID: Integer;
begin
  LogMethodName('Get_SAMHWVendorID');
  Result := Driver.SAMHWVendorID;
  LogMethodValue('Get_SAMHWVendorID', Result);
end;

function TMifareDrv.Get_SAMHWVendorName: WideString;
begin
  LogMethodName('Get_SAMHWVendorName');
  Result := Driver.SAMHWVendorName;
  LogMethodValue('Get_SAMHWVendorName', Result);
end;

function TMifareDrv.Get_SAMHWType: Integer;
begin
  LogMethodName('Get_SAMHWType');
  Result := Driver.SAMHWType;
  LogMethodValue('Get_SAMHWType', Result);
end;

function TMifareDrv.Get_SAMHWSubType: Integer;
begin
  LogMethodName('Get_SAMHWSubType');
  Result := Driver.SAMHWSubType;
  LogMethodValue('Get_SAMHWSubType', Result);
end;

function TMifareDrv.Get_SAMHWMajorVersion: Integer;
begin
  LogMethodName('Get_SAMHWMajorVersion');
  Result := Driver.SAMHWMajorVersion;
  LogMethodValue('Get_SAMHWMajorVersion', Result);
end;

function TMifareDrv.Get_SAMHWMinorVersion: Integer;
begin
  LogMethodName('Get_SAMHWMinorVersion');
  Result := Driver.SAMHWMinorVersion;
  LogMethodValue('Get_SAMHWMinorVersion', Result);
end;

function TMifareDrv.Get_SAMHWProtocol: Integer;
begin
  LogMethodName('Get_SAMHWProtocol');
  Result := Driver.SAMHWProtocol;
  LogMethodValue('Get_SAMHWProtocol', Result);
end;

function TMifareDrv.Get_SAMHWStorageSize: Integer;
begin
  LogMethodName('Get_SAMHWStorageSize');
  Result := Driver.SAMHWStorageSize;
  LogMethodValue('Get_SAMHWStorageSize', Result);
end;

function TMifareDrv.Get_SAMHWStorageSizeCode: Integer;
begin
  LogMethodName('Get_SAMHWStorageSizeCode');
  Result := Driver.SAMHWStorageSizeCode;
  LogMethodValue('Get_SAMHWStorageSizeCode', Result);
end;

function TMifareDrv.Get_SAMSWMajorVersion: Integer;
begin
  LogMethodName('Get_SAMSWMajorVersion');
  Result := Driver.SAMSWMajorVersion;
  LogMethodValue('Get_SAMSWMajorVersion', Result);
end;

function TMifareDrv.Get_SAMSWMinorVersion: Integer;
begin
  LogMethodName('Get_SAMSWMinorVersion');
  Result := Driver.SAMSWMinorVersion;
  LogMethodValue('Get_SAMSWMinorVersion', Result);
end;

function TMifareDrv.Get_SAMSWProtocol: Integer;
begin
  LogMethodName('Get_SAMSWProtocol');
  Result := Driver.SAMSWProtocol;
  LogMethodValue('Get_SAMSWProtocol', Result);
end;

function TMifareDrv.Get_SAMSWStorageSize: Integer;
begin
  LogMethodName('Get_SAMSWStorageSize');
  Result := Driver.SAMSWStorageSize;
  LogMethodValue('Get_SAMSWStorageSize', Result);
end;

function TMifareDrv.Get_SAMSWStorageSizeCode: Integer;
begin
  LogMethodName('Get_SAMSWStorageSizeCode');
  Result := Driver.SAMSWStorageSizeCode;
  LogMethodValue('Get_SAMSWStorageSizeCode', Result);
end;

function TMifareDrv.Get_SAMSWSubType: Integer;
begin
  LogMethodName('Get_SAMSWSubType');
  Result := Driver.SAMSWSubType;
  LogMethodValue('Get_SAMSWSubType', Result);
end;

function TMifareDrv.Get_SAMSWType: Integer;
begin
  LogMethodName('Get_SAMSWType');
  Result := Driver.SAMSWType;
  LogMethodValue('Get_SAMSWType', Result);
end;

function TMifareDrv.Get_SAMSWVendorID: Integer;
begin
  LogMethodName('Get_SAMSWVendorID');
  Result := Driver.SAMSWVendorID;
  LogMethodValue('Get_SAMSWVendorID', Result);
end;

function TMifareDrv.Get_SAMSWVendorName: WideString;
begin
  LogMethodName('Get_SAMSWVendorName');
  Result := Driver.SAMSWVendorName;
  LogMethodValue('Get_SAMSWVendorName', Result);
end;

function TMifareDrv.Get_SAMMode: Integer;
begin
  LogMethodName('Get_SAMMode');
  Result := Driver.SAMMode;
  LogMethodValue('Get_SAMMode', Result);
end;

function TMifareDrv.Get_SAMModeName: WideString;
begin
  LogMethodName('Get_SAMModeName');
  Result := Driver.SAMModeName;
  LogMethodValue('Get_SAMModeName', Result);
end;

function TMifareDrv.Get_SAMMDBatchNo: Integer;
begin
  LogMethodName('Get_SAMMDBatchNo');
  Result := Driver.SAMMDBatchNo;
  LogMethodValue('Get_SAMMDBatchNo', Result);
end;

function TMifareDrv.Get_SAMMDGlobalCryptoSettings: Integer;
begin
  LogMethodName('Get_SAMMDGlobalCryptoSettings');
  Result := Driver.SAMMDGlobalCryptoSettings;
  LogMethodValue('Get_SAMMDGlobalCryptoSettings', Result);
end;

function TMifareDrv.Get_SAMMDProductionDay: Integer;
begin
  LogMethodName('Get_SAMMDProductionDay');
  Result := Driver.SAMMDProductionDay;
  LogMethodValue('Get_SAMMDProductionDay', Result);
end;

function TMifareDrv.Get_SAMMDProductionMonth: Integer;
begin
  LogMethodName('Get_SAMMDProductionMonth');
  Result := Driver.SAMMDProductionMonth;
  LogMethodValue('Get_SAMMDProductionMonth', Result);
end;

function TMifareDrv.Get_SAMMDProductionYear: Integer;
begin
  LogMethodName('Get_SAMMDProductionYear');
  Result := Driver.SAMMDProductionYear;
  LogMethodValue('Get_SAMMDProductionYear', Result);
end;

function TMifareDrv.Get_SAMMDUID: Integer;
begin
  LogMethodName('Get_SAMMDUID');
  Result := Driver.SAMMDUID;
  LogMethodValue('Get_SAMMDUID', Result);
end;

function TMifareDrv.Get_SAMMDUIDHex: WideString;
begin
  LogMethodName('Get_SAMMDUIDHex');
  Result := Driver.SAMMDUIDHex;
  LogMethodValue('Get_SAMMDUIDHex', Result);
end;

function TMifareDrv.Get_SAMMDUIDStr: WideString;
begin
  LogMethodName('Get_SAMMDUIDStr');
  Result := Driver.SAMMDUIDStr;
  LogMethodValue('Get_SAMMDUIDStr', Result);
end;

function TMifareDrv.EnableCardAccept: Integer;
begin
  LogMethodName('EnableCardAccept');
  Result := Driver.EnableCardAccept;
  LogMethodValue('EnableCardAccept', Result);
end;

function TMifareDrv.DisableCardAccept: Integer;
begin
  LogMethodName('DisableCardAccept');
  Result := Driver.DisableCardAccept;
  LogMethodValue('DisableCardAccept', Result);
end;

function TMifareDrv.HoldCard: Integer;
begin
  LogMethodName('HoldCard');
  Result := Driver.HoldCard;
  LogMethodValue('HoldCard', Result);
end;

function TMifareDrv.IssueCard: Integer;
begin
  LogMethodName('IssueCard');
  Result := Driver.IssueCard;
  LogMethodValue('IssueCard', Result);
end;

function TMifareDrv.ReadLastAnswer: Integer;
begin
  LogMethodName('ReadLastAnswer');
  Result := Driver.ReadLastAnswer;
  LogMethodValue('ReadLastAnswer', Result);
end;

function TMifareDrv.ReadStatus: Integer;
begin
  LogMethodName('ReadStatus');
  Result := Driver.ReadStatus;
  LogMethodValue('ReadStatus', Result);
end;

function TMifareDrv.Get_Protocol: Integer;
begin
  LogMethodName('Get_Protocol');
  Result := Driver.Protocol;
  LogMethodValue('Get_Protocol', Result);
end;

procedure TMifareDrv.Set_Protocol(Value: Integer);
begin
  LogMethodName('Set_Protocol');
  Driver.Protocol := Value;
  LogMethodValue('Set_Protocol', Value);
end;

function TMifareDrv.MifarePlusAuthSL2: Integer;
begin
  LogMethodName('MifarePlusAuthSL2');
  Result := Driver.MifarePlusAuthSL2;
  LogMethodValue('MifarePlusAuthSL2', Result);
end;

function TMifareDrv.SAMAV2WriteKey: Integer;
begin
  LogMethodName('SAMAV2WriteKey');
  Result := Driver.SAMAV2WriteKey;
  LogMethodValue('SAMAV2WriteKey', Result);
end;

function TMifareDrv.Get_AnswerSignature: WordBool;
begin
  LogMethodName('Get_AnswerSignature');
  Result := Driver.AnswerSignature;
  LogMethodValue('Get_AnswerSignature', Result);
end;

function TMifareDrv.Get_CommandSignature: WordBool;
begin
  LogMethodName('Get_CommandSignature');
  Result := Driver.CommandSignature;
  LogMethodValue('Get_CommandSignature', Result);
end;

function TMifareDrv.Get_EncryptionEnabled: WordBool;
begin
  LogMethodName('Get_EncryptionEnabled');
  Result := Driver.EncryptionEnabled;
  LogMethodValue('Get_EncryptionEnabled', Result);
end;

procedure TMifareDrv.Set_AnswerSignature(Value: WordBool);
begin
  LogMethodName('Set_AnswerSignature');
  Driver.AnswerSignature := Value;
  LogMethodValue('Set_AnswerSignature', Value);
end;

procedure TMifareDrv.Set_CommandSignature(Value: WordBool);
begin
  LogMethodName('Set_CommandSignature');
  Driver.CommandSignature := Value;
  LogMethodValue('Set_CommandSignature', Value);
end;

procedure TMifareDrv.Set_EncryptionEnabled(Value: WordBool);
begin
  LogMethodName('Set_EncryptionEnabled');
  Driver.EncryptionEnabled := Value;
  LogMethodValue('Set_EncryptionEnabled', Value);
end;

function TMifareDrv.MifarePlusMultiblockReadSL2: Integer;
begin
  LogMethodName('MifarePlusMultiblockReadSL2');
  Result := Driver.MifarePlusMultiblockReadSL2;
  LogMethodValue('MifarePlusMultiblockReadSL2', Result);
end;

function TMifareDrv.MifarePlusMultiblockWriteSL2: Integer;
begin
  LogMethodName('MifarePlusMultiblockWriteSL2');
  Result := Driver.MifarePlusMultiblockWriteSL2;
  LogMethodValue('MifarePlusMultiblockWriteSL2', Result);
end;

function TMifareDrv.MifarePlusAuthSL2Crypto1: Integer;
begin
  LogMethodName('MifarePlusAuthSL2Crypto1');
  Result := Driver.MifarePlusAuthSL2Crypto1;
  LogMethodValue('MifarePlusAuthSL2Crypto1', Result);
end;

function TMifareDrv.WriteEncryptedData: Integer;
begin
  LogMethodName('WriteEncryptedData');
  Result := Driver.WriteEncryptedData;
  LogMethodValue('WriteEncryptedData', Result);
end;

function TMifareDrv.Get_PollActivateMethod: TPollActivateMethod;
begin
  LogMethodName('Get_PollActivateMethod');
  Result := Driver.PollActivateMethod;
  LogMethodValue('Get_PollActivateMethod', Result);
end;

procedure TMifareDrv.Set_PollActivateMethod(Value: TPollActivateMethod);
begin
  LogMethodName('Set_PollActivateMethod');
  Driver.PollActivateMethod := Value;
  LogMethodValue('Set_PollActivateMethod', Value);
end;

end.

