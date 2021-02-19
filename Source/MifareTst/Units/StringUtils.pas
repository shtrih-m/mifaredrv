unit StringUtils;

interface

uses
  // VCL
  SysUtils;

function HexToStr(Data: string): string;
function HexToInt(const Data: string): Integer;
function StrToHex(const S: string): string; overload;
function StrToHex8(const Data: string): string;
function StrToHex(const Data: string; LineSize: Integer): string; overload;

implementation

function Min(Value1, Value2: Integer): Integer;
begin
  if Value1 < Value2 then Result := Value1 else Result := Value2;
end;

function StrToHex(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
  begin
    Result := Result + IntToHex(Ord(S[i]), 2);
  end;
end;

function StrToHex(const Data: string; LineSize: Integer): string;
var
  i: Integer;
  Count: Integer;
begin
  Result := '';
  Count := (Length(Data) + LineSize -1 ) div LineSize;
  for i := 0 to Count-1 do
    Result := Result + StrToHex(Copy(Data, 1 + LineSize*i, LineSize)) + #13#10;
end;

function StrToHex8(const Data: string): string;
var
  i: Integer;
  Count: Integer;
begin
  Result := '';
  Count := (Length(Data) + 7) div 8;
  for i := 0 to Count-1 do
    Result := Result + StrToHex(Copy(Data, 1 + 8*i, 8)) + #13#10;
end;

function HexToChar(const Data: string): Char;
begin
  Result := Chr(StrToInt('$' + Data));
end;

function HexToStr(Data: string): string;
var
  C: Char;
  i: Integer;
  PrevChar: Char;
  HasPrev: Boolean;
begin
  Result := '';
  PrevChar := #0;
  HasPrev := False;

  for i := 1 to Length(Data) do
  begin
    C := Data[i];
    if C in ['0'..'9', 'A'..'F', 'a'..'f'] then
    begin
      if HasPrev then
      begin
        Result := Result + HexToChar(PrevChar + C);
        HasPrev := False;
      end else
      begin
        PrevChar := C;
        HasPrev := True;
      end;
    end else
    begin
      if HasPrev then
        Result := Result + HexToChar(PrevChar);
      HasPrev := False;
    end;
  end;
  if HasPrev then
    Result := Result + HexToChar(PrevChar);
end;

function SwapBytes(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    Result := S[i] + Result;
end;

function HexToInt(const Data: string): Integer;
var
  S: string;
  Count: Integer;
begin
  Result := 0;
  S := HexToStr(Data);
  S := SwapBytes(S);
  if Length(S) > 0 then
  begin
    Count := Min(Length(S), Sizeof(Result));
    Move(S[1], Result, Count);
  end;
end;

end.
