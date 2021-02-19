program AcceptTest;

{%ToDo 'AcceptTest.todo'}

uses
  TestFramework,
  GUITestRunner,
  MifareLib_TLB in '..\..\Source\MifareDrv\MifareLib_TLB.pas',
  utSmartCardReader in 'Units\utSmartCardReader.pas',
  EventItem in 'Units\EventItem.pas',
  DriverEvent in '..\..\Source\MifareDrv\Units\DriverEvent.pas',
  SCardSyn in '..\..\Source\MifareDrv\Units\SCardSyn.pas',
  WinSCard in '..\..\Source\MifareDrv\Units\WinSCard.pas',
  WinSmCrd in '..\..\Source\MifareDrv\Units\WinSmCrd.pas',
  SCardErr in '..\..\Source\MifareDrv\Units\SCardErr.pas',
  NotifyThread in '..\..\Source\MifareDrv\Units\NotifyThread.pas',
  untError in '..\..\Source\MifareDrv\Units\untError.pas',
  untConst in '..\..\Source\MifareDrv\Units\untConst.pas',
  untUtil in '..\..\Source\MifareDrv\Units\untUtil.pas',
  OmnikeyReader5422 in '..\..\Source\MifareDrv\Units\OmnikeyReader5422.pas',
  OmnikeyCardReader in '..\..\Source\MifareDrv\Units\OmnikeyCardReader.pas',
  CardReaderInterface in '..\..\Source\MifareDrv\Units\CardReaderInterface.pas',
  SerialParams in '..\..\Source\MifareDrv\Units\SerialParams.pas',
  ValueBlock in '..\..\Source\MifareDrv\Units\ValueBlock.pas',
  utOmnikeyReader in 'Units\utOmnikeyReader.pas',
  SCardUtil in '..\..\Source\MifareDrv\Units\SCardUtil.pas',
  LogFile in '..\..\Source\MifareDrv\Units\LogFile.pas',
  DebugUtils in '..\..\Source\MifareDrv\Units\DebugUtils.pas',
  OmnikeyReader in '..\..\Source\MifareDrv\Units\OmnikeyReader.pas';

{$R *.RES}

begin
  TGUITestRunner.RunTest(RegisteredTests);
end.
