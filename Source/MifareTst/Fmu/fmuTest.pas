unit fmuTest;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  // This
  untPage, MifareLib_TLB, StringUtils, untUtil, MifareTrailer;

type

  { TfmTest }

  TfmTest = class(TPage)
    Memo: TMemo;
    btnWriteData: TButton;
    btnWriteField: TButton;
    btnKeyA: TButton;
    btnKeyB: TButton;
    btnCatalog: TButton;
    btnAuth: TButton;
    chbInitCard: TCheckBox;
    procedure btnWriteDataClick(Sender: TObject);
    procedure btnWriteFieldClick(Sender: TObject);
    procedure btnKeyAClick(Sender: TObject);
    procedure btnKeyBClick(Sender: TObject);
    procedure btnCatalogClick(Sender: TObject);
    procedure btnAuthClick(Sender: TObject);
  private
    procedure AddResult;
    procedure WriteData;
    procedure FieldsToMemo;
    procedure Check(ResultCode: Integer);
    procedure PiccAuthKeys(BlockNumber, KeyType: Integer);
    function PiccAuthKey(BlockNumber, KeyType: Integer;
      const KeyValue: string): Boolean;
  public
    procedure TestKey;
    procedure TestTrailer;
  end;

implementation

{$R *.DFM}

function StringOfStr(const S: string; Count: Integer): string;
begin
  Result := '';
  while Count > 0 do
  begin
    Result := Result + S;
    Dec(Count);
  end;
end;

{ TfmTest }

procedure TfmTest.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

procedure TfmTest.AddResult;
begin
  Memo.Lines.Add(' --------------------------------');
  Memo.Lines.Add(Format(' ���������: %d, %s',
    [Driver.ResultCode, Driver.ResultDescription]));
end;

procedure TfmTest.FieldsToMemo;
var
  i: Integer;
const
  FieldType: array [0..5] of string = (
    'Byte','Smallint', 'Bool', 'Integer', 'Double', 'String');
begin
  for i := 0 to Driver.FieldCount-1 do
  begin
    Driver.FieldIndex := i;
    Driver.GetFieldParams;
    Memo.Lines.Add(Format('  ���� �%d :', [i]));
    Memo.Lines.Add('    ���       : ' + FieldType[Driver.FieldType]);
    Memo.Lines.Add('    ��������  : ' + Driver.FieldValue);
  end;
end;

procedure TfmTest.WriteData;
begin
  Check(Driver.WriteData);
  Memo.Lines.Add('   ��������: '+Driver.Data);
  // ������� ����� ���������, ��� ������ ���� ������������� ���������
  Driver.Data := '';
  Check(Driver.ReadData);
  Memo.Lines.Add('   ���������: '+Driver.Data)
end;

(*******************************************************************************

 ������ ������ c �������������� �������� MikleSoft � ��� ������������� ��������

 1. ���� ���������� ��������� ������ �� �����, ��������� �������,
    � ����� ��������� ��.
 2. ���������� ��������� ������ �� ����� ��� ������������� ��������,
    � ����� ��������� �� (������ ������ � ��������).

*******************************************************************************)

procedure TfmTest.btnWriteDataClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add('         ������ ������');
    Memo.Lines.Add(' --------------------------------');

    Driver.FirmCode := 1;
    Driver.AppCode := 10;
    // �����
    if chbInitCard.Checked then
    begin
      Driver.KeyA := '4B6579410000';
      Driver.KeyB := '4B6579420000';
      Driver.UpdateTrailer := True;
      Driver.DataAuthMode := dmAuthByKey;

      Driver.KeyType := ktKeyA;
      Driver.KeyNumber := 1;
      Driver.KeyUncoded := '4B6579410000';
      Check(Driver.PcdLoadKeyE2);
    end else
    begin
      Driver.KeyA := '';
      Driver.KeyB := '';
      Driver.KeyType := ktKeyA;
      Driver.KeyNumber := 1;
      Driver.UpdateTrailer := False;
      Driver.DataAuthMode := dmAuthByReader;
    end;
    // ���������� ������� MikleSoft
    Memo.Lines.Add(' 1. ������� MikleSoft');
    Driver.DataMode := dmMikleSoftDir;
    Driver.DataSize := 120;
    Driver.Data := StringOfStr('������ �������� ������ 1', 5);
    WriteData;
    // ������� �� ������������ - ������ ������ � ��������
    Memo.Lines.Add(' 2. ������� �� ������������');
    Driver.DataMode := dmDirNotUsed;
    Driver.Data := StringOfStr('������ �������� ������ 2', 5);
    Driver.SectorNumber := 2;
    WriteData;
  finally
    AddResult;
    EnableButtons(True);
  end;
