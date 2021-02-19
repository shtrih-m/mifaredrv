unit ole1C;

interface

uses
  // VCL
  Windows, ActiveX, SysUtils, AxCtrls, ComObj, ComServ, Forms,
  // This
  MifareLib_TLB, oleAddin, AddInLib, untCtrl, LogFile;

type
  { Tole1C }

  Tole1C = class(ToleAddin, IInitDone)
  protected
    procedure DriverOnEvent(Sender: TObject; EventID: Integer); override;
    procedure CardEvent(Sender: TObject; const CardUIDHex: WideString); override;
    procedure PollError(Sender: TObject; ErrorCode: Integer;
      const ErrorText: WideString); override;
  private
    FAsyncEvent: IAsyncEvent;

    // IInitDone
    function Init(pConnection: IDispatch): HResult; stdcall;
    function Done: HResult; stdcall;
    function GetInfo(var Info: PSafeArray): HResult; stdcall;
    procedure ExternalEvent(const ASource, AMessage, AData: WideString);
  end;

implementation

{$R *.RES}

{ Tole1C }

function Tole1C.Init(pConnection: IDispatch): HResult;
var
  EventBufferDepth: Integer;
begin
  Logger.Debug('Tole1C.Init');

  if pConnection <> nil then
    pConnection.QueryInterface(IAsyncEvent, FAsyncEvent);

  if FAsyncEvent <> nil then
  begin
    FAsyncEvent.SetEventBufferDepth(100);
    FAsyncEvent.GetEventBufferDepth(EventBufferDepth);
    Logger.Debug(Format('EventBufferDepth: %d', [EventBufferDepth]));
  end;

  Result := S_OK;
  FIsClient1C := True;
end;

function Tole1C.Done: HResult;
begin
  Result := S_OK;
  FAsyncEvent := nil;
end;

function Tole1C.GetInfo(var Info: PSafeArray): HResult;
var
  Index: Integer;
  Value: OleVariant;
begin
  Index := 0;
  Value := '2000';
  SafeArrayPutElement(Info, Index, Value);
  Result := S_OK;
end;

procedure Tole1C.ExternalEvent(const ASource, AMessage, AData: WideString);
begin
  if (FAsyncEvent <> nil)and(ASource <> '')and(AMessage <> '')and(AData <> '') then
  begin
    Logger.Debug(Format('ExternalEvent("%s", "%s", "%s")', [ASource, AMessage, AData]));
    try
      FAsyncEvent.ExternalEvent(ASource, AMessage, AData);
    except
      on E: Exception do
      begin
        Logger.Error('ExternalEventError: ' + E.Message);
      end;
    end;
  end;
end;

procedure Tole1C.DriverOnEvent(Sender: TObject; EventID: Integer);
begin
  inherited DriverOnEvent(Sender, EventID);
  ExternalEvent('MifareDrv', 'DriverEvent', IntToStr(EventID));
end;

procedure Tole1C.CardEvent(Sender: TObject; const CardUIDHex: WideString);
begin
  inherited CardEvent(Sender, CardUIDHex);
  ExternalEvent('MifareDrv', 'CardFound', CardUIDHex);
end;

procedure Tole1C.PollError(Sender: TObject; ErrorCode: Integer;
  const ErrorText: WideString);
begin
  inherited PollError(Sender, ErrorCode, ErrorText);
  ExternalEvent('MifareDrv', 'PollError', Format('(%d) %s',[ErrorCode, ErrorText]));
end;

initialization
  ComServer.SetServerName('Addin');
  TActiveXControlFactory.Create(ComServer, Tole1C, TAxCtrl, CLASS_MifareDrv,
    1, '', OLEMISC_INVISIBLEATRUNTIME, tmApartment);

  TActiveXControlFactory.Create(ComServer, Tole1C, TAxCtrl, CLASS_MifareDrv2,
    1, '', OLEMISC_INVISIBLEATRUNTIME, tmApartment);


end.
