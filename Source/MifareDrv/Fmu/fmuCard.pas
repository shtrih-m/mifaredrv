unit fmuCard;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids,
  // This
  MifareLib_TLB, untUtil;

type
  { TfmCard }

  TfmCard = class(TForm)
    Grid: TStringGrid;
    btnRead: TBitBtn;
    btnSave: TBitBtn;
    btnLoad: TBitBtn;
    btnWrite: TBitBtn;
    btnClose: TBitBtn;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    lblCardInfo: TLabel;
    btnClear: TButton;
    procedure btnReadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    Driver: IMifareDrv;
    FButton: TWinControl;
    FLastColWidth: Integer;

    procedure UpdatePage;
    procedure UpdateGrid;
    procedure UpdateGridUL;
    procedure UpdateObject;
    procedure UpdateObjectMifare;
    procedure UpdateGridMifare;
    procedure UpdateLastColWidth;
    function GetCardInfo: string;
    function GetCardFileName: string;
    procedure Check(ResultCode: Integer);
    procedure EnableButtons(Value: Boolean);
    function GetBlockData(BlockNumber: Integer): string;
    procedure GridToBlocksUL;
  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure ShowCardDialog(ParentWnd: HWND; ADriver: IMifareDrv);

implementation

{$R *.DFM}

procedure ODS(const Data: string);
begin
  OutputDebugString(PChar(Data));
end;

procedure ShowCardDialog(ParentWnd: HWND; ADriver: IMifareDrv);
var
  fm: TfmCard;
begin
  fm := TfmCard.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, ParentWnd);
    fm.Driver := ADriver;
    ADriver.ReadCard;
    fm.UpdatePage;
    fm.ShowModal;
  finally
    fm.Free;
  end;
end;

{ TfmCard }

constructor TfmCard.Create(AOwner: TComponent);
var
  ModuleFileName: string;
begin
  inherited Create(AOwner);
  Grid.RowCount := 10;

  ModuleFileName := ExtractFilePath(GetModuleFileName);
  SaveDialog.InitialDir := ModuleFileName;
  OpenDialog.InitialDir := ModuleFileName;
end;

procedure TfmCard.UpdateLastColWidth;

  function GetGridWidth(Grid: TStringGrid): Integer;
  var
    i: Integer;
  begin
    with Grid do
    begin
      Result := GridLineWidth*(ColCount-1);
      for i := 0 to ColCount-1 do Result := Result + ColWidths[i];
    end;
  end;

var
  CellWidth: Integer;
begin
  CellWidth := Grid.ClientWidth - GetGridWidth(Grid);
  CellWidth := Grid.ColWidths[Grid.ColCount-1]+CellWidth;
  if CellWidth > FLastColWidth then
    Grid.ColWidths[Grid.ColCount-1] := CellWidth
  else
    Grid.ColWidths[Grid.ColCount-1] := FLastColWidth;
end;

procedure TfmCard.EnableButtons(Value: Boolean);
begin
  EnableFormButtons(Self, Value, FButton);
end;

function TfmCard.GetBlockData(BlockNumber: Integer): string;
begin
  Driver.BlockNumber := BlockNumber;
  Check(Driver.GetBlockParams);
  if Driver.BlockAuthResult <> 0 then
  begin
    Result := IntToStr(Driver.BlockAuthResult)
  end else
  begin
    if Driver.BlockReadResult <> 0 then
    begin
      Result := IntToStr(Driver.BlockReadResult)
    end else
    begin
      Result := Driver.BlockDataHex;
    end;
  end;
end;

// Карта MIFARE Ultralight

procedure TfmCard.UpdateGridUL;
var
  i: Integer;
begin
  Grid.ColCount := 2;
  Grid.RowCount := Driver.BlockCount + 1;
  Grid.Cells[0,0] := 'Страница';
  Grid.Cells[1,0] := 'Данные';
  Grid.ColWidths[1] := 200;
  for i := 0 to Driver.BlockCount-1 do
  begin
    Grid.Cells[0, i+1] := IntToStr(i);
    Grid.Cells[1, i+1] := GetBlockData(i);
  end;
end;

procedure TfmCard.GridToBlocksUL;
var
  i: Integer;
begin
  Driver.ClearBlocks;
  for i := 1 to Grid.RowCount-1 do
  begin
    Driver.BlockNumber := StrToInt(Grid.Cells[0, i]);
    Driver.BlockDataHex := Grid.Cells[1, i+1];
    Check(Driver.AddBlock);
  end;
end;

procedure TfmCard.UpdateGridMifare;
var
  S: string;
  i: Integer;
begin
  Grid.ColCount := 3;
  Grid.RowCount := Driver.BlockCount + 1;

  for i := 0 to Driver.BlockCount-1 do
  begin
    Driver.BlockNumber := i;
    Check(Driver.GetBlockParams);
    ODS(Driver.BlockDataHex);
    if Driver.BlockAuthResult <> 0 then
    begin
      S := IntToStr(Driver.BlockAuthResult)
    end else
    begin
      if Driver.BlockReadResult <> 0 then
      begin
        S := IntToStr(Driver.BlockReadResult)
      end else
      begin
        S := Driver.BlockDataHex;
      end;
    end;
    Grid.Cells[0, i+1] := IntToStr(Driver.BlockSectorNumber);
    Grid.Cells[1, i+1] := IntToStr(i);
    Grid.Cells[2, i+1] := S;
  end;
end;

function TfmCard.GetCardInfo: string;
begin
  case Driver.CardType of
    1: Result := Format('Тип карты: %s Номер: %s', [Driver.CardDescription, Driver.UIDHex]);
  else
    Result := '';
  end;
end;

procedure TfmCard.UpdateGrid;
begin
  case Driver.CardType of
    1: UpdateGridUL;
  else
    UpdateGridMifare;
  end;
end;

procedure TfmCard.UpdatePage;
begin
  if Driver.ResultCode = 0 then
  begin
    Grid.Visible := True;
    UpdateGrid;
    lblCardInfo.Caption := GetCardInfo;
    UpdateLastColWidth;
  end else
  begin
    Grid.Visible := False;
    lblCardInfo.Caption := Format('(%d) %s', [Driver.ResultCode, Driver.ResultDescription]);
  end;
end;

procedure TfmCard.UpdateObject;
begin
  case Driver.CardType of
    1: GridToBlocksUL;
  else
    UpdateObjectMifare;
  end;
end;

procedure TfmCard.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then
    raise Exception.Create(Driver.ErrorText);
end;

procedure TfmCard.btnReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Check(Driver.ReadCard);
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

function TfmCard.GetCardFileName: string;
begin
  Result := Format('%s №0x%s', [Driver.CardDescription, Driver.UIDHex]);
end;

procedure TfmCard.btnSaveClick(Sender: TObject);
begin
  SaveDialog.FileName := GetCardFileName;
  if SaveDialog.Execute then
  begin
    Driver.FileName := SaveDialog.FileName;
    Check(Driver.CardSaveToFile);
  end;
end;

procedure TfmCard.btnLoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Driver.FileName := OpenDialog.FileName;
    Check(Driver.CardLoadFromFile);
    UpdatePage;
  end;
end;

procedure TfmCard.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmCard.FormResize(Sender: TObject);
begin
  UpdateLastColWidth;
end;

procedure TfmCard.btnWriteClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.WriteCard);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmCard.UpdateObjectMifare;
begin

end;

procedure TfmCard.btnClearClick(Sender: TObject);
begin
  Check(Driver.ClearBlocksData);
  UpdatePage;
end;

end.
