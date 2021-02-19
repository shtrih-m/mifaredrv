unit fmuTrailer;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, Registry, ComCtrls, ExtCtrls,
  // This
  BaseForm, MifareLib_TLB, untUtil, untError, untConst,
  fmuAccessData, fmuAccessTrailer, Spin;

type
  { TfmTrailer }

  TfmTrailer = class(TBaseForm)
    lblKeyA: TLabel;
    edtKeyA: TEdit;
    lblKeyB: TLabel;
    edtKeyB: TEdit;
    lblTrailer: TLabel;
    edtTrailer: TEdit;
    btnRead: TButton;
    btnClose: TButton;
    btnWrite: TButton;
    Label1: TLabel;
    lblWarning: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    edtNewKeyA: TEdit;
    edtNewKeyB: TEdit;
    gbAccessBits: TGroupBox;
    lblBlock0: TLabel;
    lblBlock1: TLabel;
    lblBlock2: TLabel;
    lblBlock3: TLabel;
    btnBlock0: TButton;
    btnBlock1: TButton;
    btnBlock2: TButton;
    btnBlock3: TButton;
    lblWarning2: TLabel;
    cbBlock0: TComboBox;
    cbBlock1: TComboBox;
    cbBlock2: TComboBox;
    cbBlock3: TComboBox;
    btnDecode: TButton;
    btnEncode: TButton;
    seSectorNumber: TSpinEdit;
    procedure btnReadClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure btnBlock0Click(Sender: TObject);
    procedure btnBlock1Click(Sender: TObject);
    procedure btnBlock2Click(Sender: TObject);
    procedure btnBlock3Click(Sender: TObject);
    procedure btnDecodeClick(Sender: TObject);
    procedure btnEncodeClick(Sender: TObject);
    procedure edtNewKeyAChange(Sender: TObject);
    procedure edtNewKeyBChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    Driver: IMifareDrv3;
    procedure LoadParams;
    procedure SaveParams;
    procedure EncodeTrailer;
    function DecodeTrailer: Boolean;
    function CheckHexKey(Key: string): Boolean;
    function GetRegKey: string;
  end;

procedure ShowTrailer(AParentWnd: HWND; ADriver: IMifareDrv3);

implementation

{$R *.DFM}

function GetMode(Number: Integer): Integer;
begin
  case Number of
    0: Result := 0;
    1: Result := 2;
    2: Result := 4;
    3: Result := 6;
    4: Result := 1;
    5: Result := 3;
    6: Result := 5;
    7: Result := 7;
  else
    Result := -1;
  end;
end;

function SetNumber(Mode: Integer): Integer;
begin
  case Mode of
    0: Result := 0;
    1: Result := 4;
    2: Result := 1;
    3: Result := 5;
    4: Result := 2;
    5: Result := 6;
    6: Result := 3;
    7: Result := 7;
  else
    Result := -1;
  end;
end;

const
  REGSTR_VAL_SECTORNUMBER = 'TrailerSectorNumber';
  REGSTR_VAL_KEYA         = 'TrailerKeyA';
  REGSTR_VAL_KEYB         = 'TrailerKeyB';
  REGSTR_VAL_NEWKEYA      = 'TrailerNewKeyA';
  REGSTR_VAL_NEWKEYB      = 'TrailerNewKeyB';
  REGSTR_VAL_BLOCK0       = 'TrailerBlock0';
  REGSTR_VAL_BLOCK1       = 'TrailerBlock1';
  REGSTR_VAL_BLOCK2       = 'TrailerBlock2';
  REGSTR_VAL_BLOCK3       = 'TrailerBlock3';
  REGSTR_VAL_VALUE        = 'TrailerValue';

procedure ShowTrailer(AParentWnd: HWND; ADriver: IMifareDrv3);
var
  fm: TfmTrailer;
begin
  fm := TfmTrailer.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, AParentWnd);
    fm.Driver := ADriver;
    fm.LoadParams;
    fm.ShowModal;
  finally
    fm.SaveParams;
    fm.Free;
  end;
end;

{ TfmTrailer }

procedure TfmTrailer.EncodeTrailer;
begin
  Driver.NewKeyA := edtNewKeyA.Text;
  Driver.NewKeyB := edtNewKeyB.Text;
  Driver.AccessMode0 := GetMode(cbBlock0.ItemIndex);
  Driver.AccessMode1 := GetMode(cbBlock1.ItemIndex);
  Driver.AccessMode2 := GetMode(cbBlock2.ItemIndex);
  Driver.AccessMode3 := GetMode(cbBlock3.ItemIndex);
  Driver.EncodeTrailer;
  edtTrailer.Text := Driver.BlockDataHex;
end;

