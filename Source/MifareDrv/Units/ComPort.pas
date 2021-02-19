unit COMPort;

// COM-порт

interface

uses
  // VCL
  Windows, SysUtils, SyncObjs,
  // This
  SerialPortInterface, untError, untUtil, untConst, SerialParams, LogFile;

type
  { TComPort }

  TComPort = class(TInterfacedObject, ISerialPort)
  private
    FRxData: string;
    FTxData: string;
    FHandle: THandle;
    FCS: TCriticalSection;
    FParams: TSerialParams;

    procedure Lock;
    procedure Unlock;
    procedure Purge;
    function GetHandle: THandle;
    function ReadAnswer: string;
    procedure Write(const Data: string);
    function Read(Count: DWORD): string;
    procedure UpdateTimeout(Value: DWORD);
    procedure UpdateBaudRate(Value: DWORD);
    procedure CreateHandle(APortNumber: DWORD);

    property Handle: THandle read GetHandle;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Close;
    procedure ShowProperties(ParentWnd: HWND);
    procedure Open(const Params: TSerialParams);

    function Opened: Boolean;
    function GetRxData: string;
    function GetTxData: string;
    function GetParams: TSerialParams;
    function SendCommand(const Data: string): string;
  end;

implementation

const
  STX = #$02;
  ENQ = #$05;

{ TComPort }

constructor TComPort.Create;
begin
  inherited Create;
  FCS := TCriticalSection.Create;
  FHandle := INVALID_HANDLE_VALUE;
end;

destructor TComPort.Destroy;
begin
  Close;
  FCS.Free;
  inherited Destroy;
end;

procedure TComPort.UpdateBaudRate(Value: DWORD);
const
  fBinary = $00000003;
var
  DCB: TDCB;
begin
  FillChar(DCB, SizeOf(DCB), 0);
  DCB.Bytesize := 8;
  DCB.Parity := FParams.Parity;
  DCB.Stopbits := ONESTOPBIT;   // TWOSTOPBITS;
  DCB.BaudRate := FParams.BaudRate;
  DCB.Flags := FBinary;

  if not SetCommState(Handle, DCB) then
    RaiseLastOsError;
end;

function TComPort.Opened: Boolean;
begin
  Result := FHandle <> INVALID_HANDLE_VALUE;
end;

procedure TComPort.CreateHandle(APortNumber: DWORD);
var
  DeviceName: string;
begin
  DeviceName := '\\.\COM' + IntToStr(APortNumber);
  FHandle := CreateFile(PCHAR(DeviceName),
    GENERIC_READ or GENERIC_WRITE, 0, nil,
    OPEN_EXISTING, 0, 0);

  if not Opened then
  begin
    if GetLastError = ERROR_ACCESS_DENIED then
      RaiseError(E_COM_ACCESS_DENIED, S_COM_ACCESS_DENIED)
    else
      RaiseError(E_COM_PORT_NOT_FOUND, S_COM_PORT_NOT_FOUND);
  end;
end;

function TComPort.GetHandle: THandle;
begin
  if not Opened then Open(FParams);
  Result := FHandle;
end;

procedure TComPort.Open(const Params: TSerialParams);
begin
  FParams := Params;
  Lock;
  try
    if not Opened then
    begin
      CreateHandle(FParams.PortNumber);
      if not SetupComm(Handle, 1024, 1024) then
        RaiseLastOsError;
      UpdateBaudRate(FParams.BaudRate);
      UpdateTimeout(FParams.Timeout);
    end;
  finally
    Unlock;
  end;
end;

procedure TComPort.Close;
begin
  Lock;
  try
    if Opened then
    begin
      CloseHandle(FHandle);
      FHandle := INVALID_HANDLE_VALUE;
    end;
  finally
    Unlock;
  end;
end;

procedure TComPort.Write(const Data: string);
var
  WriteCount: Integer;
begin
  Logger.Debug('-> ' + StrToHexText(Data));

  if not WriteFile(Handle, Data[1], Length(Data), DWORD(WriteCount), nil) then
    RaiseLastOsError;
  if WriteCount <> Length(Data) then
    RaiseError(E_COM_WRITE_ERROR, S_COM_WRITE_ERROR);


end;

function TComPort.Read(Count: DWORD): string;
var
  ReadCount: DWORD;
begin
  SetLength(Result, Count);
  if not ReadFile(Handle, Result[1], Count, ReadCount, nil) then
    RaiseLastOsError;
  if ReadCount <> Count then
    RaiseNoHardwareError;

  SetLength(Result, ReadCount);
  Logger.Debug('<- ' + StrToHexText(Result));
end;

procedure TComPort.UpdateTimeout(Value: DWORD);
var
  Timeouts: TCommTimeouts;
begin
  Timeouts.ReadIntervalTimeout := Value;
  Timeouts.ReadTotalTimeoutMultiplier := 1;
  Timeouts.ReadTotalTimeoutConstant := Value;
  Timeouts.WriteTotalTimeoutMultiplier := Value;
  Timeouts.WriteTotalTimeoutConstant := 0;
  if not SetCommTimeouts(Handle, TimeOuts) then
    RaiseLastOsError;
end;

procedure TComPort.Purge;
begin
  PurgeComm(Handle, PURGE_RXABORT + PURGE_RXCLEAR + PURGE_TXABORT +
    PURGE_TXCLEAR);
end;

function TComPort.ReadAnswer: string;
var
  DataLen: Integer;
begin
  repeat
  until Read(1) = STX;

  DataLen := Ord(Read(1)[1]);
  if DataLen = 0 then
    RaiseError(E_ANSWER_LENGTH, S_ANSWER_LENGTH);

  Result := Chr(DataLen) + Read(DataLen + 1);
  FRxData := STX + Result;
end;

function TComPort.SendCommand(const Data: string): string;
begin
  FRxData := '';
  FTxData := Data;

  Lock;
  try
    Open(FParams);
    Purge;
    Write(Data);
    Result := ReadAnswer;
  finally
    Unlock;
  end;
end;

procedure TComPort.ShowProperties;
begin

end;

procedure TComPort.Lock;
begin
  FCS.Enter;
end;

procedure TComPort.Unlock;
begin
  FCS.Leave;
end;

function TComPort.GetParams: TSerialParams;
begin
  Result := FParams;
end;

function TComPort.GetRxData: string;
begin
  Result := FRxData;
end;

function TComPort.GetTxData: string;
begin
  Result := FTxData;
end;

end.
