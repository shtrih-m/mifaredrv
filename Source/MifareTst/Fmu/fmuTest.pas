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
  Memo.Lines.Add(Format(' Результат: %d, %s',
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
    Memo.Lines.Add(Format('  Поле №%d :', [i]));
    Memo.Lines.Add('    Тип       : ' + FieldType[Driver.FieldType]);
    Memo.Lines.Add('    Значение  : ' + Driver.FieldValue);
  end;
end;

procedure TfmTest.WriteData;
begin
  Check(Driver.WriteData);
  Memo.Lines.Add('   Записано: '+Driver.Data);
  // Очищаем чтобы убедиться, что данные были действительно прочитаны
  Driver.Data := '';
  Check(Driver.ReadData);
  Memo.Lines.Add('   Прочитано: '+Driver.Data)
end;

(*******************************************************************************

 Запись данных c использованием каталога MikleSoft и без использования каталога

 1. Тест записывает некоторые данные на карту, используя каталог,
    а затем считывает их.
 2. Записывает некоторые данные на карту без использования каталога,
    а затем считывает их (прямой доступ к секторам).

*******************************************************************************)

procedure TfmTest.btnWriteDataClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add('         Запись данных');
    Memo.Lines.Add(' --------------------------------');

    Driver.FirmCode := 1;
    Driver.AppCode := 10;
    // Ключи
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
    // Используем каталог MikleSoft
    Memo.Lines.Add(' 1. Каталог MikleSoft');
    Driver.DataMode := dmMikleSoftDir;
    Driver.DataSize := 120;
    Driver.Data := StringOfStr('Строка тестовых данных 1', 5);
    WriteData;
    // Каталог не используется - прямой доступ к секторам
    Memo.Lines.Add(' 2. Каталог не используется');
    Driver.DataMode := dmDirNotUsed;
    Driver.Data := StringOfStr('Строка тестовых данных 2', 5);
    Driver.SectorNumber := 2;
    WriteData;
  finally
    AddResult;
    EnableButtons(True);
  end;
end;


(*******************************************************************************

                              Запись полей.

 Тест формирует поля данных всех поддерживаемых типов, записывает их на карту,
 а затем считывает.

*******************************************************************************)

procedure TfmTest.btnWriteFieldClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Update;
    Memo.Lines.Add('');
    Memo.Lines.Add('         Запись полей');
    Memo.Lines.Add(' --------------------------------');
    // Ключи
    Driver.KeyA := 'FFFFFFFFFFFF';
    Driver.KeyB := 'FFFFFFFFFFFF';
    Driver.FirmCode := 1;
    Driver.AppCode := 10;
    // Удаление всех полей
    Driver.DeleteAllFields;
    // Создание полей
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
    // Запись полей
    Check(Driver.WriteFields);
    Memo.Lines.Add('');
    Memo.Lines.Add(' Записано:');
    Memo.Lines.Add(' --------------------------------');
    FieldsToMemo;
    // Очищаем значения всех полей чтобы убедиться, что
    // мы действительно прочитали данные.
    Driver.ClearFieldValues;
    Check(Driver.ReadFields);
    Memo.Lines.Add('');
    Memo.Lines.Add(' Прочитано:');
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
    Memo.Lines.Add('         Тест ключа А');
    Memo.Lines.Add(' --------------------------------');
    //for i := 0 to 15 do
    begin
      Driver.BlockNumber := 3;
      Check(Driver.PiccActivateWakeup);
      Driver.KeyType := ktKeyA;
      Driver.KeyUncoded := 'FFFFFFFFFFFF';
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);

      Memo.Lines.Add(' Авторизация по ключу А'+' = '+Driver.KeyUncoded+' прошла');
      Check(Driver.PiccRead);
      // Ключ А при чтении трейлера невозможно прочитать
      //if Driver.BlockDataHex <> '000000000000FF078069FFFFFFFFFFFF' then Abort;
      //Memo.Lines.Add(' Ключ А невозможно прочитать: '+Driver.BlockDataHex);
      // Пишем новый ключ
      Driver.BlockDataHex := '010203040506FF078069FFFFFFFFFFFF';
      Check(Driver.PiccWrite);
      // Подключаемся с новым ключом
      Check(Driver.PiccActivateWakeup);
      Driver.KeyUncoded := '010203040506';
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);
      Memo.Lines.Add(' Авторизация по ключу А'+' = '+Driver.KeyUncoded+' прошла');
      Check(Driver.PiccRead);
      // Ключ А при чтении трейлера невозможно прочитать
      //if Driver.BlockDataHex <> '000000000000FF078069FFFFFFFFFFFF' then Abort;
      //Memo.Lines.Add(' Ключ А невозможно прочитать: '+Driver.BlockDataHex);
      // Подключаемся с новым ключом к блоку данных
      Memo.Lines.Add(' Чтение/запись данных по ключу А:');
      Check(Driver.PiccActivateWakeup);
      Driver.BlockNumber := 2;
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);
      Memo.Lines.Add(' Авторизация по ключу А'+' = '+Driver.KeyUncoded+' прошла');
      Driver.BlockData := '1234567890ABCDEF';
      Check(Driver.PiccWrite);
      Memo.Lines.Add('   Записано: '+Driver.BlockData);
      Driver.BlockData := '';
      Check(Driver.PiccRead);
      if Driver.BlockData <> '1234567890ABCDEF' then
      begin
        Memo.Lines.Add('Ошибка! Прочитано: ' + Driver.BlockData);
        Exit;
      end;
      Memo.Lines.Add('   Прочитано: '+Driver.BlockData);
      // Восстанавливаем старый ключ
      Check(Driver.PiccActivateWakeup);
      Driver.BlockNumber := 3;
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);
      Memo.Lines.Add(' Авторизация по ключу А'+' = '+Driver.KeyUncoded+' прошла');
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
    Memo.Lines.Add('         Тест ключа B');
    Memo.Lines.Add(' --------------------------------');
    Driver.BlockNumber := 3;
    // Подключаемся с ключом B
    Check(Driver.PiccActivateWakeup);
    Driver.KeyType := ktKeyB;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' Авторизация по ключу B'+' = '+Driver.KeyUncoded+' прошла');
    // По ключу B нельзя читать трейлер
    if Driver.PiccRead = 0 then Abort;
    Memo.Lines.Add(' По ключу B нельзя читать трейлер');
    Check(Driver.PiccActivateWakeup);
    // По ключу B нельзя писать в трейлер
    Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069010203040506';
    if Driver.PiccWrite = 0 then Abort;
    Memo.Lines.Add(' По ключу B нельзя писать в трейлер');
    // Подключаемся с ключом А
    Check(Driver.PiccActivateWakeup);
    Driver.KeyType := ktKeyA;
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' Авторизация по ключу A'+' = '+Driver.KeyUncoded+' прошла');
    Check(Driver.PiccWrite);
    // Подключаемся с новым ключом B
    Check(Driver.PiccActivateWakeup);
    // Авторизация проходит = ключ B был действительно изменен
    Driver.KeyType := ktKeyB;
    Driver.KeyUncoded := '010203040506';
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' Авторизация по ключу B'+' = '+Driver.KeyUncoded+' прошла');
    // Подключаемся с новым ключом к блоку данных
    Check(Driver.PiccActivateWakeup);
    Driver.BlockNumber := 2;
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' Авторизация по ключу B'+' = '+Driver.KeyUncoded+' прошла');
    // В режиме transport configuration ключ B не позволяет
    // ни читать ни писать данные.
    if Driver.PiccWrite = 0 then Abort;
    Memo.Lines.Add(' По ключу B нельзя писать данные в режиме transport configuration');
    Check(Driver.PiccActivateWakeup);
    if Driver.PiccRead = 0 then Abort;
    Memo.Lines.Add(' По ключу B нельзя читать данные в режиме transport configuration');
    // Подключаемся с ключем A
    Check(Driver.PiccActivateWakeup);
    Driver.BlockNumber := 3;
    Driver.KeyType := ktKeyA;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Check(Driver.EncodeKey);
    Check(Driver.PiccAuthKey);
    Memo.Lines.Add(' Авторизация по ключу A'+' = '+Driver.KeyUncoded+' прошла');
    // Читаем трейлер по ключу A
    Check(Driver.PiccRead);
    // Ключ B доступен для чтения в режиме transport configuration (B=010203040506)
    if Driver.BlockDataHex <> '000000000000FF078069010203040506' then Abort;
    Memo.Lines.Add(' Ключ B был изменен и прочитан: '+Driver.BlockDataHex);
    // Восстанавливаем старый ключ
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
    Memo.Lines.Add('     Тест работы с каталогом');
    Memo.Lines.Add(' --------------------------------');
    // Запись каталога
    Memo.Lines.Add(' Запись каталога:');
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Driver.FirmCode := 10+i;
      Driver.AppCode := 20+i;
      Check(Driver.SetSectorParams);
    end;
    Memo.Lines.Add(' --------------------------------');
    Memo.Lines.Add(' Сектор  Фирма  Приложение');
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Check(Driver.GetSectorParams);
      Memo.Lines.Add(Format('%6d %6d %11d',[Driver.SectorNumber, Driver.FirmCode, Driver.AppCode]));
    end;
    Memo.Lines.Add('');
    Check(Driver.WriteDirectory);
    // Очищаем каталог
    Driver.AppCode := 0;
    Driver.FirmCode := 0;
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Check(Driver.SetSectorParams);
    end;
    // Чтение каталога
    Memo.Lines.Add(' Чтение каталога:');
    Check(Driver.ReadDirectory);
    Memo.Lines.Add(' --------------------------------');
    Memo.Lines.Add(' Сектор  Фирма  Приложение');
    for i := 0 to Driver.SectorCount - 1 do
    begin
      Driver.SectorIndex := i;
      Check(Driver.GetSectorParams);
      Memo.Lines.Add(Format('%6d %6d %11d',[Driver.SectorNumber, Driver.FirmCode, Driver.AppCode]));
    end;
    Memo.Lines.Add('');
    Memo.Lines.Add(' Статус каталога: ' + Driver.DirectoryStatusText);
    // Очищаем каталог на карте
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
    Memo.Lines.Add(Format('Сектор %.2d: %s, ошибка активации карты',
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
    Memo.Lines.Add(Format('Сектор %.2d: %s, OK', [BlockNumber div 4, KeyValue]));
    //if KeyValue <> 'FFFFFFFFFFFF' then
    begin
      Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069FFFFFFFFFFFF';
      Driver.PiccWrite; 
    end;
  end else
  begin
    // Memo.Lines.Add(Format('Сектор %.2d: %s, ошибка авторизации !',
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



  Memo.Lines.Add(Format('Сектор %.2d: ошибка авторизации !',
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
    Memo.Lines.Add(' Проверка ключа А');
    Memo.Lines.Add(' --------------------------------');
    for i := 0 to 15 do
    begin
      PiccAuthKeys(i*4 + 3, ktKeyA);
    end;
    Memo.Lines.Add(' Проверка ключа B');
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

{ Кодирование ключа 6 байт в 12 }

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
