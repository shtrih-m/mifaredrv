unit fmuSelect;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, PICCCmdConst;

type
  TfmSelect = class(TPage)
    Mf500PiccCascSelect: TButton;
    lblSerialNumber: TLabel;
    edtSerialNumber: TEdit;
    lblSAK: TLabel;
    edtSAK: TEdit;
    lblSelCode: TLabel;
    cbSelCode: TComboBox;
    Mf500PiccSelect: TButton;
    procedure Mf500PiccCascSelectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Mf500PiccSelectClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmSelect.Mf500PiccCascSelectClick(Sender: TObject);
begin
  Driver.SelectCode := Integer(cbSelCode.Items.Objects[cbSelCode.ItemIndex]);
  Driver.SerialNumber := StrToInt64(edtSerialNumber.Text);

  ResultCode := Driver.Mf500PiccCascSelect;
  ShowResult(ResultCode);
  if ResultCode <> 0 then edtSAK.Clear
  else edtSAK.Text := IntTostr(Driver.SAK);
end;

procedure TfmSelect.FormShow(Sender: TObject);
begin
  edtSerialNumber.Text := IntToStr(DWORD(Driver.SerialNumber));
end;

procedure TfmSelect.FormCreate(Sender: TObject);
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

procedure TfmSelect.Mf500PiccSelectClick(Sender: TObject);
begin
  Driver.SerialNumber := StrToInt64(edtSerialNumber.Text);

  ResultCode := Driver.Mf500PiccSelect;
  ShowResult(ResultCode);
  if ResultCode <> 0 then edtSAK.Clear
  else edtSAK.Text := IntTostr(Driver.SAK);
end;

end.
