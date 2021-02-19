unit fmuUltraLightCLock1;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  // This
  untUtil;

type
  TfmUltraLightCLock1 = class(TForm)
    ListView: TListView;
    Bevel1: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    btnReset: TButton;
    lblValue: TLabel;
    edtValue: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    Value1: Integer;
    Value2: Integer;
    procedure UpdatePage;
    procedure UpdateObject;
    procedure AddBit(BitNumber: Integer; const BitName: string);
  end;

var
  fmUltraLightCLock1: TfmUltraLightCLock1;

function ShowLockBytes1(var Value: Integer): Boolean;

implementation

function ShowLockBytes1(var Value: Integer): Boolean;
var
  fm: TfmUltraLightCLock1;
begin
  fm := TfmUltraLightCLock1.Create(Application);
  try
    fm.Value1 := Value;
    fm.Value2 := Value;
    fm.UpdatePage;
    Result := fm.ShowModal = mrOK;
    if Result then
    begin
      fm.UpdateObject;
      Value := fm.Value1;
    end;
  finally
    fm.Free;
  end;
end;

{$R *.dfm}

procedure TfmUltraLightCLock1.AddBit(BitNumber: Integer; const BitName: string);
var
  ListItem: TListItem;
begin
  ListItem := ListView.Items.Add;
  ListItem.Caption := IntToStr(BitNumber);
  ListItem.Data := Pointer(BitNumber);
  ListItem.SubItems.Add(BitName);
end;

procedure TfmUltraLightCLock1.FormCreate(Sender: TObject);
begin
  ListView.Items.BeginUpdate;
  try
    ListView.Items.Clear;

    AddBit(0, 'Блокировать локбит OTP');
    AddBit(1, 'Блокировать локбиты 9-4');
    AddBit(2, 'Блокировать локбиты 15-10');
    AddBit(3, 'Блокировать OTP');
    AddBit(4, 'Блокировать страницу 4');
    AddBit(5, 'Блокировать страницу 5');
    AddBit(6, 'Блокировать страницу 6');
    AddBit(7, 'Блокировать страницу 7');

    AddBit(8, 'Блокировать страницу 8');
    AddBit(9, 'Блокировать страницу 9');
    AddBit(10, 'Блокировать страницу 10');
    AddBit(11, 'Блокировать страницу 11');
    AddBit(12, 'Блокировать страницу 12');
    AddBit(13, 'Блокировать страницу 13');
    AddBit(14, 'Блокировать страницу 14');
    AddBit(15, 'Блокировать страницу 15');

    ListView.Items[0].Focused := True;
    ListView.Items[0].Selected := True;
  finally
    ListView.Items.EndUpdate;
  end;
end;

procedure TfmUltraLightCLock1.UpdatePage;
var
  i: Integer;
  BitNumber: Integer;
  ListItem: TListItem;
begin
  for i := 0 to ListView.Items.Count-1 do
  begin
    ListItem := ListView.Items[i];
    BitNumber := Integer(ListItem.Data);
    ListItem.Checked := TestBit(Value1, BitNumber);
  end;
end;

procedure TfmUltraLightCLock1.UpdateObject;
var
  i: Integer;
  BitNumber: Integer;
  ListItem: TListItem;
begin
  Value1 := 0;
  for i := 0 to ListView.Items.Count-1 do
  begin
    ListItem := ListView.Items[i];
    BitNumber := Integer(ListItem.Data);
    if ListItem.Checked then
      SetBit(Value1, BitNumber);
  end;
  edtValue.Text := Format('%.2x %.2x', [Lo(Value1), Hi(Value1)]);
end;

procedure TfmUltraLightCLock1.btnResetClick(Sender: TObject);
begin
  Value1 := Value2;
  UpdatePage;
end;

procedure TfmUltraLightCLock1.ListViewChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  UpdateObject;
end;

end.
