unit CardReaderEmulator;

interface

uses
  //VLC
  Windows, SysUtils,
  //This
  CardReaderInterface, SerialPortInterface, ComPort, untConst, untError,
  MifareLib_TLB, CardCheckerPort, untUtil, SerialParams, SCardUtil;

type
  { TCardReaderEmulator }

  TCardReaderEmulator = class(TInterfacedObject, ICardReader)
  public
    procedure Lock;
    procedure Unlock;
    function GetRxData: string;
    function GetTxData: string;
    function GetDeviceName: string;
    procedure ShowConnectionProperties(ParentWnd: HWND);
    procedure Mf500InterfaceSetTimeout(Timeout: Word);
    procedure Mf500PcdConfig;
    procedure Mf500PiccHalt;
    procedure OpenPort;
    procedure ClosePort;
    procedure Mf500InterfaceClose;
    procedure Mf500PiccRequest(ReqCode: Byte; var ATQ: Word);
    procedure Mf500PiccAnticoll(BitCount: Byte; var Serial: string);
    procedure Mf500PiccCascAnticoll(SelCode, BitCount: Byte; var Serial: string);
    procedure Mf500PcdSetDefaultAttrib;
    procedure Mf500PiccCascSelect(SelCode: Byte; var Serial: string;
      var SAK: Byte);
    procedure Mf500PiccSelect(var Serial: string; var SAK: Byte);
    procedure Mf500PiccActivateIdle(BaudRate: Byte; var ATQ: word;
      var SAK, uid_len: Byte; var uid: string);
    procedure Mf500PiccActivateWakeup(BaudRate: Byte; var ATQ: word;
      var SAK: Byte; var UID: string; var UIDLength: Byte);
    procedure Mf500PiccAuth(KeyType, KeySector, BlockNumber: Byte);
    procedure Mf500PcdLoadKeyE2(KeyType, KeySector: Byte; KeyValue: string);
    procedure Mf500PiccAuthKey(KeyType: Byte; Serial: string;
      EncodedKey: string; SectorNumber: Byte);
    procedure Mf500PiccCommonRead(cmd, addr, datalen: Byte; var Data: string);
    procedure Mf500PiccRead(addr: Byte; var Data: string);
    procedure Mf500PiccCommonWrite(cmd, addr, datalen: Byte; const Data: string);
    procedure Mf500PiccWrite(addr: Byte; const Data: string);
    procedure Mf500PiccValue(Operation, BlockNumber, TransBlockNumber, Value,
      Address, KeyType, KeyNumber: Integer);
    procedure Mf500PiccValueDebit(dd_mode: Byte; addr: Byte; Value: string);
    procedure Mf500HostCodeKey(const KeyUncoded: string; var KeyCoded: string);
    procedure PcdSetTmo(tmoVal: LongWord);
    procedure PcdGetSnr(var Serial: string);
    function PcdGetFwVersion: string;
    procedure PcdGetRicVersion(var version: string);
    procedure PcdReadE2(startaddr: word; length: Byte; var Data: string);
    procedure PcdWriteE2(startaddr: word; length: Byte; const  Data: string);
    procedure PcdRfReset(ms: word);
    procedure HostTransTmrStart;
    procedure HostTransTmrStop(var ms: LongWord);
    procedure HostGetExecutionTime(var us: LongWord);
    function GetOnlineStatus: Integer;
    procedure WriteRIC(addr, value: Byte);
    procedure ReadRIC(addr: Byte; var value: Byte);
    procedure WriteMultiple(var addr_value: Byte; Len: word);
    procedure ReadMultiple(var addr_value: Byte; Len: word);
    procedure PcdReset;
    procedure PcdBeep(num: Byte);
    // команды MikleSoft
    procedure MksReopen;
    procedure MksReadCatalog(var Catalog: string);
    procedure MksWriteCatalog(const Catalog: string);
    procedure MksFindCard(CardType: Word; var ATQ: Word; var Serial: string);
    procedure SleepMode;
    procedure PcdControlLEDAndPoll(RedLED, GreenLED, BlueLED, YellowLed: Boolean;
      var ButtonState: Boolean);
    procedure PcdControlLED(RedLED, GreenLED, BlueLED, YellowLed: Boolean);
    procedure PcdPollButton(var ButtonState: Boolean);
    function SAM_GetVersion: TSAMVersion;
    procedure SAM_WriteKey(const Data: TSAMKey);
    procedure SAM_AuthKey(const Data: TSAMKeyInfo);
    function SAM_GetKeyEntry(KeyNumber: Integer): TSAMKeyEntry;
    procedure SAM_WriteHostAuthKey(const KeyUncoded: string);
    function ReadFullSerialNumber: string;
    procedure SAM_SetProtection;
    procedure SAM_SetProtectionSN(const SerialNumber: string);
    function IsPortOpened: Boolean;
    procedure WriteConnectionParams(BaudRate: Integer);
    // Ultralight
    procedure UltralightAuth(KeyNumber, KeyVersion: Byte);
    procedure UltralightCompatWrite(Address: Byte; const Data: string);
    function UltralightRead(Address: Byte): string;
    procedure UltralightWrite(Address: Byte; const Data: string);
    procedure UltralightWriteKey(KeyNumber, KeyPosition, KeyVersion: Byte;
      const Data: string);
    // MifarePlus
    procedure MifarePlusCommitPerso;
    procedure MifarePlusWriteParameters(ReceiveDivisor, SendDivisor: Byte);
    procedure MifarePlusWritePerso(BlockNumber: Integer;
      const BlockData: string);
    procedure MifarePlusAuthSL1(const P: TMifarePlusAuth);
    procedure MifarePlusAuthSL2(const P: TMifarePlusAuth);
    procedure MifarePlusAuthSL3(const P: TMifarePlusAuth; var Status: Integer);
    procedure MifarePlusAuthSL3Key(const P: TMifarePlusAuthKey; var Status: Integer);
    procedure MifarePlusDecrement(const P: TMifarePlusDecrement);
    procedure MifarePlusDecrementTransfer(const P: TMifarePlusDecrement);
    procedure MifarePlusIncrement(const P: TMifarePlusIncrement);
    procedure MifarePlusIncrementTransfer(const P: TMifarePlusIncrement);
    function MifarePlusMultiblockRead(const P: TMifarePlusMultiblockRead): string;
    procedure MifarePlusMultiblockWrite(const P: TMifarePlusMultiblockWrite);
    function MifarePlusRead(const P: TMifarePlusReadValue): string;
    procedure MifarePlusWrite(const P: TMifarePlusWrite);
    function MifarePlusReadValue(const P: TMifarePlusReadValue): Integer;
    procedure MifarePlusResetAuthentication;
    procedure MifarePlusRestore(const P: TMifarePlusRestore);
    procedure MifarePlusTransfer(const P: TMifarePlusTransfer);
    procedure MifarePlusWriteValue(const P: TMifarePlusWriteValue);
    procedure EnableCardAccept;
    procedure DisableCardAccept;
    procedure ReadStatus;
    procedure IssueCard;
    procedure HoldCard;
    function ReadLastAnswer: string;
    function GetCardType: Integer;
    function GetCardName: string;
    procedure SAMAV2WriteKey(const P: TSAMAV2Key);
    function MifarePlusMultiblockReadSL2(const P: TMifarePlusMultiblockReadSL2): string;
    procedure MifarePlusMultiblockWriteSL2(const P: TMifarePlusMultiblockWriteSL2);
    procedure MifarePlusAuthSL2Crypto1(const P: TMifarePlusAuthSL2Crypto1);
    procedure WriteEncryptedData(const P: TWriteEncryptedDataRec);
    procedure MifarePlusSelectSAMSlot(const P: TSelectSAM; var R: TSelectSAMAnswer);


    property RxData: string read GetRxData;
    property TxData: string read GetTxData;
  end;

