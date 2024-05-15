unit fmuMain;

interface

uses
  // VCL
  Windows, StdCtrls, Controls, ExtCtrls, Classes, Forms, SysUtils,
  Registry, ComCtrls,
  // This
  BaseForm, MifareLib_TLB, untPage, fmuAbout, fmuConnection, fmuRequest,
  fmuActivate, fmuAuth, fmuData, fmuReaderParams, fmuReaderMemory, untVInfo,
  fmuConnectionTest, fmuPoll, fmuLedControl, fmuValueBlock, fmuTest,
  fmuUltraLight, fmuUltraLightC, fmuMikleSoft, fmuSAMVersion, fmuSAMAuth,
  fmuSAMCommands, fmuMifarePlusParams, fmuMifarePlusPerso, fmuMifarePlusAuth,
  fmuMifarePlusValue, fmuMifarePlusData, fmuUltraLightCData, fmuDispenser,
  fmuMifarePlusAuthSL2, fmuCardEmission, fmuMifarePlusSelectSlot;

type
  { TfmMain }

  TfmMain = class(TBaseForm)
    pnlPage: TPanel;
    ListBox: TListBox;
    edtResult: TEdit;
    lblResult: TLabel;
    btnProperties: TButton;
    lblTime: TLabel;
    edtTime: TEdit;
    Bevel: TBevel;
    btnAbout: TButton;
    btnClose: TButton;
    edtTxData: TEdit;
    lblTxData: TLabel;
    edtRxData: TEdit;
    lblRxData: TLabel;
    procedure ListBoxClick(Sender: TObject);
    procedure btnPropertiesClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FPages: TPages;
    FLastPage: TForm;
    FDriver: TMifareDrv;

    procedure CreatePages;
    procedure UpdateCommands;
    procedure ShowPage(Page: TPage);
    procedure ShowResult(Sender: TObject);
    function IndexToPage(Index: Integer): TPage;
    procedure AddPage(PageClass: TPageClass);

    property Pages: TPages read FPages;
    property Driver: TMifareDrv read FDriver;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  fmMain: TfmMain;

implementation

uses fmuCardData;

{$R *.DFM}

{ TfmMain }

constructor TfmMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDriver := TMifareDrv.Create(Self);
  FPages := TPages.Create(Driver);
  FPages.OnShowResult := ShowResult;
  CreatePages;
  UpdateCommands;
  Show;
  if btnProperties.CanFocus then
    btnProperties.SetFocus;
end;

destructor TfmMain.Destroy;
begin
  FPages.Free;
  FDriver.Free;
  inherited Destroy;
end;

procedure TfmMain.ShowResult(Sender: TObject);
begin
  edtTime.Text := IntToStr(OperationTime);
  edtResult.Text := Format('%d,  %s',
    [Driver.ResultCode, Driver.ResultDescription]);
  edtTxData.Text := Driver.TxDataHex;
  edtRxData.Text := Driver.RxDataHex;
end;

procedure TfmMain.AddPage(PageClass: TPageClass);
var
  Page: TPage;
begin
  Page := PageClass.Create(nil);
  Page.SetOwner(Pages);
  Page.BorderStyle := bsNone;
  Page.Parent := pnlPage;
end;

procedure TfmMain.CreatePages;
begin
  AddPage(TfmConnection);
  AddPage(TfmConnectionTest);
  AddPage(TfmReaderParams);
  AddPage(TfmReaderMemory);
  AddPage(TfmLedControl);
  AddPage(TfmRequest);
  AddPage(TfmActivate);
  AddPage(TfmAuth);
  AddPage(TfmData);
  AddPage(TfmValueBlock);

  AddPage(TfmPoll);
  AddPage(TfmTest);
  AddPage(TfmMikleSoft);
  AddPage(TfmCardData);
  AddPage(TfmUltraLight);
  AddPage(TfmUltraLightC);
  AddPage(TfmUltraLightCData);
  AddPage(TfmSAMVersion);
  AddPage(TfmSAMCommands);
  AddPage(TfmSAMAuth);

  AddPage(TfmMifarePlusParams);
  AddPage(TfmMifarePlusPerso);
  AddPage(TfmMifarePlusAuth);
  AddPage(TfmMifarePlusAuthSL2);
  AddPage(TfmMifarePlusValue);
  AddPage(TfmMifarePlusData);
  AddPage(TfmMifarePlusSelectSlot);
  AddPage(TfmDispenser);
  AddPage(TfmCardEmission);
end;

procedure TfmMain.UpdateCommands;
var
  i: Integer;
  PageName: string;
begin
  with ListBox do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      for i := 0 to FPages.Count-1 do
      begin
        PageName := Format(' %d. %s', [i+1, FPages[i].Caption]);
        Items.Add(PageName);
      end;
    finally
      Items.EndUpdate;
    end;
  end;
  if FPages.Count > 0 then
  begin
    ListBox.ItemIndex := 0;
    ShowPage(IndexToPage(0));
  end;
end;

procedure TfmMain.ShowPage(Page: TPage);
begin
  if Page <> FLastPage then
  begin
    if Page <> nil then
    begin
      Page.UpdatePage;
      Page.Align := alClient;
      Page.Visible := True;
      Page.Width := pnlPage.ClientWidth;
    end;
    if FLastPage <> nil then
      FLastPage.Visible := False;
    FLastPage := Page;
  end;
end;

function TfmMain.IndexToPage(Index: Integer): TPage;
begin
  if (Index < 0) or (Index >= FPages.Count) then
    raise Exception.Create('Invalid page index');
  Result := FPages[Index];
end;

// Events

procedure TfmMain.ListBoxClick(Sender: TObject);
begin                
  ShowPage(IndexToPage(ListBox.ItemIndex));
end;

procedure TfmMain.btnPropertiesClick(Sender: TObject);
begin
  Driver.ShowProperties;
end;

procedure TfmMain.btnAboutClick(Sender: TObject);
var
  TstVersion: string;
  DrvVersion: string;
begin
  TstVersion := 'Версия теста: ' + GetFileVersionInfoStr;
  DrvVersion := 'Версия драйвера: ' + Driver.Version;
  ShowAboutBox(Handle, 'Тест драйвера считывателей Mifare', [TstVersion, DrvVersion]);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Caption := Caption + ' ' + GetFileVersionInfoStr;
end;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
