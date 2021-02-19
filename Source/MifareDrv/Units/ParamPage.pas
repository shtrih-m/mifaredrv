unit ParamPage;

interface

Uses
  // VCL
  Windows, Classes, SysUtils, Forms, Grids, Controls, ComObj,
  // This
  BaseForm, MifareLib_TLB;

type
  TParamPage  = class;

  { TParamPages }

  TParamPages = class
  private
    FList: TList;
    FDriver: IMifareDrv3;
    FPageIndex: Integer;

    function GetCount: Integer;
    function GetItem(Index: Integer): TParamPage;
    function GetItemIndex(AItem: TParamPage): Integer;
    procedure InsertItem(AItem: TParamPage);
    procedure RemoveItem(AItem: TParamPage);
  public
    constructor Create(ADriver: IMifareDrv3);
    destructor Destroy; override;
    procedure UpdatePage;
    procedure UpdateObject;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TParamPage read GetItem; default;
    property PageIndex: Integer read FPageIndex write FPageIndex;
  end;

  { TParamPage }

  TParamPage = class(TBaseForm)
  private
    FOwner: TParamPages;
    function GetIndex: Integer;
    function GetDriver: IMifareDrv3;
  protected
    procedure UpdateAllPages;
  public
    destructor Destroy; override;
    procedure SetOwner(AOwner: TParamPages);

    procedure UpdatePage; virtual;
    procedure SetDefaults; virtual;
    procedure UpdateObject; virtual;
    procedure Check(ResultCode: Integer);

    property Index: Integer read GetIndex;
    property Driver: IMifareDrv3 read GetDriver;
  end;
  TParamPageClass = class of TParamPage;

implementation

const
  SDriverName = 'Äנאיגונ Mifare';

{ TParamPages }

constructor TParamPages.Create(ADriver: IMifareDrv3);
begin
  inherited Create;
  FDriver := ADriver;
  FPageIndex := -1;
end;

destructor TParamPages.Destroy;
begin
  while Count > 0 do Items[0].Free;
  FDriver := nil;
  inherited Destroy;
end;

function TParamPages.GetCount: Integer;
begin
  if FList = nil then
    Result := 0
  else
    Result := FList.Count;
end;

function TParamPages.GetItem(Index: Integer): TParamPage;
begin
  Result := FList[Index];
end;

function TParamPages.GetItemIndex(AItem: TParamPage): Integer;
begin
  Result := FList.IndexOf(AItem);
end;

procedure TParamPages.InsertItem(AItem: TParamPage);
begin
  if FList = nil then FList := TList.Create;
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TParamPages.RemoveItem(AItem: TParamPage);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
  if FList.Count = 0 then
  begin
    FList.Free;
    FList := nil;
  end;
end;

procedure TParamPages.UpdateObject;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].UpdateObject;
end;

procedure TParamPages.UpdatePage;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].UpdatePage;
end;

{ TParamPage }

destructor TParamPage.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TParamPage.SetOwner(AOwner: TParamPages);
begin
  if FOwner <> nil then FOwner.RemoveItem(Self);
  if AOwner <> nil then AOwner.InsertItem(Self);
end;

function TParamPage.GetDriver: IMifareDrv3;
begin
  Result := FOwner.FDriver;
end;

function TParamPage.GetIndex: Integer;
begin
  Result := FOwner.GetItemIndex(Self);
end;

procedure TParamPage.UpdateObject;
begin

end;

procedure TParamPage.UpdatePage;
begin

end;

procedure TParamPage.Check(ResultCode: Integer);
var
  S: string;
begin
  if ResultCode <> 0 then
  begin
    S := Format('(%d) %s', [Driver.ResultCode, Driver.ResultDescription]);
    MessageBox(GetActiveWindow, PChar(S), PChar(SDriverName), MB_ICONERROR);
  end;
end;

procedure TParamPage.SetDefaults;
begin
  { !!! }
end;

procedure TParamPage.UpdateAllPages;
begin
  TParamPages(FOwner).UpdatePage;
end;

end.