procedure TfmTrailer.btnReadClick(Sender: TObject);
begin
  if not CheckHexKey(edtKeyA.Text) or not CheckHexKey(edtKeyB.Text) then
  begin
    MessageBox(Handle, PChar('Ключи должны быть в Hex-коде.'),
               S_DriverName, MB_ICONERROR);
    edtTrailer.Text := '';
    Exit;
  end;
  btnWrite.Enabled := True;
  lblWarning.Visible := False;
  Driver.SectorNumber := seSectorNumber.Value;
  Driver.KeyA := edtKeyA.Text;
  Driver.KeyB := edtKeyB.Text;
  if Driver.ReadTrailer = 0 then
  begin
    edtNewKeyA.Text := Driver.KeyA;
    edtNewKeyB.Text := Driver.KeyB;
    cbBlock0.ItemIndex := SetNumber(Driver.AccessMode0);
    cbBlock1.ItemIndex := SetNumber(Driver.AccessMode1);
    cbBlock2.ItemIndex := SetNumber(Driver.AccessMode2);
    cbBlock3.ItemIndex := SetNumber(Driver.AccessMode3);
    edtTrailer.Text := Driver.BlockDataHex;
  end
  else
  begin
    MessageBox(Handle, PChar('Не удается прочитать трейлер.'),
               S_DriverName, MB_ICONERROR);
    edtTrailer.Text := '';
  end;
end;

function TfmTrailer.GetRegKey: string;
begin
  Result := IncludeTrailingPathDelimiter(REGSTR_KEY_DRV + Driver.ParamsRegKey) +
    'Trailer';
end;

procedure TfmTrailer.LoadParams;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := RegRootKey;
    if Reg.OpenKey(GetRegKey, False) then
    begin
      if Reg.ValueExists(REGSTR_VAL_SECTORNUMBER) then
        seSectorNumber.Value := Reg.ReadInteger(REGSTR_VAL_SECTORNUMBER);
      if Reg.ValueExists(REGSTR_VAL_KEYA) then
        edtKeyA.Text := Reg.ReadString(REGSTR_VAL_KEYA);
      if Reg.ValueExists(REGSTR_VAL_KEYB) then
        edtKeyB.Text := Reg.ReadString(REGSTR_VAL_KEYB);
      if Reg.ValueExists(REGSTR_VAL_NEWKEYA) then
        edtNewKeyA.Text := Reg.ReadString(REGSTR_VAL_NEWKEYA);
      if Reg.ValueExists(REGSTR_VAL_NEWKEYB) then
        edtNewKeyB.Text := Reg.ReadString(REGSTR_VAL_NEWKEYB);
      if Reg.ValueExists(REGSTR_VAL_BLOCK0) then
        cbBlock0.ItemIndex := Reg.ReadInteger(REGSTR_VAL_BLOCK0);
      if Reg.ValueExists(REGSTR_VAL_BLOCK1) then
        cbBlock1.ItemIndex := Reg.ReadInteger(REGSTR_VAL_BLOCK1);
      if Reg.ValueExists(REGSTR_VAL_BLOCK2) then
        cbBlock2.ItemIndex := Reg.ReadInteger(REGSTR_VAL_BLOCK2);
      if Reg.ValueExists(REGSTR_VAL_BLOCK3) then
        cbBlock3.ItemIndex := Reg.ReadInteger(REGSTR_VAL_BLOCK3);
      if Reg.ValueExists(REGSTR_VAL_VALUE) then
        edtTrailer.Text := Reg.ReadString(REGSTR_VAL_VALUE);
    end;
  finally;
    Reg.Free;
  end;
end;

procedure TfmTrailer.SaveParams;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := RegRootKey;
    if Reg.OpenKey(GetRegKey, True) then
    begin
      Reg.WriteInteger(REGSTR_VAL_SECTORNUMBER, seSectorNumber.Value);
      Reg.WriteString(REGSTR_VAL_KEYA, edtKeyA.Text);
      Reg.WriteString(REGSTR_VAL_KEYB, edtKeyB.Text);
      Reg.WriteString(REGSTR_VAL_NEWKEYA, edtNewKeyA.Text);
      Reg.WriteString(REGSTR_VAL_NEWKEYB, edtNewKeyB.Text);
      Reg.WriteInteger(REGSTR_VAL_BLOCK0, cbBlock0.ItemIndex);
      Reg.WriteInteger(REGSTR_VAL_BLOCK1, cbBlock1.ItemIndex);
      Reg.WriteInteger(REGSTR_VAL_BLOCK2, cbBlock2.ItemIndex);
      Reg.WriteInteger(REGSTR_VAL_BLOCK3, cbBlock3.ItemIndex);
      Reg.WriteString(REGSTR_VAL_VALUE, edtTrailer.Text);
    end;
  finally
    Reg.Free;
  end;
end;

function TfmTrailer.DecodeTrailer: Boolean;
begin
  Result := (Driver.DecodeTrailer = 0);
  if Result then
  begin
    edtNewKeyA.Text := Driver.KeyA;
    edtNewKeyB.Text := Driver.KeyB;
    cbBlock0.ItemIndex := SetNumber(Driver.AccessMode0);
    cbBlock1.ItemIndex := SetNumber(Driver.AccessMode1);
    cbBlock2.ItemIndex := SetNumber(Driver.AccessMode2);
    cbBlock3.ItemIndex := SetNumber(Driver.AccessMode3);
  end;
