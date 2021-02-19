program CfgMgr1C;

uses
  ShlObj,
  Windows,
  Classes,
  SysUtils,
  ActiveX,
  TntSystem in 'Tnt\TntSystem.pas',
  TntClasses in 'Tnt\TntClasses.pas',
  TntSysUtils in 'Tnt\TntSysUtils.pas',
  TntWindows in 'Tnt\TntWindows.pas',
  TntFormatStrUtils in 'Tnt\TntFormatStrUtils.pas',
  TntTypInfo in 'Tnt\TntTypInfo.pas',
  CfgManager in 'Units\CfgManager.pas';

{$R *.RES}

var
  Command: string;
  Params: TCfgParamsRec;
begin
  try
    Command := ParamStr(1);
    if Command = 'addcfg' then
    begin
      Params.Version1C := ParamStr(2);
      Params.AppPath := ParamStr(3);
      Params.AppGUID := ParamStr(4);
      Params.AppName := ParamStr(5);
      TCfgManager.AddCfg(Params);
    end;

  except
    on E: Exception do
      OutputDebugString(PChar(E.Message));
  end;
end.
