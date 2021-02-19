unit fmuParams;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls,
  // Tnt
  TntComCtrls, TntStdCtrls, TntExtCtrls,
  // This
  BaseForm, ParamPage, MifareLib_TLB, fmuLogParams, fmuBlockParams,
  fmuPollParams;

type
  { TfmParams }

  TfmParams = class(TBaseForm)
    btnOK: TTntButton;
    btnCancel: TTntButton;
    pnlData: TTntPanel;
    ListBox: TTntListBox;
    Bevel1: TTntBevel;
    btnSetDefault: TTntButton;
    procedure ListBoxClick(Sender: TObject);
    procedure btnSetDefaultClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FIndex: Integer;
    FDriver: IMifareDrv3;
    FPages: TParamPages;
    procedure UpdatePages;
    procedure ShowPage(Index: Integer);
    procedure AddPage(PageClass: TParamPageClass);
    property Pages: TParamPages read FPages;
  public
    constructor CreatePage(AOwner: TComponent; ADriver: IMifareDrv3);
    destructor Destroy; override;

    procedure UpdatePage;
    procedure UpdateObject;
  end;

function ShowParamsDlg(AParentWnd: HWND; ADriver: IMifareDrv3): Boolean;

implementation

{$R *.DFM}

function ShowParamsDlg(AParentWnd: HWND; ADriver: IMifareDrv3): Boolean;
var
  fm: TfmParams;
begin
  fm := TfmParams.CreatePage(nil, ADriver);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, AParentWnd);
    fm.UpdatePage;
    Result := fm.ShowModal = mrOK;
    if Result then
    begin
      fm.UpdateObject;
    end;
  finally
    fm.Free;
  end;
end;

{ TfmParams }

constructor TfmParams.CreatePage(AOwner: TComponent; ADriver: IMifareDrv3);
begin
  inherited Create(AOwner);
  FDriver := ADriver;
  FIndex := -1;
  FPages := TParamPages.Create(ADriver);
  AddPage(TfmLogParams);
  AddPage(TfmBlockParams);
  AddPage(TfmPollParams);

  UpdatePages;
  ShowPage(0);
end;

destructor TfmParams.Destroy;
begin
  FPages.Free;
  inherited Destroy;
end;

procedure TfmParams.AddPage(PageClass: TParamPageClass);
var
  Page: TParamPage;
begin
  Page := PageClass.Create(nil);
  Page.SetOwner(Pages);
  Page.BorderStyle := bsNone;
  Page.Parent := pnlData;
  Page.Align := alClient;

  if Page.Width > pnlData.Width then
    Width := Width + Page.Width - pnlData.Width;
  if Page.Height > pnlData.Height then
    Height := Height + Page.Height - pnlData.Height;

  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
end;

procedure TfmParams.UpdatePages;
var
  i: Integer;
  PageCaption: string;
begin
  with ListBox do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      for i := 0 to Pages.Count-1 do
      begin
        PageCaption := Pages[i].Caption;
        Items.Add(PageCaption);
      end;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TfmParams.ShowPage(Index: Integer);
var
  Page: TParamPage;
begin
  if Index <> FIndex then
  begin
    if (Index >= 0)and(Index < Pages.Count) then
    begin
      Page := Pages[Index];
      Page.Align := alClient;
      Page.Visible := True;
      Page.Width := pnlData.ClientWidth;
      Page.Height := pnlData.ClientHeight;
      ListBox.ItemIndex := Index;
    end;
    if (FIndex >= 0)and(FIndex < Pages.Count) then
    begin
      Pages[FIndex].Visible := False;
    end;
    FIndex := Index;
  end;
end;

procedure TfmParams.UpdatePage;
begin
  Pages.UpdatePage;
end;

procedure TfmParams.UpdateObject;
begin
  Pages.UpdateObject;
end;

procedure TfmParams.ListBoxClick(Sender: TObject);
begin
  ShowPage(ListBox.ItemIndex);
  //FDriver.ParamsPageIndex := ListBox.ItemIndex; { !!! }
end;

procedure TfmParams.btnSetDefaultClick(Sender: TObject);
begin
  Pages[FIndex].SetDefaults;
end;

procedure TfmParams.btnOKClick(Sender: TObject);
begin
  UpdateObject;
  FDriver.SaveParams;
  ModalResult := mrOK;
end;

end.

