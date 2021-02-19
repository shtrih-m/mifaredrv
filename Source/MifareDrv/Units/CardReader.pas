unit CardReader;

interface

uses
  //VLC
  Windows, SysUtils,
  //This
  SerialPort, ComPort, untConst, untError, MifareLib_TLB, CardCheckerPort,
  untUtil, SerialParams;

type
  { TCardReader }

  TCardReader = class
  protected
    FRxData: string;
    FTxData: string;
    FParity: Integer;
    FTimeout: Integer;
    FBaudRate: TBaudRate;
    FPortNumber: Integer;
    FPortBaudRate: Integer;
    FReaderName: string;
  public
    procedure ShowConnectionProperties(ParentWnd: HWND); virtual; abstract;
    procedure Mf500InterfaceSetTimeout(Timeout: Word); virtual; abstract;
    procedure Mf500PcdConfig; virtual; abstract;
    procedure Mf500PiccHalt; virtual; abstract;
    procedure Mf500InterfaceOpen(Mode: LongWord; PortNumber: LongWord); virtual; abstract;
    procedure Mf500InterfaceClose; virtual; abstract;
    procedure Mf500PiccRequest(ReqCode: Byte; var ATQ: Word); virtual; abstract;
    procedure Mf500PiccAnticoll(BitCount: Byte; var Serial: string); virtual; abstract;
    procedure Mf500PiccCascAnticoll(SelCode, BitCount: Byte; var Serial: string); virtual; abstract;
    procedure Mf500PcdSetDefaultAttrib; virtual; abstract;
    procedure Mf500PiccCascSelect(SelCode: Byte; var Serial: string; var SAK: Byte); virtual; abstract;
    procedure Mf500PiccSelect(var Serial: string; var SAK: Byte); virtual; abstract;
    procedure Mf500PiccActivateIdle(BaudRate: Byte; var ATQ: word;  var SAK, uid_len: Byte; var uid: string); virtual; abstract;
    procedure Mf500PiccActivateWakeup(BaudRate: Byte; var ATQ: word; var SAK: Byte; var UID: string; var UIDLength: Byte); virtual; abstract;
    procedure Mf500PiccAuth(KeyType, KeySector, BlockNumber: Byte); virtual; abstract;
    //procedure Mf500PiccAuthE2(KeyType: Byte; Serial: string; KeySector, BlockNumber: Byte); virtual; abstract;
    procedure Mf500PcdLoadKeyE2(KeyType, KeySector: Byte; KeyValue: string); virtual; abstract;
    procedure Mf500PiccAuthKey(KeyType: Byte; Serial: string; EncodedKey: string; SectorNumber: Byte); virtual; abstract;
    procedure Mf500PiccCommonRead(cmd, addr, datalen: Byte; var Data: string); virtual; abstract;
    procedure Mf500PiccRead(addr: Byte; var Data: string); virtual; abstract;
    procedure Mf500PiccCommonWrite(cmd, addr, datalen: Byte; const Data: string); virtual; abstract;
    procedure Mf500PiccWrite(addr: Byte; const Data: string); virtual; abstract;
    procedure Mf500PiccValue(dd_mode: Byte; addr: Byte; Value: string; trans_addr: Byte); virtual; abstract;
    procedure Mf500PiccValueDebit(dd_mode: Byte; addr: Byte; Value: string); virtual; abstract;
    procedure Mf500HostCodeKey(const KeyUncoded: string; var KeyCoded: string); virtual; abstract;
    procedure PcdSetTmo(tmoVal: LongWord); virtual; abstract;
    procedure PcdGetSnr(var Serial: string); virtual; abstract;
    procedure PcdGetFwVersion(var Version: string); virtual; abstract;
    procedure PcdGetRicVersion(var version: string); virtual; abstract;
    procedure PcdReadE2(startaddr: word; length: Byte; var Data: string); virtual; abstract;
    procedure PcdWriteE2(startaddr: word; length: Byte; const  Data: string); virtual; abstract;
    procedure PcdRfReset(ms: word); virtual; abstract;
    procedure HostTransTmrStart; virtual; abstract;
    procedure HostTransTmrStop(var ms: LongWord); virtual; abstract;
    procedure HostGetExecutionTime(var us: LongWord); virtual; abstract;
    function GetOnlineStatus: Integer; virtual; abstract;
    procedure WriteRIC(addr, value: Byte); virtual; abstract;
    procedure ReadRIC(addr: Byte; var value: Byte); virtual; abstract;
    procedure WriteMultiple(var addr_value: Byte; Len: word); virtual; abstract;
    procedure ReadMultiple(var addr_value: Byte; Len: word); virtual; abstract;
    procedure PcdReset; virtual; abstract;
    procedure PcdBeep(num: Byte); virtual; abstract;
    // команды MikleSoft
    procedure MksReopen; virtual; abstract;
    procedure MksReadCatalog(var Catalog: string); virtual; abstract;
    procedure MksWriteCatalog(const Catalog: string); virtual; abstract;
    procedure MksFindCard(CardType: Word; var ATQ: Word; var Serial: string); virtual; abstract;
    procedure SleepMode; virtual; abstract;
    procedure PcdControlLEDAndPoll(RedLED, GreenLED, BlueLED: Boolean; var ButtonState: Boolean); virtual; abstract;

    property RxData: string read FRxData;
    property TxData: string read FTxData;
    property Parity: Integer read FParity write FParity;
    property Timeout: Integer read FTimeout write FTimeout;
    property BaudRate: TBaudRate read FBaudRate write FBaudRate;
    property ReaderName: string read FReaderName write FReaderName;
    property PortNumber: Integer read FPortNumber write FPortNumber;
    property PortBaudRate: Integer read FPortBaudRate write FPortBaudRate;
  end;

implementation

end.
