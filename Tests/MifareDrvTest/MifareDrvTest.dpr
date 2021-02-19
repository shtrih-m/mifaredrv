program MifareDrvTest;

{%ToDo 'MifareDrvTest.todo'}

uses
  FastMM4,
  TestFramework,
  GUITestRunner,
  VersionInfo in '..\..\Source\MifareDrv\Units\VersionInfo.pas',
  AddInLib in '..\..\Source\MifareDrv\Units\AddinLib.pas',
  ole1C in '..\..\Source\MifareDrv\Units\ole1C.pas',
  oleAddin in '..\..\Source\MifareDrv\Units\oleAddin.pas',
  oleMain in '..\..\Source\MifareDrv\Units\oleMain.pas',
  untAddin in '..\..\Source\MifareDrv\Units\untAddin.pas',
  untConst in '..\..\Source\MifareDrv\Units\untConst.pas',
  untCtrl in '..\..\Source\MifareDrv\Units\untCtrl.pas',
  untDriver in '..\..\Source\MifareDrv\Units\untDriver.pas',
  untDrvLink in '..\..\Source\MifareDrv\Units\untDrvLink.pas',
  untError in '..\..\Source\MifareDrv\Units\untError.pas',
  untUtil in '..\..\Source\MifareDrv\Units\untUtil.pas',
  fmuPage in '..\..\Source\MifareDrv\Fmu\fmuPage.pas' {fmPage: TPropertyPage},
  fmuAbout in '..\..\Source\MifareDrv\Fmu\fmuAbout.pas' {fmAbout},
  MifareLib_TLB in '..\..\Source\MifareDrv\MifareLib_TLB.pas',
  CardSector in '..\..\Source\MifareDrv\Units\CardSector.pas',
  fmuCatalog in '..\..\Source\MifareDrv\Fmu\fmuCatalog.pas' {fmCatalog},
  fmuPassword in '..\..\Source\MifareDrv\Fmu\fmuPassword.pas' {fmPassword},
  fmuFirm in '..\..\Source\MifareDrv\Fmu\fmuFirm.pas' {fmFirm},
  fmuFirmCode in '..\..\Source\MifareDrv\Fmu\fmuFirmCode.pas' {fmFirmCode},
  fmuFirms in '..\..\Source\MifareDrv\Fmu\fmuFirms.pas' {fmFirms},
  CardFirm in '..\..\Source\MifareDrv\Units\CardFirm.pas',
  CardApp in '..\..\Source\MifareDrv\Units\CardApp.pas',
  CardBlock in '..\..\Source\MifareDrv\Units\CardBlock.pas',
  CardDriver in '..\..\Source\MifareDrv\Units\CardDriver.pas',
  CardField in '..\..\Source\MifareDrv\Units\CardField.pas',
  CustomCard in '..\..\Source\MifareDrv\Units\CustomCard.pas',
  Firms in '..\..\Source\MifareDrv\Units\Firms.pas',
  Mifare1K in '..\..\Source\MifareDrv\Units\Mifare1K.pas',
  Mifare4K in '..\..\Source\MifareDrv\Units\Mifare4K.pas',
  MifareUltraLight in '..\..\Source\MifareDrv\Units\MifareUltraLight.pas',
  Sectors in '..\..\Source\MifareDrv\Units\Sectors.pas',
  untTypes in '..\..\Source\MifareDrv\Units\untTypes.pas',
  fmuApp in '..\..\Source\MifareDrv\Fmu\fmuApp.pas' {fmApp},
  Directory in '..\..\Source\MifareDrv\Units\Directory.pas',
  Notifier in '..\..\Source\MifareDrv\Units\Notifier.pas',
  utole1C in 'Units\utole1C.pas',
  COMPort in '..\..\Source\MifareDrv\Units\ComPort.pas',
  fmuTrailer in '..\..\Source\MifareDrv\Fmu\fmuTrailer.pas' {fmTrailer},
  fmuAccessData in '..\..\Source\MifareDrv\Fmu\fmuAccessData.pas' {fmAccessData},
  fmuAccessTrailer in '..\..\Source\MifareDrv\Fmu\fmuAccessTrailer.pas' {fmAccessTrailer},
  WinSmCrd in '..\..\Source\MifareDrv\Units\WinSmCrd.pas',
  CardCheckerPort in '..\..\Source\MifareDrv\Units\CardCheckerPort.pas',
  OmnikeyCardReader5422 in '..\..\Source\MifareDrv\Units\OmnikeyCardReader5422.pas',
  CardReader in '..\..\Source\MifareDrv\Units\CardReader.pas',
  CardReaderInterface in '..\..\Source\MifareDrv\Units\CardReaderInterface.pas',
  DebugUtils in '..\..\Source\MifareDrv\Units\DebugUtils.pas',
  LogFile in '..\..\Source\MifareDrv\Units\LogFile.pas',
  MFRC500Reader in '..\..\Source\MifareDrv\Units\MFRC500Reader.pas',
  MifareTrailer in '..\..\Source\MifareDrv\Units\MifareTrailer.pas',
  NotifyThread in '..\..\Source\MifareDrv\Units\NotifyThread.pas',
  Port in '..\..\Source\MifareDrv\Units\Port.pas',
  PriceDrv_TLB in '..\..\Source\MifareDrv\Units\PriceDrv_TLB.pas',
  SCardErr in '..\..\Source\MifareDrv\Units\SCardErr.pas',
  SCardSyn in '..\..\Source\MifareDrv\Units\SCardSyn.pas',
  SCardSynh in '..\..\Source\MifareDrv\Units\scardsynh.pas',
  SerialParams in '..\..\Source\MifareDrv\Units\SerialParams.pas',
  SerialPort in '..\..\Source\MifareDrv\Units\SerialPort.pas',
  SerialPortInterface in '..\..\Source\MifareDrv\Units\SerialPortInterface.pas',
  WinSCard in '..\..\Source\MifareDrv\Units\WinSCard.pas',
  fmuLogFile in '..\..\Source\MifareDrv\Fmu\fmuLogFile.pas' {fmLogFile},
  fmuSerialParams in '..\..\Source\MifareDrv\Fmu\fmuSerialParams.pas' {fmSerialParams},
  DriverEvent in '..\..\Source\MifareDrv\Units\DriverEvent.pas',
  CardReaderEmulator in '..\..\Source\MifareDrv\Units\CardReaderEmulator.pas',
  utCardFirm in 'Units\utCardFirm.pas',
  utOmnikey5422 in 'Units\utOmnikey5422.pas',
  AxCtrls in '..\..\..\Shared\AxCtrls.pas',
  EventItem in 'Units\EventItem.pas',
  MethodSynchronizer in '..\..\Source\MifareDrv\Units\MethodSynchronizer.pas',
  MifareDevice in '..\..\Source\MifareDrv\Units\MifareDevice.pas',
  OmnikeyReader5422 in '..\..\Source\MifareDrv\Units\OmnikeyReader5422.pas',
  BaseForm in '..\..\Source\MifareDrv\Units\BaseForm.pas',
  DriverUtils in 'Units\DriverUtils.pas',
  fmuDeviceSearch in '..\..\Source\MifareDrv\Fmu\fmuDeviceSearch.pas' {fmDeviceSearch},
  DeviceSearch in '..\..\Source\MifareDrv\Units\DeviceSearch.pas',
  SearchPort in '..\..\Source\MifareDrv\Units\SearchPort.pas',
  fmuParams in '..\..\Source\MifareDrv\Fmu\fmuParams.pas' {fmParams},
  ParamPage in '..\..\Source\MifareDrv\Units\ParamPage.pas',
  fmuPollParams in '..\..\Source\MifareDrv\Fmu\fmuPollParams.pas' {fmPollParams},
  fmuBlockParams in '..\..\Source\MifareDrv\Fmu\fmuBlockParams.pas' {fmBlockParams},
  fmuLogParams in '..\..\Source\MifareDrv\Fmu\fmuLogParams.pas' {fmLogParams},
  utDriver in 'Units\utDriver.pas',
  OmnikeyReader in '..\..\Source\MifareDrv\Units\OmnikeyReader.pas',
  SCardUtil in '..\..\Source\MifareDrv\Units\SCardUtil.pas',
  OmnikeyCardReader in '..\..\Source\MifareDrv\Units\OmnikeyCardReader.pas';

{$R *.RES}
{$R ..\..\Source\MifareDrv\MifareDrv.TLB}

begin
  TGUITestRunner.RunTest(RegisteredTests);
end.
