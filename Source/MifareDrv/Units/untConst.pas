unit untConst;

interface

uses
  // VCL
  Windows, SysUtils,
  // This
  MifareLib_TLB, untError;

const
  MAX_PORT_NUMBER = 256;  // Количество COM портов
  S_DriverName = 'Драйвер считывателей Mifare';

  // Параметры реестра

{$IFNDEF HKLM}
  RegRootKey = HKEY_CURRENT_USER;
{$ELSE}
  RegRootKey = HKEY_LOCAL_MACHINE;
{$ENDIF}

  REGSTR_KEY_DRV                = 'Software\ShtrihM\MifareDrv\';
  REGSTR_VAL_TIMEOUT            = 'Timeout';
  REGSTR_VAL_PARITY             = 'Parity';
  REGSTR_VAL_PORTNUMBER         = 'PortNumber';
  REGSTR_VAL_BAUDRATE           = 'BaudRate';
  REGSTR_VAL_DEVICETYPE         = 'DeviceType';
  REGSTR_VAL_READERNAME         = 'ReaderName';
  REGSTR_VAL_LOGENABLED         = 'LogEnabled';
  REGSTR_VAL_LOGFILENAME        = 'LogFileName';
  REGSTR_VAL_INIFILENAME        = 'IniFileName';
  REGSTR_VAL_ERROR_ON_CORRUPTED = 'ErrorOnCorruptedValueBlock';
  REGSTR_VAL_POLL_ACTIVATE_METHOD = 'PollActivateMethod';

  MODE_USB              = $30;
  MODE_RS232            = $40;
  PICC_REQIDL           = $26; // request idle
  PICC_REQALL           = $52; // request all
  PICC_ANTICOLL1        = $93; // anticollision level 1 106 kBaud
  PICC_ANTICOLL11       = $92; // anticollision level 1 212 kBaud
  PICC_ANTICOLL12       = $94; // anticollision level 1 424 kBaud
  PICC_ANTICOLL13       = $98; // anticollision level 1 848 kBaud
  PICC_ANTICOLL2        = $95; // anticollision level 2
  PICC_ANTICOLL3        = $97; // anticollision level 3
  PICC_AUTHENT1A        = $60; // authentication using key A
  PICC_AUTHENT1B        = $61; // authentication using key B
  PICC_READ16           = $30; // read 16 byte block
  PICC_WRITE16          = $A0; // write 16 byte block
  PICC_WRITE4           = $A2; // write 4 byte block
  PICC_DECREMENT        = $C0; // decrement value
  PICC_INCREMENT        = $C1; // increment value
  PICC_RESTORE          = $C2; // restore command code
  PICC_TRANSFER         = $B0; // transfer command code
  PICC_HALT             = $50; // halt

//////////////////////////////////////////////////////////////////////////////
// Reader Error Codes                   Base Address Start:    = 0;000
//                                      Base Address End:        -999
//////////////////////////////////////////////////////////////////////////////

const
  MIREADER_ERR_BASE_START = 0;

  MI_OK                 = MIREADER_ERR_BASE_START + 0;
  MI_CHK_OK             = MIREADER_ERR_BASE_START + 0;
  MI_CRC_ZERO           = MIREADER_ERR_BASE_START + 0;
