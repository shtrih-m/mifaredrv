unit SCardSyn;


interface

uses
  // VCL
  Windows, SysUtils,
  // This
  WinSCard;


const
////////////////////////////////////////
// Eventlog categories
//
// Categories always have to be the first entries in a message file!
//
//
//  Values are 32 bit values layed out as follows:
//
//   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
//   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
//  +---+-+-+-----------------------+-------------------------------+
//  |Sev|C|R|     Facility          |               Code            |
//  +---+-+-+-----------------------+-------------------------------+
//
//  where
//
//      Sev - is the severity code
//
//          00 - Success
//          01 - Informational
//          10 - Warning
//          11 - Error
//
//      C - is the Customer code flag
//
//      R - is a reserved bit
//
//      Facility - is the facility code
//
//      Code - is the facility's status code
//
//
// Define the facility codes
//


//
// Define the severity codes
//


//
// MessageId: OKERR_STANDARD_LIMIT
//
// MessageText:
//
//  Module specific error codes may be defined above this limit
//
  OKERR_STANDARD_LIMIT             = $82000000;

//
// MessageId: OKERR_PARM1
//
// MessageText:
//
//  Error in parameter 1
//
  OKERR_PARM1                      = $81000000;

//
// MessageId: OKERR_PARM2
//
// MessageText:
//
//  Error in parameter 2
//
  OKERR_PARM2                      = $81000001;

//
// MessageId: OKERR_PARM3
//
// MessageText:
//
//  Error in parameter 3
//
  OKERR_PARM3                      = $81000002;

//
// MessageId: OKERR_PARM4
//
// MessageText:
//
//  Error in parameter 4
//
  OKERR_PARM4                      = $81000003;

//
// MessageId: OKERR_PARM5
//
// MessageText:
//
//  Error in parameter 5
//
  OKERR_PARM5                      = $81000004;

//
// MessageId: OKERR_PARM6
//
// MessageText:
//
//  Error in parameter 6
//
  OKERR_PARM6                      = $81000005;

//
// MessageId: OKERR_PARM7
//
// MessageText:
//
//  Error in parameter 7
//
  OKERR_PARM7                      = $81000006;

//
// MessageId: OKERR_PARM8
//
// MessageText:
//
//  Error in parameter 8
//
  OKERR_PARM8                      = $81000007;

//
// MessageId: OKERR_PARM9
//
// MessageText:
//
//  Error in parameter 9
//
  OKERR_PARM9                      = $81000008;

//
// MessageId: OKERR_PARM10
//
// MessageText:
//
//  Error in parameter 10
//
  OKERR_PARM10                     = $81000009;

//
// MessageId: OKERR_PARM11
//
// MessageText:
//
//  Error in parameter 11
//
  OKERR_PARM11                     = $8100000A;

//
// MessageId: OKERR_PARM12
//
// MessageText:
//
//  Error in parameter 12
//
  OKERR_PARM12                     = $8100000B;

//
// MessageId: OKERR_PARM13
//
// MessageText:
//
//  Error in parameter 13
//
  OKERR_PARM13                     = $8100000C;

//
// MessageId: OKERR_PARM14
//
// MessageText:
//
//  Error in parameter 14
//
  OKERR_PARM14                     = $8100000D;

//
// MessageId: OKERR_PARM15
//
// MessageText:
//
//  Error in parameter 15
//
  OKERR_PARM15                     = $8100000E;

//
// MessageId: OKERR_PARM16
//
// MessageText:
//
//  Error in parameter 16
//
  OKERR_PARM16                     = $8100000F;

//
// MessageId: OKERR_PARM17
//
// MessageText:
//
//  Error in parameter 17
//
  OKERR_PARM17                     = $81000010;

//
// MessageId: OKERR_PARM18
//
// MessageText:
//
//  Error in parameter 18
//
  OKERR_PARM18                     = $81000011;

//
// MessageId: OKERR_PARM19
//
// MessageText:
//
//  Error in parameter 19
//
  OKERR_PARM19                     = $81000012;

////////////////////////////////////////
// OkPassword
//
// MessageId: OKERR_INSUFFICIENT_PRIV
//
// MessageText:
//
//  You currently do not have the rights to execute the requested action.
//  Usually a password has to be presented in advance
//
  OKERR_INSUFFICIENT_PRIV          = $81100000;

