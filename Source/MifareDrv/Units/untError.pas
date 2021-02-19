unit untError;

interface

uses
  // VCL
  SysUtils, Windows,
  //This
  MifareLib_TLB;

const
  SUCCESS                 = 0;    // ������ ���
  E_NOHARDWARE            = -1;   // ��� �����
  E_UNKNOWNERROR          = -2;   // ����������� ������
  E_COM_ACCESS_DENIED     = -3;   // ���� ����� ������ �����������
  E_COM_PORT_NOT_FOUND    = -4;   // ���� ����������
  E_COM_WRITE_ERROR       = -5;   // � ���� �������� �� ��� ������
  E_INVALID_FRAME         = -6;   // �������� ������ �����
  E_ANSWER_LENGTH         = -7;   // �������� ����� ������
  E_INVALID_CS            = -8;   // �������� ����������� ����� ������
  E_SECTOR_NUMBER         = -9;   // �������� ����� �������
  E_INVALID_TRAILER       = -10;  // �������� �������� ��������
  E_INVALID_ACCESS_BITS   = -11;  // �������� ���� �������
  E_CARD_NOTSUPPORTED     = -12;  // �������� �� �������������� ������
  E_FIELD_INDEX           = -13;  // �������� ������ ����
  E_NOAPPSECTOR           = -14;  // �� ������� ������� ����������
  E_NOFREESECTOR          = -15;  // ��� ��������� �������� ��� ������
  E_APPSECTOR_COUNT       = -16;  // ������������� ���������� �������� ���������� � ��������
  E_REMOVED_CARD          = -17;  // The smart card has been removed, so that further communication is not possible.
  E_INVALID_DATA_LENGTH   = -18;  // �������� ����� ������
  E_NOT_VALUE_BLOCK       = -19;  // ���� �� �������� ������-���������
  E_VALUE_BLOCK_CORRUPTED = -20;  // ����-�������� ���������

resourcestring
  S_SUCCESS                     = '������ ���';
  S_NOHARDWARE                  = '��� �����';
  S_UNKNOWNERROR                = '������������ ������';
  S_BLOCKDATA                   = '�������� ����� �����';
  S_DIRECTORY_DATALENGTH        = '�������� ����� ������';
  S_DIRECTORY_NOHEADER          = '��������� �������� �� ������';
  S_DIRECTORY_HEADERCRC         = '������ CRC � ��������� ��������';
  S_DIRECTORY_DATACRC           = '������ CRC � ������ ��������';
  S_DIRECTORY_NOSECTOR          = '��������� ������ ����� �� ������';
  S_FIELD_INDEX                 = '�������� ������ ����';
  S_CARD_NOTSUPPORTED           = '�������� �� �������������� ������';
  S_NOFREESECTOR                = '��� ��������� �������� ��� ������';
  S_APPSECTOR_COUNT             = '������������� ���������� �������� ���������� � ��������';
  S_NOAPPSECTOR                 = '�� ������� ������� ����������';
  S_COM_ACCESS_DENIED           = '���� ����� ������ �����������';
  S_COM_PORT_NOT_FOUND          = '���� ����������';
  S_COM_WRITE_ERROR             = '� ���� �������� �� ��� ������';
  S_INVALID_FRAME               = '�������� ������ �����';
  S_ANSWER_LENGTH               = '�������� ����� ������';
  S_INVALID_CS                  = '�������� ����������� ����� ������';
  S_SECTOR_NUMBER               = '�������� ����� �������';
  S_INVALID_TRAILER             = '�������� �������� ��������';
  S_INVALID_ACCESS_BITS         = '�������� ���� �������';
  S_INVALID_DATA_LENGTH         = '�������� ����� ������';
  S_NOT_VALUE_BLOCK             = '���� �� �������� ������-���������';
  S_VALUE_BLOCK_CORRUPTED       = '����-�������� ���������';

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
