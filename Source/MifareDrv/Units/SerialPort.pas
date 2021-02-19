unit SerialPort;

interface

uses
  // VCL
  Windows,
  // This
  SerialParams;

type
  { TSerialPort }

  TSerialPort = class
  private
    FParams: TSerialParams;
    function GetPortNumber: Integer;
    procedure SetPortNumber(const Value: Integer);
    function GetBaudRate: Integer;
    procedure SetBaudRate(const Value: Integer);
    function GetTimeout: Integer;
    procedure SetTimeout(const Value: Integer);
    function GetParams: TSerialParams;
    function GetRxData: string;
    function GetTxData: string;
  protected
    FRxData: string;
    FTxData: string;
  public
    constructor Create(AParams: TSerialParams);

    procedure Open; virtual; abstract;
    procedure Close; virtual; abstract;
    function Opened: Boolean; virtual; abstract;
    procedure ShowProperties(ParentWnd: HWND); virtual; abstract;
    function SendCommand(const Data: string): string; virtual; abstract;

    property RxData: string read GetRxData;
    property TxData: string read GetTxData;
    property Params: TSerialParams read GetParams;
    property Timeout: Integer read GetTimeout write SetTimeout;
    property BaudRate: Integer read GetBaudRate write SetBaudRate;
    property PortNumber: Integer read GetPortNumber write SetPortNumber;
  end;

implementation

{ TSerialPort }

constructor TSerialPort.Create(AParams: TSerialParams);
begin
  inherited Create;
  FParams := AParams;
end;

function TSerialPort.GetBaudRate: Integer;
begin
  Result := Params.BaudRate;
end;

function TSerialPort.GetParams: TSerialParams;
begin
  Result := FParams;
end;

function TSerialPort.GetPortNumber: Integer;
begin
  Result := Params.PortNumber;
end;

function TSerialPort.GetRxData: string;
begin

end;

function TSerialPort.GetTimeout: Integer;
begin
  Result := Params.Timeout;
end;

function TSerialPort.GetTxData: string;
begin

end;

procedure TSerialPort.SetBaudRate(const Value: Integer);
begin
  FParams.BaudRate := Value;
end;

procedure TSerialPort.SetPortNumber(const Value: Integer);
begin
  FParams.PortNumber := Value;
end;

procedure TSerialPort.SetTimeout(const Value: Integer);
begin
  FParams.Timeout := Value;
end;

end.
