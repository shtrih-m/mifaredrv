unit CardField;

interface

Uses
  // VCL
  Classes, SysUtils, IniFiles,
  // This
  MifareLib_TLB, untTypes;

type
  TCardField = class;

  { TCardFields }

  TCardFields = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TCardField;
    procedure InsertItem(AItem: TCardField);
    procedure RemoveItem(AItem: TCardField);
    function GetData: string;
    function GetDataSize: Integer;
    procedure SetData(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure ClearValues;
    function Add: TCardField;
    procedure Assign(Src: TCardFields);
    function IsEqual(Src: TCardFields): Boolean;
    procedure SaveToFile(const FileName: string);
    procedure LoadFromFile(const FileName: string);

    property Count: Integer read GetCount;
    property Size: Integer read GetDataSize;
    property Data: string read GetData write SetData;
    property Items[Index: Integer]: TCardField read GetItem; default;
  end;

  { TCardField }

  TCardField = class
  private
    FOwner: TCardFields;
    procedure SetOwner(AOwner: TCardFields);
  public
    Tag: Integer;
    Size: Integer;
    Text: string;
    Value: string;
    FieldType: TFieldType;
    constructor Create(AOwner: TCardFields);
    destructor Destroy; override;

    procedure ClearValue;
    function GetData: string;
    function DataSize: Integer;
    procedure Assign(Src: TCardField);
    procedure SetData(var Data: string);
    function IsEqual(Src: TCardField): Boolean;
  end;

implementation

function IntToBin(Value: Integer; DataLength: Integer): string;
begin
  Result := '';
  if DataLength > 0 then
  begin
    SetLength(Result, DataLength);
    Move(Value, Result[1], DataLength);
  end;
end;

function BinToInt(S: string; Index, Count: Integer): Int64;
begin
  Result := 0;
  Move(S[1], Result, Count);
end;

function DblToBin(Value: Double; DataLength: Integer): string;
begin
  Result := '';
  if DataLength > 0 then
  begin
    SetLength(Result, DataLength);
    Move(Value, Result[1], DataLength);
  end;
end;

function BinToDbl(S: string; Index, Count: Integer): Double;
begin
  Move(S[1], Result, Count);
end;

function GetStr(const Value: string; DataLength: Integer): string;
begin
  Result := Copy(Value, 1, DataLength);
  Result := Result + StringOfChar(#0, DataLength - Length(Result));
end;

{ TCardFields }

constructor TCardFields.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TCardFields.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TCardFields.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TCardFields.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TCardFields.GetItem(Index: Integer): TCardField;
begin
  Result := FList[Index];
end;

procedure TCardFields.InsertItem(AItem: TCardField);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TCardFields.RemoveItem(AItem: TCardField);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TCardFields.GetData: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Count-1 do
    Result := Result + Items[i].GetData;
end;

procedure TCardFields.SetData(const Value: string);
var
  i: Integer;
  Data: string;
begin
  Data := Value;
  for i := 0 to Count-1 do
    Items[i].SetData(Data);
end;

function TCardFields.Add: TCardField;
begin
  Result := TCardField.Create(Self);
end;

function TCardFields.GetDataSize: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count-1 do
    Result := Result + Items[i].DataSize;
end;

function TCardFields.IsEqual(Src: TCardFields): Boolean;
var
  i: Integer;
begin
  Result := Count = Src.Count;
  if not Result then Exit;

  for i := 0 to Count-1 do
  begin
    Result := Items[i].IsEqual(Src[i]);
    if not Result then Exit;
  end;
end;

procedure TCardFields.Assign(Src: TCardFields);
var
  i: Integer;
begin
  Clear;
  for i := 0 to Src.Count-1 do
    Add.Assign(Src[i]);
end;

procedure TCardFields.ClearValues;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].ClearValue;
end;

procedure TCardFields.LoadFromFile(const FileName: string);
var
  S: string;
  i: Integer;
  Section: string;
  Field: TCardField;
  IniFile: TIniFile;
  Sections: TStrings;
begin
  Clear;
  Sections := TStringList.Create;
  IniFile := TIniFile.Create(FileName);
  try
    IniFile.ReadSections(Sections);
    for i := 0 to Sections.Count-1 do
    begin
      Field := Add;
      Section := Sections[i];

      S := Format('Поле %d', [i+1]);
      Field.Text := IniFile.ReadString(Section, 'FieldText', S);
      Field.Size := IniFile.ReadInteger(Section, 'FieldSize', 1);
      Field.Value := IniFile.ReadString(Section, 'FieldValue', '');
      Field.FieldType := IniFile.ReadInteger(Section, 'FieldType', ftByte);
      Field.Tag := IniFile.ReadInteger(Section, 'FieldTag', 0);
    end;
  finally
    IniFile.Free;
    Sections.Free;
  end;
end;

procedure TCardFields.SaveToFile(const FileName: string);
var
  i: Integer;
  Section: string;
  Field: TCardField;
  IniFile: TIniFile;
begin
  if FileExists(FileName) then
    DeleteFile(FileName);
  IniFile := TIniFile.Create(FileName);
  try
    for i := 0 to Count-1 do
    begin
      Field := Items[i];
      Section := IntToStr(i);
      IniFile.WriteString(Section, 'FieldText', Field.Text);
      IniFile.WriteInteger(Section, 'FieldSize', Field.Size);
      IniFile.WriteString(Section, 'FieldValue', Field.Value);
      IniFile.WriteInteger(Section, 'FieldType', Field.FieldType);
      IniFile.WriteInteger(Section, 'FieldTag', Field.Tag);
    end;
  finally
    IniFile.Free;
  end;
end;

{ TCardField }

constructor TCardField.Create(AOwner: TCardFields);
begin
  inherited Create;
  SetOwner(AOwner);
end;

destructor TCardField.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

function TCardField.DataSize: Integer;
begin
  case FieldType of
    ftByte     : Result := 1;
    ftSmallint : Result := 2;
    ftInteger  : Result := 4;
    ftDouble   : Result := 8;
    ftBool     : Result := 1;
    ftString   : Result := Size;
  else
    raise Exception.Create('Неизвестный тип карты');
  end;
end;

function TCardField.GetData: string;
begin
  case FieldType of
    ftByte     : Result := IntToBin(StrToInt(Value), 1);
    ftSmallint : Result := IntToBin(StrToInt(Value), 2);
    ftInteger  : Result := IntToBin(StrToInt(Value), 4);
    ftDouble   : Result := DblToBin(StrToFloat(Value), 8);
    ftBool     : Result := IntToBin(StrToInt(Value), 1);
    ftString   : Result := GetStr(Value, Size);
  else
    raise Exception.Create('Неизвестный тип карты');
  end;
end;

procedure TCardField.SetData(var Data: string);
begin
  if Length(Data) < DataSize then
    raise Exception.Create('Неверная длина данных.');

  case FieldType of
    ftByte     : Value := IntToStr(BinToInt(Data, 1, 1));
    ftSmallint : Value := IntToStr(BinToInt(Data, 1, 2));
    ftInteger  : Value := IntToStr(BinToInt(Data, 1, 4));
    ftDouble   : Value := FloatToStr(BinToDbl(Data, 1, 8));
    ftBool     : Value := IntToStr(BinToInt(Data, 1, 1));
    ftString   : Value := PChar(Copy(Data, 1, Size));
  else
    raise Exception.Create('Неизвестный тип карты');
  end;
  Data := Copy(Data, DataSize+1, Length(Data));
end;

procedure TCardField.SetOwner(AOwner: TCardFields);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

function TCardField.IsEqual(Src: TCardField): Boolean;
begin
  // FieldText
  Result := AnsiCompareStr(Src.Text, Self.Text) = 0;
  if not Result then Exit;
  // FieldSize
  Result := Src.Size = Self.Size;
  if not Result then Exit;
  // FieldValue
  Result := AnsiCompareStr(Src.Value, Self.Value) = 0;
  if not Result then Exit;
  // FieldType
  Result := Src.FieldType = Self.FieldType;
  if not Result then Exit;
  // FieldTag
  Result := Src.Tag = Self.Tag;
  if not Result then Exit;
end;

procedure TCardField.Assign(Src: TCardField);
begin
  Tag := Src.Tag;
  Text := Src.Text;
  Size := Src.Size;
  Value := Src.Value;
  FieldType := Src.FieldType;
end;

procedure TCardField.ClearValue;
begin
  Value := '';
end;

end.
