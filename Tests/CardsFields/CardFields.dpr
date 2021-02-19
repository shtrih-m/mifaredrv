program CardFields;

uses
  Forms,
  fmuMain in 'fmuMain.pas' {Form1},
  CardField in 'CardField.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
