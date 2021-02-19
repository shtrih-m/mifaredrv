unit untAddin;

interface

uses
  // VCL
  Windows, Classes, SysUtils;

type
  TAddinItem = class;

  { TAddinItems }

  TAddinItems = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TAddinItem;
    procedure InsertItem(AItem: TAddinItem);
    procedure RemoveItem(AItem: TAddinItem);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function ItemByEngName(const Value: string): TAddinItem;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TAddinItem read GetItem; default;
  end;

  { TAddinItem }

  TAddinItem = class
  private
    FOwner: TAddinItems;
    procedure SetOwner(AOwner: TAddinItems);
  public
    MemId: Integer;
    EngName: string;
    RusName: string;
    IsReadable: Boolean;
    IsWritable: Boolean;
    vt: DWORD;
    constructor Create(AOwner: TAddinItems);
    destructor Destroy; override;
  end;


implementation

{ TAddinItems }

constructor TAddinItems.Create;
begin
  Inherited Create;
  FList := TList.Create;
end;

destructor TAddinItems.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TAddinItems.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TAddinItems.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TAddinItems.GetItem(Index: Integer): TAddinItem;
begin
  Result := FList[Index];
end;

procedure TAddinItems.InsertItem(AItem: TAddinItem);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TAddinItems.RemoveItem(AItem: TAddinItem);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TAddinItems.ItemByEngName(const Value: string): TAddinItem;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Result := Items[i];
    if AnsiCompareText(Result.EngName, Value) = 0 then Exit;
  end;
  Result := nil;
end;

{ TAddinItem }

constructor TAddinItem.Create(AOwner: TAddinItems);
begin
  inherited Create;
  SetOwner(AOwner);
end;

destructor TAddinItem.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TAddinItem.SetOwner(AOwner: TAddinItems);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

end.
