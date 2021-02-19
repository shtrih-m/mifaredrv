unit CardSector;

interface

uses
  // VCL
  Classes,
  // This
  untTypes, untError, Notifier;

type
  TCardSector = class;
  TCardSectors = class;

  { TCardSectors }

  TCardSectors = class(TNotifyObject)
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TCardSector;
    procedure InsertItem(AItem: TCardSector);
    procedure RemoveItem(AItem: TCardSector);
  public
    constructor Create(ANotifier: TNotifier); override;
    destructor Destroy; override;

    procedure Clear;
    function Add: TCardSector;
    function ItemByNumber(Value: Integer): TCardSector;
    procedure FindAppSectors(const CardApp: TCardApplication;
      Dst: TCardSectors);
    procedure FindFreeSectors(const CardApp: TCardApplication;
      Dst: TCardSectors; CountNeeded: Integer);

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TCardSector read GetItem; default;
  end;

  { TCardSector }

  TCardSector = class(TNotifyObject)
  private
    FAppCode: Integer;          // Код приложения
    FFirmCode: Integer;         // Код фирмы
    FOwner: TCardSectors;
    procedure SetOwner(AOwner: TCardSectors);
    procedure SetAppCode(const Value: Integer);
    procedure SetFirmCode(const Value: Integer);
    function IsAppSector(const CardApp: TCardApplication): Boolean;
  public
    Number: Integer;           // Номер сектора
    constructor CreateSector(ANotifier: TNotifier; AOwner: TCardSectors);
    destructor Destroy; override;
    procedure Clear;
    function IsFree: Boolean;
    procedure Assign(Src: TCardSector);

    property AppCode: Integer read FAppCode write SetAppCode;
    property FirmCode: Integer read FFirmCode write SetFirmCode;
  end;

implementation

{ TCardSectors }

constructor TCardSectors.Create(ANotifier: TNotifier);
begin
  inherited Create(ANotifier);
  FList := TList.Create;
end;

destructor TCardSectors.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TCardSectors.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TCardSectors.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TCardSectors.GetItem(Index: Integer): TCardSector;
begin
  Result := FList[Index];
end;

procedure TCardSectors.InsertItem(AItem: TCardSector);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
  Modified;
end;

procedure TCardSectors.RemoveItem(AItem: TCardSector);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
  Modified;
end;

{ Поиск свободных секторов }

procedure TCardSectors.FindFreeSectors(const CardApp: TCardApplication;
  Dst: TCardSectors; CountNeeded: Integer);
var
  i: Integer;
  Sector: TCardSector;
  AddedCount: Integer;
begin
  AddedCount := 0;
  for i := 0 to Count-1 do
  begin
    Sector := Items[i];
    if Sector.IsFree then
    begin
      Sector.AppCode := CardApp.AppCode;
      Sector.FirmCode := CardApp.FirmCode;

      Dst.Add.Assign(Sector);
      Inc(AddedCount);
      if AddedCount = CountNeeded then Break;
    end;
  end;
  if AddedCount < CountNeeded then
    RaiseError(E_NOFREESECTOR, S_NOFREESECTOR);
end;

{ Поиск секторов от приложения CardApp }

procedure TCardSectors.FindAppSectors(const CardApp: TCardApplication;
  Dst: TCardSectors);
var
  i: Integer;
  Sector: TCardSector;
begin
  for i := 0 to Count-1 do
  begin
    Sector := Items[i];
    if Sector.IsAppSector(CardApp) then
      Dst.Add.Assign(Sector);
  end;
end;

function TCardSectors.Add: TCardSector;
begin
  Result := TCardSector.CreateSector(Notifier, Self);
end;

function TCardSectors.ItemByNumber(Value: Integer): TCardSector;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    Result := Items[i];
    if Result.Number = Value then Exit;
  end;
  Result := nil;
end;

{ TCardSector }

constructor TCardSector.CreateSector(ANotifier: TNotifier; AOwner: TCardSectors);
begin
  inherited Create(ANotifier);
  SetOwner(AOwner);
end;

destructor TCardSector.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

function TCardSector.IsFree: Boolean;
begin
  Result := FirmCode = 0;
end;

procedure TCardSector.SetOwner(AOwner: TCardSectors);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

procedure TCardSector.Clear;
begin
  AppCode := 0;
  FirmCode := 0;
end;

procedure TCardSector.Assign(Src: TCardSector);
begin
  Number := Src.Number;
  AppCode := Src.AppCode;
  FirmCode := Src.FirmCode;
end;

{ Проверка, относится ли сектор к приложению CardApp }

function TCardSector.IsAppSector(const CardApp: TCardApplication): Boolean;
begin
  Result := (FirmCode = CardApp.FirmCode)and(AppCode = CardApp.AppCode);
end;

procedure TCardSector.SetAppCode(const Value: Integer);
begin
  if Value <> AppCode then
  begin
    FAppCode := Value;
    Modified;
  end;
end;

procedure TCardSector.SetFirmCode(const Value: Integer);
begin
  if Value <> FirmCode then
  begin
    FFirmCode := Value;
    Modified;
  end;
end;

end.

