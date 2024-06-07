unit MifareLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 07.06.2024 8:51:40 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\projects\MifareDrv\Source\MifareDrv\MifareDrv.tlb (1)
// LIBID: {11C2E197-6F27-42B2-A78C-40D7D0446092}
// LCID: 0
// Helpfile: 
// HelpString: ØÒÐÈÕ-Ì: Äנאיגונ סקטעûגאעוכוי Mifare
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MifareLibMajorVersion = 1;
  MifareLibMinorVersion = 0;

  LIBID_MifareLib: TGUID = '{11C2E197-6F27-42B2-A78C-40D7D0446092}';

  IID_IMifareDrv: TGUID = '{48689C27-D899-417E-A640-3B5D87EEF108}';
  DIID_IMifareDrvEvents: TGUID = '{F7F7EF32-F06D-4884-A4BC-62103A627967}';
  IID_IMifareDrv1: TGUID = '{F374ADB9-5526-496D-890F-52C1651042F5}';
  IID_IMIfareDrv2: TGUID = '{244EC6AA-F110-4835-BB5C-013D50E71518}';
  IID_IMifareDrv3: TGUID = '{EE43D29A-EE86-4604-80E6-742A9E1B6790}';
  CLASS_MifareDrv2: TGUID = '{1427F57D-CDF3-46B3-BC10-3C9D1C029F7E}';
  IID_IMifareDrv4: TGUID = '{04F0144D-C7DB-4BC6-8B6A-CF8FF7E73BCC}';
  CLASS_MifareDrv: TGUID = '{450E3DC0-5370-4007-BD5F-90827EC2C2D6}';
  CLASS_MifareDrv4: TGUID = '{DD055FE8-636A-4666-8D75-7CF115D5A159}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TBaudRate
type
  TBaudRate = TOleEnum;
const
  br106KBaud = $00000000;
  br212KBaud = $00000001;
  br424KBaud = $00000002;
  br848KBaud = $00000003;

// Constants for enum TValueOperation
type
  TValueOperation = TOleEnum;
const
  voIncrement = $000000C1;
  voDecrement = $000000C0;
  voRestore = $000000C2;
  voTransfer = $000000B0;

// Constants for enum TCardType
type
  TCardType = TOleEnum;
const
  ctUnknown = $00000000;
  ctMifareUltraLight = $00000001;
  ctMifare1K = $00000002;
  ctMifare4K = $00000003;
  ctMifareDESfire = $00000004;
  ctMifareProximity = $00000005;
  ctSmartMX_1K = $00000006;
  ctMifareMini = $00000007;
  ctMifarePlus2K = $00000008;
  ctMifarePlus4K = $00000009;
  ctMifarePlus_2K_7UID_SL3 = $0000000A;
  ctMifarePlus_4K_7UID_SL3 = $0000000B;
  ctMifarePlus_2K_4UID_SL1 = $0000000C;
  ctMifarePlus_4K_4UID_SL1 = $0000000D;
  ctMifarePlus_2K_7UID_SL1 = $0000000E;
  ctMifarePlus_4K_7UID_SL1 = $0000000F;
  ctSmartMX_4K = $00000010;
  ctSmartMX_7UID = $00000011;

// Constants for enum TReqCode
type
  TReqCode = TOleEnum;
const
  rcIDLE = $00000026;
  rcALL = $00000052;

// Constants for enum TDataCommand
type
  TDataCommand = TOleEnum;
const
  dcRead16 = $00000030;
  dcWrite4 = $000000A2;
  dcWrite16 = $000000A0;

// Constants for enum TSelectCode
type
  TSelectCode = TOleEnum;
const
  scAnticoll1 = $00000093;
  scAnticoll11 = $00000092;
  scAnticoll12 = $00000094;
  scAnticoll13 = $00000098;
  scAnticoll2 = $00000095;
  scAnticoll3 = $00000097;

// Constants for enum TResultCode
type
  TResultCode = TOleEnum;
const
  E_NOERROR = $00000000;
  E_UNKNOWN = $FFFFF830;
  E_BLOCKDATA = $FFFFF82F;
  E_DIRECTORY_NOHEADER = $FFFFF82E;
  E_DIRECTORY_HEADERCRC = $FFFFF82D;
  E_DIRECTORY_DATALENGTH = $FFFFF82C;
  E_DIRECTORY_DATACRC = $FFFFF82B;
  E_DIRECTORY_NOSECTOR = $FFFFF82A;
  E_INVALID_VALUE = $FFFFF829;
  E_EVENT_NOT_FOUND = $FFFFF828;

// Constants for enum TKeyType
type
  TKeyType = TOleEnum;
const
  ktKeyA = $00000060;
  ktKeyB = $00000061;

// Constants for enum TDirectoryStatus
type
  TDirectoryStatus = TOleEnum;
const
  dsOK = $00000000;
  dsNotFound = $00000001;
  dsCorrupted = $00000002;

// Constants for enum TFieldtype
type
  TFieldtype = TOleEnum;
const
  ftByte = $00000000;
  ftSmallint = $00000001;
  ftBool = $00000002;
  ftInteger = $00000003;
  ftDouble = $00000004;
  ftString = $00000005;

// Constants for enum TAccess
type
  TAccess = TOleEnum;
const
  aNone = $00000001;
  aKeyA = $00000002;
  aKeyB = $00000004;

// Constants for enum TDataMode
type
  TDataMode = TOleEnum;
const
  dmDirNotUsed = $00000000;
  dmMikleSoftDir = $00000001;
  dmCustomDir = $00000002;

// Constants for enum TDeviceType
type
  TDeviceType = TOleEnum;
const
  dtMiReader = $00000000;
  dtCardman5321 = $00000001;
  dtEmulator = $00000002;
  dtOmnikey5422 = $00000003;

// Constants for enum TDataAuthMode
type
  TDataAuthMode = TOleEnum;
const
  dmAuthByKey = $00000000;
  dmAuthByReader = $00000001;

// Constants for enum TDataFormat
type
  TDataFormat = TOleEnum;
const
  dfHex = $00000000;
  dfBin = $00000001;

// Constants for enum VENDOR_ID
type
  VENDOR_ID = TOleEnum;
const
  VENDOR_ID_PHILIPS = $00000004;

// Constants for enum TPollActivateMethod
type
  TPollActivateMethod = TOleEnum;
const
  POLL_ACTIVATE_IDLE = $00000000;
  POLL_ACTIVATE_WAKEUP = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IMifareDrv = interface;
  IMifareDrvDisp = dispinterface;
  IMifareDrvEvents = dispinterface;
  IMifareDrv1 = interface;
  IMifareDrv1Disp = dispinterface;
  IMIfareDrv2 = interface;
  IMIfareDrv2Disp = dispinterface;
  IMifareDrv3 = interface;
  IMifareDrv3Disp = dispinterface;
  IMifareDrv4 = interface;
  IMifareDrv4Disp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MifareDrv2 = IMifareDrv3;
  MifareDrv = IMifareDrv4;
  MifareDrv4 = IMifareDrv4;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  TSAMSoftwareInfo = packed record
    VendorID: Byte;
    RType: Byte;
    SubType: Byte;
    MajorVersion: Byte;
    MinorVersion: Byte;
    StorageSize: Integer;
    Protocol: Byte;
    VendorName: WideString;
    StorageSizeCode: Byte;
  end;

  TSAMManufacturingData = packed record
    UID: Largeuint;
    UIDHex: WideString;
    BatchNo: Largeuint;
    ProductionDay: Byte;
    ProductionMonth: Byte;
    ProductionYear: Byte;
    GlobalCryptoSettings: Byte;
  end;

  TSAMVersion = packed record
    Data: WideString;
    HardwareInfo: TSAMSoftwareInfo;
    SoftwareInfo: TSAMSoftwareInfo;
    ManufacturingData: TSAMManufacturingData;
    Mode: Byte;
    ModeName: WideString;
  end;


// *********************************************************************//
// Interface: IMifareDrv
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {48689C27-D899-417E-A640-3B5D87EEF108}
// *********************************************************************//
  IMifareDrv = interface(IDispatch)
    ['{48689C27-D899-417E-A640-3B5D87EEF108}']
    procedure AboutBox; safecall;
    function AddField: Integer; safecall;
    function AuthStandard: Integer; safecall;
    function ClearBlock: Integer; safecall;
    function ClearFieldValues: Integer; safecall;
    function ClosePort: Integer; safecall;
    function Connect: Integer; safecall;
    function DecodeTrailer: Integer; safecall;
    function DecodeValueBlock: Integer; safecall;
    function DeleteAllFields: Integer; safecall;
    function DeleteAppSectors: Integer; safecall;
    function DeleteField: Integer; safecall;
    function DeleteSector: Integer; safecall;
    function Disconnect: Integer; safecall;
    function EncodeKey: Integer; safecall;
    function EncodeTrailer: Integer; safecall;
    function EncodeValueBlock: Integer; safecall;
    function FindDevice: Integer; safecall;
    function GetFieldParams: Integer; safecall;
    function GetSectorParams: Integer; safecall;
    function InterfaceSetTimeout: Integer; safecall;
    function LoadFieldsFromFile: Integer; safecall;
    function LoadParams: Integer; safecall;
    function LoadValue: Integer; safecall;
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
    function PollStart: Integer; safecall;
    function PollStop: Integer; safecall;
    function PortOpened: Integer; safecall;
    function ReadData: Integer; safecall;
    function ReadDirectory: Integer; safecall;
    function ReadFields: Integer; safecall;
    function ReadTrailer: Integer; safecall;
    function RequestAll: Integer; safecall;
    function RequestIdle: Integer; safecall;
    function ResetCard: Integer; safecall;
    function SaveFieldsToFile: Integer; safecall;
    function SaveParams: Integer; safecall;
    function SendEvent: Integer; safecall;
    function SetDefaults: Integer; safecall;
    function SetFieldParams: Integer; safecall;
    function SetSectorParams: Integer; safecall;
    function ShowDirectoryDlg: Integer; safecall;
    function ShowFirmsDlg: Integer; safecall;
    function ShowProperties: Integer; safecall;
    function ShowSearchDlg: Integer; safecall;
    function ShowTrailerDlg: Integer; safecall;
    function StartTransTimer: Integer; safecall;
    function StopTransTimer: Integer; safecall;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool; safecall;
    function WriteData: Integer; safecall;
    function WriteDirectory: Integer; safecall;
    function WriteFields: Integer; safecall;
    function WriteTrailer: Integer; safecall;
    function Get_AccessMode0: Integer; safecall;
    procedure Set_AccessMode0(Value: Integer); safecall;
    function Get_AccessMode1: Integer; safecall;
    procedure Set_AccessMode1(Value: Integer); safecall;
    function Get_AccessMode2: Integer; safecall;
    procedure Set_AccessMode2(Value: Integer); safecall;
    function Get_AccessMode3: Integer; safecall;
    procedure Set_AccessMode3(Value: Integer); safecall;
    function Get_AppCode: Integer; safecall;
    procedure Set_AppCode(Value: Integer); safecall;
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
    function Get_CardDescription: WideString; safecall;
    function Get_CardType: TCardType; safecall;
    function Get_Command: TDataCommand; safecall;
    procedure Set_Command(Value: TDataCommand); safecall;
    function Get_Connected: WordBool; safecall;
    function Get_Data: WideString; safecall;
    procedure Set_Data(const Value: WideString); safecall;
    function Get_DataLength: Integer; safecall;
    procedure Set_DataLength(Value: Integer); safecall;
    function Get_DataMode: TDataMode; safecall;
    procedure Set_DataMode(Value: TDataMode); safecall;
    function Get_DataSize: Integer; safecall;
    procedure Set_DataSize(Value: Integer); safecall;
    function Get_DeltaValue: Integer; safecall;
    procedure Set_DeltaValue(Value: Integer); safecall;
    function Get_DirectoryStatus: TDirectoryStatus; safecall;
    function Get_DirectoryStatusText: WideString; safecall;
    function Get_ErrorText: WideString; safecall;
    function Get_ExecutionTime: Integer; safecall;
    function Get_FieldCount: Integer; safecall;
    function Get_FieldIndex: Integer; safecall;
    procedure Set_FieldIndex(Value: Integer); safecall;
    function Get_FieldSize: Integer; safecall;
    procedure Set_FieldSize(Value: Integer); safecall;
    function Get_FieldType: Integer; safecall;
    procedure Set_FieldType(Value: Integer); safecall;
    function Get_FieldValue: WideString; safecall;
    procedure Set_FieldValue(const Value: WideString); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const Value: WideString); safecall;
    function Get_FirmCode: Integer; safecall;
    procedure Set_FirmCode(Value: Integer); safecall;
    function Get_IsClient1C: WordBool; safecall;
    function Get_IsShowProperties: WordBool; safecall;
    function Get_KeyA: WideString; safecall;
    procedure Set_KeyA(const Value: WideString); safecall;
    function Get_KeyB: WideString; safecall;
    procedure Set_KeyB(const Value: WideString); safecall;
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
    function Get_NewKeyA: WideString; safecall;
    procedure Set_NewKeyA(const Value: WideString); safecall;
    function Get_NewKeyB: WideString; safecall;
    procedure Set_NewKeyB(const Value: WideString); safecall;
    function Get_ParentWnd: Integer; safecall;
    procedure Set_ParentWnd(Value: Integer); safecall;
    function Get_PasswordHeader: WideString; safecall;
    function Get_PcdFwVersion: WideString; safecall;
    function Get_PcdRicVersion: WideString; safecall;
    function Get_PollInterval: Integer; safecall;
    procedure Set_PollInterval(Value: Integer); safecall;
    function Get_PollStarted: WordBool; safecall;
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
    function Get_SectorCount: Integer; safecall;
    function Get_SectorIndex: Integer; safecall;
    procedure Set_SectorIndex(Value: Integer); safecall;
    function Get_SectorNumber: Integer; safecall;
    procedure Set_SectorNumber(Value: Integer); safecall;
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
    function Get_ValueOperation: TValueOperation; safecall;
    procedure Set_ValueOperation(Value: TValueOperation); safecall;
    function Get_Version: WideString; safecall;
    property AccessMode0: Integer read Get_AccessMode0 write Set_AccessMode0;
    property AccessMode1: Integer read Get_AccessMode1 write Set_AccessMode1;
    property AccessMode2: Integer read Get_AccessMode2 write Set_AccessMode2;
    property AccessMode3: Integer read Get_AccessMode3 write Set_AccessMode3;
    property AppCode: Integer read Get_AppCode write Set_AppCode;
    property ATQ: Word read Get_ATQ;
    property BaudRate: TBaudRate read Get_BaudRate write Set_BaudRate;
    property BeepTone: Integer read Get_BeepTone write Set_BeepTone;
    property BitCount: Integer read Get_BitCount write Set_BitCount;
    property BlockAddr: Integer read Get_BlockAddr write Set_BlockAddr;
    property BlockData: WideString read Get_BlockData write Set_BlockData;
    property BlockDataHex: WideString read Get_BlockDataHex write Set_BlockDataHex;
    property BlockNumber: Integer read Get_BlockNumber write Set_BlockNumber;
    property BlockValue: Integer read Get_BlockValue write Set_BlockValue;
    property CardDescription: WideString read Get_CardDescription;
    property CardType: TCardType read Get_CardType;
    property Command: TDataCommand read Get_Command write Set_Command;
    property Connected: WordBool read Get_Connected;
    property Data: WideString read Get_Data write Set_Data;
    property DataLength: Integer read Get_DataLength write Set_DataLength;
    property DataMode: TDataMode read Get_DataMode write Set_DataMode;
    property DataSize: Integer read Get_DataSize write Set_DataSize;
    property DeltaValue: Integer read Get_DeltaValue write Set_DeltaValue;
    property DirectoryStatus: TDirectoryStatus read Get_DirectoryStatus;
    property DirectoryStatusText: WideString read Get_DirectoryStatusText;
    property ErrorText: WideString read Get_ErrorText;
    property ExecutionTime: Integer read Get_ExecutionTime;
    property FieldCount: Integer read Get_FieldCount;
    property FieldIndex: Integer read Get_FieldIndex write Set_FieldIndex;
    property FieldSize: Integer read Get_FieldSize write Set_FieldSize;
    property FieldType: Integer read Get_FieldType write Set_FieldType;
    property FieldValue: WideString read Get_FieldValue write Set_FieldValue;
    property FileName: WideString read Get_FileName write Set_FileName;
    property FirmCode: Integer read Get_FirmCode write Set_FirmCode;
    property IsClient1C: WordBool read Get_IsClient1C;
    property IsShowProperties: WordBool read Get_IsShowProperties;
    property KeyA: WideString read Get_KeyA write Set_KeyA;
    property KeyB: WideString read Get_KeyB write Set_KeyB;
    property KeyEncoded: WideString read Get_KeyEncoded write Set_KeyEncoded;
    property KeyNumber: Integer read Get_KeyNumber write Set_KeyNumber;
    property KeyType: TKeyType read Get_KeyType write Set_KeyType;
    property KeyUncoded: WideString read Get_KeyUncoded write Set_KeyUncoded;
    property LibInfoKey: Integer read Get_LibInfoKey write Set_LibInfoKey;
    property LockDevices: WordBool read Get_LockDevices write Set_LockDevices;
    property NewKeyA: WideString read Get_NewKeyA write Set_NewKeyA;
    property NewKeyB: WideString read Get_NewKeyB write Set_NewKeyB;
    property ParentWnd: Integer read Get_ParentWnd write Set_ParentWnd;
    property PasswordHeader: WideString read Get_PasswordHeader;
    property PcdFwVersion: WideString read Get_PcdFwVersion;
    property PcdRicVersion: WideString read Get_PcdRicVersion;
    property PollInterval: Integer read Get_PollInterval write Set_PollInterval;
    property PollStarted: WordBool read Get_PollStarted;
    property PortNumber: Integer read Get_PortNumber write Set_PortNumber;
    property ReqCode: TReqCode read Get_ReqCode write Set_ReqCode;
    property ResultCode: Integer read Get_ResultCode;
    property ResultDescription: WideString read Get_ResultDescription;
    property RfResetTime: Integer read Get_RfResetTime write Set_RfResetTime;
    property RICValue: Integer read Get_RICValue write Set_RICValue;
    property SAK: Byte read Get_SAK;
    property SectorCount: Integer read Get_SectorCount;
    property SectorIndex: Integer read Get_SectorIndex write Set_SectorIndex;
    property SectorNumber: Integer read Get_SectorNumber write Set_SectorNumber;
    property SelectCode: TSelectCode read Get_SelectCode write Set_SelectCode;
    property Timeout: Integer read Get_Timeout write Set_Timeout;
    property TransBlockNumber: Integer read Get_TransBlockNumber write Set_TransBlockNumber;
    property TransTime: Integer read Get_TransTime write Set_TransTime;
    property UID: WideString read Get_UID write Set_UID;
    property UIDHex: WideString read Get_UIDHex write Set_UIDHex;
    property UIDLen: Byte read Get_UIDLen;
    property ValueOperation: TValueOperation read Get_ValueOperation write Set_ValueOperation;
    property Version: WideString read Get_Version;
  end;

// *********************************************************************//
// DispIntf:  IMifareDrvDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {48689C27-D899-417E-A640-3B5D87EEF108}
// *********************************************************************//
  IMifareDrvDisp = dispinterface
    ['{48689C27-D899-417E-A640-3B5D87EEF108}']
    procedure AboutBox; dispid -552;
    function AddField: Integer; dispid 1;
    function AuthStandard: Integer; dispid 2;
    function ClearBlock: Integer; dispid 3;
    function ClearFieldValues: Integer; dispid 4;
    function ClosePort: Integer; dispid 5;
    function Connect: Integer; dispid 6;
    function DecodeTrailer: Integer; dispid 7;
    function DecodeValueBlock: Integer; dispid 8;
    function DeleteAllFields: Integer; dispid 9;
    function DeleteAppSectors: Integer; dispid 10;
    function DeleteField: Integer; dispid 11;
    function DeleteSector: Integer; dispid 12;
    function Disconnect: Integer; dispid 13;
    function EncodeKey: Integer; dispid 14;
    function EncodeTrailer: Integer; dispid 15;
    function EncodeValueBlock: Integer; dispid 16;
    function FindDevice: Integer; dispid 17;
    function GetFieldParams: Integer; dispid 18;
    function GetSectorParams: Integer; dispid 19;
    function InterfaceSetTimeout: Integer; dispid 20;
    function LoadFieldsFromFile: Integer; dispid 21;
    function LoadParams: Integer; dispid 22;
    function LoadValue: Integer; dispid 23;
    function OpenPort: Integer; dispid 24;
    function PcdBeep: Integer; dispid 25;
    function PcdConfig: Integer; dispid 26;
    function PcdGetFwVersion: Integer; dispid 27;
    function PcdGetRicVersion: Integer; dispid 28;
    function PcdGetSerialNumber: Integer; dispid 29;
    function PcdLoadKeyE2: Integer; dispid 30;
    function PcdReadE2: Integer; dispid 31;
    function PcdReset: Integer; dispid 32;
    function PcdRfReset: Integer; dispid 33;
    function PcdSetDefaultAttrib: Integer; dispid 34;
    function PcdSetTmo: Integer; dispid 35;
    function PcdWriteE2: Integer; dispid 36;
    function PiccActivateIdle: Integer; dispid 37;
    function PiccActivateWakeup: Integer; dispid 38;
    function PiccAnticoll: Integer; dispid 39;
    function PiccAuth: Integer; dispid 40;
    function PiccAuthE2: Integer; dispid 41;
    function PiccAuthKey: Integer; dispid 42;
    function PiccCascAnticoll: Integer; dispid 43;
    function PiccCascSelect: Integer; dispid 44;
    function PiccCommonRead: Integer; dispid 45;
    function PiccCommonRequest: Integer; dispid 46;
    function PiccCommonWrite: Integer; dispid 47;
    function PiccHalt: Integer; dispid 48;
    function PiccRead: Integer; dispid 49;
    function PiccSelect: Integer; dispid 50;
    function PiccValue: Integer; dispid 51;
    function PiccValueDebit: Integer; dispid 52;
    function PiccWrite: Integer; dispid 53;
    function PollStart: Integer; dispid 54;
    function PollStop: Integer; dispid 55;
    function PortOpened: Integer; dispid 56;
    function ReadData: Integer; dispid 57;
    function ReadDirectory: Integer; dispid 58;
    function ReadFields: Integer; dispid 59;
    function ReadTrailer: Integer; dispid 60;
    function RequestAll: Integer; dispid 61;
    function RequestIdle: Integer; dispid 62;
    function ResetCard: Integer; dispid 63;
    function SaveFieldsToFile: Integer; dispid 64;
    function SaveParams: Integer; dispid 65;
    function SendEvent: Integer; dispid 66;
    function SetDefaults: Integer; dispid 67;
    function SetFieldParams: Integer; dispid 68;
    function SetSectorParams: Integer; dispid 69;
    function ShowDirectoryDlg: Integer; dispid 70;
    function ShowFirmsDlg: Integer; dispid 71;
    function ShowProperties: Integer; dispid 72;
    function ShowSearchDlg: Integer; dispid 73;
    function ShowTrailerDlg: Integer; dispid 74;
    function StartTransTimer: Integer; dispid 75;
    function StopTransTimer: Integer; dispid 76;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool; dispid 77;
    function WriteData: Integer; dispid 78;
    function WriteDirectory: Integer; dispid 79;
    function WriteFields: Integer; dispid 80;
    function WriteTrailer: Integer; dispid 81;
    property AccessMode0: Integer dispid 82;
    property AccessMode1: Integer dispid 83;
    property AccessMode2: Integer dispid 84;
    property AccessMode3: Integer dispid 85;
    property AppCode: Integer dispid 86;
    property ATQ: {??Word}OleVariant readonly dispid 87;
    property BaudRate: TBaudRate dispid 88;
    property BeepTone: Integer dispid 89;
    property BitCount: Integer dispid 90;
    property BlockAddr: Integer dispid 91;
    property BlockData: WideString dispid 92;
    property BlockDataHex: WideString dispid 93;
    property BlockNumber: Integer dispid 94;
    property BlockValue: Integer dispid 95;
    property CardDescription: WideString readonly dispid 96;
    property CardType: TCardType readonly dispid 97;
    property Command: TDataCommand dispid 98;
    property Connected: WordBool readonly dispid 99;
    property Data: WideString dispid 100;
    property DataLength: Integer dispid 101;
    property DataMode: TDataMode dispid 102;
    property DataSize: Integer dispid 103;
    property DeltaValue: Integer dispid 104;
    property DirectoryStatus: TDirectoryStatus readonly dispid 105;
    property DirectoryStatusText: WideString readonly dispid 106;
    property ErrorText: WideString readonly dispid 107;
    property ExecutionTime: Integer readonly dispid 108;
    property FieldCount: Integer readonly dispid 109;
    property FieldIndex: Integer dispid 110;
    property FieldSize: Integer dispid 111;
    property FieldType: Integer dispid 112;
    property FieldValue: WideString dispid 113;
    property FileName: WideString dispid 114;
    property FirmCode: Integer dispid 115;
    property IsClient1C: WordBool readonly dispid 116;
    property IsShowProperties: WordBool readonly dispid 117;
    property KeyA: WideString dispid 118;
    property KeyB: WideString dispid 119;
    property KeyEncoded: WideString dispid 120;
    property KeyNumber: Integer dispid 121;
    property KeyType: TKeyType dispid 122;
    property KeyUncoded: WideString dispid 123;
    property LibInfoKey: Integer dispid 124;
    property LockDevices: WordBool dispid 125;
    property NewKeyA: WideString dispid 126;
    property NewKeyB: WideString dispid 127;
    property ParentWnd: Integer dispid 128;
    property PasswordHeader: WideString readonly dispid 129;
    property PcdFwVersion: WideString readonly dispid 130;
    property PcdRicVersion: WideString readonly dispid 131;
    property PollInterval: Integer dispid 132;
    property PollStarted: WordBool readonly dispid 133;
    property PortNumber: Integer dispid 134;
    property ReqCode: TReqCode dispid 135;
    property ResultCode: Integer readonly dispid 136;
    property ResultDescription: WideString readonly dispid 137;
    property RfResetTime: Integer dispid 138;
    property RICValue: Integer dispid 139;
    property SAK: Byte readonly dispid 140;
    property SectorCount: Integer readonly dispid 141;
    property SectorIndex: Integer dispid 142;
    property SectorNumber: Integer dispid 143;
    property SelectCode: TSelectCode dispid 144;
    property Timeout: Integer dispid 145;
    property TransBlockNumber: Integer dispid 146;
    property TransTime: Integer dispid 147;
    property UID: WideString dispid 148;
    property UIDHex: WideString dispid 149;
    property UIDLen: Byte readonly dispid 150;
    property ValueOperation: TValueOperation dispid 151;
    property Version: WideString readonly dispid 152;
  end;

