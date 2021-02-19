unit OmnikeyCardReader;

interface

uses
  //VLC
  Windows, SysUtils, SyncObjs,
  //This
  CardReaderInterface, untConst, OmnikeyReader, SCardSyn, untUtil,
  SerialParams, MifareLib_TLB, SCardUtil;

type
  { TOmnikeyCardReader }

  TOmnikeyCardReader = class(TInterfacedObject, ICardReader)
  private
    FCS: TCriticalSection;
    FParams: TSerialParams;
    FReader: TOmnikeyReader;

    procedure Connect;
    property Reader: TOmnikeyReader read FReader;
  public
    constructor Create(AParams: TSerialParams);
    destructor Destroy; override;

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
    procedure Mf500PiccCascSelect(SelCode: Byte; var Serial: string; var SAK: Byte);
    procedure Mf500PiccSelect(var Serial: string; var SAK: Byte);
    procedure Mf500PiccActivateIdle(BaudRate: Byte; var ATQ: word;  var SAK, uid_len: Byte; var uid: string);
    procedure Mf500PiccActivateWakeup(BaudRate: Byte; var ATQ: word; var SAK: Byte; var UID: string; var UIDLength: Byte);
    procedure Mf500PiccAuth(KeyType, KeySector, BlockNumber: Byte);
    procedure Mf500PcdLoadKeyE2(KeyType, KeySector: Byte; KeyValue: string);
    procedure Mf500PiccAuthKey(KeyType: Byte; Serial: string; EncodedKey: string; SectorNumber: Byte);
    procedure Mf500PiccCommonRead(cmd, addr, datalen: Byte; var Data: string);
    procedure Mf500PiccRead(addr: Byte; var Data: string);
    procedure Mf500PiccCommonWrite(cmd, addr, datalen: Byte; const Data: string);
    procedure Mf500PiccWrite(addr: Byte; const Data: string);
    procedure Mf500PiccValue(Operation, BlockNumber, TransBlockNumber,
      Value, Address, KeyType, KeyNumber: Integer);
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
    procedure MifarePlusAuthSL3(const P: TMifarePlusAuth);
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
  end;

implementation

{ Кодирование ключа 6 байт в 12 }

function EncodeKey(const Data: string): string;
var
  i: Integer;
  ln, hn: Byte;
begin
  Result := '';
  for i := 1 to Length(Data) do
  begin
    ln := Ord(Data[i]) and $0F;
    hn := Ord(Data[i]) shr 4;
    Result := Result + Chr(((not hn) shl 4) or hn);
    Result := Result + Chr(((not ln) shl 4) or ln);
  end;
end;

function DecodeKey(const Data: string): string;
var
  i: Integer;
  ln, hn: Byte;
  Count: Integer;
begin
  Result := '';
  Count := Length(Data) div 2;
  for i := 1 to Count do
  begin
    hn := Ord(Data[i*2-1]) and $0F;
    ln := (Ord(Data[i*2]) and $0F);
    Result := Result + Chr(ln + (hn shl 4));
  end;
end;

function CardTypeToATQ(Value: Integer): Integer;
begin
  case Value of
    Mifare_Standard_1K: Result := $0004;
    Mifare_Standard_4K: Result := $0002;
    Mifare_Ultra_light: Result := $0044;
  else
    Result := 0;
  end;
end;

function CardTypeToSAK(Value: Integer): Integer;
begin
  case Value of
    Mifare_Standard_1K: Result := $08;
    Mifare_Standard_4K: Result := $18;
    Mifare_Ultra_light: Result := $00;
  else
    Result := 00;
  end;
end;

{ TOmnikeyCardReader }

constructor TOmnikeyCardReader.Create(AParams: TSerialParams);
begin
  inherited Create;
  FCS := TCriticalSection.Create;
  FReader := TOmnikeyReader.Create;
  FReader.ReaderName := AParams.ReaderName;
  FParams := AParams;
end;

destructor TOmnikeyCardReader.Destroy;
begin
  FCS.Free;
  FReader.Free;
  inherited Destroy;
end;

function TOmnikeyCardReader.GetCardType: Integer;
begin
  Result := Reader.CardType;
end;

function TOmnikeyCardReader.GetCardName: string;
begin
  Result := Reader.CardName;
end;

