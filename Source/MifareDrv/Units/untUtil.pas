unit untUtil;

interface

uses
  // VCL
  Windows, SysUtils, Forms, Controls, StdCtrls, Registry, Classes,
  // This
  MifareLib_TLB, untError;

procedure ODS(const Data: string);
function HexToStr(Data: string): string;
function StrToHex(const S: string): string;
function HexToInt(const Data: string): Integer;
function Add0(const S: string; Count: Integer): string;
function GetDeviceName(const DeviceName: string; DeviceNumber: Integer): string;
procedure GetDevicePorts(Ports: TStringList);
procedure DrvCheck(Driver: IMifareDrv2; ResultCode: Integer);

function SwapStr(const S: string): string;
function GetModuleFileName: string;
function GetLongFileName(const FileName: string): string;
function BufToStr(Buf: array of Byte; Count: Byte): string;
function BufToHex(const Buf: array of Byte; Count: Byte): string;
function HexToBin(const S: string; Count: Integer): string;
function BinToHex(const S: string; Count: Integer): string;
function SwapDWORD(Value: DWORD): DWORD;
function TestBit(Value, Bit: Integer): Boolean;
procedure SetBit(var Value: Integer; BitNumber: Integer);
procedure SwapBuf(var Src, Dst: array of Byte; Count: Byte);
procedure EnableFormButtons(Parent: TWinControl; Value: Boolean; var Control: TWinControl);
procedure CheckMinLength(const Data: string; MinLength: Integer);
function IntToBin(Value, Len: Integer): string;
function BinToInt(S: string; Index, Count: Integer): Int64;
function StrToHexText(const S: string): string;
procedure SafeSetChecked(CheckBox: TCheckBox; Value: Boolean);

implementation

procedure DrvCheck(Driver: IMifareDrv2; ResultCode: Integer);
begin
  if ResultCode <> 0 then
    RaiseError(ResultCode, Driver.ResultDescription);
end;

