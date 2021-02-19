unit CfgManager;

interface

uses
  // VCL
  Windows, Classes, SysUtils, ActiveX, ShlObj, Registry,
  // Tnt
  TntSystem, TntClasses, TntSysUtils, TntWindows, TntFormatStrUtils;

type
  { TCfgParamsRec }

  TCfgParamsRec = record
    Version1C: string;
    AppPath: string;
    AppGUID: string;
    AppName: string;
  end;

  { TCfgManager }

  TCfgManager = class
  public
    class procedure AddCfg(const CfgParams: TCfgParamsRec);
    class procedure AddCfg77(const CfgParams: TCfgParamsRec);
    class procedure AddCfg80(const CfgParams: TCfgParamsRec);
    class procedure AddCfg81(const CfgParams: TCfgParamsRec);
    class procedure AddCfgVersion8(const CfgParams: TCfgParamsRec;
      const CfgFileName: string);
  end;

implementation

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

{ TCfgManager }

class procedure TCfgManager.AddCfg(const CfgParams: TCfgParamsRec);
var
  Code: Integer;
  Version1C: Integer;
begin
  Val(CfgParams.Version1C, Version1C, Code);
  if Code <> 0 then Version1C := 80;

  case Version1C of
    77: AddCfg77(CfgParams);
    80: AddCfg80(CfgParams);
    81: AddCfg81(CfgParams);
  else
    AddCfg80(CfgParams);
  end;
end;

class procedure TCfgManager.AddCfg77(const CfgParams: TCfgParamsRec);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    if Reg.OpenKey('Software\1C\1Cv7\7.7\Defaults', False) then
    begin
      Reg.WriteString('LastTitle', CfgParams.AppName);
      Reg.CloseKey;
    end;

    if Reg.OpenKey('Software\1C\1Cv7\7.7\Titles', False) then
    begin
      Reg.WriteString(CfgParams.AppPath, CfgParams.AppName);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

class procedure TCfgManager.AddCfg80(const CfgParams: TCfgParamsRec);
var
  CfgFileName: string;
begin
  CfgFileName := GetSpecialFolderLocation(CSIDL_APPDATA) + '\1C\1Cv8\v8ib.lst';
  AddCfgVersion8(CfgParams, CfgFileName);
end;

class procedure TCfgManager.AddCfg81(const CfgParams: TCfgParamsRec);
var
  CfgFileName: string;
begin
  CfgFileName := GetSpecialFolderLocation(CSIDL_APPDATA) + '\1C\1Cv81\ibases.v8i';
  AddCfgVersion8(CfgParams, CfgFileName);
end;

class procedure TCfgManager.AddCfgVersion8(const CfgParams: TCfgParamsRec;
  const CfgFileName: string);
var
  S: String;
  AppName: string;
  Stream: TFileStream;
  Strings: TTntStrings;
begin
  AppName := Format('[%s]', [CfgParams.AppName]);
  Strings := TTntStringList.Create;
  try
    if FileExists(CfgFileName) then
      Strings.LoadFromFile(CfgFileName);

    if Strings.IndexOf(AppName) = -1 then
    begin
      Strings.Add(AppName);
      Strings.Add(Format('Connect=File="%s";', [CfgParams.AppPath]));
      Strings.Add(Format('ID=%s', [CfgParams.AppGUID]));
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
end;

end.
