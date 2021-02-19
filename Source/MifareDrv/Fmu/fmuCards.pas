unit fmuCards;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, ExtCtrls, StdCtrls,
  // This
  MifareLib_TLB;

type
  { TfmCards }

  TfmCards = class(TForm)
    ListView: TListView;
    btnOpen: TButton;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FDriver: IMifareDrv;
    procedure OpenCard;
    procedure UpdatePage;
    procedure Check(ResultCode: Integer);
  end;

procedure ShowCardsDialog(AParentWnd: HWND; ADriver: IMifareDrv);

implementation

{$R *.DFM}

procedure ShowCardsDialog(AParentWnd: HWND; ADriver: IMifareDrv);
var
  fm: TfmCards;
begin
  fm := TfmCards.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, AParentWnd);
    fm.FDriver := ADriver;
    fm.UpdatePage;
    fm.ShowModal;
  finally
    fm.Free;
  end;
end;

{ TfmCards }

procedure TfmCards.UpdatePage;
var
  i: Integer;
  ListItem: TListItem;
begin
(*
  ListView.Items.BeginUpdate;
  try
    ListView.Items.Clear;
    Check(Driver.FindCards);
    for i := 0 to Driver.CardsCount-1 do
    begin
      Driver.CardIndex := 0;
      Check(Driver.GetCardParams);
      ListItem := ListView.Items.Add;
      ListItem.Text := IntToStr(i+1);
      ListItem.SubItems.Add(Driver.UIDHex);
      ListItem.SubItems.Add(Driver.CardDescription);
    end;
    // Выделяем первую таблицу
    if ListView.Items.Count > 0 then
    begin
      ListItem := ListView.Items[0];
      ListItem.Selected := True;
      ListItem.Focused := True;
    end;
  finally
    ListView.Items.EndUpdate;
  end;
*)
end;

procedure TfmCards.OpenCard;
var
  ListItem: TListItem;
  CardNumber: Integer;
begin
(*
  ListItem := ListView.Selected;
  if ListItem <> nil then
  begin
    Driver.CardIndex :=
      try
        if ECR.ReadCard(Card) then
        begin
          if Card.RowCount = 1 then
            ShowVCardDlg(Handle, ECR, Card)
          else
            ShowCardDlg(Handle, ECR, Card);
        end;
      except
        on E: Exception do HandleException(E);
      end;
    end;
  end;
*)
end;

// Events

procedure TfmCards.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmCards.btnOpenClick(Sender: TObject);
begin
  OpenCard;
end;

procedure TfmCards.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then OpenCard;
end;

procedure TfmCards.FormCreate(Sender: TObject);
var
  FilePath: string;
begin
(*
  FilePath := ExtractFilePath(ParamStr(0));
  OpenDialog.InitialDir := FilePath;
  SaveDialog.InitialDir := FilePath;
*)  
end;

procedure TfmCards.Check(ResultCode: Integer);
begin

end;

end.