function ComparePorts(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := Integer(List.Objects[Index1]) - Integer(List.Objects[Index2]);
end;

procedure GetDevicePorts(Ports: TStringList);
var
  S: string;
  S1: string;
  i: Integer;
  Code: Integer;
  Reg: TRegistry;
  PortNumber: Integer;
  Strings: TStringList;
begin
  Ports.Clear;
  Reg := TRegistry.Create;
  Strings := TStringList.Create;
  try
    Reg.Access := KEY_READ;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\HARDWARE\DEVICEMAP\SERIALCOMM', False) then
    begin
      Reg.GetValueNames(Strings);
      for i := 0 to Strings.Count-1 do
      begin
        S := Reg.ReadString(Strings[i]);
        S1 := Copy(S, 4, Length(S));
        Val(S1, PortNumber, Code);
        if Code = 0 then
        begin
          if Ports.IndexOf(S) = -1 then
            Ports.AddObject(S, TObject(PortNumber));
        end;
      end;
      Ports.CustomSort(ComparePorts);
    end;
  finally
    Reg.Free;
    Strings.Free;
  end;
end;

function TestBit(Value, Bit: Integer): Boolean;
begin
  Result := (Value and (1 shl Bit)) <> 0;
end;

procedure SetBit(var Value: Integer; BitNumber: Integer);
begin
  Value := Value or (1 shl BitNumber);
end;

function BufToStr(Buf: array of Byte; Count: Byte): string;
begin
  Result := '';
  if Count > 0 then
  begin
    SetLength(Result, Count);
    Move(Buf, Result[1], Count);
  end;
end;

procedure SwapBuf(var Src, Dst: array of Byte; Count: Byte);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Dst[i] := Src[Count - 1 - i];
end;

function BufToHex(const Buf: array of Byte; Count: Byte): string;
var
  i: Integer;
begin
  Result := '';
  for i := Count - 1 downto 0 do
  begin
    Result := IntToHex(Buf[i], 2) + Result;
  end;
end;

function SwapDWORD(Value: DWORD): DWORD;
var
  B: array[0..3] of Byte;
begin
  Move(Value, B, 4);
  Result := (B[0] shl 24) + (B[1] shl 16) + (B[2] shl 8) + B[3];
end;

function Min(Value1, Value2: Integer): Integer;
begin
  if Value1 < Value2 then Result := Value1 else Result := Value2;
end;

function SwapStr(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    Result := S[i] + Result;
end;

function Add0(const S: string; Count: Integer): string;
begin
  Result := Copy(S, 1, Count);
  Result := Result + StringOfChar(#0, Count - Length(Result));
end;

function HexToBin(const S: string; Count: Integer): string;
begin
  Result := HexToStr(S);
  Result := Add0(Result, Count);
end;

function BinToHex(const S: string; Count: Integer): string;
begin
  Result := Add0(S, Count);
  Result := StrToHex(Result);
end;

procedure ODS(const Data: string);
begin
  OutputDebugString(PChar(Data));
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
  if Odd(Length(Data)) then Data := Data + '0';

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

function GetDeviceName(const DeviceName: string; DeviceNumber: Integer): string;
begin
  if DeviceNumber < 10 then
    Result := Format('№ %d %s', [DeviceNumber, DeviceName])
  else
    Result := Format('№%d %s', [DeviceNumber, DeviceName]);
end;

procedure EnableFormButtons(Parent: TWinControl; Value: Boolean; var Control: TWinControl);
var
  i: Integer;
  Button: TButton;
begin
  for i := 0 to Parent.ControlCount - 1 do
  begin
    if (Parent.Controls[i] is TButton) then
    begin
      Button := Parent.Controls[i] as TButton;
      if (not Value) and Button.Focused then
        Control := Button;
      Button.Enabled := Value;
    end;
  end;
  if Value and (Control <> nil) then Control.SetFocus;
end;

function GetLongFileName(const FileName: string): string;
var
  L: Integer;
  Handle: Integer;
  Buffer: array[0..MAX_PATH] of Char;
  GetLongPathName: function (ShortPathName: PChar; LongPathName: PChar;
    cchBuffer: Integer): Integer stdcall;
const
  kernel = 'kernel32.dll';
begin
  Result := FileName;
  Handle := GetModuleHandle(kernel);
  if Handle <> 0 then
  begin
    @GetLongPathName := GetProcAddress(Handle, 'GetLongPathNameA');
    if Assigned(GetLongPathName) then
    begin
      L := GetLongPathName(PChar(FileName), Buffer, SizeOf(Buffer));
      SetString(Result, Buffer, L);
    end;
  end;
end;

function GetModuleFileName: string;
var
  Buffer: array[0..261] of Char;
begin
  SetString(Result, Buffer, Windows.GetModuleFileName(HInstance,
    Buffer, SizeOf(Buffer)));
end;

procedure CheckMinLength(const Data: string; MinLength: Integer);
begin
  if Length(Data) < MinLength then
    RaiseError(E_ANSWER_LENGTH, S_ANSWER_LENGTH);
end;

function IntToBin(Value, Len: Integer): string;
begin
  SetLength(Result, Len);
  Move(Value, Result[1], Len);
end;

function BinToInt(S: string; Index, Count: Integer): Int64;
begin
  S := Copy(S, Index, Count);
  if Length(S) < Count then
    raise Exception.Create('Недостаточная длина данных');

  Result := 0;
  Move(S[1], Result, Count);
end;

function StrToHexText(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
  begin
    if i <> 1 then Result := Result + ' ';
    Result := Result + IntToHex(Ord(S[i]), 2);
  end;
end;

procedure SafeSetChecked(CheckBox: TCheckBox; Value: Boolean);
var
  SaveOnClick: TNotifyEvent;
begin
  SaveOnClick := CheckBox.OnClick;
  CheckBox.OnClick := nil;
  try
    CheckBox.Checked := Value;
  finally
    CheckBox.OnClick := SaveOnClick;
  end;
end;

end.
