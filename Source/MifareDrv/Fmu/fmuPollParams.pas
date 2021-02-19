unit fmuPollParams;

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
  { TfmPollParams }

  TfmPollParams = class(TParamPage)
    lblPollActivateMethod: TLabel;
    cbPollActivateMethod: TComboBox;
  private
  public
    procedure UpdatePage; override;
    procedure UpdateObject; override;
    procedure SetDefaults; override;
  end;

var
  fmPollParams: TfmPollParams;

implementation

{$R *.DFM}

procedure TfmPollParams.UpdatePage;
begin
  cbPollActivateMethod.ItemIndex := Driver.PollActivateMethod;
end;

procedure TfmPollParams.UpdateObject;
begin
  Driver.PollActivateMethod := cbPollActivateMethod.ItemIndex;
end;

procedure TfmPollParams.SetDefaults;
begin
  cbPollActivateMethod.ItemIndex := 0;
end;

end.
