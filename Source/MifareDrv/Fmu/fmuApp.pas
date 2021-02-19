unit fmuApp;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  BaseForm, CardApp, untTypes, Spin;

type
  { TfmApp }

  TfmApp = class(TBaseForm)
    lblCode: TLabel;
    lblText: TLabel;
    edtName: TEdit;
    Bevel1: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    seCode: TSpinEdit;
    procedure btnOKClick(Sender: TObject);
  private
    FApps: TCardApps;
    FDialogType: TDialogType;
    procedure UpdatePage(DialogType: TDialogType; AApps: TCardApps);
  end;

function ShowAppDialog(ParentWnd: HWND; DialogType: TDialogType;
  Apps: TCardApps): Boolean;

implementation

{$R *.DFM}

function ShowAppDialog(ParentWnd: HWND; DialogType: TDialogType;
  Apps: TCardApps): Boolean;
var
  fm: TfmApp;
begin
  fm := TfmApp.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, ParentWnd);
    fm.UpdatePage(DialogType, Apps);
    Result := fm.ShowModal = mrOK;
  finally
    fm.Free;
  end;
end;

{ TfmApp }

procedure TfmApp.UpdatePage(DialogType: TDialogType; AApps: TCardApps);
var
  App: TCardApp;
begin
  FApps := AApps;
  FDialogType := DialogType;

  if DialogType = dtAdd then
  begin
    edtName.Text := 'Новое приложение';
    seCode.Value := AApps.GetFreeCode;
  end else
  begin
    App := AApps[AApps.Index];
    edtName.Text := App.Name;
    seCode.Value := App.Code;
  end;
end;

procedure TfmApp.btnOKClick(Sender: TObject);
var
  App: TCardApp;
  AppName: string;
  AppCode: Integer;
begin
  AppName := edtName.Text;
  AppCode := seCode.Value;
  if FDialogType = dtAdd then
  begin
    FApps.CheckCode(AppCode);
    App := FApps.Add;
    App.Code := AppCode;
    App.Name := AppName;
    FApps.Index := FApps.Count-1;
  end else
  begin
    App := FApps[FApps.Index];
    App.Code := AppCode;
    App.Name := AppName;
  end;
  ModalResult := mrOK;
end;

end.