// ICODE1 Error   Codes
  I1_OK                 = MIREADER_ERR_BASE_START + 0;
  I1_NO_ERR             = MIREADER_ERR_BASE_START + 0;

  MI_CRC_NOTZERO        = MIREADER_ERR_BASE_START + 1;

  MI_NOTAGERR           = MIREADER_ERR_BASE_START + 1;
  MI_CHK_FAILED         = MIREADER_ERR_BASE_START + 1;
  MI_CRCERR             = MIREADER_ERR_BASE_START + 2;
  MI_CHK_COMPERR        = MIREADER_ERR_BASE_START + 2;
  MI_EMPTY              = MIREADER_ERR_BASE_START + 3;
  MI_AUTHERR            = MIREADER_ERR_BASE_START + 4;
  MI_PARITYERR          = MIREADER_ERR_BASE_START + 5;
  MI_CODEERR            = MIREADER_ERR_BASE_START + 6;

  MI_SERNRERR           = MIREADER_ERR_BASE_START + 8;
  MI_KEYERR             = MIREADER_ERR_BASE_START + 9;
  MI_NOTAUTHERR         = MIREADER_ERR_BASE_START + 10;
  MI_BITCOUNTERR        = MIREADER_ERR_BASE_START + 11;
  MI_BYTECOUNTERR       = MIREADER_ERR_BASE_START + 12;
  MI_IDLE               = MIREADER_ERR_BASE_START + 13;
  MI_TRANSERR           = MIREADER_ERR_BASE_START + 14;
  MI_WRITEERR           = MIREADER_ERR_BASE_START + 15;
  MI_INCRERR            = MIREADER_ERR_BASE_START + 16;
  MI_DECRERR            = MIREADER_ERR_BASE_START + 17;
  MI_READERR            = MIREADER_ERR_BASE_START + 18;
  MI_OVFLERR            = MIREADER_ERR_BASE_START + 19;
  MI_POLLING            = MIREADER_ERR_BASE_START + 20;
  MI_FRAMINGERR         = MIREADER_ERR_BASE_START + 21;
  MI_ACCESSERR          = MIREADER_ERR_BASE_START + 22;
  MI_UNKNOWN_COMMAND    = MIREADER_ERR_BASE_START + 23;
  MI_COLLERR            = MIREADER_ERR_BASE_START + 24;
  MI_RESETERR           = MIREADER_ERR_BASE_START + 25;
  MI_INITERR            = MIREADER_ERR_BASE_START + 25;
  MI_INTERFACEERR       = MIREADER_ERR_BASE_START + 26;
  MI_ACCESSTIMEOUT      = MIREADER_ERR_BASE_START + 27;
  MI_NOBITWISEANTICOLL  = MIREADER_ERR_BASE_START + 28;
  MI_QUIT               = MIREADER_ERR_BASE_START + 30;
  MI_CODINGERR          = MIREADER_ERR_BASE_START + 31;
  MI_SENDBYTENR         = MIREADER_ERR_BASE_START + 51;
  MI_CASCLEVEX          = MIREADER_ERR_BASE_START + 52;
  MI_SENDBUF_OVERFLOW   = MIREADER_ERR_BASE_START + 53;
  MI_BAUDRATE_NOT_SUPPORTED = MIREADER_ERR_BASE_START + 54;
  MI_SAME_BAUDRATE_REQUIRED = MIREADER_ERR_BASE_START + 55;

  MI_WRONG_PARAMETER_VALUE = MIREADER_ERR_BASE_START + 60;
  I1_WRONGPARAM         = MIREADER_ERR_BASE_START + 61;
  I1_NYIMPLEMENTED      = MIREADER_ERR_BASE_START + 62;
  I1_TSREADY            = MIREADER_ERR_BASE_START + 63;

  I1_TIMEOUT            = MIREADER_ERR_BASE_START + 70;
  I1_NOWRITE            = MIREADER_ERR_BASE_START + 71;
  I1_NOHALT             = MIREADER_ERR_BASE_START + 72;
  I1_MISS_ANTICOLL      = MIREADER_ERR_BASE_START + 73;
  I1_COMM_ABORT         = MIREADER_ERR_BASE_START + 82;
  MI_BREAK              = MIREADER_ERR_BASE_START + 99;
  MI_NY_IMPLEMENTED     = MIREADER_ERR_BASE_START + 100;
  MI_NO_MFRC            = MIREADER_ERR_BASE_START + 101;
  MI_MFRC_NOTAUTH       = MIREADER_ERR_BASE_START + 102;
  MI_WRONG_DES_MODE     = MIREADER_ERR_BASE_START + 103;
  MI_HOST_AUTH_FAILED   = MIREADER_ERR_BASE_START + 104;
  MI_WRONG_LOAD_MODE    = MIREADER_ERR_BASE_START + 106;
  MI_WRONG_DESKEY       = MIREADER_ERR_BASE_START + 107;
  MI_MKLOAD_FAILED      = MIREADER_ERR_BASE_START + 108;
  MI_FIFOERR            = MIREADER_ERR_BASE_START + 109;
  MI_WRONG_ADDR         = MIREADER_ERR_BASE_START + 110;
  MI_DESKEYLOAD_FAILED  = MIREADER_ERR_BASE_START + 111;
  MI_RECBUF_OVERFLOW    = MIREADER_ERR_BASE_START + 112;
  MI_WRONG_SEL_CNT      = MIREADER_ERR_BASE_START + 114;
  MI_WRONG_TEST_MODE    = MIREADER_ERR_BASE_START + 117;
  MI_TEST_FAILED        = MIREADER_ERR_BASE_START + 118;
  MI_TOC_ERROR          = MIREADER_ERR_BASE_START + 119;
  MI_COMM_ABORT         = MIREADER_ERR_BASE_START + 120;
  MI_INVALID_BASE       = MIREADER_ERR_BASE_START + 121;
  MI_MFRC_RESET         = MIREADER_ERR_BASE_START + 122;
  MI_WRONG_VALUE        = MIREADER_ERR_BASE_START + 123;
  MI_VALERR             = MIREADER_ERR_BASE_START + 124;
  MI_WRONG_MAC_TOKEN    = MIREADER_ERR_BASE_START + 149;
  MI_WRONG_TOKEN        = MIREADER_ERR_BASE_START + 150;
  MI_NO_VALUE           = MIREADER_ERR_BASE_START + 151;
  MI_MFRC150            = MIREADER_ERR_BASE_START + 152;
  MI_MFRC170            = MIREADER_ERR_BASE_START + 153;
  MI_WRONG_BASEADDR     = MIREADER_ERR_BASE_START + 180;
  MI_NO_ERROR_TEXT_AVAIL = MIREADER_ERR_BASE_START + 199;
  MI_DRIVER_FAILURE     = MIREADER_ERR_BASE_START + 254;
  MI_INTERFACE_FAILURE  = MIREADER_ERR_BASE_START + 255;
  MI_PROTOCOL_FAILURE   = MIREADER_ERR_BASE_START + 256;
  MI_SERERR             = MIREADER_ERR_BASE_START + 260;
  MI_CALLOPEN           = MIREADER_ERR_BASE_START + 261;
  MI_RESERVED_BUFFER_OVERFLOW = MIREADER_ERR_BASE_START + 262;
  READER_ERR_BASE_END   = MIREADER_ERR_BASE_START + 999;

  // команды для карт
  CMD_PCDCONFIG                 = #2;
  CMD_PCDSETDEFAULTATTRIB       = #3;
  CMD_REQUEST                   = #4;
  CMD_ANTICOLL                  = #5;
  CMD_SELECT                    = #6;
  CMD_ACTIVATEIDLE              = #7;
  CMD_ACTIVATEIDLELOOP          = #8;
  CMD_ACTIVATEWAKEUP            = #9;
  CMD_AUTH                      = #$0A;
  CMD_LOADE2                    = #$0B;
  CMD_AUTHKEY                   = #$0C;
  CMD_PICCREAD                  = #$0D;
  CMD_PICCWRITE                 = #$0E;
  CMD_PICCVALUE                 = #$0F;
  CMD_PICCVALUEDEBIT            = #$10;
  CMD_PICCEXCHANGE              = #$11;
  CMD_AUTHE2                    = #$12;
  CMD_PICCHALT                  = #$13;

  // команды для ридера
  CMD_PCDSETTMO                 = #$14;
  CMD_PCDGETSNR                 = #$15;
  CMD_PCDGETFWVERSION           = #$16;
  CMD_PCDGETRICVERSION          = #$17;
  CMD_PCDREADE2                 = #$18;
  CMD_PCDWRITEE2                = #$19;
  CMD_PCDRFRESET                = #$1A;
  CMD_PCDWRITERIC               = #$1B;
  CMD_PCDREADRIC                = #$1C;
  CMD_PCDWRITEMULT              = #$1D;
  CMD_PCDREADMULT               = #$1E;
  CMD_PCDRESET                  = #$1F;
  CMD_PCDBEEP                   = #$20;

  CMD_CTRLLEDANDPOLL            = #$F0;
  CMD_CTRLLED                   = #$F2;
  CMD_POLLBUTTON                = #$F3;

  // дополнительные команды от MicleSoft
  CMD_MKSREOPEN                 = #$30; // выбирает последнюю карту
  CMD_MKSREADCATALOG            = #$31; // считывает каталог карты
  CMD_MKSFINDCARD               = #$32; // поиск и выбор карты указанного типа
  CMD_MKSWRITECATALOG           = #$33; // записывает каталог на карту

  // Write Key for AuthHost SAM AV2
  // Запись ключа авторизации SAM модуля
  CMD_SAM_WRITE_AUTH_KEY        = #$34;

  // Get key entry
  // Получить параметры записи ключа
  CMD_SAM_READ_AUTH_KEY         = #$35;

  // Get Full Serial Number
  // Получить полный серийный номер считывателя
  CMD_READ_READER_SERIAL        = #$36;

  // Set protection on SAM AV2 module
  // Установить/включить защиту SAM модуля установленного в считыватель
  CMD_SAM_ENABLE_PROTECTION     = #$37;

  // Set protection on SAM AV2 module with external serial number
  // Установить/включить защиту SAM модуля с использованием присланного серийного номера
  CMD_SAM_ENABLE_PROTECTION_SN  = #$38;