// *********************************************************************//
// DispIntf:  IMifareDrvEvents
// Flags:     (4096) Dispatchable
// GUID:      {F7F7EF32-F06D-4884-A4BC-62103A627967}
// *********************************************************************//
  IMifareDrvEvents = dispinterface
    ['{F7F7EF32-F06D-4884-A4BC-62103A627967}']
    procedure CardFound(const CardUIDHex: WideString); dispid 1;
    procedure PollError(ErrorCode: Integer; const ErrorText: WideString); dispid 2;
    procedure DriverEvent(EventID: Integer); dispid 201;
  end;

// *********************************************************************//
// Interface: IMifareDrv1
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F374ADB9-5526-496D-890F-52C1651042F5}
// *********************************************************************//
  IMifareDrv1 = interface(IMifareDrv)
    ['{F374ADB9-5526-496D-890F-52C1651042F5}']
    function MksFindCard: Integer; safecall;
    function MksReadCatalog: Integer; safecall;
    function MksReopen: Integer; safecall;
    function MksWriteCatalog: Integer; safecall;
    function ShowConnectionPropertiesDlg: Integer; safecall;
    function Get_CardATQ: Integer; safecall;
    procedure Set_CardATQ(Value: Integer); safecall;
    function Get_DeviceType: TDeviceType; safecall;
    procedure Set_DeviceType(Value: TDeviceType); safecall;
    function Get_Parity: Integer; safecall;
    procedure Set_Parity(Value: Integer); safecall;
    function Get_PortBaudRate: Integer; safecall;
    procedure Set_PortBaudRate(Value: Integer); safecall;
    function Get_RxData: WideString; safecall;
    function Get_RxDataHex: WideString; safecall;
    function Get_TxData: WideString; safecall;
    function Get_TxDataHex: WideString; safecall;
    function SleepMode: Integer; safecall;
    function Get_PollAutoDisable: WordBool; safecall;
    procedure Set_PollAutoDisable(Value: WordBool); safecall;
    property CardATQ: Integer read Get_CardATQ write Set_CardATQ;
    property DeviceType: TDeviceType read Get_DeviceType write Set_DeviceType;
    property Parity: Integer read Get_Parity write Set_Parity;
    property PortBaudRate: Integer read Get_PortBaudRate write Set_PortBaudRate;
    property RxData: WideString read Get_RxData;
    property RxDataHex: WideString read Get_RxDataHex;
    property TxData: WideString read Get_TxData;
    property TxDataHex: WideString read Get_TxDataHex;
    property PollAutoDisable: WordBool read Get_PollAutoDisable write Set_PollAutoDisable;
  end;

// *********************************************************************//
// DispIntf:  IMifareDrv1Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F374ADB9-5526-496D-890F-52C1651042F5}
// *********************************************************************//
  IMifareDrv1Disp = dispinterface
    ['{F374ADB9-5526-496D-890F-52C1651042F5}']
    function MksFindCard: Integer; dispid 153;
    function MksReadCatalog: Integer; dispid 154;
    function MksReopen: Integer; dispid 155;
    function MksWriteCatalog: Integer; dispid 156;
    function ShowConnectionPropertiesDlg: Integer; dispid 157;
    property CardATQ: Integer dispid 158;
    property DeviceType: TDeviceType dispid 159;
    property Parity: Integer dispid 160;
    property PortBaudRate: Integer dispid 161;
    property RxData: WideString readonly dispid 162;
    property RxDataHex: WideString readonly dispid 163;
    property TxData: WideString readonly dispid 164;
    property TxDataHex: WideString readonly dispid 165;
    function SleepMode: Integer; dispid 166;
    property PollAutoDisable: WordBool dispid 167;
    procedure AboutBox; dispid -552;
    function AddField: Integer; dispid 1;
    function AuthStandard: Integer; dispid 2;
    function ClearBlock: Integer; dispid 3;
    function ClearFieldValues: Integer; dispid 4;
    function ClosePort: Integer; dispid 5;
    function Connect: Integer; dispid 6;
    function DecodeTrailer: Integer; dispid 7;
    function DecodeValueBlock: Integer; dispid 8;
    function DeleteAllFields: Integer; dispid 9;
    function DeleteAppSectors: Integer; dispid 10;
    function DeleteField: Integer; dispid 11;
    function DeleteSector: Integer; dispid 12;
    function Disconnect: Integer; dispid 13;
    function EncodeKey: Integer; dispid 14;
    function EncodeTrailer: Integer; dispid 15;
    function EncodeValueBlock: Integer; dispid 16;
    function FindDevice: Integer; dispid 17;
    function GetFieldParams: Integer; dispid 18;
    function GetSectorParams: Integer; dispid 19;
    function InterfaceSetTimeout: Integer; dispid 20;
    function LoadFieldsFromFile: Integer; dispid 21;
    function LoadParams: Integer; dispid 22;
    function LoadValue: Integer; dispid 23;
    function OpenPort: Integer; dispid 24;
    function PcdBeep: Integer; dispid 25;
    function PcdConfig: Integer; dispid 26;
    function PcdGetFwVersion: Integer; dispid 27;
    function PcdGetRicVersion: Integer; dispid 28;
    function PcdGetSerialNumber: Integer; dispid 29;
    function PcdLoadKeyE2: Integer; dispid 30;
    function PcdReadE2: Integer; dispid 31;
    function PcdReset: Integer; dispid 32;
    function PcdRfReset: Integer; dispid 33;
    function PcdSetDefaultAttrib: Integer; dispid 34;
    function PcdSetTmo: Integer; dispid 35;
    function PcdWriteE2: Integer; dispid 36;
    function PiccActivateIdle: Integer; dispid 37;
    function PiccActivateWakeup: Integer; dispid 38;
    function PiccAnticoll: Integer; dispid 39;
    function PiccAuth: Integer; dispid 40;
    function PiccAuthE2: Integer; dispid 41;
    function PiccAuthKey: Integer; dispid 42;
    function PiccCascAnticoll: Integer; dispid 43;
    function PiccCascSelect: Integer; dispid 44;
    function PiccCommonRead: Integer; dispid 45;
    function PiccCommonRequest: Integer; dispid 46;
    function PiccCommonWrite: Integer; dispid 47;
    function PiccHalt: Integer; dispid 48;
    function PiccRead: Integer; dispid 49;
    function PiccSelect: Integer; dispid 50;
    function PiccValue: Integer; dispid 51;
    function PiccValueDebit: Integer; dispid 52;
    function PiccWrite: Integer; dispid 53;
    function PollStart: Integer; dispid 54;
    function PollStop: Integer; dispid 55;
    function PortOpened: Integer; dispid 56;
    function ReadData: Integer; dispid 57;
    function ReadDirectory: Integer; dispid 58;
    function ReadFields: Integer; dispid 59;
    function ReadTrailer: Integer; dispid 60;
    function RequestAll: Integer; dispid 61;
    function RequestIdle: Integer; dispid 62;
    function ResetCard: Integer; dispid 63;
    function SaveFieldsToFile: Integer; dispid 64;
    function SaveParams: Integer; dispid 65;
    function SendEvent: Integer; dispid 66;
    function SetDefaults: Integer; dispid 67;
    function SetFieldParams: Integer; dispid 68;
    function SetSectorParams: Integer; dispid 69;
    function ShowDirectoryDlg: Integer; dispid 70;
    function ShowFirmsDlg: Integer; dispid 71;
    function ShowProperties: Integer; dispid 72;
    function ShowSearchDlg: Integer; dispid 73;
    function ShowTrailerDlg: Integer; dispid 74;
    function StartTransTimer: Integer; dispid 75;
    function StopTransTimer: Integer; dispid 76;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool; dispid 77;
    function WriteData: Integer; dispid 78;
    function WriteDirectory: Integer; dispid 79;
    function WriteFields: Integer; dispid 80;
    function WriteTrailer: Integer; dispid 81;
    property AccessMode0: Integer dispid 82;
    property AccessMode1: Integer dispid 83;
    property AccessMode2: Integer dispid 84;
    property AccessMode3: Integer dispid 85;
    property AppCode: Integer dispid 86;
    property ATQ: {??Word}OleVariant readonly dispid 87;
    property BaudRate: TBaudRate dispid 88;
    property BeepTone: Integer dispid 89;
    property BitCount: Integer dispid 90;
    property BlockAddr: Integer dispid 91;
    property BlockData: WideString dispid 92;
    property BlockDataHex: WideString dispid 93;
    property BlockNumber: Integer dispid 94;
    property BlockValue: Integer dispid 95;
    property CardDescription: WideString readonly dispid 96;
    property CardType: TCardType readonly dispid 97;
    property Command: TDataCommand dispid 98;
    property Connected: WordBool readonly dispid 99;
    property Data: WideString dispid 100;
    property DataLength: Integer dispid 101;
    property DataMode: TDataMode dispid 102;
    property DataSize: Integer dispid 103;
    property DeltaValue: Integer dispid 104;
    property DirectoryStatus: TDirectoryStatus readonly dispid 105;
    property DirectoryStatusText: WideString readonly dispid 106;
    property ErrorText: WideString readonly dispid 107;
    property ExecutionTime: Integer readonly dispid 108;
    property FieldCount: Integer readonly dispid 109;
    property FieldIndex: Integer dispid 110;
    property FieldSize: Integer dispid 111;
    property FieldType: Integer dispid 112;
    property FieldValue: WideString dispid 113;
    property FileName: WideString dispid 114;
    property FirmCode: Integer dispid 115;
    property IsClient1C: WordBool readonly dispid 116;
    property IsShowProperties: WordBool readonly dispid 117;
    property KeyA: WideString dispid 118;
    property KeyB: WideString dispid 119;
    property KeyEncoded: WideString dispid 120;
    property KeyNumber: Integer dispid 121;
    property KeyType: TKeyType dispid 122;
    property KeyUncoded: WideString dispid 123;
    property LibInfoKey: Integer dispid 124;
    property LockDevices: WordBool dispid 125;
    property NewKeyA: WideString dispid 126;
    property NewKeyB: WideString dispid 127;
    property ParentWnd: Integer dispid 128;
    property PasswordHeader: WideString readonly dispid 129;
    property PcdFwVersion: WideString readonly dispid 130;
    property PcdRicVersion: WideString readonly dispid 131;
    property PollInterval: Integer dispid 132;
    property PollStarted: WordBool readonly dispid 133;
    property PortNumber: Integer dispid 134;
    property ReqCode: TReqCode dispid 135;
    property ResultCode: Integer readonly dispid 136;
    property ResultDescription: WideString readonly dispid 137;
    property RfResetTime: Integer dispid 138;
    property RICValue: Integer dispid 139;
    property SAK: Byte readonly dispid 140;
    property SectorCount: Integer readonly dispid 141;
    property SectorIndex: Integer dispid 142;
    property SectorNumber: Integer dispid 143;
    property SelectCode: TSelectCode dispid 144;
    property Timeout: Integer dispid 145;
    property TransBlockNumber: Integer dispid 146;
    property TransTime: Integer dispid 147;
    property UID: WideString dispid 148;
    property UIDHex: WideString dispid 149;
    property UIDLen: Byte readonly dispid 150;
    property ValueOperation: TValueOperation dispid 151;
    property Version: WideString readonly dispid 152;
  end;

// *********************************************************************//
// Interface: IMIfareDrv2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {244EC6AA-F110-4835-BB5C-013D50E71518}
// *********************************************************************//
  IMIfareDrv2 = interface(IMifareDrv1)
    ['{244EC6AA-F110-4835-BB5C-013D50E71518}']
    function Get_ReaderName: WideString; safecall;
    procedure Set_ReaderName(const Value: WideString); safecall;
    function Get_DataAuthMode: TDataAuthMode; safecall;
    procedure Set_DataAuthMode(Value: TDataAuthMode); safecall;
    function Get_UpdateTrailer: WordBool; safecall;
    procedure Set_UpdateTrailer(Value: WordBool); safecall;
    function Get_DataFormat: TDataFormat; safecall;
    procedure Set_DataFormat(Value: TDataFormat); safecall;
    function Get_LogEnabled: WordBool; safecall;
    procedure Set_LogEnabled(Value: WordBool); safecall;
    function Get_LogFileName: WideString; safecall;
    procedure Set_LogFileName(const Value: WideString); safecall;
    function Get_RedLED: WordBool; safecall;
    procedure Set_RedLED(Value: WordBool); safecall;
    function Get_GreenLED: WordBool; safecall;
    procedure Set_GreenLED(Value: WordBool); safecall;
    function Get_BlueLED: WordBool; safecall;
    procedure Set_BlueLED(Value: WordBool); safecall;
    function Get_ButtonState: WordBool; safecall;
    function PcdControlLEDAndPoll: Integer; safecall;
    function PcdControlLED: Integer; safecall;
    function PcdPollButton: Integer; safecall;
    property ReaderName: WideString read Get_ReaderName write Set_ReaderName;
    property DataAuthMode: TDataAuthMode read Get_DataAuthMode write Set_DataAuthMode;
    property UpdateTrailer: WordBool read Get_UpdateTrailer write Set_UpdateTrailer;
    property DataFormat: TDataFormat read Get_DataFormat write Set_DataFormat;
    property LogEnabled: WordBool read Get_LogEnabled write Set_LogEnabled;
    property LogFileName: WideString read Get_LogFileName write Set_LogFileName;
    property RedLED: WordBool read Get_RedLED write Set_RedLED;
    property GreenLED: WordBool read Get_GreenLED write Set_GreenLED;
    property BlueLED: WordBool read Get_BlueLED write Set_BlueLED;
    property ButtonState: WordBool read Get_ButtonState;
  end;

// *********************************************************************//
// DispIntf:  IMIfareDrv2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {244EC6AA-F110-4835-BB5C-013D50E71518}
// *********************************************************************//
  IMIfareDrv2Disp = dispinterface
    ['{244EC6AA-F110-4835-BB5C-013D50E71518}']
    property ReaderName: WideString dispid 168;
    property DataAuthMode: TDataAuthMode dispid 169;
    property UpdateTrailer: WordBool dispid 170;
    property DataFormat: TDataFormat dispid 171;
    property LogEnabled: WordBool dispid 172;
    property LogFileName: WideString dispid 173;
    property RedLED: WordBool dispid 401;
    property GreenLED: WordBool dispid 402;
    property BlueLED: WordBool dispid 403;
    property ButtonState: WordBool readonly dispid 404;
    function PcdControlLEDAndPoll: Integer; dispid 405;
    function PcdControlLED: Integer; dispid 406;
    function PcdPollButton: Integer; dispid 407;
    function MksFindCard: Integer; dispid 153;
    function MksReadCatalog: Integer; dispid 154;
    function MksReopen: Integer; dispid 155;
    function MksWriteCatalog: Integer; dispid 156;
    function ShowConnectionPropertiesDlg: Integer; dispid 157;
    property CardATQ: Integer dispid 158;
    property DeviceType: TDeviceType dispid 159;
    property Parity: Integer dispid 160;
    property PortBaudRate: Integer dispid 161;
    property RxData: WideString readonly dispid 162;
    property RxDataHex: WideString readonly dispid 163;
    property TxData: WideString readonly dispid 164;
    property TxDataHex: WideString readonly dispid 165;
    function SleepMode: Integer; dispid 166;
    property PollAutoDisable: WordBool dispid 167;
    procedure AboutBox; dispid -552;
    function AddField: Integer; dispid 1;
    function AuthStandard: Integer; dispid 2;
    function ClearBlock: Integer; dispid 3;
    function ClearFieldValues: Integer; dispid 4;
    function ClosePort: Integer; dispid 5;
    function Connect: Integer; dispid 6;
    function DecodeTrailer: Integer; dispid 7;
    function DecodeValueBlock: Integer; dispid 8;
    function DeleteAllFields: Integer; dispid 9;
    function DeleteAppSectors: Integer; dispid 10;
    function DeleteField: Integer; dispid 11;
    function DeleteSector: Integer; dispid 12;
    function Disconnect: Integer; dispid 13;
    function EncodeKey: Integer; dispid 14;
    function EncodeTrailer: Integer; dispid 15;
    function EncodeValueBlock: Integer; dispid 16;
    function FindDevice: Integer; dispid 17;
    function GetFieldParams: Integer; dispid 18;
    function GetSectorParams: Integer; dispid 19;
    function InterfaceSetTimeout: Integer; dispid 20;
    function LoadFieldsFromFile: Integer; dispid 21;
    function LoadParams: Integer; dispid 22;
    function LoadValue: Integer; dispid 23;
    function OpenPort: Integer; dispid 24;
    function PcdBeep: Integer; dispid 25;
    function PcdConfig: Integer; dispid 26;
    function PcdGetFwVersion: Integer; dispid 27;
    function PcdGetRicVersion: Integer; dispid 28;
    function PcdGetSerialNumber: Integer; dispid 29;
    function PcdLoadKeyE2: Integer; dispid 30;
    function PcdReadE2: Integer; dispid 31;
    function PcdReset: Integer; dispid 32;
    function PcdRfReset: Integer; dispid 33;
    function PcdSetDefaultAttrib: Integer; dispid 34;
    function PcdSetTmo: Integer; dispid 35;
    function PcdWriteE2: Integer; dispid 36;
    function PiccActivateIdle: Integer; dispid 37;
    function PiccActivateWakeup: Integer; dispid 38;
    function PiccAnticoll: Integer; dispid 39;
    function PiccAuth: Integer; dispid 40;
    function PiccAuthE2: Integer; dispid 41;
    function PiccAuthKey: Integer; dispid 42;
    function PiccCascAnticoll: Integer; dispid 43;
    function PiccCascSelect: Integer; dispid 44;
    function PiccCommonRead: Integer; dispid 45;
    function PiccCommonRequest: Integer; dispid 46;
    function PiccCommonWrite: Integer; dispid 47;
    function PiccHalt: Integer; dispid 48;
    function PiccRead: Integer; dispid 49;
    function PiccSelect: Integer; dispid 50;
    function PiccValue: Integer; dispid 51;
    function PiccValueDebit: Integer; dispid 52;
    function PiccWrite: Integer; dispid 53;
    function PollStart: Integer; dispid 54;
    function PollStop: Integer; dispid 55;
    function PortOpened: Integer; dispid 56;
    function ReadData: Integer; dispid 57;
    function ReadDirectory: Integer; dispid 58;
    function ReadFields: Integer; dispid 59;
    function ReadTrailer: Integer; dispid 60;
    function RequestAll: Integer; dispid 61;
    function RequestIdle: Integer; dispid 62;
    function ResetCard: Integer; dispid 63;
    function SaveFieldsToFile: Integer; dispid 64;
    function SaveParams: Integer; dispid 65;
    function SendEvent: Integer; dispid 66;
    function SetDefaults: Integer; dispid 67;
    function SetFieldParams: Integer; dispid 68;
    function SetSectorParams: Integer; dispid 69;
    function ShowDirectoryDlg: Integer; dispid 70;
    function ShowFirmsDlg: Integer; dispid 71;
    function ShowProperties: Integer; dispid 72;
    function ShowSearchDlg: Integer; dispid 73;
    function ShowTrailerDlg: Integer; dispid 74;
    function StartTransTimer: Integer; dispid 75;
    function StopTransTimer: Integer; dispid 76;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool; dispid 77;
    function WriteData: Integer; dispid 78;
    function WriteDirectory: Integer; dispid 79;
    function WriteFields: Integer; dispid 80;
    function WriteTrailer: Integer; dispid 81;
    property AccessMode0: Integer dispid 82;
    property AccessMode1: Integer dispid 83;
    property AccessMode2: Integer dispid 84;
    property AccessMode3: Integer dispid 85;
    property AppCode: Integer dispid 86;
    property ATQ: {??Word}OleVariant readonly dispid 87;
    property BaudRate: TBaudRate dispid 88;
    property BeepTone: Integer dispid 89;
    property BitCount: Integer dispid 90;
    property BlockAddr: Integer dispid 91;
    property BlockData: WideString dispid 92;
    property BlockDataHex: WideString dispid 93;
    property BlockNumber: Integer dispid 94;
    property BlockValue: Integer dispid 95;
    property CardDescription: WideString readonly dispid 96;
    property CardType: TCardType readonly dispid 97;
    property Command: TDataCommand dispid 98;
    property Connected: WordBool readonly dispid 99;
    property Data: WideString dispid 100;
    property DataLength: Integer dispid 101;
    property DataMode: TDataMode dispid 102;
    property DataSize: Integer dispid 103;
    property DeltaValue: Integer dispid 104;
    property DirectoryStatus: TDirectoryStatus readonly dispid 105;
    property DirectoryStatusText: WideString readonly dispid 106;
    property ErrorText: WideString readonly dispid 107;
    property ExecutionTime: Integer readonly dispid 108;
    property FieldCount: Integer readonly dispid 109;
    property FieldIndex: Integer dispid 110;
    property FieldSize: Integer dispid 111;
    property FieldType: Integer dispid 112;
    property FieldValue: WideString dispid 113;
    property FileName: WideString dispid 114;
    property FirmCode: Integer dispid 115;
    property IsClient1C: WordBool readonly dispid 116;
    property IsShowProperties: WordBool readonly dispid 117;
    property KeyA: WideString dispid 118;
    property KeyB: WideString dispid 119;
    property KeyEncoded: WideString dispid 120;
    property KeyNumber: Integer dispid 121;
    property KeyType: TKeyType dispid 122;
    property KeyUncoded: WideString dispid 123;
    property LibInfoKey: Integer dispid 124;
    property LockDevices: WordBool dispid 125;
    property NewKeyA: WideString dispid 126;
    property NewKeyB: WideString dispid 127;
    property ParentWnd: Integer dispid 128;
    property PasswordHeader: WideString readonly dispid 129;
    property PcdFwVersion: WideString readonly dispid 130;
    property PcdRicVersion: WideString readonly dispid 131;
    property PollInterval: Integer dispid 132;
    property PollStarted: WordBool readonly dispid 133;
    property PortNumber: Integer dispid 134;
    property ReqCode: TReqCode dispid 135;
    property ResultCode: Integer readonly dispid 136;
    property ResultDescription: WideString readonly dispid 137;
    property RfResetTime: Integer dispid 138;
    property RICValue: Integer dispid 139;
    property SAK: Byte readonly dispid 140;
    property SectorCount: Integer readonly dispid 141;
    property SectorIndex: Integer dispid 142;
    property SectorNumber: Integer dispid 143;
    property SelectCode: TSelectCode dispid 144;
    property Timeout: Integer dispid 145;
    property TransBlockNumber: Integer dispid 146;
    property TransTime: Integer dispid 147;
    property UID: WideString dispid 148;
    property UIDHex: WideString dispid 149;
    property UIDLen: Byte readonly dispid 150;
    property ValueOperation: TValueOperation dispid 151;
    property Version: WideString readonly dispid 152;
  end;

