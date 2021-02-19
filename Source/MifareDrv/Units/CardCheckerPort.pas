unit CardCheckerPort;

interface

uses
  // VCL
  Windows, ComObj, SysUtils, SyncObjs,
  // This
  SerialPortInterface, PriceDrv_TLB, untUtil, untError, SerialParams;

type
  { TCardCheckerPort }

  TCardCheckerPort = class(TInterfacedObject, ISerialPort)
  private
    FRxData: string;
    FTxData: string;
    FCS: TCriticalSection;
    FParams: TSerialParams;
    FPriceDrv: TPriceChecker;

    procedure Lock;
    procedure Unlock;
    function GetPriceDrv: TPriceChecker;
    property PriceDrv: TPriceChecker read GetPriceDrv;
    procedure Check(ResultCode: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Close;
    function Opened: Boolean;
    function GetRxData: string;
    function GetTxData: string;
    function GetParams: TSerialParams;
    procedure ShowProperties(ParentWnd: HWND);
    procedure Open(const Params: TSerialParams);
    function SendCommand(const Data: string): string;
  end;

implementation

const
  STX = #2;

{ TCardCheckerPort }

constructor TCardCheckerPort.Create;
begin
  inherited Create;
  FCS := TCriticalSection.Create;
end;

destructor TCardCheckerPort.Destroy;
begin
  FPriceDrv.Free;
  FCS.Free;
  inherited Destroy;
end;

procedure TCardCheckerPort.Close;
begin
  Lock;
  try
  Check(PriceDrv.Disconnect);
  finally
    Unlock;
  end;
end;

function TCardCheckerPort.GetPriceDrv: TPriceChecker;
begin
  if FPriceDrv = nil then
    FPriceDrv := TPriceChecker.Create(nil);
  Result := FPriceDrv;
end;

procedure TCardCheckerPort.Open;
begin
  Lock;
  try
    Check(PriceDrv.Connect);
  finally
    Unlock;
  end;
end;

function TCardCheckerPort.Opened: Boolean;
begin
  Result := PriceDrv.Connected;
end;

procedure TCardCheckerPort.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then
    RaiseError(PriceDrv.ResultCode, PriceDrv.ResultCodeDescription);
end;

function TCardCheckerPort.SendCommand(const Data: string): string;
var
  DataLen: Integer;
begin
  FRxData := '';
  FTxData := Data;

  Lock;
  try
    PriceDrv.MifareTimeout := FParams.Timeout;
    PriceDrv.MifareCommand := Data;
    Check(PriceDrv.SendMifareCommand);
    Result := PriceDrv.MifareAnswer;
    FRxData := Result;

    if Result[1] <> STX then
      RaiseError(E_INVALID_FRAME, S_INVALID_FRAME);
    DataLen := Ord(Result[2]);
    if DataLen = 0 then
      RaiseError(E_ANSWER_LENGTH, S_ANSWER_LENGTH);

    Result := Copy(Result, 2, Length(Result) - 1);
  finally
    Unlock;
  end;
end;

procedure TCardCheckerPort.ShowProperties(ParentWnd: HWND);
begin
  Check(PriceDrv.ShowProperties);
end;

procedure TCardCheckerPort.Lock;
begin
  FCS.Enter;
end;

procedure TCardCheckerPort.Unlock;
begin
  FCS.Leave;
end;

function TCardCheckerPort.GetParams: TSerialParams;
begin
  Result := FParams;
end;

function TCardCheckerPort.GetRxData: string;
begin
  Result := FRxData;
end;

function TCardCheckerPort.GetTxData: string;
begin
  Result := FTxData;
end;

end.
