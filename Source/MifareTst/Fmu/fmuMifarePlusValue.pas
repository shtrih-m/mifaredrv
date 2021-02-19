unit fmuMifarePlusValue;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, StringUtils, Spin;

type
  TfmMifarePlusValue = class(TPage)
    gbData: TGroupBox;
    lblBlockDataHex: TLabel;
    lblBlockValue2: TLabel;
    edtBlockDataHex: TEdit;
    btnEncodeValueBlock: TButton;
    btnDecodeValueBlock: TButton;
    gbOperations: TGroupBox;
    lblBBlock: TLabel;
    lblDeltaValue: TLabel;
    btnMifarePlusIncrement: TButton;
    btnMifarePlusDecrement: TButton;
    btnMifarePlusTransfer: TButton;
    btnMifarePlusRestore: TButton;
    btnMifarePlusReadValue: TButton;
    btnMifarePlusWriteValue: TButton;
    lblBlockValue: TLabel;
    btnMifarePlusIncrementTransfer: TButton;
    btnMifarePlusDecrementTransfer: TButton;
    lblBlockAddr: TLabel;
    seBlockNumber: TSpinEdit;
    seBlockValue2: TSpinEdit;
    seBlockAddr: TSpinEdit;
    chbEncryptionEnabled: TCheckBox;
    chbAnswerSignature: TCheckBox;
    chbCommandSignature: TCheckBox;
    edtBlockValue: TEdit;
    edtDeltaValue: TEdit;
    procedure btnMifarePlusRestoreClick(Sender: TObject);
    procedure btnMifarePlusTransferClick(Sender: TObject);
    procedure btnMifarePlusIncrementClick(Sender: TObject);
    procedure btnMifarePlusDecrementClick(Sender: TObject);
    procedure btnEncodeValueBlockClick(Sender: TObject);
    procedure btnMifarePlusReadValueClick(Sender: TObject);
    procedure btnMifarePlusWriteValueClick(Sender: TObject);
    procedure btnDecodeValueBlockClick(Sender: TObject);
    procedure btnMifarePlusIncrementTransferClick(Sender: TObject);
    procedure btnMifarePlusDecrementTransferClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

function GetItem(ComboBox: TComboBox): Integer;
begin
  Result := Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);
end;

{ TfmMifarePlus2 }

procedure TfmMifarePlusValue.btnMifarePlusReadValueClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.EncryptionEnabled := chbEncryptionEnabled.Checked;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.CommandSignature := chbCommandSignature.Checked;
    if Driver.MifarePlusReadValue = 0 then
    begin
      edtBlockValue.Text := IntToStr(Driver.BlockValue);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnMifarePlusWriteValueClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.EncryptionEnabled := chbEncryptionEnabled.Checked;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.CommandSignature := chbCommandSignature.Checked;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockValue := StrToInt(edtBlockValue.Text);
    Driver.MifarePlusWriteValue;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnMifarePlusIncrementClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeltaValue := StrToInt(edtDeltaValue.Text);
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusIncrement;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnMifarePlusDecrementClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeltaValue := StrToInt(edtDeltaValue.Text);
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusDecrement;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnMifarePlusTransferClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusTransfer;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnMifarePlusRestoreClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusRestore;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnMifarePlusIncrementTransferClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeltaValue := StrToInt(edtDeltaValue.Text);
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusIncrementTransfer;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnMifarePlusDecrementTransferClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeltaValue := StrToInt(edtDeltaValue.Text);
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusDecrementTransfer;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnEncodeValueBlockClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    edtBlockDataHex.Text := '';
    Driver.BlockAddr := seBlockAddr.Value;
    Driver.BlockValue := StrToInt(edtBlockValue.Text);
    if Driver.EncodeValueBlock = 0 then
      edtBlockDataHex.Text := Driver.BlockDataHex;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusValue.btnDecodeValueBlockClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockDataHex := edtBlockDataHex.Text;
    if Driver.DecodeValueBlock = 0 then
    begin
      seBlockAddr.Value := Driver.BlockAddr;
      edtBlockValue.Text := IntToStr(Driver.BlockValue);
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
