program MifareTst;

uses
  Forms,
  fmuMain in 'Fmu\fmuMain.pas' {fmMain},
  fmuAbout in 'Fmu\fmuAbout.pas' {fmAbout},
  untPage in 'Units\untPage.pas',
  fmuReaderMemory in 'Fmu\fmuReaderMemory.pas' {fmReaderMemory},
  fmuActivate in 'Fmu\fmuActivate.pas' {fmActivate},
  fmuRequest in 'Fmu\fmuRequest.pas' {fmRequest},
  fmuSAMAuth in 'Fmu\fmuSAMAuth.pas' {fmSAMAuth},
  fmuMifarePlusData in 'Fmu\fmuMifarePlusData.pas' {fmMifarePlusData},
  untVInfo in 'Units\untVInfo.pas',
  fmuReaderParams in 'Fmu\fmuReaderParams.pas' {fmReaderParams},
  fmuConnection in 'Fmu\fmuConnection.pas' {fmConnection},
  fmuConnectionTest in 'Fmu\fmuConnectionTest.pas' {fmConnectionTest},
  fmuPoll in 'Fmu\fmuPoll.pas' {fmPoll},
  MifareLib_TLB in '..\MifareDrv\MifareLib_TLB.pas',
  fmuTest in 'Fmu\fmuTest.pas' {fmTest},
  fmuUltraLightC in 'Fmu\fmuUltraLightC.pas' {fmUltraLightC},
  fmuSAMCommands in 'Fmu\fmuSAMCommands.pas' {fmSAMCommands},
  fmuMikleSoft in 'Fmu\fmuMikleSoft.pas' {fmMikleSoft},
  StringUtils in 'Units\StringUtils.pas',
  untUtil in '..\MifareDrv\Units\untUtil.pas',
  untError in '..\MifareDrv\Units\untError.pas',
  MifareTrailer in '..\MifareDrv\Units\MifareTrailer.pas',
  fmuCardData in 'Fmu\fmuCardData.pas' {fmCardData},
  fmuLedControl in 'Fmu\fmuLedControl.pas' {fmLedControl},
  fmuAuth in 'Fmu\fmuAuth.pas' {fmAuth},
  BaseForm in 'Units\BaseForm.pas',
  fmuSAMVersion in 'Fmu\fmuSAMVersion.pas' {fmSAMVersion},
  fmuMifarePlusAuthSL2 in 'Fmu\fmuMifarePlusAuthSL2.pas' {fmMifarePlusAuthSL2},
  fmuDispenser in 'Fmu\fmuDispenser.pas' {fmDispenser},
  fmuValueBlock in 'Fmu\fmuValueBlock.pas' {fmValueBlock},
  fmuCardEmission in 'Fmu\fmuCardEmission.pas' {fmCardEmission},
  fmuMifarePlusParams in 'Fmu\fmuMifarePlusParams.pas' {fmMifarePlusParams},
  fmuMifarePlusPerso in 'Fmu\fmuMifarePlusPerso.pas' {fmMifarePlusPerso},
  fmuUltraLightCLock2 in 'Fmu\fmuUltraLightCLock2.pas' {fmUltraLightCLock2},
  fmuUltraLightCLock0 in 'Fmu\fmuUltraLightCLock0.pas' {fmUltraLightCLock0},
  fmuUltraLightCLock1 in 'Fmu\fmuUltraLightCLock1.pas' {fmUltraLightCLock1},
  fmuUltraLight in 'Fmu\fmuUltraLight.pas' {fmUltraLight},
  fmuData in 'Fmu\fmuData.pas' {fmData},
  fmuUltraLightCData in 'Fmu\fmuUltraLightCData.pas' {fmUltraLightCData},
  fmuMifarePlusAuth in 'Fmu\fmuMifarePlusAuth.pas' {fmMifarePlusAuth},
  MifareTypes in 'Units\MifareTypes.pas',
  fmuMifarePlusValue in 'Fmu\fmuMifarePlusValue.pas' {fmMifarePlusValue};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Тест драйвера считывателей Mifare';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmUltraLightCLock0, fmUltraLightCLock0);
  Application.CreateForm(TfmUltraLightCLock1, fmUltraLightCLock1);
  Application.Run;
end.
