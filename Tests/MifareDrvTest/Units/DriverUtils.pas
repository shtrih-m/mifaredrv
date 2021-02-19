unit DriverUtils;

interface

uses
  // VCL
  Registry,
  // This
  untConst;

procedure DisableDriverLog;

implementation

procedure DisableDriverLog;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := RegRootKey;
    if Reg.OpenKey(REGSTR_KEY_DRV + 'Params', False) then
    begin
      Reg.WriteBool(REGSTR_VAL_LOGENABLED, False);
    end;
  finally
    Reg.Free;
  end;
end;


end.
