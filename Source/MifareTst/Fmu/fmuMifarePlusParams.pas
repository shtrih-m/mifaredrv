unit fmuMifarePlusParams;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Spin,
  // This
  MifareLib_TLB, untPage;

type
  TfmMifarePlusParams = class(TPage)
    gsParameters: TGroupBox;
    lblReceiveDivisor: TLabel;
    cbReceiveDivisor: TComboBox;
    btnMifarePlusWriteParameters: TButton;
    lblSendDivisor: TLabel;
    cbSendDivisor: TComboBox;
    procedure btnMifarePlusWriteParametersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmMifarePlusParams.FormCreate(Sender: TObject);
begin
  cbSendDivisor.ItemIndex := 0;
  cbReceiveDivisor.ItemIndex := 0;
end;

procedure TfmMifarePlusParams.btnMifarePlusWriteParametersClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ReceiveDivisor := cbReceiveDivisor.ItemIndex;
    Driver.SendDivisor := cbSendDivisor.ItemIndex;
    Driver.MifarePlusWriteParameters;
  finally
    EnableButtons(True);
  end;
end;

end.
