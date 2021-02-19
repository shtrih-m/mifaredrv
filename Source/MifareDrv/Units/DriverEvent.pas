unit DriverEvent;

interface

Uses
  // VCL
  Classes, SyncObjs;

const
  EVENT_TYPE_CARD_FOUND = 0;
  EVENT_TYPE_POLL_ERROR = 1;

type
  TDriverEvent = class;

  { TDriverEventRec }

  TDriverEventRec = record
    ID: Integer;
    ErrorText: string;
    DriverID: Integer;
    EventType: Integer;
    ErrorCode: Integer;
    PortNumber: Integer;
    CardUIDHex: string;
  end;

  { TDriverEvents }

  TDriverEvents = class
  private
    FList: TList;
    FCS: TCriticalSection;
    function GetCount: Integer;
    procedure InsertItem(AItem: TDriverEvent);
    procedure RemoveItem(AItem: TDriverEvent);
    function GetItem(Index: Integer): TDriverEvent;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Lock;
    procedure Unlock;
    function ItemByID(const ID: Integer): TDriverEvent;
    function Add(const AData: TDriverEventRec): TDriverEvent;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDriverEvent read GetItem; default;
  end;

  { TDriverEvent }

  TDriverEvent = class
  private
    FID: Integer;
    FDelivered: Boolean;
    FOwner: TDriverEvents;
    FData: TDriverEventRec;
    procedure SetOwner(AOwner: TDriverEvents);
  public
    constructor Create(AOwner: TDriverEvents; const AData: TDriverEventRec);
    destructor Destroy; override;

    property ID: Integer read FID;
    property Data: TDriverEventRec read FData;
    property DriverID: Integer read FData.DriverID;
    property ErrorText: string read FData.ErrorText;
    property ErrorCode: Integer read FData.ErrorCode;
    property EventType: Integer read FData.EventType;
    property PortNumber: Integer read FData.PortNumber;
    property Delivered: Boolean read FDelivered write FDelivered;
  end;

implementation

{ TDriverEvents }

constructor TDriverEvents.Create;
begin
  inherited Create;
  FList := TList.Create;
  FCS := TCriticalSection.Create;
end;

destructor TDriverEvents.Destroy;
begin
  Clear;
  FCS.Free;
  FList.Free;
  inherited Destroy;
end;

procedure TDriverEvents.Clear;
begin
  while Count > 0 do
    Items[0].Free;
end;

function TDriverEvents.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDriverEvents.GetItem(Index: Integer): TDriverEvent;
begin
  Result := FList[Index];
end;

procedure TDriverEvents.InsertItem(AItem: TDriverEvent);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TDriverEvents.RemoveItem(AItem: TDriverEvent);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TDriverEvents.Add(const AData: TDriverEventRec): TDriverEvent;
begin
  Result := TDriverEvent.Create(Self, AData);
end;

function TDriverEvents.ItemByID(const ID: Integer): TDriverEvent;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    Result := Items[i];
    if Result.ID = ID then Exit;
  end;
  Result := nil;
end;

procedure TDriverEvents.Lock;
begin
  FCS.Enter;
end;

procedure TDriverEvents.Unlock;
begin
  FCS.Leave;
end;

{ TDriverEvent }

constructor TDriverEvent.Create(AOwner: TDriverEvents;
  const AData: TDriverEventRec);
const
  LastID: Integer = 0;
begin
  inherited Create;
  FData := AData;
  Inc(LastID); FID := LastID;
  SetOwner(AOwner);
end;

destructor TDriverEvent.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TDriverEvent.SetOwner(AOwner: TDriverEvents);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;  
end;

end.
