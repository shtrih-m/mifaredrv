program AddinTest;

uses
  Forms,
  fmuMain in 'FMU\fmuMain.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
