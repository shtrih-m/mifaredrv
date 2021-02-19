unit ListItem;

interface

Uses
  // VCL
  Classes;

type
  TListItem = class;

  { TListItems }

  TListItems = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TListItem;
    procedure Clear;
    procedure InsertItem(AItem: TListItem);
    procedure RemoveItem(AItem: TListItem);
  public
    constructor Create;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TListItem read GetItem; default;
  end;

  { TListItem }

  TListItem = class
  private
    FOwner: TListItems;
    procedure SetOwner(AOwner: TListItems);
  public
    constructor Create(AOwner: TListItems);
    destructor Destroy; override;
  end;

implementation

{ TListItems }

constructor TListItems.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TListItems.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TListItems.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TListItems.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TListItems.GetItem(Index: Integer): TListItem;
begin
  Result := FList[Index];
end;

procedure TListItems.InsertItem(AItem: TListItem);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TListItems.RemoveItem(AItem: TListItem);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

{ TListItem }

constructor TListItem.Create(AOwner: TListItems);
begin
  inherited Create;
  SetOwner(AOwner);
end;

destructor TListItem.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TListItem.SetOwner(AOwner: TListItems);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;  
end;

end.
