unit CardReaderInterface;

interface

uses
  // VCL
  Windows,
  // This
  SerialParams, MifareLib_TLB;

type
  { TSAMKey }

  TSAMKey = record
    KeyNumber: Byte;
    KeyPos: Byte;
    KeyVersion: Byte;
    KeyA: string; // 6 bytes
    KeyB: string; // 6 bytes
  end;

  { TSAMKeyInfo }

  TSAMKeyInfo = record
    KeyType: Byte;
    KeyNumber: Byte;
    KeyVersion: Byte;
    BlockNumber: Byte;
  end;

  { TSAMKeyEntry }

  TSAMKeyEntry = record
    KeyType: Word;
    KeyNumber: Word;
    KeyVersion0: Word;
    KeyVersion1: Word;
    KeyVersion2: Word;
  end;

  { TMifarePlusAuth }

  TMifarePlusAuth = record
    AuthType: Integer;
    Protocol: Integer;
    BlockNumber: Integer;
    KeyNumber: Integer;
    KeyVersion: Integer;
  end;

  { TSAMAV2Key }

  TSAMAV2Key = record
    KeyEntry: Integer;
    KeyPosition: Integer;
    KeyVersion: Integer;
    KeyData: string;
  end;

  { TMifarePlusReadValue }

  TMifarePlusReadValue = record
    BlockNumber: Integer;      // Номер блока
    Encryption: Boolean;       // Настройка обмена, шифрование
    AnswerSignature: Boolean;  // Настройка обмена, подпись ответа
    CommandSignature: Boolean; // Настройка обмена, подпись команды
  end;

  { TMifarePlusWriteValue }

  TMifarePlusWriteValue = record
    BlockNumber: Integer;      // Номер блока
    BlockValue: Integer;       // Значение блока
    Encryption: Boolean;       // Настройка обмена, шифрование
    AnswerSignature: Boolean;  // Настройка обмена, подпись ответа
  end;

  { TMifarePlusIncrement }

  TMifarePlusIncrement = record
    BlockNumber: Integer;
    DeltaValue: Integer;
    AnswerSignature: Boolean;  // Настройка обмена, подпись ответа
  end;

  { TMifarePlusDecrement }

  TMifarePlusDecrement = record
    BlockNumber: Integer;
    DeltaValue: Integer;
    AnswerSignature: Boolean;  // Настройка обмена, подпись ответа
  end;

  { TMifarePlusRestore }

  TMifarePlusRestore = record
    BlockNumber: Integer;
    AnswerSignature: Boolean;  // Настройка обмена, подпись ответа
  end;

  { TMifarePlusTransfer }

  TMifarePlusTransfer = record
    BlockNumber: Integer;
    AnswerSignature: Boolean;  // Настройка обмена, подпись ответа
  end;

  { TMifarePlusWrite }

  TMifarePlusWrite = record
    BlockNumber: Integer;       // Номер блока
    BlockData: string;          // Значение блока
    Encryption: Boolean;        // Настройка обмена, шифрование
    AnswerSignature: Boolean;   // Настройка обмена, подпись ответа
  end;

  { TMifarePlusMultiblockRead }

  TMifarePlusMultiblockRead = record
    BlockNumber: Integer;       // Номер блока
    BlockCount: Integer;        // Количество блоков
    Encryption: Boolean;        // Настройка обмена, шифрование
    AnswerSignature: Boolean;   // Настройка обмена, подпись ответа
    CommandSignature: Boolean;  // Настройка обмена, подпись команды
  end;

  { TMifarePlusMultiblockWrite }

  TMifarePlusMultiblockWrite = record
    BlockNumber: Integer;       // Номер блока
    BlockCount: Integer;        // Количество блоков
    BlockData: string;          // Значение блока
    Encryption: Boolean;        // Настройка обмена, шифрование
    AnswerSignature: Boolean;   // Настройка обмена, подпись ответа
  end;

  { TMifarePlusMultiblockReadSL2 }

  TMifarePlusMultiblockReadSL2 = record
    BlockNumber: Integer;       // Номер блока
    BlockCount: Integer;        // Количество блоков
  end;

  { TMifarePlusMultiblockWriteSL2 }

  TMifarePlusMultiblockWriteSL2 = record
    BlockNumber: Integer;       // Номер блока
    BlockCount: Integer;        // Количество блоков
    BlockData: string;          // Значение блока
  end;

  { TMifarePlusAuthSL2Crypto1 }

  TMifarePlusAuthSL2Crypto1 = record
    BlockNumber: Byte;
    KeyType: Byte;
    KeyNumber: Byte;
    KeyVersion: Byte;
    UID: string;
  end;

  { TWriteEncryptedDataRec }

  TWriteEncryptedDataRec = record
    Protocol: Integer;
    BlockNumber: Integer;
    KeyNumber: Integer;
    KeyVersion: Integer;
    BlockData: string;
  end;

  { TSelectSAM }

  TSelectSAM = record
    SlotNumber: Byte; // Номер слота. Значение от 0 до 4.
    Optional: Byte;   // Опциональный байт.
    UseOptional: Boolean;
  end;

  { TSelectSAMAnswer }

  TSelectSAMAnswer = record
    SlotNumber: Byte;  // Текущий слот. Значение от 0 до 4. Либо 0xFF если работа без SAM модуля
    SlotStatus0: Byte; // Статус слота 0
    SlotStatus1: Byte; // Статус слота 1
    SlotStatus2: Byte; // Статус слота 2
    SlotStatus3: Byte; // Статус слота 3
    SlotStatus4: Byte; // Статус слота 4
  end;

  { ICardReader }

  ICardReader = interface
  ['{C643CEDB-F12A-4374-A4E0-FE88EC85E0FF}']

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
    procedure MifarePlusAuthSL3(const P: TMifarePlusAuth);
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
    procedure WriteEncryptedData(const P: TWriteEncryptedDataRec);

    procedure EnableCardAccept;
    procedure DisableCardAccept;
    procedure ReadStatus;
    procedure IssueCard;
    procedure HoldCard;
    function GetCardType: Integer;
    function GetCardName: string;
    function ReadLastAnswer: string;
    procedure SAMAV2WriteKey(const P: TSAMAV2Key);
    procedure MifarePlusAuthSL2Crypto1(const P: TMifarePlusAuthSL2Crypto1);
    procedure MifarePlusSelectSAMSlot(const P: TSelectSAM; var R: TSelectSAMAnswer);

    property RxData: string read GetRxData;
    property TxData: string read GetTxData;
    property CardName: string read GetCardName;
    property CardType: Integer read GetCardType;
    property DeviceName: string read GetDeviceName;
  end;

