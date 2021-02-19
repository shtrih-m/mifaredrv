unit DebugUtils;

interface

uses
  // VCL
  Windows;

procedure ODS(const S: string);

implementation

procedure ODS(const S: string);
begin
  //{$IFDEF DEBUG}
  OutputDebugString(PChar(S));
  //{$ENDIF}
end;

end.
