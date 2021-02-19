unit CardApp;

interface

Uses
  // VCL
  Classes, SysUtils;

type
  TCardApp = class;

  { TCardApps }

  TCardApps = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TCardApp;
    procedure Clear;
    procedure InsertItem(AItem: TCardApp);
    procedure RemoveItem(AItem: TCardApp);
  public
    Index: Integer;
    constructor Create;
    destructor Destroy; override;
    function Add: TCardApp;
    function GetFreeCode: Integer;
    procedure CheckCode(Value: Integer);
    function IsEqual(Src: TCardApps): Boolean;
    function ItemByCode(Value: Integer): TCardApp;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TCardApp read GetItem; default;
  end;

  { TCardApp }

  TCardApp = class
  private
    FCode: Integer;
    FOwner: TCardApps;
    procedure SetOwner(AOwner: TCardApps);
    function IsEqual(Src: TCardApp): Boolean;
    procedure SetCode(Value: Integer);
    function GetDisplayText: string;
  public
    Name: string;
    constructor Create(AOwner: TCardApps);
    destructor Destroy; override;

    property Owner: TCardApps read FOwner;
    property Code: Integer read FCode write SetCode;
    property DisplayText: string read GetDisplayText;
  end;

implementation

{ TCardApps }

constructor TCardApps.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TCardApps.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TCardApps.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TCardApps.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TCardApps.GetItem(Index: Integer): TCardApp;
begin
  Result := FList[Index];
end;

procedure TCardApps.InsertItem(AItem: TCardApp);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TCardApps.RemoveItem(AItem: TCardApp);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TCardApps.IsEqual(Src: TCardApps): Boolean;
var
  i: Integer;
begin
  Result := Count = Src.Count;
  if not Result then Exit;

  for i := 0 to Count-1 do
  begin
    Result := Items[i].IsEqual(Src[i]);
    if not Result then Exit;
  end;
end;

function TCardApps.Add: TCardApp;
begin
  Result := TCardApp.Create(Self);
end;

function TCardApps.ItemByCode(Value: Integer): TCardApp;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    Result := Items[i];
    if Result.Code = Value then Exit;
  end;
  Result := nil;
end;

function TCardApps.GetFreeCode: Integer;
var
  i: Integer;
begin
  for i := 0 to 255 do
  begin
    Result := i;
    if ItemByCode(i) = nil then Exit;
  end;
end;

procedure TCardApps.CheckCode(Value: Integer);
begin
  if (Value < 0)or(Value > 255) then
    raise Exception.Create('Код должен быть в диапазоне 0..255.');

  if ItemByCode(Value) <> nil then
    raise Exception.CreateFmt('Приложение с кодом %d уже существует.', [Value]);
end;

{ TCardApp }

constructor TCardApp.Create(AOwner: TCardApps);
begin
  inherited Create;
  SetOwner(AOwner);
end;

destructor TCardApp.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TCardApp.SetOwner(AOwner: TCardApps);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

function TCardApp.IsEqual(Src: TCardApp): Boolean;
begin
  Result := (Code = Src.Code)and(Name = Src.Name);
end;

procedure TCardApp.SetCode(Value: Integer);
begin
  if Value <> Code then
  begin
    FOwner.CheckCode(Value);
    FCode := Value;
  end;
end;

function TCardApp.GetDisplayText: string;
begin
  Result := Format('0x%.2x, %s', [Code, Name]);
end;

end.