function GetErrorSymbol(Code: Integer): string;
function GetResultDescription(Code: Int64): string;

implementation


{ Получение символического обозначения кода ошибки }

function GetErrorSymbol(Code: Integer): string;
begin
  case Code of
    MI_OK                       : Result := 'MI_OK';
    MI_NOTAGERR                 : Result := 'MI_NOTAGERR';
    MI_CRCERR                   : Result := 'MI_CRCERR';
    MI_EMPTY                    : Result := 'MI_EMPTY';
    MI_AUTHERR                  : Result := 'MI_AUTHERR';
    MI_PARITYERR                : Result := 'MI_PARITYERR';
    MI_CODEERR                  : Result := 'MI_CODEERR';
    MI_SERNRERR                 : Result := 'MI_SERNRERR';
    MI_KEYERR                   : Result := 'MI_KEYERR';
    MI_NOTAUTHERR               : Result := 'MI_NOTAUTHERR';
    MI_BITCOUNTERR              : Result := 'MI_BITCOUNTERR';
    MI_BYTECOUNTERR             : Result := 'MI_BYTECOUNTERR';
    MI_IDLE                     : Result := 'MI_IDLE';
    MI_TRANSERR                 : Result := 'MI_TRANSERR';
    MI_WRITEERR                 : Result := 'MI_WRITEERR';
    MI_INCRERR                  : Result := 'MI_INCRERR';
    MI_DECRERR                  : Result := 'MI_DECRERR';
    MI_READERR                  : Result := 'MI_READERR';
    MI_OVFLERR                  : Result := 'MI_OVFLERR';
    MI_POLLING                  : Result := 'MI_POLLING';
    MI_FRAMINGERR               : Result := 'MI_FRAMINGERR';
    MI_ACCESSERR                : Result := 'MI_ACCESSERR';
    MI_UNKNOWN_COMMAND          : Result := 'MI_UNKNOWN_COMMAND';
    MI_COLLERR                  : Result := 'MI_COLLERR';
    MI_RESETERR                 : Result := 'MI_RESETERR';
    MI_INTERFACEERR             : Result := 'MI_INTERFACEERR';
    MI_ACCESSTIMEOUT            : Result := 'MI_ACCESSTIMEOUT';
    MI_NOBITWISEANTICOLL        : Result := 'MI_NOBITWISEANTICOLL';
    MI_QUIT                     : Result := 'MI_QUIT';
    MI_CODINGERR                : Result := 'MI_CODINGERR';
    MI_SENDBYTENR               : Result := 'MI_SENDBYTENR';
    MI_CASCLEVEX                : Result := 'MI_CASCLEVEX';
    MI_SENDBUF_OVERFLOW         : Result := 'MI_SENDBUF_OVERFLOW';
    MI_BAUDRATE_NOT_SUPPORTED   : Result := 'MI_BAUDRATE_NOT_SUPPORTED';
    MI_SAME_BAUDRATE_REQUIRED   : Result := 'MI_SAME_BAUDRATE_REQUIRED';
    MI_WRONG_PARAMETER_VALUE    : Result := 'MI_WRONG_PARAMETER_VALUE';
    I1_WRONGPARAM               : Result := 'I1_WRONGPARAM';
    I1_NYIMPLEMENTED            : Result := 'I1_NYIMPLEMENTED';
    I1_TSREADY                  : Result := 'I1_TSREADY';
    I1_TIMEOUT                  : Result := 'I1_TIMEOUT';
    I1_NOWRITE                  : Result := 'I1_NOWRITE';
    I1_NOHALT                   : Result := 'I1_NOHALT';
    I1_MISS_ANTICOLL            : Result := 'I1_MISS_ANTICOLL';
    I1_COMM_ABORT               : Result := 'I1_COMM_ABORT';
    MI_BREAK                    : Result := 'MI_BREAK';
    MI_NY_IMPLEMENTED           : Result := 'MI_NY_IMPLEMENTED';
    MI_NO_MFRC                  : Result := 'MI_NO_MFRC';
    MI_MFRC_NOTAUTH             : Result := 'MI_MFRC_NOTAUTH';
    MI_WRONG_DES_MODE           : Result := 'MI_WRONG_DES_MODE';
    MI_HOST_AUTH_FAILED         : Result := 'MI_HOST_AUTH_FAILED';
    MI_WRONG_LOAD_MODE          : Result := 'MI_WRONG_LOAD_MODE';
    MI_WRONG_DESKEY             : Result := 'MI_WRONG_DESKEY';
    MI_MKLOAD_FAILED            : Result := 'MI_MKLOAD_FAILED';
    MI_FIFOERR                  : Result := 'MI_FIFOERR';
    MI_WRONG_ADDR               : Result := 'MI_WRONG_ADDR';
    MI_DESKEYLOAD_FAILED        : Result := 'MI_DESKEYLOAD_FAILED';
    MI_RECBUF_OVERFLOW          : Result := 'MI_RECBUF_OVERFLOW';
    MI_WRONG_SEL_CNT            : Result := 'MI_WRONG_SEL_CNT';
    MI_WRONG_TEST_MODE          : Result := 'MI_WRONG_TEST_MODE';
    MI_TEST_FAILED              : Result := 'MI_TEST_FAILED';
    MI_TOC_ERROR                : Result := 'MI_TOC_ERROR';
    MI_COMM_ABORT               : Result := 'MI_COMM_ABORT';
    MI_INVALID_BASE             : Result := 'MI_INVALID_BASE';
    MI_MFRC_RESET               : Result := 'MI_MFRC_RESET';
    MI_WRONG_VALUE              : Result := 'MI_WRONG_VALUE';
    MI_VALERR                   : Result := 'MI_VALERR';
    MI_WRONG_MAC_TOKEN          : Result := 'MI_WRONG_MAC_TOKEN';
    MI_WRONG_TOKEN              : Result := 'MI_WRONG_TOKEN';
    MI_NO_VALUE                 : Result := 'MI_NO_VALUE';
    MI_MFRC150                  : Result := 'MI_MFRC150';
    MI_MFRC170                  : Result := 'MI_MFRC170';
    MI_WRONG_BASEADDR           : Result := 'MI_WRONG_BASEADDR';
    MI_NO_ERROR_TEXT_AVAIL      : Result := 'MI_NO_ERROR_TEXT_AVAIL';
    MI_DRIVER_FAILURE           : Result := 'MI_DRIVER_FAILURE';
    MI_INTERFACE_FAILURE        : Result := 'MI_INTERFACE_FAILURE';
    MI_PROTOCOL_FAILURE         : Result := 'MI_PROTOCOL_FAILURE';
    MI_SERERR                   : Result := 'MI_SERERR';
    MI_CALLOPEN                 : Result := 'MI_CALLOPEN';
    MI_RESERVED_BUFFER_OVERFLOW : Result := 'MI_RESERVED_BUFFER_OVERFLOW';
  else
    Result := Format('Ошибка: %d', [Code]);
  end;
