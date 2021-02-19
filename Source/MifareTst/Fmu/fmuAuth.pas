unit fmuAuth;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, Spin;

type
  TfmAuth = class(TPage)
    btnPiccAuth: TButton;
    lblKeyNumber: TLabel;
    lblBlockNumber: TLabel;
    rbKeyB: TRadioButton;
    rbKeyA: TRadioButton;
    lblAuthKey: TLabel;
    edtUIDHex: TEdit;
    lblSerialNumber: TLabel;
    btnHostCodeKey: TButton;
    btnPcdLoadKeyE2: TButton;
    lblKeyUncoded: TLabel;
    edtKeyUncoded: TEdit;
    btnPiccAuthKey: TButton;
    lblKeyEncoded: TLabel;
    edtKeyEncoded: TEdit;
    btnActivate: TButton;
    seKeyNumber: TSpinEdit;
    seBlockNumber: TSpinEdit;
    procedure btnPiccAuthClick(Sender: TObject);
    procedure btnHostCodeKeyClick(Sender: TObject);
    procedure btnPcdLoadKeyE2Click(Sender: TObject);
    procedure btnPiccAuthKeyClick(Sender: TObject);
    procedure btnActivateClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmAuth }

procedure TfmAuth.btnPiccAuthClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyType := KeyTypes[rbKeyA.Checked];
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.PiccAuth;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmAuth.btnHostCodeKeyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyUncoded := edtKeyUncoded.Text;
    Driver.EncodeKey;
    edtKeyEncoded.Text := Driver.KeyEncoded;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmAuth.btnPcdLoadKeyE2Click(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyType := KeyTypes[rbKeyA.Checked];
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyUncoded := edtKeyUncoded.Text;
    Driver.PcdLoadKeyE2;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmAuth.btnPiccAuthKeyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyType := KeyTypes[rbKeyA.Checked];
    Driver.KeyEncoded := edtKeyEncoded.Text;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.UIDHex := edtUIDHex.Text;
    Driver.PiccAuthKey;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmAuth.btnActivateClick(Sender: TObject);
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
