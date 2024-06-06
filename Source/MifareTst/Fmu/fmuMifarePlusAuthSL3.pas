unit fmuMifarePlusAuthSL3;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  // This
  MifareLib_TLB, untPage, ComCtrls, Spin;

type
  { TfmMifarePlusAuthSL3 }

  TfmMifarePlusAuthSL3 = class(TPage)
    gbAuth: TGroupBox;
    lblBlockNumber: TLabel;
    lblAuthType: TLabel;
    cbAuthType: TComboBox;
    btnMifarePlusAuthSL3: TButton;
    btnMifarePlusResetAuthentication: TButton;
    seBlockNumber: TSpinEdit;
    gbActivation: TGroupBox;
    lblSerialNumber: TLabel;
    edtUIDHex: TEdit;
    btnPiccActivateWakeUp: TButton;
    lblKeyData: TLabel;
    edtBlockDataHex: TEdit;
    lblDivInputHex: TLabel;
    edtDivInputHex: TEdit;
    edtStatus: TEdit;
    lblStatus: TLabel;
    procedure btnMifarePlusAuthSL3Click(Sender: TObject);
    procedure btnMifarePlusResetAuthenticationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSAMAV2WriteKeyClick(Sender: TObject);
    procedure btnPiccActivateWakeUpClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmMifarePlusAuthSL3.FormCreate(Sender: TObject);
begin
  cbAuthType.ItemIndex := 0;
end;

procedure TfmMifarePlusAuthSL3.btnMifarePlusAuthSL3Click(Sender: TObject);
begin
  edtStatus.Clear;
  EnableButtons(False);
  try
    Driver.AuthType := cbAuthType.ItemIndex;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.DivInputHex := edtDivInputHex.Text;
    if Driver.MifarePlusAuthSL3 = 0 then
    begin
      edtStatus.Text := IntToStr(Driver.Status);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMifarePlusAuthSL3.btnMifarePlusResetAuthenticationClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.MifarePlusResetAuthentication;
  finally
    EnableButtons(True);
  end;
end;


procedure TfmMifarePlusAuthSL3.btnSAMAV2WriteKeyClick(Sender: TObject);
begin
end;

(*

3.5. Добавить GproupBox с подписью "Авторизация SL2 ключом Crypto-1".
См. команду 0x4A.
То что  в протоколе  "Длина UID карты (4, 7 или 10)" и "UID карты" выводить но заполнять не вручную а при активации карты.
UID карты - номер карты.

*)

procedure TfmMifarePlusAuthSL3.btnPiccActivateWakeUpClick(Sender: TObject);
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
