unit fmuCardEmission;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, StringUtils, Spin;

type
  TfmCardEmission = class(TPage)
    gbOperations: TGroupBox;
    btnWriteEncryptedData: TButton;
    lblBlockData: TLabel;
    edtBlockDataHex: TEdit;
    Label1: TLabel;
    cbProtocol: TComboBox;
    lblProtocol: TLabel;
    lblBlockNumber: TLabel;
    seBlockNumber: TSpinEdit;
    seKeyNumber: TSpinEdit;
    lblKeyNumber: TLabel;
    lblKeyVersion: TLabel;
    seKeyVersion: TSpinEdit;
    procedure btnWriteEncryptedDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmCardEmission.btnWriteEncryptedDataClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Protocol := cbProtocol.ItemIndex;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.WriteEncryptedData;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmCardEmission.FormCreate(Sender: TObject);
begin
  cbProtocol.ItemIndex := 0;
end;

end.
