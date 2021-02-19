unit NotifyThread;

interface

uses
  // VCL
  Windows, SysUtils, Classes, Messages, Forms, SyncObjs;

type
  { TNotifyThread }

  TNotifyThread = class(TThread)
  private
    FStartEvent: TEvent;
    FOnExecute: TNotifyEvent;
  protected
    procedure Execute; override;
  public
    constructor CreateThread(AOnExecute: TNotifyEvent);
    destructor Destroy; override;
  published
    property Terminated;
  end;

implementation

{ TNotifyThread }

constructor TNotifyThread.CreateThread(AOnExecute: TNotifyEvent);
begin
  inherited Create(True);
  FOnExecute := AOnExecute;
  FStartEvent := TSimpleEvent.Create;
  Resume;

  if FStartEvent.WaitFor(INFINITE) <> wrSignaled then
    RaiseLastOSError;
end;

destructor TNotifyThread.Destroy;
begin
  FStartEvent.SetEvent;
  FStartEvent.Free;
  inherited Destroy;
end;

procedure TNotifyThread.Execute;
begin
  FStartEvent.SetEvent;
  if Assigned(FOnExecute) then
    FOnExecute(Self);
end;

end.
