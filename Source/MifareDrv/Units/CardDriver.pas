unit CardDriver;

interface

uses
  // VCL
  Windows, SysUtils,
  // This
  untDriver, MifareLib_TLB, CustomCard, Mifare1K, Mifare4K, MifareUltraLight,
  untTypes, untUtil, untError;

type
  { TCardDriver }

  // TCardDriver - класс, который знает о типах карт

  TCardDriver = class(TDriver)
  private
    FData: string;
    FCardATQ: Integer;
    FDataSize: Integer;
    FCard: TCustomCard;
    ExecutionTime: DWORD;
    FDataMode: TDataMode;
    function GetCard: TCustomCard;
    function CreateCard: TCustomCard;
    property Card: TCustomCard read GetCard;
    procedure StartExecute2;
    procedure StopExecute2;
    function ValidBits(C0, C1, C2, C3: Integer): Boolean;
    function CheckAccessBits(Byte6, Byte7, Byte8: Integer): Boolean;
    procedure ActivateWakeup;
  protected
    procedure SetCardType(Value: TCardType); override;
  public
    destructor Destroy; override;

    function ReadData: Integer;
    function WriteData: Integer;
    function WriteTrailer: Integer;
    function ReadTrailer: Integer;
    function EncodeTrailer: Integer;
    function DecodeTrailer: Integer;
    function ReadFields: Integer;
    function WriteFields: Integer;
    function ReadDirectory: Integer;
    function WriteDirectory: Integer;
    function DeleteAppSectors: Integer;
    function CardDescription: string;
    function LoadParams: Integer; override;
    // команды MikleSoft
    function MksReopen: Integer;
    function MksFindCard: Integer;
    function MksReadCatalog: Integer;
    function MksWriteCatalog: Integer;

    property Data: string read FData write FData;
    property CardATQ: Integer read FCardATQ write FCardATQ;
    property DataSize: Integer read FDataSize write FDataSize;
    property DataMode: TDataMode read FDataMode write FDataMode;
  end;

implementation

{ TCardDriver }

destructor TCardDriver.Destroy;
begin
  FCard.Free;
  inherited Destroy;
end;

function TCardDriver.CreateCard: TCustomCard;
begin
  case CardType of
    ctMifare1K: Result := TMifare1K.Create(Self);
    ctMifare4K: Result := TMifare4K.Create(Self);
    ctMifareUltraLight: Result := TMifareUltraLight.Create(Self);
  else
    Result := TCustomCard.Create(Self);
  end;
end;

function TCardDriver.GetCard: TCustomCard;
begin
  if FCard = nil then
    FCard := CreateCard;
  Result := FCard;
end;

function TCardDriver.ReadFields: Integer;
begin
  try
    ResetCard;
    Fields.Data := Card.MikleReadData(Fields.Size);

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.WriteFields: Integer;
begin
  try
    ResetCard;
    Card.MikleWriteData(Fields.Data);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

procedure TCardDriver.StartExecute2;
begin
  ExecutionTime := GetTickCount;
end;

procedure TCardDriver.StopExecute2;
begin
  ExecutionTime := GetTickCount - ExecutionTime;
end;

function TCardDriver.ReadDirectory: Integer;
begin
  try
    StartExecute2;
    try
      ResetCard;
      Card.ReadDirectory;
    finally
      StopExecute2;
      ODS('ExecutionTime: ' + IntToStr(ExecutionTime));
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

{ Удаление секторов для приложения }

function TCardDriver.DeleteAppSectors: Integer;
var
  i: Integer;
  CardApp: TCardApplication;
begin
  try
    ResetCard;
    ReadDirectory;
    CardApp.AppCode := AppCode;
    CardApp.FirmCode := FirmCode;
    Directory.Sectors.FindAppSectors(CardApp, Sectors);
    for i := 0 to Sectors.Count-1 do
    begin
      SectorNumber := Sectors[i].Number;
      DeleteSector;
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.WriteDirectory: Integer;
begin
  try
    ResetCard;
    Card.WriteDirectory;

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end
end;

procedure TCardDriver.SetCardType(Value: TCardType);
begin
  if Value <> CardType then
  begin
    FCard.Free;
    FCard := nil;
  end;
  inherited SetCardType(Value);
end;

function TCardDriver.CardDescription: string;
begin
  Result := Format('%d, %s', [Ord(CardType), CardReader.CardName]);