implementation

{ TCardReaderEmulator }

function TCardReaderEmulator.GetOnlineStatus: Integer;
begin
  Result := 0;
end;

function TCardReaderEmulator.GetRxData: string;
begin
  Result := '';
end;

function TCardReaderEmulator.GetTxData: string;
begin
  Result := '';
end;

procedure TCardReaderEmulator.HostGetExecutionTime(var us: LongWord);
begin

end;

procedure TCardReaderEmulator.HostTransTmrStart;
begin

end;

procedure TCardReaderEmulator.HostTransTmrStop(var ms: LongWord);
begin

end;

procedure TCardReaderEmulator.Lock;
begin

end;

procedure TCardReaderEmulator.Mf500HostCodeKey(const KeyUncoded: string;
  var KeyCoded: string);
begin

end;

procedure TCardReaderEmulator.Mf500InterfaceClose;
begin

end;

procedure TCardReaderEmulator.OpenPort;
begin

end;

procedure TCardReaderEmulator.ClosePort;
begin

end;

procedure TCardReaderEmulator.Mf500InterfaceSetTimeout(Timeout: Word);
begin

end;

procedure TCardReaderEmulator.Mf500PcdConfig;
begin

end;

procedure TCardReaderEmulator.Mf500PcdLoadKeyE2(KeyType, KeySector: Byte;
  KeyValue: string);
