unit untDrvLink;

interface

uses
  // VCL
  Classes,
  // This
  CardDriver;

type
  TDriverLink = class;

  { TDriverLinks }

  TDriverLinks = class
  private
    FList: TList;
    FDriver: TCardDriver;
    procedure Clear;
    procedure InsertItem(AItem: TDriverLink);
    procedure RemoveItem(AItem: TDriverLink);
    function GetCount: Integer;
    function GetItem(Index: Integer): TDriverLink;
  public
    constructor Create;
    destructor Destroy; override;

    property Driver: TCardDriver read FDriver;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDriverLink read GetItem; default;
  end;

  { TDriverLink }

  TDriverLink = class
  private
    FOwner: TDriverLinks;
    function GeTCardDriver: TCardDriver;
    procedure SetOwner(AOwner: TDriverLinks);
  public
    constructor Create;
    destructor Destroy; override;
    property Driver: TCardDriver read GeTCardDriver;
  end;

implementation

var
  DrvLinks: TDriverLinks;

function GetDriverLinks: TDriverLinks;
begin
  if DrvLinks = nil then
    DrvLinks := TDriverLinks.Create;
  Result := DrvLinks;
end;

{ TDriverLinks }

constructor TDriverLinks.Create;
begin
  inherited Create;
  FList := TList.Create;
  FDriver := TCardDriver.Create;
end;

destructor TDriverLinks.Destroy;
begin
  Clear;
  FList.Free;
  FDriver.Free;
  DrvLinks := nil;
  inherited Destroy;
end;

procedure TDriverLinks.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TDriverLinks.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDriverLinks.GetItem(Index: Integer): TDriverLink;
begin
  Result := FList[Index];
end;

procedure TDriverLinks.InsertItem(AItem: TDriverLink);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TDriverLinks.RemoveItem(AItem: TDriverLink);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

{ TDriverLink }

constructor TDriverLink.Create;
begin
  inherited Create;
  SetOwner(GetDriverLinks);
end;

destructor TDriverLink.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TDriverLink.SetOwner(AOwner: TDriverLinks);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

function TDriverLink.GeTCardDriver: TCardDriver;
begin
  Result := FOwner.Driver;
end;

end.
