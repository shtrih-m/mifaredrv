unit fmuActivate;

interface

uses
  // VCL          
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage;

type
  TfmActivate = class(TPage)
    Timer: TTimer;
    gsPoll: TGroupBox;
    lblPoll: TLabel;
    Shape: TShape;
    btnStart: TButton;
    btnStop: TButton;
    Label1: TLabel;
    gsActivate: TGroupBox;
    lblBaudRate: TLabel;
    lblSAK: TLabel;
    lblATQ: TLabel;
    lblUID: TLabel;
    lblInfo: TLabel;
    lblCardType: TLabel;
    btnPiccActivateIdle: TButton;
    cbBaudRate: TComboBox;
    edtSAK: TEdit;
    edtATQ: TEdit;
    edtUIDHex: TEdit;
    btnPiccActivateWakeup: TButton;
    edtCardDescription: TEdit;
    procedure btnPiccActivateIdleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPiccActivateWakeupClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmActivate.FormCreate(Sender: TObject);
begin
  with cbBaudRate do
  begin
    Items.Clear;
    Items.Add('106 kBaud');
    Items.Add('212 kBaud');
    Items.Add('424 kBaud');
    Items.Add('848 kBaud');
    ItemIndex := 0;
  end;
end;

procedure TfmActivate.btnPiccActivateIdleClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BaudRate := cbBaudRate.ItemIndex;
    if Driver.PiccActivateIdle = 0 then
    begin
      edtATQ.Text := IntToStr(Driver.ATQ);
      edtSAK.Text := IntToStr(Driver.SAK);
      edtUIDHex.Text := Driver.UIDHex;
      edtCardDescription.Text := Driver.CardDescription;
    end else
    begin
      edtATQ.Clear;
      edtSAK.Clear;
      edtUIDHex.Clear;
      edtCardDescription.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmActivate.btnPiccActivateWakeupClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BaudRate := cbBaudRate.ItemIndex;
    if Driver.PiccActivateWakeUp = 0 then
    begin
      edtATQ.Text := IntToStr(Driver.ATQ);
      edtSAK.Text := IntToStr(Driver.SAK);
      edtUIDHex.Text := Driver.UIDHex;
      edtCardDescription.Text := Driver.CardDescription;
    end else
    begin
      edtATQ.Clear;
      edtSAK.Clear;
      edtUIDHex.Clear;
      edtCardDescription.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmActivate.btnStartClick(Sender: TObject);
begin
  Timer.Enabled := True;
  btnStop.Enabled := True;
  btnStart.Enabled := False;
  Shape.Brush.Color := clRed;
end;

procedure TfmActivate.btnStopClick(Sender: TObject);
begin
  Timer.Enabled := False;
  btnStop.Enabled := False;
  btnStart.Enabled := True;
  Shape.Brush.Color := clRed;
end;

procedure TfmActivate.TimerTimer(Sender: TObject);
begin
  Driver.PiccActivateWakeUp;
  if Driver.ResultCode = 0 then
  begin
    Shape.Brush.Color := clGreen;
    edtATQ.Text := IntToStr(Driver.ATQ);
    edtSAK.Text := IntToStr(Driver.SAK);
    edtUIDHex.Text := Driver.UIDHex;
    edtCardDescription.Text := Driver.CardDescription;
  end else
  begin
    edtATQ.Clear;
    edtSAK.Clear;
    edtUIDHex.Clear;
    edtCardDescription.Clear;
    Shape.Brush.Color := clRed;
  end;
end;

end.
