unit DeviceSearch;

interface

uses
  // VCL
  Windows, SysUtils, Classes,
  // This
  SearchPort, MifareLib_TLB, untUtil;

type
  { TDeviceSearch }

  TDeviceSearch = class
  private
    FPorts: TSearchPorts;
    procedure UpdatePorts;
    function GetCompleted: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Start;
    procedure Stop;

    property Ports: TSearchPorts read FPorts;
    property Completed: Boolean read GetCompleted;
  end;

implementation

{ TDeviceSearch }

constructor TDeviceSearch.Create;
begin
  inherited Create;
  FPorts := TSearchPorts.Create;
  UpdatePorts;
end;

destructor TDeviceSearch.Destroy;
begin
  FPorts.Free;
  inherited Destroy;
end;

procedure TDeviceSearch.UpdatePorts;
var
  i: Integer;
  Port: TSearchPort;
  Driver: TMifareDrv;
  PortNames: TStringList;
  PortData: TSearchPortRec;
begin
  Ports.Lock;
  Driver := TMifareDrv.Create(nil);
  PortNames := TStringList.Create;
  try
    Ports.Clear;
    GetDevicePorts(PortNames);
    for i := 0 to PortNames.Count-1 do
    begin
      PortData.PortName := PortNames[i];
      PortData.PortNumber := StrToInt(Copy(PortNames[i], 4, 10));

      Port := Ports.Add;
      Port.Data := PortData;
      Port.Selected := True;
    end;
  finally
    Driver.Free;
    PortNames.Free;
    Ports.Unlock;
  end;
end;

procedure TDeviceSearch.Stop;
var
  i: Integer;
begin
  for i := 0 to Ports.Count-1 do
    Ports[i].Stop;
end;

procedure TDeviceSearch.Start;
var
  i: Integer;
begin
  Stop;
  for i := 0 to Ports.Count-1 do
  begin
    Ports[i].Start;
  end;
end;

function TDeviceSearch.GetCompleted: Boolean;
begin
  Result := Ports.Completed;
end;

end.
