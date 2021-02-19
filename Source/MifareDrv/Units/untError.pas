unit untError;

interface

uses
  // VCL
  SysUtils, Windows,
  //This
  MifareLib_TLB;

const
  SUCCESS                 = 0;    // Ошибок нет
  E_NOHARDWARE            = -1;   // Нет связи
  E_UNKNOWNERROR          = -2;   // Неизвестная ошибка
  E_COM_ACCESS_DENIED     = -3;   // Порт занят другим приложением
  E_COM_PORT_NOT_FOUND    = -4;   // Порт недоступен
  E_COM_WRITE_ERROR       = -5;   // В порт записаны не все данные
  E_INVALID_FRAME         = -6;   // Неверный формат кадра
  E_ANSWER_LENGTH         = -7;   // Неверная длина ответа
  E_INVALID_CS            = -8;   // Неверная контрольная сумма пакета
  E_SECTOR_NUMBER         = -9;   // Неверный номер сектора
  E_INVALID_TRAILER       = -10;  // Неверное значение трейлера
  E_INVALID_ACCESS_BITS   = -11;  // Неверные биты доступа
  E_CARD_NOTSUPPORTED     = -12;  // Операция не поддерживается картой
  E_FIELD_INDEX           = -13;  // Неверный индекс поля
  E_NOAPPSECTOR           = -14;  // Не найдены сектора приложения
  E_NOFREESECTOR          = -15;  // Нет свободных секторов для записи
  E_APPSECTOR_COUNT       = -16;  // Недостаточное количество секторов приложения в каталоге
  E_REMOVED_CARD          = -17;  // The smart card has been removed, so that further communication is not possible.
  E_INVALID_DATA_LENGTH   = -18;  // Неверная длина данных
  E_NOT_VALUE_BLOCK       = -19;  // Блок не является блоком-значением
  E_VALUE_BLOCK_CORRUPTED = -20;  // Блок-значение поврежден

resourcestring
  S_SUCCESS                     = 'Ошибок нет';
  S_NOHARDWARE                  = 'Нет связи';
  S_UNKNOWNERROR                = 'Неопознанная ошибка';
  S_BLOCKDATA                   = 'Неверные даные блока';
  S_DIRECTORY_DATALENGTH        = 'Неверная длина данных';
  S_DIRECTORY_NOHEADER          = 'Заголовок каталога не найден';
  S_DIRECTORY_HEADERCRC         = 'Ошибка CRC в заголовке каталога';
  S_DIRECTORY_DATACRC           = 'Ошибка CRC в данных каталога';
  S_DIRECTORY_NOSECTOR          = 'Свободный сектор карты не найден';
  S_FIELD_INDEX                 = 'Неверный индекс поля';
  S_CARD_NOTSUPPORTED           = 'Операция не поддерживается картой';
  S_NOFREESECTOR                = 'Нет свободных секторов для записи';
  S_APPSECTOR_COUNT             = 'Недостаточное количество секторов приложения в каталоге';
  S_NOAPPSECTOR                 = 'Не найдены сектора приложения';
  S_COM_ACCESS_DENIED           = 'Порт занят другим приложением';
  S_COM_PORT_NOT_FOUND          = 'Порт недоступен';
  S_COM_WRITE_ERROR             = 'В порт записаны не все данные';
  S_INVALID_FRAME               = 'Неверный формат кадра';
  S_ANSWER_LENGTH               = 'Неверная длина ответа';
  S_INVALID_CS                  = 'Неверная контрольная сумма пакета';
  S_SECTOR_NUMBER               = 'Неверный номер сектора';
  S_INVALID_TRAILER             = 'Неверное значение трейлера';
  S_INVALID_ACCESS_BITS         = 'Неверные биты доступа';
  S_INVALID_DATA_LENGTH         = 'Неверная длина данных';
  S_NOT_VALUE_BLOCK             = 'Блок не является блоком-значением';
  S_VALUE_BLOCK_CORRUPTED       = 'Блок-значение поврежден';

type
  { EDriverError }

  EDriverError = class(Exception)
  private
    fErrorCode: Int64;
  public
    property ErrorCode: Int64 read fErrorCode;
    constructor Create2(Code: Int64; Msg: string);
  end;

procedure RaiseNotSupportedError;
procedure RaiseNoHardwareError;
procedure RaiseError(Code: Int64; const Msg: string);
function HandleException(E: Exception): Integer;

implementation

{ EDriverError }

constructor EDriverError.Create2(Code: Int64; Msg: string);
begin
  inherited Create(Msg);
  FErrorCode := Code;
end;

procedure RaiseError(Code: Int64; const Msg: string);
begin
  raise EDriverError.Create2(Code, Msg);
end;

procedure RaiseNotSupportedError;
begin
  RaiseError(E_CARD_NOTSUPPORTED, S_CARD_NOTSUPPORTED);
end;

procedure RaiseNoHardwareError;
begin
  RaiseError(E_NOHARDWARE, S_NOHARDWARE);
end;

function HandleException(E: Exception): Integer;
begin
  if E is EDriverError then
    Result := (E as EDriverError).ErrorCode
  else
    Result := Integer(E_UNKNOWN);
end;

end.
