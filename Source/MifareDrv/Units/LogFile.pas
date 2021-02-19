unit LogFile;

interface

uses
  // VCL
  Windows, Classes, SysUtils, SyncObjs, SysConst, Variants,
  // This
  DebugUtils;

type
  { TLogFile }

  TLogFile = class
  private
    FHandle: THandle;
    FFilePath: string;
    FFileName: string;
    FEnabled: Boolean;
    FLock: TCriticalSection;

    procedure Lock;
    procedure Unlock;
    procedure OpenFile;
    procedure CloseFile;
    procedure SetDefaults;
    function GetOpened: Boolean;
    function GetFileName: string;
    procedure SetEnabled(Value: Boolean);
    procedure Write(const Data: string);
    procedure AddLine(const Data: string);
    class function ParamsToStr(const Params: array of const): string;

    property Opened: Boolean read GetOpened;
  public
    constructor Create;
    destructor Destroy; override;

    class function GetDefaultPath: string;
    procedure Info(const Data: string); overload;
    procedure Debug(const Data: string); overload;
    procedure Trace(const Data: string); overload;
    procedure Error(const Data: string); overload;
    procedure Error(const Data: string; E: Exception); overload;
    procedure Info(const Data: string; Params: array of const); overload;
    procedure Debug(const Data: string; Params: array of const); overload;
    procedure Trace(const Data: string; Params: array of const); overload;
    procedure Error(const Data: string; Params: array of const); overload;
    procedure Debug(const Data: string; Params: array of const; Result: Variant); overload;

    property FilePath: string read FFilePath write FFilePath;
    property Enabled: Boolean read FEnabled write SetEnabled;
  end;

function Logger: TLogFile;

procedure LogDebugData(const Prefix, Data: string);

implementation

type
  TVariantArray = array of Variant;

type
  TFNGetLongPathName = function(lpszShortName: LPCTSTR; lpszLongName: LPTSTR;
    cchBuffer: DWORD): DWORD; stdcall;
var
  GetLongPathName: TFNGetLongPathName = nil;

function ShortToLongFileName(FileName: string): string;
var
  FindData: TWin32FindData;
  Search: THandle;
  KernelHandle: THandle;
begin
  KernelHandle := GetModuleHandle('KERNEL32');
  if KernelHandle <> 0 then
    @GetLongPathName := GetProcAddress(KernelHandle, 'GetLongPathNameA');

  // Use GetLongPathName where available (Win98 and later) to avoid
  // Win98 SE problems accessing UNC paths on NT/2K/XP based systems
  if Assigned(GetLongPathName) then
  begin
    SetLength(Result, MAX_PATH + 1);
    SetLength(Result, GetLongPathName(PChar(FileName), @Result[1], MAX_PATH));
  end
  else
  begin
    Result := '';

    // Strip off one directory level at a time starting with the file name
    // and store it into the result. FindFirstFile will return the long file
    // name from the short file name.
    while (True) do
    begin
      Search := Windows.FindFirstFile(PChar(FileName), FindData);

      if Search = INVALID_HANDLE_VALUE then
        Break;

      Result := string('\') + FindData.cFileName + Result;
      FileName := ExtractFileDir(FileName);
      Windows.FindClose(Search);

      // Found the drive letter followed by the colon.
      if Length(FileName) <= 2 then
        Break;
    end;

    Result := ExtractFileDrive(FileName) + Result;
  end;
end;

function ConstArrayToVarArray(const AValues : array of const): TVariantArray;
var
  i : Integer;
begin
  SetLength(Result, Length(AValues));
  for i := Low(AValues) to High(AValues) do
  begin
    with AValues[i] do
    begin
      case VType of
        vtInteger: Result[i] := VInteger;
        vtInt64: Result[i] := VInt64^;
        vtBoolean: Result[i] := VBoolean;
        vtChar: Result[i] := VChar;
        vtExtended: Result[i] := VExtended^;
        vtString: Result[i] := VString^;
        vtPointer: Result[i] := Integer(VPointer);
        vtPChar: Result[i] := StrPas(VPChar);
        vtObject: Result[i]:= Integer(VObject);
        vtAnsiString: Result[i] := String(VAnsiString);
        vtCurrency: Result[i] := VCurrency^;
        vtVariant: Result[i] := VVariant^;
        vtInterface: Result[i]:= Integer(VPointer);
        vtWideString: Result[i]:= WideString(VWideString);
      else
        Result[i] := NULL;
      end;
    end;
  end;
end;

function VarArrayToStr(const AVarArray: TVariantArray): string;
var
  I: Integer;
begin
  Result := '';
  for i := Low(AVarArray) to High(AVarArray) do
  begin
    if Length(Result) > 0 then
      Result := Result + ', ';
    if VarIsNull(AVarArray[I]) then
      Result := Result + 'NULL'
    else
      Result := Result + VarToStr(AVarArray[I]);
  end;
  Result := '('+Result+')';
end;

function StrToHex(const S: string): string;
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

const
  S_SEPARATOR   = '------------------------------------------------------------';

  TagInfo         = '[ INFO] ';
  TagTrace        = '[TRACE] ';
  TagDebug        = '[DEBUG] ';
  TagError        = '[ERROR] ';

var
  FLogger: TLogFile;

function Logger: TLogFile;
begin
  if FLogger = nil then
    FLogger := TLogFile.Create;
  Result := FLogger;
end;

function GetTimeStamp: string;
var
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(Date, Year, Month, Day);
  DecodeTime(Time, Hour, Min, Sec, MSec);
  Result := Format('%.2d.%.2d.%.4d %.2d:%.2d:%.2d.%.3d ',[
    Day, Month, Year, Hour, Min, Sec, MSec]);
end;

function GetModuleFileName: string;
var
  Buffer: array[0..261] of Char;
begin
  SetString(Result, Buffer, Windows.GetModuleFileName(HInstance,
    Buffer, SizeOf(Buffer)));
  Result := ShortToLongFileName(Result);
end;

function GetLastErrorText: string;
begin
  Result := Format(SOSError, [GetLastError,  SysErrorMessage(GetLastError)]);
end;

procedure LogDebugData(const Prefix, Data: string);
var
  Line: string;
const
  DataLen = 20; // Max data string length
begin
  Line := Data;
  repeat
    Logger.Debug(Prefix + StrToHex(Copy(Line, 1, DataLen)));
    Line := Copy(Line, DataLen + 1, Length(Line));
  until Line = '';
end;

procedure ODS(const S: string);
begin
{$IFDEF DEBUG}
  OutputDebugString(PChar(S));
{$ENDIF}
end;

{ TLogFile }

constructor TLogFile.Create;
begin
  inherited Create;
  FLock := TCriticalSection.Create;
  FHandle := INVALID_HANDLE_VALUE;
  SetDefaults;
end;

destructor TLogFile.Destroy;
begin
  CloseFile;
  FLock.Free;
  inherited Destroy;
end;

procedure TLogFile.Lock;
begin
  FLock.Enter;
end;

procedure TLogFile.Unlock;
begin
  FLock.Leave;
end;

function TLogFile.GetFileName: string;
begin
  Result := IncludeTrailingPathDelimiter(FilePath) +
    ChangeFileExt(ExtractFileName(GetModuleFileName), '') + '_' +
    FormatDateTime('dd.mm.yyyy', Date) + '.log';
end;

procedure TLogFile.SetDefaults;
begin
  Enabled := False;
  FFilePath := GetDefaultPath;
end;

class function TLogFile.GetDefaultPath: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(GetModuleFileName)) + 'Logs';
end;