end;


(*******************************************************************************

                              ������ �����.

 ���� ��������� ���� ������ ���� �������������� �����, ���������� �� �� �����,
 � ����� ���������.

*******************************************************************************)

procedure TfmTest.btnWriteFieldClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add('         ������ �����');
    Memo.Lines.Add(' --------------------------------');
    // �����
    Driver.KeyA := 'FFFFFFFFFFFF';
    Driver.KeyB := 'FFFFFFFFFFFF';
    Driver.FirmCode := 1;
    Driver.AppCode := 10;
    // �������� ���� �����
    Driver.DeleteAllFields;
    // �������� �����
    // ftByte
    Driver.FieldType := ftByte;
    Driver.FieldValue := IntToStr(56);
    Driver.AddField;
    // ftSmallint
    Driver.FieldType := ftSmallint;
    Driver.FieldValue := IntToStr(65534);
    Driver.AddField;
    // ftInteger
    Driver.FieldType := ftInteger;
    Driver.FieldValue := IntToStr(50238402);
    Driver.AddField;
    // ftDouble
    Driver.FieldType := ftDouble;
    Driver.FieldValue := FloatToStr(129.789);
    Driver.AddField;
    // ftBool
    Driver.FieldType := ftBool;
    Driver.FieldValue := IntToStr(0);
    Driver.AddField;
    // ftString
    Driver.FieldType := ftString;
    Driver.FieldValue := '0123456789';
    Driver.FieldSize := 10;
    Driver.AddField;
    // ������ �����
    Check(Driver.WriteFields);
    Memo.Lines.Add('');
    Memo.Lines.Add(' ��������:');
    Memo.Lines.Add(' --------------------------------');
    FieldsToMemo;
    // ������� �������� ���� ����� ����� ���������, ���
    // �� ������������� ��������� ������.
    Driver.ClearFieldValues;
    Check(Driver.ReadFields);
    Memo.Lines.Add('');
    Memo.Lines.Add(' ���������:');
    Memo.Lines.Add(' --------------------------------');
    FieldsToMemo;
  finally
    AddResult;
    EnableButtons(True);
  end;
end;

procedure TfmTest.btnKeyAClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add('         ���� ����� �');
    Memo.Lines.Add(' --------------------------------');
    //for i := 0 to 15 do
    begin
      Driver.BlockNumber := 3;
      Check(Driver.PiccActivateWakeup);
      Driver.KeyType := ktKeyA;
      Driver.KeyUncoded := 'FFFFFFFFFFFF';
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);

      Memo.Lines.Add(' ����������� �� ����� �'+' = '+Driver.KeyUncoded+' ������');
      Check(Driver.PiccRead);
      // ���� � ��� ������ �������� ���������� ���������
      //if Driver.BlockDataHex <> '000000000000FF078069FFFFFFFFFFFF' then Abort;
      //Memo.Lines.Add(' ���� � ���������� ���������: '+Driver.BlockDataHex);
      // ����� ����� ����
      Driver.BlockDataHex := '010203040506FF078069FFFFFFFFFFFF';
      Check(Driver.PiccWrite);
      // ������������ � ����� ������
      Check(Driver.PiccActivateWakeup);
      Driver.KeyUncoded := '010203040506';
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);
      Memo.Lines.Add(' ����������� �� ����� �'+' = '+Driver.KeyUncoded+' ������');
      Check(Driver.PiccRead);
      // ���� � ��� ������ �������� ���������� ���������
      //if Driver.BlockDataHex <> '000000000000FF078069FFFFFFFFFFFF' then Abort;
      //Memo.Lines.Add(' ���� � ���������� ���������: '+Driver.BlockDataHex);
      // ������������ � ����� ������ � ����� ������
      Memo.Lines.Add(' ������/������ ������ �� ����� �:');
      Check(Driver.PiccActivateWakeup);
      Driver.BlockNumber := 2;
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);
      Memo.Lines.Add(' ����������� �� ����� �'+' = '+Driver.KeyUncoded+' ������');
      Driver.BlockData := '1234567890ABCDEF';
      Check(Driver.PiccWrite);
      Memo.Lines.Add('   ��������: '+Driver.BlockData);
      Driver.BlockData := '';
      Check(Driver.PiccRead);
      if Driver.BlockData <> '1234567890ABCDEF' then
      begin
        Memo.Lines.Add('������! ���������: ' + Driver.BlockData);
        Exit;
      end;
      Memo.Lines.Add('   ���������: '+Driver.BlockData);
      // ��������������� ������ ����
      Check(Driver.PiccActivateWakeup);
      Driver.BlockNumber := 3;
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);
      Memo.Lines.Add(' ����������� �� ����� �'+' = '+Driver.KeyUncoded+' ������');
      Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069FFFFFFFFFFFF';
      Check(Driver.PiccWrite);
    end;
  finally
    AddResult;
    EnableButtons(True);
  end;
