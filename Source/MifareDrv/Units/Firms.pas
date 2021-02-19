unit Firms;

interface

Uses
  // VCL
  Classes;

type
  TOwnedClass = class;

  { TOwnerClass }

  TOwnerClass = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TOwnedClass;
    procedure Clear;
    procedure InsertItem(AItem: TOwnedClass);
    procedure RemoveItem(AItem: TOwnedClass);
  public
    constructor Create;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TOwnedClass read GetItem; default;
  end;

  { TOwnedClass }

  TOwnedClass = class
  private
    FOwner: TOwnerClass;
    procedure SetOwner(AOwner: TOwnerClass);
  public
    constructor Create(AOwner: TOwnerClass);
    destructor Destroy; override;
  end;

implementation

{ TOwnerClass }

constructor TOwnerClass.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TOwnerClass.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TOwnerClass.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TOwnerClass.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TOwnerClass.GetItem(Index: Integer): TOwnedClass;
begin
  Result := FList[Index];
end;

procedure TOwnerClass.InsertItem(AItem: TOwnedClass);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TOwnerClass.RemoveItem(AItem: TOwnedClass);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

{ TOwnedClass }

constructor TOwnedClass.Create(AOwner: TOwnerClass);
begin
  inherited Create;
  SetOwner(AOwner);
end;

destructor TOwnedClass.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TOwnedClass.SetOwner(AOwner: TOwnerClass);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;  
end;

end.
