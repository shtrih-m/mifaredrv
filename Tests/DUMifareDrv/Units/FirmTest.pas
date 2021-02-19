unit FirmTest;

interface

uses
  // VCL
  SysUtils,
  // TestFramework
  TestFramework,
  // This
  CardFirm, CardApp;

type
  { TFirmsTest }

  TFirmsTest = class(TTestCase)
  published
    procedure TestIniFile;
  end;

implementation

{ TFirmsTest }

procedure TFirmsTest.TestIniFile;
var
  App: TCardApp;
  Firm: TCardFirm;
  Src: TCardFirms;
  Dst: TCardFirms;
  IniFileName: string;
begin
  IniFileName := ChangeFileExt(ParamStr(0), '.ini');
  if FileExists(IniFileName) then DeleteFile(IniFileName);

  Src := TCardFirms.Create;
  Dst := TCardFirms.Create;
  try
    // ����� 1
    Firm := Src.Add;
    Firm.Code := 10;
    Firm.Name := '98we.kdjhfskdjf=jd';
    // ���������� 1
    App := Firm.CardApps.Add;
    App.Code := 23;
    App.Name := '039458';
    // ���������� 2
    App := Firm.CardApps.Add;
    App.Code := 89;
    App.Name := 'kxcclviuarvh';
    // ����� 2
    Firm := Src.Add;
    Firm.Code := 124;
    Firm.Name := 'aslfkdjhaslfuiy13 f498';

    Src.SaveToIniFile(IniFileName);
    Dst.LoadFromIniFile(IniFileName);
    Check(Src.IsEqual(Dst));
  finally
    Src.Free;
    Dst.Free;
  end;
end;

initialization
  RegisterTest('', TFirmsTest.Suite);

end.
