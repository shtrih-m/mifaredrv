unit MifareTrailer;

interface

uses
  // VCL
  SysUtils;

type
  { TMifareTrailer }

  TMifareTrailer = class
  public
    class function CheckAccessBits(Byte6, Byte7, Byte8: Integer): Boolean;
    class function Encode(C0, C1, C2, C3: Byte; const KeyA, KeyB: string): string;
    class procedure Decode(const Data: string; var C0, C1, C2, C3: Integer;
      var KeyA, KeyB: string);
  end;

implementation

function TestBit(Value, Bit: Integer): Boolean;
begin
  Result := (Value and (1 shl Bit)) <> 0;
end;

procedure SetBit(var Value: Integer; BitNumber: Integer);
begin
  Value := Value or (1 shl BitNumber);
end;

function Add0(const S: string; Count: Integer): string;
begin
  Result := Copy(S, 1, Count);
  Result := Result + StringOfChar(#0, Count - Length(Result));
end;

{ TMifareTrailer }

{ Создание блока }

class function TMifareTrailer.Encode(C0, C1, C2, C3: Byte;
  const KeyA, KeyB: string): string;
var
  Byte6: Integer;
  Byte7: Integer;
  Byte8: Integer;
begin
  // Byte6
  Byte6 := 0;
  if not TestBit(C0, 0) then SetBit(Byte6, 0);
  if not TestBit(C1, 0) then SetBit(Byte6, 1);
  if not TestBit(C2, 0) then SetBit(Byte6, 2);
  if not TestBit(C3, 0) then SetBit(Byte6, 3);
  if not TestBit(C0, 1) then SetBit(Byte6, 4);
  if not TestBit(C1, 1) then SetBit(Byte6, 5);
  if not TestBit(C2, 1) then SetBit(Byte6, 6);
  if not TestBit(C3, 1) then SetBit(Byte6, 7);
  // Byte7
  Byte7 := 0;
  if not TestBit(C0, 2) then SetBit(Byte7, 0);
  if not TestBit(C1, 2) then SetBit(Byte7, 1);
  if not TestBit(C2, 2) then SetBit(Byte7, 2);
  if not TestBit(C3, 2) then SetBit(Byte7, 3);
  if TestBit(C0, 0) then SetBit(Byte7, 4);
  if TestBit(C1, 0) then SetBit(Byte7, 5);
  if TestBit(C2, 0) then SetBit(Byte7, 6);
  if TestBit(C3, 0) then SetBit(Byte7, 7);
  // Byte8
  Byte8 := 0;
  if TestBit(C0, 1) then SetBit(Byte8, 0);
  if TestBit(C1, 1) then SetBit(Byte8, 1);
  if TestBit(C2, 1) then SetBit(Byte8, 2);
  if TestBit(C3, 1) then SetBit(Byte8, 3);
  if TestBit(C0, 2) then SetBit(Byte8, 4);
  if TestBit(C1, 2) then SetBit(Byte8, 5);
  if TestBit(C2, 2) then SetBit(Byte8, 6);
  if TestBit(C3, 2) then SetBit(Byte8, 7);
  // Data
  Result := Add0(KeyA, 6) + Chr(Byte6) + Chr(Byte7) + Chr(Byte8) + #$69 + Add0(KeyB, 6);
end;

{ Декодирование блока }

class procedure TMifareTrailer.Decode(const Data: string;
  var C0, C1, C2, C3: Integer; var KeyA, KeyB: string);
var
  Byte6: Integer;
  Byte7: Integer;
  Byte8: Integer;
begin
  if Length(Data) <> 16 then
    raise Exception.Create('Неверная длиина данных');

  Byte6 := Ord(Data[7]);
  Byte7 := Ord(Data[8]);
  Byte8 := Ord(Data[9]);
  if not CheckAccessBits(Byte6, Byte7, Byte8) then
    raise Exception.Create('Неверное значение битов доступа');

  C0 := 0;
  C1 := 0;
  C2 := 0;
  C3 := 0;
  if not TestBit(Byte6, 0) then SetBit(C0, 0);
  if not TestBit(Byte6, 1) then SetBit(C1, 0);
  if not TestBit(Byte6, 2) then SetBit(C2, 0);
  if not TestBit(Byte6, 3) then SetBit(C3, 0);
  if not TestBit(Byte6, 4) then SetBit(C0, 1);
  if not TestBit(Byte6, 5) then SetBit(C1, 1);
  if not TestBit(Byte6, 6) then SetBit(C2, 1);
  if not TestBit(Byte6, 7) then SetBit(C3, 1);
  if not TestBit(Byte7, 0) then SetBit(C0, 2);
  if not TestBit(Byte7, 1) then SetBit(C1, 2);
  if not TestBit(Byte7, 2) then SetBit(C2, 2);
  if not TestBit(Byte7, 3) then SetBit(C3, 2);
  KeyA := Copy(Data, 1, 6);
  KeyB := Copy(Data, 11, 6);
end;

class function TMifareTrailer.CheckAccessBits(Byte6, Byte7,
  Byte8: Integer): Boolean;
begin
  Result :=
    (TestBit(Byte6, 0) = not TestBit(Byte7, 4)) and
    (TestBit(Byte6, 1) = not TestBit(Byte7, 5)) and
    (TestBit(Byte6, 2) = not TestBit(Byte7, 6)) and
    (TestBit(Byte6, 3) = not TestBit(Byte7, 7)) and
    (TestBit(Byte6, 4) = not TestBit(Byte8, 0)) and
    (TestBit(Byte6, 5) = not TestBit(Byte8, 1)) and
    (TestBit(Byte6, 6) = not TestBit(Byte8, 2)) and
    (TestBit(Byte6, 7) = not TestBit(Byte8, 3)) and
    (TestBit(Byte7, 0) = not TestBit(Byte8, 4)) and
    (TestBit(Byte7, 1) = not TestBit(Byte8, 5)) and
    (TestBit(Byte7, 2) = not TestBit(Byte8, 6)) and
    (TestBit(Byte7, 3) = not TestBit(Byte8, 7));
end;




end.