end;

procedure TfmTest.btnKeyBClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add('         ���� ����� B');
    Memo.Lines.Add(' --------------------------------');
    Driver.BlockNumber := 3;
    // ������������ � ������ B
    Check(Driver.PiccActivateWakeup);
    Driver.KeyType := ktKeyB;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' ����������� �� ����� B'+' = '+Driver.KeyUncoded+' ������');
    // �� ����� B ������ ������ �������
    if Driver.PiccRead = 0 then Abort;
    Memo.Lines.Add(' �� ����� B ������ ������ �������');
    Check(Driver.PiccActivateWakeup);
    // �� ����� B ������ ������ � �������
    Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069010203040506';
    if Driver.PiccWrite = 0 then Abort;
    Memo.Lines.Add(' �� ����� B ������ ������ � �������');
    // ������������ � ������ �
    Check(Driver.PiccActivateWakeup);
    Driver.KeyType := ktKeyA;
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' ����������� �� ����� A'+' = '+Driver.KeyUncoded+' ������');
    Check(Driver.PiccWrite);
    // ������������ � ����� ������ B
    Check(Driver.PiccActivateWakeup);
    // ����������� �������� = ���� B ��� ������������� �������
    Driver.KeyType := ktKeyB;
    Driver.KeyUncoded := '010203040506';
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' ����������� �� ����� B'+' = '+Driver.KeyUncoded+' ������');
    // ������������ � ����� ������ � ����� ������
    Check(Driver.PiccActivateWakeup);
    Driver.BlockNumber := 2;
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' ����������� �� ����� B'+' = '+Driver.KeyUncoded+' ������');
    // � ������ transport configuration ���� B �� ���������
    // �� ������ �� ������ ������.
    if Driver.PiccWrite = 0 then Abort;
    Memo.Lines.Add(' �� ����� B ������ ������ ������ � ������ transport configuration');
    Check(Driver.PiccActivateWakeup);
    if Driver.PiccRead = 0 then Abort;
    Memo.Lines.Add(' �� ����� B ������ ������ ������ � ������ transport configuration');
    // ������������ � ������ A
    Check(Driver.PiccActivateWakeup);
    Driver.BlockNumber := 3;
    Driver.KeyType := ktKeyA;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' ����������� �� ����� A'+' = '+Driver.KeyUncoded+' ������');
    // ������ ������� �� ����� A
    Check(Driver.PiccRead);
    // ���� B �������� ��� ������ � ������ transport configuration (B=010203040506)
    if Driver.BlockDataHex <> '000000000000FF078069010203040506' then Abort;
    Memo.Lines.Add(' ���� B ��� ������� � ��������: '+Driver.BlockDataHex);
    // ��������������� ������ ����
    Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069FFFFFFFFFFFF';
    Check(Driver.PiccWrite);
    Check(Driver.PiccActivateWakeup);
  finally
    AddResult;
    EnableButtons(True);
  end;
end;

