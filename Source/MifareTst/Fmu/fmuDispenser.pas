unit fmuDispenser;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  // This
  MifareLib_TLB, untPage, untUtil;

type
  TfmDispenser = class(TPage)
    btnEnableCardAccept: TButton;
    btnDisableCardAccept: TButton;
    btnReadStatus: TButton;
    btnHoldCard: TButton;
    btnReadLastAnswer: TButton;
    btnIssueCard: TButton;
    memData: TMemo;
    procedure btnEnableCardAcceptClick(Sender: TObject);
    procedure btnDisableCardAcceptClick(Sender: TObject);
    procedure btnReadStatusClick(Sender: TObject);
    procedure btnIssueCardClick(Sender: TObject);
    procedure btnHoldCardClick(Sender: TObject);
    procedure btnReadLastAnswerClick(Sender: TObject);
  end;

implementation

{$R *.DFM}


procedure TfmDispenser.btnEnableCardAcceptClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.EnableCardAccept;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDispenser.btnDisableCardAcceptClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DisableCardAccept;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDispenser.btnReadStatusClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ReadStatus;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDispenser.btnIssueCardClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.IssueCard;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDispenser.btnHoldCardClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.HoldCard;
  finally
    EnableButtons(True);
  end;
end;

(*

Код ответа считывателя

1 ACK
2 NAK
3 STX - данные
4 STX – данные, но ошибка CRCC
5 DLE
6 EOT
7 таймаут закончился, но считыватель не ответил

*)

procedure TfmDispenser.btnReadLastAnswerClick(Sender: TObject);
var
  Line: string;
  Code: Integer;
begin
  EnableButtons(False);
  try
    memData.Clear;
    Driver.ReadLastAnswer;
    if Length(Driver.BlockData) > 0 then
    begin
      Line := '';
      Code := Ord(Driver.BlockData[1]);
      case Code of
        1: Line := 'ACK';
        2: Line := 'NAK';
        3: Line := 'STX + данные';
        4: Line := 'STX + данные, ошибка CRC';
        5: Line := 'DLE';
        6: Line := 'EOT';
        7: Line := 'таймаут закончился, но считыватель не ответил';
      else
        Line := '';
      end;
      memData.Lines.Add(Driver.BlockDataHex);
      Line := IntToStr(Code) + ', ' + Line;
      memData.Lines.Add(Line);
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