end;

{ Получение пазвание ошибки }

function GetResultDescription(Code: Int64): string;
begin
  case Code of
    MI_OK                       : Result := 'Ошибок нет';
    MI_NOTAGERR                 : Result := 'Нет карты';
    MI_CRCERR                   : Result := 'Ошибка CRC';
    MI_EMPTY                    : Result := 'MI_EMPTY';
    MI_AUTHERR                  : Result := 'Ошибка авторизации доступа';
    MI_PARITYERR                : Result := 'Ошибка контроля четности';
    MI_CODEERR                  : Result := 'Ошибка передачи';
    MI_SERNRERR                 : Result := 'Ошибка приема номера карты';
    MI_KEYERR                   : Result := 'Ошибка загрузки ключа';
    MI_NOTAUTHERR               : Result := 'Ошибка при чтении без авторизации';
    MI_BITCOUNTERR              : Result := 'Принято неверное число битов';
    MI_BYTECOUNTERR             : Result := 'Принято неверное число байтов';
    MI_IDLE                     : Result := 'MI_IDLE';
    MI_TRANSERR                 : Result := 'Ошибка копирования';
    MI_WRITEERR                 : Result := 'Ошибка записи';
    MI_INCRERR                  : Result := 'Ошибка инкремента';
    MI_DECRERR                  : Result := 'Ошибка декремента';
    MI_READERR                  : Result := 'Ошибка чтения';
    MI_OVFLERR                  : Result := 'Переполнение буфера FIFO ридера';
    MI_POLLING                  : Result := 'Ошибок нет';
    MI_FRAMINGERR               : Result := 'Ошибка кадра';
    MI_ACCESSERR                : Result := 'Ошибка доступа';
    MI_UNKNOWN_COMMAND          : Result := 'Неизвестная команда';
    MI_COLLERR                  : Result := 'Неисправимая коллизия';
    MI_RESETERR                 : Result := 'Ошибка сброса';
    MI_INTERFACEERR             : Result := 'Нет связи';
    MI_ACCESSTIMEOUT            : Result := 'Таймаут доступа';
    MI_NOBITWISEANTICOLL        : Result := 'Карта не поддерживает антиколлизию';
    MI_QUIT                     : Result := 'MI_QUIT';
    MI_CODINGERR                : Result := 'Ошибка формата передачи';
    MI_SENDBYTENR               : Result := 'MI_SENDBYTENR';
    MI_CASCLEVEX                : Result := 'Превышен уровень каскадирования (больше 3)';
    MI_SENDBUF_OVERFLOW         : Result := 'Переполнение буфера отправки';
    MI_BAUDRATE_NOT_SUPPORTED   : Result := 'Карта не поддерживает скорость';
    MI_SAME_BAUDRATE_REQUIRED   : Result := 'MI_SAME_BAUDRATE_REQUIRED';
    MI_WRONG_PARAMETER_VALUE    : Result := 'Неверное значение параметра';
    I1_WRONGPARAM               : Result := 'I1_WRONGPARAM';
    I1_NYIMPLEMENTED            : Result := 'I1_NYIMPLEMENTED';
    I1_TSREADY                  : Result := 'I1_TSREADY';
    I1_TIMEOUT                  : Result := 'I1_TIMEOUT';
    I1_NOWRITE                  : Result := 'I1_NOWRITE';
    I1_NOHALT                   : Result := 'I1_NOHALT';
    I1_MISS_ANTICOLL            : Result := 'I1_MISS_ANTICOLL';
    I1_COMM_ABORT               : Result := 'I1_COMM_ABORT';
    MI_BREAK                    : Result := 'MI_BREAK';
    MI_NY_IMPLEMENTED           : Result := 'Обработка ошибки не реализована';
    MI_NO_MFRC                  : Result := 'MI_NO_MFRC';
    MI_MFRC_NOTAUTH             : Result := 'MI_MFRC_NOTAUTH';
    MI_WRONG_DES_MODE           : Result := 'MI_WRONG_DES_MODE';
    MI_HOST_AUTH_FAILED         : Result := 'MI_HOST_AUTH_FAILED';
    MI_WRONG_LOAD_MODE          : Result := 'MI_WRONG_LOAD_MODE';
    MI_WRONG_DESKEY             : Result := 'MI_WRONG_DESKEY';
    MI_MKLOAD_FAILED            : Result := 'MI_MKLOAD_FAILED';
    MI_FIFOERR                  : Result := 'MI_FIFOERR';
    MI_WRONG_ADDR               : Result := 'MI_WRONG_ADDR';
    MI_DESKEYLOAD_FAILED        : Result := 'MI_DESKEYLOAD_FAILED';
    MI_RECBUF_OVERFLOW          : Result := 'Переполнен буфер приема';
    MI_WRONG_SEL_CNT            : Result := 'MI_WRONG_SEL_CNT';
    MI_WRONG_TEST_MODE          : Result := 'MI_WRONG_TEST_MODE';
    MI_TEST_FAILED              : Result := 'MI_TEST_FAILED';
    MI_TOC_ERROR                : Result := 'MI_TOC_ERROR';
    MI_COMM_ABORT               : Result := 'MI_COMM_ABORT';
    MI_INVALID_BASE             : Result := 'MI_INVALID_BASE';
    MI_MFRC_RESET               : Result := 'MI_MFRC_RESET';
    MI_WRONG_VALUE              : Result := 'MI_WRONG_VALUE';
    MI_VALERR                   : Result := 'Ошибка в value-блоке';
    MI_WRONG_MAC_TOKEN          : Result := 'MI_WRONG_MAC_TOKEN';
    MI_WRONG_TOKEN              : Result := 'MI_WRONG_TOKEN';
    MI_NO_VALUE                 : Result := 'MI_NO_VALUE';
    MI_MFRC150                  : Result := 'MI_MFRC150';
    MI_MFRC170                  : Result := 'MI_MFRC170';
    MI_WRONG_BASEADDR           : Result := 'MI_WRONG_BASEADDR';
    MI_NO_ERROR_TEXT_AVAIL      : Result := 'MI_NO_ERROR_TEXT_AVAIL';
    MI_DRIVER_FAILURE           : Result := 'MI_DRIVER_FAILURE';
    MI_INTERFACE_FAILURE        : Result := 'MI_INTERFACE_FAILURE';
    MI_PROTOCOL_FAILURE         : Result := 'MI_PROTOCOL_FAILURE';
    MI_SERERR                   : Result := 'MI_SERERR';
    MI_CALLOPEN                 : Result := 'MI_CALLOPEN';
    MI_RESERVED_BUFFER_OVERFLOW : Result := 'MI_RESERVED_BUFFER_OVERFLOW';
    E_UNKNOWNERROR              : Result := S_UNKNOWNERROR;
    Integer(E_BLOCKDATA)        : Result := S_BLOCKDATA;
    E_COM_ACCESS_DENIED         : Result := S_COM_ACCESS_DENIED;
    E_COM_PORT_NOT_FOUND        : Result := S_COM_PORT_NOT_FOUND;
    E_COM_WRITE_ERROR           : Result := S_COM_WRITE_ERROR;
    E_INVALID_FRAME             : Result := S_INVALID_FRAME;
    E_ANSWER_LENGTH             : Result := S_ANSWER_LENGTH;
    E_INVALID_CS                : Result := S_INVALID_CS;
  else
    Result := Format('Ошибка: %d', [Code]);
  end;
end;

///////////////////////////////////////////////////////////////////////////////
// #$30; // SAM get version


end.
