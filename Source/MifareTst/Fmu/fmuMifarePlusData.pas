unit fmuMifarePlusData;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, StringUtils, Spin;

type
  TfmMifarePlusData = class(TPage)
    gbBlockData: TGroupBox;
    lblBBlock: TLabel;
    lblBlockCount: TLabel;
    btnMifarePlusMultiblockRead: TButton;
    btnMifarePlusMultiblockWrite: TButton;
    btnMifarePlusRead: TButton;
    btnMifarePlusWrite: TButton;
    memBlockData: TMemo;
    lblBlockData: TLabel;
    seBlockNumber: TSpinEdit;
    seBlockCount: TSpinEdit;
    chbEncryptionEnabled: TCheckBox;
    chbAnswerSignature: TCheckBox;
    chbCommandSignature: TCheckBox;
    btnMifarePlusMultiblockReadSL2: TButton;
    btnMifarePlusMultiblockWriteSL2: TButton;
    procedure btnMifarePlusReadClick(Sender: TObject);
    procedure btnMifarePlusWriteClick(Sender: TObject);
    procedure btnMifarePlusMultiblockReadClick(Sender: TObject);
    procedure btnMifarePlusMultiblockWriteClick(Sender: TObject);
    procedure btnMifarePlusMultiblockReadSL2Click(Sender: TObject);
    procedure btnMifarePlusMultiblockWriteSL2Click(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmMifarePlus3 }

procedure TfmMifarePlusData.btnMifarePlusReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    memBlockData.Clear;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.EncryptionEnabled := chbEncryptionEnabled.Checked;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.CommandSignature := chbCommandSignature.Checked;
    if Driver.MifarePlusRead = 0 then
    begin
      memBlockData.Text := StrToHex(Driver.BlockData, 16);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusData.btnMifarePlusWriteClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockData := HexToStr(memBlockData.Text);
    Driver.EncryptionEnabled := chbEncryptionEnabled.Checked;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusWrite;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusData.btnMifarePlusMultiblockReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    memBlockData.Clear;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockCount := seBlockCount.Value;
    Driver.EncryptionEnabled := chbEncryptionEnabled.Checked;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.CommandSignature := chbCommandSignature.Checked;
    if Driver.MifarePlusMultiblockRead = 0 then
    begin
      memBlockData.Text := StrToHex(Driver.BlockData, 16);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusData.btnMifarePlusMultiblockWriteClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockCount := seBlockCount.Value;
    Driver.BlockData := HexToStr(memBlockData.Text);
    Driver.EncryptionEnabled := chbEncryptionEnabled.Checked;
    Driver.AnswerSignature := chbAnswerSignature.Checked;
    Driver.MifarePlusMultiblockWrite;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusData.btnMifarePlusMultiblockReadSL2Click(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    memBlockData.Clear;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockCount := seBlockCount.Value;
    if Driver.MifarePlusMultiblockReadSL2 = 0 then
    begin
      memBlockData.Text := StrToHex(Driver.BlockData, 16);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusData.btnMifarePlusMultiblockWriteSL2Click(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockCount := seBlockCount.Value;
    Driver.BlockData := HexToStr(memBlockData.Text);
    Driver.MifarePlusMultiblockWriteSL2;
  finally
    EnableButtons(True);
  end;
end;

end.