//
// MessageId: OKERR_PW_WRONG
//
// MessageText:
//
//  The presented password is wrong
//
  OKERR_PW_WRONG                   = $81100001;

//
// MessageId: OKERR_PW_LOCKED
//
// MessageText:
//
//  The password has been presented several
//  times wrong and is therefore locked.
//  Usually use some administrator tool to unblock it
//
  OKERR_PW_LOCKED                  = $81100002;

//
// MessageId: OKERR_PW_TOO_SHORT
//
// MessageText:
//
//  The lenght of the password was too short
//
  OKERR_PW_TOO_SHORT               = $81100003;

//
// MessageId: OKERR_PW_TOO_LONG
//
// MessageText:
//
//  The length of the password was too long
//
  OKERR_PW_TOO_LONG                = $81100004;

//
// MessageId: OKERR_PW_NOT_LOCKED
//
// MessageText:
//
//  The password is not locked
//
  OKERR_PW_NOT_LOCKED              = $81100005;

////////////////////////////////////////
// OkItem errors
//
// MessageId: OKERR_ITEM_NOT_FOUND
//
// MessageText:
//
//  An item could not be found
//
  OKERR_ITEM_NOT_FOUND             = $81200000;

//
// MessageId: OKERR_ITEMS_LEFT
//
// MessageText:
//
//  Directory is not empty and can not be deleted
//
  OKERR_ITEMS_LEFT                 = $81200001;

//
// MessageId: OKERR_INVALID_CFG_FILE
//
// MessageText:
//
//  Invalid configuration file
//
  OKERR_INVALID_CFG_FILE           = $81200002;

//
// MessageId: OKERR_SECTION_NOT_FOUND
//
// MessageText:
//
//  Section not found
//
  OKERR_SECTION_NOT_FOUND          = $81200003;

//
// MessageId: OKERR_ENTRY_NOT_FOUND
//
// MessageText:
//
//  Entry not found
//
  OKERR_ENTRY_NOT_FOUND            = $81200004;

//
// MessageId: OKERR_NO_MORE_SECTIONS
//
// MessageText:
//
//  No more sections
//
  OKERR_NO_MORE_SECTIONS           = $81200005;

//
// MessageId: OKERR_ITEM_ALREADY_EXISTS
//
// MessageText:
//
//  The specified item alread exists
//
  OKERR_ITEM_ALREADY_EXISTS        = $81200006;

//
// MessageId: OKERR_ITEM_EXPIRED
//
// MessageText:
//
//  Some item has expired
//
  OKERR_ITEM_EXPIRED               = $81200007;

////////////////////////////////////////
// OkGeneral
//
// MessageId: OKERR_UNEXPECTED_RET_VALUE
//
// MessageText:
//
//  Unexpected return value
//
  OKERR_UNEXPECTED_RET_VALUE       = $81300000;

//
// MessageId: OKERR_COMMUNICATE
//
// MessageText:
//
//  General communication error
//
  OKERR_COMMUNICATE                = $81300001;

//
// MessageId: OKERR_NOT_ENOUGH_MEMORY
//
// MessageText:
//
//  Not enough memory
//
  OKERR_NOT_ENOUGH_MEMORY          = $81300002;

//
// MessageId: OKERR_BUFFER_OVERFLOW
//
// MessageText:
//
//  Buffer overflow
//
  OKERR_BUFFER_OVERFLOW            = $81300003;

//
// MessageId: OKERR_TIMEOUT
//
// MessageText:
//
//  A timeout has occurred
//
  OKERR_TIMEOUT                    = $81300004;

//
// MessageId: OKERR_NOT_SUPPORTED
//
// MessageText:
//
//  The requested functionality is not supported
//
  OKERR_NOT_SUPPORTED              = $81300005;

//
// MessageId: OKERR_ILLEGAL_ARGUMENT
//
// MessageText:
//
//  Illegal argument
//
  OKERR_ILLEGAL_ARGUMENT           = $81300006;

//
// MessageId: OKERR_READ_FIO
//
// MessageText:
//
//  File IO read error
//
  OKERR_READ_FIO                   = $81300007;

