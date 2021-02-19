program MifareTstTest;

uses
  FastMM4,
  TestFramework,
  GUITestRunner,
  duDfmFile in 'Units\duDfmFile.pas',
  DebugUtils in '..\..\Source\MifareDrv\Units\DebugUtils.pas';

{$R *.RES}

begin
  TGUITestRunner.RunTest(RegisteredTests);
end.
