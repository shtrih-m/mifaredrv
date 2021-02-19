unit fmuReaderParams;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, Spin;

type
  { TfmReaderParams }

  TfmReaderParams = class(TPage)
    gsParams: TGroupBox;
    lblRfResetTime: TLabel;
    lblBeepTone: TLabel;
    btnPcdGetSerialNumber: TButton;
    btnPcdGetFwVersion: TButton;
    Memo: TMemo;
    btnPcdGetRicVersion: TButton;
    btnPcdRfReset: TButton;
    btnPortOpened: TButton;
    btnPcdReset: TButton;
    btnPcdBeep: TButton;
    btnSleepMode: TButton;
    seRfResetTime: TSpinEdit;
    seBeepTone: TSpinEdit;
    edtPortStatus: TEdit;
    lblPortStatus: TLabel;
    procedure btnPcdGetSerialNumberClick(Sender: TObject);
    procedure btnPcdGetFwVersionClick(Sender: TObject);
    procedure btnPcdGetRicVersionClick(Sender: TObject);
    procedure btnPcdRfResetClick(Sender: TObject);
    procedure btnPortOpenedClick(Sender: TObject);
    procedure btnPcdResetClick(Sender: TObject);
    procedure btnPcdBeepClick(Sender: TObject);
    procedure btnSleepModeClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmReaderParams.btnPcdGetSerialNumberClick(Sender: TObject);
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

procedure TfmReaderParams.btnPcdGetFwVersionClick(Sender: TObject);
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

procedure TfmReaderParams.btnPcdGetRicVersionClick(Sender: TObject);
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

procedure TfmReaderParams.btnPcdRfResetClick(Sender: TObject);
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

procedure TfmReaderParams.btnPortOpenedClick(Sender: TObject);

  function PortStateToStr(Value: Integer): string;
  begin
    if Value = 0 then Result := 'порт открыт'
    else Result := 'порт закрыт';
  end;

begin
  EnableButtons(False);
  try
    Memo.Clear;
    edtPortStatus.Text := IntToStr(Driver.PortOpened) + ', ' +
      PortStateToStr(Driver.PortOpened);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReaderParams.btnPcdResetClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PcdReset;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReaderParams.btnPcdBeepClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BeepTone := seBeepTone.Value;
    Driver.PcdBeep;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReaderParams.btnSleepModeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SleepMode;
  finally
    EnableButtons(True);
  end;
end;

end.
