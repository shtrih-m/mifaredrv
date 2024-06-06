unit MFRC500Reader;

interface

uses
  //VLC
  Windows, SysUtils, SyncObjs,
  //This
  CardReaderInterface, SerialPortInterface, ComPort, untConst, untError,
  MifareLib_TLB, CardCheckerPort, untUtil, SerialParams;

type
  { TMFRC500Reader }

  TMFRC500Reader = class(TInterfacedObject, ICardReader)
  private
    FPort: ISerialPort;
    FCardName: string;
    FCardType: Integer;
    FCS: TCriticalSection;
    FParams: TSerialParams;

    function GetPort: ISerialPort;
    property Port: ISerialPort read GetPort;
    function SendCommand(const Data: string): string;
    function DoSendCommand(const TxData: string;
      var RxData: string): Integer;
    procedure Check(Code: Integer);
    function DoMf500PiccActivateWakeup(BaudRate: Byte; var ATQ: word;
      var SAK: Byte; var UID: string; var UIDLength: Byte): Integer;
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
    //procedure Mf500PiccAuthE2(KeyType: Byte; Serial: string; KeySector, BlockNumber: Byte);
    procedure Mf500PcdLoadKeyE2(KeyType, KeySector: Byte; KeyValue: string);
    procedure Mf500PiccAuthKey(KeyType: Byte; Serial: string; EncodedKey: string; SectorNumber: Byte);
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
    // ������� MikleSoft
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
    function MifarePlusMultiblockReadSL2(const P: TMifarePlusMultiblockReadSL2): string;
    procedure MifarePlusMultiblockWriteSL2(const P: TMifarePlusMultiblockWriteSL2);
    function MifarePlusRead(const P: TMifarePlusReadValue): string;
    procedure MifarePlusWrite(const P: TMifarePlusWrite);
    function MifarePlusReadValue(const P: TMifarePlusReadValue): Integer;
    procedure MifarePlusResetAuthentication;
    procedure MifarePlusRestore(const P: TMifarePlusRestore);
    procedure MifarePlusTransfer(const P: TMifarePlusTransfer);
    procedure MifarePlusWriteValue(const P: TMifarePlusWriteValue);
    procedure MifarePlusAuthSL2Crypto1(const P: TMifarePlusAuthSL2Crypto1);
    procedure MifarePlusSelectSAMSlot(const P: TSelectSAM;
      var R: TSelectSAMAnswer);

    procedure EnableCardAccept;
    procedure DisableCardAccept;
    procedure ReadStatus;
    procedure IssueCard;
    procedure HoldCard;
    function ReadLastAnswer: string;
    function GetCardType: Integer;
    function GetCardName: string;
    procedure SAMAV2WriteKey(const P: TSAMAV2Key);
    procedure WriteEncryptedData(const P: TWriteEncryptedDataRec);
  end;

const
  STX = #$02;

  /////////////////////////////////////////////////////////////////////////////
  // KeyType constants

  PH_KEYSTORE_KEY_TYPE_AES128  = $00; // AES 128 Key [16]
  PH_KEYSTORE_KEY_TYPE_AES192  = $01; // AES 192 Key [24]
  PH_KEYSTORE_KEY_TYPE_AES256  = $02; // AES 256 Key [32]
  PH_KEYSTORE_KEY_TYPE_DES     = $03; // DES Single Key
  PH_KEYSTORE_KEY_TYPE_2K3DES  = $04; // 2 Key Triple Des
  PH_KEYSTORE_KEY_TYPE_3K3DES  = $05; // 3 Key Triple Des
  PH_KEYSTORE_KEY_TYPE_MIFARE  = $06; // MIFARE (R) Key

function KeyTypeToStr(KeyType: Integer): string;

implementation