//
// MessageId: OKERR_WRITE_FIO
//
// MessageText:
//
//  File IO write error
//
  OKERR_WRITE_FIO                  = $81300008;

//
// MessageId: OKERR_INVALID_HANDLE
//
// MessageText:
//
//  Invalid handle
//
  OKERR_INVALID_HANDLE             = $81300009;

//
// MessageId: OKERR_GENERAL_FAILURE
//
// MessageText:
//
//  General failure
//
  OKERR_GENERAL_FAILURE            = $8130000A;

//
// MessageId: OKERR_FILE_NOT_FOUND
//
// MessageText:
//
//  File not found
//
  OKERR_FILE_NOT_FOUND             = $8130000B;

//
// MessageId: OKERR_OPEN_FILE
//
// MessageText:
//
//  File opening failed
//
  OKERR_OPEN_FILE                  = $8130000C;

//
// MessageId: OKERR_SEM_USED
//
// MessageText:
//
//  The semaphore is currently use by an other process
//
  OKERR_SEM_USED                   = $8130000D;

////////////////////////////////////////
// OkGeneralBack
// General errors for backwards compatibility   = $81F0000                */
//
// MessageId: OKERR_NOP
//
// MessageText:
//
//  No operation done
//
  OKERR_NOP                        = $81F00001;

//
// MessageId: OKERR_NOK
//
// MessageText:
//
//  Function not executed
//
  OKERR_NOK                        = $81F00002;

//
// MessageId: OKERR_FWBUG
//
// MessageText:
//
//  Internal error detected
//
  OKERR_FWBUG                      = $81F00003;

//
// MessageId: OKERR_INIT
//
// MessageText:
//
//  Module not initialized
//
  OKERR_INIT                       = $81F00004;

//
// MessageId: OKERR_FIO
//
// MessageText:
//
//  File IO error detected
//
  OKERR_FIO                        = $81F00005;

//
// MessageId: OKERR_ALLOC
//
// MessageText:
//
//  Cannot allocate memory
//
  OKERR_ALLOC                      = $81F00006;

//
// MessageId: OKERR_SESSION_ERR
//
// MessageText:
//
//  General error
//
  OKERR_SESSION_ERR                = $81F00007;

//
// MessageId: OKERR_ACCESS_ERR
//
// MessageText:
//
//  Access not allowed
//
  OKERR_ACCESS_ERR                 = $81F00008;

//
// MessageId: OKERR_OPEN_FAILURE
//
// MessageText:
//
//  An open command was not successful
//
  OKERR_OPEN_FAILURE               = $81F00009;

//
// MessageId: OKERR_CARD_NOT_POWERED
//
// MessageText:
//
//  Card is not powered
//
  OKERR_CARD_NOT_POWERED           = $81F0000A;

//
// MessageId: OKERR_ILLEGAL_CARDTYPE
//
// MessageText:
//
//  Illegal cardtype
//
  OKERR_ILLEGAL_CARDTYPE           = $81F0000B;

//
// MessageId: OKERR_CARD_NOT_INSERTED
//
// MessageText:
//
//  Card not inserted
//
  OKERR_CARD_NOT_INSERTED          = $81F0000C;

//
// MessageId: OKERR_NO_DRIVER
//
// MessageText:
//
//  No device driver installed
//
  OKERR_NO_DRIVER                  = $81F0000D;

//
// MessageId: OKERR_OUT_OF_SERVICE
//
// MessageText:
//
//  The service is currently not available
//
  OKERR_OUT_OF_SERVICE             = $81F0000E;

//
// MessageId: OKERR_EOF_REACHED
//
// MessageText:
//
//  End of file reached
//
  OKERR_EOF_REACHED                = $81F0000F;

//
// MessageId: OKERR_ON_BLACKLIST
//
// MessageText:
//
//  The ID is on a blacklist, the requested action is therefore not allowed
//
  OKERR_ON_BLACKLIST               = $81F00010;

//
// MessageId: OKERR_CONSISTENCY_CHECK
//
// MessageText:
//
//  Error during consistency check
//
  OKERR_CONSISTENCY_CHECK          = $81F00011;

