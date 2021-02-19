program TlbEnum;

uses
  Forms,
  fmuMain in 'Fmu\fmuMain.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.                                             