procedure TOmnikeyCardReader.Lock;
begin
  FCS.Enter;
end;

procedure TOmnikeyCardReader.Unlock;
begin
  FCS.Leave;
end;

procedure TOmnikeyCardReader.Connect;
begin
  Lock;
  try
    Reader.Connect;
    Reader.GetStatus;
  finally
    Unlock;
  end;
end;

function TOmnikeyCardReader.GetOnlineStatus: Integer;
begin
  Result := MI_OK;
end;

procedure TOmnikeyCardReader.HostGetExecutionTime(var us: LongWord);
begin

end;

procedure TOmnikeyCardReader.HostTransTmrStart;
begin

end;

procedure TOmnikeyCardReader.HostTransTmrStop(var ms: LongWord);
begin

end;

procedure TOmnikeyCardReader.Mf500HostCodeKey(const KeyUncoded: string;
  var KeyCoded: string);
begin
  KeyCoded := EncodeKey(KeyUncoded);
end;

procedure TOmnikeyCardReader.Mf500InterfaceClose;
begin
  Lock;
  try
    Reader.Disconnect;
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.OpenPort;
begin
  Connect;
end;

procedure TOmnikeyCardReader.ClosePort;
begin
  Reader.Disconnect;
end;

procedure TOmnikeyCardReader.Mf500InterfaceSetTimeout(Timeout: Word);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.Mf500PcdConfig;
begin
  { !!! }
end;

procedure TOmnikeyCardReader.Mf500PcdLoadKeyE2(KeyType, KeySector: Byte;
  KeyValue: string);
begin
  Lock;
  try
    Connect;
    Reader.WriteKeyToReader(KeySector, KeyValue, False, 0);
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PcdSetDefaultAttrib;
begin


end;

procedure TOmnikeyCardReader.Mf500PiccActivateIdle(BaudRate: Byte;
  var ATQ: word; var SAK, uid_len: Byte; var uid: string);
begin
  Lock;
  try
    Connect;
    ATQ := CardTypeToATQ(Reader.CardType);
    SAK := CardTypeToSAK(Reader.CardType);
    UID := Reader.ReadUID;
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PiccActivateWakeup(BaudRate: Byte;
  var ATQ: word; var SAK: Byte; var UID: string; var UIDLength: Byte);
begin
  Lock;
  try
    Connect;
    ATQ := CardTypeToATQ(Reader.CardType);
    SAK := CardTypeToSAK(Reader.CardType);
    UID := Reader.ReadUID;
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PiccAnticoll(BitCount: Byte;
  var Serial: string);
begin
  Lock;
  try
    Connect;
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PiccAuth(KeyType, KeySector,
  BlockNumber: Byte);
begin
  Lock;
  try
    Connect;
    Reader.Authenticate(BlockNumber, KeyType, KeySector);
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PiccAuthKey(KeyType: Byte; Serial,
  EncodedKey: string; SectorNumber: Byte);
var
  KeyData: string;
begin
  Lock;
  try
    Connect;
    KeyData := DecodeKey(EncodedKey);
    Reader.AuthenticateKey(SectorNumber, KeyType, KeyData);
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PiccCascAnticoll(SelCode, BitCount: Byte;
  var Serial: string);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.Mf500PiccCascSelect(SelCode: Byte;
  var Serial: string; var SAK: Byte);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.Mf500PiccCommonRead(cmd, addr, datalen: Byte;
  var Data: string);
begin
  Lock;
  try
    Data := Reader.ReadBinary(Addr);
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PiccCommonWrite(cmd, addr, datalen: Byte;
  const Data: string);
begin
  Lock;
  try
    Reader.WriteBinary(Addr, Data);
  finally
    Unlock;
  end;
end;

procedure TOmnikeyCardReader.Mf500PiccHalt;
begin

end;

procedure TOmnikeyCardReader.Mf500PiccRead(addr: Byte; var Data: string);
begin
  Data := Reader.ReadBinary(Addr);
end;

procedure TOmnikeyCardReader.Mf500PiccRequest(ReqCode: Byte;
  var ATQ: Word);
begin
  Connect;
  ATQ := CardTypeToATQ(Reader.CardType);
end;

procedure TOmnikeyCardReader.Mf500PiccSelect(var Serial: string;
  var SAK: Byte);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.Mf500PiccValue(Operation, BlockNumber,
  TransBlockNumber, Value, Address, KeyType, KeyNumber: Integer);
