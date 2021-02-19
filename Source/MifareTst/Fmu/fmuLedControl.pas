unit fmuLedControl;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage;

type
  TfmLedControl = class(TPage)
    gsLeds: TGroupBox;
    lblBS: TLabel;
    chkRedLED: TCheckBox;
    chkGreenLED: TCheckBox;
    chkBlueLED: TCheckBox;
    btnPcdControlLEDAndPoll: TButton;
    edtButtonState: TEdit;
    btnPcdControlLED: TButton;
    btnPcdPollButton: TButton;
    chkYellowLED: TCheckBox;
    procedure btnPcdControlLEDAndPollClick(Sender: TObject);
    procedure btnPcdControlLEDClick(Sender: TObject);
    procedure btnPcdPollButtonClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmLED }

procedure TfmLedControl.btnPcdControlLEDAndPollClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RedLED := chkRedLED.Checked;
    Driver.GreenLED := chkGreenLED.Checked;
    Driver.BlueLED := chkBlueLED.Checked;
    Driver.YellowLED := chkYellowLED.Checked;
    Driver.PcdControlLEDAndPoll;
    if Driver.ButtonState then
      edtButtonState.Text := 'была нажата'
    else
      edtButtonState.Text := 'не была нажата';
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLedControl.btnPcdControlLEDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RedLED := chkRedLED.Checked;
    Driver.GreenLED := chkGreenLED.Checked;
    Driver.BlueLED := chkBlueLED.Checked;
    Driver.YellowLED := chkYellowLED.Checked;
    Driver.PcdControlLED;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLedControl.btnPcdPollButtonClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PcdPollButton;
    if Driver.ButtonState then
      edtButtonState.Text := 'была нажата'
    else
      edtButtonState.Text := 'не была нажата';
  finally
    EnableButtons(True);
  end;
end;

end.