//
// MessageId: OKERR_IDENTITY_MISMATCH
//
// MessageText:
//
//  The identity does not match a defined cross-check identity
//
  OKERR_IDENTITY_MISMATCH          = $81F00012;

//
// MessageId: OKERR_MULTIPLE_ERRORS
//
// MessageText:
//
//  Multiple errors have occurred
//
  OKERR_MULTIPLE_ERRORS            = $81F00013;

//
// MessageId: OKERR_ILLEGAL_DRIVER
//
// MessageText:
//
//  Illegal driver
//
  OKERR_ILLEGAL_DRIVER             = $81F00014;

//
// MessageId: OKERR_ILLEGAL_FW_RELEASE
//
// MessageText:
//
//  The connected hardware whose firmware is not useable by this software
//
  OKERR_ILLEGAL_FW_RELEASE         = $81F00015;

//
// MessageId: OKERR_NO_CARDREADER
//
// MessageText:
//
//  No cardreader attached
//
  OKERR_NO_CARDREADER              = $81F00016;

//
// MessageId: OKERR_IPC_FAULT
//
// MessageText:
//
//  General failure of inter process communication
//
  OKERR_IPC_FAULT                  = $81F00017;

//
// MessageId: OKERR_WAIT_AND_RETRY
//
// MessageText:
//
//  The service currently does not take calls
//
  OKERR_WAIT_AND_RETRY             = $81F00018;


function SCardCLWriteMifareKeyToReader(
                        ulHandleCard: SCARDHANDLE;              // IN
                        hContext: SCARDCONTEXT;                 // IN
                        pcCardReader: PCHAR;                    // IN
                        ulMifareKeyNr: ULONG;                   // IN
                        ulMifareKeyLen: ULONG;                  // IN
                        pucMifareKey: PUCHAR;                   // IN
                        fSecuredTransmission: BOOLEAN;          // IN
                        ulEncryptionKeyNr: ULONG                // IN
                        ): Integer; stdcall;

function SCardCLGetUID(
                         ulHandleCard: SCARDHANDLE;             // IN
                         pucUID: PUCHAR;                        // IN OUT
                         ulUIDBufLen: ULONG;                    // IN
                         var pulnByteUID: ULONG                 // IN OUT
                         ): Integer; stdcall;

function SCardCLMifareStdAuthent(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        ucMifareAuthMode: UCHAR;        // IN
                        ucMifareAccessType: UCHAR;      // IN
                        ucMifareKeyNr: UCHAR;           // IN
                        pucMifareKey: PUCHAR;           // IN
                        ulMifareKeyLen: ULONG           // IN
                        ): Integer; stdcall;

function SCardCLMifareStdRead(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataRead: PUCHAR;      // IN OUT
                        ulMifareDataReadBufLen: ULONG;  // IN
                        pulMifareNumOfDataRead: PULONG  // IN OUT
                        ): Integer; stdcall;

function SCardCLMifareStdWrite(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataWrite: PUCHAR;     // IN
                        ulMifareDataWriteBufLen: ULONG  // IN
                        ): Integer; stdcall;

function SCardCLMifareLightWrite(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataWrite: PUCHAR;     // IN
                        ulMifareDataWriteBufLen: ULONG  // IN
                        ): Integer; stdcall;

function SCardCLMifareStdIncrementVal(
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareBlockNr: ULONG;                 // IN
                        pucMifareIncrementValue: PUCHAR;        // IN
                        ulMifareIncrementValueBufLen: ULONG     // IN
                        ): Integer; stdcall;

function SCardCLMifareStdDecrementVal(
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareBlockNr: ULONG;                 // IN
                        pucMifareDecrementValue: PUCHAR;        // IN
                        ulMifareDecrementValueBufLen: ULONG     // IN
                        ): Integer; stdcall;

function SCardCLMifareStdRestoreVal(
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareOldBlockNr: ULONG;              // IN
                        ulMifareNewBlockNr: ULONG;              // IN
                        fMifareSameSector: BOOLEAN;             // IN
                        ucMifareAuthModeForNewBlock: UCHAR;     // IN
                        ucMifareAccessTypeForNewBlock: UCHAR;   // IN
                        ucMifareKeyNrForNewBlock: UCHAR;        // IN
                        pucMifareKeyForNewBlock: PUCHAR;        // IN
                        ulMifareKeyLenForNewBlock: ULONG        // IN
                        ): Integer; stdcall;