end;

function TCardDriver.ReadData: Integer;
begin
  try
    ResetCard;
    case DataMode of
      dmDirNotUsed:
      begin
        Data := Card.ReadData(DataSize);
        Data := Copy(Data, 1, DataSize);
      end;
      dmMikleSoftDir:
      begin
        Data := Card.MikleReadData(DataSize);
        Data := Copy(Data, 1, DataSize);
      end;
      dmCustomDir:
      begin
      { !!! }
      end;
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.WriteData: Integer;
begin
  try
    ResetCard;
    case DataMode of
      dmDirNotUsed: Card.WriteData(Data);
      dmMikleSoftDir: Card.MikleWriteData(Data);
      dmCustomDir:
      begin
      { !!! }
      end;
    end;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.LoadParams: Integer;
begin
  Result :=  inherited LoadParams;
  DataMode := dmMikleSoftDir;
end;

function TCardDriver.DecodeTrailer: Integer;
var
  Byte6: Integer;
  Byte7: Integer;
  Byte8: Integer;
  C0: Integer;
  C1: Integer;
  C2: Integer;
  C3: Integer;
begin
  try
    if Length(BlockData) <> 16 then
      RaiseError(E_INVALID_TRAILER, S_INVALID_TRAILER);
    Byte6 := Ord(BlockData[7]);
    Byte7 := Ord(BlockData[8]);
    Byte8 := Ord(BlockData[9]);
    if not CheckAccessBits(Byte6, Byte7, Byte8) then
      RaiseError(E_INVALID_TRAILER, S_INVALID_TRAILER);
    C0 := 0;
    C1 := 0;
    C2 := 0;
    C3 := 0;
    if not TestBit(Byte6, 0) then SetBit(C0, 2);
    if not TestBit(Byte6, 1) then SetBit(C1, 2);
    if not TestBit(Byte6, 2) then SetBit(C2, 2);
    if not TestBit(Byte6, 3) then SetBit(C3, 2);
    if not TestBit(Byte6, 4) then SetBit(C0, 1);
    if not TestBit(Byte6, 5) then SetBit(C1, 1);
    if not TestBit(Byte6, 6) then SetBit(C2, 1);
    if not TestBit(Byte6, 7) then SetBit(C3, 1);
    if not TestBit(Byte7, 0) then SetBit(C0, 0);
    if not TestBit(Byte7, 1) then SetBit(C1, 0);
    if not TestBit(Byte7, 2) then SetBit(C2, 0);
    if not TestBit(Byte7, 3) then SetBit(C3, 0);
    FKeyA := Copy(BlockData, 1, 6);
    FKeyB := Copy(BlockData, 11, 6);
    AccessMode0 := C0;
    AccessMode1 := C1;
    AccessMode2 := C2;
    AccessMode3 := C3;

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.EncodeTrailer: Integer;
var
  C0: Integer;
  C1: Integer;
  C2: Integer;
  C3: Integer;
  Byte6: Integer;
  Byte7: Integer;
  Byte8: Integer;
begin
  try
    C0 := AccessMode0;
    C1 := AccessMode1;
    C2 := AccessMode2;
    C3 := AccessMode3;
    if not ValidBits(C0, C1, C2, C3) then
      RaiseError(E_INVALID_ACCESS_BITS, S_INVALID_ACCESS_BITS);
    // Byte6
    Byte6 := 0;
    if not TestBit(C0, 2) then SetBit(Byte6, 0);
    if not TestBit(C1, 2) then SetBit(Byte6, 1);
    if not TestBit(C2, 2) then SetBit(Byte6, 2);
    if not TestBit(C3, 2) then SetBit(Byte6, 3);

    if not TestBit(C0, 1) then SetBit(Byte6, 4);
    if not TestBit(C1, 1) then SetBit(Byte6, 5);
    if not TestBit(C2, 1) then SetBit(Byte6, 6);
    if not TestBit(C3, 1) then SetBit(Byte6, 7);
    // Byte7
    Byte7 := 0;
    if not TestBit(C0, 0) then SetBit(Byte7, 0);
    if not TestBit(C1, 0) then SetBit(Byte7, 1);
    if not TestBit(C2, 0) then SetBit(Byte7, 2);
    if not TestBit(C3, 0) then SetBit(Byte7, 3);
    if TestBit(C0, 2) then SetBit(Byte7, 4);
    if TestBit(C1, 2) then SetBit(Byte7, 5);
    if TestBit(C2, 2) then SetBit(Byte7, 6);
    if TestBit(C3, 2) then SetBit(Byte7, 7);
    // Byte8
    Byte8 := 0;
    if TestBit(C0, 1) then SetBit(Byte8, 0);
    if TestBit(C1, 1) then SetBit(Byte8, 1);
    if TestBit(C2, 1) then SetBit(Byte8, 2);
    if TestBit(C3, 1) then SetBit(Byte8, 3);
    if TestBit(C0, 0) then SetBit(Byte8, 4);
    if TestBit(C1, 0) then SetBit(Byte8, 5);
    if TestBit(C2, 0) then SetBit(Byte8, 6);
    if TestBit(C3, 0) then SetBit(Byte8, 7);
    BlockData := Add0(FNewKeyA, 6) +
                 Chr(Byte6) +
                 Chr(Byte7) +
                 Chr(Byte8) + #0 +
                 Add0(FNewKeyB, 6);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.ReadTrailer: Integer;