begin

end;

procedure TCardReaderEmulator.Mf500PcdSetDefaultAttrib;
begin

end;

procedure TCardReaderEmulator.Mf500PiccActivateIdle(BaudRate: Byte;
  var ATQ: word; var SAK, uid_len: Byte; var uid: string);
begin

end;

procedure TCardReaderEmulator.Mf500PiccActivateWakeup(BaudRate: Byte;
  var ATQ: word; var SAK: Byte; var UID: string; var UIDLength: Byte);
begin

end;

procedure TCardReaderEmulator.Mf500PiccAnticoll(BitCount: Byte;
  var Serial: string);
begin

end;

procedure TCardReaderEmulator.Mf500PiccAuth(KeyType, KeySector,
  BlockNumber: Byte);
begin

end;

procedure TCardReaderEmulator.Mf500PiccAuthKey(KeyType: Byte; Serial,
  EncodedKey: string; SectorNumber: Byte);
begin

end;

procedure TCardReaderEmulator.Mf500PiccCascAnticoll(SelCode,
  BitCount: Byte; var Serial: string);
begin

end;

procedure TCardReaderEmulator.Mf500PiccCascSelect(SelCode: Byte;
  var Serial: string; var SAK: Byte);
begin

end;

procedure TCardReaderEmulator.Mf500PiccCommonRead(cmd, addr, datalen: Byte;
  var Data: string);
begin

end;

procedure TCardReaderEmulator.Mf500PiccCommonWrite(cmd, addr,
  datalen: Byte; const Data: string);
begin

end;

procedure TCardReaderEmulator.Mf500PiccHalt;
begin

end;

procedure TCardReaderEmulator.Mf500PiccRead(addr: Byte; var Data: string);
begin

end;

procedure TCardReaderEmulator.Mf500PiccRequest(ReqCode: Byte;
  var ATQ: Word);
begin

end;

procedure TCardReaderEmulator.Mf500PiccSelect(var Serial: string;
  var SAK: Byte);
begin

end;

procedure TCardReaderEmulator.Mf500PiccValue(Operation, BlockNumber,
  TransBlockNumber, Value, Address, KeyType, KeyNumber: Integer);
begin

end;

procedure TCardReaderEmulator.Mf500PiccValueDebit(dd_mode, addr: Byte;
  Value: string);
begin

end;

procedure TCardReaderEmulator.Mf500PiccWrite(addr: Byte;
  const Data: string);
begin

end;

procedure TCardReaderEmulator.MksFindCard(CardType: Word; var ATQ: Word;
  var Serial: string);
begin

end;

procedure TCardReaderEmulator.MksReadCatalog(var Catalog: string);
begin

end;

