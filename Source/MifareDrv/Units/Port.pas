unit Port;

interface

uses
  // VCL
  Windows;

type
  { TPort }

  TPort = class
  public
    BaudRate: Integer;
    Timeout: DWORD;
    PortNumber: Integer;
    procedure Open; virtual; abstract;
    procedure Close; virtual; abstract;
    procedure Purge; virtual; abstract;
    function Opened: Boolean; virtual; abstract;
    procedure Write(const Data: string); virtual; abstract;
    function Read(Count: DWORD): string; virtual; abstract;
    procedure SetTimeout(Value: DWORD); virtual; abstract;
  end;

implementation

end.
