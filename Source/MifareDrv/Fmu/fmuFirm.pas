unit fmuFirm;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  BaseForm, CardFirm, untTypes;

type
  { TfmFirm }

  TfmFirm = class(TBaseForm)
    lblCode: TLabel;
    edtCode: TEdit;
    lblText: TLabel;
    edtName: TEdit;
    Bevel1: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
  private
    FFirms: TCardFirms;
    FDialogType: TDialogType;
    procedure UpdatePage(DialogType: TDialogType; AFirms: TCardFirms);
  end;

function ShowFirmDialog(ParentWnd: HWND; DialogType: TDialogType;
  Firms: TCardFirms): Boolean;

implementation

{$R *.DFM}

function ShowFirmDialog(ParentWnd: HWND; DialogType: TDialogType;
  Firms: TCardFirms): Boolean;
var
  fm: TfmFirm;
begin
  fm := TfmFirm.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, ParentWnd);
    fm.UpdatePage(DialogType, Firms);
    Result := fm.ShowModal = mrOK;
  finally
    fm.Free;
  end;
end;

{ TfmFirm }

procedure TfmFirm.UpdatePage(DialogType: TDialogType; AFirms: TCardFirms);
var
  Firm: TCardFirm;
begin
  FFirms := AFirms;
  FDialogType := DialogType;

  if DialogType = dtAdd then
  begin
    edtName.Text := 'Новая фирма';
    edtCode.Text := IntToHex(AFirms.GetFreeCode, 2);
  end else
  begin
    Firm := AFirms[AFirms.Index];
    edtName.Text := Firm.Name;
    edtCode.Text := IntToHex(Firm.Code, 2);
  end;
end;

procedure TfmFirm.btnOKClick(Sender: TObject);
var
  Firm: TCardFirm;
  FirmName: string;
  FirmCode: Integer;
begin
  FirmName := edtName.Text;
  FirmCode := StrToInt('$' + edtCode.Text);
  if FDialogType = dtAdd then
  begin
    FFirms.CheckCode(FirmCode);
    Firm := FFirms.Add;
    Firm.Code := FirmCode;
    Firm.Name := FirmName;
    FFirms.Index := FFirms.Count-1;
  end else
  begin
    Firm := FFirms[FFirms.Index];
    Firm.Code := FirmCode;
    Firm.Name := FirmName;
  end;
  ModalResult := mrOK;
end;

end.