function CardTypeToCardName(CardType: TCardType): string;
function SelectCardType(card_atq: Word; card_sak: Byte): TCardType;

implementation

function CardTypeToCardName(CardType: TCardType): string;
begin
  case CardType of
    ctMifareUltraLight: Result := 'MIFARE ultralight';
    ctMifare1K: Result := 'MIFARE 1K';
    ctMifareMini: Result := 'MIFARE Mini';
    ctMifare4K: Result := 'MIFARE 4K';
    ctMifareDESFire: Result := 'MIFARE DESFire';
    ctMifarePlus2K: Result := 'MIFARE Plus 2K, 4UID, SL3';
    ctMifarePlus4K: Result := 'MIFARE Plus 4K, 4UID, SL3';
    ctMifarePlus_2K_7UID_SL3: Result := 'MIFARE Plus 2K, 7UID, SL3';
    ctMifarePlus_4K_7UID_SL3: Result := 'MIFARE Plus 4K, 7UID, SL3';
    ctMifarePlus_2K_4UID_SL1: Result := 'MIFARE Plus 2K, 4UID, SL1';
    ctMifarePlus_4K_4UID_SL1: Result := 'MIFARE Plus 4K, 4UID, SL1';
    ctMifarePlus_2K_7UID_SL1: Result := 'MIFARE Plus 2K, 7UID, SL1';
    ctMifarePlus_4K_7UID_SL1: Result := 'MIFARE Plus 4K, 7UID, SL1';

  else
    Result := 'Неизвестный тип карты';
  end;
end;


function SelectCardType(card_atq: Word; card_sak: Byte): TCardType;
begin
  Result := ctUnknown;
  card_atq := card_atq and $3FF;
  card_sak := card_sak and $FB;
  if ((card_atq = $0044) and (card_sak = $00)) then
  begin
    Result := ctMifareUltraLight;
    Exit;
  end;
  // Карты Mifare Plus 2K/EV1 2K, 4 UID, SL3
  if ((card_atq = $0004) and (card_sak = $20)) then
  begin
    Result := ctMifarePlus2K;
    Exit;
  end;
  // Карты Mifare Plus 4K/EV1 4K, 4 UID, SL3
  if ((card_atq = $0002) and (card_sak = $20)) then
  begin
    Result := ctMifarePlus4K;
    Exit;
  end;
  // Карты Mifare Plus 2K/EV1 2K, 7 UID, SL3
  if ((card_atq = $0044) and (card_sak = $20)) then
  begin
    Result := ctMifarePlus_2K_7UID_SL3;
    Exit;
  end;
  // Карты Mifare Plus 4K/EV1 4K, 7 UID, SL3
  if ((card_atq = $0042) and (card_sak = $20)) then
  begin
    Result := ctMifarePlus_4K_7UID_SL3;
    Exit;
  end;
  // Карты Mifare Plus 2K/EV1 2K, 4 UID, SL1
  if ((card_atq = $0004) and (card_sak = $08)) then
  begin
    Result := ctMifarePlus_2K_4UID_SL1;
    Exit;
  end;
  // Карты Mifare Plus 4K/EV1 4K, 4 UID, SL1
  if ((card_atq = $0002) and (card_sak = $18)) then
  begin
    Result := ctMifarePlus_4K_4UID_SL1;
    Exit;
  end;
  // Карты Mifare Plus 2K/EV1 2K, 7 UID, SL1
  if ((card_atq = $0044) and (card_sak = $08)) then
  begin
    Result := ctMifarePlus_2K_7UID_SL1;
    Exit;
  end;
  // Карты Mifare Plus 4K/EV1 4K, 7 UID, SL1
  if ((card_atq = $0042) and (card_sak = $18)) then
  begin
    Result := ctMifarePlus_4K_7UID_SL1;
    Exit;
  end;
  // Карты Mifare 1K
  if ((card_atq = $0004) and (card_sak = $08)) then
  begin
    Result := ctMifare1K;
    Exit;
  end;
  // Карты Mifare Mini
  if ((card_atq = $0004) and (card_sak = $09)) then
  begin
    Result := ctMifareMini;
    Exit;
  end;
  // Карты Mifare 4K
  if ((card_atq = $0002) and (card_sak = $18)) then
  begin
    Result := ctMifare4K;
    Exit;
  end;
  // Карты ctMifareDESFire
  if ((card_atq = $0344) and (card_sak = $20)) then
  begin
    Result := ctMifareDESFire;
    Exit;
  end;
end;


end.
