unit fmuAccessData;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Registry,
  // This
  untConst, untUtil;

type
  { TfmAccessData }

  TfmAccessData = class(TForm)
    Grid: TStringGrid;
    Bevel1: TBevel;
    btnCancel: TButton;
    btnOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    procedure UpdatePage(Mode: Integer);
    procedure UpdateObject(var Mode: Integer);
  end;

function ShowDataAccessDlg(AParentWnd: HWND; BlockNumber: Integer;
  var Mode: Integer): Boolean;

implementation

{$R *.DFM}

function ShowDataAccessDlg(AParentWnd: HWND; BlockNumber: Integer;
  var Mode: Integer): Boolean;
var
  fm: TfmAccessData;
begin
  fm := TfmAccessData.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, AParentWnd);
    fm.Caption := Format('���� ������ %d', [BlockNumber]);
    fm.UpdatePage(Mode);
    Result := fm.ShowModal = mrOK;
    if Result then
      fm.UpdateObject(Mode);
  finally
    fm.Free;
  end;
end;

{ TfmAccessData }

procedure TfmAccessData.UpdateObject(var Mode: Integer);
begin
  Mode := Grid.Row;
end;

procedure TfmAccessData.UpdatePage(Mode: Integer);
begin
  if (Mode > 0) and (Mode < Grid.RowCount) then
    Grid.Row := Mode;
end;

procedure TfmAccessData.FormCreate(Sender: TObject);

  procedure AddRow(S: array of string);
  var
    i: Integer;
  begin
    for i := 0 to Length(S)-1 do
      Grid.Cells[i, Grid.RowCount-1] := S[i];
    Grid.RowCount := Grid.RowCount + 1;
  end;

const
  KeyA = '���� �';
  KeyB = '���� �';
  Never = '�������';
  KeyAB = '���� � � �';
  RWblock = '������/������';
  VBlock = '�������� �� ���������';
begin
  // ���������� ��������
  Grid.RowCount := 0;
  Grid.ColCount := 8;
  //
  AddRow(['C1', 'C2', 'C3', '������', '������', '���������', '���������', '��������']);
  AddRow(['0', '0', '0', KeyAB, KeyAB, KeyAB, KeyAB, '�������� �� ���������']);
  AddRow(['0', '1', '0', KeyAB, Never, Never, Never, RWblock]);
  AddRow(['1', '0', '0', KeyAB, KeyB, Never, Never, RWblock]);
  AddRow(['1', '1', '0', KeyAB, KeyB, KeyB, KeyAB, Vblock]);
  AddRow(['0', '0', '1', KeyAB, Never, Never, KeyAB, Vblock]);
  AddRow(['0', '1', '1', KeyB, KeyB, Never, Never, RWblock]);
  AddRow(['1', '0', '1', KeyB, Never, Never, Never, RWblock]);
  AddRow(['1', '1', '1', Never, Never, Never, Never, RWblock]);
  Grid.RowCount := Grid.RowCount - 1;
  // ������
  Grid.ColWidths[0] := 20;
  Grid.ColWidths[1] := 20;
  Grid.ColWidths[2] := 20;
  Grid.ColWidths[3] := 80;
  Grid.ColWidths[4] := 80;
  Grid.ColWidths[5] := 80;
  Grid.ColWidths[6] := 80;
  Grid.ColWidths[7] := 130;
  Grid.FixedRows := 1;
end;

procedure TfmAccessData.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  LeftAlign: Integer;
begin
  Grid.Canvas.FillRect(Rect);
  if ARow = 0 then
    LeftAlign := (Rect.Right - Rect.Left -
      Grid.Canvas.TextExtent(Grid.Cells[ACol, ARow]).Cx) div 2
  else
    LeftAlign := 2;
  Grid.Canvas.TextOut(Rect.Left+ LeftAlign, Rect.Top+4,Grid.Cells[ACol, ARow]);
end;

end.