// *********************************************************************//
// Interface: IMifareDrv3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EE43D29A-EE86-4604-80E6-742A9E1B6790}
// *********************************************************************//
  IMifareDrv3 = interface(IMIfareDrv2)
    ['{EE43D29A-EE86-4604-80E6-742A9E1B6790}']
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
    function Get_DriverID: Integer; safecall;
    function LockReader: Integer; safecall;
    function UnlockReader: Integer; safecall;
    function Get_YellowLED: WordBool; safecall;
    procedure Set_YellowLED(Value: WordBool); safecall;
    function SAM_GetVersion: Integer; safecall;
    function Get_SAMVersion: TSAMVersion; safecall;
    function SAM_WriteKey: Integer; safecall;
    function Get_KeyPosition: Integer; safecall;
    procedure Set_KeyPosition(Value: Integer); safecall;
    function Get_KeyVersion: Integer; safecall;
    procedure Set_KeyVersion(Value: Integer); safecall;
    function SAM_AuthKey: Integer; safecall;
    function Get_LogFilePath: WideString; safecall;
    procedure Set_LogFilePath(const Value: WideString); safecall;
    function Get_ParamsRegKey: WideString; safecall;
    procedure Set_ParamsRegKey(const Value: WideString); safecall;
    function SAM_WriteHostAuthKey: Integer; safecall;
    function SAM_GetKeyEntry: Integer; safecall;
    function ReadFullSerialNumber: Integer; safecall;
    function SAM_SetProtection: Integer; safecall;
    function SAM_SetProtectionSN: Integer; safecall;
    function Get_KeyEntryNumber: Integer; safecall;
    procedure Set_KeyEntryNumber(Value: Integer); safecall;
    function Get_KeyVersion0: Integer; safecall;
    function Get_KeyVersion1: Integer; safecall;
    function Get_KeyVersion2: Integer; safecall;
    function Get_SerialNumber: WideString; safecall;
    procedure Set_SerialNumber(const Value: WideString); safecall;
    function Get_SerialNumberHex: WideString; safecall;
    procedure Set_SerialNumberHex(const Value: WideString); safecall;
    function Get_KeyTypeText: WideString; safecall;
    function WriteConnectionParams: Integer; safecall;
    function Get_ErrorOnCorruptedValueBlock: WordBool; safecall;
    procedure Set_ErrorOnCorruptedValueBlock(Value: WordBool); safecall;
    function Get_IsValueBlockCorrupted: WordBool; safecall;
    function UltralightRead: Integer; safecall;
    function UltralightWrite: Integer; safecall;
    function UltralightCompatWrite: Integer; safecall;
    function UltralightWriteKey: Integer; safecall;
    function UltralightAuth: Integer; safecall;
    function MifarePlusWritePerso: Integer; safecall;
    function MifarePlusWriteParameters: Integer; safecall;
    function MifarePlusCommitPerso: Integer; safecall;
    function Get_ReceiveDivisor: Integer; safecall;
    procedure Set_ReceiveDivisor(Value: Integer); safecall;
    function Get_SendDivisor: Integer; safecall;
    procedure Set_SendDivisor(Value: Integer); safecall;
    function MifarePlusAuthSL1: Integer; safecall;
    function MifarePlusAuthSL3: Integer; safecall;
    function MifarePlusIncrement: Integer; safecall;
    function MifarePlusDecrement: Integer; safecall;
    function MifarePlusIncrementTransfer: Integer; safecall;
    function MifarePlusDecrementTransfer: Integer; safecall;
    function MifarePlusRead: Integer; safecall;
    function MifarePlusRestore: Integer; safecall;
    function MifarePlusTransfer: Integer; safecall;
    function MifarePlusReadValue: Integer; safecall;
    function MifarePlusWriteValue: Integer; safecall;
    function MifarePlusMultiblockRead: Integer; safecall;
    function MifarePlusMultiblockWrite: Integer; safecall;
    function MifarePlusResetAuthentication: Integer; safecall;
    function Get_AuthType: Integer; safecall;
    procedure Set_AuthType(Value: Integer); safecall;
    function Get_BlockCount: Integer; safecall;
    procedure Set_BlockCount(Value: Integer); safecall;
    function MifarePlusWrite: Integer; safecall;
    function Get_NewBaudRate: Integer; safecall;
    procedure Set_NewBaudRate(Value: Integer); safecall;
    function ClearResult: Integer; safecall;
    function Get_SAMHWVendorID: Integer; safecall;
    function Get_SAMHWVendorName: WideString; safecall;
    function Get_SAMHWType: Integer; safecall;
    function Get_SAMHWSubType: Integer; safecall;
    function Get_SAMHWMajorVersion: Integer; safecall;
    function Get_SAMHWMinorVersion: Integer; safecall;
    function Get_SAMHWProtocol: Integer; safecall;
    function Get_SAMHWStorageSize: Integer; safecall;
    function Get_SAMHWStorageSizeCode: Integer; safecall;
    function Get_SAMSWVendorID: Integer; safecall;
    function Get_SAMSWVendorName: WideString; safecall;
    function Get_SAMSWType: Integer; safecall;
    function Get_SAMSWSubType: Integer; safecall;
    function Get_SAMSWMajorVersion: Integer; safecall;
    function Get_SAMSWMinorVersion: Integer; safecall;
    function Get_SAMSWProtocol: Integer; safecall;
    function Get_SAMSWStorageSize: Integer; safecall;
    function Get_SAMSWStorageSizeCode: Integer; safecall;
    function Get_SAMMode: Integer; safecall;
    function Get_SAMModeName: WideString; safecall;
    function Get_SAMMDUID: Integer; safecall;
    function Get_SAMMDUIDHex: WideString; safecall;
    function Get_SAMMDBatchNo: Integer; safecall;
    function Get_SAMMDProductionDay: Integer; safecall;
    function Get_SAMMDProductionMonth: Integer; safecall;
    function Get_SAMMDProductionYear: Integer; safecall;
    function Get_SAMMDGlobalCryptoSettings: Integer; safecall;
    function Get_SAMMDUIDStr: WideString; safecall;
    function EnableCardAccept: Integer; safecall;
    function DisableCardAccept: Integer; safecall;
    function ReadStatus: Integer; safecall;
    function IssueCard: Integer; safecall;
    function HoldCard: Integer; safecall;
    function ReadLastAnswer: Integer; safecall;
    function Get_Protocol: Integer; safecall;
    procedure Set_Protocol(Value: Integer); safecall;
    function MifarePlusAuthSL2: Integer; safecall;
    function SAMAV2WriteKey: Integer; safecall;
    function Get_EncryptionEnabled: WordBool; safecall;
    procedure Set_EncryptionEnabled(Value: WordBool); safecall;
    function Get_AnswerSignature: WordBool; safecall;
    procedure Set_AnswerSignature(Value: WordBool); safecall;
    function Get_CommandSignature: WordBool; safecall;
    procedure Set_CommandSignature(Value: WordBool); safecall;
    function MifarePlusMultiblockReadSL2: Integer; safecall;
    function MifarePlusMultiblockWriteSL2: Integer; safecall;
    function MifarePlusAuthSL2Crypto1: Integer; safecall;
    function WriteEncryptedData: Integer; safecall;
    function Get_PollActivateMethod: TPollActivateMethod; safecall;
    procedure Set_PollActivateMethod(Value: TPollActivateMethod); safecall;
    property EventID: Integer read Get_EventID write Set_EventID;
    property EventDriverID: Integer read Get_EventDriverID;
    property EventType: Integer read Get_EventType;
    property EventPortNumber: Integer read Get_EventPortNumber;
    property EventErrorCode: Integer read Get_EventErrorCode;
    property EventErrorText: WideString read Get_EventErrorText;
    property EventCardUIDHex: WideString read Get_EventCardUIDHex;
    property EventsEnabled: WordBool read Get_EventsEnabled write Set_EventsEnabled;
    property EventCount: Integer read Get_EventCount;
    property DriverID: Integer read Get_DriverID;
    property YellowLED: WordBool read Get_YellowLED write Set_YellowLED;
    property SAMVersion: TSAMVersion read Get_SAMVersion;
    property KeyPosition: Integer read Get_KeyPosition write Set_KeyPosition;
    property KeyVersion: Integer read Get_KeyVersion write Set_KeyVersion;
    property LogFilePath: WideString read Get_LogFilePath write Set_LogFilePath;
    property ParamsRegKey: WideString read Get_ParamsRegKey write Set_ParamsRegKey;
    property KeyEntryNumber: Integer read Get_KeyEntryNumber write Set_KeyEntryNumber;
    property KeyVersion0: Integer read Get_KeyVersion0;
    property KeyVersion1: Integer read Get_KeyVersion1;
    property KeyVersion2: Integer read Get_KeyVersion2;
    property SerialNumber: WideString read Get_SerialNumber write Set_SerialNumber;
    property SerialNumberHex: WideString read Get_SerialNumberHex write Set_SerialNumberHex;
    property KeyTypeText: WideString read Get_KeyTypeText;
    property ErrorOnCorruptedValueBlock: WordBool read Get_ErrorOnCorruptedValueBlock write Set_ErrorOnCorruptedValueBlock;
    property IsValueBlockCorrupted: WordBool read Get_IsValueBlockCorrupted;
    property ReceiveDivisor: Integer read Get_ReceiveDivisor write Set_ReceiveDivisor;
    property SendDivisor: Integer read Get_SendDivisor write Set_SendDivisor;
    property AuthType: Integer read Get_AuthType write Set_AuthType;
    property BlockCount: Integer read Get_BlockCount write Set_BlockCount;
    property NewBaudRate: Integer read Get_NewBaudRate write Set_NewBaudRate;
    property SAMHWVendorID: Integer read Get_SAMHWVendorID;
    property SAMHWVendorName: WideString read Get_SAMHWVendorName;
    property SAMHWType: Integer read Get_SAMHWType;
    property SAMHWSubType: Integer read Get_SAMHWSubType;
    property SAMHWMajorVersion: Integer read Get_SAMHWMajorVersion;
    property SAMHWMinorVersion: Integer read Get_SAMHWMinorVersion;
    property SAMHWProtocol: Integer read Get_SAMHWProtocol;
    property SAMHWStorageSize: Integer read Get_SAMHWStorageSize;
    property SAMHWStorageSizeCode: Integer read Get_SAMHWStorageSizeCode;
    property SAMSWVendorID: Integer read Get_SAMSWVendorID;
    property SAMSWVendorName: WideString read Get_SAMSWVendorName;
    property SAMSWType: Integer read Get_SAMSWType;
    property SAMSWSubType: Integer read Get_SAMSWSubType;
    property SAMSWMajorVersion: Integer read Get_SAMSWMajorVersion;
    property SAMSWMinorVersion: Integer read Get_SAMSWMinorVersion;
    property SAMSWProtocol: Integer read Get_SAMSWProtocol;
    property SAMSWStorageSize: Integer read Get_SAMSWStorageSize;
    property SAMSWStorageSizeCode: Integer read Get_SAMSWStorageSizeCode;
    property SAMMode: Integer read Get_SAMMode;
    property SAMModeName: WideString read Get_SAMModeName;
    property SAMMDUID: Integer read Get_SAMMDUID;
    property SAMMDUIDHex: WideString read Get_SAMMDUIDHex;
    property SAMMDBatchNo: Integer read Get_SAMMDBatchNo;
    property SAMMDProductionDay: Integer read Get_SAMMDProductionDay;
    property SAMMDProductionMonth: Integer read Get_SAMMDProductionMonth;
    property SAMMDProductionYear: Integer read Get_SAMMDProductionYear;
    property SAMMDGlobalCryptoSettings: Integer read Get_SAMMDGlobalCryptoSettings;
    property SAMMDUIDStr: WideString read Get_SAMMDUIDStr;
    property Protocol: Integer read Get_Protocol write Set_Protocol;
    property EncryptionEnabled: WordBool read Get_EncryptionEnabled write Set_EncryptionEnabled;
    property AnswerSignature: WordBool read Get_AnswerSignature write Set_AnswerSignature;
    property CommandSignature: WordBool read Get_CommandSignature write Set_CommandSignature;
    property PollActivateMethod: TPollActivateMethod read Get_PollActivateMethod write Set_PollActivateMethod;
  end;

// *********************************************************************//
// DispIntf:  IMifareDrv3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EE43D29A-EE86-4604-80E6-742A9E1B6790}
// *********************************************************************//
  IMifareDrv3Disp = dispinterface
    ['{EE43D29A-EE86-4604-80E6-742A9E1B6790}']
    property EventID: Integer dispid 501;
    property EventDriverID: Integer readonly dispid 502;
    property EventType: Integer readonly dispid 503;
    property EventPortNumber: Integer readonly dispid 504;
    property EventErrorCode: Integer readonly dispid 505;
    property EventErrorText: WideString readonly dispid 506;
    property EventCardUIDHex: WideString readonly dispid 507;
    function FindEvent: Integer; dispid 508;
    function DeleteEvent: Integer; dispid 509;
    property EventsEnabled: WordBool dispid 510;
    function ClearEvents: Integer; dispid 512;
    property EventCount: Integer readonly dispid 513;
    property DriverID: Integer readonly dispid 511;
    function LockReader: Integer; dispid 514;
    function UnlockReader: Integer; dispid 515;
    property YellowLED: WordBool dispid 516;
    function SAM_GetVersion: Integer; dispid 517;
    property SAMVersion: {??TSAMVersion}OleVariant readonly dispid 518;
    function SAM_WriteKey: Integer; dispid 519;
    property KeyPosition: Integer dispid 520;
    property KeyVersion: Integer dispid 521;
    function SAM_AuthKey: Integer; dispid 522;
    property LogFilePath: WideString dispid 523;
    property ParamsRegKey: WideString dispid 524;
    function SAM_WriteHostAuthKey: Integer; dispid 525;
    function SAM_GetKeyEntry: Integer; dispid 526;
    function ReadFullSerialNumber: Integer; dispid 527;
    function SAM_SetProtection: Integer; dispid 528;
    function SAM_SetProtectionSN: Integer; dispid 529;
    property KeyEntryNumber: Integer dispid 530;
    property KeyVersion0: Integer readonly dispid 531;
    property KeyVersion1: Integer readonly dispid 532;
    property KeyVersion2: Integer readonly dispid 533;
    property SerialNumber: WideString dispid 534;
    property SerialNumberHex: WideString dispid 535;
    property KeyTypeText: WideString readonly dispid 536;
    function WriteConnectionParams: Integer; dispid 537;
    property ErrorOnCorruptedValueBlock: WordBool dispid 538;
    property IsValueBlockCorrupted: WordBool readonly dispid 539;
    function UltralightRead: Integer; dispid 540;
    function UltralightWrite: Integer; dispid 541;
    function UltralightCompatWrite: Integer; dispid 542;
    function UltralightWriteKey: Integer; dispid 543;
    function UltralightAuth: Integer; dispid 544;
    function MifarePlusWritePerso: Integer; dispid 545;
    function MifarePlusWriteParameters: Integer; dispid 546;
    function MifarePlusCommitPerso: Integer; dispid 547;
    property ReceiveDivisor: Integer dispid 548;
    property SendDivisor: Integer dispid 549;
    function MifarePlusAuthSL1: Integer; dispid 550;
    function MifarePlusAuthSL3: Integer; dispid 551;
    function MifarePlusIncrement: Integer; dispid 552;
    function MifarePlusDecrement: Integer; dispid 553;
    function MifarePlusIncrementTransfer: Integer; dispid 554;
    function MifarePlusDecrementTransfer: Integer; dispid 555;
    function MifarePlusRead: Integer; dispid 556;
    function MifarePlusRestore: Integer; dispid 557;
    function MifarePlusTransfer: Integer; dispid 558;
    function MifarePlusReadValue: Integer; dispid 559;
    function MifarePlusWriteValue: Integer; dispid 560;
    function MifarePlusMultiblockRead: Integer; dispid 561;
    function MifarePlusMultiblockWrite: Integer; dispid 562;
    function MifarePlusResetAuthentication: Integer; dispid 563;
    property AuthType: Integer dispid 564;
    property BlockCount: Integer dispid 565;
    function MifarePlusWrite: Integer; dispid 566;
    property NewBaudRate: Integer dispid 567;
    function ClearResult: Integer; dispid 568;
    property SAMHWVendorID: Integer readonly dispid 569;
    property SAMHWVendorName: WideString readonly dispid 570;
    property SAMHWType: Integer readonly dispid 571;
    property SAMHWSubType: Integer readonly dispid 572;
    property SAMHWMajorVersion: Integer readonly dispid 573;
    property SAMHWMinorVersion: Integer readonly dispid 574;
    property SAMHWProtocol: Integer readonly dispid 575;
    property SAMHWStorageSize: Integer readonly dispid 576;
    property SAMHWStorageSizeCode: Integer readonly dispid 577;
    property SAMSWVendorID: Integer readonly dispid 578;
    property SAMSWVendorName: WideString readonly dispid 579;
    property SAMSWType: Integer readonly dispid 580;
    property SAMSWSubType: Integer readonly dispid 581;
    property SAMSWMajorVersion: Integer readonly dispid 582;
    property SAMSWMinorVersion: Integer readonly dispid 583;
    property SAMSWProtocol: Integer readonly dispid 584;
    property SAMSWStorageSize: Integer readonly dispid 585;
    property SAMSWStorageSizeCode: Integer readonly dispid 586;
    property SAMMode: Integer readonly dispid 587;
    property SAMModeName: WideString readonly dispid 588;
    property SAMMDUID: Integer readonly dispid 589;
    property SAMMDUIDHex: WideString readonly dispid 590;
    property SAMMDBatchNo: Integer readonly dispid 591;
    property SAMMDProductionDay: Integer readonly dispid 592;
    property SAMMDProductionMonth: Integer readonly dispid 593;
    property SAMMDProductionYear: Integer readonly dispid 594;
    property SAMMDGlobalCryptoSettings: Integer readonly dispid 595;
    property SAMMDUIDStr: WideString readonly dispid 596;
    function EnableCardAccept: Integer; dispid 597;
    function DisableCardAccept: Integer; dispid 598;
    function ReadStatus: Integer; dispid 599;
    function IssueCard: Integer; dispid 600;
    function HoldCard: Integer; dispid 601;
    function ReadLastAnswer: Integer; dispid 602;
    property Protocol: Integer dispid 603;
    function MifarePlusAuthSL2: Integer; dispid 604;
    function SAMAV2WriteKey: Integer; dispid 605;
    property EncryptionEnabled: WordBool dispid 606;
    property AnswerSignature: WordBool dispid 607;
    property CommandSignature: WordBool dispid 608;
    function MifarePlusMultiblockReadSL2: Integer; dispid 609;
    function MifarePlusMultiblockWriteSL2: Integer; dispid 610;
    function MifarePlusAuthSL2Crypto1: Integer; dispid 611;
    function WriteEncryptedData: Integer; dispid 612;
    property PollActivateMethod: TPollActivateMethod dispid 613;
    property ReaderName: WideString dispid 168;
    property DataAuthMode: TDataAuthMode dispid 169;
    property UpdateTrailer: WordBool dispid 170;
    property DataFormat: TDataFormat dispid 171;
    property LogEnabled: WordBool dispid 172;
    property LogFileName: WideString dispid 173;
    property RedLED: WordBool dispid 401;
    property GreenLED: WordBool dispid 402;
    property BlueLED: WordBool dispid 403;
    property ButtonState: WordBool readonly dispid 404;
    function PcdControlLEDAndPoll: Integer; dispid 405;
    function PcdControlLED: Integer; dispid 406;
    function PcdPollButton: Integer; dispid 407;
    function MksFindCard: Integer; dispid 153;
    function MksReadCatalog: Integer; dispid 154;
    function MksReopen: Integer; dispid 155;
    function MksWriteCatalog: Integer; dispid 156;
    function ShowConnectionPropertiesDlg: Integer; dispid 157;
    property CardATQ: Integer dispid 158;
    property DeviceType: TDeviceType dispid 159;
    property Parity: Integer dispid 160;
    property PortBaudRate: Integer dispid 161;
    property RxData: WideString readonly dispid 162;
    property RxDataHex: WideString readonly dispid 163;
    property TxData: WideString readonly dispid 164;
    property TxDataHex: WideString readonly dispid 165;
    function SleepMode: Integer; dispid 166;
    property PollAutoDisable: WordBool dispid 167;
    procedure AboutBox; dispid -552;
    function AddField: Integer; dispid 1;
    function AuthStandard: Integer; dispid 2;
    function ClearBlock: Integer; dispid 3;
    function ClearFieldValues: Integer; dispid 4;
    function ClosePort: Integer; dispid 5;
    function Connect: Integer; dispid 6;
    function DecodeTrailer: Integer; dispid 7;
    function DecodeValueBlock: Integer; dispid 8;
    function DeleteAllFields: Integer; dispid 9;
    function DeleteAppSectors: Integer; dispid 10;
    function DeleteField: Integer; dispid 11;
    function DeleteSector: Integer; dispid 12;
    function Disconnect: Integer; dispid 13;
    function EncodeKey: Integer; dispid 14;
    function EncodeTrailer: Integer; dispid 15;
    function EncodeValueBlock: Integer; dispid 16;
    function FindDevice: Integer; dispid 17;
    function GetFieldParams: Integer; dispid 18;
    function GetSectorParams: Integer; dispid 19;
    function InterfaceSetTimeout: Integer; dispid 20;
    function LoadFieldsFromFile: Integer; dispid 21;
    function LoadParams: Integer; dispid 22;
    function LoadValue: Integer; dispid 23;
    function OpenPort: Integer; dispid 24;
    function PcdBeep: Integer; dispid 25;
    function PcdConfig: Integer; dispid 26;
    function PcdGetFwVersion: Integer; dispid 27;
    function PcdGetRicVersion: Integer; dispid 28;
    function PcdGetSerialNumber: Integer; dispid 29;
    function PcdLoadKeyE2: Integer; dispid 30;
    function PcdReadE2: Integer; dispid 31;
    function PcdReset: Integer; dispid 32;
    function PcdRfReset: Integer; dispid 33;
    function PcdSetDefaultAttrib: Integer; dispid 34;
    function PcdSetTmo: Integer; dispid 35;
    function PcdWriteE2: Integer; dispid 36;
    function PiccActivateIdle: Integer; dispid 37;
    function PiccActivateWakeup: Integer; dispid 38;
    function PiccAnticoll: Integer; dispid 39;
    function PiccAuth: Integer; dispid 40;
    function PiccAuthE2: Integer; dispid 41;
    function PiccAuthKey: Integer; dispid 42;
    function PiccCascAnticoll: Integer; dispid 43;
    function PiccCascSelect: Integer; dispid 44;
    function PiccCommonRead: Integer; dispid 45;
    function PiccCommonRequest: Integer; dispid 46;
    function PiccCommonWrite: Integer; dispid 47;
    function PiccHalt: Integer; dispid 48;
    function PiccRead: Integer; dispid 49;
    function PiccSelect: Integer; dispid 50;
    function PiccValue: Integer; dispid 51;
    function PiccValueDebit: Integer; dispid 52;
    function PiccWrite: Integer; dispid 53;
    function PollStart: Integer; dispid 54;
    function PollStop: Integer; dispid 55;
    function PortOpened: Integer; dispid 56;
    function ReadData: Integer; dispid 57;
    function ReadDirectory: Integer; dispid 58;
    function ReadFields: Integer; dispid 59;
    function ReadTrailer: Integer; dispid 60;
    function RequestAll: Integer; dispid 61;
    function RequestIdle: Integer; dispid 62;
    function ResetCard: Integer; dispid 63;
    function SaveFieldsToFile: Integer; dispid 64;
    function SaveParams: Integer; dispid 65;
    function SendEvent: Integer; dispid 66;
    function SetDefaults: Integer; dispid 67;
    function SetFieldParams: Integer; dispid 68;
    function SetSectorParams: Integer; dispid 69;
    function ShowDirectoryDlg: Integer; dispid 70;
    function ShowFirmsDlg: Integer; dispid 71;
    function ShowProperties: Integer; dispid 72;
    function ShowSearchDlg: Integer; dispid 73;
    function ShowTrailerDlg: Integer; dispid 74;
    function StartTransTimer: Integer; dispid 75;
    function StopTransTimer: Integer; dispid 76;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool; dispid 77;
    function WriteData: Integer; dispid 78;
    function WriteDirectory: Integer; dispid 79;
    function WriteFields: Integer; dispid 80;
    function WriteTrailer: Integer; dispid 81;
    property AccessMode0: Integer dispid 82;
    property AccessMode1: Integer dispid 83;
    property AccessMode2: Integer dispid 84;
    property AccessMode3: Integer dispid 85;
    property AppCode: Integer dispid 86;
    property ATQ: {??Word}OleVariant readonly dispid 87;
    property BaudRate: TBaudRate dispid 88;
    property BeepTone: Integer dispid 89;
    property BitCount: Integer dispid 90;
    property BlockAddr: Integer dispid 91;
    property BlockData: WideString dispid 92;
    property BlockDataHex: WideString dispid 93;
    property BlockNumber: Integer dispid 94;
    property BlockValue: Integer dispid 95;
    property CardDescription: WideString readonly dispid 96;
    property CardType: TCardType readonly dispid 97;
    property Command: TDataCommand dispid 98;
    property Connected: WordBool readonly dispid 99;
    property Data: WideString dispid 100;
    property DataLength: Integer dispid 101;
    property DataMode: TDataMode dispid 102;
    property DataSize: Integer dispid 103;
    property DeltaValue: Integer dispid 104;
    property DirectoryStatus: TDirectoryStatus readonly dispid 105;
    property DirectoryStatusText: WideString readonly dispid 106;
    property ErrorText: WideString readonly dispid 107;
    property ExecutionTime: Integer readonly dispid 108;
    property FieldCount: Integer readonly dispid 109;
    property FieldIndex: Integer dispid 110;
    property FieldSize: Integer dispid 111;
    property FieldType: Integer dispid 112;
    property FieldValue: WideString dispid 113;
    property FileName: WideString dispid 114;
    property FirmCode: Integer dispid 115;
    property IsClient1C: WordBool readonly dispid 116;
    property IsShowProperties: WordBool readonly dispid 117;
    property KeyA: WideString dispid 118;
    property KeyB: WideString dispid 119;
    property KeyEncoded: WideString dispid 120;
    property KeyNumber: Integer dispid 121;
    property KeyType: TKeyType dispid 122;
    property KeyUncoded: WideString dispid 123;
    property LibInfoKey: Integer dispid 124;
    property LockDevices: WordBool dispid 125;
    property NewKeyA: WideString dispid 126;
    property NewKeyB: WideString dispid 127;
    property ParentWnd: Integer dispid 128;
    property PasswordHeader: WideString readonly dispid 129;
    property PcdFwVersion: WideString readonly dispid 130;
    property PcdRicVersion: WideString readonly dispid 131;
    property PollInterval: Integer dispid 132;
    property PollStarted: WordBool readonly dispid 133;
    property PortNumber: Integer dispid 134;
    property ReqCode: TReqCode dispid 135;
    property ResultCode: Integer readonly dispid 136;
    property ResultDescription: WideString readonly dispid 137;
    property RfResetTime: Integer dispid 138;
    property RICValue: Integer dispid 139;
    property SAK: Byte readonly dispid 140;
    property SectorCount: Integer readonly dispid 141;
    property SectorIndex: Integer dispid 142;
    property SectorNumber: Integer dispid 143;
    property SelectCode: TSelectCode dispid 144;
    property Timeout: Integer dispid 145;
    property TransBlockNumber: Integer dispid 146;
    property TransTime: Integer dispid 147;
    property UID: WideString dispid 148;
    property UIDHex: WideString dispid 149;
    property UIDLen: Byte readonly dispid 150;
    property ValueOperation: TValueOperation dispid 151;
    property Version: WideString readonly dispid 152;
  end;

