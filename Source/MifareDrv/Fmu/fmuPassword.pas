unit fmuPassword;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  BaseForm, untUtil;

type
  { TfmPassword }

  TfmPassword = class(TBaseForm)
    Image1: TImage;
    lblErrorText: TLabel;
    edtPassword: TEdit;
    btnCancel: TButton;
    lblPassword: TLabel;
    btnOK: TButton;
    Bevel1: TBevel;
    rbText: TRadioButton;
    rbHex: TRadioButton;
    Label1: TLabel;
    procedure btnOKClick(Sender: TObject);
  private
    FPassword: string;
  end;

function ShowErrorDlg(ParentWnd: HWND; const ErrorText: string;
  var Password: string): Boolean;

implementation

{$R *.DFM}

function ShowErrorDlg(ParentWnd: HWND; const ErrorText: string;
  var Password: string): Boolean;
var
  fm: TfmPassword;
begin
  fm := TfmPassword.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, ParentWnd);
    fm.lblErrorText.Caption := ErrorText;
    Result := fm.ShowModal = mrOK;
    if Result then
      Password := fm.FPassword;
  finally
    fm.Free;
  end;
end;

procedure TfmPassword.btnOKClick(Sender: TObject);
begin
  if rbText.Checked then FPassword := edtPassword.Text
  else FPassword := HexToStr(edtPassword.Text);
  ModalResult := mrOK;
end;

end.
