program AddCfg80;

uses
  ShlObj,
  Windows,
  Classes,
  SysUtils,
  ActiveX,
  TntSystem in 'Tnt\TntSystem.pas',
  TntClasses in 'Tnt\TntClasses.pas',
  TntSysUtils in 'Tnt\TntSysUtils.pas',
  TntWindows in 'Tnt\TntWindows.pas',
  TntFormatStrUtils in 'Tnt\TntFormatStrUtils.pas',
  TntTypInfo in 'Tnt\TntTypInfo.pas';

{$R *.RES}

function PidlFree(var IdList: PItemIdList): Boolean;
var
  Malloc: IMalloc;
begin
  Result := False;
  if IdList = nil then
    Result := True
  else
  begin
    if Succeeded(SHGetMalloc(Malloc)) and (Malloc.DidAlloc(IdList) > 0) then
    begin
      Malloc.Free(IdList);
      IdList := nil;
      Result := True;
    end;
  end;
end;

procedure StrResetLength(var S: AnsiString);
begin
  SetLength(S, StrLen(PChar(S)));
end;

function PidlToPath(IdList: PItemIdList): string;
begin
  SetLength(Result, MAX_PATH);
  if SHGetPathFromIdList(IdList, PChar(Result)) then
    StrResetLength(Result)
  else
    Result := '';
end;

function GetSpecialFolderLocation(const Folder: Integer): string;
var
  FolderPidl: PItemIdList;
begin
  if Succeeded(SHGetSpecialFolderLocation(0, Folder, FolderPidl)) then
  begin
    Result := PidlToPath(FolderPidl);
    PidlFree(FolderPidl);
  end
  else
    Result := '';
end;

var
  S: String;
  AppID: string;
  AppPath: string;
  AppSection: string;
  CfgFileName: string;
  Stream: TFileStream;
  Strings: TTntStrings;
begin
  try
    AppPath := ParamStr(1);
    AppID := ParamStr(2);
    AppSection := Format('[%s]', [ParamStr(3)]);
    CfgFileName := GetSpecialFolderLocation(CSIDL_APPDATA) + '\1C\1Cv8\v8ib.lst';
    Strings := TTntStringList.Create;
    try
      if FileExists(CfgFileName) then
        Strings.LoadFromFile(CfgFileName);

      if Strings.IndexOf(AppSection) = -1 then
      begin
        Strings.Add(AppSection);
        Strings.Add(Format('Connect=File="%s";', [AppPath]));
        Strings.Add(Format('ID=%s', [AppID]));
        Strings.Add('OrderInList=-1');
        Strings.Add('Folder=/');
        Strings.Add('OrderInTree=-1');

        Stream := TFileStream.Create(CfgFileName, fmCreate);
        try
          S := WideStringToUTF8(Strings.Text);
          Stream.WriteBuffer(PAnsiChar(UTF8_BOM)^, Length(UTF8_BOM));
          Stream.WriteBuffer(PAnsiChar(S)^, Length(S));
        finally
          Stream.Free;
        end;
      end;
    finally
      Strings.Free;
    end;
  except
    on E: Exception do
      OutputDebugString(PChar(E.Message));
  end;
end.
