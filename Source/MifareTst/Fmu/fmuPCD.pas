unit fmuPCD;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, Spin;

type
  TfmPCD = class(TPage)
    btnPcdGetSerialNumber: TButton;
    btnPcdGetFwVersion: TButton;
    Memo: TMemo;
    btnPcdGetRicVersion: TButton;
    lblRfResetTime: TLabel;
    btnPcdRfReset: TButton;
    btnGetOnlineStatus: TButton;
    btnPcdReset: TButton;
    btnPcdBeep: TButton;
    lblBeepTone: TLabel;
    btnSleepMode: TButton;
    seRfResetTime: TSpinEdit;
    seBeepTone: TSpinEdit;
    procedure btnPcdGetSerialNumberClick(Sender: TObject);
    procedure btnPcdGetFwVersionClick(Sender: TObject);
    procedure btnPcdGetRicVersionClick(Sender: TObject);
    procedure btnPcdRfResetClick(Sender: TObject);
    procedure btnGetOnlineStatusClick(Sender: TObject);
    procedure btnPcdResetClick(Sender: TObject);
    procedure btnPcdBeepClick(Sender: TObject);
    procedure btnSleepModeClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmPCD.btnPcdGetSerialNumberClick(Sender: TObject);
var
  S: string;
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.PcdGetSerialNumber = 0 then
    begin
      //S := 'Серийный номер cчитывателя: ' + Driver.UID;
      //Memo.Lines.Add(S);

      S := 'Серийный номер cчитывателя, Hex: ' + Driver.UIDHex;
      Memo.Lines.Add(S);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPCD.btnPcdGetFwVersionClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.PcdGetFwVersion = 0 then
    begin
      Memo.Lines.Add(Driver.PcdFWVersion);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPCD.btnPcdGetRicVersionClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.PcdGetRicVersion = 0 then
    begin
      Memo.Lines.Add(Driver.PcdRicVersion);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPCD.btnPcdRfResetClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Driver.RfResetTime := seRfResetTime.Value;
    Driver.PcdRfReset;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPCD.btnGetOnlineStatusClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Driver.PortOpened;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPCD.btnPcdResetClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PcdReset;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPCD.btnPcdBeepClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BeepTone := seBeepTone.Value;
    Driver.PcdBeep;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPCD.btnSleepModeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SleepMode;
  finally
    EnableButtons(True);
  end;
end;

end.