function SCardCLICCTransmit(
                        ulHandleCard: SCARDHANDLE;              // IN
                        pucSendData: PUCHAR;                    // IN
                        ulSendDataBufLen: ULONG;                // IN
                        pucReceivedData: PUCHAR;                // IN OUT
                        pulReceivedDataBufLen: PULONG           // IN OUT
                        ): Integer; stdcall;


implementation

{$R *.res}

const
  SCardSyncDll = 'scardsyn.dll';

type
  TSCardCLWriteMifareKeyToReader = function(
                        ulHandleCard: SCARDHANDLE;              // IN
                        hContext: SCARDCONTEXT;                 // IN
                        pcCardReader: PCHAR;                    // IN
                        ulMifareKeyNr: ULONG;                   // IN
                        ulMifareKeyLen: ULONG;                  // IN
                        pucMifareKey: PUCHAR;                   // IN
                        fSecuredTransmission: BOOLEAN;          // IN
                        ulEncryptionKeyNr: ULONG                // IN
                        ): Integer; stdcall;

  TSCardCLGetUID = function(
                         ulHandleCard: SCARDHANDLE;             // IN
                         pucUID: PUCHAR;                        // IN OUT
                         ulUIDBufLen: ULONG;                    // IN
                         var pulnByteUID: ULONG                 // IN OUT
                         ): Integer; stdcall;

  TSCardCLMifareStdAuthent = function (
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        ucMifareAuthMode: UCHAR;        // IN
                        ucMifareAccessType: UCHAR;      // IN
                        ucMifareKeyNr: UCHAR;           // IN
                        pucMifareKey: PUCHAR;           // IN
                        ulMifareKeyLen: ULONG           // IN
                        ): Integer; stdcall;

  TSCardCLMifareStdRead = function (
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataRead: PUCHAR;      // IN OUT
                        ulMifareDataReadBufLen: ULONG;  // IN
                        pulMifareNumOfDataRead: PULONG  // IN OUT
                        ): Integer; stdcall;

  TSCardCLMifareStdWrite = function (
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataWrite: PUCHAR;     // IN
                        ulMifareDataWriteBufLen: ULONG  // IN
                        ): Integer; stdcall;

  TSCardCLMifareLightWrite = function (
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataWrite: PUCHAR;     // IN
                        ulMifareDataWriteBufLen: ULONG  // IN
                        ): Integer; stdcall;

  TSCardCLMifareStdIncrementVal = function (
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareBlockNr: ULONG;                 // IN
                        pucMifareIncrementValue: PUCHAR;        // IN
                        ulMifareIncrementValueBufLen: ULONG     // IN
                        ): Integer; stdcall;

  TSCardCLMifareStdDecrementVal = function (
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareBlockNr: ULONG;                 // IN
                        pucMifareDecrementValue: PUCHAR;        // IN
                        ulMifareDecrementValueBufLen: ULONG     // IN
                        ): Integer; stdcall;

  TSCardCLMifareStdRestoreVal = function (
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareOldBlockNr: ULONG;              // IN
                        ulMifareNewBlockNr: ULONG;              // IN
                        fMifareSameSector: BOOLEAN;             // IN
                        ucMifareAuthModeForNewBlock: UCHAR;     // IN
                        ucMifareAccessTypeForNewBlock: UCHAR;   // IN
                        ucMifareKeyNrForNewBlock: UCHAR;        // IN
                        pucMifareKeyForNewBlock: PUCHAR;        // IN
                        ulMifareKeyLenForNewBlock: ULONG        // IN
                        ): Integer; stdcall;


  TSCardCLICCTransmit = function (
                        ulHandleCard: SCARDHANDLE;              // IN
                        pucSendData: PUCHAR;                    // IN
                        ulSendDataBufLen: ULONG;                // IN
                        pucReceivedData: PUCHAR;                // IN OUT
                        pulReceivedDataBufLen: PULONG           // IN OUT
                        ): Integer; stdcall;


const
  DllName = 'Scardsyn.dll';

