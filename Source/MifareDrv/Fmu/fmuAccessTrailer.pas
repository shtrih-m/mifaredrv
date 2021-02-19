unit fmuAccessTrailer;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Registry,
  // This
  untConst, untUtil;

type
  { TfmAccessTrailer }

  TfmAccessTrailer = class(TForm)
    Grid: TStringGrid;
    Bevel1: TBevel;
    btnCancel: TButton;
    btnOK: TButton;
    lblKeyA: TLabel;
    lblKeyB: TLabel;
    lblAccessBits: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    procedure UpdatePage(Mode: Integer);
    procedure UpdateObject(var Mode: Integer);
  end;

function ShowTrailerAccessDlg(AParentWnd: HWND; var Mode: Integer): Boolean;

implementation

{$R *.DFM}

function ShowTrailerAccessDlg(AParentWnd: HWND; var Mode: Integer): Boolean;
var
  fm: TfmAccessTrailer;
begin
  fm := TfmAccessTrailer.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, AParentWnd);
    fm.UpdatePage(Mode);
    Result := fm.ShowModal = mrOK;
    if Result then
      fm.UpdateObject(Mode);
  finally
    fm.Free;
  end;
end;

{ TfmAccessTrailer }

procedure TfmAccessTrailer.FormCreate(Sender: TObject);

  procedure AddRow(S: array of string);
  var
    i: Integer;
  begin
    for i := 0 to Length(S)-1 do
      Grid.Cells[i, Grid.RowCount-1] := S[i];
    Grid.RowCount := Grid.RowCount + 1;
  end;

const
  KeyA = 'ключ А';
  KeyB = 'ключ Б';
  Read = 'чтение';
  Write = 'запись';
  Never = 'никогда';
  KeyAB = 'ключ А и Б';
  KeyBRead = 'Ключ Б читается';
  RWblock = 'чтение/запись';
  VBlock = 'операции со значением';
begin
  // количество столбцов
  Grid.RowCount := 0;
  Grid.ColCount := 10;
  //
  AddRow(['C1', 'C2', 'C3', Read, Write, Read, Write, Read, Write, 'Описание']);
  AddRow(['0', '0', '0', Never, KeyA, KeyA, Never, KeyA, KeyA, KeyBRead]);
  AddRow(['0', '1', '0', Never, Never, KeyA, Never, KeyA, Never, KeyBRead]);
  AddRow(['1', '0', '0', Never, KeyB, KeyAB, Never, Never, KeyB, '']);
  AddRow(['1', '1', '0', Never, Never, KeyAB, Never, Never, Never, '']);
  AddRow(['0', '0', '1', Never, KeyA, KeyA, KeyA, KeyA, KeyA, KeyBRead]);
  AddRow(['0', '1', '1', Never, KeyB, KeyAB, KeyB, Never, KeyB, '']);
  AddRow(['1', '0', '1', Never, Never, KeyAB, KeyB, Never, Never, '']);
  AddRow(['1', '1', '1', Never, Never, KeyAB, Never, Never, Never, '']);
  Grid.RowCount := Grid.RowCount - 1;
  // ширина
  Grid.ColWidths[0] := 20;
  Grid.ColWidths[1] := 20;
  Grid.ColWidths[2] := 20;
  Grid.ColWidths[3] := 60;
  Grid.ColWidths[4] := 60;
  Grid.ColWidths[5] := 60;
  Grid.ColWidths[6] := 60;
  Grid.ColWidths[7] := 60;
  Grid.ColWidths[8] := 60;
  Grid.ColWidths[9] := 90;
  Grid.FixedRows := 1;
end;

procedure TfmAccessTrailer.UpdateObject(var Mode: Integer);
begin
  Mode := Grid.Row;
end;

procedure TfmAccessTrailer.UpdatePage(Mode: Integer);
begin
  if (Mode > 0) and (Mode < Grid.RowCount) then
    Grid.Row := Mode;
end;

procedure TfmAccessTrailer.GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
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
