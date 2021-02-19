unit fmuData;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, Spin;

type
  TfmData = class(TPage)
    lblBBlock: TLabel;
    lblBlockDataHex: TLabel;
    edtBlockDataHex: TEdit;
    btnPiccRead: TButton;
    btnPiccWrite: TButton;
    edtBlockData: TEdit;
    lblData: TLabel;
    btnWrite: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    seBlockNumber: TSpinEdit;
    procedure btnPiccReadClick(Sender: TObject);
    procedure btnPiccWriteClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmData }

procedure TfmData.btnPiccReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.PiccRead;
    edtBlockData.Text := Driver.BlockData;
    edtBlockDataHex.Text := Driver.BlockDataHex;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmData.btnWriteClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockData := edtBlockData.Text;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.PiccWrite;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmData.btnPiccWriteClick(Sender: TObject);
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

end.