procedure TCardReaderEmulator.MksReopen;
begin

end;

procedure TCardReaderEmulator.MksWriteCatalog(const Catalog: string);
begin

end;

procedure TCardReaderEmulator.PcdBeep(num: Byte);
begin

end;

procedure TCardReaderEmulator.PcdControlLED(RedLED, GreenLED,
  BlueLED, YellowLed: Boolean);
begin

end;

procedure TCardReaderEmulator.PcdControlLEDAndPoll(RedLED, GreenLED,
  BlueLED, YellowLed: Boolean; var ButtonState: Boolean);
begin

end;

function TCardReaderEmulator.PcdGetFwVersion: string;
begin

end;

procedure TCardReaderEmulator.PcdGetRicVersion(var version: string);
begin

end;

procedure TCardReaderEmulator.PcdGetSnr(var Serial: string);
begin

end;

procedure TCardReaderEmulator.PcdPollButton(var ButtonState: Boolean);
begin

end;

procedure TCardReaderEmulator.PcdReadE2(startaddr: word; length: Byte;
  var Data: string);
begin

end;

procedure TCardReaderEmulator.PcdReset;
begin

end;

procedure TCardReaderEmulator.PcdRfReset(ms: word);
begin

end;

procedure TCardReaderEmulator.PcdSetTmo(tmoVal: LongWord);
begin

end;

procedure TCardReaderEmulator.PcdWriteE2(startaddr: word; length: Byte;
  const Data: string);
begin

end;

procedure TCardReaderEmulator.ReadMultiple(var addr_value: Byte;
  Len: word);
begin

end;

procedure TCardReaderEmulator.ReadRIC(addr: Byte; var value: Byte);
begin

end;

procedure TCardReaderEmulator.ShowConnectionProperties(ParentWnd: HWND);
begin

end;

procedure TCardReaderEmulator.SleepMode;
begin

end;

procedure TCardReaderEmulator.Unlock;
begin

end;

procedure TCardReaderEmulator.WriteMultiple(var addr_value: Byte;
  Len: word);
begin

end;

procedure TCardReaderEmulator.WriteRIC(addr, value: Byte);
begin

end;

function TCardReaderEmulator.GetDeviceName: string;
begin

end;

function TCardReaderEmulator.SAM_GetVersion: TSAMVersion;
begin

end;

procedure TCardReaderEmulator.SAM_WriteKey(const Data: TSAMKey);
begin

end;

procedure TCardReaderEmulator.SAM_AuthKey(const Data: TSAMKeyInfo);
begin

end;

function TCardReaderEmulator.SAM_GetKeyEntry(
  KeyNumber: Integer): TSAMKeyEntry;
begin

end;

procedure TCardReaderEmulator.SAM_WriteHostAuthKey(const KeyUncoded: string);
begin

end;

function TCardReaderEmulator.ReadFullSerialNumber: string;
begin

end;

procedure TCardReaderEmulator.SAM_SetProtection;
begin

end;

procedure TCardReaderEmulator.SAM_SetProtectionSN(
  const SerialNumber: string);
begin

end;

function TCardReaderEmulator.IsPortOpened: Boolean;
begin
  Result := True;
end;

procedure TCardReaderEmulator.WriteConnectionParams(BaudRate: Integer);
begin

end;

procedure TCardReaderEmulator.UltralightAuth(KeyNumber, KeyVersion: Byte);
begin

end;

procedure TCardReaderEmulator.UltralightCompatWrite(Address: Byte;
  const Data: string);
begin

end;

function TCardReaderEmulator.UltralightRead(Address: Byte): string;
begin

end;

procedure TCardReaderEmulator.UltralightWrite(Address: Byte;
  const Data: string);
begin

end;

procedure TCardReaderEmulator.UltralightWriteKey(KeyNumber, KeyPosition,
  KeyVersion: Byte; const Data: string);
begin

end;

procedure TCardReaderEmulator.MifarePlusCommitPerso;
begin

end;

