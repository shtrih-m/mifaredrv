unit fmuMifarePlusAuth;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  // This
  MifareLib_TLB, untPage, ComCtrls, Spin;

type
  TfmMifarePlusAuth = class(TPage)
    gbAuth: TGroupBox;
    lblKeyNumber: TLabel;
    Label1: TLabel;
    lblKeyVersion: TLabel;
    lblAuthType: TLabel;
    cbAuthType: TComboBox;
    btnMifarePlusAuthSL1: TButton;
    btnMifarePlusAuthSL3: TButton;
    btnMifarePlusResetAuthentication: TButton;
    seBlockNumber2: TSpinEdit;
    seKeyNumber: TSpinEdit;
    seKeyVersion: TSpinEdit;
    lblProtocol: TLabel;
    cbProtocol: TComboBox;
    btnMifarePlusAuthSL2: TButton;
    gbSAMAV2Key: TGroupBox;
    lblKeyEntry: TLabel;
    seKeyEntryNumber: TSpinEdit;
    seKeyPosition: TSpinEdit;
    lblKeyPosition: TLabel;
    lblKeyVersion2: TLabel;
    seKeyVersion2: TSpinEdit;
    edtBlockDataHex: TEdit;
    lblKeyData: TLabel;
    btnSAMAV2WriteKey: TButton;
    gbActivation: TGroupBox;
    lblSerialNumber: TLabel;
    edtUIDHex: TEdit;
    btnPiccActivateWakeUp: TButton;
    procedure btnMifarePlusAuthSL3Click(Sender: TObject);
    procedure btnMifarePlusResetAuthenticationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMifarePlusAuthSL1Click(Sender: TObject);
    procedure btnMifarePlusAuthSL2Click(Sender: TObject);
    procedure btnSAMAV2WriteKeyClick(Sender: TObject);
    procedure btnPiccActivateWakeUpClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmMifarePlusAuth.FormCreate(Sender: TObject);
begin
  cbAuthType.ItemIndex := 0;
  cbProtocol.ItemIndex := 0;
end;

procedure TfmMifarePlusAuth.btnMifarePlusAuthSL1Click(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AuthType := cbAuthType.ItemIndex;
    Driver.Protocol := cbProtocol.ItemIndex;
    Driver.BlockNumber := seBlockNumber2.Value;
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.MifarePlusAuthSL1;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusAuth.btnMifarePlusAuthSL3Click(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AuthType := cbAuthType.ItemIndex;
    Driver.BlockNumber := seBlockNumber2.Value;
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.MifarePlusAuthSL3;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusAuth.btnMifarePlusResetAuthenticationClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.MifarePlusResetAuthentication;
  finally
    EnableButtons(True);
  end;
end;


procedure TfmMifarePlusAuth.btnMifarePlusAuthSL2Click(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AuthType := cbAuthType.ItemIndex;
    Driver.Protocol := cbProtocol.ItemIndex;
    Driver.BlockNumber := seBlockNumber2.Value;
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.MifarePlusAuthSL2;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusAuth.btnSAMAV2WriteKeyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyEntryNumber := seKeyEntryNumber.Value;
    Driver.KeyPosition := seKeyPosition.Value;
    Driver.KeyVersion := seKeyVersion2.Value;
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.SAMAV2WriteKey;
  finally
    EnableButtons(True);
  end;
end;

(*

3.5. Добавить GproupBox с подписью "Авторизация SL2 ключом Crypto-1".
См. команду 0x4A.
То что  в протоколе  "Длина UID карты (4, 7 или 10)" и "UID карты" выводить но заполнять не вручную а при активации карты.
UID карты - номер карты.

*)

procedure TfmMifarePlusAuth.btnPiccActivateWakeUpClick(Sender: TObject);
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
