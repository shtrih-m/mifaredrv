unit fmuReaderMemory;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin,
  // This
  untPage;

type
  TfmReaderMemory = class(TPage)
    lblBlockNumber: TLabel;
    lblBlockDataHex: TLabel;
    btnPcdReadE2: TButton;
    edtBlockDataHex: TEdit;
    lblBlockLength: TLabel;
    btnPcdWriteE2: TButton;
    seBlockNumber: TSpinEdit;
    seDataLength: TSpinEdit;
    procedure btnPcdReadE2Click(Sender: TObject);
    procedure btnPcdWriteE2Click(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmReaderMemory }

procedure TfmReaderMemory.btnPcdReadE2Click(Sender: TObject);
begin
  EnableButtons(False);
  try                  
    Driver.DataLength := seDataLength.Value;
    Driver.BlockNumber := seBlockNumber.Value;
    if Driver.PcdReadE2 = 0 then
    begin
      edtBlockDataHex.Text := Driver.BlockDataHex;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReaderMemory.btnPcdWriteE2Click(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.DataLength := seDataLength.Value;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.PcdWriteE2;
  finally
    EnableButtons(True);
  end;
end;

end.
