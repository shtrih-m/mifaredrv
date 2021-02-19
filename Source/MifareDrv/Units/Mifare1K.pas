unit Mifare1K;

interface

uses
  // VCL
  SysUtils,
  // This
  CustomCard, MifareLib_TLB, untDriver, untConst, MFRC500Reader,
  Directory, CardBlock, untTypes, untError, CardSector, untUtil;

type
  { TMifare1K }

  TMifare1K = class(TCustomCard)
  private
    FBlocks: TCardBlocks;
    procedure ReadDirectoryData;
    procedure ReadDirectoryHeader;
    procedure WriteDirectoryHeader;
    procedure GetReadDataBlocks(DataSize: Integer);
    procedure GetWriteDataBlocks(DataSize: Integer);
    procedure WriteDirectoryData(const Data: string);
    procedure ReadBlocks(Blocks: TCardBlocks);
    procedure ReadBlock(Block: TCardBlock);
    procedure WriteBlock(Block: TCardBlock);
    procedure WriteBlocks(Blocks: TCardBlocks);
    procedure AddDataBlocks(Sectors: TCardSectors; DataSize: Integer);
    procedure AddWriteBlocks(Sectors: TCardSectors; DataSize: Integer);
    property Blocks: TCardBlocks read FBlocks;
  public
    constructor Create(ADriver: TDriver); override;
    destructor Destroy; override;

    procedure ReadDirectory; override;
    procedure WriteDirectory; override;
    procedure FormatDirectory; override;
    function GetDescription: string; override;
    procedure WriteData(const Data: string); override;
    procedure MikleWriteData(const Data: string); override;
    function ReadData(DataSize: Integer): string; override;
    function MikleReadData(DataSize: Integer): string; override;
  end;

implementation

const
  SectorSize            = 48;
  BLOCK_DIRHDR_DATA     = 1; // ����� ����� ��������� ��������
  BLOCK_DIRHDR_TRAILER  = 3; // ����� ����� �������� ���������
  BLOCK_DIRDATA_1       = 4; // ����� ����� ������ �������� 1
  BLOCK_DIRDATA_2       = 5; // ����� ����� ������ �������� 2
  BLOCK_DIRDATA_TRAILER = 7; // ����� ����� �������� ���������


  procedure CheckSectorNumber(Number: Integer);
  begin
    if (Number< 2)or(Number>15) then
      RaiseError(E_SECTOR_NUMBER, S_SECTOR_NUMBER);
  end;


  { TMifare1K }

constructor TMifare1K.Create(ADriver: TDriver);
begin
  inherited Create(ADriver);
  FBlocks := TCardBlocks.Create;
end;

destructor TMifare1K.Destroy;
begin
  FBlocks.Free;
  inherited Destroy;
end;

{ ������ ��������� �������� }

procedure TMifare1K.ReadDirectoryHeader;
begin
  Driver.KeyType := ktKeyA;
  Driver.BlockNumber := BLOCK_DIRHDR_DATA;
  Driver.Check(Driver.AuthByKeys([KEY_STANDARD, KEY_MIKLESOFT]));
  Driver.Check(Driver.PiccRead);
  Directory.SetHeader(Driver.BlockData);
end;

{ ������ ������ �������� }

procedure TMifare1K.ReadDirectoryData;
var
  Data: string;
begin
  Data := '';
  Driver.KeyType := ktKeyA;
  Driver.BlockNumber := BLOCK_DIRDATA_1;
  Driver.Check(Driver.AuthByKeys([KEY_STANDARD, KEY_MIKLESOFT]));
  // ������ ����� DIR_SECTOR_DATA1
  Driver.Check(Driver.PiccRead);
  Data := Data + Driver.BlockData;
  // ������ ����� DIR_SECTOR_DATA2
  Driver.BlockNumber := BLOCK_DIRDATA_2;
  Driver.Check(Driver.PiccRead);
  Data := Data + Driver.BlockData;
  // ������ ��������
  Directory.SetCatalog(Data);
end;