procedure TLogFile.OpenFile;
var
  FileName: string;
begin
  Lock;
  try
    if not Opened then
    begin
      if not DirectoryExists(FilePath) then
      begin
        ODS(Format('Log directory is not exists, "%s"', [FilePath]));
        if not CreateDir(FilePath) then
        begin
          ODS('Failed to create log directory');
          ODS(GetLastErrorText);
        end;
      end;

      FileName := GetFileName;
      FHandle := CreateFile(PChar(GetFileName), GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);

      if Opened then
      begin
        FileSeek(FHandle, 0, 2); // 0 from end
        FFileName := FileName;
      end else
      begin
        ODS(Format('Failed to create log file "%s"', [FileName]));
        ODS(GetLastErrorText);
      end;
    end;
  finally
    Unlock;
  end;
end;

procedure TLogFile.CloseFile;
begin
  Lock;
  try
    if Opened then
      CloseHandle(FHandle);
    FHandle := INVALID_HANDLE_VALUE;
  finally
    Unlock;
  end;
end;

function TLogFile.GetOpened: Boolean;
begin
  Result := FHandle <> INVALID_HANDLE_VALUE;
end;

procedure TLogFile.SetEnabled(Value: Boolean);
begin
  if Value <> Enabled then
  begin
    FEnabled := Value;
    CloseFile;
  end;
end;

procedure TLogFile.Write(const Data: string);
var
  S: string;
  Count: DWORD;
begin
  Lock;
  try
    ODS(Data);
    if not Enabled then Exit;
    S := Data;

    if GetFileName <> FFileName then
    begin
      CloseFile;
    end;
    OpenFile;
    if Opened then
    begin
      WriteFile(FHandle, S[1], Length(S), Count, nil);
    end;
  finally
    Unlock;
  end;
end;

procedure TLogFile.AddLine(const Data: string);
var
  S: string;
begin
  S := Data;
  S := Format('[%s] [%.8d] %s', [GetTimeStamp, GetCurrentThreadID, S + #13#10]);
  Write(S);
  ODS(S);
end;

procedure TLogFile.Trace(const Data: string);
begin
  AddLine(TagTrace + Data);
end;

procedure TLogFile.Info(const Data: string);
begin
  AddLine(TagInfo + Data);
end;

procedure TLogFile.Error(const Data: string);
begin
  AddLine(TagError + Data);
end;

procedure TLogFile.Error(const Data: string; E: Exception);
begin
  AddLine(TagError + Data + ' ' + E.Message);
end;

procedure TLogFile.Debug(const Data: string);
begin
  AddLine(TagDebug + Data);
end;

class function TLogFile.ParamsToStr(const Params: array of const): string;
begin
  Result := VarArrayToStr(ConstArrayToVarArray(Params));
end;

procedure TLogFile.Debug(const Data: string; Params: array of const);
begin
  Debug(Data + ParamsToStr(Params));
end;

procedure TLogFile.Debug(const Data: string; Params: array of const;
  Result: Variant);
begin
  Debug(Data + ParamsToStr(Params) + '=' + VarToStr(Result));
end;

procedure TLogFile.Error(const Data: string; Params: array of const);
begin
  Error(Data + ParamsToStr(Params));
end;

procedure TLogFile.Info(const Data: string; Params: array of const);
begin
  Info(Data + ParamsToStr(Params));
end;

procedure TLogFile.Trace(const Data: string; Params: array of const);
begin
  Trace(Data + ParamsToStr(Params));
end;

initialization

finalization
  ODS('LogFile.finalization.0');
  FLogger.Free;
  FLogger := nil;
  ODS('LogFile.finalization.1');

end.
