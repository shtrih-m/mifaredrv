unit fmuMifarePlusAuthSL2;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Spin,
  // This
  MifareLib_TLB, MifareTypes, untPage;

type
  TfmMifarePlusAuthSL2 = class(TPage)
    GroupBox1: TGroupBox;
    lblKeyNumber: TLabel;
    lblBlockNumber: TLabel;
    KeyVersion: TLabel;
    btnMifarePlusAuthSL2Crypto1: TButton;
    seBlockNumber: TSpinEdit;
    seKeyNumber: TSpinEdit;
    seKeyVersion: TSpinEdit;
    btnKeyType: TLabel;
    cbKeyType: TComboBox;
    lblUID: TLabel;
    btnPiccActivateWakeUp: TButton;
    edtUIDHex: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnPiccActivateWakeUpClick(Sender: TObject);
    procedure btnMifarePlusAuthSL2Crypto1Click(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmMifarePlusAuthSL2.FormCreate(Sender: TObject);
begin
  cbKeyType.ItemIndex := 0;
end;

procedure TfmMifarePlusAuthSL2.btnPiccActivateWakeUpClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BaudRate := 0;
    if Driver.PiccActivateWakeUp = 0 then
    begin
      edtUIDHex.Text := Driver.UIDHex;
    end else
    begin
      edtUIDHex.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusAuthSL2.btnMifarePlusAuthSL2Crypto1Click(Sender: TObject);
const
  KeyTypes: array [0..1] of TKeyType = (ktKeyA, ktKeyB);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.KeyType := KeyTypes[cbKeyType.ItemIndex];
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.UIDHex := edtUIDHex.Text;
    Driver.MifarePlusAuthSL2Crypto1;
  finally
    EnableButtons(True);
  end;
end;

end.