procedure TMifare1K.ReadDirectory;
begin
  Directory.Clear;
  ReadDirectoryHeader;
  if Directory.Status = dsOK then
  begin
    ReadDirectoryData;
  end;
end;

procedure TMifare1K.WriteDirectory;
begin
  WriteDirectoryHeader;
  WriteDirectoryData(Directory.GetCatalog);
end;

procedure TMifare1K.WriteDirectoryHeader;
begin
  Driver.KeyType := ktKeyA;
  Driver.BlockNumber := BLOCK_DIRHDR_DATA;
  Driver.Check(Driver.AuthByKeys([KEY_HEADER, KEY_MIKLESOFT, KEY_STANDARD]));
  Driver.Check(Driver.WriteBlock(BLOCK_DIRHDR_DATA, Directory.GetHeader));
//  Driver.Check(Driver.WriteTrailer(BLOCK_DIRHDR_TRAILER, 1, 1, 1, 6, KEY_STANDARD, KEY_HEADER));
end;

procedure TMifare1K.WriteDirectoryData(const Data: string);
begin
  Driver.KeyType := ktKeyA;
  Driver.BlockNumber := BLOCK_DIRDATA_1;
  Driver.Check(Driver.AuthByKeys([KEY_CATALOG, KEY_MIKLESOFT, KEY_STANDARD]));
  Driver.Check(Driver.WriteBlock(BLOCK_DIRDATA_1, Copy(Data, 1, 16)));
  Driver.Check(Driver.WriteBlock(BLOCK_DIRDATA_2, Copy(Data, 17, 16)));
//  Driver.Check(Driver.WriteTrailer(BLOCK_DIRDATA_TRAILER, 1, 1, 1, 6, KEY_STANDARD, KEY_CATALOG));
end;

procedure TMifare1K.FormatDirectory;
begin
  WriteDirectoryHeader;
  WriteDirectoryData('');
end;

{ ��� ������ ������ ������ ����� ������ }

procedure TMifare1K.AddDataBlocks(Sectors: TCardSectors; DataSize: Integer);
var
  Size: Integer;
  i, j: Integer;
  Block: TCardBlock;
  Sector: TCardSector;
begin
  Size := 0;
  for i := 0 to Sectors.Count-1 do
  begin
    Sector := Sectors[i];
    // ����� ������
    for j := 0 to 2 do
    begin
      Block := Blocks.Add;
      Block.Number := Sector.Number*4 + j;
      Block.SectorNumber := Sector.Number;
      Block.IsDataBlock := True;
      Block.Size := 16;
      Size := Size + 16;
      if Size >= DataSize then Break;
    end;
  end;
end;

{ ��������� ������ ������ ������ �� ������ �������� }
{ � ������ ������� 3 ����� ������ � ���� �������    }

procedure TMifare1K.AddWriteBlocks(Sectors: TCardSectors; DataSize: Integer);
var
  Size: Integer;
  i, j: Integer;
  Block: TCardBlock;
  Sector: TCardSector;
begin
  Size := 0;
  for i := 0 to Sectors.Count-1 do
  begin
    Sector := Sectors[i];
    // ����� ������
    for j := 0 to 2 do
    begin
      Block := Blocks.Add;
      Block.Number := Sector.Number*4 + j;
      Block.SectorNumber := Sector.Number;
      Block.IsDataBlock := True;
      Block.Size := 16;
      Size := Size + 16;
      if Size >= DataSize then Break;
    end;
    // �������
    Block := Blocks.Add;
    Block.Number := Sector.Number*4 + 3;
    Block.SectorNumber := Sector.Number;
    Block.Size := 16;
    Block.IsDataBlock := False;
    if Size >= DataSize then Break;
  end;
end;

{ ��������� ������ ������ ��� ������ }

procedure TMifare1K.GetReadDataBlocks(DataSize: Integer);
var
  Remainder: Integer;
  SectorCount: Integer;
  CardApp: TCardApplication;
