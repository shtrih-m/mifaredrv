unit CardField;

interface

Uses
  // VCL
  Classes, SysUtils, IniFiles;


type
  // Constants for enum TFieldtype
  TFieldtype = (
    ftByte, ftSmallint,
    ftBool,
    ftInteger,
    ftDouble,
    ftString);

  TCardField = class;

  { TCardFields }

  TCardFields = class(TComponent)
  private
    function GetData: string;
    function GetCount: Integer;
    function GetDataSize: Integer;
    procedure SetData(const Value: string);
    function GetItem(Index: Integer): TCardField;
  public
    procedure Clear;
    procedure ClearValues;
    function Add: TCardField;
    procedure Assign(Src: TCardFields);
    function IsEqual(Src: TCardFields): Boolean;
    procedure SaveToIni(const FileName: string);
    procedure LoadFromIni(const FileName: string);
    procedure SaveToFile(const FileName: string);
    procedure LoadFromFile(const FileName: string);

    property Count: Integer read GetCount;
    property Size: Integer read GetDataSize;
    property Data: string read GetData write SetData;
  published
    property Items[Index: Integer]: TCardField read GetItem; default;
  end;

  { TCardField }

  TCardField = class(TComponent)
  private
    FSize: Integer;
    FText: string;
    FValue: string;
    FFieldType: TFieldType;
  public
    procedure ClearValue;
    function GetData: string;
    function DataSize: Integer;
    procedure Assign(Src: TCardField);
    procedure SetData(var Data: string);
    function IsEqual(Src: TCardField): Boolean;
  published
    property Text: string read FText write FText;
    property Size: Integer read FSize write FSize;
    property Value: string read FValue write FValue;
    property FieldType: TFieldType read FFieldType write FFieldType;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('VK', [TCardFields]);
end;

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

procedure TCardFields.Clear;
begin
  DestroyComponents;
end;

function TCardFields.GetCount: Integer;
begin
  Result := ComponentCount;
end;

function TCardFields.GetItem(Index: Integer): TCardField;
begin
  Result := Components[Index] as TCardField;
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

procedure TCardFields.LoadFromIni(const FileName: string);
var
  IniFile: TIniFile;
begin
(*
  Clear;
  IniFile := TIniFile.Create(FileName);
  try
    IniFile.ReadComponent('CardFields', Self);
  finally
    IniFile.Free;
  end;
*)
end;

procedure TCardFields.SaveToIni(const FileName: string);
var
  IniFile: TIniFile;
begin
(*
  if FileExists(FileName) then
    DeleteFile(FileName);

  IniFile := TIniFile.Create(FileName);
  try
    IniFile.WriteComponent(Self, 'CardFields');
  finally
    IniFile.Free;
  end;
*)
end;

procedure TCardFields.LoadFromFile(const FileName: string);
begin
  { !!! }
end;

procedure TCardFields.SaveToFile(const FileName: string);
begin
  { !!! }
end;

{ TCardField }

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

function TCardField.IsEqual(Src: TCardField): Boolean;
begin
  // FieldName
  Result := AnsiCompareStr(Src.Name, Self.Name) = 0;
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
  Size := Src.Size;
  Value := Src.Value;
  FieldType := Src.FieldType;
end;

procedure TCardField.ClearValue;
begin
  Value := '';
end;

end.
