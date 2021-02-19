unit fmuLogParams;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls,
  // Tnt
  TntComCtrls, TntStdCtrls, TntDialogs,
  // This
  ParamPage, VersionInfo, LogFile;

type
  { TfmLogParams }

  TfmLogParams = class(TParamPage)
    gbParams: TGroupBox;
    lblLogFileName: TLabel;
    chbLogEnabled: TCheckBox;
    edtLogFilePath: TEdit;
  private
  public
    procedure UpdatePage; override;
    procedure UpdateObject; override;
    procedure SetDefaults; override;
  end;

var
  fmLogParams: TfmLogParams;

implementation

{$R *.DFM}

procedure TfmLogParams.UpdatePage;
begin
  edtLogFilePath.Text := Driver.LogFilePath;
  chbLogEnabled.Checked := Driver.LogEnabled;
end;

procedure TfmLogParams.UpdateObject;
begin
  Driver.LogFilePath := edtLogFilePath.Text;
  Driver.LogEnabled := chbLogEnabled.Checked;
end;

procedure TfmLogParams.SetDefaults;
begin
  chbLogEnabled.Checked := False;
  edtLogFilePath.Text := TLogFile.GetDefaultPath;
end;

end.