// *********************************************************************//
// Interface: IMifareDrv4
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {04F0144D-C7DB-4BC6-8B6A-CF8FF7E73BCC}
// *********************************************************************//
  IMifareDrv4 = interface(IMifareDrv3)
    ['{04F0144D-C7DB-4BC6-8B6A-CF8FF7E73BCC}']
    function Get_SlotNumber: Integer; safecall;
    procedure Set_SlotNumber(Value: Integer); safecall;
    function Get_UseOptional: WordBool; safecall;
    procedure Set_UseOptional(Value: WordBool); safecall;
    function Get_OptionalValue: Integer; safecall;
    procedure Set_OptionalValue(Value: Integer); safecall;
    function MifarePlusSelectSAMSlot: Integer; safecall;
    function Get_SlotStatus0: Integer; safecall;
    function Get_SlotStatus1: Integer; safecall;
    function Get_SlotStatus2: Integer; safecall;
    function Get_SlotStatus3: Integer; safecall;
    function Get_SlotStatus4: Integer; safecall;
    function MifarePlusAuthSL3Key: Integer; safecall;
    function Get_Status: Integer; safecall;
    procedure Set_Status(Value: Integer); safecall;
    function Get_DivInputHex: WideString; safecall;
    procedure Set_DivInputHex(const Value: WideString); safecall;
    property SlotNumber: Integer read Get_SlotNumber write Set_SlotNumber;
    property UseOptional: WordBool read Get_UseOptional write Set_UseOptional;
    property OptionalValue: Integer read Get_OptionalValue write Set_OptionalValue;
    property SlotStatus0: Integer read Get_SlotStatus0;
    property SlotStatus1: Integer read Get_SlotStatus1;
    property SlotStatus2: Integer read Get_SlotStatus2;
    property SlotStatus3: Integer read Get_SlotStatus3;
    property SlotStatus4: Integer read Get_SlotStatus4;
    property Status: Integer read Get_Status write Set_Status;
    property DivInputHex: WideString read Get_DivInputHex write Set_DivInputHex;
  end;

// *********************************************************************//
// DispIntf:  IMifareDrv4Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {04F0144D-C7DB-4BC6-8B6A-CF8FF7E73BCC}
// *********************************************************************//
  IMifareDrv4Disp = dispinterface
    ['{04F0144D-C7DB-4BC6-8B6A-CF8FF7E73BCC}']
    property SlotNumber: Integer dispid 614;
    property UseOptional: WordBool dispid 615;
    property OptionalValue: Integer dispid 616;
    function MifarePlusSelectSAMSlot: Integer; dispid 617;
    property SlotStatus0: Integer readonly dispid 618;
    property SlotStatus1: Integer readonly dispid 619;
    property SlotStatus2: Integer readonly dispid 620;
    property SlotStatus3: Integer readonly dispid 621;
    property SlotStatus4: Integer readonly dispid 622;
    function MifarePlusAuthSL3Key: Integer; dispid 623;
    property Status: Integer dispid 624;
    property DivInputHex: WideString dispid 625;
    property EventID: Integer dispid 501;
    property EventDriverID: Integer readonly dispid 502;
    property EventType: Integer readonly dispid 503;
    property EventPortNumber: Integer readonly dispid 504;
    property EventErrorCode: Integer readonly dispid 505;
    property EventErrorText: WideString readonly dispid 506;
    property EventCardUIDHex: WideString readonly dispid 507;
    function FindEvent: Integer; dispid 508;
    function DeleteEvent: Integer; dispid 509;
    property EventsEnabled: WordBool dispid 510;
    function ClearEvents: Integer; dispid 512;
    property EventCount: Integer readonly dispid 513;
    property DriverID: Integer readonly dispid 511;
    function LockReader: Integer; dispid 514;
    function UnlockReader: Integer; dispid 515;
    property YellowLED: WordBool dispid 516;
    function SAM_GetVersion: Integer; dispid 517;
    property SAMVersion: {??TSAMVersion}OleVariant readonly dispid 518;
    function SAM_WriteKey: Integer; dispid 519;
    property KeyPosition: Integer dispid 520;
    property KeyVersion: Integer dispid 521;
    function SAM_AuthKey: Integer; dispid 522;
    property LogFilePath: WideString dispid 523;
    property ParamsRegKey: WideString dispid 524;
    function SAM_WriteHostAuthKey: Integer; dispid 525;
    function SAM_GetKeyEntry: Integer; dispid 526;
    function ReadFullSerialNumber: Integer; dispid 527;
    function SAM_SetProtection: Integer; dispid 528;
    function SAM_SetProtectionSN: Integer; dispid 529;
    property KeyEntryNumber: Integer dispid 530;
    property KeyVersion0: Integer readonly dispid 531;
    property KeyVersion1: Integer readonly dispid 532;
    property KeyVersion2: Integer readonly dispid 533;
    property SerialNumber: WideString dispid 534;
    property SerialNumberHex: WideString dispid 535;
    property KeyTypeText: WideString readonly dispid 536;
    function WriteConnectionParams: Integer; dispid 537;
    property ErrorOnCorruptedValueBlock: WordBool dispid 538;
    property IsValueBlockCorrupted: WordBool readonly dispid 539;
    function UltralightRead: Integer; dispid 540;
    function UltralightWrite: Integer; dispid 541;
    function UltralightCompatWrite: Integer; dispid 542;
    function UltralightWriteKey: Integer; dispid 543;
    function UltralightAuth: Integer; dispid 544;
    function MifarePlusWritePerso: Integer; dispid 545;
    function MifarePlusWriteParameters: Integer; dispid 546;
    function MifarePlusCommitPerso: Integer; dispid 547;
    property ReceiveDivisor: Integer dispid 548;
    property SendDivisor: Integer dispid 549;
    function MifarePlusAuthSL1: Integer; dispid 550;
    function MifarePlusAuthSL3: Integer; dispid 551;
    function MifarePlusIncrement: Integer; dispid 552;
    function MifarePlusDecrement: Integer; dispid 553;
    function MifarePlusIncrementTransfer: Integer; dispid 554;
    function MifarePlusDecrementTransfer: Integer; dispid 555;
    function MifarePlusRead: Integer; dispid 556;
    function MifarePlusRestore: Integer; dispid 557;
    function MifarePlusTransfer: Integer; dispid 558;
    function MifarePlusReadValue: Integer; dispid 559;
    function MifarePlusWriteValue: Integer; dispid 560;
    function MifarePlusMultiblockRead: Integer; dispid 561;
    function MifarePlusMultiblockWrite: Integer; dispid 562;
    function MifarePlusResetAuthentication: Integer; dispid 563;
    property AuthType: Integer dispid 564;
    property BlockCount: Integer dispid 565;
    function MifarePlusWrite: Integer; dispid 566;
    property NewBaudRate: Integer dispid 567;
    function ClearResult: Integer; dispid 568;
    property SAMHWVendorID: Integer readonly dispid 569;
    property SAMHWVendorName: WideString readonly dispid 570;
    property SAMHWType: Integer readonly dispid 571;
    property SAMHWSubType: Integer readonly dispid 572;
    property SAMHWMajorVersion: Integer readonly dispid 573;
    property SAMHWMinorVersion: Integer readonly dispid 574;
    property SAMHWProtocol: Integer readonly dispid 575;
    property SAMHWStorageSize: Integer readonly dispid 576;
    property SAMHWStorageSizeCode: Integer readonly dispid 577;
    property SAMSWVendorID: Integer readonly dispid 578;
    property SAMSWVendorName: WideString readonly dispid 579;
    property SAMSWType: Integer readonly dispid 580;
    property SAMSWSubType: Integer readonly dispid 581;
    property SAMSWMajorVersion: Integer readonly dispid 582;
    property SAMSWMinorVersion: Integer readonly dispid 583;
    property SAMSWProtocol: Integer readonly dispid 584;
    property SAMSWStorageSize: Integer readonly dispid 585;
    property SAMSWStorageSizeCode: Integer readonly dispid 586;
    property SAMMode: Integer readonly dispid 587;
    property SAMModeName: WideString readonly dispid 588;
    property SAMMDUID: Integer readonly dispid 589;
    property SAMMDUIDHex: WideString readonly dispid 590;
    property SAMMDBatchNo: Integer readonly dispid 591;
    property SAMMDProductionDay: Integer readonly dispid 592;
    property SAMMDProductionMonth: Integer readonly dispid 593;
    property SAMMDProductionYear: Integer readonly dispid 594;
    property SAMMDGlobalCryptoSettings: Integer readonly dispid 595;
    property SAMMDUIDStr: WideString readonly dispid 596;
    function EnableCardAccept: Integer; dispid 597;
    function DisableCardAccept: Integer; dispid 598;
    function ReadStatus: Integer; dispid 599;
    function IssueCard: Integer; dispid 600;
    function HoldCard: Integer; dispid 601;
    function ReadLastAnswer: Integer; dispid 602;
    property Protocol: Integer dispid 603;
    function MifarePlusAuthSL2: Integer; dispid 604;
    function SAMAV2WriteKey: Integer; dispid 605;
    property EncryptionEnabled: WordBool dispid 606;
    property AnswerSignature: WordBool dispid 607;
    property CommandSignature: WordBool dispid 608;
    function MifarePlusMultiblockReadSL2: Integer; dispid 609;
    function MifarePlusMultiblockWriteSL2: Integer; dispid 610;
    function MifarePlusAuthSL2Crypto1: Integer; dispid 611;
    function WriteEncryptedData: Integer; dispid 612;
    property PollActivateMethod: TPollActivateMethod dispid 613;
    property ReaderName: WideString dispid 168;
    property DataAuthMode: TDataAuthMode dispid 169;
    property UpdateTrailer: WordBool dispid 170;
    property DataFormat: TDataFormat dispid 171;
    property LogEnabled: WordBool dispid 172;
    property LogFileName: WideString dispid 173;
    property RedLED: WordBool dispid 401;
    property GreenLED: WordBool dispid 402;
    property BlueLED: WordBool dispid 403;
    property ButtonState: WordBool readonly dispid 404;
    function PcdControlLEDAndPoll: Integer; dispid 405;
    function PcdControlLED: Integer; dispid 406;
    function PcdPollButton: Integer; dispid 407;
    function MksFindCard: Integer; dispid 153;
    function MksReadCatalog: Integer; dispid 154;
    function MksReopen: Integer; dispid 155;
    function MksWriteCatalog: Integer; dispid 156;
    function ShowConnectionPropertiesDlg: Integer; dispid 157;
    property CardATQ: Integer dispid 158;
    property DeviceType: TDeviceType dispid 159;
    property Parity: Integer dispid 160;
    property PortBaudRate: Integer dispid 161;
    property RxData: WideString readonly dispid 162;
    property RxDataHex: WideString readonly dispid 163;
    property TxData: WideString readonly dispid 164;
    property TxDataHex: WideString readonly dispid 165;
    function SleepMode: Integer; dispid 166;
    property PollAutoDisable: WordBool dispid 167;
    procedure AboutBox; dispid -552;
    function AddField: Integer; dispid 1;
    function AuthStandard: Integer; dispid 2;
    function ClearBlock: Integer; dispid 3;
    function ClearFieldValues: Integer; dispid 4;
    function ClosePort: Integer; dispid 5;
    function Connect: Integer; dispid 6;
    function DecodeTrailer: Integer; dispid 7;
    function DecodeValueBlock: Integer; dispid 8;
    function DeleteAllFields: Integer; dispid 9;
    function DeleteAppSectors: Integer; dispid 10;
    function DeleteField: Integer; dispid 11;
    function DeleteSector: Integer; dispid 12;
    function Disconnect: Integer; dispid 13;
    function EncodeKey: Integer; dispid 14;
    function EncodeTrailer: Integer; dispid 15;
    function EncodeValueBlock: Integer; dispid 16;
    function FindDevice: Integer; dispid 17;
    function GetFieldParams: Integer; dispid 18;
    function GetSectorParams: Integer; dispid 19;
    function InterfaceSetTimeout: Integer; dispid 20;
    function LoadFieldsFromFile: Integer; dispid 21;
    function LoadParams: Integer; dispid 22;
    function LoadValue: Integer; dispid 23;
    function OpenPort: Integer; dispid 24;
    function PcdBeep: Integer; dispid 25;
    function PcdConfig: Integer; dispid 26;
    function PcdGetFwVersion: Integer; dispid 27;
    function PcdGetRicVersion: Integer; dispid 28;
    function PcdGetSerialNumber: Integer; dispid 29;
    function PcdLoadKeyE2: Integer; dispid 30;
    function PcdReadE2: Integer; dispid 31;
    function PcdReset: Integer; dispid 32;
    function PcdRfReset: Integer; dispid 33;
    function PcdSetDefaultAttrib: Integer; dispid 34;
    function PcdSetTmo: Integer; dispid 35;
    function PcdWriteE2: Integer; dispid 36;
    function PiccActivateIdle: Integer; dispid 37;
    function PiccActivateWakeup: Integer; dispid 38;
    function PiccAnticoll: Integer; dispid 39;
    function PiccAuth: Integer; dispid 40;
    function PiccAuthE2: Integer; dispid 41;
    function PiccAuthKey: Integer; dispid 42;
    function PiccCascAnticoll: Integer; dispid 43;
    function PiccCascSelect: Integer; dispid 44;
    function PiccCommonRead: Integer; dispid 45;
    function PiccCommonRequest: Integer; dispid 46;
    function PiccCommonWrite: Integer; dispid 47;
    function PiccHalt: Integer; dispid 48;
    function PiccRead: Integer; dispid 49;
    function PiccSelect: Integer; dispid 50;
    function PiccValue: Integer; dispid 51;
    function PiccValueDebit: Integer; dispid 52;
    function PiccWrite: Integer; dispid 53;
    function PollStart: Integer; dispid 54;
    function PollStop: Integer; dispid 55;
    function PortOpened: Integer; dispid 56;
    function ReadData: Integer; dispid 57;
    function ReadDirectory: Integer; dispid 58;
    function ReadFields: Integer; dispid 59;
    function ReadTrailer: Integer; dispid 60;
    function RequestAll: Integer; dispid 61;
    function RequestIdle: Integer; dispid 62;
    function ResetCard: Integer; dispid 63;
    function SaveFieldsToFile: Integer; dispid 64;
    function SaveParams: Integer; dispid 65;
    function SendEvent: Integer; dispid 66;
    function SetDefaults: Integer; dispid 67;
    function SetFieldParams: Integer; dispid 68;
    function SetSectorParams: Integer; dispid 69;
    function ShowDirectoryDlg: Integer; dispid 70;
    function ShowFirmsDlg: Integer; dispid 71;
    function ShowProperties: Integer; dispid 72;
    function ShowSearchDlg: Integer; dispid 73;
    function ShowTrailerDlg: Integer; dispid 74;
    function StartTransTimer: Integer; dispid 75;
    function StopTransTimer: Integer; dispid 76;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool; dispid 77;
    function WriteData: Integer; dispid 78;
    function WriteDirectory: Integer; dispid 79;
    function WriteFields: Integer; dispid 80;
    function WriteTrailer: Integer; dispid 81;
    property AccessMode0: Integer dispid 82;
    property AccessMode1: Integer dispid 83;
    property AccessMode2: Integer dispid 84;
    property AccessMode3: Integer dispid 85;
    property AppCode: Integer dispid 86;
    property ATQ: {??Word}OleVariant readonly dispid 87;
    property BaudRate: TBaudRate dispid 88;
    property BeepTone: Integer dispid 89;
    property BitCount: Integer dispid 90;
    property BlockAddr: Integer dispid 91;
    property BlockData: WideString dispid 92;
    property BlockDataHex: WideString dispid 93;
    property BlockNumber: Integer dispid 94;
    property BlockValue: Integer dispid 95;
    property CardDescription: WideString readonly dispid 96;
    property CardType: TCardType readonly dispid 97;
    property Command: TDataCommand dispid 98;
    property Connected: WordBool readonly dispid 99;
    property Data: WideString dispid 100;
    property DataLength: Integer dispid 101;
    property DataMode: TDataMode dispid 102;
    property DataSize: Integer dispid 103;
    property DeltaValue: Integer dispid 104;
    property DirectoryStatus: TDirectoryStatus readonly dispid 105;
    property DirectoryStatusText: WideString readonly dispid 106;
    property ErrorText: WideString readonly dispid 107;
    property ExecutionTime: Integer readonly dispid 108;
    property FieldCount: Integer readonly dispid 109;
    property FieldIndex: Integer dispid 110;
    property FieldSize: Integer dispid 111;
    property FieldType: Integer dispid 112;
    property FieldValue: WideString dispid 113;
    property FileName: WideString dispid 114;
    property FirmCode: Integer dispid 115;
    property IsClient1C: WordBool readonly dispid 116;
    property IsShowProperties: WordBool readonly dispid 117;
    property KeyA: WideString dispid 118;
    property KeyB: WideString dispid 119;
    property KeyEncoded: WideString dispid 120;
    property KeyNumber: Integer dispid 121;
    property KeyType: TKeyType dispid 122;
    property KeyUncoded: WideString dispid 123;
    property LibInfoKey: Integer dispid 124;
    property LockDevices: WordBool dispid 125;
    property NewKeyA: WideString dispid 126;
    property NewKeyB: WideString dispid 127;
    property ParentWnd: Integer dispid 128;
    property PasswordHeader: WideString readonly dispid 129;
    property PcdFwVersion: WideString readonly dispid 130;
    property PcdRicVersion: WideString readonly dispid 131;
    property PollInterval: Integer dispid 132;
    property PollStarted: WordBool readonly dispid 133;
    property PortNumber: Integer dispid 134;
    property ReqCode: TReqCode dispid 135;
    property ResultCode: Integer readonly dispid 136;
    property ResultDescription: WideString readonly dispid 137;
    property RfResetTime: Integer dispid 138;
    property RICValue: Integer dispid 139;
    property SAK: Byte readonly dispid 140;
    property SectorCount: Integer readonly dispid 141;
    property SectorIndex: Integer dispid 142;
    property SectorNumber: Integer dispid 143;
    property SelectCode: TSelectCode dispid 144;
    property Timeout: Integer dispid 145;
    property TransBlockNumber: Integer dispid 146;
    property TransTime: Integer dispid 147;
    property UID: WideString dispid 148;
    property UIDHex: WideString dispid 149;
    property UIDLen: Byte readonly dispid 150;
    property ValueOperation: TValueOperation dispid 151;
    property Version: WideString readonly dispid 152;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMifareDrv2