procedure TCardReaderEmulator.MifarePlusWriteParameters(ReceiveDivisor,
  SendDivisor: Byte);
begin

end;

procedure TCardReaderEmulator.MifarePlusWritePerso(BlockNumber: Integer;
  const BlockData: string);
begin

end;

function TCardReaderEmulator.MifarePlusReadValue(
  const P: TMifarePlusReadValue): Integer;
begin
  Result := 0;
end;

procedure TCardReaderEmulator.MifarePlusResetAuthentication;
begin

end;

procedure TCardReaderEmulator.DisableCardAccept;
begin

end;

procedure TCardReaderEmulator.EnableCardAccept;
begin

end;

procedure TCardReaderEmulator.HoldCard;
begin

end;

procedure TCardReaderEmulator.IssueCard;
begin

end;

function TCardReaderEmulator.ReadLastAnswer: string;
begin
  Result := '';
end;

procedure TCardReaderEmulator.ReadStatus;
begin

end;

procedure TCardReaderEmulator.MifarePlusAuthSL1(const P: TMifarePlusAuth);
begin

end;

procedure TCardReaderEmulator.MifarePlusAuthSL2(const P: TMifarePlusAuth);
begin

end;

procedure TCardReaderEmulator.MifarePlusAuthSL3(const P: TMifarePlusAuth;
  var Status: Integer);
begin

end;

procedure TCardReaderEmulator.SAMAV2WriteKey(const P: TSAMAV2Key);
begin

end;

procedure TCardReaderEmulator.MifarePlusWriteValue(
  const P: TMifarePlusWriteValue);
begin

end;

procedure TCardReaderEmulator.MifarePlusIncrement(
  const P: TMifarePlusIncrement);
begin

end;

procedure TCardReaderEmulator.MifarePlusDecrement(
  const P: TMifarePlusDecrement);
begin

end;

procedure TCardReaderEmulator.MifarePlusRestore(
  const P: TMifarePlusRestore);
begin

end;

procedure TCardReaderEmulator.MifarePlusTransfer(
  const P: TMifarePlusTransfer);
begin

end;

procedure TCardReaderEmulator.MifarePlusIncrementTransfer(
  const P: TMifarePlusIncrement);
begin

end;

procedure TCardReaderEmulator.MifarePlusDecrementTransfer(
  const P: TMifarePlusDecrement);
begin

end;

function TCardReaderEmulator.MifarePlusRead(
  const P: TMifarePlusReadValue): string;
begin

end;

procedure TCardReaderEmulator.MifarePlusWrite(const P: TMifarePlusWrite);
begin

end;

function TCardReaderEmulator.MifarePlusMultiblockRead(
  const P: TMifarePlusMultiblockRead): string;
begin

end;

procedure TCardReaderEmulator.MifarePlusMultiblockWrite(
  const P: TMifarePlusMultiblockWrite);
begin

end;

function TCardReaderEmulator.MifarePlusMultiblockReadSL2(
  const P: TMifarePlusMultiblockReadSL2): string;
begin
  Result := '';
end;

procedure TCardReaderEmulator.MifarePlusMultiblockWriteSL2(
  const P: TMifarePlusMultiblockWriteSL2);
begin

end;

procedure TCardReaderEmulator.MifarePlusAuthSL2Crypto1(
  const P: TMifarePlusAuthSL2Crypto1);
begin

end;

procedure TCardReaderEmulator.WriteEncryptedData(
  const P: TWriteEncryptedDataRec);
begin

end;

function TCardReaderEmulator.GetCardType: Integer;
begin
  Result := UNKNOWNCARD;
end;

function TCardReaderEmulator.GetCardName: string;
begin
  Result := 'Неизвестная карта';
end;

procedure TCardReaderEmulator.MifarePlusSelectSAMSlot(const P: TSelectSAM;
  var R: TSelectSAMAnswer);
begin

end;

procedure TCardReaderEmulator.MifarePlusAuthSL3Key(
  const P: TMifarePlusAuthKey; var Status: Integer);
begin

end;

end.
