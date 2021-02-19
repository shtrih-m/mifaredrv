unit fmuValueBlock;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, StringUtils, Spin;

type
  TfmValueBlock = class(TPage)
    gbOperations: TGroupBox;
    lblBBlock: TLabel;
    lblDeltaValue: TLabel;
    lblTransBlockNumber: TLabel;
    lblOperation: TLabel;
    btnIncrement: TButton;
    btnPiccValueDebit: TButton;
    btnDecrement: TButton;
    btnTransfer: TButton;
    btnRestore: TButton;
    btnPiccRead: TButton;
    btnPiccWrite: TButton;
    cbOperation: TComboBox;
    seBlockNumber: TSpinEdit;
    seTransBlockNumber: TSpinEdit;
    seDeltaValue: TSpinEdit;
    lblBlockValue: TLabel;
    lblBlockAddr: TLabel;
    lblBlockData: TLabel;
    edtBlockDataHex: TEdit;
    seBlockAddr: TSpinEdit;
    seBlockValue: TSpinEdit;
    btnEncodeBlock: TButton;
    btnDecodeBlock: TButton;
    btnDefaultValue: TButton;
    btnFillBlock: TButton;
    edtFillValue: TEdit;
    Label1: TLabel;
    procedure btnPiccReadClick(Sender: TObject);
    procedure btnPiccValueDebitClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure btnIncrementClick(Sender: TObject);
    procedure btnDecrementClick(Sender: TObject);
    procedure btnEncodeBlockClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure btnPiccWriteClick(Sender: TObject);
    procedure btnDecodeBlockClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFillBlockClick(Sender: TObject);
    procedure btnDefaultValueClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

function GetItem(ComboBox: TComboBox): Integer;
begin
  Result := Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);
end;

{ TfmData }

// Чтение блока

procedure TfmValueBlock.btnPiccReadClick(Sender: TObject);
begin
end;

// Записать блок

procedure TfmValueBlock.btnRestoreClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.TransBlockNumber := seTransBlockNumber.Value;
    Driver.ValueOperation := voRestore;
    Driver.PiccValue;
    seBlockValue.Value := Driver.BlockValue;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnTransferClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.TransBlockNumber := seTransBlockNumber.Value;
    Driver.ValueOperation := voTransfer;
    Driver.PiccValue;
    seBlockValue.Value := Driver.BlockValue;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnIncrementClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeltaValue := seDeltaValue.Value;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.TransBlockNumber := seBlockNumber.Value;
    Driver.ValueOperation := voIncrement;
    Driver.PiccValue;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnDecrementClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeltaValue := seDeltaValue.Value;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.TransBlockNumber := seBlockNumber.Value;
    Driver.ValueOperation := voDecrement;
    Driver.PiccValue;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnPiccValueDebitClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeltaValue := seDeltaValue.Value;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.TransBlockNumber := seBlockNumber.Value;
    Driver.ValueOperation := GetItem(cbOperation);
    Driver.PiccValueDebit;
    seBlockValue.Value := Driver.BlockValue;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnEncodeBlockClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    edtBlockDataHex.Text := '';
    Driver.BlockAddr := seBlockAddr.Value;
    Driver.BlockValue := seBlockValue.Value;
    if Driver.EncodeValueBlock = 0 then
      edtBlockDataHex.Text := Driver.BlockDataHex;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    if Driver.PiccRead = 0 then
    begin
      edtBlockDataHex.Text := Driver.BlockDataHex;
      if Driver.DecodeValueBlock = 0 then
      begin
        seBlockAddr.Value := Driver.BlockAddr;
        seBlockValue.Value := Driver.BlockValue;
      end;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnPiccWriteClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.PiccWrite;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.btnDecodeBlockClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockDataHex := edtBlockDataHex.Text;
    if Driver.DecodeValueBlock = 0 then
    begin
      seBlockAddr.Value := Driver.BlockAddr;
      seBlockValue.Value := Driver.BlockValue;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmValueBlock.FormCreate(Sender: TObject);
begin
  cbOperation.Items.Clear;
  cbOperation.Items.AddObject('Increment', TObject(voIncrement));
  cbOperation.Items.AddObject('Decrement', TObject(voDecrement));
  cbOperation.Items.AddObject('Restore', TObject(voRestore));
  cbOperation.Items.AddObject('Transfer', TObject(voTransfer));
  cbOperation.ItemIndex := 0;
end;

procedure TfmValueBlock.btnFillBlockClick(Sender: TObject);
var
  V: Integer;
begin
  V := HexToInt(edtFillValue.Text);
  edtBlockDataHex.Text := StrToHex(StringOfChar(Char(V), 16));
end;

procedure TfmValueBlock.btnDefaultValueClick(Sender: TObject);
begin
  edtBlockDataHex.Text := 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF';
end;

end.