// Help String      : ØÒÐÈÕ-Ì: Äנאיגונ סקטעûגאעוכוי Mifare
// Default Interface: IMifareDrv3
// Def. Intf. DISP? : No
// Event   Interface: IMifareDrvEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMifareDrv2CardFound = procedure(ASender: TObject; const CardUIDHex: WideString) of object;
  TMifareDrv2PollError = procedure(ASender: TObject; ErrorCode: Integer; const ErrorText: WideString) of object;
  TMifareDrv2DriverEvent = procedure(ASender: TObject; EventID: Integer) of object;

  TMifareDrv2 = class(TOleControl)
  private
    FOnCardFound: TMifareDrv2CardFound;
    FOnPollError: TMifareDrv2PollError;
    FOnDriverEvent: TMifareDrv2DriverEvent;
    FIntf: IMifareDrv3;
    function  GetControlInterface: IMifareDrv3;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_SAMVersion: TSAMVersion;
  public
    procedure AboutBox;
    function AddField: Integer;
    function AuthStandard: Integer;
    function ClearBlock: Integer;
    function ClearFieldValues: Integer;
    function ClosePort: Integer;
    function Connect: Integer;
    function DecodeTrailer: Integer;
    function DecodeValueBlock: Integer;
    function DeleteAllFields: Integer;
    function DeleteAppSectors: Integer;
    function DeleteField: Integer;
    function DeleteSector: Integer;
    function Disconnect: Integer;
    function EncodeKey: Integer;
    function EncodeTrailer: Integer;
    function EncodeValueBlock: Integer;
    function FindDevice: Integer;
    function GetFieldParams: Integer;
    function GetSectorParams: Integer;
    function InterfaceSetTimeout: Integer;
    function LoadFieldsFromFile: Integer;
    function LoadParams: Integer;
    function LoadValue: Integer;
    function OpenPort: Integer;
    function PcdBeep: Integer;
    function PcdConfig: Integer;
    function PcdGetFwVersion: Integer;
    function PcdGetRicVersion: Integer;
    function PcdGetSerialNumber: Integer;
    function PcdLoadKeyE2: Integer;
    function PcdReadE2: Integer;
    function PcdReset: Integer;
    function PcdRfReset: Integer;
    function PcdSetDefaultAttrib: Integer;
    function PcdSetTmo: Integer;
    function PcdWriteE2: Integer;
    function PiccActivateIdle: Integer;
    function PiccActivateWakeup: Integer;
    function PiccAnticoll: Integer;
    function PiccAuth: Integer;
    function PiccAuthE2: Integer;
    function PiccAuthKey: Integer;
    function PiccCascAnticoll: Integer;
    function PiccCascSelect: Integer;
    function PiccCommonRead: Integer;
    function PiccCommonRequest: Integer;
    function PiccCommonWrite: Integer;
    function PiccHalt: Integer;
    function PiccRead: Integer;
    function PiccSelect: Integer;
    function PiccValue: Integer;
    function PiccValueDebit: Integer;
    function PiccWrite: Integer;
    function PollStart: Integer;
    function PollStop: Integer;
    function PortOpened: Integer;
    function ReadData: Integer;
    function ReadDirectory: Integer;
    function ReadFields: Integer;
    function ReadTrailer: Integer;
    function RequestAll: Integer;
    function RequestIdle: Integer;
    function ResetCard: Integer;
    function SaveFieldsToFile: Integer;
    function SaveParams: Integer;
    function SendEvent: Integer;
    function SetDefaults: Integer;
    function SetFieldParams: Integer;
    function SetSectorParams: Integer;
    function ShowDirectoryDlg: Integer;
    function ShowFirmsDlg: Integer;
    function ShowProperties: Integer;
    function ShowSearchDlg: Integer;
    function ShowTrailerDlg: Integer;
    function StartTransTimer: Integer;
    function StopTransTimer: Integer;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool;
    function WriteData: Integer;
    function WriteDirectory: Integer;
    function WriteFields: Integer;
    function WriteTrailer: Integer;
    function MksFindCard: Integer;
    function MksReadCatalog: Integer;
    function MksReopen: Integer;
    function MksWriteCatalog: Integer;
    function ShowConnectionPropertiesDlg: Integer;
    function SleepMode: Integer;
    function PcdControlLEDAndPoll: Integer;
    function PcdControlLED: Integer;
    function PcdPollButton: Integer;
    function FindEvent: Integer;
    function DeleteEvent: Integer;
    function ClearEvents: Integer;
    function LockReader: Integer;
    function UnlockReader: Integer;
    function SAM_GetVersion: Integer;
    function SAM_WriteKey: Integer;
    function SAM_AuthKey: Integer;
    function SAM_WriteHostAuthKey: Integer;
    function SAM_GetKeyEntry: Integer;
    function ReadFullSerialNumber: Integer;
    function SAM_SetProtection: Integer;
    function SAM_SetProtectionSN: Integer;
    function WriteConnectionParams: Integer;
    function UltralightRead: Integer;
    function UltralightWrite: Integer;
    function UltralightCompatWrite: Integer;
    function UltralightWriteKey: Integer;
    function UltralightAuth: Integer;
    function MifarePlusWritePerso: Integer;
    function MifarePlusWriteParameters: Integer;
    function MifarePlusCommitPerso: Integer;
    function MifarePlusAuthSL1: Integer;
    function MifarePlusAuthSL3: Integer;
    function MifarePlusIncrement: Integer;
    function MifarePlusDecrement: Integer;
    function MifarePlusIncrementTransfer: Integer;
    function MifarePlusDecrementTransfer: Integer;
    function MifarePlusRead: Integer;
    function MifarePlusRestore: Integer;
    function MifarePlusTransfer: Integer;
    function MifarePlusReadValue: Integer;
    function MifarePlusWriteValue: Integer;
    function MifarePlusMultiblockRead: Integer;
    function MifarePlusMultiblockWrite: Integer;
    function MifarePlusResetAuthentication: Integer;
    function MifarePlusWrite: Integer;
    function ClearResult: Integer;
    function EnableCardAccept: Integer;
    function DisableCardAccept: Integer;
    function ReadStatus: Integer;
    function IssueCard: Integer;
    function HoldCard: Integer;
    function ReadLastAnswer: Integer;
    function MifarePlusAuthSL2: Integer;
    function SAMAV2WriteKey: Integer;
    function MifarePlusMultiblockReadSL2: Integer;
    function MifarePlusMultiblockWriteSL2: Integer;
    function MifarePlusAuthSL2Crypto1: Integer;
    function WriteEncryptedData: Integer;
    property  ControlInterface: IMifareDrv3 read GetControlInterface;
    property  DefaultInterface: IMifareDrv3 read GetControlInterface;
    property ATQ: Word index 87 read GetWordProp;
    property CardDescription: WideString index 96 read GetWideStringProp;
    property CardType: TOleEnum index 97 read GetTOleEnumProp;
    property Connected: WordBool index 99 read GetWordBoolProp;
    property DirectoryStatus: TOleEnum index 105 read GetTOleEnumProp;
    property DirectoryStatusText: WideString index 106 read GetWideStringProp;
    property ErrorText: WideString index 107 read GetWideStringProp;
    property ExecutionTime: Integer index 108 read GetIntegerProp;
    property FieldCount: Integer index 109 read GetIntegerProp;
    property IsClient1C: WordBool index 116 read GetWordBoolProp;
    property IsShowProperties: WordBool index 117 read GetWordBoolProp;
    property PasswordHeader: WideString index 129 read GetWideStringProp;
    property PcdFwVersion: WideString index 130 read GetWideStringProp;
    property PcdRicVersion: WideString index 131 read GetWideStringProp;
    property PollStarted: WordBool index 133 read GetWordBoolProp;
    property ResultCode: Integer index 136 read GetIntegerProp;
    property ResultDescription: WideString index 137 read GetWideStringProp;
    property SAK: Byte index 140 read GetByteProp;
    property SectorCount: Integer index 141 read GetIntegerProp;
    property UIDLen: Byte index 150 read GetByteProp;
    property Version: WideString index 152 read GetWideStringProp;
    property RxData: WideString index 162 read GetWideStringProp;
    property RxDataHex: WideString index 163 read GetWideStringProp;
    property TxData: WideString index 164 read GetWideStringProp;
    property TxDataHex: WideString index 165 read GetWideStringProp;
    property ButtonState: WordBool index 404 read GetWordBoolProp;
    property EventDriverID: Integer index 502 read GetIntegerProp;
    property EventType: Integer index 503 read GetIntegerProp;
    property EventPortNumber: Integer index 504 read GetIntegerProp;
    property EventErrorCode: Integer index 505 read GetIntegerProp;
    property EventErrorText: WideString index 506 read GetWideStringProp;
    property EventCardUIDHex: WideString index 507 read GetWideStringProp;
    property EventCount: Integer index 513 read GetIntegerProp;
    property DriverID: Integer index 511 read GetIntegerProp;
    property SAMVersion: TSAMVersion read Get_SAMVersion;
    property KeyVersion0: Integer index 531 read GetIntegerProp;
    property KeyVersion1: Integer index 532 read GetIntegerProp;
    property KeyVersion2: Integer index 533 read GetIntegerProp;
    property KeyTypeText: WideString index 536 read GetWideStringProp;
    property IsValueBlockCorrupted: WordBool index 539 read GetWordBoolProp;
    property SAMHWVendorID: Integer index 569 read GetIntegerProp;
    property SAMHWVendorName: WideString index 570 read GetWideStringProp;
    property SAMHWType: Integer index 571 read GetIntegerProp;
    property SAMHWSubType: Integer index 572 read GetIntegerProp;
    property SAMHWMajorVersion: Integer index 573 read GetIntegerProp;
    property SAMHWMinorVersion: Integer index 574 read GetIntegerProp;
    property SAMHWProtocol: Integer index 575 read GetIntegerProp;
    property SAMHWStorageSize: Integer index 576 read GetIntegerProp;
    property SAMHWStorageSizeCode: Integer index 577 read GetIntegerProp;
    property SAMSWVendorID: Integer index 578 read GetIntegerProp;
    property SAMSWVendorName: WideString index 579 read GetWideStringProp;
    property SAMSWType: Integer index 580 read GetIntegerProp;
    property SAMSWSubType: Integer index 581 read GetIntegerProp;
    property SAMSWMajorVersion: Integer index 582 read GetIntegerProp;
    property SAMSWMinorVersion: Integer index 583 read GetIntegerProp;
    property SAMSWProtocol: Integer index 584 read GetIntegerProp;
    property SAMSWStorageSize: Integer index 585 read GetIntegerProp;
    property SAMSWStorageSizeCode: Integer index 586 read GetIntegerProp;
    property SAMMode: Integer index 587 read GetIntegerProp;
    property SAMModeName: WideString index 588 read GetWideStringProp;
    property SAMMDUID: Integer index 589 read GetIntegerProp;
    property SAMMDUIDHex: WideString index 590 read GetWideStringProp;
    property SAMMDBatchNo: Integer index 591 read GetIntegerProp;
    property SAMMDProductionDay: Integer index 592 read GetIntegerProp;
    property SAMMDProductionMonth: Integer index 593 read GetIntegerProp;
    property SAMMDProductionYear: Integer index 594 read GetIntegerProp;
    property SAMMDGlobalCryptoSettings: Integer index 595 read GetIntegerProp;
    property SAMMDUIDStr: WideString index 596 read GetWideStringProp;
  published
    property Anchors;
    property AccessMode0: Integer index 82 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode1: Integer index 83 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode2: Integer index 84 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode3: Integer index 85 read GetIntegerProp write SetIntegerProp stored False;
    property AppCode: Integer index 86 read GetIntegerProp write SetIntegerProp stored False;
    property BaudRate: TOleEnum index 88 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BeepTone: Integer index 89 read GetIntegerProp write SetIntegerProp stored False;
    property BitCount: Integer index 90 read GetIntegerProp write SetIntegerProp stored False;
    property BlockAddr: Integer index 91 read GetIntegerProp write SetIntegerProp stored False;
    property BlockData: WideString index 92 read GetWideStringProp write SetWideStringProp stored False;
    property BlockDataHex: WideString index 93 read GetWideStringProp write SetWideStringProp stored False;
    property BlockNumber: Integer index 94 read GetIntegerProp write SetIntegerProp stored False;
    property BlockValue: Integer index 95 read GetIntegerProp write SetIntegerProp stored False;
    property Command: TOleEnum index 98 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Data: WideString index 100 read GetWideStringProp write SetWideStringProp stored False;
    property DataLength: Integer index 101 read GetIntegerProp write SetIntegerProp stored False;
    property DataMode: TOleEnum index 102 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property DataSize: Integer index 103 read GetIntegerProp write SetIntegerProp stored False;
    property DeltaValue: Integer index 104 read GetIntegerProp write SetIntegerProp stored False;
    property FieldIndex: Integer index 110 read GetIntegerProp write SetIntegerProp stored False;
    property FieldSize: Integer index 111 read GetIntegerProp write SetIntegerProp stored False;
    property FieldType: Integer index 112 read GetIntegerProp write SetIntegerProp stored False;
    property FieldValue: WideString index 113 read GetWideStringProp write SetWideStringProp stored False;
    property FileName: WideString index 114 read GetWideStringProp write SetWideStringProp stored False;
    property FirmCode: Integer index 115 read GetIntegerProp write SetIntegerProp stored False;
    property KeyA: WideString index 118 read GetWideStringProp write SetWideStringProp stored False;
    property KeyB: WideString index 119 read GetWideStringProp write SetWideStringProp stored False;
    property KeyEncoded: WideString index 120 read GetWideStringProp write SetWideStringProp stored False;
    property KeyNumber: Integer index 121 read GetIntegerProp write SetIntegerProp stored False;
    property KeyType: TOleEnum index 122 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property KeyUncoded: WideString index 123 read GetWideStringProp write SetWideStringProp stored False;
    property LibInfoKey: Integer index 124 read GetIntegerProp write SetIntegerProp stored False;
    property LockDevices: WordBool index 125 read GetWordBoolProp write SetWordBoolProp stored False;
    property NewKeyA: WideString index 126 read GetWideStringProp write SetWideStringProp stored False;
    property NewKeyB: WideString index 127 read GetWideStringProp write SetWideStringProp stored False;
    property ParentWnd: Integer index 128 read GetIntegerProp write SetIntegerProp stored False;
    property PollInterval: Integer index 132 read GetIntegerProp write SetIntegerProp stored False;
    property PortNumber: Integer index 134 read GetIntegerProp write SetIntegerProp stored False;
    property ReqCode: TOleEnum index 135 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RfResetTime: Integer index 138 read GetIntegerProp write SetIntegerProp stored False;
    property RICValue: Integer index 139 read GetIntegerProp write SetIntegerProp stored False;
    property SectorIndex: Integer index 142 read GetIntegerProp write SetIntegerProp stored False;
    property SectorNumber: Integer index 143 read GetIntegerProp write SetIntegerProp stored False;
    property SelectCode: TOleEnum index 144 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Timeout: Integer index 145 read GetIntegerProp write SetIntegerProp stored False;
    property TransBlockNumber: Integer index 146 read GetIntegerProp write SetIntegerProp stored False;
    property TransTime: Integer index 147 read GetIntegerProp write SetIntegerProp stored False;
    property UID: WideString index 148 read GetWideStringProp write SetWideStringProp stored False;
    property UIDHex: WideString index 149 read GetWideStringProp write SetWideStringProp stored False;
    property ValueOperation: TOleEnum index 151 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property CardATQ: Integer index 158 read GetIntegerProp write SetIntegerProp stored False;
    property DeviceType: TOleEnum index 159 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Parity: Integer index 160 read GetIntegerProp write SetIntegerProp stored False;
    property PortBaudRate: Integer index 161 read GetIntegerProp write SetIntegerProp stored False;
    property PollAutoDisable: WordBool index 167 read GetWordBoolProp write SetWordBoolProp stored False;
    property ReaderName: WideString index 168 read GetWideStringProp write SetWideStringProp stored False;
    property DataAuthMode: TOleEnum index 169 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property UpdateTrailer: WordBool index 170 read GetWordBoolProp write SetWordBoolProp stored False;
    property DataFormat: TOleEnum index 171 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LogEnabled: WordBool index 172 read GetWordBoolProp write SetWordBoolProp stored False;
    property LogFileName: WideString index 173 read GetWideStringProp write SetWideStringProp stored False;
    property RedLED: WordBool index 401 read GetWordBoolProp write SetWordBoolProp stored False;
    property GreenLED: WordBool index 402 read GetWordBoolProp write SetWordBoolProp stored False;
    property BlueLED: WordBool index 403 read GetWordBoolProp write SetWordBoolProp stored False;
    property EventID: Integer index 501 read GetIntegerProp write SetIntegerProp stored False;
    property EventsEnabled: WordBool index 510 read GetWordBoolProp write SetWordBoolProp stored False;
    property YellowLED: WordBool index 516 read GetWordBoolProp write SetWordBoolProp stored False;
    property KeyPosition: Integer index 520 read GetIntegerProp write SetIntegerProp stored False;
    property KeyVersion: Integer index 521 read GetIntegerProp write SetIntegerProp stored False;
    property LogFilePath: WideString index 523 read GetWideStringProp write SetWideStringProp stored False;
    property ParamsRegKey: WideString index 524 read GetWideStringProp write SetWideStringProp stored False;
    property KeyEntryNumber: Integer index 530 read GetIntegerProp write SetIntegerProp stored False;
    property SerialNumber: WideString index 534 read GetWideStringProp write SetWideStringProp stored False;
    property SerialNumberHex: WideString index 535 read GetWideStringProp write SetWideStringProp stored False;
    property ErrorOnCorruptedValueBlock: WordBool index 538 read GetWordBoolProp write SetWordBoolProp stored False;
    property ReceiveDivisor: Integer index 548 read GetIntegerProp write SetIntegerProp stored False;
    property SendDivisor: Integer index 549 read GetIntegerProp write SetIntegerProp stored False;
    property AuthType: Integer index 564 read GetIntegerProp write SetIntegerProp stored False;
    property BlockCount: Integer index 565 read GetIntegerProp write SetIntegerProp stored False;
    property NewBaudRate: Integer index 567 read GetIntegerProp write SetIntegerProp stored False;
    property Protocol: Integer index 603 read GetIntegerProp write SetIntegerProp stored False;
    property EncryptionEnabled: WordBool index 606 read GetWordBoolProp write SetWordBoolProp stored False;
    property AnswerSignature: WordBool index 607 read GetWordBoolProp write SetWordBoolProp stored False;
    property CommandSignature: WordBool index 608 read GetWordBoolProp write SetWordBoolProp stored False;
    property PollActivateMethod: TOleEnum index 613 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property OnCardFound: TMifareDrv2CardFound read FOnCardFound write FOnCardFound;
    property OnPollError: TMifareDrv2PollError read FOnPollError write FOnPollError;
    property OnDriverEvent: TMifareDrv2DriverEvent read FOnDriverEvent write FOnDriverEvent;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMifareDrv
// Help String      : ØÒÐÈÕ-Ì: Äנאיגונ סקטעûגאעוכוי Mifare
// Default Interface: IMifareDrv4
// Def. Intf. DISP? : No
// Event   Interface: IMifareDrvEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMifareDrvCardFound = procedure(ASender: TObject; const CardUIDHex: WideString) of object;
  TMifareDrvPollError = procedure(ASender: TObject; ErrorCode: Integer; const ErrorText: WideString) of object;
  TMifareDrvDriverEvent = procedure(ASender: TObject; EventID: Integer) of object;

  TMifareDrv = class(TOleControl)
  private
    FOnCardFound: TMifareDrvCardFound;
    FOnPollError: TMifareDrvPollError;
    FOnDriverEvent: TMifareDrvDriverEvent;
    FIntf: IMifareDrv4;
    function  GetControlInterface: IMifareDrv4;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_SAMVersion: TSAMVersion;
  public
    procedure AboutBox;
    function AddField: Integer;
    function AuthStandard: Integer;
    function ClearBlock: Integer;
    function ClearFieldValues: Integer;
    function ClosePort: Integer;
    function Connect: Integer;
    function DecodeTrailer: Integer;
    function DecodeValueBlock: Integer;
    function DeleteAllFields: Integer;
    function DeleteAppSectors: Integer;
    function DeleteField: Integer;
    function DeleteSector: Integer;
    function Disconnect: Integer;
    function EncodeKey: Integer;
    function EncodeTrailer: Integer;
    function EncodeValueBlock: Integer;
    function FindDevice: Integer;
    function GetFieldParams: Integer;
    function GetSectorParams: Integer;
    function InterfaceSetTimeout: Integer;
    function LoadFieldsFromFile: Integer;
    function LoadParams: Integer;
    function LoadValue: Integer;
    function OpenPort: Integer;
    function PcdBeep: Integer;
    function PcdConfig: Integer;
    function PcdGetFwVersion: Integer;
    function PcdGetRicVersion: Integer;
    function PcdGetSerialNumber: Integer;
    function PcdLoadKeyE2: Integer;
    function PcdReadE2: Integer;
    function PcdReset: Integer;
    function PcdRfReset: Integer;
    function PcdSetDefaultAttrib: Integer;
    function PcdSetTmo: Integer;
    function PcdWriteE2: Integer;
    function PiccActivateIdle: Integer;
    function PiccActivateWakeup: Integer;
    function PiccAnticoll: Integer;
    function PiccAuth: Integer;
    function PiccAuthE2: Integer;
    function PiccAuthKey: Integer;
    function PiccCascAnticoll: Integer;
    function PiccCascSelect: Integer;
    function PiccCommonRead: Integer;
    function PiccCommonRequest: Integer;
    function PiccCommonWrite: Integer;
    function PiccHalt: Integer;
    function PiccRead: Integer;
    function PiccSelect: Integer;
    function PiccValue: Integer;
    function PiccValueDebit: Integer;
    function PiccWrite: Integer;
    function PollStart: Integer;
    function PollStop: Integer;
    function PortOpened: Integer;
    function ReadData: Integer;
    function ReadDirectory: Integer;
    function ReadFields: Integer;
    function ReadTrailer: Integer;
    function RequestAll: Integer;
    function RequestIdle: Integer;
    function ResetCard: Integer;
    function SaveFieldsToFile: Integer;
    function SaveParams: Integer;
    function SendEvent: Integer;
    function SetDefaults: Integer;
    function SetFieldParams: Integer;
    function SetSectorParams: Integer;
    function ShowDirectoryDlg: Integer;
    function ShowFirmsDlg: Integer;
    function ShowProperties: Integer;
    function ShowSearchDlg: Integer;
    function ShowTrailerDlg: Integer;
    function StartTransTimer: Integer;
    function StopTransTimer: Integer;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool;
    function WriteData: Integer;
    function WriteDirectory: Integer;
    function WriteFields: Integer;
    function WriteTrailer: Integer;
    function MksFindCard: Integer;
    function MksReadCatalog: Integer;
    function MksReopen: Integer;
    function MksWriteCatalog: Integer;
    function ShowConnectionPropertiesDlg: Integer;
    function SleepMode: Integer;
    function PcdControlLEDAndPoll: Integer;
    function PcdControlLED: Integer;
    function PcdPollButton: Integer;
    function FindEvent: Integer;
    function DeleteEvent: Integer;
    function ClearEvents: Integer;
    function LockReader: Integer;
    function UnlockReader: Integer;
    function SAM_GetVersion: Integer;
    function SAM_WriteKey: Integer;
    function SAM_AuthKey: Integer;
    function SAM_WriteHostAuthKey: Integer;
    function SAM_GetKeyEntry: Integer;
    function ReadFullSerialNumber: Integer;
    function SAM_SetProtection: Integer;
    function SAM_SetProtectionSN: Integer;
    function WriteConnectionParams: Integer;
    function UltralightRead: Integer;
    function UltralightWrite: Integer;
    function UltralightCompatWrite: Integer;
    function UltralightWriteKey: Integer;
    function UltralightAuth: Integer;
    function MifarePlusWritePerso: Integer;
    function MifarePlusWriteParameters: Integer;
    function MifarePlusCommitPerso: Integer;
    function MifarePlusAuthSL1: Integer;
    function MifarePlusAuthSL3: Integer;
    function MifarePlusIncrement: Integer;
    function MifarePlusDecrement: Integer;
    function MifarePlusIncrementTransfer: Integer;
    function MifarePlusDecrementTransfer: Integer;
    function MifarePlusRead: Integer;
    function MifarePlusRestore: Integer;
    function MifarePlusTransfer: Integer;
    function MifarePlusReadValue: Integer;
    function MifarePlusWriteValue: Integer;
    function MifarePlusMultiblockRead: Integer;
    function MifarePlusMultiblockWrite: Integer;
    function MifarePlusResetAuthentication: Integer;
    function MifarePlusWrite: Integer;
    function ClearResult: Integer;
    function EnableCardAccept: Integer;
    function DisableCardAccept: Integer;
    function ReadStatus: Integer;
    function IssueCard: Integer;
    function HoldCard: Integer;
    function ReadLastAnswer: Integer;
    function MifarePlusAuthSL2: Integer;
    function SAMAV2WriteKey: Integer;
    function MifarePlusMultiblockReadSL2: Integer;
    function MifarePlusMultiblockWriteSL2: Integer;
    function MifarePlusAuthSL2Crypto1: Integer;
    function WriteEncryptedData: Integer;
    function MifarePlusSelectSAMSlot: Integer;
    function MifarePlusAuthSL3Key: Integer;
    property  ControlInterface: IMifareDrv4 read GetControlInterface;
    property  DefaultInterface: IMifareDrv4 read GetControlInterface;
    property ATQ: Word index 87 read GetWordProp;
    property CardDescription: WideString index 96 read GetWideStringProp;
    property CardType: TOleEnum index 97 read GetTOleEnumProp;
    property Connected: WordBool index 99 read GetWordBoolProp;
    property DirectoryStatus: TOleEnum index 105 read GetTOleEnumProp;
    property DirectoryStatusText: WideString index 106 read GetWideStringProp;
    property ErrorText: WideString index 107 read GetWideStringProp;
    property ExecutionTime: Integer index 108 read GetIntegerProp;
    property FieldCount: Integer index 109 read GetIntegerProp;
    property IsClient1C: WordBool index 116 read GetWordBoolProp;
    property IsShowProperties: WordBool index 117 read GetWordBoolProp;
    property PasswordHeader: WideString index 129 read GetWideStringProp;
    property PcdFwVersion: WideString index 130 read GetWideStringProp;
    property PcdRicVersion: WideString index 131 read GetWideStringProp;
    property PollStarted: WordBool index 133 read GetWordBoolProp;
    property ResultCode: Integer index 136 read GetIntegerProp;
    property ResultDescription: WideString index 137 read GetWideStringProp;
    property SAK: Byte index 140 read GetByteProp;
    property SectorCount: Integer index 141 read GetIntegerProp;
    property UIDLen: Byte index 150 read GetByteProp;
    property Version: WideString index 152 read GetWideStringProp;
    property RxData: WideString index 162 read GetWideStringProp;
    property RxDataHex: WideString index 163 read GetWideStringProp;
    property TxData: WideString index 164 read GetWideStringProp;
    property TxDataHex: WideString index 165 read GetWideStringProp;
    property ButtonState: WordBool index 404 read GetWordBoolProp;
    property EventDriverID: Integer index 502 read GetIntegerProp;
    property EventType: Integer index 503 read GetIntegerProp;
    property EventPortNumber: Integer index 504 read GetIntegerProp;
    property EventErrorCode: Integer index 505 read GetIntegerProp;
    property EventErrorText: WideString index 506 read GetWideStringProp;
    property EventCardUIDHex: WideString index 507 read GetWideStringProp;
    property EventCount: Integer index 513 read GetIntegerProp;
    property DriverID: Integer index 511 read GetIntegerProp;
    property SAMVersion: TSAMVersion read Get_SAMVersion;
    property KeyVersion0: Integer index 531 read GetIntegerProp;
    property KeyVersion1: Integer index 532 read GetIntegerProp;
    property KeyVersion2: Integer index 533 read GetIntegerProp;
    property KeyTypeText: WideString index 536 read GetWideStringProp;
    property IsValueBlockCorrupted: WordBool index 539 read GetWordBoolProp;
    property SAMHWVendorID: Integer index 569 read GetIntegerProp;
    property SAMHWVendorName: WideString index 570 read GetWideStringProp;
    property SAMHWType: Integer index 571 read GetIntegerProp;
    property SAMHWSubType: Integer index 572 read GetIntegerProp;
    property SAMHWMajorVersion: Integer index 573 read GetIntegerProp;
    property SAMHWMinorVersion: Integer index 574 read GetIntegerProp;
    property SAMHWProtocol: Integer index 575 read GetIntegerProp;
    property SAMHWStorageSize: Integer index 576 read GetIntegerProp;
    property SAMHWStorageSizeCode: Integer index 577 read GetIntegerProp;
    property SAMSWVendorID: Integer index 578 read GetIntegerProp;
    property SAMSWVendorName: WideString index 579 read GetWideStringProp;
    property SAMSWType: Integer index 580 read GetIntegerProp;
    property SAMSWSubType: Integer index 581 read GetIntegerProp;
    property SAMSWMajorVersion: Integer index 582 read GetIntegerProp;
    property SAMSWMinorVersion: Integer index 583 read GetIntegerProp;
    property SAMSWProtocol: Integer index 584 read GetIntegerProp;
    property SAMSWStorageSize: Integer index 585 read GetIntegerProp;
    property SAMSWStorageSizeCode: Integer index 586 read GetIntegerProp;
    property SAMMode: Integer index 587 read GetIntegerProp;
    property SAMModeName: WideString index 588 read GetWideStringProp;
    property SAMMDUID: Integer index 589 read GetIntegerProp;
    property SAMMDUIDHex: WideString index 590 read GetWideStringProp;
    property SAMMDBatchNo: Integer index 591 read GetIntegerProp;
    property SAMMDProductionDay: Integer index 592 read GetIntegerProp;
    property SAMMDProductionMonth: Integer index 593 read GetIntegerProp;
    property SAMMDProductionYear: Integer index 594 read GetIntegerProp;
    property SAMMDGlobalCryptoSettings: Integer index 595 read GetIntegerProp;
    property SAMMDUIDStr: WideString index 596 read GetWideStringProp;
    property SlotStatus0: Integer index 618 read GetIntegerProp;
    property SlotStatus1: Integer index 619 read GetIntegerProp;
    property SlotStatus2: Integer index 620 read GetIntegerProp;
    property SlotStatus3: Integer index 621 read GetIntegerProp;
    property SlotStatus4: Integer index 622 read GetIntegerProp;
  published
    property Anchors;
    property AccessMode0: Integer index 82 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode1: Integer index 83 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode2: Integer index 84 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode3: Integer index 85 read GetIntegerProp write SetIntegerProp stored False;
    property AppCode: Integer index 86 read GetIntegerProp write SetIntegerProp stored False;
    property BaudRate: TOleEnum index 88 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BeepTone: Integer index 89 read GetIntegerProp write SetIntegerProp stored False;
    property BitCount: Integer index 90 read GetIntegerProp write SetIntegerProp stored False;
    property BlockAddr: Integer index 91 read GetIntegerProp write SetIntegerProp stored False;
    property BlockData: WideString index 92 read GetWideStringProp write SetWideStringProp stored False;
    property BlockDataHex: WideString index 93 read GetWideStringProp write SetWideStringProp stored False;
    property BlockNumber: Integer index 94 read GetIntegerProp write SetIntegerProp stored False;
    property BlockValue: Integer index 95 read GetIntegerProp write SetIntegerProp stored False;
    property Command: TOleEnum index 98 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Data: WideString index 100 read GetWideStringProp write SetWideStringProp stored False;
    property DataLength: Integer index 101 read GetIntegerProp write SetIntegerProp stored False;
    property DataMode: TOleEnum index 102 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property DataSize: Integer index 103 read GetIntegerProp write SetIntegerProp stored False;
    property DeltaValue: Integer index 104 read GetIntegerProp write SetIntegerProp stored False;
    property FieldIndex: Integer index 110 read GetIntegerProp write SetIntegerProp stored False;
    property FieldSize: Integer index 111 read GetIntegerProp write SetIntegerProp stored False;
    property FieldType: Integer index 112 read GetIntegerProp write SetIntegerProp stored False;
    property FieldValue: WideString index 113 read GetWideStringProp write SetWideStringProp stored False;
    property FileName: WideString index 114 read GetWideStringProp write SetWideStringProp stored False;
    property FirmCode: Integer index 115 read GetIntegerProp write SetIntegerProp stored False;
    property KeyA: WideString index 118 read GetWideStringProp write SetWideStringProp stored False;
    property KeyB: WideString index 119 read GetWideStringProp write SetWideStringProp stored False;
    property KeyEncoded: WideString index 120 read GetWideStringProp write SetWideStringProp stored False;
    property KeyNumber: Integer index 121 read GetIntegerProp write SetIntegerProp stored False;
    property KeyType: TOleEnum index 122 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property KeyUncoded: WideString index 123 read GetWideStringProp write SetWideStringProp stored False;
    property LibInfoKey: Integer index 124 read GetIntegerProp write SetIntegerProp stored False;
    property LockDevices: WordBool index 125 read GetWordBoolProp write SetWordBoolProp stored False;
    property NewKeyA: WideString index 126 read GetWideStringProp write SetWideStringProp stored False;
    property NewKeyB: WideString index 127 read GetWideStringProp write SetWideStringProp stored False;
    property ParentWnd: Integer index 128 read GetIntegerProp write SetIntegerProp stored False;
    property PollInterval: Integer index 132 read GetIntegerProp write SetIntegerProp stored False;
    property PortNumber: Integer index 134 read GetIntegerProp write SetIntegerProp stored False;
    property ReqCode: TOleEnum index 135 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RfResetTime: Integer index 138 read GetIntegerProp write SetIntegerProp stored False;
    property RICValue: Integer index 139 read GetIntegerProp write SetIntegerProp stored False;
    property SectorIndex: Integer index 142 read GetIntegerProp write SetIntegerProp stored False;
    property SectorNumber: Integer index 143 read GetIntegerProp write SetIntegerProp stored False;
    property SelectCode: TOleEnum index 144 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Timeout: Integer index 145 read GetIntegerProp write SetIntegerProp stored False;
    property TransBlockNumber: Integer index 146 read GetIntegerProp write SetIntegerProp stored False;
    property TransTime: Integer index 147 read GetIntegerProp write SetIntegerProp stored False;
    property UID: WideString index 148 read GetWideStringProp write SetWideStringProp stored False;
    property UIDHex: WideString index 149 read GetWideStringProp write SetWideStringProp stored False;
    property ValueOperation: TOleEnum index 151 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property CardATQ: Integer index 158 read GetIntegerProp write SetIntegerProp stored False;
    property DeviceType: TOleEnum index 159 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Parity: Integer index 160 read GetIntegerProp write SetIntegerProp stored False;
    property PortBaudRate: Integer index 161 read GetIntegerProp write SetIntegerProp stored False;
    property PollAutoDisable: WordBool index 167 read GetWordBoolProp write SetWordBoolProp stored False;
    property ReaderName: WideString index 168 read GetWideStringProp write SetWideStringProp stored False;
    property DataAuthMode: TOleEnum index 169 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property UpdateTrailer: WordBool index 170 read GetWordBoolProp write SetWordBoolProp stored False;
    property DataFormat: TOleEnum index 171 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LogEnabled: WordBool index 172 read GetWordBoolProp write SetWordBoolProp stored False;
    property LogFileName: WideString index 173 read GetWideStringProp write SetWideStringProp stored False;
    property RedLED: WordBool index 401 read GetWordBoolProp write SetWordBoolProp stored False;
    property GreenLED: WordBool index 402 read GetWordBoolProp write SetWordBoolProp stored False;
    property BlueLED: WordBool index 403 read GetWordBoolProp write SetWordBoolProp stored False;
    property EventID: Integer index 501 read GetIntegerProp write SetIntegerProp stored False;
    property EventsEnabled: WordBool index 510 read GetWordBoolProp write SetWordBoolProp stored False;
    property YellowLED: WordBool index 516 read GetWordBoolProp write SetWordBoolProp stored False;
    property KeyPosition: Integer index 520 read GetIntegerProp write SetIntegerProp stored False;
    property KeyVersion: Integer index 521 read GetIntegerProp write SetIntegerProp stored False;
    property LogFilePath: WideString index 523 read GetWideStringProp write SetWideStringProp stored False;
    property ParamsRegKey: WideString index 524 read GetWideStringProp write SetWideStringProp stored False;
    property KeyEntryNumber: Integer index 530 read GetIntegerProp write SetIntegerProp stored False;
    property SerialNumber: WideString index 534 read GetWideStringProp write SetWideStringProp stored False;
    property SerialNumberHex: WideString index 535 read GetWideStringProp write SetWideStringProp stored False;
    property ErrorOnCorruptedValueBlock: WordBool index 538 read GetWordBoolProp write SetWordBoolProp stored False;
    property ReceiveDivisor: Integer index 548 read GetIntegerProp write SetIntegerProp stored False;
    property SendDivisor: Integer index 549 read GetIntegerProp write SetIntegerProp stored False;
    property AuthType: Integer index 564 read GetIntegerProp write SetIntegerProp stored False;
    property BlockCount: Integer index 565 read GetIntegerProp write SetIntegerProp stored False;
    property NewBaudRate: Integer index 567 read GetIntegerProp write SetIntegerProp stored False;
    property Protocol: Integer index 603 read GetIntegerProp write SetIntegerProp stored False;
    property EncryptionEnabled: WordBool index 606 read GetWordBoolProp write SetWordBoolProp stored False;
    property AnswerSignature: WordBool index 607 read GetWordBoolProp write SetWordBoolProp stored False;
    property CommandSignature: WordBool index 608 read GetWordBoolProp write SetWordBoolProp stored False;
    property PollActivateMethod: TOleEnum index 613 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property SlotNumber: Integer index 614 read GetIntegerProp write SetIntegerProp stored False;
    property UseOptional: WordBool index 615 read GetWordBoolProp write SetWordBoolProp stored False;
    property OptionalValue: Integer index 616 read GetIntegerProp write SetIntegerProp stored False;
    property Status: Integer index 624 read GetIntegerProp write SetIntegerProp stored False;
    property DivInputHex: WideString index 625 read GetWideStringProp write SetWideStringProp stored False;
    property OnCardFound: TMifareDrvCardFound read FOnCardFound write FOnCardFound;
    property OnPollError: TMifareDrvPollError read FOnPollError write FOnPollError;
    property OnDriverEvent: TMifareDrvDriverEvent read FOnDriverEvent write FOnDriverEvent;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMifareDrv4
