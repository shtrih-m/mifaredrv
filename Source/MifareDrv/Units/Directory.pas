unit Directory;

interface

uses
  // VCL
  Windows, Classes, Registry, SysUtils,
  // This
  MifareLib_TLB, untError, untUtil, untConst, CardFirm, untTypes,
  CardSector, Notifier, LogFile;

type
  { TCardDirectory }

  TCardDirectory = class
  private
    FFirms: TCardFirms;
    FStatusText: string;
    FNotifier: TNotifier;
    FSectors: TCardSectors;
    FStatus: TDirectoryStatus;

    procedure CreateSectors;
    function GetIsModified: Boolean;
    procedure SaveFirms;
  public
    Version: Byte;
    IniFileName: string;
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function GetHeader: string;
    function GetCatalog: string;
    procedure SetHeader(const Data: string);
    procedure SetCatalog(const Data: string);

    property Firms: TCardFirms read FFirms;
    property Sectors: TCardSectors read FSectors;
    property StatusText: string read FStatusText;
    property Status: TDirectoryStatus read FStatus;
    property IsModified: Boolean read GetIsModified;
  end;

implementation

procedure CheckMinLength(const Data: string; MinLength: Integer);
begin
  if Length(Data) < MinLength then
    RaiseError(Integer(E_DIRECTORY_DATALENGTH), S_DIRECTORY_DATALENGTH);
end;

{ Проверка заголовка }

function GetCRC(const Data: string; Count: Integer): Byte;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Count do
    Result := (Result + Ord(Data[i])) mod 256;
end;

const
  CARD_HEADER = #$4D#$4B#$53;

{ TCardDirectory }

constructor TCardDirectory.Create;
begin
  inherited Create;
  FNotifier := TNotifier.Create;
  FSectors := TCardSectors.Create(FNotifier);
  FFirms := TCardFirms.Create;
  IniFileName := ChangeFileExt(GetModuleFileName, '.ini');
  CreateSectors;
  FFirms.LoadFromIniFile(IniFileName);
end;

destructor TCardDirectory.Destroy;
begin
  SaveFirms;
  FFirms.Free;
  FSectors.Free;
  FNotifier.Free;
  inherited Destroy;
end;

procedure TCardDirectory.SaveFirms;
begin
  try
    FFirms.SaveToIniFile(IniFileName);
  except
    on E: Exception do
      Logger.Error('TCardDirectory.SaveFirms', E);
  end;
end;

procedure TCardDirectory.CreateSectors;
var
  i: Integer;
begin
  for i := 2 to 15 do
  begin
    FSectors.Add.Number := i;
  end;
end;

procedure TCardDirectory.SetHeader(const Data: string);
begin
  FStatus := dsOK;
  FStatusText := 'Каталог найден';

  CheckMinLength(Data, 5);
  if Copy(Data, 1, 3) <> CARD_HEADER then
  begin
    FStatus := dsNotFound;
    FStatusText := 'Не найден заголовок каталога';
    Exit;
  end;
  if GetCRC(Data, 4) <> Ord(Data[5]) then
  begin
    FStatus := dsCorrupted;
    FStatusText := 'Заголовок каталога поврежден';
    Exit;
  end;
  Version := Ord(Data[4]);
end;

function TCardDirectory.GetCatalog: string;
var
  i: Integer;
  Sector: TCardSector;
begin
  Result := '';
  for i := 0 to Sectors.Count - 1 do
  begin
    Sector := Sectors[i];
    Result := Result + Chr(Sector.FirmCode);
    Result := Result + Chr(Sector.AppCode);
  end;
  Result := Result + Chr(GetCRC(Result, Length(Result)));
end;

procedure TCardDirectory.SetCatalog(const Data: string);
var
  i: Integer;
  Sector: TCardSector;
begin
  CheckMinLength(Data, 29);
  if GetCRC(Data, 28) <> Ord(Data[29]) then
  begin
    FStatus := dsCorrupted;
    FStatusText := 'Данные каталога повреждены';
    Exit;
  end;

  // Сектора
  for i := 0 to Sectors.Count - 1 do
  begin
    Sector := Sectors[i];
    Sector.FirmCode := Ord(Data[i * 2 + 1]);
    Sector.AppCode := Ord(Data[i * 2 + 2]);
  end;
end;

function TCardDirectory.GetHeader: string;
begin
  Result := CARD_HEADER + Chr(Version);
  Result := Result + Chr(GetCRC(Result, Length(Result)));
end;

procedure TCardDirectory.Clear;
var
  i: Integer;
begin
  for i := 0 to Sectors.Count - 1 do
    Sectors[i].Clear;
end;

function TCardDirectory.GetIsModified: Boolean;
begin
  Result := FNotifier.IsModified;
end;

end.

