unit SearchController;

interface

uses
  // VCL
  // This
  NotifyThread, MifareLib_TLB, SearchPort;

type
  { TSearchController }

  TSearchController = class
  private
    FStarted: Boolean;
    FStopFlag: Boolean;
    FPorts: TSearchPorts;
    FThread: TNotifyThread;

    procedure StopThread;
    function GetStarted: Boolean;
  public
    procedure Stop;
    procedure Start;
    property Started: Boolean read FStarted;
  end;

implementation

const
  BaudRates: array [0..6] of string = (
  '2400',
  '4800',
  '9600',
  '19200',
  '38400',
  '57600',
  '115200');

{ TSearchController }

procedure TSearchController.StopThread;
begin
  FStopFlag := True;
  FThread.Free;
  FThread := nil;
end;

procedure TSearchController.Start;
begin
(*
  StopThread;
  ClearListItems;
  FThread := TNotifyThread.CreateThread(ThreadProc);
  FThread.OnTerminate := ThreadTerminated;

  btnStart.Enabled := False;
  btnStop.Enabled := True;
  btnStop.SetFocus;
  Animate.Play(Animate.StartFrame, Animate.StopFrame, 0);
  Animate.Visible := True;
  ListView.Enabled := False;
  btnClearPorts.Enabled := False;
  btnCheckPorts.Enabled := False;
*)
end;

procedure TSearchController.Stop;
begin

end;

(*

procedure TfmFind.ClearListItems;
var
  i: Integer;
begin
  for i := 0 to ListView.Items.Count-1 do
    ListView.Items[i].SubItems.Clear;
  ListView.Refresh;
end;


*)

end.
