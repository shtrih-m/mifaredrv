unit fmuUltraLightCLock2;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  // This
  untUtil;

type
  TfmUltraLightCLock2 = class(TForm)
    gbLockPage: TGroupBox;
    chbLockPage16_19: TCheckBox;
    chbLockPage42: TCheckBox;
    chbLockPage41: TCheckBox;
    chbLockPage20_23: TCheckBox;
    chbLockPage24_27: TCheckBox;
    chbLockPage28_31: TCheckBox;
    chbLockPage32_35: TCheckBox;
    chbLockPage36_39: TCheckBox;
    chbLockPage43: TCheckBox;
    btnCancel: TButton;
    btnOK: TButton;
    Bevel1: TBevel;
    edtValue: TEdit;
    lblValue: TLabel;
    btnReset: TButton;
    chbLockPage44_47: TCheckBox;
    chbLockBitKey: TCheckBox;
    chbLockBitAuth1: TCheckBox;
    chbLockBitAuth0: TCheckBox;
    chbLockBitCount: TCheckBox;
    chbLOckBits5_7: TCheckBox;
    chbLockBits1_3: TCheckBox;
    lblInfo: TLabel;
    procedure chbLockPage16_19Click(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
  private
    Value1: Integer;
    Value2: Integer;
    procedure UpdatePage;
    procedure UpdateObject;
  end;

var
  fmUltraLightCLock2: TfmUltraLightCLock2;

function ShowLockBytes2(var Value: Integer): Boolean;

implementation

{$R *.dfm}

function ShowLockBytes2(var Value: Integer): Boolean;
var
  fm: TfmUltraLightCLock2;
begin
  fm := TfmUltraLightCLock2.Create(Application);
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

procedure TfmUltraLightCLock2.chbLockPage16_19Click(Sender: TObject);
begin
  UpdateObject;
end;

procedure TfmUltraLightCLock2.UpdatePage;
begin
  SafeSetChecked(chbLockPage44_47, TestBit(Value1, 15));
  SafeSetChecked(chbLockPage43, TestBit(Value1, 14));
  SafeSetChecked(chbLockPage42, TestBit(Value1, 13));
  SafeSetChecked(chbLockPage41, TestBit(Value1, 12));
  SafeSetChecked(chbLockBitKey, TestBit(Value1, 11));
  SafeSetChecked(chbLockBitAuth1, TestBit(Value1, 10));
  SafeSetChecked(chbLockBitAuth0, TestBit(Value1, 9));
  SafeSetChecked(chbLockBitCount, TestBit(Value1, 8));
  SafeSetChecked(chbLockPage36_39, TestBit(Value1, 7));
  SafeSetChecked(chbLockPage32_35, TestBit(Value1, 6));
  SafeSetChecked(chbLockPage28_31, TestBit(Value1, 5));
  SafeSetChecked(chbLockBits5_7, TestBit(Value1, 4));
  SafeSetChecked(chbLockPage24_27, TestBit(Value1, 3));
  SafeSetChecked(chbLockPage20_23, TestBit(Value1, 2));
  SafeSetChecked(chbLockPage16_19, TestBit(Value1, 1));
  SafeSetChecked(chbLockBits1_3, TestBit(Value1, 0));
  edtValue.Text := Format('%.2x %.2x', [Lo(Value1), Hi(Value1)]);
end;

procedure TfmUltraLightCLock2.UpdateObject;
begin
  Value1 := 0;
  if chbLockPage44_47.Checked then SetBit(Value1, 15);
  if chbLockPage43.Checked then SetBit(Value1, 14);
  if chbLockPage42.Checked then SetBit(Value1, 13);
  if chbLockPage41.Checked then SetBit(Value1, 12);
  if chbLockBitKey.Checked then SetBit(Value1, 11);
  if chbLockBitAuth1.Checked then SetBit(Value1, 10);
  if chbLockBitAuth0.Checked then SetBit(Value1, 9);
  if chbLockBitCount.Checked then SetBit(Value1, 8);
  if chbLockPage36_39.Checked then SetBit(Value1, 7);
  if chbLockPage32_35.Checked then SetBit(Value1, 6);
  if chbLockPage28_31.Checked then SetBit(Value1, 5);
  if chbLockBits5_7.Checked then SetBit(Value1, 4);
  if chbLockPage24_27.Checked then SetBit(Value1, 3);
  if chbLockPage20_23.Checked then SetBit(Value1, 2);
  if chbLockPage16_19.Checked then SetBit(Value1, 1);
  if chbLockBits1_3.Checked then SetBit(Value1, 0);
  edtValue.Text := Format('%.2x %.2x', [Lo(Value1), Hi(Value1)]);
end;

procedure TfmUltraLightCLock2.btnResetClick(Sender: TObject);
begin
  Value1 := Value2;
  UpdatePage;
end;

end.
