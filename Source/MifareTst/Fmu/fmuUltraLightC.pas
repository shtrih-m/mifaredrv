unit fmuUltraLightC;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Spin,
  // This
  MifareLib_TLB, untPage, fmuUltraLightCLock0, fmuUltraLightCLock2,
  untUtil;

type
  TfmUltraLightC = class(TPage)
    gsAuth: TGroupBox;
    lblKeyNumber: TLabel;
    lblKeyA: TLabel;
    lblKeyPosition: TLabel;
    lblKeyVersion: TLabel;
    btnUltralightWriteKey: TButton;
    edtBlockDataHex2: TEdit;
    gsData: TGroupBox;
    lblPageNumber: TLabel;
    btnUltralightAuth: TButton;
    lblBlockDataHex: TLabel;
    edtBlockDataHex: TEdit;
    btnUltralightRead: TButton;
    btnUltralightWrite: TButton;
    btnUltralightCompatWrite: TButton;
    lblUIDHex: TLabel;
    edtUIDHex: TEdit;
    btnPiccActivateWakeUp: TButton;
    seKeyNumber: TSpinEdit;
    seKeyPosition: TSpinEdit;
    seKeyVersion: TSpinEdit;
    btnLockBytes: TButton;
    cbPageNumber: TComboBox;
    Label1: TLabel;
    procedure btnUltralightWriteKeyClick(Sender: TObject);
    procedure btnUltralightAuthClick(Sender: TObject);
    procedure btnUltralightReadClick(Sender: TObject);
    procedure btnUltralightWriteClick(Sender: TObject);
    procedure btnUltralightCompatWriteClick(Sender: TObject);
    procedure btnPiccActivateWakeUpClick(Sender: TObject);
    procedure btnLockBytesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbPageNumberChange(Sender: TObject);
  private
    function GetPageNumber: Integer;
  public
    procedure UpdatePage; override;
  end;

implementation

{$R *.DFM}

procedure TfmUltraLightC.btnUltralightWriteKeyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyPosition := seKeyPosition.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.UltralightWriteKey;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmUltraLightC.btnUltralightAuthClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KeyNumber := seKeyNumber.Value;
    Driver.KeyVersion := seKeyVersion.Value;
    Driver.UltralightAuth;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmUltraLightC.btnUltralightReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := GetPageNumber;
    if Driver.UltralightRead = 0 then
    begin
      edtBlockDataHex.Text := Driver.BlockDataHex;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmUltraLightC.btnUltralightWriteClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := GetPageNumber;
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.UltralightWrite;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmUltraLightC.btnUltralightCompatWriteClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BlockNumber := GetPageNumber;
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.UltralightCompatWrite;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmUltraLightC.btnPiccActivateWakeUpClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    edtUIDHex.Clear;
    Driver.BaudRate := 0;
    if Driver.PiccActivateWakeUp = 0 then
    begin
      edtUIDHex.Text := Driver.UIDHex;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmUltraLightC.btnLockBytesClick(Sender: TObject);
var
  V: Integer;
  Data: string;
  PageNumber: Integer;
begin
  Driver.BlockNumber := GetPageNumber;
  if Driver.UltralightRead <> 0 then Exit;

  edtBlockDataHex.Text := Driver.BlockDataHex;
  Data := HexToStr(edtBlockDataHex.Text);
  PageNumber := GetPageNumber;
  case PageNumber of
    2:
    begin
      V := BinToInt(Data, 3, 2);
      if ShowLockBytes0(V) then
      begin
        Data := Copy(Data, 1, 2) + IntToBin(V, 2) + Copy(Data, 5, Length(Data));
        edtBlockDataHex.Text := StrToHex(Data);
      end;
    end;

    40:
    begin
      V := BinToInt(Data, 1, 2);
      if ShowLockBytes2(V) then
      begin
        Data := IntToBin(V, 2) + Copy(Data, 3, Length(Data));
        edtBlockDataHex.Text := StrToHex(Data);
      end;
    end;
  end;
end;

procedure TfmUltraLightC.FormCreate(Sender: TObject);
var
  S: string;
  i: Integer;
begin
  cbPageNumber.Clear;
  for i := 0 to 47 do
  begin
    S := Format('0x%.2x', [i]);
    cbPageNumber.Items.AddObject(S, TObject(i));
  end;
  cbPageNumber.ItemIndex := 0;
  UpdatePage;
end;

function TfmUltraLightC.GetPageNumber: Integer;
begin
  Result := Integer(cbPageNumber.Items.Objects[cbPageNumber.ItemIndex]);
end;

procedure TfmUltraLightC.cbPageNumberChange(Sender: TObject);
begin
  UpdatePage;
end;

procedure TfmUltraLightC.UpdatePage;
begin
  btnLockBytes.Enabled := GetPageNumber in [2, 40];
end;

end.