procedure TfmTest.btnCatalogClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add('     ���� ������ � ���������');
    Memo.Lines.Add(' --------------------------------');
    // ������ ��������
    Memo.Lines.Add(' ������ ��������:');
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Driver.FirmCode := 10+i;
      Driver.AppCode := 20+i;
      Check(Driver.SetSectorParams);
    end;
    Memo.Lines.Add(' --------------------------------');
    Memo.Lines.Add(' ������  �����  ����������');
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Check(Driver.GetSectorParams);
      Memo.Lines.Add(Format('%6d %6d %11d',[Driver.SectorNumber, Driver.FirmCode, Driver.AppCode]));
    end;
    Memo.Lines.Add('');
    Check(Driver.WriteDirectory);
    // ������� �������
    Driver.AppCode := 0;
    Driver.FirmCode := 0;
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Check(Driver.SetSectorParams);
    end;
    // ������ ��������
    Memo.Lines.Add(' ������ ��������:');
    Check(Driver.ReadDirectory);
    Memo.Lines.Add(' --------------------------------');
    Memo.Lines.Add(' ������  �����  ����������');
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Check(Driver.GetSectorParams);
      Memo.Lines.Add(Format('%6d %6d %11d',[Driver.SectorNumber, Driver.FirmCode, Driver.AppCode]));
    end;
    Memo.Lines.Add('');
    Memo.Lines.Add(' ������ ��������: ' + Driver.DirectoryStatusText);
    // ������� ������� �� �����
    Driver.AppCode := 0;
    Driver.FirmCode := 0;
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Check(Driver.SetSectorParams);
    end;
    Driver.WriteDirectory;
  finally
    AddResult;
    EnableButtons(True);
  end;
end;

const
  KEY_HEADER = 'HEADER';
  KEY_CATALOG = 'CATAL.';
  KEY_MIKLESOFT = #$00#$00#$00#$00#$00#$00;
  KEY_STANDARD = #$FF#$FF#$FF#$FF#$FF#$FF;

{ PiccAuthKey }

function TfmTest.PiccAuthKey(BlockNumber, KeyType: Integer;
  const KeyValue: string): Boolean;
var
  i: Integer;
begin
  for i := 1 to 3 do
  begin
    Result := Driver.PiccActivateWakeup = 0;
    if Result then Break;
  end;

  if not Result then
  begin
    Memo.Lines.Add(Format('������ %.2d: %s, ������ ��������� �����',
        [BlockNumber div 4, KeyValue]));
    Exit;
  end;


  Driver.KeyType := KeyType;
  Driver.BlockNumber := BlockNumber;
  // FFFFFFFFFFFF
  Driver.KeyUncoded := KeyValue;
  Check(Driver.EncodeKey);
  Result := Driver.PiccAuthKey = 0;
  if Result then
  begin
    Memo.Lines.Add(Format('������ %.2d: %s, OK', [BlockNumber div 4, KeyValue]));
    //if KeyValue <> 'FFFFFFFFFFFF' then
    begin
      Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069FFFFFFFFFFFF';
      Driver.PiccWrite; 
    end;
  end else
  begin
    // Memo.Lines.Add(Format('������ %.2d: %s, ������ ����������� !',
    //   [BlockNumber div 4, KeyValue]));
  end;
end;

procedure TfmTest.PiccAuthKeys(BlockNumber, KeyType: Integer);
begin
  // FFFFFFFFFFFF
  if PiccAuthKey(BlockNumber, KeyType, 'FFFFFFFFFFFF') then Exit;
  // 000000000000
  if PiccAuthKey(BlockNumber, KeyType, '000000000000') then Exit;
  // 010203040506
  if PiccAuthKey(BlockNumber, KeyType, '010203040506') then Exit;
  // KeyA
  if PiccAuthKey(BlockNumber, KeyType, '4B6579410000') then Exit;
  // KeyB
  if PiccAuthKey(BlockNumber, KeyType, '4B6579420000') then Exit;
  // KeyB
  if PiccAuthKey(BlockNumber, KeyType, 'FFFFFFFFFFFF') then Exit;

  // KEY_HEADER
  if PiccAuthKey(BlockNumber, KeyType, KEY_HEADER) then Exit;
  // KEY_CATALOG
  if PiccAuthKey(BlockNumber, KeyType, KEY_CATALOG) then Exit;

  // 111111111111
  if PiccAuthKey(BlockNumber, KeyType, '111111111111') then Exit;
  // 222222222222
  if PiccAuthKey(BlockNumber, KeyType, '222222222222') then Exit;

  if PiccAuthKey(BlockNumber, KeyType, HexToStr('4B6579410000')) then Exit;



  Memo.Lines.Add(Format('������ %.2d: ������ ����������� !',
    [BlockNumber div 4]));
