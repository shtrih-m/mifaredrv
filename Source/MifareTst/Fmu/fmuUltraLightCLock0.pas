unit fmuUltraLightCLock0;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  // This
  untUtil;

type
  TfmUltraLightCLock0 = class(TForm)
    gbLockPage: TGroupBox;
    chbLockPage4: TCheckBox;
    chbLockPage5: TCheckBox;
    chbLockPage6: TCheckBox;
    chbLockPage15: TCheckBox;
    chbLockPage14: TCheckBox;
    chbLockPage13: TCheckBox;
    chbLockPage12: TCheckBox;
    chbLockPage11: TCheckBox;
    chbLockPage10: TCheckBox;
    chbLockPage9: TCheckBox;
    chbLockPage8: TCheckBox;
    chbLockPage7: TCheckBox;
    chbLockOTP: TCheckBox;
    chbLockBits15_10: TCheckBox;
    chbLockBits_9_4: TCheckBox;
    chbLockBitsOTP: TCheckBox;
    lblOTP: TLabel;
    Label1: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    Bevel1: TBevel;
    edtValue: TEdit;
    lblValue: TLabel;
    btnReset: TButton;
    lblInfo: TLabel;
    procedure chbLockPage15Click(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    Value1: Integer;
    Value2: Integer;
    procedure UpdatePage;
    procedure UpdateObject;
  end;

var
  fmUltraLightCLock0: TfmUltraLightCLock0;

function ShowLockBytes0(var Value: Integer): Boolean;

implementation

{$R *.dfm}

function ShowLockBytes0(var Value: Integer): Boolean;
var
  fm: TfmUltraLightCLock0;
begin
  fm := TfmUltraLightCLock0.Create(Application);
  try
    fm.Value1 := Value;
    fm.Value2 := Value;
    fm.UpdatePage;
    Result := fm.ShowModal = mrOK;
    if Result then
    begin
      fm.UpdateObject;
      Value := fm.Value1;
    end;
  finally
    fm.Free;
  end;
end;

{ TfmUltraLightCLock0 }

procedure TfmUltraLightCLock0.chbLockPage15Click(Sender: TObject);
begin
  UpdateObject;
end;

procedure TfmUltraLightCLock0.UpdateObject;
begin
  Value1 := 0;
  if chbLockPage15.Checked then SetBit(Value1, 15);
  if chbLockPage14.Checked then SetBit(Value1, 14);
  if chbLockPage13.Checked then SetBit(Value1, 13);
  if chbLockPage12.Checked then SetBit(Value1, 12);
  if chbLockPage11.Checked then SetBit(Value1, 11);
  if chbLockPage10.Checked then SetBit(Value1, 10);
  if chbLockPage9.Checked then SetBit(Value1, 9);
  if chbLockPage8.Checked then SetBit(Value1, 8);
  if chbLockPage7.Checked then SetBit(Value1, 7);
  if chbLockPage6.Checked then SetBit(Value1, 6);
  if chbLockPage5.Checked then SetBit(Value1, 5);
  if chbLockPage4.Checked then SetBit(Value1, 4);
  if chbLockOTP.Checked then SetBit(Value1, 3);
  if chbLockBits15_10.Checked then SetBit(Value1, 2);
  if chbLockBits_9_4.Checked then SetBit(Value1, 1);
  if chbLockBitsOTP.Checked then SetBit(Value1, 0);
  edtValue.Text := Format('%.2x %.2x', [Lo(Value1), Hi(Value1)]);
end;

procedure TfmUltraLightCLock0.UpdatePage;
begin
  SafeSetChecked(chbLockPage15, TestBit(Value1, 15));
  SafeSetChecked(chbLockPage14, TestBit(Value1, 14));
  SafeSetChecked(chbLockPage13, TestBit(Value1, 13));
  SafeSetChecked(chbLockPage12, TestBit(Value1, 12));
  SafeSetChecked(chbLockPage11, TestBit(Value1, 11));
  SafeSetChecked(chbLockPage10, TestBit(Value1, 10));
  SafeSetChecked(chbLockPage9, TestBit(Value1, 9));
  SafeSetChecked(chbLockPage8, TestBit(Value1, 8));
  SafeSetChecked(chbLockPage7, TestBit(Value1, 7));
  SafeSetChecked(chbLockPage6, TestBit(Value1, 6));
  SafeSetChecked(chbLockPage5, TestBit(Value1, 5));
  SafeSetChecked(chbLockPage4, TestBit(Value1, 4));
  SafeSetChecked(chbLockOTP, TestBit(Value1, 3));
  SafeSetChecked(chbLockBits15_10, TestBit(Value1, 2));
  SafeSetChecked(chbLockBits_9_4, TestBit(Value1, 1));
  SafeSetChecked(chbLockBitsOTP, TestBit(Value1, 0));
  edtValue.Text := Format('%.2x %.2x', [Lo(Value1), Hi(Value1)]);
end;

procedure TfmUltraLightCLock0.btnResetClick(Sender: TObject);
begin
  Value1 := Value2;
  UpdatePage;
end;

end.
