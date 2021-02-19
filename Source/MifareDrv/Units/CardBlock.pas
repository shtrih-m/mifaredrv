unit CardBlock;

interface

Uses
  // VCL
  Classes;

type
  TCardBlock = class;

  { TCardBlocks }

  TCardBlocks = class
  private
    FList: TList;
    function GetData: string;
    function GetCount: Integer;
    procedure SetData(Data: string);
    procedure InsertItem(AItem: TCardBlock);
    procedure RemoveItem(AItem: TCardBlock);
    function GetItem(Index: Integer): TCardBlock;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Size: Integer;
    function Add: TCardBlock;
    procedure AddBlocks(Src: TCardBlocks);

    property Count: Integer read GetCount;
    property Data: string read GetData write SetData;
    property Items[Index: Integer]: TCardBlock read GetItem; default;
  end;

  { TCardBlock }

  TCardBlock = class
  private
    FOwner: TCardBlocks;
    procedure SetOwner(AOwner: TCardBlocks);
  public
    Data: string;               // Данные блока
    Size: Integer;              // Размер блока
    Number: Integer;            // Номер блока
    IsDataBlock: Boolean;       // Блок является блоком данных
    SectorNumber: Integer;      // Номер сектора
    constructor Create(AOwner: TCardBlocks);
    destructor Destroy; override;
    procedure Assign(Src: TCardBlock);
  end;

implementation

{ TCardBlocks }

constructor TCardBlocks.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TCardBlocks.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TCardBlocks.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TCardBlocks.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TCardBlocks.GetItem(Index: Integer): TCardBlock;
begin
  Result := FList[Index];
end;

procedure TCardBlocks.InsertItem(AItem: TCardBlock);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TCardBlocks.RemoveItem(AItem: TCardBlock);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TCardBlocks.Add: TCardBlock;
begin
  Result := TCardBlock.Create(Self);
end;

function TCardBlocks.Size: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count-1 do
  begin
    if Items[i].IsDataBlock then
      Result := Result + Items[i].Size;
  end;
end;

function TCardBlocks.GetData: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Count-1 do
  begin
    if Items[i].IsDataBlock then
      Result := Result + Items[i].Data;
  end;
end;

{ Размер блоков может быть больше или меньше чем размер данных }
{ А мы об этом не узнаем... Нехорошо...}

procedure TCardBlocks.SetData(Data: string);
var
  i: Integer;
  Block: TCardBlock;
begin
  for i := 0 to Count-1 do
  begin
    Block := Items[i];
    if Block.IsDataBlock then
    begin
      Block.Data := Copy(Data, 1, Block.Size);
      Data := Copy(Data, 1 + Block.Size, Length(Data));
      if Data = '' then Break;
    end;
  end;
end;

procedure TCardBlocks.AddBlocks(Src: TCardBlocks);
var
  i: Integer;
begin
  for i := 0 to Src.Count-1 do
    Add.Assign(Src[i]);
end;

{ TCardBlock }

procedure TCardBlock.Assign(Src: TCardBlock);
begin
  Data := Src.Data;
  Size := Src.Size;
  Number := Src.Number;
end;

constructor TCardBlock.Create(AOwner: TCardBlocks);
begin
  inherited Create;
  SetOwner(AOwner);
end;

destructor TCardBlock.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TCardBlock.SetOwner(AOwner: TCardBlocks);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;  
end;

end.
