unit Notifier;

interface

uses
  // VCL
  Classes;

type
  { TNotifier }

  TNotifier = class
  private
    FIsModified: Boolean;
    FOnModify: TNotifyEvent;
  public
    procedure Modified;
    procedure ClearModified;
    property IsModified: Boolean read FIsModified;
    property OnModify: TNotifyEvent read FOnModify write FOnModify;
  end;

  { TNotifyObject }

  TNotifyObject = class
  private
    FNotifier: TNotifier;
    FIsModified: Boolean;
  public
    constructor Create(ANotifier: TNotifier); virtual;
    procedure Modified;
    procedure ClearModified;

    property Notifier: TNotifier read FNotifier;
    property IsModified: Boolean read FIsModified;
  end;

implementation

{ TNotifier }

procedure TNotifier.ClearModified;
begin
  FIsModified := False;
end;

procedure TNotifier.Modified;
begin
  if not FIsModified then
  begin
    FIsModified := True;
    if Assigned(FOnModify) then FOnModify(Self);
  end;
end;

{ TNotifyObject }

constructor TNotifyObject.Create(ANotifier: TNotifier);
begin
  inherited Create;
  FNotifier := ANotifier;
end;

procedure TNotifyObject.Modified;
begin
  if FNotifier <> nil then
    FNotifier.Modified;

  FIsModified := True;
end;

procedure TNotifyObject.ClearModified;
begin
  FIsModified := False;
end;

end.