// Help String      : ØÒÐÈÕ-Ì: Äנאיגונ סקטעûגאעוכוי Mifare 4
// Default Interface: IMifareDrv4
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMifareDrv4 = class(TOleControl)
  private
    FIntf: IMifareDrv4;
    function  GetControlInterface: IMifareDrv4;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_SAMVersion: TSAMVersion;
  public
    procedure AboutBox;
    function AddField: Integer;
    function AuthStandard: Integer;
    function ClearBlock: Integer;
    function ClearFieldValues: Integer;
    function ClosePort: Integer;
    function Connect: Integer;
    function DecodeTrailer: Integer;
    function DecodeValueBlock: Integer;
    function DeleteAllFields: Integer;
    function DeleteAppSectors: Integer;
    function DeleteField: Integer;
    function DeleteSector: Integer;
    function Disconnect: Integer;
    function EncodeKey: Integer;
    function EncodeTrailer: Integer;
    function EncodeValueBlock: Integer;
    function FindDevice: Integer;
    function GetFieldParams: Integer;
    function GetSectorParams: Integer;
    function InterfaceSetTimeout: Integer;
    function LoadFieldsFromFile: Integer;
    function LoadParams: Integer;
    function LoadValue: Integer;
    function OpenPort: Integer;
    function PcdBeep: Integer;
    function PcdConfig: Integer;
    function PcdGetFwVersion: Integer;
    function PcdGetRicVersion: Integer;
    function PcdGetSerialNumber: Integer;
    function PcdLoadKeyE2: Integer;
    function PcdReadE2: Integer;
    function PcdReset: Integer;
    function PcdRfReset: Integer;
    function PcdSetDefaultAttrib: Integer;
    function PcdSetTmo: Integer;
    function PcdWriteE2: Integer;
    function PiccActivateIdle: Integer;
    function PiccActivateWakeup: Integer;
    function PiccAnticoll: Integer;
    function PiccAuth: Integer;
    function PiccAuthE2: Integer;
    function PiccAuthKey: Integer;
    function PiccCascAnticoll: Integer;
    function PiccCascSelect: Integer;
    function PiccCommonRead: Integer;
    function PiccCommonRequest: Integer;
    function PiccCommonWrite: Integer;
    function PiccHalt: Integer;
    function PiccRead: Integer;
    function PiccSelect: Integer;
    function PiccValue: Integer;
    function PiccValueDebit: Integer;
    function PiccWrite: Integer;
    function PollStart: Integer;
    function PollStop: Integer;
    function PortOpened: Integer;
    function ReadData: Integer;
    function ReadDirectory: Integer;
    function ReadFields: Integer;
    function ReadTrailer: Integer;
    function RequestAll: Integer;
    function RequestIdle: Integer;
    function ResetCard: Integer;
    function SaveFieldsToFile: Integer;
    function SaveParams: Integer;
    function SendEvent: Integer;
    function SetDefaults: Integer;
    function SetFieldParams: Integer;
    function SetSectorParams: Integer;
    function ShowDirectoryDlg: Integer;
    function ShowFirmsDlg: Integer;
    function ShowProperties: Integer;
    function ShowSearchDlg: Integer;
    function ShowTrailerDlg: Integer;
    function StartTransTimer: Integer;
    function StopTransTimer: Integer;
    function TestBit(AValue: Integer; ABitIndex: Integer): WordBool;
    function WriteData: Integer;
    function WriteDirectory: Integer;
    function WriteFields: Integer;
    function WriteTrailer: Integer;
    function MksFindCard: Integer;
    function MksReadCatalog: Integer;
    function MksReopen: Integer;
    function MksWriteCatalog: Integer;
    function ShowConnectionPropertiesDlg: Integer;
    function SleepMode: Integer;
    function PcdControlLEDAndPoll: Integer;
    function PcdControlLED: Integer;
    function PcdPollButton: Integer;
    function FindEvent: Integer;
    function DeleteEvent: Integer;
    function ClearEvents: Integer;
    function LockReader: Integer;
    function UnlockReader: Integer;
    function SAM_GetVersion: Integer;
    function SAM_WriteKey: Integer;
    function SAM_AuthKey: Integer;
    function SAM_WriteHostAuthKey: Integer;
    function SAM_GetKeyEntry: Integer;
    function ReadFullSerialNumber: Integer;
    function SAM_SetProtection: Integer;
    function SAM_SetProtectionSN: Integer;
    function WriteConnectionParams: Integer;
    function UltralightRead: Integer;
    function UltralightWrite: Integer;
    function UltralightCompatWrite: Integer;
    function UltralightWriteKey: Integer;
    function UltralightAuth: Integer;
    function MifarePlusWritePerso: Integer;
    function MifarePlusWriteParameters: Integer;
    function MifarePlusCommitPerso: Integer;
    function MifarePlusAuthSL1: Integer;
    function MifarePlusAuthSL3: Integer;
    function MifarePlusIncrement: Integer;
    function MifarePlusDecrement: Integer;
    function MifarePlusIncrementTransfer: Integer;
    function MifarePlusDecrementTransfer: Integer;
    function MifarePlusRead: Integer;
    function MifarePlusRestore: Integer;
    function MifarePlusTransfer: Integer;
    function MifarePlusReadValue: Integer;
    function MifarePlusWriteValue: Integer;
    function MifarePlusMultiblockRead: Integer;
    function MifarePlusMultiblockWrite: Integer;
    function MifarePlusResetAuthentication: Integer;
    function MifarePlusWrite: Integer;
    function ClearResult: Integer;
    function EnableCardAccept: Integer;
    function DisableCardAccept: Integer;
    function ReadStatus: Integer;
    function IssueCard: Integer;
    function HoldCard: Integer;
    function ReadLastAnswer: Integer;
    function MifarePlusAuthSL2: Integer;
    function SAMAV2WriteKey: Integer;
    function MifarePlusMultiblockReadSL2: Integer;
    function MifarePlusMultiblockWriteSL2: Integer;
    function MifarePlusAuthSL2Crypto1: Integer;
    function WriteEncryptedData: Integer;
    function MifarePlusSelectSAMSlot: Integer;
    function MifarePlusAuthSL3Key: Integer;
    property  ControlInterface: IMifareDrv4 read GetControlInterface;
    property  DefaultInterface: IMifareDrv4 read GetControlInterface;
    property ATQ: Word index 87 read GetWordProp;
    property CardDescription: WideString index 96 read GetWideStringProp;
    property CardType: TOleEnum index 97 read GetTOleEnumProp;
    property Connected: WordBool index 99 read GetWordBoolProp;
    property DirectoryStatus: TOleEnum index 105 read GetTOleEnumProp;
    property DirectoryStatusText: WideString index 106 read GetWideStringProp;
    property ErrorText: WideString index 107 read GetWideStringProp;
    property ExecutionTime: Integer index 108 read GetIntegerProp;
    property FieldCount: Integer index 109 read GetIntegerProp;
    property IsClient1C: WordBool index 116 read GetWordBoolProp;
    property IsShowProperties: WordBool index 117 read GetWordBoolProp;
    property PasswordHeader: WideString index 129 read GetWideStringProp;
    property PcdFwVersion: WideString index 130 read GetWideStringProp;
    property PcdRicVersion: WideString index 131 read GetWideStringProp;
    property PollStarted: WordBool index 133 read GetWordBoolProp;
    property ResultCode: Integer index 136 read GetIntegerProp;
    property ResultDescription: WideString index 137 read GetWideStringProp;
    property SAK: Byte index 140 read GetByteProp;
    property SectorCount: Integer index 141 read GetIntegerProp;
    property UIDLen: Byte index 150 read GetByteProp;
    property Version: WideString index 152 read GetWideStringProp;
    property RxData: WideString index 162 read GetWideStringProp;
    property RxDataHex: WideString index 163 read GetWideStringProp;
    property TxData: WideString index 164 read GetWideStringProp;
    property TxDataHex: WideString index 165 read GetWideStringProp;
    property ButtonState: WordBool index 404 read GetWordBoolProp;
    property EventDriverID: Integer index 502 read GetIntegerProp;
    property EventType: Integer index 503 read GetIntegerProp;
    property EventPortNumber: Integer index 504 read GetIntegerProp;
    property EventErrorCode: Integer index 505 read GetIntegerProp;
    property EventErrorText: WideString index 506 read GetWideStringProp;
    property EventCardUIDHex: WideString index 507 read GetWideStringProp;
    property EventCount: Integer index 513 read GetIntegerProp;
    property DriverID: Integer index 511 read GetIntegerProp;
    property SAMVersion: TSAMVersion read Get_SAMVersion;
    property KeyVersion0: Integer index 531 read GetIntegerProp;
    property KeyVersion1: Integer index 532 read GetIntegerProp;
    property KeyVersion2: Integer index 533 read GetIntegerProp;
    property KeyTypeText: WideString index 536 read GetWideStringProp;
    property IsValueBlockCorrupted: WordBool index 539 read GetWordBoolProp;
    property SAMHWVendorID: Integer index 569 read GetIntegerProp;
    property SAMHWVendorName: WideString index 570 read GetWideStringProp;
    property SAMHWType: Integer index 571 read GetIntegerProp;
    property SAMHWSubType: Integer index 572 read GetIntegerProp;
    property SAMHWMajorVersion: Integer index 573 read GetIntegerProp;
    property SAMHWMinorVersion: Integer index 574 read GetIntegerProp;
    property SAMHWProtocol: Integer index 575 read GetIntegerProp;
    property SAMHWStorageSize: Integer index 576 read GetIntegerProp;
    property SAMHWStorageSizeCode: Integer index 577 read GetIntegerProp;
    property SAMSWVendorID: Integer index 578 read GetIntegerProp;
    property SAMSWVendorName: WideString index 579 read GetWideStringProp;
    property SAMSWType: Integer index 580 read GetIntegerProp;
    property SAMSWSubType: Integer index 581 read GetIntegerProp;
    property SAMSWMajorVersion: Integer index 582 read GetIntegerProp;
    property SAMSWMinorVersion: Integer index 583 read GetIntegerProp;
    property SAMSWProtocol: Integer index 584 read GetIntegerProp;
    property SAMSWStorageSize: Integer index 585 read GetIntegerProp;
    property SAMSWStorageSizeCode: Integer index 586 read GetIntegerProp;
    property SAMMode: Integer index 587 read GetIntegerProp;
    property SAMModeName: WideString index 588 read GetWideStringProp;
    property SAMMDUID: Integer index 589 read GetIntegerProp;
    property SAMMDUIDHex: WideString index 590 read GetWideStringProp;
    property SAMMDBatchNo: Integer index 591 read GetIntegerProp;
    property SAMMDProductionDay: Integer index 592 read GetIntegerProp;
    property SAMMDProductionMonth: Integer index 593 read GetIntegerProp;
    property SAMMDProductionYear: Integer index 594 read GetIntegerProp;
    property SAMMDGlobalCryptoSettings: Integer index 595 read GetIntegerProp;
    property SAMMDUIDStr: WideString index 596 read GetWideStringProp;
    property SlotStatus0: Integer index 618 read GetIntegerProp;
    property SlotStatus1: Integer index 619 read GetIntegerProp;
    property SlotStatus2: Integer index 620 read GetIntegerProp;
    property SlotStatus3: Integer index 621 read GetIntegerProp;
    property SlotStatus4: Integer index 622 read GetIntegerProp;
  published
    property Anchors;
    property AccessMode0: Integer index 82 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode1: Integer index 83 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode2: Integer index 84 read GetIntegerProp write SetIntegerProp stored False;
    property AccessMode3: Integer index 85 read GetIntegerProp write SetIntegerProp stored False;
    property AppCode: Integer index 86 read GetIntegerProp write SetIntegerProp stored False;
    property BaudRate: TOleEnum index 88 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BeepTone: Integer index 89 read GetIntegerProp write SetIntegerProp stored False;
    property BitCount: Integer index 90 read GetIntegerProp write SetIntegerProp stored False;
    property BlockAddr: Integer index 91 read GetIntegerProp write SetIntegerProp stored False;
    property BlockData: WideString index 92 read GetWideStringProp write SetWideStringProp stored False;
    property BlockDataHex: WideString index 93 read GetWideStringProp write SetWideStringProp stored False;
    property BlockNumber: Integer index 94 read GetIntegerProp write SetIntegerProp stored False;
    property BlockValue: Integer index 95 read GetIntegerProp write SetIntegerProp stored False;
    property Command: TOleEnum index 98 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Data: WideString index 100 read GetWideStringProp write SetWideStringProp stored False;
    property DataLength: Integer index 101 read GetIntegerProp write SetIntegerProp stored False;
    property DataMode: TOleEnum index 102 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property DataSize: Integer index 103 read GetIntegerProp write SetIntegerProp stored False;
    property DeltaValue: Integer index 104 read GetIntegerProp write SetIntegerProp stored False;
    property FieldIndex: Integer index 110 read GetIntegerProp write SetIntegerProp stored False;
    property FieldSize: Integer index 111 read GetIntegerProp write SetIntegerProp stored False;
    property FieldType: Integer index 112 read GetIntegerProp write SetIntegerProp stored False;
    property FieldValue: WideString index 113 read GetWideStringProp write SetWideStringProp stored False;
    property FileName: WideString index 114 read GetWideStringProp write SetWideStringProp stored False;
    property FirmCode: Integer index 115 read GetIntegerProp write SetIntegerProp stored False;
    property KeyA: WideString index 118 read GetWideStringProp write SetWideStringProp stored False;
    property KeyB: WideString index 119 read GetWideStringProp write SetWideStringProp stored False;
    property KeyEncoded: WideString index 120 read GetWideStringProp write SetWideStringProp stored False;
    property KeyNumber: Integer index 121 read GetIntegerProp write SetIntegerProp stored False;
    property KeyType: TOleEnum index 122 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property KeyUncoded: WideString index 123 read GetWideStringProp write SetWideStringProp stored False;
    property LibInfoKey: Integer index 124 read GetIntegerProp write SetIntegerProp stored False;
    property LockDevices: WordBool index 125 read GetWordBoolProp write SetWordBoolProp stored False;
    property NewKeyA: WideString index 126 read GetWideStringProp write SetWideStringProp stored False;
    property NewKeyB: WideString index 127 read GetWideStringProp write SetWideStringProp stored False;
    property ParentWnd: Integer index 128 read GetIntegerProp write SetIntegerProp stored False;
    property PollInterval: Integer index 132 read GetIntegerProp write SetIntegerProp stored False;
    property PortNumber: Integer index 134 read GetIntegerProp write SetIntegerProp stored False;
    property ReqCode: TOleEnum index 135 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property RfResetTime: Integer index 138 read GetIntegerProp write SetIntegerProp stored False;
    property RICValue: Integer index 139 read GetIntegerProp write SetIntegerProp stored False;
    property SectorIndex: Integer index 142 read GetIntegerProp write SetIntegerProp stored False;
    property SectorNumber: Integer index 143 read GetIntegerProp write SetIntegerProp stored False;
    property SelectCode: TOleEnum index 144 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Timeout: Integer index 145 read GetIntegerProp write SetIntegerProp stored False;
    property TransBlockNumber: Integer index 146 read GetIntegerProp write SetIntegerProp stored False;
    property TransTime: Integer index 147 read GetIntegerProp write SetIntegerProp stored False;
    property UID: WideString index 148 read GetWideStringProp write SetWideStringProp stored False;
    property UIDHex: WideString index 149 read GetWideStringProp write SetWideStringProp stored False;
    property ValueOperation: TOleEnum index 151 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property CardATQ: Integer index 158 read GetIntegerProp write SetIntegerProp stored False;
    property DeviceType: TOleEnum index 159 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Parity: Integer index 160 read GetIntegerProp write SetIntegerProp stored False;
    property PortBaudRate: Integer index 161 read GetIntegerProp write SetIntegerProp stored False;
    property PollAutoDisable: WordBool index 167 read GetWordBoolProp write SetWordBoolProp stored False;
    property ReaderName: WideString index 168 read GetWideStringProp write SetWideStringProp stored False;
    property DataAuthMode: TOleEnum index 169 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property UpdateTrailer: WordBool index 170 read GetWordBoolProp write SetWordBoolProp stored False;
    property DataFormat: TOleEnum index 171 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LogEnabled: WordBool index 172 read GetWordBoolProp write SetWordBoolProp stored False;
    property LogFileName: WideString index 173 read GetWideStringProp write SetWideStringProp stored False;
    property RedLED: WordBool index 401 read GetWordBoolProp write SetWordBoolProp stored False;
    property GreenLED: WordBool index 402 read GetWordBoolProp write SetWordBoolProp stored False;
    property BlueLED: WordBool index 403 read GetWordBoolProp write SetWordBoolProp stored False;
    property EventID: Integer index 501 read GetIntegerProp write SetIntegerProp stored False;
    property EventsEnabled: WordBool index 510 read GetWordBoolProp write SetWordBoolProp stored False;
    property YellowLED: WordBool index 516 read GetWordBoolProp write SetWordBoolProp stored False;
    property KeyPosition: Integer index 520 read GetIntegerProp write SetIntegerProp stored False;
    property KeyVersion: Integer index 521 read GetIntegerProp write SetIntegerProp stored False;
    property LogFilePath: WideString index 523 read GetWideStringProp write SetWideStringProp stored False;
    property ParamsRegKey: WideString index 524 read GetWideStringProp write SetWideStringProp stored False;
    property KeyEntryNumber: Integer index 530 read GetIntegerProp write SetIntegerProp stored False;
    property SerialNumber: WideString index 534 read GetWideStringProp write SetWideStringProp stored False;
    property SerialNumberHex: WideString index 535 read GetWideStringProp write SetWideStringProp stored False;
    property ErrorOnCorruptedValueBlock: WordBool index 538 read GetWordBoolProp write SetWordBoolProp stored False;
    property ReceiveDivisor: Integer index 548 read GetIntegerProp write SetIntegerProp stored False;
    property SendDivisor: Integer index 549 read GetIntegerProp write SetIntegerProp stored False;
    property AuthType: Integer index 564 read GetIntegerProp write SetIntegerProp stored False;
    property BlockCount: Integer index 565 read GetIntegerProp write SetIntegerProp stored False;
    property NewBaudRate: Integer index 567 read GetIntegerProp write SetIntegerProp stored False;
    property Protocol: Integer index 603 read GetIntegerProp write SetIntegerProp stored False;
    property EncryptionEnabled: WordBool index 606 read GetWordBoolProp write SetWordBoolProp stored False;
    property AnswerSignature: WordBool index 607 read GetWordBoolProp write SetWordBoolProp stored False;
    property CommandSignature: WordBool index 608 read GetWordBoolProp write SetWordBoolProp stored False;
    property PollActivateMethod: TOleEnum index 613 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property SlotNumber: Integer index 614 read GetIntegerProp write SetIntegerProp stored False;
    property UseOptional: WordBool index 615 read GetWordBoolProp write SetWordBoolProp stored False;
    property OptionalValue: Integer index 616 read GetIntegerProp write SetIntegerProp stored False;
    property Status: Integer index 624 read GetIntegerProp write SetIntegerProp stored False;
    property DivInputHex: WideString index 625 read GetWideStringProp write SetWideStringProp stored False;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'Servers';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TMifareDrv2.InitControlData;
const
  CEventDispIDs: array [0..2] of DWORD = (
    $00000001, $00000002, $000000C9);
  CControlData: TControlData2 = (
    ClassID: '{1427F57D-CDF3-46B3-BC10-3C9D1C029F7E}';
    EventIID: '{F7F7EF32-F06D-4884-A4BC-62103A627967}';
    EventCount: 3;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnCardFound) - Cardinal(Self);
end;

procedure TMifareDrv2.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IMifareDrv3;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMifareDrv2.GetControlInterface: IMifareDrv3;
begin
  CreateControl;
  Result := FIntf;
end;

function TMifareDrv2.Get_SAMVersion: TSAMVersion;
begin
    Result := DefaultInterface.SAMVersion;
end;

procedure TMifareDrv2.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

function TMifareDrv2.AddField: Integer;
begin
  Result := DefaultInterface.AddField;
end;

function TMifareDrv2.AuthStandard: Integer;
begin
  Result := DefaultInterface.AuthStandard;
end;

function TMifareDrv2.ClearBlock: Integer;
begin
  Result := DefaultInterface.ClearBlock;
end;

function TMifareDrv2.ClearFieldValues: Integer;
begin
  Result := DefaultInterface.ClearFieldValues;
end;

function TMifareDrv2.ClosePort: Integer;
begin
  Result := DefaultInterface.ClosePort;
end;

function TMifareDrv2.Connect: Integer;
begin
  Result := DefaultInterface.Connect;
end;

function TMifareDrv2.DecodeTrailer: Integer;
begin
  Result := DefaultInterface.DecodeTrailer;
end;

function TMifareDrv2.DecodeValueBlock: Integer;
begin
  Result := DefaultInterface.DecodeValueBlock;
end;

function TMifareDrv2.DeleteAllFields: Integer;
begin
  Result := DefaultInterface.DeleteAllFields;
