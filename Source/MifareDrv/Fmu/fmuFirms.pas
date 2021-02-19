unit fmuFirms;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ImgList, Buttons,
  // This
  BaseForm, untDriver, CardFirm, CardApp, fmuFirm, fmuApp, untTypes, Menus;

type
  { TfmFirms }

  TfmFirms = class(TBaseForm)
    btnClose: TButton;
    ImageList: TImageList;
    TreeView: TTreeView;
    btnAddFirm: TBitBtn;
    btnDelete: TBitBtn;
    btnAddApp: TBitBtn;
    PopupMenu: TPopupMenu;
    miEdit: TMenuItem;
    miDelete: TMenuItem;
    miAddFirm: TMenuItem;
    miAddApp: TMenuItem;
    btnEdit: TBitBtn;
    N1: TMenuItem;
    procedure btnCloseClick(Sender: TObject);
    procedure EditClick(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AddFirmClick(Sender: TObject);
    procedure AddAppClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure TreeViewExpanded(Sender: TObject; Node: TTreeNode);
    procedure TreeViewCollapsed(Sender: TObject; Node: TTreeNode);
  private
    FDriver: TDriver;
    procedure AddApp;
    procedure AddFirm;
    procedure EditItem;
    procedure DeleteItem;
    procedure UpdatePage;
    function AddAppNode(ParentNode: TTreeNode; App: TCardApp): TTreeNode;
    function AddFirmNode(ParentNode: TTreeNode; Firm: TCardFirm): TTreeNode;
  end;

procedure ShowFirmsDialog(ParentWnd: HWND; Driver: TDriver);

implementation

{$R *.DFM}

procedure ShowFirmsDialog(ParentWnd: HWND; Driver: TDriver);
var
  fm: TfmFirms;
begin
  fm := TfmFirms.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, ParentWnd);
    fm.FDriver := Driver;
    fm.UpdatePage;
    fm.ShowModal;
  finally
    fm.Free;
  end;
end;

{ TfmFirm }

function TfmFirms.AddFirmNode(ParentNode: TTreeNode; Firm: TCardFirm): TTreeNode;
begin
  Result := TreeView.Items.AddChild(ParentNode, Firm.DisplayText);
  Result.Data := Firm;
  Result.ImageIndex := 0;
  Result.SelectedIndex := 0;
end;

function TfmFirms.AddAppNode(ParentNode: TTreeNode; App: TCardApp): TTreeNode;
begin
  Result := TreeView.Items.AddChild(ParentNode, App.DisplayText);
  Result.Data := App;
  Result.ImageIndex := 1;
  Result.SelectedIndex := 1;
end;

procedure TfmFirms.UpdatePage;
var
  i: Integer;
  j: Integer;
  Firm: TCardFirm;
  Firms: TCardFirms;
  TreeNode: TTreeNode;
begin
  Firms := FDriver.Directory.Firms;
  TreeView.Items.Clear;

  TreeView.Items.BeginUpdate;
  try
    for i := 0 to Firms.Count - 1 do
    begin
      Firm := Firms[i];
      TreeNode := AddFirmNode(nil, Firm);
      for j := 0 to Firm.CardApps.count-1 do
      begin
        AddAppNode(TreeNode, Firm.CardApps[j])
      end;
      TreeNode.Expand(False);
    end;
  finally
    TreeView.Items.EndUpdate;
  end;
end;

procedure TfmFirms.AddApp;
var
  App: TCardApp;
  Firm: TCardFirm;
  TreeNode: TTreeNode;
begin
  TreeNode := TreeView.Selected;
  if TreeNode = nil then Exit;

  while TreeNode.Parent <> nil do
    TreeNode := TreeNode.Parent;

  Firm := TCardFirm(TreeNode.Data);
  if Firm = nil then Exit;

  if ShowAppDialog(Handle, dtAdd, Firm.CardApps) then
  begin
    App := Firm.CardApps[Firm.CardApps.Index];
    TreeNode := AddAppNode(TreeNode, App);
    TreeNode.Selected := True;
    TreeNode.Focused := True;
  end;
end;

procedure TfmFirms.AddFirm;
var
  Firm: TCardFirm;
  Firms: TCardFirms;
  TreeNode: TTreeNode;
begin
  Firms := FDriver.Directory.Firms;
  if ShowFirmDialog(Handle, dtAdd, Firms) then
  begin
    Firm := Firms[Firms.Index];
    TreeNode := AddFirmNode(nil, Firm);
    TreeNode.Selected := True;
    TreeNode.Focused := True;
  end;
end;

procedure TfmFirms.EditItem;
var
  Item: TObject;
  App: TCardApp;
  Apps: TCardApps;
  Firm: TCardFirm;
  Firms: TCardFirms;
  TreeNode: TTreeNode;
begin
  TreeNode := TreeView.Selected;
  if TreeNode <> nil then
  begin
    Item := TObject(TreeNode.Data);
    // Фирма
    if Item is TCardFirm then
    begin
      Firm := Item as TCardFirm;
      Firms := Firm.Owner;
      Firms.Index := TreeNode.Index;
      if ShowFirmDialog(Handle, dtEdit, Firms) then
      begin
        Firm := Firms[Firms.Index];
        TreeNode.Text := Firm.DisplayText;
      end;
    end;
    // Приложение
    if Item is TCardApp then
    begin
      App := Item as TCardApp;
      Apps := App.Owner;
      Apps.Index := TreeNode.Index;
      if ShowAppDialog(Handle, dtEdit, Apps) then
      begin
        App := Apps[Apps.Index];
        TreeNode.Text := App.DisplayText;
      end;
    end;
  end;
end;

procedure TfmFirms.DeleteItem;
var
  TreeNode: TTreeNode;
begin
  TreeNode := TreeView.Selected;
  if TreeNode <> nil then
  begin
    TObject(TreeNode.Data).Free;
    TreeNode.Delete;
  end;
end;

procedure TfmFirms.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmFirms.EditClick(Sender: TObject);
begin
  EditItem;
end;

procedure TfmFirms.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then EditItem;
  if Key = VK_DELETE then DeleteItem;
end;

procedure TfmFirms.AddFirmClick(Sender: TObject);
begin
  AddFirm;
end;

procedure TfmFirms.AddAppClick(Sender: TObject);
begin
  AddApp;
end;

procedure TfmFirms.DeleteClick(Sender: TObject);
begin
  DeleteItem;
end;

procedure TfmFirms.TreeViewExpanded(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := 3;
  Node.SelectedIndex := 3;
end;

procedure TfmFirms.TreeViewCollapsed(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;
end;

end.

