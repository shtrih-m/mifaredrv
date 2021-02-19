unit fmuSAMAuth;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls,
  // This
  untPage, untUtil, Spin;

type
  TfmSAMAuth = class(TPage)
    gsWriteKey: TGroupBox;
    lblKeyNumber: TLabel;
    lblKeyA: TLabel;
    btnWriteKey: TButton;
    edtKeyA: TEdit;
    lblKeyPosition: TLabel;
    lblKeyVersion: TLabel;
    lblKeyB: TLabel;
    edtKeyB: TEdit;
    gsKeyAuth: TGroupBox;
    btnSAM_AuthKey: TButton;
    Label1: TLabel;
    Label3: TLabel;
    lblAuthKey: TLabel;
    rbKeyB: TRadioButton;
    rbKeyA: TRadioButton;
    lblBlockNumber: TLabel;
    lblUIDHex: TLabel;
    edtUIDHex: TEdit;
    btnPiccActivateWakeUp: TButton;
    seKeyNumber: TSpinEdit;
    seKeyPosition: TSpinEdit;
    seKeyVersion: TSpinEdit;
    seKeyNumber2: TSpinEdit;
    seKeyVersion2: TSpinEdit;
    seBlockNumber: TSpinEdit;
    procedure btnWriteKeyClick(Sender: TObject);
    procedure btnSAM_AuthKeyClick(Sender: TObject);
    procedure btnPiccActivateWakeUpClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmAuth }

procedure TfmSAMAuth.btnWriteKeyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyPosition := seKeyPosition.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.KeyA := edtKeyA.Text;
    Driver.KeyB := edtKeyB.Text;
    Driver.SAM_WriteKey;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSAMAuth.btnSAM_AuthKeyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyType := KeyTypes[rbKeyA.Checked];
    Driver.KeyNumber := seKeyNumber2.Value;
    Driver.KeyVersion := seKeyVersion2.Value;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.SAM_AuthKey;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSAMAuth.btnPiccActivateWakeUpClick(Sender: TObject);
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

end.
