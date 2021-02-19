unit fmuRequest;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, Spin;

type
  TfmRequest = class(TPage)
    btnRequestAll: TButton;
    lblATQ: TLabel;
    edtATQ: TEdit;
    btnRequestIdle: TButton;
    btnPiccHalt: TButton;
    lblBitCount: TLabel;
    lblUIDHex2: TLabel;
    lblUIDHex: TLabel;
    edtUIDHex2: TEdit;
    edtUIDHex: TEdit;
    btnPiccAnticoll: TButton;
    btnPiccSelect: TButton;
    Bevel1: TBevel;
    lblSAK: TLabel;
    edtSAK: TEdit;
    Bevel2: TBevel;
    lblCardType: TLabel;
    edtCardType: TEdit;
    seBitCount: TSpinEdit;
    procedure btnRequestAllClick(Sender: TObject);
    procedure btnRequestIdleClick(Sender: TObject);
    procedure btnPiccHaltClick(Sender: TObject);
    procedure btnPiccAnticollClick(Sender: TObject);
    procedure btnPiccSelectClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmRequest }

procedure TfmRequest.btnRequestAllClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    if Driver.RequestAll = 0 then
    begin
      edtATQ.Text := IntToStr(Driver.ATQ);
      edtCardType.Text := Driver.CardDescription;
    end else
    begin
      edtATQ.Clear;
      edtCardType.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmRequest.btnRequestIdleClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    if Driver.RequestIdle = 0 then
    begin
      edtATQ.Text := IntToStr(Driver.ATQ);
      edtCardType.Text := Driver.CardDescription;
    end else
    begin
      edtATQ.Clear;
      edtCardType.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmRequest.btnPiccHaltClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PiccHalt;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmRequest.btnPiccAnticollClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BitCount := seBitCount.Value;
    Driver.UIDHex := edtUIDHex2.Text;
    if Driver.PiccAnticoll = 0 then
    begin
      edtUIDHex.Text := Driver.UIDHex;
    end else
    begin
      edtUIDHex.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmRequest.btnPiccSelectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UIDHex := edtUIDHex.Text;
    if Driver.PiccSelect = 0 then
    begin
      edtSAK.Text := IntTostr(Driver.SAK);
    end else
    begin
      edtSAK.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
