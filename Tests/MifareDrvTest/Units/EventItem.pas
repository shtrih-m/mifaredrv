unit EventItem;

interface

Uses
  // VCL
  Classes;

type
  TEventItem = class;

  { TEventItems }

  TEventItems = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TEventItem;
    procedure InsertItem(AItem: TEventItem);
    procedure RemoveItem(AItem: TEventItem);
  public
    constructor Create;
    destructor Destroy; override;
    
    procedure Clear;
    function Add(ASender: TObject; AEventID, AThreadID: Integer): TEventItem;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TEventItem read GetItem; default;
  end;

  { TEventItem }

  TEventItem = class
  private
    FSender: TObject;
    FEventID: Integer;
    FThreadID: Integer;
    FOwner: TEventItems;
    procedure SetOwner(AOwner: TEventItems);
  public
    constructor Create(AOwner: TEventItems; ASender: TObject; AEventID, AThreadID: Integer);
    destructor Destroy; override;

    property Sender: TObject read FSender;
    property EventID: Integer read FEventID;
    property ThreadID: Integer read FThreadID;
  end;

implementation

{ TEventItems }

constructor TEventItems.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TEventItems.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TEventItems.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TEventItems.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TEventItems.GetItem(Index: Integer): TEventItem;
begin
  Result := FList[Index];
end;

procedure TEventItems.InsertItem(AItem: TEventItem);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TEventItems.RemoveItem(AItem: TEventItem);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TEventItems.Add(ASender: TObject; AEventID,
  AThreadID: Integer): TEventItem;
begin
  Result := TEventItem.Create(Self, ASender, AEventID, AThreadID);
end;

{ TEventItem }

constructor TEventItem.Create(AOwner: TEventItems;
  ASender: TObject; AEventID, AThreadID: Integer);
begin
  inherited Create;
  FSender := ASender;
  FEventID := AEventID;
  FThreadID := AThreadID;
  SetOwner(AOwner);
end;

destructor TEventItem.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TEventItem.SetOwner(AOwner: TEventItems);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;  
end;

end.