begin
  case Operation of
    PICC_INCREMENT: Reader.MifareIncrement(BlockNumber, Value);
    PICC_DECREMENT: Reader.MifareDecrement(BlockNumber, Value);
    PICC_RESTORE  : Reader.MifareRestore(BlockNumber, TransBlockNumber, Value, Address, KeyType, KeyNumber);
    PICC_TRANSFER : Reader.MifareTransfer(BlockNumber, TransBlockNumber, Value, Address);
  else
    raise Exception.Create('Not supported');
  end;
end;


procedure TOmnikeyCardReader.Mf500PiccValueDebit(dd_mode, addr: Byte;
  Value: string);
begin


end;

procedure TOmnikeyCardReader.Mf500PiccWrite(addr: Byte;
  const Data: string);
begin
  Reader.WriteBinary(Addr, Data);
end;

procedure TOmnikeyCardReader.MksFindCard(CardType: Word; var ATQ: Word;
  var Serial: string);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.MksReadCatalog(var Catalog: string);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.MksReopen;
begin
  { !!! }
end;

procedure TOmnikeyCardReader.MksWriteCatalog(const Catalog: string);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdBeep(num: Byte);
begin
  { !!! }
end;

function TOmnikeyCardReader.PcdGetFwVersion: string;
begin
  Connect;
  Result := Reader.GetFirmwareVersion;
end;

procedure TOmnikeyCardReader.PcdGetRicVersion(var version: string);
begin
  Connect;
  Version := Reader.GetFirmwareVersion;
end;

procedure TOmnikeyCardReader.PcdGetSnr(var Serial: string);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdReadE2(startaddr: word; length: Byte;
  var Data: string);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdReset;
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdRfReset(ms: word);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdSetTmo(tmoVal: LongWord);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdWriteE2(startaddr: word; length: Byte;
  const Data: string);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.ReadMultiple(var addr_value: Byte; Len: word);
begin

end;

procedure TOmnikeyCardReader.ReadRIC(addr: Byte; var value: Byte);
begin


end;

procedure TOmnikeyCardReader.ShowConnectionProperties(ParentWnd: HWND);
begin


end;

procedure TOmnikeyCardReader.SleepMode;
begin


end;

procedure TOmnikeyCardReader.WriteMultiple(var addr_value: Byte;
  Len: word);
begin


end;

procedure TOmnikeyCardReader.WriteRIC(addr, value: Byte);
begin

end;

procedure TOmnikeyCardReader.PcdControlLEDAndPoll(RedLED, GreenLED,
  BlueLED, YellowLed: Boolean; var ButtonState: Boolean);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdControlLED(RedLED, GreenLED,
  BlueLED, YellowLed: Boolean);
begin
  { !!! }
end;

procedure TOmnikeyCardReader.PcdPollButton(var ButtonState: Boolean);
begin
{ !!! }
end;

function TOmnikeyCardReader.GetRxData: string;
begin
  Result := '';
end;

function TOmnikeyCardReader.GetTxData: string;
begin
  Result := '';
end;

function TOmnikeyCardReader.GetDeviceName: string;
begin
  Result := FReader.ReaderName;
end;

function TOmnikeyCardReader.SAM_GetVersion: TSAMVersion;
begin

end;

procedure TOmnikeyCardReader.SAM_WriteKey(const Data: TSAMKey);
begin

end;

procedure TOmnikeyCardReader.SAM_AuthKey(const Data: TSAMKeyInfo);
begin

end;

function TOmnikeyCardReader.SAM_GetKeyEntry(
  KeyNumber: Integer): TSAMKeyEntry;
begin

end;

procedure TOmnikeyCardReader.SAM_WriteHostAuthKey(
  const KeyUncoded: string);
begin

end;

function TOmnikeyCardReader.ReadFullSerialNumber: string;
begin

end;

procedure TOmnikeyCardReader.SAM_SetProtection;
begin

end;

procedure TOmnikeyCardReader.SAM_SetProtectionSN(
  const SerialNumber: string);
begin

end;

function TOmnikeyCardReader.IsPortOpened: Boolean;
begin
  Result := Reader.Connected;
end;