begin
  Driver.Sectors.Clear;
  Remainder := DataSize mod SectorSize;
  if Remainder <> 0 then Remainder := 1;
  SectorCount := (DataSize div SectorSize)+Remainder;//Trunc(DataSize/SectorSize + 0.5);
  CardApp.AppCode := Driver.AppCode;
  CardApp.FirmCode := Driver.FirmCode;
  Directory.Sectors.FindAppSectors(CardApp, Driver.Sectors);
  // ��� �������� ����������
  if Driver.Sectors.Count = 0 then
    RaiseError(E_NOAPPSECTOR, S_NOAPPSECTOR);
  // ������������ ��������
  if Driver.Sectors.Count < SectorCount then
    RaiseError(E_APPSECTOR_COUNT, S_APPSECTOR_COUNT);

  Blocks.Clear;
  AddDataBlocks(Driver.Sectors, DataSize);
end;

{ ��������� ������ ������ ��� ������ }

procedure TMifare1K.GetWriteDataBlocks(DataSize: Integer);
var
  i: Integer;
  Remainder: Integer;
  Sector: TCardSector;
  SectorCount: Integer;       // ��������� ���������� ��������
  SectorNumber: Integer;
  CardApp: TCardApplication;
begin
  CardApp.AppCode := Driver.AppCode;
  CardApp.FirmCode := Driver.FirmCode;

  Blocks.Clear;
  Driver.Sectors.Clear;

  Directory.Sectors.FindAppSectors(CardApp, Driver.Sectors);
  Remainder := DataSize mod SectorSize;
  if Remainder <> 0 then Remainder := 1;
  SectorCount := (DataSize div SectorSize)+Remainder;//Trunc(DataSize/SectorSize + 0.5);
  // ����� ���������� �������������� �������
  if Driver.Sectors.Count > SectorCount then
  begin
    for i := Driver.Sectors.Count-1 downto SectorCount do
    begin
      SectorNumber := Driver.Sectors[i].Number;
      Driver.SectorNumber := SectorNumber;
      Driver.Check(Driver.DeleteSector);
      Driver.Sectors[i].Free;

      Sector := Directory.Sectors.ItemByNumber(SectorNumber);
      if Sector <> nil then Sector.Clear;
    end;
  end;
  // ���� �� ������� ������, �� �������� ���������
  if Driver.Sectors.Count < SectorCount then
  begin
    Directory.Sectors.FindFreeSectors(CardApp, Driver.Sectors,
      SectorCount - Driver.Sectors.Count);
  end;
  // ���� �� ������� ��������� � �������, �� ��������� ���
  if Directory.IsModified then WriteDirectory;

  AddWriteBlocks(Driver.Sectors, DataSize);
end;

