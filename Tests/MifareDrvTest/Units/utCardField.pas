unit utCardField;

interface

uses
  // VCL
  SysUtils,
  // DUnit
  TestFramework,
  // This
  CardField, MifareLib_TLB;

type
  { TCardFieldTest }

  TCardFieldTest = class(TTestCase)
  published
    procedure CheckFieldsData;
    procedure CheckFieldsSave;
  end;

implementation

{ TCardFieldTest }

procedure CreateFields(Fields: TCardFields);
var
  Field: TCardField;
begin
  // ftByte
  Field := Fields.Add;
  Field.FieldType := ftByte;
  Field.Value := IntToStr(56);
  Field.Text := 'ftByte';
  Field.Tag := 1;
  // ftSmallint
  Field := Fields.Add;
  Field.FieldType := ftSmallint;
  Field.Value := IntToStr(65534);
  Field.Text := 'ftSmallint';
  Field.Tag := 2;
  // ftInteger
  Field := Fields.Add;
  Field.FieldType := ftInteger;
  Field.Value := IntToStr(50238402);
  Field.Text := 'ftInteger';
  Field.Tag := 3;
  // ftDouble
  Field := Fields.Add;
  Field.FieldType := ftDouble;
  Field.Value := FloatToStr(129.789);
  Field.Text := 'ftDouble';
  Field.Tag := 4;
  // ftBool
  Field := Fields.Add;
  Field.FieldType := ftBool;
  Field.Value := IntToStr(0);
  Field.Text := 'ftBool';
  Field.Tag := 5;
  // ftString
  Field := Fields.Add;
  Field.FieldType := ftString;
  Field.Value := '0123456789';
  Field.Size := 10;
  Field.Text := 'ftString';
  Field.Tag := 6;
end;

procedure TCardFieldTest.CheckFieldsData;
var
  Data: string;
  Src: TCardFields;
  Dst: TCardFields;
begin
  Src := TCardFields.Create;
  Dst := TCardFields.Create;
  try
    CreateFields(Src);
    Data := Src.Data;

    Dst.Assign(Src);
    Dst.ClearValues;
    Dst.Data := Data;
    Check(Src.IsEqual(Dst));
  finally
    Src.Free;
    Dst.Free;
  end;
end;

procedure TCardFieldTest.CheckFieldsSave;
var
  Src: TCardFields;
  Dst: TCardFields;
  FileName: string;
begin
  FileName := ExtractFilePath(ParamStr(0)) + '\Test.ini';

  if FileExists(FileName) then
    DeleteFile(FileName);

  Src := TCardFields.Create;
  Dst := TCardFields.Create;
  try
    CreateFields(Src);
    Src.SaveToFile(FileName);
    Dst.LoadFromFile(FileName);
    Check(Src.IsEqual(Dst));
  finally
    Src.Free;
    Dst.Free;
  end;
end;

initialization
  RegisterTest('', TCardFieldTest.Suite);

end.
