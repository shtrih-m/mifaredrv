unit fmuConnectionTest;

interface

uses
  //VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  //This
  untPage;

type
  TfmConnectionTest = class(TPage)
    GroupBox1: TGroupBox;
    lblRepCount2: TLabel;
    lblRepCount: TLabel;
    lblErrCount2: TLabel;
    lblErrCount: TLabel;
    lblSpeed: TLabel;
    lblTxSpeed: TLabel;
    lblExecTime2: TLabel;
    lblExecTime: TLabel;
    lblErrRate2: TLabel;
    lblErrRate: TLabel;
    lblTimeLeft2: TLabel;
    lblTimeLeft: TLabel;
    btnStart: TButton;
    btnStop: TButton;
    chbStopOnError: TCheckBox;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    StopFlag: Boolean;
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TfmConnectionTest.btnStartClick(Sender: TObject);
var
  Speed: Integer;
  ErrRate: Double;
  TimeLeft: DWORD;
  TickCount: DWORD;
  RepCount: Integer;
  ErrCount: Integer;
  ResultCode: Integer;
begin
  RepCount := 0;
  ErrCount := 0;
  StopFlag := False;
  TickCount := GetTickCount;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    ResultCode := Driver.OpenPort;
    if ResultCode <> 0 then Exit;

    repeat
      Inc(RepCount);

      ResultCode := Driver.PcdGetFwVersion;
      if ResultCode <> 0 then Inc(ErrCount);

      TimeLeft := GetTickCount - TickCount;
      if TimeLeft = 0 then Continue;

      Speed := Trunc(RepCount*1000/TimeLeft);
      ErrRate := ErrCount*100/RepCount;

      lblRepCount.Caption := IntToStr(RepCount);
      lblErrCount.Caption := IntToStr(ErrCount);
      lblTxSpeed.Caption := IntToStr(Speed);
      lblErrRate.Caption := Format('%.2f', [ErrRate]);
      lblTimeLeft.Caption := IntToStr(Trunc(TimeLeft/1000));
      lblExecTime.Caption := IntToStr(Trunc(TimeLeft/RepCount));

      Application.ProcessMessages;
      if (ResultCode <> 0) and (chbStopOnError.Checked) then
      begin
        Driver.ClosePort;
        Exit;
      end;
    until StopFlag;
    Driver.ClosePort;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmConnectionTest.btnStopClick(Sender: TObject);
begin
  StopFlag := True;
end;

end.
