[Setup]
OutputDir="."
OutputBaseFilename=setup
AppName="������� ������������ Mifare"
AppVerName="������� ������������ Mifare ${version2}"

AppVersion= ${version2}
AppPublisher=�����-�
AppPublisherURL=http://www.shtrih-m.ru
AppSupportURL=http://www.shtrih-m.ru
AppUpdatesURL=http://www.shtrih-m.ru
AppComments=�������� ������������ �� �������������, ������������� ��������
AppContact=�. (095) 797-60-90
AppReadmeFile=History.txt
AppCopyright="Copyright 2010, �����-�"
;������
VersionInfoCompany="�����-�"
VersionInfoDescription="������� ������������ Mifare"
VersionInfoTextVersion="${version}"
VersionInfoVersion=${version}

DefaultDirName= {pf}\�����-�\��������\������� Mifare
DefaultGroupName=�����-�\������� ������������ Mifare
UninstallDisplayIcon= {app}\Uninstall.exe
WizardImageFile=WizardImageFile.bmp
AllowNoIcons=Yes
[Components]
Name: "main"; Description: "������� � �����"; Types: full compact custom
Name: "doc"; Description: "������������"; Types: full
Name: "samples"; Description: "�������"; Types: full
[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"
[Files]
; ������� ������
Source: "History.txt"; DestDir: "{app}\Doc"; Components: main
; SCARD driver
Source: "scardsyn.dll"; DestDir: "{sys}"; Flags: onlyifdoesntexist sharedfile;
; ������� � �����
Source: "Bin\MifareTst.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: main
Source: "Bin\MifareDrv.dll"; DestDir: "{app}"; Flags: ignoreversion regserver; Components: main
; ������ ��� 1� ������ 7.7
Source: "..\Samples\1Cv77\1Cv7.DD"; DestDir: "{app}\Samples\1Cv77"; Components: Samples
Source: "..\Samples\1Cv77\1Cv7.MD"; DestDir: "{app}\Samples\1Cv77"; Components: Samples
; ������ ��� 1� ������ 8.0
Source: "Bin\CfgMgr1C.exe"; DestDir: "{app}"; Flags: deleteafterinstall; Components: Samples
Source: "..\Samples\1Cv80\1Cv8.1CD"; DestDir: "{app}\Samples\1Cv80"; Components: Samples
Source: "..\Samples\1Cv81\1Cv8.1CD"; DestDir: "{app}\Samples\1Cv81"; Components: Samples
; ���������� ��� ��������
Source: "Bin\MifareDrv.dll"; DestDir: "{app}\Samples\1Cv77"; Components: Samples; Flags: ignoreversion;
Source: "Bin\MifareDrv.dll"; DestDir: "{code:Get1c80Path}"; Components: Samples; Flags: ignoreversion;
Source: "Bin\MifareDrv.dll"; DestDir: "{code:Get1c81Path}"; Components: Samples; Flags: ignoreversion;
; ������� - Delphi 7.0
Source: "..\Source\MifareTst\*"; Flags: createallsubdirs recursesubdirs; Excludes: "*.svn,*.rsm,*.dcu,*.exe,*.dll,*.rt,*.rc,*.ico";	DestDir: "{app}\Samples\Delphi 7\MifareTst\"; Components: Samples
Source: "..\Source\MifareDrv\*"; Flags: createallsubdirs recursesubdirs; Excludes: "*.svn,*.rsm,*.dcu,*.exe,*.dll,*.rt,*.rc,*.ico";	DestDir: "{app}\Samples\Delphi 7\MifareDrv\"; Components: Samples
; ������������
Source: "..\Doc\�������Mifare.pdf"; DestDir: "{app}\Doc"; Components: doc
Source: "..\Doc\�������������������Mifare.pdf"; DestDir: "{app}\Doc"; Components: doc

[Icons]
; ������� ������
Name: "{group}\������� ������"; Filename: "{app}\Doc\History.txt"; WorkingDir: "{app}"; Components: main
; ������������
Name: "{group}\�������� ��������"; Filename: "{app}\Doc\�������Mifare.pdf"; WorkingDir: "{app}"; Components: doc
;��������
Name: "{group}\���� �������� MiReader ${version2}"; Filename: "{app}\MifareTst.exe"; WorkingDir: "{app}"; Components: main
;�������
Name: "{group}\�������\Delphi 7.0"; Filename: "{app}\Samples\Delphi 7"; WorkingDir: "{app}"; Components: Samples
Name: "{group}\�������\1� ������ 7.7"; Filename: "{app}\Samples\1Cv77"; WorkingDir: "{app}"; Components: Samples
Name: "{group}\�������\1� ������ 8.0"; Filename: "{app}\Samples\1Cv80"; WorkingDir: "{app}"; Components: Samples
Name: "{group}\�������\1� ������ 8.1"; Filename: "{app}\Samples\1Cv81"; WorkingDir: "{app}"; Components: Samples
; ��������
Name: "{group}\�������"; Filename: "{uninstallexe}"
[Run]
Filename: "{app}\CfgMgr1C.exe"; Parameters: """addcfg"" ""77"" ""{app}\Samples\1Cv77"" ""77469E18-F2BE-424D-B440-8FE56122C3DE"" ""�����-�: ������� ������������ Mifare ${version2}"""; Components: samples
Filename: "{app}\CfgMgr1C.exe"; Parameters: """addcfg"" ""80"" ""{app}\Samples\1Cv80"" ""77469E18-F2BE-424D-B440-8FE56122C3DE"" ""�����-�: ������� ������������ Mifare ${version2}"""; Components: samples
Filename: "{app}\CfgMgr1C.exe"; Parameters: """addcfg"" ""81"" ""{app}\Samples\1Cv81"" ""77469E18-F2BE-424D-B440-8FE56122C3DE"" ""�����-�: ������� ������������ Mifare ${version2}"""; Components: samples
Filename: "{app}\MifareTst.exe"; Description: "��������� ���� ��������"; Flags: postinstall nowait skipifsilent skipifdoesntexist; Components: main
[Code]
function Get1c80Path(Default: string): string;
var
  KeyName: string;
begin
  Result := 'C:\Program Files\1cv8\bin';
  KeyName := 'SOFTWARE\Classes\CLSID\{FB17AD3E-5F20-453A-AE83-2711006155CF}\LocalServer32';
  if RegQueryStringValue(HKLM, KeyName, '', Result) then
    Result := ExtractFilePath(Result);
end;

function Get1c81Path(Default: string): string;
var
  KeyName: string;
begin
  Result := 'C:\Program Files\1cv81\bin';
  KeyName := 'CLSID\{71CF7C7C-964B-49F1-A507-F1618AF0A7ED}\InprocServer32';
  if RegQueryStringValue(HKEY_CLASSES_ROOT, KeyName, '', Result) then
    Result := ExtractFilePath(Result);
end;