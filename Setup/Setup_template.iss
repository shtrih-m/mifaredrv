[Setup]
OutputDir="."
OutputBaseFilename=setup
AppName="Драйвер считывателей Mifare"
AppVerName="Драйвер считывателей Mifare ${version2}"

AppVersion= ${version2}
AppPublisher=ШТРИХ-М
AppPublisherURL=http://www.shtrih-m.ru
AppSupportURL=http://www.shtrih-m.ru
AppUpdatesURL=http://www.shtrih-m.ru
AppComments=Торговое оборудование от производителя, автоматизация торговли
AppContact=т. (095) 797-60-90
AppReadmeFile=History.txt
AppCopyright="Copyright 2010, ШТРИХ-М"
;Версия
VersionInfoCompany="ШТРИХ-М"
VersionInfoDescription="Драйвер считывателей Mifare"
VersionInfoTextVersion="${version}"
VersionInfoVersion=${version}

DefaultDirName= {pf}\Штрих-М\Драйверы\Драйвер Mifare
DefaultGroupName=Штрих-М\Драйвер считывателей Mifare
UninstallDisplayIcon= {app}\Uninstall.exe
WizardImageFile=WizardImageFile.bmp
AllowNoIcons=Yes
[Components]
Name: "main"; Description: "Драйвер и тесты"; Types: full compact custom
Name: "doc"; Description: "Документация"; Types: full
Name: "samples"; Description: "Примеры"; Types: full
[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"
[Files]
; История версий
Source: "History.txt"; DestDir: "{app}\Doc"; Components: main
; SCARD driver
Source: "scardsyn.dll"; DestDir: "{sys}"; Flags: onlyifdoesntexist sharedfile;
; Драйвер и тесты
Source: "Bin\MifareTst.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: main
Source: "Bin\MifareDrv.dll"; DestDir: "{app}"; Flags: ignoreversion regserver; Components: main
; Пример для 1С версии 7.7
Source: "..\Samples\1Cv77\1Cv7.DD"; DestDir: "{app}\Samples\1Cv77"; Components: Samples
Source: "..\Samples\1Cv77\1Cv7.MD"; DestDir: "{app}\Samples\1Cv77"; Components: Samples
; Пример для 1С версии 8.0
Source: "Bin\CfgMgr1C.exe"; DestDir: "{app}"; Flags: deleteafterinstall; Components: Samples
Source: "..\Samples\1Cv80\1Cv8.1CD"; DestDir: "{app}\Samples\1Cv80"; Components: Samples
Source: "..\Samples\1Cv81\1Cv8.1CD"; DestDir: "{app}\Samples\1Cv81"; Components: Samples
; Библиотека для примеров
Source: "Bin\MifareDrv.dll"; DestDir: "{app}\Samples\1Cv77"; Components: Samples; Flags: ignoreversion;
Source: "Bin\MifareDrv.dll"; DestDir: "{code:Get1c80Path}"; Components: Samples; Flags: ignoreversion;
Source: "Bin\MifareDrv.dll"; DestDir: "{code:Get1c81Path}"; Components: Samples; Flags: ignoreversion;
; Примеры - Delphi 7.0
Source: "..\Source\MifareTst\*"; Flags: createallsubdirs recursesubdirs; Excludes: "*.svn,*.rsm,*.dcu,*.exe,*.dll,*.rt,*.rc,*.ico";	DestDir: "{app}\Samples\Delphi 7\MifareTst\"; Components: Samples
Source: "..\Source\MifareDrv\*"; Flags: createallsubdirs recursesubdirs; Excludes: "*.svn,*.rsm,*.dcu,*.exe,*.dll,*.rt,*.rc,*.ico";	DestDir: "{app}\Samples\Delphi 7\MifareDrv\"; Components: Samples
; Документация
Source: "..\Doc\ДрайверMifare.pdf"; DestDir: "{app}\Doc"; Components: doc
Source: "..\Doc\ПротоколСчитывателяMifare.pdf"; DestDir: "{app}\Doc"; Components: doc

[Icons]
; История версий
Name: "{group}\История версий"; Filename: "{app}\Doc\History.txt"; WorkingDir: "{app}"; Components: main
; Документация
Name: "{group}\Описание драйвера"; Filename: "{app}\Doc\ДрайверMifare.pdf"; WorkingDir: "{app}"; Components: doc
;Основные
Name: "{group}\Тест драйвера MiReader ${version2}"; Filename: "{app}\MifareTst.exe"; WorkingDir: "{app}"; Components: main
;Примеры
Name: "{group}\Примеры\Delphi 7.0"; Filename: "{app}\Samples\Delphi 7"; WorkingDir: "{app}"; Components: Samples
Name: "{group}\Примеры\1С версия 7.7"; Filename: "{app}\Samples\1Cv77"; WorkingDir: "{app}"; Components: Samples
Name: "{group}\Примеры\1С версия 8.0"; Filename: "{app}\Samples\1Cv80"; WorkingDir: "{app}"; Components: Samples
Name: "{group}\Примеры\1С версия 8.1"; Filename: "{app}\Samples\1Cv81"; WorkingDir: "{app}"; Components: Samples
; Удаление
Name: "{group}\Удалить"; Filename: "{uninstallexe}"
[Run]
Filename: "{app}\CfgMgr1C.exe"; Parameters: """addcfg"" ""77"" ""{app}\Samples\1Cv77"" ""77469E18-F2BE-424D-B440-8FE56122C3DE"" ""Штрих-М: Драйвер считывателей Mifare ${version2}"""; Components: samples
Filename: "{app}\CfgMgr1C.exe"; Parameters: """addcfg"" ""80"" ""{app}\Samples\1Cv80"" ""77469E18-F2BE-424D-B440-8FE56122C3DE"" ""Штрих-М: Драйвер считывателей Mifare ${version2}"""; Components: samples
Filename: "{app}\CfgMgr1C.exe"; Parameters: """addcfg"" ""81"" ""{app}\Samples\1Cv81"" ""77469E18-F2BE-424D-B440-8FE56122C3DE"" ""Штрих-М: Драйвер считывателей Mifare ${version2}"""; Components: samples
Filename: "{app}\MifareTst.exe"; Description: "Запустить тест драйвера"; Flags: postinstall nowait skipifsilent skipifdoesntexist; Components: main
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