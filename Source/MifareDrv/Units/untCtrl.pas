unit untCtrl;

interface

uses
  // VCL
  Windows, Messages, Classes, Controls, Graphics, ExtCtrls,
  // This
  LogFile;

type
  { TAxCtrl }

  TAxCtrl = class(TCustomControl)
  private
    FBitmap: TBitmap;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    property Bitmap: TBitmap read FBitmap;
  protected
    procedure Paint; override;
    function GetPalette: HPALETTE; override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.RES}

{ TAxCtrl }

constructor TAxCtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csOpaque, csFixedWidth, csFixedHeight,
    csReplicatable, csNoStdEvents];
  FBitmap := TBitmap.Create;
  FBitmap.LoadFromResourceID(hInstance, 1);
  FBitmap.Transparent := True;

  Width := 40;
  Height := 40;
end;

destructor TAxCtrl.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

procedure TAxCtrl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

function TAxCtrl.GetPalette: HPALETTE;
begin
  Result := 0;
  if not Bitmap.Empty then
    Result := Bitmap.Palette;
end;

procedure TAxCtrl.WMWindowPosChanged(
  var Message: TWMWindowPosChanged);
begin
  Invalidate;
  inherited;
end;

procedure TAxCtrl.Paint;
var
  R: TRect;
  LeftBound, TopBound: WORD;
begin
  R := GetClientRect;
  Frame3D(Canvas, R, clBtnHighlight, clBtnShadow, 1);
  with Canvas do
  begin
    Brush.Color := Color;
    FillRect(R);
  end;
  if not Bitmap.Empty then
  begin
    LeftBound := Round(R.Left + (R.Right - R.Left) / 2 - Bitmap.Width / 2);
    TopBound := Round(R.Top - (R.Top - R.Bottom) / 2 - Bitmap.Height / 2);
    Canvas.Draw(LeftBound, TopBound, Bitmap);
  end;
end;

end.
