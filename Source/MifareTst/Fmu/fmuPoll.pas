unit fmuPoll;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, MifareLib_TLB;

type
  TfmPoll = class(TPage)
    Memo: TMemo;
    btnPollStart: TButton;
    btnPollStop: TButton;
    btnClear: TButton;
    lblPortNumber: TLabel;
    cbPortNumber: TComboBox;
    chbPollAutoDisable: TCheckBox;
    procedure btnClearClick(Sender: TObject);
    procedure btnPollStartClick(Sender: TObject);
    procedure btnPollStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    AccessTime: Int64;
    AccessCount: Integer;

    procedure DriverEvent(Sender: TObject; EventID: Integer);
    procedure PollError(Sender: TObject; ErrorCode: Integer; const ErrorText: WideString);
    procedure CardFound;
  end;

var
  fmPoll: TfmPoll;

implementation

{$R *.DFM}

procedure FillPortNumbers(Items: TStrings);
var
  i: Integer;
begin
  Items.Clear;
  for i := 1 to 256 do
    Items.AddObject('COM '+ IntToStr(i), TObject(i));
end;

{ TfmPoll }

procedure TfmPoll.btnClearClick(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TfmPoll.DriverEvent(Sender: TObject; EventID: Integer);
begin
  Memo.Lines.Add(Format('DriverEvent: EventID: %d', [EventID]));
  Driver.EventID := EventID;
  if Driver.FindEvent = 0 then
  begin
    if Driver.EventType = 0 then
    begin
      Memo.Lines.Add(Format('CardUIDHex: %s', [
        Driver.EventCardUIDHex]));
      CardFound;
    end else
    begin
      Memo.Lines.Add(Format('PollError: %d, %s', [
        Driver.EventErrorCode,
        Driver.EventErrorText]));
    end;
  end;
  Driver.DeleteEvent;
end;

procedure TfmPoll.PollError(Sender: TObject; ErrorCode: Integer; const ErrorText: WideString);
begin
  Memo.Lines.Add(Format('Ошибка опроса: %d, %s', [ErrorCode, ErrorText]));
end;

procedure TfmPoll.CardFound;
begin
  Memo.Lines.Add('Найдена карта №' + Driver.EventCardUIDHex);
end;

procedure TfmPoll.btnPollStartClick(Sender: TObject);
begin
  AccessTime := 0;
  AccessCount := 0;

  EnableButtons(False);
  try
    Driver.PortNumber := cbPortNumber.ItemIndex + 1;
    Driver.PollAutoDisable := chbPollAutoDisable.Checked;
    Driver.OnPollError := PollError;
    Driver.OnDriverEvent := DriverEvent;
    Driver.PollStart;
  finally
    EnableButtons(True);
  end;
  btnPollStop.SetFocus;
end;

procedure TfmPoll.btnPollStopClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PortNumber := cbPortNumber.ItemIndex + 1;
    Driver.PollStop;
  finally
    EnableButtons(True);
  end;
  btnPollStart.SetFocus;
end;

procedure TfmPoll.FormCreate(Sender: TObject);
begin
  FillPortNumbers(cbPortNumber.Items);
  cbPortNumber.ItemIndex := 0;
end;

end.
