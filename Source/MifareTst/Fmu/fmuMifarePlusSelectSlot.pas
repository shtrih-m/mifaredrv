unit fmuMifarePlusSelectSlot;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  // This
  MifareLib_TLB, untPage, ComCtrls, Spin;

type
  TfmMifarePlusSelectSlot = class(TPage)
    gbSelectSlot: TGroupBox;
    lblSlotNumber2: TLabel;
    lblOptionalValue: TLabel;
    lblSlotNumber: TLabel;
    cbSlotNumber: TComboBox;
    btnMifarePlusSelectSlot: TButton;
    seOptionalValue: TSpinEdit;
    chbUseOptional: TCheckBox;
    edtSlotNumber: TEdit;
    Label1: TLabel;
    edtSlotStatus0: TEdit;
    lblSlotStatus0: TLabel;
    lblSlotStatus1: TLabel;
    edtSlotStatus1: TEdit;
    lblSlotStatus2: TLabel;
    edtSlotStatus2: TEdit;
    lblSlotStatus3: TLabel;
    edtSlotStatus3: TEdit;
    lblSlotStatus4: TLabel;
    edtSlotStatus4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnMifarePlusSelectSlotClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmMifarePlusSelectSlot.FormCreate(Sender: TObject);
begin
  cbSlotNumber.ItemIndex := 0;
end;

procedure TfmMifarePlusSelectSlot.btnMifarePlusSelectSlotClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SlotNumber := cbSlotNumber.ItemIndex;
    Driver.UseOptional := chbUseOptional.Checked;
    Driver.OptionalValue := seOptionalValue.Value;
    Driver.MifarePlusSelectSAMSlot;
    edtSlotNumber.Text := IntToStr(Driver.SlotNumber);
    edtSlotStatus0.Text := IntToStr(Driver.SlotStatus0);
    edtSlotStatus1.Text := IntToStr(Driver.SlotStatus1);
    edtSlotStatus2.Text := IntToStr(Driver.SlotStatus2);
    edtSlotStatus3.Text := IntToStr(Driver.SlotStatus3);
    edtSlotStatus4.Text := IntToStr(Driver.SlotStatus4);
  finally
    EnableButtons(True);
  end;
end;

end.