end;

procedure TfmTrailer.btnWriteClick(Sender: TObject);
var
  S: string;
begin
  // Если старые и новые ключи различаются, то предупреждаем об этом
  if ((edtKeyA.Text <> edtNewKeyA.Text)or(edtKeyB.Text <> edtNewKeyB.Text)) and
     (MessageBox(Handle, PChar('Сейчас будут измененены ключи. Продолжить?'),
        S_DriverName, MB_YESNO or MB_ICONEXCLAMATION) = IDNO) then Exit;

  Driver.SectorNumber := seSectorNumber.Value;
  Driver.KeyA := edtKeyA.Text;
  Driver.KeyB := edtKeyB.Text;
  Driver.NewKeyA := edtNewKeyA.Text;
  Driver.NewKeyB := edtNewKeyB.Text;
  Driver.AccessMode0 := GetMode(cbBlock0.ItemIndex);
  Driver.AccessMode1 := GetMode(cbBlock1.ItemIndex);
  Driver.AccessMode2 := GetMode(cbBlock2.ItemIndex);
  Driver.AccessMode3 := GetMode(cbBlock3.ItemIndex);
  if Driver.WriteTrailer = 0 then
    edtTrailer.Text := Driver.BlockDataHex
  else
  begin
    if Driver.ResultCode = E_INVALID_TRAILER then
      S := Driver.ResultDescription+'.'
    else
      S := 'Не удается записать трейлер.';
    MessageBox(Handle, PChar(S), S_DriverName, MB_ICONERROR);
    edtTrailer.Text := '';
  end;
end;

procedure TfmTrailer.btnBlock0Click(Sender: TObject);
var
  N: Integer;
begin
  N := cbBlock0.ItemIndex+1;
  if ShowDataAccessDlg(Handle, 0, N) then
  begin
    cbBlock0.ItemIndex := N-1;
    EncodeTrailer;
  end;
end;

procedure TfmTrailer.btnBlock1Click(Sender: TObject);
var
  N: Integer;
begin
  N := cbBlock1.ItemIndex+1;
  if ShowDataAccessDlg(Handle, 1, N) then
  begin
    cbBlock1.ItemIndex := N-1;
    EncodeTrailer;
  end;
end;

procedure TfmTrailer.btnBlock2Click(Sender: TObject);
var
  N: Integer;
begin
  N := cbBlock2.ItemIndex+1;
  if ShowDataAccessDlg(Handle, 2, N) then
  begin
    cbBlock2.ItemIndex := N-1;
    EncodeTrailer;
  end;
end;

procedure TfmTrailer.btnBlock3Click(Sender: TObject);
var
  N: Integer;
begin
  N := cbBlock3.ItemIndex+1;
  if ShowTrailerAccessDlg(Handle, N) then
  begin
    cbBlock3.ItemIndex := N-1;
    EncodeTrailer;
  end;
end;

procedure TfmTrailer.btnDecodeClick(Sender: TObject);
begin
  Driver.BlockDataHex := edtTrailer.Text;
  if (Length(edtTrailer.Text) <> 32) or
     (not DecodeTrailer) then
  begin
    btnWrite.Enabled := False;
    lblWarning.Caption := 'Ошибка в трейлере!';
    lblWarning.Visible := True
  end else
  begin
    btnWrite.Enabled := True;
    lblWarning.Visible := False;
  end;
end;

procedure TfmTrailer.btnEncodeClick(Sender: TObject);
begin
  btnWrite.Enabled := True;
  lblWarning.Visible := False;
  EncodeTrailer;
end;

procedure TfmTrailer.edtNewKeyAChange(Sender: TObject);
begin
  if Length(edtNewKeyA.Text) = 12 then
  begin
    btnWrite.Enabled := True;
    btnEncode.Enabled := True;
    lblWarning2.Visible := False;
  end
  else begin
    btnWrite.Enabled := False;
    btnEncode.Enabled := False;
    lblWarning2.Caption := 'Ключи должны состоять из 12 байт!';
    lblWarning2.Visible := True
  end;
end;

procedure TfmTrailer.edtNewKeyBChange(Sender: TObject);
begin
  if Length(edtNewKeyB.Text) = 12 then
  begin
    btnWrite.Enabled := True;
    btnEncode.Enabled := True;
    lblWarning2.Visible := False;
  end
  else begin
    btnWrite.Enabled := False;
    btnEncode.Enabled := False;
    lblWarning2.Caption := 'Ключи должны состоять из 12 байт!';
    lblWarning2.Visible := True
  end;
end;

procedure TfmTrailer.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function TfmTrailer.CheckHexKey(Key: string): Boolean;
var
  C: Char;
  i: Integer;
begin
  Result := False;
  if Key = '' then
    Exit;
  for i := 1 to Length(Key) do
  begin
    C := Key[i];
    if not (C in ['0'..'9','A'..'F']) then
      Exit;
  end;
  Result := True;
end;

end.