begin
  try
    BlockNumber := (SectorNumber+1)*4-1;
    KeyType := ktKeyA;
    FKeyUncoded := FKeyA;
    ActivateWakeup;
    Check(EncodeKey);
    if (PiccAuthKey <> 0) or (PiccRead <> 0) then
    begin
      KeyType := ktKeyB;
      FKeyUncoded := FKeyB;
      ActivateWakeup;
      Check(EncodeKey);
      Check(PiccAuth);
      Check(PiccRead);
    end;
    Check(DecodeTrailer);

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.WriteTrailer: Integer;
begin
  try
    BlockNumber := (SectorNumber+1)*4-1;
    KeyType := ktKeyA;
    FKeyUncoded := FKeyA;
    Check(EncodeTrailer);
    ActivateWakeup;
    Check(EncodeKey);
    if (PiccAuthKey <> 0) or (PiccWrite <> 0) then
    begin
      KeyType := ktKeyB;
      FKeyUncoded := FKeyB;
      ActivateWakeup;
      Check(EncodeKey);
      Check(PiccAuth);
      Check(PiccWrite);
    end;

    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.CheckAccessBits(Byte6, Byte7,
  Byte8: Integer): Boolean;
begin
  Result :=
    (TestBit(Byte6, 0) = not TestBit(Byte7, 4)) and
    (TestBit(Byte6, 1) = not TestBit(Byte7, 5)) and
    (TestBit(Byte6, 2) = not TestBit(Byte7, 6)) and
    (TestBit(Byte6, 3) = not TestBit(Byte7, 7)) and
    (TestBit(Byte6, 4) = not TestBit(Byte8, 0)) and
    (TestBit(Byte6, 5) = not TestBit(Byte8, 1)) and
    (TestBit(Byte6, 6) = not TestBit(Byte8, 2)) and
    (TestBit(Byte6, 7) = not TestBit(Byte8, 3)) and
    (TestBit(Byte7, 0) = not TestBit(Byte8, 4)) and
    (TestBit(Byte7, 1) = not TestBit(Byte8, 5)) and
    (TestBit(Byte7, 2) = not TestBit(Byte8, 6)) and
    (TestBit(Byte7, 3) = not TestBit(Byte8, 7));
end;

function TCardDriver.ValidBits(C0, C1, C2, C3: Integer): Boolean;
begin
  Result := (C0 >= 0) and (C0 <= 7) and
            (C1 >= 0) and (C1 <= 7) and
            (C2 >= 0) and (C2 <= 7) and
            (C3 >= 0) and (C3 <= 7);
end;

procedure TCardDriver.ActivateWakeup;
begin
  if PiccActivateWakeup = -1 then
    Check(PiccActivateWakeup);
end;

function TCardDriver.MksFindCard: Integer;
begin
  try
    CardReader.MksFindCard(CardATQ, FATQ, UID);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.MksReadCatalog: Integer;
begin
  try
    CardReader.MksReadCatalog(FData);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.MksReopen: Integer;
begin
  try
    CardReader.MksReopen;
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;

function TCardDriver.MksWriteCatalog: Integer;
begin
  try
    CardReader.MksWriteCatalog(FData);
    Result := ClearResult;
  except
    on E: Exception do
      Result := HandleException(E);
  end;
end;


end.