{*****************************************************************************

    ������ �����. ������� �������� ������ ������ ��� ������ ������
    ���� ������ ������, �� �� ����� ��� ������ ����� ����������

{*****************************************************************************}

function TMifare1K.MikleReadData(DataSize: Integer): string;
begin
  ReadDirectory;
  GetReadDataBlocks(DataSize);
  ReadBlocks(Blocks);
  Result := Blocks.Data;
end;

procedure TMifare1K.MikleWriteData(const Data: string);
begin
  ReadDirectory;
  GetWriteDataBlocks(Length(Data));
  Blocks.Data := Data;
  WriteBlocks(Blocks);
end;

procedure TMifare1K.ReadBlock(Block: TCardBlock);
begin
  Driver.BlockNumber := Block.Number;
  Driver.PiccRead;
  Block.Data := Driver.BlockData;
end;

{  ������ ����� }

procedure TMifare1K.WriteBlock(Block: TCardBlock);
begin
  if Block.IsDataBlock then          
  begin
    Driver.Check(Driver.WriteBlock(Block.Number, Block.Data));
  end else
  begin
    if Driver.UpdateTrailer then
      Driver.Check(Driver.WriteTrailer(Block.Number, 0,0,0,4, Driver.KeyABin, Driver.KeyBBin));
  end;
end;

procedure TMifare1K.ReadBlocks(Blocks: TCardBlocks);
var
  i: Integer;
  Block: TCardBlock;
  SectorNumber: Integer;
begin
  SectorNumber := -1;
  for i := 0 to Blocks.Count-1 do
  begin
    Block := Blocks[i];
    if Block.SectorNumber <> SectorNumber then
    begin
      Driver.BlockNumber := Block.Number;
      Driver.AuthBlock;

      SectorNumber := Block.SectorNumber;
    end;
    ReadBlock(Block);
  end;
end;

{  ������ ������ }
{  ��� �������� � ������� ������� �� ���������������� }
{  ��������������, ��� ����� ���� ���������������     }

procedure TMifare1K.WriteBlocks(Blocks: TCardBlocks);
var
  i: Integer;
  Block: TCardBlock;
  SectorNumber: Integer;
begin
  SectorNumber := -1;
  for i := 0 to Blocks.Count-1 do
  begin
    Block := Blocks[i];
    if Block.SectorNumber <> SectorNumber then
    begin
      Driver.BlockNumber := Block.Number;
      Driver.AuthBlock;
      SectorNumber := Block.SectorNumber;
    end;
    WriteBlock(Block);
  end;
end;

function TMifare1K.GetDescription: string;
begin
  Result := 'MIFARE� 1K';
end;

// 48 45 41 44 45 52
// 52 45 44 41 45 48


(*******************************************************************************

  ������ ������ ������ DataSize ������� � ������� � ������� SectorNumber.
  ��� ������ ���������� �����������.

*******************************************************************************)

function TMifare1K.ReadData(DataSize: Integer): string;
var
  i: Integer;
  j: Integer;
  L: Integer;
  Remainder: Integer;
  BlockNumber: Integer;
  SectorCount: Integer;
begin
  CheckSectorNumber(Driver.SectorNumber);
  // ���������� ���������� ��������, ��������� ��� ������ ������
  Remainder := DataSize mod SectorSize;
  if Remainder <> 0 then Remainder := 1;
  SectorCount := (DataSize div SectorSize)+Remainder;
  // ���� ����� ������ ������� �� ������� �����, �� ������ ������ �� ��� ����
  L := Driver.SectorNumber + SectorCount;
  if L > 16 then
    SectorCount := SectorCount - (L-16);

  Result := '';
  BlockNumber := Driver.SectorNumber*4;
  for i := 0 to SectorCount-1 do
  begin
    for j := 0 to 2 do
    begin
      Driver.BlockNumber := BlockNumber+i*4+j;
      // ���� ��� ����� ������, �� ������������
      if j = 0 then Driver.AuthBlock;

      Driver.PiccRead;
      Result := Result + Driver.BlockData;
    end;
  end;
end;

(*******************************************************************************

  ������ ������ Data ������� � ������� � ������� SectorNumber.
  ��� ������ ���������� �����������.

*******************************************************************************)

procedure TMifare1K.WriteData(const Data: string);
var
  i: Integer;
  j: Integer;
  Remainder: Integer;
  BlockNumber: Integer;
  SectorCount: Integer;
begin
  CheckSectorNumber(Driver.SectorNumber);
  // ���������� ���������� ��������, ��������� ��� ������ ������
  Remainder := Length(Data) mod SectorSize;
  if Remainder <> 0 then Remainder := 1;
  SectorCount := (Length(Data) div SectorSize)+Remainder;
  // ���� �� ������� �������� ������� � ������� � ������� SectorNumber,
  // �� ������������ ������ 4 - ��� ��������� �������� ��� ������
  if (Driver.SectorNumber+SectorCount) > 16 then
    RaiseError(E_NOFREESECTOR, S_NOFREESECTOR);

  BlockNumber := Driver.SectorNumber*4;
  for i := 0 to SectorCount-1 do
  begin
    for j := 0 to 2 do
    begin
      Driver.BlockNumber := BlockNumber+i*4+j;
      // ���� ��� ����� ������, �� ������������
      if j = 0 then Driver.AuthBlock;

      Driver.BlockData := Copy(Data, i*48+j*16 + 1, 16);
      Driver.PiccWrite;
    end;
  end;
end;

end.