end;

function TMifareDrv2.DeleteAppSectors: Integer;
begin
  Result := DefaultInterface.DeleteAppSectors;
end;

function TMifareDrv2.DeleteField: Integer;
begin
  Result := DefaultInterface.DeleteField;
end;

function TMifareDrv2.DeleteSector: Integer;
begin
  Result := DefaultInterface.DeleteSector;
end;

function TMifareDrv2.Disconnect: Integer;
begin
  Result := DefaultInterface.Disconnect;
end;

function TMifareDrv2.EncodeKey: Integer;
begin
  Result := DefaultInterface.EncodeKey;
end;

function TMifareDrv2.EncodeTrailer: Integer;
begin
  Result := DefaultInterface.EncodeTrailer;
end;

function TMifareDrv2.EncodeValueBlock: Integer;
begin
  Result := DefaultInterface.EncodeValueBlock;
end;

function TMifareDrv2.FindDevice: Integer;
begin
  Result := DefaultInterface.FindDevice;
end;

function TMifareDrv2.GetFieldParams: Integer;
begin
  Result := DefaultInterface.GetFieldParams;
end;

function TMifareDrv2.GetSectorParams: Integer;
begin
  Result := DefaultInterface.GetSectorParams;
end;

function TMifareDrv2.InterfaceSetTimeout: Integer;
begin
  Result := DefaultInterface.InterfaceSetTimeout;
end;

function TMifareDrv2.LoadFieldsFromFile: Integer;
begin
  Result := DefaultInterface.LoadFieldsFromFile;
end;

function TMifareDrv2.LoadParams: Integer;
begin
  Result := DefaultInterface.LoadParams;
end;

function TMifareDrv2.LoadValue: Integer;
begin
  Result := DefaultInterface.LoadValue;
end;

function TMifareDrv2.OpenPort: Integer;
begin
  Result := DefaultInterface.OpenPort;
end;

function TMifareDrv2.PcdBeep: Integer;
begin
  Result := DefaultInterface.PcdBeep;
end;

function TMifareDrv2.PcdConfig: Integer;
begin
  Result := DefaultInterface.PcdConfig;
end;

function TMifareDrv2.PcdGetFwVersion: Integer;
begin
  Result := DefaultInterface.PcdGetFwVersion;
end;

function TMifareDrv2.PcdGetRicVersion: Integer;
begin
  Result := DefaultInterface.PcdGetRicVersion;
end;

function TMifareDrv2.PcdGetSerialNumber: Integer;
begin
  Result := DefaultInterface.PcdGetSerialNumber;
end;

function TMifareDrv2.PcdLoadKeyE2: Integer;
begin
  Result := DefaultInterface.PcdLoadKeyE2;
end;

function TMifareDrv2.PcdReadE2: Integer;
begin
  Result := DefaultInterface.PcdReadE2;
end;

function TMifareDrv2.PcdReset: Integer;
begin
  Result := DefaultInterface.PcdReset;
end;

function TMifareDrv2.PcdRfReset: Integer;
begin
  Result := DefaultInterface.PcdRfReset;
end;

function TMifareDrv2.PcdSetDefaultAttrib: Integer;
begin
  Result := DefaultInterface.PcdSetDefaultAttrib;
end;

function TMifareDrv2.PcdSetTmo: Integer;
begin
  Result := DefaultInterface.PcdSetTmo;
end;

function TMifareDrv2.PcdWriteE2: Integer;
begin
  Result := DefaultInterface.PcdWriteE2;
end;

function TMifareDrv2.PiccActivateIdle: Integer;
begin
  Result := DefaultInterface.PiccActivateIdle;
end;

function TMifareDrv2.PiccActivateWakeup: Integer;
begin
  Result := DefaultInterface.PiccActivateWakeup;
end;

function TMifareDrv2.PiccAnticoll: Integer;
begin
  Result := DefaultInterface.PiccAnticoll;
end;

function TMifareDrv2.PiccAuth: Integer;
begin
  Result := DefaultInterface.PiccAuth;
end;

function TMifareDrv2.PiccAuthE2: Integer;
begin
  Result := DefaultInterface.PiccAuthE2;
end;

function TMifareDrv2.PiccAuthKey: Integer;
begin
  Result := DefaultInterface.PiccAuthKey;
end;

function TMifareDrv2.PiccCascAnticoll: Integer;
begin
  Result := DefaultInterface.PiccCascAnticoll;
end;

function TMifareDrv2.PiccCascSelect: Integer;
begin
  Result := DefaultInterface.PiccCascSelect;
end;

function TMifareDrv2.PiccCommonRead: Integer;
begin
  Result := DefaultInterface.PiccCommonRead;
end;

function TMifareDrv2.PiccCommonRequest: Integer;
begin
  Result := DefaultInterface.PiccCommonRequest;
end;

function TMifareDrv2.PiccCommonWrite: Integer;
begin
  Result := DefaultInterface.PiccCommonWrite;
end;

function TMifareDrv2.PiccHalt: Integer;
begin
  Result := DefaultInterface.PiccHalt;
end;

function TMifareDrv2.PiccRead: Integer;
begin
  Result := DefaultInterface.PiccRead;
end;

function TMifareDrv2.PiccSelect: Integer;
begin
  Result := DefaultInterface.PiccSelect;
end;

function TMifareDrv2.PiccValue: Integer;
begin
  Result := DefaultInterface.PiccValue;
end;

function TMifareDrv2.PiccValueDebit: Integer;
begin
  Result := DefaultInterface.PiccValueDebit;
end;

function TMifareDrv2.PiccWrite: Integer;
begin
  Result := DefaultInterface.PiccWrite;
end;

function TMifareDrv2.PollStart: Integer;
begin
  Result := DefaultInterface.PollStart;
end;

function TMifareDrv2.PollStop: Integer;
begin
  Result := DefaultInterface.PollStop;
end;

function TMifareDrv2.PortOpened: Integer;
begin
  Result := DefaultInterface.PortOpened;
end;

function TMifareDrv2.ReadData: Integer;
begin
  Result := DefaultInterface.ReadData;
end;

function TMifareDrv2.ReadDirectory: Integer;
begin
  Result := DefaultInterface.ReadDirectory;
end;

function TMifareDrv2.ReadFields: Integer;
begin
  Result := DefaultInterface.ReadFields;
end;

function TMifareDrv2.ReadTrailer: Integer;
begin
  Result := DefaultInterface.ReadTrailer;
end;

function TMifareDrv2.RequestAll: Integer;
begin
  Result := DefaultInterface.RequestAll;
end;

function TMifareDrv2.RequestIdle: Integer;
begin
  Result := DefaultInterface.RequestIdle;
end;

function TMifareDrv2.ResetCard: Integer;
begin
  Result := DefaultInterface.ResetCard;
end;

function TMifareDrv2.SaveFieldsToFile: Integer;
begin
  Result := DefaultInterface.SaveFieldsToFile;
end;

function TMifareDrv2.SaveParams: Integer;
begin
  Result := DefaultInterface.SaveParams;
end;

function TMifareDrv2.SendEvent: Integer;
begin
  Result := DefaultInterface.SendEvent;
end;

function TMifareDrv2.SetDefaults: Integer;
begin
  Result := DefaultInterface.SetDefaults;
end;

function TMifareDrv2.SetFieldParams: Integer;
begin
  Result := DefaultInterface.SetFieldParams;
end;

function TMifareDrv2.SetSectorParams: Integer;
begin
  Result := DefaultInterface.SetSectorParams;
end;

function TMifareDrv2.ShowDirectoryDlg: Integer;
begin
  Result := DefaultInterface.ShowDirectoryDlg;
end;

function TMifareDrv2.ShowFirmsDlg: Integer;
begin
  Result := DefaultInterface.ShowFirmsDlg;
end;

function TMifareDrv2.ShowProperties: Integer;
begin
  Result := DefaultInterface.ShowProperties;
end;

function TMifareDrv2.ShowSearchDlg: Integer;
begin
  Result := DefaultInterface.ShowSearchDlg;
end;

function TMifareDrv2.ShowTrailerDlg: Integer;
begin
  Result := DefaultInterface.ShowTrailerDlg;
end;

function TMifareDrv2.StartTransTimer: Integer;
begin
  Result := DefaultInterface.StartTransTimer;
end;

function TMifareDrv2.StopTransTimer: Integer;
begin
  Result := DefaultInterface.StopTransTimer;
end;

function TMifareDrv2.TestBit(AValue: Integer; ABitIndex: Integer): WordBool;
begin
  Result := DefaultInterface.TestBit(AValue, ABitIndex);
end;

function TMifareDrv2.WriteData: Integer;
begin
  Result := DefaultInterface.WriteData;
end;

function TMifareDrv2.WriteDirectory: Integer;
begin
  Result := DefaultInterface.WriteDirectory;
end;

function TMifareDrv2.WriteFields: Integer;
begin
  Result := DefaultInterface.WriteFields;
end;

function TMifareDrv2.WriteTrailer: Integer;
begin
  Result := DefaultInterface.WriteTrailer;
end;

function TMifareDrv2.MksFindCard: Integer;
begin
  Result := DefaultInterface.MksFindCard;
end;

function TMifareDrv2.MksReadCatalog: Integer;
begin
  Result := DefaultInterface.MksReadCatalog;
end;

function TMifareDrv2.MksReopen: Integer;
begin
  Result := DefaultInterface.MksReopen;
end;

function TMifareDrv2.MksWriteCatalog: Integer;
begin
  Result := DefaultInterface.MksWriteCatalog;
end;

function TMifareDrv2.ShowConnectionPropertiesDlg: Integer;
begin
  Result := DefaultInterface.ShowConnectionPropertiesDlg;
end;

function TMifareDrv2.SleepMode: Integer;
begin
  Result := DefaultInterface.SleepMode;
end;

function TMifareDrv2.PcdControlLEDAndPoll: Integer;
begin
  Result := DefaultInterface.PcdControlLEDAndPoll;
end;

function TMifareDrv2.PcdControlLED: Integer;
begin
  Result := DefaultInterface.PcdControlLED;
end;

function TMifareDrv2.PcdPollButton: Integer;
begin
  Result := DefaultInterface.PcdPollButton;
end;

function TMifareDrv2.FindEvent: Integer;
begin
  Result := DefaultInterface.FindEvent;
end;

function TMifareDrv2.DeleteEvent: Integer;
begin
  Result := DefaultInterface.DeleteEvent;
end;

function TMifareDrv2.ClearEvents: Integer;
begin
  Result := DefaultInterface.ClearEvents;
end;

function TMifareDrv2.LockReader: Integer;
begin
  Result := DefaultInterface.LockReader;
end;

function TMifareDrv2.UnlockReader: Integer;
begin
  Result := DefaultInterface.UnlockReader;
end;

function TMifareDrv2.SAM_GetVersion: Integer;
begin
  Result := DefaultInterface.SAM_GetVersion;
end;

function TMifareDrv2.SAM_WriteKey: Integer;
begin
  Result := DefaultInterface.SAM_WriteKey;
end;

function TMifareDrv2.SAM_AuthKey: Integer;
begin
  Result := DefaultInterface.SAM_AuthKey;
end;

function TMifareDrv2.SAM_WriteHostAuthKey: Integer;
begin
  Result := DefaultInterface.SAM_WriteHostAuthKey;
end;

function TMifareDrv2.SAM_GetKeyEntry: Integer;
begin
  Result := DefaultInterface.SAM_GetKeyEntry;
end;

function TMifareDrv2.ReadFullSerialNumber: Integer;
begin
  Result := DefaultInterface.ReadFullSerialNumber;
end;

function TMifareDrv2.SAM_SetProtection: Integer;
begin
  Result := DefaultInterface.SAM_SetProtection;
end;

function TMifareDrv2.SAM_SetProtectionSN: Integer;
begin
  Result := DefaultInterface.SAM_SetProtectionSN;
end;

function TMifareDrv2.WriteConnectionParams: Integer;
begin
  Result := DefaultInterface.WriteConnectionParams;
end;

function TMifareDrv2.UltralightRead: Integer;
begin
  Result := DefaultInterface.UltralightRead;
end;

function TMifareDrv2.UltralightWrite: Integer;
begin
  Result := DefaultInterface.UltralightWrite;
end;

function TMifareDrv2.UltralightCompatWrite: Integer;
begin
  Result := DefaultInterface.UltralightCompatWrite;
end;

function TMifareDrv2.UltralightWriteKey: Integer;
begin
  Result := DefaultInterface.UltralightWriteKey;
end;

function TMifareDrv2.UltralightAuth: Integer;
begin
  Result := DefaultInterface.UltralightAuth;
end;

function TMifareDrv2.MifarePlusWritePerso: Integer;
begin
  Result := DefaultInterface.MifarePlusWritePerso;
end;

function TMifareDrv2.MifarePlusWriteParameters: Integer;
begin
  Result := DefaultInterface.MifarePlusWriteParameters;
end;

function TMifareDrv2.MifarePlusCommitPerso: Integer;
begin
  Result := DefaultInterface.MifarePlusCommitPerso;
end;

function TMifareDrv2.MifarePlusAuthSL1: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL1;
end;

function TMifareDrv2.MifarePlusAuthSL3: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL3;
end;

function TMifareDrv2.MifarePlusIncrement: Integer;
begin
  Result := DefaultInterface.MifarePlusIncrement;
end;

function TMifareDrv2.MifarePlusDecrement: Integer;
begin
  Result := DefaultInterface.MifarePlusDecrement;
end;

function TMifareDrv2.MifarePlusIncrementTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusIncrementTransfer;
end;

function TMifareDrv2.MifarePlusDecrementTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusDecrementTransfer;
end;

function TMifareDrv2.MifarePlusRead: Integer;
begin
  Result := DefaultInterface.MifarePlusRead;
end;

function TMifareDrv2.MifarePlusRestore: Integer;
begin
  Result := DefaultInterface.MifarePlusRestore;
end;

function TMifareDrv2.MifarePlusTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusTransfer;
end;

function TMifareDrv2.MifarePlusReadValue: Integer;
begin
  Result := DefaultInterface.MifarePlusReadValue;
end;

function TMifareDrv2.MifarePlusWriteValue: Integer;
begin
  Result := DefaultInterface.MifarePlusWriteValue;
end;

function TMifareDrv2.MifarePlusMultiblockRead: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockRead;
end;

function TMifareDrv2.MifarePlusMultiblockWrite: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockWrite;
end;

function TMifareDrv2.MifarePlusResetAuthentication: Integer;
begin
  Result := DefaultInterface.MifarePlusResetAuthentication;
end;

function TMifareDrv2.MifarePlusWrite: Integer;
begin
  Result := DefaultInterface.MifarePlusWrite;
end;

function TMifareDrv2.ClearResult: Integer;
begin
  Result := DefaultInterface.ClearResult;
end;

function TMifareDrv2.EnableCardAccept: Integer;
begin
  Result := DefaultInterface.EnableCardAccept;
end;

function TMifareDrv2.DisableCardAccept: Integer;
begin
  Result := DefaultInterface.DisableCardAccept;
end;

function TMifareDrv2.ReadStatus: Integer;
begin
  Result := DefaultInterface.ReadStatus;
end;

function TMifareDrv2.IssueCard: Integer;
begin
  Result := DefaultInterface.IssueCard;
end;

function TMifareDrv2.HoldCard: Integer;
begin
  Result := DefaultInterface.HoldCard;
end;

function TMifareDrv2.ReadLastAnswer: Integer;
begin
  Result := DefaultInterface.ReadLastAnswer;
end;

function TMifareDrv2.MifarePlusAuthSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL2;
end;

function TMifareDrv2.SAMAV2WriteKey: Integer;
begin
  Result := DefaultInterface.SAMAV2WriteKey;
end;

function TMifareDrv2.MifarePlusMultiblockReadSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockReadSL2;
end;

function TMifareDrv2.MifarePlusMultiblockWriteSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockWriteSL2;
end;

function TMifareDrv2.MifarePlusAuthSL2Crypto1: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL2Crypto1;
end;

function TMifareDrv2.WriteEncryptedData: Integer;
begin
  Result := DefaultInterface.WriteEncryptedData;
end;

procedure TMifareDrv.InitControlData;
const
  CEventDispIDs: array [0..2] of DWORD = (
    $00000001, $00000002, $000000C9);
  CControlData: TControlData2 = (
    ClassID: '{450E3DC0-5370-4007-BD5F-90827EC2C2D6}';
    EventIID: '{F7F7EF32-F06D-4884-A4BC-62103A627967}';
    EventCount: 3;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnCardFound) - Cardinal(Self);
end;

procedure TMifareDrv.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IMifareDrv4;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMifareDrv.GetControlInterface: IMifareDrv4;
begin
  CreateControl;
  Result := FIntf;
end;

function TMifareDrv.Get_SAMVersion: TSAMVersion;
begin
    Result := DefaultInterface.SAMVersion;
end;

procedure TMifareDrv.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

function TMifareDrv.AddField: Integer;
begin
  Result := DefaultInterface.AddField;
end;

function TMifareDrv.AuthStandard: Integer;
begin
  Result := DefaultInterface.AuthStandard;
end;

function TMifareDrv.ClearBlock: Integer;
begin
  Result := DefaultInterface.ClearBlock;
end;

function TMifareDrv.ClearFieldValues: Integer;
begin
  Result := DefaultInterface.ClearFieldValues;
end;

function TMifareDrv.ClosePort: Integer;
begin
  Result := DefaultInterface.ClosePort;
end;

function TMifareDrv.Connect: Integer;
begin
  Result := DefaultInterface.Connect;
end;

function TMifareDrv.DecodeTrailer: Integer;
begin
  Result := DefaultInterface.DecodeTrailer;
end;

function TMifareDrv.DecodeValueBlock: Integer;
begin
  Result := DefaultInterface.DecodeValueBlock;
end;

function TMifareDrv.DeleteAllFields: Integer;
begin
  Result := DefaultInterface.DeleteAllFields;
end;

function TMifareDrv.DeleteAppSectors: Integer;
begin
  Result := DefaultInterface.DeleteAppSectors;
end;

function TMifareDrv.DeleteField: Integer;
begin
  Result := DefaultInterface.DeleteField;
end;

function TMifareDrv.DeleteSector: Integer;
begin
  Result := DefaultInterface.DeleteSector;
end;

function TMifareDrv.Disconnect: Integer;
begin
  Result := DefaultInterface.Disconnect;
end;

function TMifareDrv.EncodeKey: Integer;
begin
  Result := DefaultInterface.EncodeKey;
end;

function TMifareDrv.EncodeTrailer: Integer;
begin
  Result := DefaultInterface.EncodeTrailer;
end;

function TMifareDrv.EncodeValueBlock: Integer;
begin
  Result := DefaultInterface.EncodeValueBlock;
end;

function TMifareDrv.FindDevice: Integer;
begin
  Result := DefaultInterface.FindDevice;
end;

function TMifareDrv.GetFieldParams: Integer;
begin
  Result := DefaultInterface.GetFieldParams;
end;

function TMifareDrv.GetSectorParams: Integer;
begin
  Result := DefaultInterface.GetSectorParams;
end;

function TMifareDrv.InterfaceSetTimeout: Integer;
begin
  Result := DefaultInterface.InterfaceSetTimeout;
end;

function TMifareDrv.LoadFieldsFromFile: Integer;
begin
  Result := DefaultInterface.LoadFieldsFromFile;
end;

function TMifareDrv.LoadParams: Integer;
begin
  Result := DefaultInterface.LoadParams;
end;

function TMifareDrv.LoadValue: Integer;
begin
  Result := DefaultInterface.LoadValue;
end;

function TMifareDrv.OpenPort: Integer;
begin
  Result := DefaultInterface.OpenPort;
end;

function TMifareDrv.PcdBeep: Integer;
begin
  Result := DefaultInterface.PcdBeep;
end;

function TMifareDrv.PcdConfig: Integer;
begin
  Result := DefaultInterface.PcdConfig;
end;

function TMifareDrv.PcdGetFwVersion: Integer;
begin
  Result := DefaultInterface.PcdGetFwVersion;
end;

function TMifareDrv.PcdGetRicVersion: Integer;
begin
  Result := DefaultInterface.PcdGetRicVersion;
end;

function TMifareDrv.PcdGetSerialNumber: Integer;
begin
  Result := DefaultInterface.PcdGetSerialNumber;
end;

function TMifareDrv.PcdLoadKeyE2: Integer;
begin
  Result := DefaultInterface.PcdLoadKeyE2;
end;

function TMifareDrv.PcdReadE2: Integer;
begin
  Result := DefaultInterface.PcdReadE2;
end;

function TMifareDrv.PcdReset: Integer;
begin
  Result := DefaultInterface.PcdReset;
end;

function TMifareDrv.PcdRfReset: Integer;
begin
  Result := DefaultInterface.PcdRfReset;
end;

function TMifareDrv.PcdSetDefaultAttrib: Integer;
begin
  Result := DefaultInterface.PcdSetDefaultAttrib;
end;

function TMifareDrv.PcdSetTmo: Integer;
begin
  Result := DefaultInterface.PcdSetTmo;
end;

function TMifareDrv.PcdWriteE2: Integer;
begin
  Result := DefaultInterface.PcdWriteE2;
end;

function TMifareDrv.PiccActivateIdle: Integer;
begin
  Result := DefaultInterface.PiccActivateIdle;
end;

function TMifareDrv.PiccActivateWakeup: Integer;
begin
  Result := DefaultInterface.PiccActivateWakeup;
end;

function TMifareDrv.PiccAnticoll: Integer;
begin
  Result := DefaultInterface.PiccAnticoll;
end;

function TMifareDrv.PiccAuth: Integer;
begin
  Result := DefaultInterface.PiccAuth;
end;

function TMifareDrv.PiccAuthE2: Integer;
begin
  Result := DefaultInterface.PiccAuthE2;
end;

function TMifareDrv.PiccAuthKey: Integer;
begin
  Result := DefaultInterface.PiccAuthKey;
end;

function TMifareDrv.PiccCascAnticoll: Integer;
begin
  Result := DefaultInterface.PiccCascAnticoll;
end;

function TMifareDrv.PiccCascSelect: Integer;
begin
  Result := DefaultInterface.PiccCascSelect;
end;

function TMifareDrv.PiccCommonRead: Integer;
begin
  Result := DefaultInterface.PiccCommonRead;
end;

function TMifareDrv.PiccCommonRequest: Integer;
begin
  Result := DefaultInterface.PiccCommonRequest;
end;

function TMifareDrv.PiccCommonWrite: Integer;
begin
  Result := DefaultInterface.PiccCommonWrite;
end;

function TMifareDrv.PiccHalt: Integer;
begin
  Result := DefaultInterface.PiccHalt;
end;

function TMifareDrv.PiccRead: Integer;
begin
  Result := DefaultInterface.PiccRead;
end;

function TMifareDrv.PiccSelect: Integer;
begin
  Result := DefaultInterface.PiccSelect;
end;

function TMifareDrv.PiccValue: Integer;
begin
  Result := DefaultInterface.PiccValue;
end;

function TMifareDrv.PiccValueDebit: Integer;
begin
  Result := DefaultInterface.PiccValueDebit;
end;

function TMifareDrv.PiccWrite: Integer;
begin
  Result := DefaultInterface.PiccWrite;
end;

function TMifareDrv.PollStart: Integer;
begin
  Result := DefaultInterface.PollStart;
end;

function TMifareDrv.PollStop: Integer;
begin
  Result := DefaultInterface.PollStop;
end;

function TMifareDrv.PortOpened: Integer;
begin
  Result := DefaultInterface.PortOpened;
end;

function TMifareDrv.ReadData: Integer;
begin
  Result := DefaultInterface.ReadData;
end;

function TMifareDrv.ReadDirectory: Integer;
begin
  Result := DefaultInterface.ReadDirectory;
end;

function TMifareDrv.ReadFields: Integer;
begin
  Result := DefaultInterface.ReadFields;
end;

function TMifareDrv.ReadTrailer: Integer;
begin
  Result := DefaultInterface.ReadTrailer;
end;

function TMifareDrv.RequestAll: Integer;
begin
  Result := DefaultInterface.RequestAll;
end;

function TMifareDrv.RequestIdle: Integer;
begin
  Result := DefaultInterface.RequestIdle;
end;

function TMifareDrv.ResetCard: Integer;
begin
  Result := DefaultInterface.ResetCard;
end;

function TMifareDrv.SaveFieldsToFile: Integer;
begin
  Result := DefaultInterface.SaveFieldsToFile;
end;

function TMifareDrv.SaveParams: Integer;
begin
  Result := DefaultInterface.SaveParams;
end;

function TMifareDrv.SendEvent: Integer;
begin
  Result := DefaultInterface.SendEvent;
end;

function TMifareDrv.SetDefaults: Integer;
begin
  Result := DefaultInterface.SetDefaults;
end;

function TMifareDrv.SetFieldParams: Integer;
begin
  Result := DefaultInterface.SetFieldParams;
end;

function TMifareDrv.SetSectorParams: Integer;
begin
  Result := DefaultInterface.SetSectorParams;
end;

function TMifareDrv.ShowDirectoryDlg: Integer;
begin
  Result := DefaultInterface.ShowDirectoryDlg;
end;

function TMifareDrv.ShowFirmsDlg: Integer;
begin
  Result := DefaultInterface.ShowFirmsDlg;
end;

function TMifareDrv.ShowProperties: Integer;
begin
  Result := DefaultInterface.ShowProperties;
end;

function TMifareDrv.ShowSearchDlg: Integer;
begin
  Result := DefaultInterface.ShowSearchDlg;
end;

function TMifareDrv.ShowTrailerDlg: Integer;
begin
  Result := DefaultInterface.ShowTrailerDlg;
end;

function TMifareDrv.StartTransTimer: Integer;
begin
  Result := DefaultInterface.StartTransTimer;
end;

function TMifareDrv.StopTransTimer: Integer;
begin
  Result := DefaultInterface.StopTransTimer;
