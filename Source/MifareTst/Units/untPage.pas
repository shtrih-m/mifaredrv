unit untPage;

interface

Uses
  // VCL
  Windows, Classes, SysUtils, Forms, Grids, Controls, ComObj, StdCtrls,
  // This
  MifareLib_TLB, BaseForm;

type
  TPage  = class;

  { TPages }

  TPages = class
  private
    FList: TList;
    FDriver: TMifareDrv;
    FOnShowResult: TNotifyEvent;
    procedure ShowResult;
    function GetCount: Integer;
    function GetItem(Index: Integer): TPage;
    function GetItemIndex(AItem: TPage): Integer;
    procedure InsertItem(AItem: TPage);
    procedure RemoveItem(AItem: TPage);
  public
    constructor Create(ADriver: TMifareDrv);
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPage read GetItem; default;
    property OnShowResult: TNotifyEvent read FOnShowResult write FOnShowResult;
  end;

  { TPage }

  TPage = class(TBaseForm)
  private
    FOwner: TPages;
    function GetIndex: Integer;
    function GetDriver: TMifareDrv;
  public
    destructor Destroy; override;
    procedure UpdatePage; virtual;
    procedure SetOwner(AOwner: TPages);
    procedure Check(ResultCode: Integer);
    procedure EnableButtons(Value: Boolean); override;
    property Index: Integer read GetIndex;
    property Driver: TMifareDrv read GetDriver;
  end;
  TPageClass = class of TPage;

var
  OperationTime: DWORD;

const
  KeyTypes: array [Boolean] of TKeyType = (ktKeyB, ktKeyA);

implementation

{ TPages }

constructor TPages.Create(ADriver: TMifareDrv);
begin
  inherited Create;
  FDriver := ADriver;
end;

destructor TPages.Destroy;
begin
  while Count > 0 do Items[0].Free;
  inherited Destroy;
end;

function TPages.GetCount: Integer;
begin
  if FList = nil then
    Result := 0
  else
    Result := FList.Count;
end;

function TPages.GetItem(Index: Integer): TPage;
begin
  Result := FList[Index];
end;

function TPages.GetItemIndex(AItem: TPage): Integer;
begin
  Result := FList.IndexOf(AItem);
end;

procedure TPages.InsertItem(AItem: TPage);
begin
  if FList = nil then FList := TList.Create;
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TPages.RemoveItem(AItem: TPage);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
  if FList.Count = 0 then
  begin
    FList.Free;
    FList := nil;
  end;
end;

procedure TPages.ShowResult;
begin
  if Assigned(FOnShowResult) then FOnShowResult(Self);
end;

{ TPage }

destructor TPage.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TPage.SetOwner(AOwner: TPages);
begin
  if FOwner <> nil then FOwner.RemoveItem(Self);
  if AOwner <> nil then AOwner.InsertItem(Self);
end;

function TPage.GetDriver: TMifareDrv;
begin
  Result := FOwner.FDriver;
end;

function TPage.GetIndex: Integer;
begin
  Result := FOwner.GetItemIndex(Self);
end;

procedure TPage.UpdatePage;
begin

end;

procedure TPage.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

procedure TPage.EnableButtons(Value: Boolean);
begin
  inherited EnableButtons(Value);
  if Value then
  begin
    OperationTime := GetTickCount - OperationTime;
    FOwner.ShowResult;
  end else
  begin
    OperationTime := GetTickCount;
  end;
end;

end.
