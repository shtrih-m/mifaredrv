unit fmuMikleSoft;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, StringUtils;

type
  { TfmMikleSoft }

  TfmMikleSoft = class(TPage)
    lblATQ: TLabel;
    edtATQ: TEdit;
    btnMksFindCard: TButton;
    edtUIDHex: TEdit;
    lblUID: TLabel;
    edtCardATQ: TEdit;
    lblCardATQ: TLabel;
    btnMksReopen: TButton;
    Bevel1: TBevel;
    btnMksWriteCatalog: TButton;
    btnMksReadCatalog: TButton;
    Memo: TMemo;
    procedure btnMksFindCardClick(Sender: TObject);
    procedure btnMksReadCatalogClick(Sender: TObject);
    procedure btnMksWriteCatalogClick(Sender: TObject);
    procedure btnMksReopenClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmMikleSoft }

procedure TfmMikleSoft.btnMksFindCardClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.CardATQ := HexToInt(edtCardATQ.Text);
    if Driver.MksFindCard = 0 then
    begin
      edtATQ.Text := IntToStr(Driver.ATQ);
      edtUIDHex.Text := Driver.UIDHex;
    end else
    begin
      edtATQ.Clear;
      edtUIDHex.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMikleSoft.btnMksReadCatalogClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.MksReadCatalog = 0 then
    begin
      Memo.Lines.Text := StrToHex8(Driver.Data);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMikleSoft.btnMksWriteCatalogClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Data := HexToStr(Memo.Lines.Text);
    Driver.MksWriteCatalog;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMikleSoft.btnMksReopenClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.MksReopen;
  finally
    EnableButtons(True);
  end;
end;

end.