var
  DllHandle: THandle = 0;
  pSCardCLWriteMifareKeyToReader: TSCardCLWriteMifareKeyToReader = nil;
  pSCardCLGetUID: TSCardCLGetUID = nil;
  pSCardCLMifareStdAuthent: TSCardCLMifareStdAuthent = nil;
  pSCardCLMifareStdRead: TSCardCLMifareStdRead = nil;
  pSCardCLMifareStdWrite: TSCardCLMifareStdWrite = nil;
  pSCardCLMifareLightWrite: TSCardCLMifareLightWrite = nil;
  pSCardCLMifareStdIncrementVal: TSCardCLMifareStdIncrementVal = nil;
  pSCardCLMifareStdDecrementVal: TSCardCLMifareStdDecrementVal = nil;
  pSCardCLMifareStdRestoreVal: TSCardCLMifareStdRestoreVal = nil;
  pSCardCLICCTransmit: TSCardCLICCTransmit = nil;

resourcestring
  DllLoadError = 'Ошибка загрузки библиотеки %s';

procedure LoadDll;
begin
  if DllHandle = 0 then
  begin
    DllHandle := LoadLibrary(DllName);
    if DllHandle = 0 then
      raise Exception.CreateFmt(DllLoadError, [DllName]);
  end;
end;

procedure UnLoadDll;
begin
  if DllHandle <> 0 then
  begin
    FreeLibrary(DllHandle);
    DllHandle := 0;
  end;
end;

procedure FindProc(var P: Pointer; const ProcName: string);
begin
  if P = nil then
  begin
    LoadDLL;
    P := GetProcAddress(DllHandle, PAnsiChar(ProcName));
    if P = nil then
      raise Exception.CreateFmt('Процедура "%s" не найдена в библиотеке "%s"',
        [ProcName, DllName]);
  end;
end;

function SCardCLWriteMifareKeyToReader(
                        ulHandleCard: SCARDHANDLE;              // IN
                        hContext: SCARDCONTEXT;                 // IN
                        pcCardReader: PCHAR;                    // IN
                        ulMifareKeyNr: ULONG;                   // IN
                        ulMifareKeyLen: ULONG;                  // IN
                        pucMifareKey: PUCHAR;                   // IN
                        fSecuredTransmission: BOOLEAN;          // IN
                        ulEncryptionKeyNr: ULONG                // IN
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLWriteMifareKeyToReader, 'SCardCLWriteMifareKeyToReader');
  Result := pSCardCLWriteMifareKeyToReader(
    ulHandleCard,
    hContext,
    pcCardReader,
    ulMifareKeyNr,
    ulMifareKeyLen,
    pucMifareKey,
    fSecuredTransmission,
    ulEncryptionKeyNr);
end;


function SCardCLGetUID(
                         ulHandleCard: SCARDHANDLE;             // IN
                         pucUID: PUCHAR;                        // IN OUT
                         ulUIDBufLen: ULONG;                    // IN
                         var pulnByteUID: ULONG                 // IN OUT
                         ): Integer; stdcall;
begin
  FindProc(@pSCardCLGetUID, 'SCardCLGetUID');
  Result := pSCardCLGetUID(
    ulHandleCard,
    pucUID,
    ulUIDBufLen,
    pulnByteUID);
end;


function SCardCLMifareStdAuthent(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        ucMifareAuthMode: UCHAR;        // IN
                        ucMifareAccessType: UCHAR;      // IN
                        ucMifareKeyNr: UCHAR;           // IN
                        pucMifareKey: PUCHAR;           // IN
                        ulMifareKeyLen: ULONG           // IN
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLMifareStdAuthent, 'SCardCLMifareStdAuthent');
  Result := pSCardCLMifareStdAuthent(
                        ulHandleCard,
                        ulMifareBlockNr,
                        ucMifareAuthMode,
                        ucMifareAccessType,
                        ucMifareKeyNr,
                        pucMifareKey,
                        ulMifareKeyLen);
end;