end;

procedure TfmTest.btnAuthClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add(' �������� ����� �');
    Memo.Lines.Add(' --------------------------------');
    for i := 0 to 15 do
    begin
      PiccAuthKeys(i*4 + 3, ktKeyA);
    end;
    Memo.Lines.Add(' �������� ����� B');
    Memo.Lines.Add(' --------------------------------');
    for i := 0 to 15 do
    begin
      PiccAuthKeys(i*4 + 3, ktKeyB);
    end;
  finally
    EnableButtons(True);
  end;
end;

// 010203040506
// F0E1F0D2F0C3F0B4F0A5F096

{ ����������� ����� 6 ���� � 12 }

function EncodeKey(const Data: string): string;
var
  i: Integer;
  ln, hn: Byte;
begin
  Result := '';
  for i := 1 to Length(Data) do
  begin
    ln := Ord(Data[i]) and $0F;
    hn := Ord(Data[i]) shr 4;
    Result := Result + Chr(((not hn) shl 4) or hn);
    Result := Result + Chr(((not ln) shl 4) or ln);
  end;
end;

function DecodeKey(const Data: string): string;
var
  i: Integer;
  ln, hn: Byte;
  Count: Integer;
begin
  Result := '';
  Count := Length(Data) div 2;
  for i := 1 to Count do
  begin
    hn := Ord(Data[i*2-1]) and $0F;
    ln := (Ord(Data[i*2]) and $0F);
    Result := Result + Chr(ln + (hn shl 4));
  end;
end;

procedure TfmTest.TestKey;
var
  Data: string;
  Data2: string;
begin
  Data := HexToStr('010203040506');
  Data2 := DecodeKey(EncodeKey(Data));
  if Data <> Data2 then
  begin
    ODS(StrToHex(Data));
    ODS(StrToHex(Data2));
    Raise Exception.Create('Data ,> Data2')
  end;
end;

// FFFFFFFFFFFFFF078069FFFFFFFFFFFF
// 000000000000FF078069FFFFFFFFFFFF
// 000000000000FF078069FFFFFFFFFFFF
// 00000000000078778800000000000000

procedure TfmTest.TestTrailer;
var
  KeyA: string;
  KeyB: string;
  Data: string;
  Data2: string;
  C0, C1, C2, C3: Integer;
begin
  Data := HexToStr('FFFFFFFFFFFFFF078069FFFFFFFFFFFF');
  TMifareTrailer.Decode(Data, C0, C1, C2, C3, KeyA, KeyB);
  Data2 := TMifareTrailer.Encode(C0, C1, C2, C3, KeyA, KeyB);
  if Data <> Data2 then
  begin
    ODS(StrToHex(Data));
    ODS(StrToHex(Data2));
    raise Exception.CreateFmt('%s <> %s', [StrToHex(Data), StrToHex(Data2)]);
  end;

(*
  ODS('KeyA: ' + StrToHex(KeyA));
  ODS('KeyB: ' + StrToHex(KeyB));
  ODS('C0: ' + IntToHex(C0, 2));
  ODS('C1: ' + IntToHex(C1, 2));
  ODS('C2: ' + IntToHex(C2, 2));
  ODS('C3: ' + IntToHex(C3, 2));

  KeyA := HexToStr('FFFFFFFFFFFF');
  KeyB := HexToStr('FFFFFFFFFFFF');
  Data := TMifareTrailer.Encode(0,0,0,1, KeyA, KeyB);
  ODS(StrToHex(Data));
  ODS('FFFFFFFFFFFFFF078069FFFFFFFFFFFF');
*)
end;

end.