const
  BoolToChar: array[Boolean] of Char = (#0, #1);

function KeyTypeToStr(KeyType: Integer): string;
begin
  case KeyType of
    PH_KEYSTORE_KEY_TYPE_AES128  : Result := 'AES 128 Key [16]';
    PH_KEYSTORE_KEY_TYPE_AES192  : Result := 'AES 192 Key [24]';
    PH_KEYSTORE_KEY_TYPE_AES256  : Result := 'AES 256 Key [32]';
    PH_KEYSTORE_KEY_TYPE_DES     : Result := 'DES Single Key';
    PH_KEYSTORE_KEY_TYPE_2K3DES  : Result := '2 Key Triple Des';
    PH_KEYSTORE_KEY_TYPE_3K3DES  : Result := '3 Key Triple Des';
    PH_KEYSTORE_KEY_TYPE_MIFARE  : Result := 'MIFARE (R) Key';
  else
    Result := 'Unknown key type';
  end;
end;

function GetVendorName(VendorID: Integer): string;
begin
  case VendorID of
    VENDOR_ID_PHILIPS: Result := 'PHILIPS';
  else
    Result := 'Unknown vendor';
  end;
end;

function GetCRC(const Data: string): Byte;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(Data) do
    Result := Result xor Ord(Data[i]);
end;

function EncodeTxData(const Data: string): string;
begin
  Result := Chr(Length(Data)) + Data;
  Result := STX + Result + Chr(GetCRC(Result));
end;

{ Mf500 }

constructor TMFRC500Reader.Create(AParams: TSerialParams);
begin
  inherited Create;
  FCS := TCriticalSection.Create;
  FParams := AParams;
end;

destructor TMFRC500Reader.Destroy;
begin
  FPort := nil;
  FCS.Free;
  inherited Destroy;
end;

procedure TMFRC500Reader.Lock;
begin
  FCS.Enter;
end;

procedure TMFRC500Reader.Unlock;
begin
  FCS.Leave;
end;

function CheckCRC(const Data: string): Boolean;
var
  CRC: Byte;
begin
  CRC := GetCRC(Copy(Data, 1, Length(Data)-1));
  Result := CRC = Ord(Data[Length(Data)]);
end;

function TMFRC500Reader.DoSendCommand(const TxData: string;
  var RxData: string): Integer;
var
  i: Integer;
const
  MaxRepCount = 1;
begin
  Lock;
  try
    Result := 0;
    for i := 0 to MaxRepCount do
    begin
      Port.Open(FParams);
      RxData := Port.SendCommand(EncodeTxData(TxData));
      if CheckCRC(RxData) then
      begin
        CheckMinLength(RxData, 2);
        RxData := Copy(RxData, 2, Length(RxData)-2);
        Result := Abs(ShortInt(RxData[1])) + MIREADER_ERR_BASE_START;
        RxData := Copy(RxData, 2, Length(RxData));
        Exit;
      end;
    end;
    RaiseError(E_INVALID_CS, S_INVALID_CS);
  finally
    Unlock;
  end;
end;

procedure TMFRC500Reader.Check(Code: Integer);
begin
  if Code <> 0 then
    RaiseError(Code, GetResultDescription(Code));
end;

function TMFRC500Reader.SendCommand(const Data: string): string;
begin
  Check(DoSendCommand(Data, Result));
end;

procedure TMFRC500Reader.OpenPort;
begin
  Port.Open(FParams);
end;

procedure TMFRC500Reader.ClosePort;
begin
  Port.Close;
end;

procedure TMFRC500Reader.Mf500InterfaceClose;
begin
  Port.Close;
end;

function TMFRC500Reader.GetOnlineStatus: Integer;
begin
  if Port.Opened then Result := MI_OK
  else Result :=  MI_INTERFACEERR;
end;

procedure TMFRC500Reader.Mf500PcdConfig;
begin
  SendCommand(CMD_PCDCONFIG);
end;

procedure TMFRC500Reader.PcdBeep(num: Byte);
begin
  SendCommand(CMD_PCDBEEP + Chr(num));
  Sleep(50);
end;

procedure TMFRC500Reader.Mf500InterfaceSetTimeout(Timeout: Word);
begin
  //Port.Timeout := Timeout; { !!! }
end;

procedure TMFRC500Reader.Mf500PiccHalt;
begin
  SendCommand(CMD_PICCHALT);
end;

procedure TMFRC500Reader.Mf500PiccRequest(ReqCode: Byte; var ATQ: Word);
var
  S: string;
begin
  S := SendCommand(CMD_REQUEST + Chr(ReqCode));
  CheckMinLength(S, 2);
  ATQ := 256*Ord(S[2]) + Ord(S[1]);
end;

procedure TMFRC500Reader.Mf500PiccCascAnticoll(SelCode, BitCount: Byte; var Serial: string);
begin
  Serial := SendCommand(CMD_ANTICOLL + Chr(SelCode) + Chr(BitCount) + Serial);
  CheckMinLength(Serial, 4);
end;

procedure TMFRC500Reader.Mf500PiccAnticoll(BitCount: Byte; var Serial: string);
begin
  Mf500PiccCascAnticoll($93, BitCount, Serial);
end;

procedure TMFRC500Reader.Mf500PcdSetDefaultAttrib;
begin
  SendCommand(CMD_PCDSETDEFAULTATTRIB);
end;

procedure TMFRC500Reader.Mf500PiccCascSelect(SelCode: Byte; var Serial: string;
  var SAK: Byte);
var
  S: string;
begin
  S := SendCommand(CMD_SELECT + Chr(SelCode) + Serial);
  CheckMinLength(S, 5);
  Serial := Copy(S, 1, 4);
  SAK := Ord(S[5]);
end;

procedure TMFRC500Reader.Mf500PiccSelect(var Serial: string; var SAK: Byte);
begin
  Mf500PiccCascSelect($93, Serial, SAK);
end;

procedure TMFRC500Reader.Mf500PiccActivateIdle(BaudRate: Byte; var ATQ: word;
  var SAK, uid_len: Byte; var uid: string);
var
  S: string;
begin
  S := SendCommand(CMD_ACTIVATEIDLE + Chr(BaudRate) + #0);
  CheckMinLength(S, 4);
  ATQ := 256*Ord(S[2]) + Ord(S[1]);
  SAK := Ord(S[3]);
  uid_len := Ord(S[4]);
  CheckMinLength(S, 4 + uid_len);
  uid := Copy(S, 5, uid_len);

  FCardType := SelectCardType(ATQ, SAK);
  FCardName := CardTypeToCardName(FCardType);
end;

function TMFRC500Reader.DoMf500PiccActivateWakeup(BaudRate: Byte; var ATQ: word;
  var SAK: Byte; var UID: string; var UIDLength: Byte): Integer;
var
  TxData: string;
  RxData: string;
begin
  TxData := CMD_ACTIVATEWAKEUP + Chr(BaudRate) + #0;
  Result := DoSendCommand(TxData, RxData);
  if Result = 0 then
  begin
    CheckMinLength(RxData, 4);
    ATQ := 256*Ord(RxData[2]) + Ord(RxData[1]);
    SAK := Ord(RxData[3]);
    UIDLength := Ord(RxData[4]);
    CheckMinLength(RxData, 4 + UIDLength);
    UID := Copy(RxData, 5, UIDLength);

    FCardType := SelectCardType(ATQ, SAK);
    FCardName := CardTypeToCardName(FCardType);
  end;
end;

procedure TMFRC500Reader.Mf500PiccActivateWakeup(BaudRate: Byte; var ATQ: word;
  var SAK: Byte; var UID: string; var UIDLength: Byte);
var
  ResultCode: Integer;
begin
  ResultCode := DoMf500PiccActivateWakeup(BaudRate, ATQ, SAK, UID, UIDLength);
  if ResultCode <> 0 then
    ResultCode := DoMf500PiccActivateWakeup(BaudRate, ATQ, SAK, UID, UIDLength);

  Check(ResultCode);
end;

procedure TMFRC500Reader.Mf500PiccAuth(KeyType, KeySector,
  BlockNumber: Byte);
begin
  SendCommand(CMD_AUTH + Chr(KeyType) + Chr(KeySector) + Chr(BlockNumber));
end;

(*
procedure TMFRC500Reader.Mf500PiccAuthE2(KeyType: Byte; Serial: string; KeySector,
  BlockNumber: Byte);
begin
  SendCommand(CMD_AUTHE2 + Chr(KeyType) + Chr(KeySector) + Chr(BlockNumber)
    + Serial);
end;
*)

procedure TMFRC500Reader.Mf500PcdLoadKeyE2(KeyType, KeySector: Byte;
  KeyValue: string);
begin
  SendCommand(CMD_LOADE2 + Chr(KeyType) + Chr(KeySector) + KeyValue);
end;

procedure TMFRC500Reader.Mf500PiccAuthKey(KeyType: Byte; Serial, EncodedKey: string;
  SectorNumber: Byte);
begin
  SendCommand(CMD_AUTHKEY + Chr(KeyType) + Chr(SectorNumber) + Serial + EncodedKey);
end;

procedure TMFRC500Reader.Mf500PiccCommonRead(cmd, addr, datalen: Byte; var Data: string);
begin
  Data := SendCommand(CMD_PICCREAD + Chr(cmd) + Chr(addr) + Chr(datalen));
  CheckMinLength(Data, datalen);
end;

procedure TMFRC500Reader.Mf500PiccRead(addr: Byte; var Data: string);
begin
  Mf500PiccCommonRead(PICC_READ16, addr, 16, Data);
end;

procedure TMFRC500Reader.Mf500PiccCommonWrite(cmd, addr, datalen: Byte;
 const Data: string);
begin
  SendCommand(CMD_PICCWRITE + Chr(cmd) + Chr(addr) + Chr(datalen) + Data);
end;

procedure TMFRC500Reader.Mf500PiccWrite(addr: Byte; const Data: string);
begin
  Mf500PiccCommonWrite(PICC_WRITE16, addr, 16, Data);
end;

procedure TMFRC500Reader.Mf500PiccValue(Operation, BlockNumber,
  TransBlockNumber, Value, Address, KeyType, KeyNumber: Integer);
begin
  SendCommand(CMD_PICCVALUE + Chr(Operation) + Chr(BlockNumber) +
    Chr(TransBlockNumber) + IntToBin(Value, 4));
end;

procedure TMFRC500Reader.Mf500PiccValueDebit(dd_mode, addr: Byte; Value: string);
begin
  SendCommand(CMD_PICCVALUEDEBIT + Chr(dd_mode) + Chr(addr) + #0 + Value);
end;

procedure TMFRC500Reader.Mf500HostCodeKey(const KeyUncoded: string; var KeyCoded: string);
var
  i: Integer;
  ln, hn: Byte;
begin
  for i := 1 to 6 do
  begin
    ln := Ord(KeyUncoded[i]) and $0F;
    hn := Ord(KeyUncoded[i]) shr 4;
    KeyCoded[i*2-1] := Chr(((not hn) shl 4) or hn);
    KeyCoded[i*2] := Chr(((not ln) shl 4) or ln);
  end;
end;

procedure TMFRC500Reader.PcdSetTmo(tmoVal: LongWord);
var
  S: string;
begin
  SetLength(S, 5);
  S[1] := CMD_PCDSETTMO;
  Move(tmoVal, S[2], 4);
  SendCommand(S);
end;

procedure TMFRC500Reader.PcdGetSnr(var Serial: string);
begin
  Serial := SendCommand(CMD_PCDGETSNR + #0);
  CheckMinLength(Serial, 4);
end;

function TMFRC500Reader.PcdGetFwVersion: string;
begin
  Result := TrimRight(PChar(SendCommand(CMD_PCDGETFWVERSION + #0)));
end;

procedure TMFRC500Reader.PcdGetRicVersion(var Version: string);
begin
  Version := SendCommand(CMD_PCDGETRICVERSION + #0);
end;

procedure TMFRC500Reader.PcdReadE2(startaddr: word; length: Byte; var Data: string);
begin
  Data := SendCommand(CMD_PCDREADE2 + Chr(startaddr and $FF) +
    Chr(startaddr shr 8) + Chr(length));
  CheckMinLength(Data, length);
end;

procedure TMFRC500Reader.PcdWriteE2(startaddr: word; length: Byte; const  Data: string);
begin
  SendCommand(CMD_PCDWRITEE2 + Chr(startaddr and $FF) +
    Chr(startaddr shr 8) + Data);
end;

procedure TMFRC500Reader.PcdReset;
begin
  SendCommand(CMD_PCDRESET);
end;

procedure TMFRC500Reader.PcdRfReset(ms: word);
var
  S: string;
begin
  SetLength(S, 2);
  move(ms, S[1], 2);
  SendCommand(CMD_PCDRFRESET + S);
end;

procedure TMFRC500Reader.HostGetExecutionTime(var us: LongWord);
begin

end;

procedure TMFRC500Reader.HostTransTmrStart;
begin

end;

procedure TMFRC500Reader.HostTransTmrStop(var ms: LongWord);
begin

end;

procedure TMFRC500Reader.ReadMultiple(var addr_value: Byte; Len: word);
begin

end;

procedure TMFRC500Reader.ReadRIC(addr: Byte; var value: Byte);
begin

end;

procedure TMFRC500Reader.WriteMultiple(var addr_value: Byte; Len: word);
begin

end;

procedure TMFRC500Reader.WriteRIC(addr, value: Byte);
begin

end;

function TMFRC500Reader.GetPort: ISerialPort;
begin
  if FPort = nil then
    FPort := TComPort.Create;
  Result := FPort;
end;

procedure TMFRC500Reader.ShowConnectionProperties(ParentWnd: HWND);
begin
  Port.ShowProperties(ParentWnd);
end;

(*
---------------------------------------------------------------
���: 0x32
��������: ������� ������ � ������ ����� ���������� ����
� ����������: MksFindCard
���������:
 1). 2 ����� - ��� �����
�����:
 1). 2 ����� - ATQ �����
 2). 4 ����� - ����� ��������� �����
---------------------------------------------------------------
*)

procedure TMFRC500Reader.MksFindCard(CardType: Word; var ATQ: Word; var Serial: string);
var
  Data: string;
begin
  Data := SendCommand(CMD_MKSFINDCARD + IntToBin(CardType, 2));
  CheckMinLength(Data, 6);
  ATQ := BinToInt(Data, 1, 2);
  Serial := Copy(Data, 3, 4);
end;

(*
---------------------------------------------------------------
���: 0x30
��������: �������� ��������� �����, � ������� ������ ������
� ����������: MksReopen
���������:
�����:
---------------------------------------------------------------
*)

procedure TMFRC500Reader.MksReopen;
begin
  SendCommand(CMD_MKSREOPEN);
end;

(*
---------------------------------------------------------------
���: 0x31
��������: MksReadCatalog
� ����������: ��������� ������� �����
���������:
�����:
 1). 34 ����� - ������ �� 17�� ������������ ����������� (�������+�.�.)
---------------------------------------------------------------
*)

procedure TMFRC500Reader.MksReadCatalog(var Catalog: string);
begin
  Catalog := SendCommand(CMD_MKSREADCATALOG);
end;

(*
---------------------------------------------------------------
���: 0x33
��������: ���������� ������� �� �����
� ����������: MksWriteCatalog
���������:
 1). 34 ����� - ������ �� 17�� ������������ ����������� (�������)
�����:
---------------------------------------------------------------
*)

procedure TMFRC500Reader.MksWriteCatalog(const Catalog: string);
begin
  SendCommand(CMD_MKSWRITECATALOG + Add0(Catalog, 34));
end;

//

procedure TMFRC500Reader.SleepMode;
begin
  SendCommand(#$FF);
end;

procedure TMFRC500Reader.PcdControlLEDAndPoll(RedLED, GreenLED,
  BlueLED, YellowLed: Boolean; var ButtonState: Boolean);
var
  BS: Byte;
  Data: string;
  LedFlags: Integer;
begin
  LedFlags := 0;
  if BlueLED then SetBit(LedFlags, 0);
  if RedLED then SetBit(LedFlags, 1);
  if GreenLED then SetBit(LedFlags, 2);
  if YellowLED then SetBit(LedFlags, 3);

  Data := SendCommand(CMD_CTRLLEDANDPOLL + Chr(LedFlags));
  BS := BinToInt(Data, 1, 1);
  ButtonState := BS <> 0;
end;

procedure TMFRC500Reader.PcdControlLED(RedLED, GreenLED, BlueLED, YellowLed: Boolean);
var
  LedFlags: Integer;
begin
  LedFlags := 0;
  if BlueLED then SetBit(LedFlags, 0);
  if RedLED then SetBit(LedFlags, 1);
  if GreenLED then SetBit(LedFlags, 2);
  if YellowLED then SetBit(LedFlags, 3);

  SendCommand(CMD_CTRLLED + Chr(LedFlags));
end;

procedure TMFRC500Reader.PcdPollButton(var ButtonState: Boolean);
var
  Data: string;
  BS: Byte;
begin
  Data := SendCommand(CMD_POLLBUTTON);
  BS := BinToInt(Data, 1, 1);
  ButtonState := BS <> 0;
end;

function TMFRC500Reader.GetRxData: string;
begin
  Result := Port.RxData;
end;

function TMFRC500Reader.GetTxData: string;
begin
  Result := Port.TxData;
end;

function TMFRC500Reader.GetDeviceName: string;
begin
  Result := Format('COM%d', [FParams.PortNumber]);
end;

function GetStorageSize(Code: Integer): Integer;
begin
  case Code of
    $21: Result := 72 * 1024;
  else
    Result := 0;
  end;
end;

function GetModeName(Code: Integer): string;
begin
  case Code of
    $A1: Result := 'AV1';
    $A2: Result := 'AV2';
  else
    Result := 'Unknown mode';
  end;
end;

function TMFRC500Reader.SAM_GetVersion: TSAMVersion;
var
  UID: string;
  Data: string;
begin
  Data := SendCommand(#$30);
  CheckMinLength(Data, 31);
  Result.Data := StrToHexText(Data);
  Result.HardwareInfo.VendorID := Ord(Data[1]);
  Result.HardwareInfo.VendorName := GetVendorName(Result.HardwareInfo.VendorID);

  Result.HardwareInfo.RType := Ord(Data[2]);
  Result.HardwareInfo.SubType := Ord(Data[3]);
  Result.HardwareInfo.MajorVersion := Ord(Data[4]);
  Result.HardwareInfo.MinorVersion := Ord(Data[5]);
  Result.HardwareInfo.StorageSizeCode := Ord(Data[6]);
  Result.HardwareInfo.StorageSize := GetStorageSize(Ord(Data[6]));

  Result.HardwareInfo.Protocol := Ord(Data[7]);
  Result.SoftwareInfo.VendorID := Ord(Data[8]);
  Result.SoftwareInfo.RType := Ord(Data[9]);
  Result.SoftwareInfo.SubType := Ord(Data[10]);
  Result.SoftwareInfo.MajorVersion := Ord(Data[11]);
  Result.SoftwareInfo.MinorVersion := Ord(Data[12]);
  Result.SoftwareInfo.StorageSizeCode := Ord(Data[13]);
  Result.SoftwareInfo.StorageSize := GetStorageSize(Ord(Data[13]));
  Result.SoftwareInfo.Protocol := Ord(Data[14]);

  UID := Copy(Data, 15, 7);
  Result.ManufacturingData.UID := BinToInt(Data, 15, 7);
  Result.ManufacturingData.UIDHex := StrToHex(UID);
  Result.ManufacturingData.BatchNo := BinToInt(Data, 22, 5);
  Result.ManufacturingData.ProductionDay := Ord(Data[27]);
  Result.ManufacturingData.ProductionMonth := Ord(Data[28]);
  Result.ManufacturingData.ProductionYear := Ord(Data[29]);
  Result.ManufacturingData.GlobalCryptoSettings := Ord(Data[30]);
  Result.Mode := Ord(Data[31]);
  Result.ModeName := GetModeName(Result.Mode);
end;

(******************************************************************************

case 0x31://Write Mifare keyA and keyB to SAM AV2 module
- ������ ������ Mifare A � B � SAM AV2 ������.

Input: KeyNumber (1) + KeyPos(1) + KeyVersion(1) + KeyA (6) + KeyB (6)
KeyNumber - ����� ����� (�������� 1 - 255)

KeyPos - ������� ����� (�������� 0, 1, 2)

KeyVersion - ������ ����� � �������� �������

KeyA - ���� A (6 ����)
KeyB - ���� B (6 ����)

******************************************************************************)

function AddZero(const S: string; Count: Integer): string;
begin
  Result := Copy(S, 1, Count);
  Result := StringOfChar(#0, Count - Length(Result)) + Result;
end;

procedure TMFRC500Reader.SAM_WriteKey(const Data: TSAMKey);
var
  Command: string;
begin
  Command := #$31 +
    Chr(Data.KeyNumber) +
    Chr(Data.KeyPos) +
    Chr(Data.KeyVersion) +
    AddZero(Data.KeyA, 6) +
    AddZero(Data.KeyB, 6);
  SendCommand(Command);
end;

(******************************************************************************

case 0x32://Auth to PICC
- ����������� �� �����

//Input: KeyType(1) + KeyNumber(1) + KeyVersion(1) + MfcBlock(1)
KeyType - ��� ����� (A ��� B)
�������� KeyType
 PICC_AUTHENT1A = 0x60    //!< authentication using key A
���
 PICC_AUTHENT1B     0x61         //!< authentication using key B

KeyNumber - ����� ����� (�������� 1 - 255)

KeyVersion - ������ ����� (�������� 0 - 255)

MfcBlock - ����� ����� �� ����� ��� ���������� (0 - 255)

******************************************************************************)

procedure TMFRC500Reader.SAM_AuthKey(const Data: TSAMKeyInfo);
var
  Command: string;
begin
  Command := #$32 + Chr(Data.KeyType) +
    Chr(Data.KeyNumber) + Chr(Data.KeyVersion) +
    Chr(Data.BlockNumber);
  SendCommand(Command);
end;

(******************************************************************************

  0x34://Write Key for AuthHost SAM AV2
  - ������ ����� ����������� SAM ������
  ���� ����� ����� 16 ���� (128 ���)
  ��� ������������ ������� ���������� � ���� ����.

  �������
  ����� ������� (�������) 19 ����
  ��� ������� 0x34
  ���� 16 ����
  CRC16 2 ����� - ��������� ������ ��� �����
  ��� ��� CRC16 ����.

*******************************************************************************)

function CRC_U(crc: Word; data: Byte): Word;
begin
  data := data xor (crc and $ff);
  data := data xor (data shl 4);
  Result := (((data shl 8) or ((crc and $ff00) shr 8)) xor (data shr 4) xor ((data shl 3)));
end;

function CRC16(const Data: string): Word; //������� CRC
var
  i: Word;
begin
  Result := 0;
  for i := 1 to Length(Data) do
    Result := crc_u(Result, Ord(Data[i]));
end;

procedure TMFRC500Reader.SAM_WriteHostAuthKey(const KeyUncoded: string);
var
  Command: string;
begin
  Command := Add0(KeyUncoded, 16);
  Command := #$34 + Command + IntToBin(CRC16(Command), 2);
  SendCommand(Command);
end;

(******************************************************************************

0x35://GetKeyEntry
- �������� ��������� ������ (Entry) �����. � ����� ������ ��� �����
�������
����� ������� (�������) 2 ����
��� ������� 0x35
����� �������� ������ 1 - ���� (�������� 0 - 255, � ������� ������ SAM ������ �� 127)

�����
����� ������� 11 ����
��� ������ - 1 ����
��� ����� - 2 ����� (������ ��� ������� ����)
����� ������ ������ - 2 ����� (������ ��� ������� ����)
- ��� ���� �������� �� ���� ����� ������ � ������ (�� 0 �� 3)
- �� ���� ������� ������� ��������� � ������ ������ ��������� �������
������ ����� � ������� 0 - 2 ����� (������ ��� ������� ����)
������ ����� � ������� 1 - 2 ����� (������ ��� ������� ����)
������ ����� � ������� 2 - 2 ����� (������ ��� ������� ����)

*******************************************************************************)

function TMFRC500Reader.SAM_GetKeyEntry(KeyNumber: Integer): TSAMKeyEntry;
var
  Data: string;
  Command: string;
begin
  Command := #$35 + Chr(KeyNumber);
  Data := SendCommand(Command);
  CheckMinLength(Data, 4);
  FillChar(Result, SizeOf(Result), #0);
  Result.KeyType := BinToInt(Data, 1, 2);
  Result.KeyNumber := BinToInt(Data, 3, 2);
  if Length(Data) > 5 then
    Result.KeyVersion0 := BinToInt(Data, 5, 2);
  if Length(Data) > 7 then
    Result.KeyVersion1 := BinToInt(Data, 7, 2);
  if Length(Data) > 9 then
    Result.KeyVersion2 := BinToInt(Data, 9, 2);
end;

(******************************************************************************

  0x36://Get Full Serial Number
  - �������� ������ �������� ����� �����������
  ������ �������� ����� �������� 12 ����.

  �������
  ����� ������� (�������) 1 ����
  ��� ������� 0x36

  �����
  ����� ������� 17 ����
  ��� ������ - 1 ����
  ������ �������� ����� - 16 ����

******************************************************************************)

function TMFRC500Reader.ReadFullSerialNumber: string;
begin
  Result := SendCommand(#$36);
end;

(******************************************************************************

�������
����� ������� (�������) 1 ����
��� ������� 0x37

�����
����� ������� 1 ����
��� ������

******************************************************************************)

procedure TMFRC500Reader.SAM_SetProtection;
begin
  SendCommand(#$37);
end;

(******************************************************************************

  0x38://Set protection on SAM AV2 module with external serial number
  - ����������/�������� ������ SAM ������ � �������������� �����������
  ��������� ������
  ����� ��� ���������� SAM ������� ����� ���������� � �����������
  ����� �������������� ����� �������� �������� ������ ���� ������������

  �������
  ����� ������� (�������) 19 ����
  ��� ������� 0x38
  �������� ����� 16 ����
  CRC16 2 ����� - ��������� ������ ��� ��������� ������
  ��� ��� CRC16 ����.

  �����
  ����� ������� 1 ����
  ��� ������

******************************************************************************)

procedure TMFRC500Reader.SAM_SetProtectionSN(const SerialNumber: string);
var
  Command: string;
begin
  Command := Add0(SerialNumber, 16);
  Command := #$38 + Command + IntToBin(CRC16(Command), 2);
  SendCommand(Command);
end;

function TMFRC500Reader.IsPortOpened: Boolean;
begin
  Result := Port.Opened;
end;

(******************************************************************************

  ������� ����� ��������. ��� ������� 0xF4,
  �������� � ���� ���� ��������� ��������.

  0 - 2400
  1 - 4800
  2 - 9600
  3 - 14400
  4 - 19200
  5 - 28800
  6 - 38400
  7 - 57600
  8 - 115200

******************************************************************************)

const
  BaudRates: array [0..8] of Integer = (
    2400,
    4800,
    9600,
    14400,
    19200,
    28800,
    38400,
    57600,
    115200);

function BaudRateToCode(BaudRate: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(BaudRates) to High(BaudRates) do
  begin
    if BaudRates[i] = BaudRate then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TMFRC500Reader.WriteConnectionParams(BaudRate: Integer);
begin
  SendCommand(#$F5 + Chr(BaudRateToCode(BaudRate)));
end;

(******************************************************************************

  ������� ��� ������ � ������� Ultraligth � Ultraligth C.
  ������� �������� Ultraligth �.

  ����� �������� 48 ������� ������ �� 0 �� 47 (2Fh).
  ������ �������� �� 32 ���� (4 �����).

(******************************************************************************

  0x21://Ultralight read. Read 16 bytes
  - ������� ������ ������ � ����� Ultralight ��� Ultraligth C.
  � ���������� ������� 1 ���� ������ �������� �������� ������.
  ��� ������ ������ �������� 16 ����. 4 ����� � �������� �������� �
  12 �� ��������� 3 �������.
  ���� ����� �� ��������� �������� ��� �� ��� ����� �����  0.
  ������� ����� ������ (1 ����) � 16 ��������� ����.

******************************************************************************)

function TMFRC500Reader.UltralightRead(Address: Byte): string;
begin
  Result := SendCommand(#$21 + Chr(Address));
end;

(******************************************************************************

  0x22://Ultralight write. Write 4 bytes
  - ������� ������.
  � ���������� ������� 1 ���� ������ ������������ �������� ������ �
  ����� 4 ����� ������.
  ������� ����� ������ (1 ����).

******************************************************************************)

procedure TMFRC500Reader.UltralightWrite(Address: Byte; const Data: string);
begin
  SendCommand(#$22 + Chr(Address) + AddZero(Data, 4));
end;

(******************************************************************************

case 0x23://Ultralight compatibility write. Write 4 bytes from 16
- ������� ������ � ������ ������������� � Mifare Classic.
� ���������� ������� 1 ���� ������ ������������ �������� ������ � ����� 16 ����� ������.
������� ����� ������ (1 ����).
���������� 4 ������ ����� �� ����������, ��������� 12 ������ ���� ����� 0.

******************************************************************************)

procedure TMFRC500Reader.UltralightCompatWrite(Address: Byte; const Data: string);
begin
  SendCommand(#$23 + Chr(Address) + AddZero(Data, 4) + StringOfChar(#0, 12));
end;

(******************************************************************************

  0x24://Write Key to SAM for Ultralight C
  - ������� ������ ����� ����������� � ����� Ultralight C.
  ���������� � SAM AV2 ������ ���� 2K3DES ��� ����������� � ����� Ultralight C.
  � ���������� �������: ����� ����� (1 ����, �� 0 �� 255), ������� �����
  (1 ����, �� 0 �� 2), ������ ����� (1 ����, �� 0 �� 255) � 16 ���� �����.
  ������� ����� ������ (1 ����).

******************************************************************************)

procedure TMFRC500Reader.UltralightWriteKey(
  KeyNumber, KeyPosition, KeyVersion: Byte; const Data: string);
begin
  SendCommand(#$24 + Chr(KeyNumber) + Chr(KeyPosition) + Chr(KeyVersion) +
    AddZero(Data, 16));
end;

(******************************************************************************

0x25://Ultralight-C Authentication
- ������� ����������� � ����� Ultralight C �� ����� � SAM AV2 ������.
� ���������� �������: ����� ����� (1����, �� 0 �� 255), ������ �����
(1 ����, �� 0 �� 255).
������� ����� ������ (1 ����).

******************************************************************************)

procedure TMFRC500Reader.UltralightAuth(KeyNumber, KeyVersion: Byte);
begin
  SendCommand(#$25 + Chr(KeyNumber) + Chr(KeyVersion));
end;

(******************************************************************************

  ������� ���������� �����.

  ��� ������� 0x1C.
  ���������: bDri - 1 ���� � bDsi - 1 ����.
  bDri - Divisor Receive, ����� �������� �������� ������ �� ����������� � �����.
  bDri - Divisor Send, ����� �������� �������� ������ �� ����� � �����������.

  �������� ��� bDri  � bDsi:
  PHPAL_I14443P4A_DATARATE_106  = 0x00U; // DRI/DSI value for 106 kBit/s
  PHPAL_I14443P4A_DATARATE_212  = 0x01U; // DRI/DSI value for 212 kBit/s
  PHPAL_I14443P4A_DATARATE_424  = 0x02U; // DRI/DSI value for 424 kBit/s
  PHPAL_I14443P4A_DATARATE_848  = 0x03U; // DRI/DSI value for 848 kBit/s

  ���������� 1 ���� �������.
  ������� ����������� ����� ��������� �����.

  ��������� ��� ������ WritePerso, CommitPerso � ������ ������ � Mifare Plus
  � ������� SL2, SL3, ��� �������� ���� � ������ SL1 �� SL2 ��� SL3.
  �.�. ������ ���� ���������� ������� ����� ����� ���������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusWriteParameters(ReceiveDivisor, SendDivisor: Byte);
begin
  SendCommand(#$1C + Chr(ReceiveDivisor) + Chr(SendDivisor));
end;

(******************************************************************************

  Commit Perso.
  ������� ����� � ����� SL1 ����� �������������� (������ ������ � ������).

  ��� ������� 0x1D.
  ���������� ���.
  ���������� 1 ���� �������.

  ����������� ����� ���� ��� ����� �������� ��� ������ � ����� �� �����.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusCommitPerso;
begin
  SendCommand(#$1D);
end;

(******************************************************************************

  Write Perso.
  ������ ������ � ������ �� ����� ��� ��������������.

  ��� ������� 0x1E.

  ��������� �������: ����� ����� ��� ������ - 2 ����� (word), 16 ���� ������ ��� ������.
  ������� ���� ������.

  ���������� 1 ���� �������.
  ���������� ��� ����� ������ � ����� ���������� �������, ��� � AES �����
  ��� Mifare Plus � ���������������� ������ ��� ������ � ������� SL2, SL3.

  ������ ��� ������ �������� � Hex.
  ������ ��� � Mifare �� 0 �� 1FF - ����� �� 0 �� 4 �������� ��� 8K �����.
  ���� �������� ����������� ������ ��� ������ ���������� �������,
  ��� �� ��� � �������� ��������� ������� -> �������.

  � �������������:
  CARD_MASTER_KEY              = 0x9000U; // Card Master Key Address
  CARD_CONFIGURATIOM_KEY       = 0x9001U; // Card Configuration Key Address
  LEVEL_2_SWITCH_KEY           = 0x9002U; // Level 2 Switch Key Address
  LEVEL_3_SWITCH_KEY           = 0x9003U; // Level 3 Switch Key Address
  SL_1_CARD_AUTHENTICATION_KEY = 0x9004U; // SL1 Card Authentication Key Address
  SELECT_VC_KEY                = 0xA000U; // Select VC Key Address
  PROXIMITY_CHECK_KEY          = 0xA001U; // Proximity Check Key Address
  VC_POLLING_ENC_KEY           = 0xA080U; // VC Polling ENC Key Address
  VC_POLLING_MAC_KEY           = 0xA081U; // VC Polling MAC Key Address
  MFP_CONFIGURATION_BLOCK      = 0xB000U; // MIFARE Plus Configuration block Address
  INSTALLATION_IDENTIFIER      = 0xB001U; // Installation Identifier Address
  FIELD_CONFIGURATION_BLOCK    = 0xB003U; // Field Configuration block Address
  PHYSICAL_AES_START_ADDRESS   = 0x4000U; // physical start address of AES key location Address
  PHYSICAL_AES_EDD_ADDRESS     = 0x404FU; // physical end address of AES key location Address

  ������ ����� SL0 - ������ �������� ������� ������� ��������������, SL1
  - ����� ������������� � Mifare Classic, SL2 �  SL3 - ������ Mifare Plus.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusWritePerso(BlockNumber: Integer;
  const BlockData: string);
begin
  SendCommand(#$1E + IntToBin(BlockNumber, 2) + AddZero(BlockData, 16));
end;

(******************************************************************************

  Reset Authentication Mifare Plus PICC.
  ����� ����������� Mifare Plus.

  ��� ������� 0x39.
  ���������� ���.
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusResetAuthentication;
begin
  SendCommand(#$39);
end;

(******************************************************************************

  Mfp write.
  ������ ����� �� ����� Mifare Plus � ������ SL3.

  ��� ������� 0x3A.
  ���������: 2 ����� - ����� ����� (������� ���� ������), 16 ���� - ������.
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusWrite(const P: TMifarePlusWrite);
var
  Command: string;
begin
  Command := #$3A +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.Encryption] +
    BoolToChar[P.AnswerSignature] +
    AddZero(P.BlockData, 16);

  SendCommand(Command);
end;

(******************************************************************************

  Mifare Plus read.
  ������ ����� � ����� Mifare Plus ������ SL3.

  ��� ������� 0x3B.
  ���������: 2 ����� - ����� �����.
  �����: 1 ���� - ������, 16 ���� - ������.

******************************************************************************)

function TMFRC500Reader.MifarePlusRead(
  const P: TMifarePlusReadValue): string;
var
  Command: string;
begin
  Command := #$3B +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.Encryption] +
    BoolToChar[P.AnswerSignature] +
    BoolToChar[P.CommandSignature];
  Result := SendCommand(Command);
end;


(******************************************************************************

  Mfp write Value.
  ������ Value �������� �� ����� � ������ SL3 (������ ������ � Value ������� � Mifare Classic).

  ��� ������� 0x3C.
  ���������: 2 ����� - ����� �����, 4 ����� - ������.
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusWriteValue(const P: TMifarePlusWriteValue);
var
  Command: string;
begin
  Command := #$3C +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.Encryption] +
    BoolToChar[P.AnswerSignature] +
    IntToBin(P.BlockValue, 4);

  SendCommand(Command);
end;

(******************************************************************************

  Mfp read value.
  ������ Value �������� � ����� � ������ SL3 (������ ������ � Value ������� � Mifare Classic).

  ��� ������� 0x3D.
  ���������: 2 ����� - ����� �����.
  �����: 1 ���� - ������, 4 ���� - ������.

******************************************************************************)

function TMFRC500Reader.MifarePlusReadValue(const P: TMifarePlusReadValue): Integer;
var
  Value: string;
  Command: string;
begin
  Command := #$3D +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.Encryption] +
    BoolToChar[P.AnswerSignature] +
    BoolToChar[P.CommandSignature];

  Value := SendCommand(Command);
  CheckMinLength(Value, 4);
  Result := BinToInt(Value, 1, 4);
end;

(******************************************************************************

  Mfp increment.
  ��������� Value �������� �� �����.

  ��� ������� 0x3E.
  ���������: 2 ����� - ����� �����, 4 ����� - ������ (�������� ����������).
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusIncrement(const P: TMifarePlusIncrement);
var
  Command: string;
begin
  Command := #$3E +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.AnswerSignature] +
    IntToBin(P.DeltaValue, 4);

  SendCommand(Command);
end;

(******************************************************************************

  Mfp decrement.
  ��������� Value �������� �� �����.

  ��� ������� 0x3F.
  ���������: 2 ����� - ����� �����, 4 ����� - ������ (�������� ����������).
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusDecrement(const P: TMifarePlusDecrement);
var
  Command: string;
begin
  Command := #$3F +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.AnswerSignature] +
    IntToBin(P.DeltaValue, 4);
  SendCommand(Command);
end;

(******************************************************************************

  Mfp transfer.
  ������ Value �������� �� �������� (����������) � ����.
  �� ���� ���������� �������� � ����� ����� �������� ���������� � ����������.

  ��� ������� 0x40.
  ���������: 2 ����� - ����� �����.
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusTransfer(const P: TMifarePlusTransfer);
var
  Command: string;
begin
  Command := #$40 +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.AnswerSignature];
  SendCommand(Command);
end;

(******************************************************************************

  Mfp restore.
  ������ Value �������� � ������� (���������) �� �����.

  ��� ������� 0x41.
  ���������: 2 ����� - ����� �����.
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusRestore(const P: TMifarePlusRestore);
var
  Command: string;
begin
  Command := #$41 +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.AnswerSignature];
  SendCommand(Command);
end;

(******************************************************************************

  Mfp increment transfer.
  ��������� Value �������� �� ����� � ������������� ����������� ����������.

  ��� ������� 0x42.
  ���������: 2 ����� - ����� �����, 4 ����� - ������ (�������� ����������).
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusIncrementTransfer(
  const P: TMifarePlusIncrement);
var
  Command: string;
begin
  Command := #$42 +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.AnswerSignature] +
    IntToBin(P.DeltaValue, 4);

  SendCommand(Command);
end;

(******************************************************************************

  Mfp decrement transfer.
  ��������� Value �������� �� ����� � ������������� ����������� ����������.

  ��� ������� 0x43.
  ���������: 2 ����� - ����� �����, 4 ����� - ������ (�������� ����������).
  �����: 1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusDecrementTransfer(
  const P: TMifarePlusDecrement);
var
  Command: string;
begin
  Command := #$43 +
    IntToBin(P.BlockNumber, 2) +
    BoolToChar[P.AnswerSignature] +
    IntToBin(P.DeltaValue, 4);
  SendCommand(Command);
end;

(******************************************************************************

  12. SL3 AES Card Authentication.
  ����������� � ����� � ������ SL3.

  ��� ������� 0x44.
  ���������:
    1 ���� - ��� �����������,
    2 ����� - ����� �����,
    1 ���� - ����� ����� � SAM AV2 ������ (���� ������������ ��� �����������),
    1 ���� - ������ �����.
  �����:
    1 ���� - ������.

  ��� �����������:
  FOLLOWING_AUTH    = 0x00U; // Following Authentication
  FIRST_AUTH        = 0x01U; // First Authentication

******************************************************************************)

procedure TMFRC500Reader.MifarePlusAuthSL3(const P: TMifarePlusAuth; var Status: Integer);
var
  Answer: AnsiString;
  Command: AnsiString;
begin
  Command := #$44 + Chr(P.AuthType) + IntToBin(P.BlockNumber, 2) +
    Chr(P.KeyNumber) + Chr(P.KeyVersion);
  Answer := SendCommand(Command);
  if Length(Answer) > 0 then
  begin
    Status := Ord(Answer[1]);
  end;
end;

(******************************************************************************

  Multiblock write.
  ������ ���������� ������ ��� ������� ��������� ����� �����������.

  ��� ������� 0x45.
  ���������:
    2 ����� - ����� �����, NumberOfBlock
    1 ���� - ����� �������� ������ (�������� 15, ������� 1),
    16*NumberOfBlock ����� - ������ (�������� 240).
  �����:
    1 ���� - ������.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusMultiblockWrite(
  const P: TMifarePlusMultiblockWrite);
var
  Command: string;
begin
  Command := #$45 +
    IntToBin(P.BlockNumber, 2) +
    Chr(P.BlockCount) +
    BoolToChar[P.Encryption] +
    BoolToChar[P.AnswerSignature] +
    AddZero(P.BlockData, P.BlockCount*16);

  SendCommand(Command);
end;

procedure TMFRC500Reader.MifarePlusMultiblockWriteSL2(
  const P: TMifarePlusMultiblockWriteSL2);
var
  Command: string;
begin
  Command := #$4B +
    IntToBin(P.BlockNumber, 2) +
    Chr(P.BlockCount) +
    AddZero(P.BlockData, P.BlockCount*16);

  SendCommand(Command);
end;

(******************************************************************************

  Multiblock read.
  ������ ���������� ������ ��� ������� ��������� ����� �����������.

  ��� ������� 0x46.
  ���������:
    2 ����� - ����� �����, NumberOfBlock
    1 ���� - ����� �������� ������ (�������� 15, ������� 1).
  �����:
    1 ���� - ������,
    16*NumberOfBlock ����� - ������ (�������� 240).

******************************************************************************)

function TMFRC500Reader.MifarePlusMultiblockRead(
  const P: TMifarePlusMultiblockRead): string;
var
  Command: string;
begin
  Command := #$46 +
    IntToBin(P.BlockNumber, 2) +
    Chr(P.BlockCount) +
    BoolToChar[P.Encryption] +
    BoolToChar[P.AnswerSignature] +
    BoolToChar[P.CommandSignature];

  Result := SendCommand(Command);
end;

function TMFRC500Reader.MifarePlusMultiblockReadSL2(
  const P: TMifarePlusMultiblockReadSL2): string;
var
  Command: string;
begin
  Command := #$4C +
    IntToBin(P.BlockNumber, 2) +
    Chr(P.BlockCount);
  Result := SendCommand(Command);
end;

(******************************************************************************

  ����������� �� ������ SL1.

  ��� ������� 0x47.
  ���������:
    ��� ����������� 1 ����,
    ����� ����� 2 �����,
    ����� ����� 1 ����,
    ������ ����� 1 ����.

  ��� �����������:
  FOLLOWING_AUTH    = 0x00U; // Following Authentication
  FIRST_AUTH        = 0x01U; // First Authentication

  �����: ������ 1 ����.

******************************************************************************)

procedure TMFRC500Reader.MifarePlusAuthSL1(const P: TMifarePlusAuth);
begin
  SendCommand(
    #$47 +
    Chr(P.AuthType) +
    Chr(P.Protocol) +
    IntToBin(P.BlockNumber, 2) +
    Chr(P.KeyNumber) +
    Chr(P.KeyVersion));
end;

procedure TMFRC500Reader.MifarePlusAuthSL2(const P: TMifarePlusAuth);
begin
  SendCommand(
    #$49 +
    Chr(P.AuthType) +
    Chr(P.Protocol) +
    IntToBin(P.BlockNumber, 2) +
    Chr(P.KeyNumber) +
    Chr(P.KeyVersion));
end;

///////////////////////////////////////////////////////////////////////////////
//
//  ������� E0h �����������/������ ����� ����
//  ������� ���������� ��� ������� ����� ����.
//  ����� ���������� ����� ����, �������������� �����������
//  ��������� � ����� ��� ������� �������������� ��������� �����.
//
// 0x30 � ��������� ���� ����.
// 0x31 � ��������� ���� ����.

procedure TMFRC500Reader.EnableCardAccept;
begin
  SendCommand(#$E0#$30);
end;

procedure TMFRC500Reader.DisableCardAccept;
begin
  SendCommand(#$E0#$31);
end;

///////////////////////////////////////////////////////////////////////////////
// ������� E2h ������� �����

procedure TMFRC500Reader.IssueCard;
begin
  SendCommand(#$E2);
end;

///////////////////////////////////////////////////////////////////////////////
// ������� E3h ���������� �����

procedure TMFRC500Reader.HoldCard;
begin
  SendCommand(#$E3);
end;

///////////////////////////////////////////////////////////////////////////////
// ������� E4h ��������� ����� �� ��������� �������� �������

function TMFRC500Reader.ReadLastAnswer: string;
begin
  Result := SendCommand(#$E4);
end;

///////////////////////////////////////////////////////////////////////////////
//
// ������� E1h ���������� ������ ������������
//


procedure TMFRC500Reader.ReadStatus;
begin
  SendCommand(#$E1);
end;

procedure TMFRC500Reader.SAMAV2WriteKey(const P: TSAMAV2Key);
var
  Command: string;
begin
  Command := #$48 +
    Chr(P.KeyEntry) +
    Chr(P.KeyPosition) +
    Chr(P.KeyVersion) +
    Add0(P.KeyData, 16);

  SendCommand(Command);
end;

procedure TMFRC500Reader.MifarePlusAuthSL2Crypto1(
  const P: TMifarePlusAuthSL2Crypto1);
var
  Command: string;
begin
  Command := #$4A +
    Chr(P.BlockNumber) +
    Chr(P.KeyType) +
    Chr(P.KeyNumber) +
    Chr(P.KeyVersion) +
    Chr(Length(P.UID)) +
    P.UID;

  SendCommand(Command);
end;

(******************************************************************************

  ������� 26h "������ ������������� AES128 ������ ������ �� �����"
  ���������� �� ����� ���� ������, �������������� ����������� ���
  ��������� AES ������.

  ��������� � �����������
  ����� ���������: 22 ����.
  �	��������	������, ����
  1	��� �������: 26h	1
  2	��������, ������������ ��� ������:
  0x00 - ISO14443-3 (��� ���� Mifare Classic)
  0x01 - ISO14443-4 (��� ���� Mifare Plus)	1
  3	����� ����� ��� ������	2
  4	����� ������ (Key Entry) � ������ AES ��� ������������ �����	1
  5	������ �����	1
  6	������	16

  ����� �� �����������
  ����� ���������: 1 ����.
  �	��������	������, ����
  1	��� ������	1

******************************************************************************)

procedure TMFRC500Reader.WriteEncryptedData(
  const P: TWriteEncryptedDataRec);
var
  Command: string;
begin
  Command := #$26 +
    Chr(P.Protocol) +
    IntToBin(P.BlockNumber, 2) +
    Chr(P.KeyNumber) +
    Chr(P.KeyVersion) +
    AddZero(P.BlockData, 16);
  SendCommand(Command);
end;

function TMFRC500Reader.GetCardType: Integer;
begin
  Result := FCardType;
end;

function TMFRC500Reader.GetCardName: string;
begin
  Result := FCardName;
end;

(*
������� 27h "������������ ����� SAM AV2 ������"
���������� ������������ ����� SAM ������.
���� SAM AV2 ��� � ����� ��� ��� ������ ����� (����� ������ 4),
�� ������������ �� ���������. ���� ��������� ESMART.

��������� � �����������
����� ���������: 2 ����� ��� 3 �����.
�	��������	������, ����
1	��� �������: 27h	1
2	����� �����. �������� �� 0 �� 4.
����� ������������ �������� ���� 4, ����� ������������ �� ���������. �� ����� ��������� ������� ����.
��� �������� �������� ����� 27h �� ����� ���������� ������ � ����� ��������� ������� ����.	1
3	������������ ����.
��� �������� ������ 0x01 ���������� ������������ �� ���������� ������ ��� SAM ������.	1

����� �� �����������
����� ���������: 7 ����.
�	��������	������, ����
1	��� ������	1
2	������� ����. �������� �� 0 �� 4. ���� 0xFF ���� ������ ��� SAM ������. ��. ������������ �������� �������.
���� ��� ������, �� ����� ����� �����, ������� ��� ����� � �������.
���� � ����� ��� SAM AV2 ������ ��� ��� ������ �����, �� ����� ������� ����.	1
3	������ ����� 0. �������� 0 - ��� SAM AV2 ������ � ����� ��� �� ������� ��������������, 255 - ���� SAM AV2 � �����, 1 - �� ��������� SAM ������ � �����, 2 - ESMART.	1
4	������ ����� 1. �������� 0 - ��� SAM AV2 ������ � ����� ��� �� ������� ��������������, 255 - ���� SAM AV2 � �����, 1 - �� ��������� SAM ������ � �����, 2 - ESMART.	1
5	������ ����� 2. �������� 0 - ��� SAM AV2 ������ � ����� ��� �� ������� ��������������, 255 - ���� SAM AV2 � �����, 1 - �� ��������� SAM ������ � �����, 2 - ESMART.	1
6	������ ����� 3. �������� 0 - ��� SAM AV2 ������ � ����� ��� �� ������� ��������������, 255 - ���� SAM AV2 � �����, 1 - �� ��������� SAM ������ � �����, 2 - ESMART.	1
7	������ ����� 4. �������� 0 - ��� SAM AV2 ������ � ����� ��� �� ������� ��������������, 255 - ���� SAM AV2 � �����, 1 - �� ��������� SAM ������ � �����, 2 - ESMART. ���� ���� ������ �����������.	1

*)

procedure TMFRC500Reader.MifarePlusSelectSAMSlot (const P: TSelectSAM;
  var R: TSelectSAMAnswer);
var
  Answer: string;
  Command: string;
begin
  Command := #$27 + Chr(P.SlotNumber);
  if P.UseOptional then
    Command := Command + Chr(P.Optional);
  Answer := SendCommand(Command);
  if Length(Answer) >= 6 then
  begin
    R.SlotNumber := Ord(Answer[1]);
    R.SlotStatus0 := Ord(Answer[2]);
    R.SlotStatus1 := Ord(Answer[3]);
    R.SlotStatus2 := Ord(Answer[4]);
    R.SlotStatus3 := Ord(Answer[5]);
    R.SlotStatus4 := Ord(Answer[6]);
  end;
end;

(*
"����������� SL3 �� ����������� �����"
ReaderOldCommand_PICC_SL3_SW_AUTHENTICATION    0x4E
�����������  � ����� Mifare Plus SL3, � ������������� �� SW keystore, � ���� �� �������
Input: 1 byte - auth_type, 2 bytes - blocknumber, 16 bytes - key_value, optional 1 to 31 bytes DivInput
Output: 1 byte - status
*)

procedure TMFRC500Reader.MifarePlusAuthSL3Key(const P: TMifarePlusAuthKey;
  var Status: Integer);
var
  Answer: string;
  Command: string;
begin
  if Length(P.KeyValue) < 16 then
    raise Exception.Create('Invalid KeyValue length. Must be 16 bytes');

  Command := #$4E + Chr(P.AuthType) + IntToBin(P.BlockNumber, 2) +
    Copy(P.KeyValue, 1, 16) + P.DivInput;
  Answer := SendCommand(Command);
  if Length(Answer) > 0 then
  begin
    Status := Ord(Answer[1]);
  end;
end;

end.