procedure TOmnikeyCardReader.WriteConnectionParams(BaudRate: Integer);
begin

end;

procedure TOmnikeyCardReader.UltralightAuth(KeyNumber,
  KeyVersion: Byte);
begin

end;

procedure TOmnikeyCardReader.UltralightCompatWrite(Address: Byte;
  const Data: string);
begin

end;

function TOmnikeyCardReader.UltralightRead(Address: Byte): string;
begin

end;

procedure TOmnikeyCardReader.UltralightWrite(Address: Byte;
  const Data: string);
begin

end;

procedure TOmnikeyCardReader.UltralightWriteKey(KeyNumber, KeyPosition,
  KeyVersion: Byte; const Data: string);
begin

end;

procedure TOmnikeyCardReader.MifarePlusCommitPerso;
begin

end;

procedure TOmnikeyCardReader.MifarePlusWriteParameters(ReceiveDivisor,
  SendDivisor: Byte);
begin

end;

procedure TOmnikeyCardReader.MifarePlusWritePerso(BlockNumber: Integer;
  const BlockData: string);
begin

end;

function TOmnikeyCardReader.MifarePlusReadValue(
  const P: TMifarePlusReadValue): Integer;
begin
  Result := 0;
end;

procedure TOmnikeyCardReader.MifarePlusResetAuthentication;
begin

end;

procedure TOmnikeyCardReader.DisableCardAccept;
begin

end;

procedure TOmnikeyCardReader.EnableCardAccept;
begin

end;

procedure TOmnikeyCardReader.HoldCard;
begin

end;

procedure TOmnikeyCardReader.IssueCard;
begin

end;

procedure TOmnikeyCardReader.ReadStatus;
begin

end;

function TOmnikeyCardReader.ReadLastAnswer: string;
begin

end;

procedure TOmnikeyCardReader.MifarePlusAuthSL1(const P: TMifarePlusAuth);
begin

end;

procedure TOmnikeyCardReader.MifarePlusAuthSL2(const P: TMifarePlusAuth);
begin

end;

procedure TOmnikeyCardReader.MifarePlusAuthSL3(const P: TMifarePlusAuth);
begin

end;

procedure TOmnikeyCardReader.SAMAV2WriteKey(const P: TSAMAV2Key);
begin

end;

procedure TOmnikeyCardReader.MifarePlusWriteValue(
  const P: TMifarePlusWriteValue);
begin

end;

procedure TOmnikeyCardReader.MifarePlusIncrement(
  const P: TMifarePlusIncrement);
begin

end;

procedure TOmnikeyCardReader.MifarePlusDecrement(
  const P: TMifarePlusDecrement);
begin

end;

procedure TOmnikeyCardReader.MifarePlusRestore(
  const P: TMifarePlusRestore);
begin

end;

procedure TOmnikeyCardReader.MifarePlusTransfer(
  const P: TMifarePlusTransfer);
begin

end;

procedure TOmnikeyCardReader.MifarePlusIncrementTransfer(
  const P: TMifarePlusIncrement);
begin

end;

procedure TOmnikeyCardReader.MifarePlusDecrementTransfer(
  const P: TMifarePlusDecrement);
begin

end;

function TOmnikeyCardReader.MifarePlusRead(
  const P: TMifarePlusReadValue): string;
begin

end;

procedure TOmnikeyCardReader.MifarePlusWrite(const P: TMifarePlusWrite);
begin

end;

function TOmnikeyCardReader.MifarePlusMultiblockRead(
  const P: TMifarePlusMultiblockRead): string;
begin

end;

procedure TOmnikeyCardReader.MifarePlusMultiblockWrite(
  const P: TMifarePlusMultiblockWrite);
begin

end;

function TOmnikeyCardReader.MifarePlusMultiblockReadSL2(
  const P: TMifarePlusMultiblockReadSL2): string;
begin
  Result := '';
end;

procedure TOmnikeyCardReader.MifarePlusMultiblockWriteSL2(
  const P: TMifarePlusMultiblockWriteSL2);
begin

end;

procedure TOmnikeyCardReader.MifarePlusAuthSL2Crypto1(
  const P: TMifarePlusAuthSL2Crypto1);
begin

end;

procedure TOmnikeyCardReader.WriteEncryptedData(
  const P: TWriteEncryptedDataRec);
begin

end;

end.
