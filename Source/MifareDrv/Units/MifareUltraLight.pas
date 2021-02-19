unit MifareUltraLight;

interface

uses
  // VCL
  SysUtils,
  // This
  CustomCard, untError, untUtil;

type
  { TMifareUltraLight }

  TMifareUltraLight = class(TCustomCard)
  private
    procedure CheckDataSize(DataLength: Integer);
  protected
    function GetDataSize: Integer; override;
    function GetDescription: string; override;
  public
    procedure ReadDirectory; override;
    procedure WriteDirectory; override;
    procedure FormatDirectory; override;
    procedure WriteData(const Data: string); override;
    function ReadData(DataSize: Integer): string; override;
    procedure MikleWriteData(const Data: string); override;
    function MikleReadData(DataSize: Integer): string; override;

  end;

implementation

procedure RaiseCatalogNotSupported;
begin
  RaiseError(E_CARD_NOTSUPPORTED,
    'Карта Mifare UltraLight не поддерживает операции с каталогом');
end;

{ TMifareUltraLight }

// Для даннных доступны 12 страниц по 4 байта

function TMifareUltraLight.GetDataSize: Integer;
begin
  Result := 48;
end;

function TMifareUltraLight.GetDescription: string;
begin
  Result := 'MIFARE® ultralight';
end;

procedure TMifareUltraLight.CheckDataSize(DataLength: Integer);
begin
  if DataLength > DataSize then
    raise Exception.Create('Количество данных превышает объем карты.');
end;

{ Чтение данных. Читаем по 16 байт }

function TMifareUltraLight.ReadData(DataSize: Integer): string;
var
  i: Integer;
  Data: string;
  PageCount: Integer;
begin
  Data := '';
  CheckDataSize(DataSize);
  PageCount := Trunc(DataSize/16 + 0.5);
  for i := 0 to PageCount-1 do
  begin
    Driver.BlockNumber := (i+1)*4;
    Driver.PiccRead;
    Data := Data + Driver.BlockData;
  end;
  ODS('RX: ' + StrToHexText(Data));
  Result := Data;
end;

{ Запись данных на карту. Пишем по 4 байта }

procedure TMifareUltraLight.WriteData(const Data: string);
var
  i: Integer;
  PageCount: Integer;
begin
  ODS('TX: ' + StrToHexText(Data));
  CheckDataSize(Length(Data));
  PageCount := Trunc(Length(Data)/4 + 0.5);
  for i := 0 to PageCount-1 do
  begin
    Driver.BlockNumber := i+4;
    Driver.BlockData := Copy(Data, i*4 + 1, 4);
    Driver.PiccWrite;
  end;
end;

procedure TMifareUltraLight.ReadDirectory;
begin
  RaiseCatalogNotSupported;
end;

procedure TMifareUltraLight.WriteDirectory;
begin
  RaiseCatalogNotSupported;
end;

procedure TMifareUltraLight.FormatDirectory;
begin
  RaiseCatalogNotSupported;
end;

function TMifareUltraLight.MikleReadData(DataSize: Integer): string;
begin
  RaiseCatalogNotSupported;
end;

procedure TMifareUltraLight.MikleWriteData(const Data: string);
begin
  RaiseCatalogNotSupported;
end;

end.
