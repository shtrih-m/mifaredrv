unit duDfmFile;

interface

uses
  // VCL
  Windows, Classes, SysUtils,
  // This
  TestFramework, DebugUtils;

type
  { TDfmFileTest }

  TDfmFileTest = class(TTestCase)
  private
    procedure CheckDfmFilePath(const Dir: string);
    function IsDFMText(const FileName: string): Boolean;
    procedure GetDFMFileNames(const Path: string; FileNames: TStrings);
  published
    procedure CheckDfmFiles;
  end;

implementation

function IsDirectory(const F: TSearchRec): Boolean;
begin
  Result := (F.FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0;
end;

{ TDfmFileTest }

procedure TDfmFileTest.GetDFMFileNames(const Path: string;
  FileNames: TStrings);
var
  Dir: string;
  SubDir: string;
  F: TSearchRec;
  Result: Integer;
begin
  Dir := IncludeTrailingBackslash(Path);
  // Поиск файлов
  Result := FindFirst(Dir + '*.dfm', faAnyFile, F);
  while Result = 0 do
  begin
    ODS(Dir + F.FindData.cFileName);
    FileNames.Add(Dir + F.FindData.cFileName);
    Result := FindNext(F);
  end;
  FindClose(F);
  // Поиск директорий
  Result := FindFirst(Dir + '*.*', faDirectory, F);
  while Result = 0 do
  begin
    if IsDirectory(F) then
    begin
      SubDir := F.FindData.cFileName;
      if (SubDir <> '.')and(SubDir <> '..') then
      begin
        SubDir := IncludeTrailingBackslash(Dir + SubDir);
        ODS(SubDir);
        GetDFMFileNames(SubDir, FileNames);
      end;
    end;
    Result := FindNext(F);
  end;
  FindClose(F);
end;

function TDfmFileTest.IsDFMText(const FileName: string): Boolean;
var
  S: string;
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    SetLength(S, 3);
    Stream.ReadBuffer(S[1], 3);
    Result := S <> #$FF#$0A#$00;
  finally
    Stream.Free;
  end;
end;

procedure TDfmFileTest.CheckDfmFilePath(const Dir: string);
var
  i: Integer;
  FileName: string;
  FileNames: TStrings;
begin
  FileNames := TStringList.Create;
  try
    GetDFMFileNames(Dir, FileNames);
    Check(FileNames.Count > 0);
    for i := 0 to FileNames.Count-1 do
    begin
      FileName := FileNames[i];
      Check(IsDfmText(FileName), FileName);
    end;
  finally
    FileNames.Free;
  end;
end;

procedure TDfmFileTest.CheckDfmFiles;
var
  FilePath: string;
  L: Integer;
begin
  SetLength(FilePath, 512);
  L := GetModuleFileName(hInstance, @FilePath[1], 512);
  SetLength(FilePath, L);
  FilePath := ExtractFilePath(FilePath) + '..\..\..\Source\MifareTst\Fmu\';
  CheckDfmFilePath(FilePath);
end;

initialization
  RegisterTest('', TDfmFileTest.Suite);

end.