function SCardCLMifareStdRead(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataRead: PUCHAR;      // IN OUT
                        ulMifareDataReadBufLen: ULONG;  // IN
                        pulMifareNumOfDataRead: PULONG  // IN OUT
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLMifareStdRead, 'SCardCLMifareStdRead');
  Result := pSCardCLMifareStdRead(
    ulHandleCard,
    ulMifareBlockNr,
    pucMifareDataRead,
    ulMifareDataReadBufLen,
    pulMifareNumOfDataRead);
end;


function SCardCLMifareStdWrite(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataWrite: PUCHAR;     // IN
                        ulMifareDataWriteBufLen: ULONG  // IN
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLMifareStdWrite, 'SCardCLMifareStdWrite');
  Result := pSCardCLMifareStdWrite(
                        ulHandleCard,
                        ulMifareBlockNr,
                        pucMifareDataWrite,
                        ulMifareDataWriteBufLen);
end;


function SCardCLMifareLightWrite(
                        ulHandleCard: SCARDHANDLE;      // IN
                        ulMifareBlockNr: ULONG;         // IN
                        pucMifareDataWrite: PUCHAR;     // IN
                        ulMifareDataWriteBufLen: ULONG  // IN
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLMifareLightWrite, 'SCardCLMifareLightWrite');
  Result := pSCardCLMifareLightWrite(
                        ulHandleCard,
                        ulMifareBlockNr,
                        pucMifareDataWrite,
                        ulMifareDataWriteBufLen);
end;


function SCardCLMifareStdIncrementVal(
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareBlockNr: ULONG;                 // IN
                        pucMifareIncrementValue: PUCHAR;        // IN
                        ulMifareIncrementValueBufLen: ULONG     // IN
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLMifareStdIncrementVal, 'SCardCLMifareStdIncrementVal');
  Result := pSCardCLMifareStdIncrementVal(
                        ulHandleCard,
                        ulMifareBlockNr,
                        pucMifareIncrementValue,
                        ulMifareIncrementValueBufLen);
end;


function SCardCLMifareStdDecrementVal(
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareBlockNr: ULONG;                 // IN
                        pucMifareDecrementValue: PUCHAR;        // IN
                        ulMifareDecrementValueBufLen: ULONG     // IN
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLMifareStdDecrementVal, 'SCardCLMifareStdDecrementVal');
  Result := pSCardCLMifareStdDecrementVal(
                        ulHandleCard,
                        ulMifareBlockNr,
                        pucMifareDecrementValue,
                        ulMifareDecrementValueBufLen);
end;

function SCardCLMifareStdRestoreVal(
                        ulHandleCard: SCARDHANDLE;              // IN
                        ulMifareOldBlockNr: ULONG;              // IN
                        ulMifareNewBlockNr: ULONG;              // IN
                        fMifareSameSector: BOOLEAN;             // IN
                        ucMifareAuthModeForNewBlock: UCHAR;     // IN
                        ucMifareAccessTypeForNewBlock: UCHAR;   // IN
                        ucMifareKeyNrForNewBlock: UCHAR;        // IN
                        pucMifareKeyForNewBlock: PUCHAR;        // IN
                        ulMifareKeyLenForNewBlock: ULONG        // IN
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLMifareStdRestoreVal, 'SCardCLMifareStdRestoreVal');
  Result := pSCardCLMifareStdRestoreVal(
                        ulHandleCard,
                        ulMifareOldBlockNr,
                        ulMifareNewBlockNr,
                        fMifareSameSector,
                        ucMifareAuthModeForNewBlock,
                        ucMifareAccessTypeForNewBlock,
                        ucMifareKeyNrForNewBlock,
                        pucMifareKeyForNewBlock,
                        ulMifareKeyLenForNewBlock);
end;

function SCardCLICCTransmit(
                        ulHandleCard: SCARDHANDLE;              // IN
                        pucSendData: PUCHAR;                    // IN
                        ulSendDataBufLen: ULONG;                // IN
                        pucReceivedData: PUCHAR;                // IN OUT
                        pulReceivedDataBufLen: PULONG           // IN OUT
                        ): Integer; stdcall;
begin
  FindProc(@pSCardCLICCTransmit, 'SCardCLICCTransmit');
  Result := pSCardCLICCTransmit(
                        ulHandleCard,
                        pucSendData,
                        ulSendDataBufLen,
                        pucReceivedData,
                        pulReceivedDataBufLen);
end;

end.
