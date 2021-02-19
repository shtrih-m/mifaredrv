unit VersionInfo;

interface

uses
  // VCL
  Windows, SysUtils;

type
  { TVersionInfo }

  TVersionInfo = record
    MajorVersion: WORD;
    MinorVersion: WORD;
    ProductRelease: WORD;
    ProductBuild: WORD;
  end;

function GetModuleVersion: string;
function GetFileVersionInfoStr: string;
function GetFileVersionInfo: TVersionInfo;

implementation

function GetFileVersionInfo: TVersionInfo;
var
  hVerInfo: THandle;
  hGlobal: THandle;
  AddrRes: pointer;
  Buf: array[0..7] of byte;
begin
  Result.MajorVersion := 0;
  Result.MinorVersion := 0;
  Result.ProductRelease := 0;
  Result.ProductBuild := 0;

  hVerInfo := FindResource(hInstance, '#1', RT_VERSION);
  if hVerInfo <> 0 then
  begin
    hGlobal := LoadResource(hInstance, hVerInfo);
    if hGlobal <> 0 then
    begin
      AddrRes := LockResource(hGlobal);
      try
        CopyMemory(@Buf, Pointer(Integer(AddrRes) + 48), 8);
        Result.MinorVersion := Buf[0] + Buf[1] * $100;
        Result.MajorVersion := Buf[2] + Buf[3] * $100;
        Result.ProductBuild := Buf[4] + Buf[5] * $100;
        Result.ProductRelease := Buf[6] + Buf[7] * $100;
      finally
        FreeResource(hGlobal);
      end;
    end;
  end;
end;

function GetFileVersionInfoStr: string;
var
  vi: TVersionInfo;
begin
  vi := GetFileVersionInfo;
  Result := Format('%d.%d.%d.%d', [vi.MajorVersion, vi.MinorVersion,
    vi.ProductRelease, vi.ProductBuild]);
end;

function GetModuleFileName: string;
var
  Buffer: array[0..261] of Char;
begin
  SetString(Result, Buffer, Windows.GetModuleFileName(HInstance,
    Buffer, SizeOf(Buffer)));
end;

function GetModuleVersion: string;
begin
  Result := GetFileVersionInfoStr;
end;

end.
