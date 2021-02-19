unit fmuMifarePlusPerso;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Spin,
  // This
  MifareLib_TLB, untPage;

type
  TfmMifarePlusPerso = class(TPage)
    gbPerso: TGroupBox;
    lblBlockNumber: TLabel;
    edtBlockDataHex: TEdit;
    lblBlockDataHex: TLabel;
    btnMifarePlusWritePerso: TButton;
    btnMifarePlusCommitPerso: TButton;
    seBlockNumber: TSpinEdit;
    cbBlockNumber: TComboBox;
    lblPersoCommit: TLabel;
    lblWritePerso: TLabel;
    pnlInfo: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnMifarePlusWritePersoClick(Sender: TObject);
    procedure btnMifarePlusCommitPersoClick(Sender: TObject);
    procedure cbBlockNumberChange(Sender: TObject);
  end;

implementation

{$R *.DFM}

(*

0x9000, Card Master Key Address
0x9001, Card Configuration Key Address
0x9002, Level 2 Switch Key Address
0x9003, Level 3 Switch Key Address
0x9004, SL1 Card Authentication Key Address
0xA000, Select VC Key Address
0xA001, Proximity Check Key Address
0xA080, VC Polling ENC Key Address
0xA081, VC Polling MAC Key Address
0xB000, MIFARE Plus Configuration block Address
0xB001, Installation Identifier Address
0xB003, Field Configuration block Address
0x4000, physical start address of AES key location Address
0x404F, physical end address of AES key location Address

*)

procedure TfmMifarePlusPerso.FormCreate(Sender: TObject);

  procedure AddBlockNumber(Value: Integer; S: string);
  begin
    S := Format('0x%.4x, %s', [Value, S]);
    cbBlockNumber.Items.AddObject(S, TObject(Value));
  end;

const
  Separator = '---------------------------------------';  
begin
  cbBlockNumber.Clear;
  AddBlockNumber($9000, 'Card Master Key');
  AddBlockNumber($9001, 'Card Configuration Key');
  AddBlockNumber($9002, 'Level 2 Switch Key');
  AddBlockNumber($9003, 'Level 3 Switch Key');
  AddBlockNumber($9004, 'SL1 Card Authentication Key');
  cbBlockNumber.Items.Add(Separator);
  AddBlockNumber($A000, 'Select VC Key');
  AddBlockNumber($A001, 'Proximity Check Key');
  AddBlockNumber($A080, 'VC Polling ENC Key');
  AddBlockNumber($A081, 'VC Polling MAC Key');
  cbBlockNumber.Items.Add(Separator);
  AddBlockNumber($B000, 'MIFARE Plus Configuration block');
  AddBlockNumber($B001, 'Installation Identifier');
  AddBlockNumber($B003, 'Field Configuration block');
  AddBlockNumber($4000, 'AES key location, start address');
  AddBlockNumber($404F, 'AES key location, end sddress');

  cbBlockNumber.ItemIndex := 0;
  seBlockNumber.Value := $9000;
end;

procedure TfmMifarePlusPerso.btnMifarePlusWritePersoClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.MifarePlusWritePerso;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusPerso.btnMifarePlusCommitPersoClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.MifarePlusCommitPerso;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusPerso.cbBlockNumberChange(Sender: TObject);
var
  BlockNumber: Integer;
begin
  BlockNumber := Integer(cbBlockNumber.Items.Objects[cbBlockNumber.ItemIndex]);
  seBlockNumber.Value := BlockNumber;
end;

end.
