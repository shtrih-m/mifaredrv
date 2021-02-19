unit fmuAnticoll;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, PICCCmdConst;

type
  TfmAnticoll = class(TPage)
    btnMf500PiccCascAnticoll: TButton;
    lblBitCount: TLabel;
    edtBitCount: TEdit;
    lblSerialFragment: TLabel;
    edtSerialFragment: TEdit;
    lblSerialNumber: TLabel;
    edtSerialNumber: TEdit;
    lblSerialNumberHex: TLabel;
    edtSerialNumberHex: TEdit;
    lblSelCode: TLabel;
    cbSelCode: TComboBox;
    btnMf500PiccAnticoll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnMf500PiccCascAnticollClick(Sender: TObject);
    procedure btnMf500PiccAnticollClick(Sender: TObject);
  private
    procedure EnableButtons(Value: Boolean);
  end;

implementation

{$R *.DFM}

procedure TfmAnticoll.EnableButtons(Value: Boolean);
begin
  btnMf500PiccAnticoll.Enabled := Value;
  btnMf500PiccCascAnticoll.Enabled := Value;
end;

procedure TfmAnticoll.FormCreate(Sender: TObject);
begin
  with cbSelCode do
  begin
    Items.Clear;
    Items.AddObject('anticollision level 1 106 kBaud', TObject(PICC_ANTICOLL1));
    Items.AddObject('anticollision level 1 212 kBaud', TObject(PICC_ANTICOLL11));
    Items.AddObject('anticollision level 1 424 kBaud', TObject(PICC_ANTICOLL12));
    Items.AddObject('anticollision level 1 848 kBaud', TObject(PICC_ANTICOLL13));
    Items.AddObject('anticollision level 2', TObject(PICC_ANTICOLL2));
    Items.AddObject('anticollision level 3', TObject(PICC_ANTICOLL3));
    ItemIndex := 0;
  end;
end;

procedure TfmAnticoll.btnMf500PiccCascAnticollClick(Sender: TObject);
var
  SerialNumber: DWORD;
begin
  EnableButtons(False);
  try
    Start;
    Driver.SelectCode := Integer(cbSelCode.Items.Objects[cbSelCode.ItemIndex]);
    Driver.BitCount := StrToInt(edtBitCount.Text);
    if edtSerialFragment.Text = '' then
    begin
      Driver.SerialNumber := 0;
    end else
    begin
      SerialNumber := StrToInt('$' + edtSerialFragment.Text);
      Driver.SerialNumber := SerialNumber;
    end;

    ResultCode := Driver.Mf500PiccCascAnticoll;
    ShowResult(ResultCode);
    if ResultCode <> 0 then
    begin
      edtSerialNumber.Clear;
      edtSerialNumberHex.Clear;
    end else
    begin
      edtSerialNumber.Text := IntToStr(DWORD(Driver.SerialNumber));
      edtSerialNumberHex.Text := IntToHex(DWORD(Driver.SerialNumber), 8);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmAnticoll.btnMf500PiccAnticollClick(Sender: TObject);
var
  SerialNumber: DWORD;
begin
  EnableButtons(False);
  try
    Start;

    Driver.BitCount := StrToInt(edtBitCount.Text);
    if edtSerialFragment.Text = '' then
    begin
      Driver.SerialNumber := 0;
    end else
    begin
      SerialNumber := StrToInt('$' + edtSerialFragment.Text);
      Driver.SerialNumber := SerialNumber;
    end;

    ResultCode := Driver.Mf500PiccAnticoll;
    ShowResult(ResultCode);
    if ResultCode <> 0 then
    begin
      edtSerialNumber.Clear;
      edtSerialNumberHex.Clear;
    end else
    begin
      edtSerialNumber.Text := IntToStr(DWORD(Driver.SerialNumber));
      edtSerialNumberHex.Text := IntToHex(DWORD(Driver.SerialNumber), 8);
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
