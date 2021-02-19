unit fmuBlockParams;

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

  TfmBlockParams = class(TParamPage)
    chbErrorOnCorruptedValueBlock: TCheckBox;
    Label1: TLabel;
  private
  public
    procedure UpdatePage; override;
    procedure UpdateObject; override;
    procedure SetDefaults; override;
  end;

var
  fmBlockParams: TfmBlockParams;

implementation

{$R *.DFM}

procedure TfmBlockParams.UpdatePage;
begin
  chbErrorOnCorruptedValueBlock.Checked := Driver.ErrorOnCorruptedValueBlock;
end;

procedure TfmBlockParams.UpdateObject;
begin
  Driver.ErrorOnCorruptedValueBlock := chbErrorOnCorruptedValueBlock.Checked;
end;

procedure TfmBlockParams.SetDefaults;
begin
  chbErrorOnCorruptedValueBlock.Checked := False;
end;

end.