end;

function TMifareDrv.TestBit(AValue: Integer; ABitIndex: Integer): WordBool;
begin
  Result := DefaultInterface.TestBit(AValue, ABitIndex);
end;

function TMifareDrv.WriteData: Integer;
begin
  Result := DefaultInterface.WriteData;
end;

function TMifareDrv.WriteDirectory: Integer;
begin
  Result := DefaultInterface.WriteDirectory;
end;

function TMifareDrv.WriteFields: Integer;
begin
  Result := DefaultInterface.WriteFields;
end;

function TMifareDrv.WriteTrailer: Integer;
begin
  Result := DefaultInterface.WriteTrailer;
end;

function TMifareDrv.MksFindCard: Integer;
begin
  Result := DefaultInterface.MksFindCard;
end;

function TMifareDrv.MksReadCatalog: Integer;
begin
  Result := DefaultInterface.MksReadCatalog;
end;

function TMifareDrv.MksReopen: Integer;
begin
  Result := DefaultInterface.MksReopen;
end;

function TMifareDrv.MksWriteCatalog: Integer;
begin
  Result := DefaultInterface.MksWriteCatalog;
end;

function TMifareDrv.ShowConnectionPropertiesDlg: Integer;
begin
  Result := DefaultInterface.ShowConnectionPropertiesDlg;
end;

function TMifareDrv.SleepMode: Integer;
begin
  Result := DefaultInterface.SleepMode;
end;

function TMifareDrv.PcdControlLEDAndPoll: Integer;
begin
  Result := DefaultInterface.PcdControlLEDAndPoll;
end;

function TMifareDrv.PcdControlLED: Integer;
begin
  Result := DefaultInterface.PcdControlLED;
end;

function TMifareDrv.PcdPollButton: Integer;
begin
  Result := DefaultInterface.PcdPollButton;
end;

function TMifareDrv.FindEvent: Integer;
begin
  Result := DefaultInterface.FindEvent;
end;

function TMifareDrv.DeleteEvent: Integer;
begin
  Result := DefaultInterface.DeleteEvent;
end;

function TMifareDrv.ClearEvents: Integer;
begin
  Result := DefaultInterface.ClearEvents;
end;

function TMifareDrv.LockReader: Integer;
begin
  Result := DefaultInterface.LockReader;
end;

function TMifareDrv.UnlockReader: Integer;
begin
  Result := DefaultInterface.UnlockReader;
end;

function TMifareDrv.SAM_GetVersion: Integer;
begin
  Result := DefaultInterface.SAM_GetVersion;
end;

function TMifareDrv.SAM_WriteKey: Integer;
begin
  Result := DefaultInterface.SAM_WriteKey;
end;

function TMifareDrv.SAM_AuthKey: Integer;
begin
  Result := DefaultInterface.SAM_AuthKey;
end;

function TMifareDrv.SAM_WriteHostAuthKey: Integer;
begin
  Result := DefaultInterface.SAM_WriteHostAuthKey;
end;

function TMifareDrv.SAM_GetKeyEntry: Integer;
begin
  Result := DefaultInterface.SAM_GetKeyEntry;
end;

function TMifareDrv.ReadFullSerialNumber: Integer;
begin
  Result := DefaultInterface.ReadFullSerialNumber;
end;

function TMifareDrv.SAM_SetProtection: Integer;
begin
  Result := DefaultInterface.SAM_SetProtection;
end;

function TMifareDrv.SAM_SetProtectionSN: Integer;
begin
  Result := DefaultInterface.SAM_SetProtectionSN;
end;

function TMifareDrv.WriteConnectionParams: Integer;
begin
  Result := DefaultInterface.WriteConnectionParams;
end;

function TMifareDrv.UltralightRead: Integer;
begin
  Result := DefaultInterface.UltralightRead;
end;

function TMifareDrv.UltralightWrite: Integer;
begin
  Result := DefaultInterface.UltralightWrite;
end;

function TMifareDrv.UltralightCompatWrite: Integer;
begin
  Result := DefaultInterface.UltralightCompatWrite;
end;

function TMifareDrv.UltralightWriteKey: Integer;
begin
  Result := DefaultInterface.UltralightWriteKey;
end;

function TMifareDrv.UltralightAuth: Integer;
begin
  Result := DefaultInterface.UltralightAuth;
end;

function TMifareDrv.MifarePlusWritePerso: Integer;
begin
  Result := DefaultInterface.MifarePlusWritePerso;
end;

function TMifareDrv.MifarePlusWriteParameters: Integer;
begin
  Result := DefaultInterface.MifarePlusWriteParameters;
end;

function TMifareDrv.MifarePlusCommitPerso: Integer;
begin
  Result := DefaultInterface.MifarePlusCommitPerso;
end;

function TMifareDrv.MifarePlusAuthSL1: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL1;
end;

function TMifareDrv.MifarePlusAuthSL3: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL3;
end;

function TMifareDrv.MifarePlusIncrement: Integer;
begin
  Result := DefaultInterface.MifarePlusIncrement;
end;

function TMifareDrv.MifarePlusDecrement: Integer;
begin
  Result := DefaultInterface.MifarePlusDecrement;
end;

function TMifareDrv.MifarePlusIncrementTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusIncrementTransfer;
end;

function TMifareDrv.MifarePlusDecrementTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusDecrementTransfer;
end;

function TMifareDrv.MifarePlusRead: Integer;
begin
  Result := DefaultInterface.MifarePlusRead;
end;

function TMifareDrv.MifarePlusRestore: Integer;
begin
  Result := DefaultInterface.MifarePlusRestore;
end;

function TMifareDrv.MifarePlusTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusTransfer;
end;

function TMifareDrv.MifarePlusReadValue: Integer;
begin
  Result := DefaultInterface.MifarePlusReadValue;
end;

function TMifareDrv.MifarePlusWriteValue: Integer;
begin
  Result := DefaultInterface.MifarePlusWriteValue;
end;

function TMifareDrv.MifarePlusMultiblockRead: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockRead;
end;

function TMifareDrv.MifarePlusMultiblockWrite: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockWrite;
end;

function TMifareDrv.MifarePlusResetAuthentication: Integer;
begin
  Result := DefaultInterface.MifarePlusResetAuthentication;
end;

function TMifareDrv.MifarePlusWrite: Integer;
begin
  Result := DefaultInterface.MifarePlusWrite;
end;

function TMifareDrv.ClearResult: Integer;
begin
  Result := DefaultInterface.ClearResult;
end;

function TMifareDrv.EnableCardAccept: Integer;
begin
  Result := DefaultInterface.EnableCardAccept;
end;

function TMifareDrv.DisableCardAccept: Integer;
begin
  Result := DefaultInterface.DisableCardAccept;
end;

function TMifareDrv.ReadStatus: Integer;
begin
  Result := DefaultInterface.ReadStatus;
end;

function TMifareDrv.IssueCard: Integer;
begin
  Result := DefaultInterface.IssueCard;
end;

function TMifareDrv.HoldCard: Integer;
begin
  Result := DefaultInterface.HoldCard;
end;

function TMifareDrv.ReadLastAnswer: Integer;
begin
  Result := DefaultInterface.ReadLastAnswer;
end;

function TMifareDrv.MifarePlusAuthSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL2;
end;

function TMifareDrv.SAMAV2WriteKey: Integer;
begin
  Result := DefaultInterface.SAMAV2WriteKey;
end;

function TMifareDrv.MifarePlusMultiblockReadSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockReadSL2;
end;

function TMifareDrv.MifarePlusMultiblockWriteSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockWriteSL2;
end;

function TMifareDrv.MifarePlusAuthSL2Crypto1: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL2Crypto1;
end;

function TMifareDrv.WriteEncryptedData: Integer;
begin
  Result := DefaultInterface.WriteEncryptedData;
end;

function TMifareDrv.MifarePlusSelectSAMSlot: Integer;
begin
  Result := DefaultInterface.MifarePlusSelectSAMSlot;
end;

function TMifareDrv.MifarePlusAuthSL3Key: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL3Key;
end;

procedure TMifareDrv4.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{DD055FE8-636A-4666-8D75-7CF115D5A159}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TMifareDrv4.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IMifareDrv4;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMifareDrv4.GetControlInterface: IMifareDrv4;
begin
  CreateControl;
  Result := FIntf;
end;

function TMifareDrv4.Get_SAMVersion: TSAMVersion;
begin
    Result := DefaultInterface.SAMVersion;
end;

procedure TMifareDrv4.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

function TMifareDrv4.AddField: Integer;
begin
  Result := DefaultInterface.AddField;
end;

function TMifareDrv4.AuthStandard: Integer;
begin
  Result := DefaultInterface.AuthStandard;
end;

function TMifareDrv4.ClearBlock: Integer;
begin
  Result := DefaultInterface.ClearBlock;
end;

function TMifareDrv4.ClearFieldValues: Integer;
begin
  Result := DefaultInterface.ClearFieldValues;
end;

function TMifareDrv4.ClosePort: Integer;
begin
  Result := DefaultInterface.ClosePort;
end;

function TMifareDrv4.Connect: Integer;
begin
  Result := DefaultInterface.Connect;
end;

function TMifareDrv4.DecodeTrailer: Integer;
begin
  Result := DefaultInterface.DecodeTrailer;
end;

function TMifareDrv4.DecodeValueBlock: Integer;
begin
  Result := DefaultInterface.DecodeValueBlock;
end;

function TMifareDrv4.DeleteAllFields: Integer;
begin
  Result := DefaultInterface.DeleteAllFields;
end;

function TMifareDrv4.DeleteAppSectors: Integer;
begin
  Result := DefaultInterface.DeleteAppSectors;
end;

function TMifareDrv4.DeleteField: Integer;
begin
  Result := DefaultInterface.DeleteField;
end;

function TMifareDrv4.DeleteSector: Integer;
begin
  Result := DefaultInterface.DeleteSector;
end;

function TMifareDrv4.Disconnect: Integer;
begin
  Result := DefaultInterface.Disconnect;
end;

function TMifareDrv4.EncodeKey: Integer;
begin
  Result := DefaultInterface.EncodeKey;
end;

function TMifareDrv4.EncodeTrailer: Integer;
begin
  Result := DefaultInterface.EncodeTrailer;
end;

function TMifareDrv4.EncodeValueBlock: Integer;
begin
  Result := DefaultInterface.EncodeValueBlock;
end;

function TMifareDrv4.FindDevice: Integer;
begin
  Result := DefaultInterface.FindDevice;
end;

function TMifareDrv4.GetFieldParams: Integer;
begin
  Result := DefaultInterface.GetFieldParams;
end;

function TMifareDrv4.GetSectorParams: Integer;
begin
  Result := DefaultInterface.GetSectorParams;
end;

function TMifareDrv4.InterfaceSetTimeout: Integer;
begin
  Result := DefaultInterface.InterfaceSetTimeout;
end;

function TMifareDrv4.LoadFieldsFromFile: Integer;
begin
  Result := DefaultInterface.LoadFieldsFromFile;
end;

function TMifareDrv4.LoadParams: Integer;
begin
  Result := DefaultInterface.LoadParams;
end;

function TMifareDrv4.LoadValue: Integer;
begin
  Result := DefaultInterface.LoadValue;
end;

function TMifareDrv4.OpenPort: Integer;
begin
  Result := DefaultInterface.OpenPort;
end;

function TMifareDrv4.PcdBeep: Integer;
begin
  Result := DefaultInterface.PcdBeep;
end;

function TMifareDrv4.PcdConfig: Integer;
begin
  Result := DefaultInterface.PcdConfig;
end;

function TMifareDrv4.PcdGetFwVersion: Integer;
begin
  Result := DefaultInterface.PcdGetFwVersion;
end;

function TMifareDrv4.PcdGetRicVersion: Integer;
begin
  Result := DefaultInterface.PcdGetRicVersion;
end;

function TMifareDrv4.PcdGetSerialNumber: Integer;
begin
  Result := DefaultInterface.PcdGetSerialNumber;
end;

function TMifareDrv4.PcdLoadKeyE2: Integer;
begin
  Result := DefaultInterface.PcdLoadKeyE2;
end;

function TMifareDrv4.PcdReadE2: Integer;
begin
  Result := DefaultInterface.PcdReadE2;
end;

function TMifareDrv4.PcdReset: Integer;
begin
  Result := DefaultInterface.PcdReset;
end;

function TMifareDrv4.PcdRfReset: Integer;
begin
  Result := DefaultInterface.PcdRfReset;
end;

function TMifareDrv4.PcdSetDefaultAttrib: Integer;
begin
  Result := DefaultInterface.PcdSetDefaultAttrib;
end;

function TMifareDrv4.PcdSetTmo: Integer;
begin
  Result := DefaultInterface.PcdSetTmo;
end;

function TMifareDrv4.PcdWriteE2: Integer;
begin
  Result := DefaultInterface.PcdWriteE2;
end;

function TMifareDrv4.PiccActivateIdle: Integer;
begin
  Result := DefaultInterface.PiccActivateIdle;
end;

function TMifareDrv4.PiccActivateWakeup: Integer;
begin
  Result := DefaultInterface.PiccActivateWakeup;
end;

function TMifareDrv4.PiccAnticoll: Integer;
begin
  Result := DefaultInterface.PiccAnticoll;
end;

function TMifareDrv4.PiccAuth: Integer;
begin
  Result := DefaultInterface.PiccAuth;
end;

function TMifareDrv4.PiccAuthE2: Integer;
begin
  Result := DefaultInterface.PiccAuthE2;
end;

function TMifareDrv4.PiccAuthKey: Integer;
begin
  Result := DefaultInterface.PiccAuthKey;
end;

function TMifareDrv4.PiccCascAnticoll: Integer;
begin
  Result := DefaultInterface.PiccCascAnticoll;
end;

function TMifareDrv4.PiccCascSelect: Integer;
begin
  Result := DefaultInterface.PiccCascSelect;
end;

function TMifareDrv4.PiccCommonRead: Integer;
begin
  Result := DefaultInterface.PiccCommonRead;
end;

function TMifareDrv4.PiccCommonRequest: Integer;
begin
  Result := DefaultInterface.PiccCommonRequest;
end;

function TMifareDrv4.PiccCommonWrite: Integer;
begin
  Result := DefaultInterface.PiccCommonWrite;
end;

function TMifareDrv4.PiccHalt: Integer;
begin
  Result := DefaultInterface.PiccHalt;
end;

function TMifareDrv4.PiccRead: Integer;
begin
  Result := DefaultInterface.PiccRead;
end;

function TMifareDrv4.PiccSelect: Integer;
begin
  Result := DefaultInterface.PiccSelect;
end;

function TMifareDrv4.PiccValue: Integer;
begin
  Result := DefaultInterface.PiccValue;
end;

function TMifareDrv4.PiccValueDebit: Integer;
begin
  Result := DefaultInterface.PiccValueDebit;
end;

function TMifareDrv4.PiccWrite: Integer;
begin
  Result := DefaultInterface.PiccWrite;
end;

function TMifareDrv4.PollStart: Integer;
begin
  Result := DefaultInterface.PollStart;
end;

function TMifareDrv4.PollStop: Integer;
begin
  Result := DefaultInterface.PollStop;
end;

function TMifareDrv4.PortOpened: Integer;
begin
  Result := DefaultInterface.PortOpened;
end;

function TMifareDrv4.ReadData: Integer;
begin
  Result := DefaultInterface.ReadData;
end;

function TMifareDrv4.ReadDirectory: Integer;
begin
  Result := DefaultInterface.ReadDirectory;
end;

function TMifareDrv4.ReadFields: Integer;
begin
  Result := DefaultInterface.ReadFields;
end;

function TMifareDrv4.ReadTrailer: Integer;
begin
  Result := DefaultInterface.ReadTrailer;
end;

function TMifareDrv4.RequestAll: Integer;
begin
  Result := DefaultInterface.RequestAll;
end;

function TMifareDrv4.RequestIdle: Integer;
begin
  Result := DefaultInterface.RequestIdle;
end;

function TMifareDrv4.ResetCard: Integer;
begin
  Result := DefaultInterface.ResetCard;
end;

function TMifareDrv4.SaveFieldsToFile: Integer;
begin
  Result := DefaultInterface.SaveFieldsToFile;
end;

function TMifareDrv4.SaveParams: Integer;
begin
  Result := DefaultInterface.SaveParams;
end;

function TMifareDrv4.SendEvent: Integer;
begin
  Result := DefaultInterface.SendEvent;
end;

function TMifareDrv4.SetDefaults: Integer;
begin
  Result := DefaultInterface.SetDefaults;
end;

function TMifareDrv4.SetFieldParams: Integer;
begin
  Result := DefaultInterface.SetFieldParams;
end;

function TMifareDrv4.SetSectorParams: Integer;
begin
  Result := DefaultInterface.SetSectorParams;
end;

function TMifareDrv4.ShowDirectoryDlg: Integer;
begin
  Result := DefaultInterface.ShowDirectoryDlg;
end;

function TMifareDrv4.ShowFirmsDlg: Integer;
begin
  Result := DefaultInterface.ShowFirmsDlg;
end;

function TMifareDrv4.ShowProperties: Integer;
begin
  Result := DefaultInterface.ShowProperties;
end;

function TMifareDrv4.ShowSearchDlg: Integer;
begin
  Result := DefaultInterface.ShowSearchDlg;
end;

function TMifareDrv4.ShowTrailerDlg: Integer;
begin
  Result := DefaultInterface.ShowTrailerDlg;
end;

function TMifareDrv4.StartTransTimer: Integer;
begin
  Result := DefaultInterface.StartTransTimer;
end;

function TMifareDrv4.StopTransTimer: Integer;
begin
  Result := DefaultInterface.StopTransTimer;
end;

function TMifareDrv4.TestBit(AValue: Integer; ABitIndex: Integer): WordBool;
begin
  Result := DefaultInterface.TestBit(AValue, ABitIndex);
end;

function TMifareDrv4.WriteData: Integer;
begin
  Result := DefaultInterface.WriteData;
end;

function TMifareDrv4.WriteDirectory: Integer;
begin
  Result := DefaultInterface.WriteDirectory;
end;

function TMifareDrv4.WriteFields: Integer;
begin
  Result := DefaultInterface.WriteFields;
end;

function TMifareDrv4.WriteTrailer: Integer;
begin
  Result := DefaultInterface.WriteTrailer;
end;

function TMifareDrv4.MksFindCard: Integer;
begin
  Result := DefaultInterface.MksFindCard;
end;

function TMifareDrv4.MksReadCatalog: Integer;
begin
  Result := DefaultInterface.MksReadCatalog;
end;

function TMifareDrv4.MksReopen: Integer;
begin
  Result := DefaultInterface.MksReopen;
end;

function TMifareDrv4.MksWriteCatalog: Integer;
begin
  Result := DefaultInterface.MksWriteCatalog;
end;

function TMifareDrv4.ShowConnectionPropertiesDlg: Integer;
begin
  Result := DefaultInterface.ShowConnectionPropertiesDlg;
end;

function TMifareDrv4.SleepMode: Integer;
begin
  Result := DefaultInterface.SleepMode;
end;

function TMifareDrv4.PcdControlLEDAndPoll: Integer;
begin
  Result := DefaultInterface.PcdControlLEDAndPoll;
end;

function TMifareDrv4.PcdControlLED: Integer;
begin
  Result := DefaultInterface.PcdControlLED;
end;

function TMifareDrv4.PcdPollButton: Integer;
begin
  Result := DefaultInterface.PcdPollButton;
end;

function TMifareDrv4.FindEvent: Integer;
begin
  Result := DefaultInterface.FindEvent;
end;

function TMifareDrv4.DeleteEvent: Integer;
begin
  Result := DefaultInterface.DeleteEvent;
end;

function TMifareDrv4.ClearEvents: Integer;
begin
  Result := DefaultInterface.ClearEvents;
end;

function TMifareDrv4.LockReader: Integer;
begin
  Result := DefaultInterface.LockReader;
end;

function TMifareDrv4.UnlockReader: Integer;
begin
  Result := DefaultInterface.UnlockReader;
end;

function TMifareDrv4.SAM_GetVersion: Integer;
begin
  Result := DefaultInterface.SAM_GetVersion;
end;

function TMifareDrv4.SAM_WriteKey: Integer;
begin
  Result := DefaultInterface.SAM_WriteKey;
end;

function TMifareDrv4.SAM_AuthKey: Integer;
begin
  Result := DefaultInterface.SAM_AuthKey;
end;

function TMifareDrv4.SAM_WriteHostAuthKey: Integer;
begin
  Result := DefaultInterface.SAM_WriteHostAuthKey;
end;

function TMifareDrv4.SAM_GetKeyEntry: Integer;
begin
  Result := DefaultInterface.SAM_GetKeyEntry;
end;

function TMifareDrv4.ReadFullSerialNumber: Integer;
begin
  Result := DefaultInterface.ReadFullSerialNumber;
end;

function TMifareDrv4.SAM_SetProtection: Integer;
begin
  Result := DefaultInterface.SAM_SetProtection;
end;

function TMifareDrv4.SAM_SetProtectionSN: Integer;
begin
  Result := DefaultInterface.SAM_SetProtectionSN;
end;

function TMifareDrv4.WriteConnectionParams: Integer;
begin
  Result := DefaultInterface.WriteConnectionParams;
end;

function TMifareDrv4.UltralightRead: Integer;
begin
  Result := DefaultInterface.UltralightRead;
end;

function TMifareDrv4.UltralightWrite: Integer;
begin
  Result := DefaultInterface.UltralightWrite;
end;

function TMifareDrv4.UltralightCompatWrite: Integer;
begin
  Result := DefaultInterface.UltralightCompatWrite;
end;

function TMifareDrv4.UltralightWriteKey: Integer;
begin
  Result := DefaultInterface.UltralightWriteKey;
end;

function TMifareDrv4.UltralightAuth: Integer;
begin
  Result := DefaultInterface.UltralightAuth;
end;

function TMifareDrv4.MifarePlusWritePerso: Integer;
begin
  Result := DefaultInterface.MifarePlusWritePerso;
end;

function TMifareDrv4.MifarePlusWriteParameters: Integer;
begin
  Result := DefaultInterface.MifarePlusWriteParameters;
end;

function TMifareDrv4.MifarePlusCommitPerso: Integer;
begin
  Result := DefaultInterface.MifarePlusCommitPerso;
end;

function TMifareDrv4.MifarePlusAuthSL1: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL1;
end;

function TMifareDrv4.MifarePlusAuthSL3: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL3;
end;

function TMifareDrv4.MifarePlusIncrement: Integer;
begin
  Result := DefaultInterface.MifarePlusIncrement;
end;

function TMifareDrv4.MifarePlusDecrement: Integer;
begin
  Result := DefaultInterface.MifarePlusDecrement;
end;

function TMifareDrv4.MifarePlusIncrementTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusIncrementTransfer;
end;

function TMifareDrv4.MifarePlusDecrementTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusDecrementTransfer;
end;

function TMifareDrv4.MifarePlusRead: Integer;
begin
  Result := DefaultInterface.MifarePlusRead;
end;

function TMifareDrv4.MifarePlusRestore: Integer;
begin
  Result := DefaultInterface.MifarePlusRestore;
end;

function TMifareDrv4.MifarePlusTransfer: Integer;
begin
  Result := DefaultInterface.MifarePlusTransfer;
end;

function TMifareDrv4.MifarePlusReadValue: Integer;
begin
  Result := DefaultInterface.MifarePlusReadValue;
end;

function TMifareDrv4.MifarePlusWriteValue: Integer;
begin
  Result := DefaultInterface.MifarePlusWriteValue;
end;

function TMifareDrv4.MifarePlusMultiblockRead: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockRead;
end;

function TMifareDrv4.MifarePlusMultiblockWrite: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockWrite;
end;

function TMifareDrv4.MifarePlusResetAuthentication: Integer;
begin
  Result := DefaultInterface.MifarePlusResetAuthentication;
end;

function TMifareDrv4.MifarePlusWrite: Integer;
begin
  Result := DefaultInterface.MifarePlusWrite;
end;

function TMifareDrv4.ClearResult: Integer;
begin
  Result := DefaultInterface.ClearResult;
end;

function TMifareDrv4.EnableCardAccept: Integer;
begin
  Result := DefaultInterface.EnableCardAccept;
end;

function TMifareDrv4.DisableCardAccept: Integer;
begin
  Result := DefaultInterface.DisableCardAccept;
end;

function TMifareDrv4.ReadStatus: Integer;
begin
  Result := DefaultInterface.ReadStatus;
end;

function TMifareDrv4.IssueCard: Integer;
begin
  Result := DefaultInterface.IssueCard;
end;

function TMifareDrv4.HoldCard: Integer;
begin
  Result := DefaultInterface.HoldCard;
end;

function TMifareDrv4.ReadLastAnswer: Integer;
begin
  Result := DefaultInterface.ReadLastAnswer;
end;

function TMifareDrv4.MifarePlusAuthSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL2;
end;

function TMifareDrv4.SAMAV2WriteKey: Integer;
begin
  Result := DefaultInterface.SAMAV2WriteKey;
end;

function TMifareDrv4.MifarePlusMultiblockReadSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockReadSL2;
end;

function TMifareDrv4.MifarePlusMultiblockWriteSL2: Integer;
begin
  Result := DefaultInterface.MifarePlusMultiblockWriteSL2;
end;

function TMifareDrv4.MifarePlusAuthSL2Crypto1: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL2Crypto1;
end;

function TMifareDrv4.WriteEncryptedData: Integer;
begin
  Result := DefaultInterface.WriteEncryptedData;
end;

function TMifareDrv4.MifarePlusSelectSAMSlot: Integer;
begin
  Result := DefaultInterface.MifarePlusSelectSAMSlot;
end;

function TMifareDrv4.MifarePlusAuthSL3Key: Integer;
begin
  Result := DefaultInterface.MifarePlusAuthSL3Key;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TMifareDrv2, TMifareDrv, TMifareDrv4]);
end;

end.
