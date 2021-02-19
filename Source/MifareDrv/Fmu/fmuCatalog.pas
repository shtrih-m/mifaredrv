unit fmuCatalog;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids,
  // This
  BaseForm, MifareLib_TLB, untUtil, untConst, untError, fmuPassword;

type
  { TfmCatalog }

  TfmCatalog = class(TBaseForm)
    Grid: TStringGrid;
    btnClose: TButton;
    btnRead: TButton;
    btnSave: TButton;
    edtStatus: TEdit;
    btnDelete: TButton;
    btnClear: TButton;
    btnFirms: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnFirmsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Driver: IMifareDrv1;
    procedure UpdatePage;
    procedure UpdateObject;
    procedure ClearDirectory;
    procedure UpdateLastColWidth;
    procedure Check(ResultCode: Integer);
    procedure DeleteSector(SectorIndex: Integer);
  end;

procedure ShowDirectory(AParentWnd: HWND; ADriver: IMifareDrv1);

implementation

{$R *.DFM}

procedure DrvCheck(Driver: IMifareDrv1; ResultCode: Integer);
begin
  if ResultCode <> 0 then
    RaiseError(Driver.ResultCode, Driver.ResultDescription);
end;

procedure ShowDirectory(AParentWnd: HWND; ADriver: IMifareDrv1);
var
  fm: TfmCatalog;
begin
  DrvCheck(ADriver, ADriver.ReadDirectory);
  fm := TfmCatalog.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, AParentWnd);
    fm.Driver := ADriver;
    fm.UpdatePage;
    fm.ShowModal;
  finally
    fm.Free;
  end;
end;

{ TfmCatalog }

procedure TfmCatalog.Check(ResultCode: Integer);
var
  S: string;
begin
  if ResultCode <> 0 then
  begin
    S := Driver.ErrorText;
    MessageBox(Handle, PChar(S), S_DriverName, MB_ICONERROR);
    Abort;
  end;
end;

procedure TfmCatalog.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmCatalog.UpdateLastColWidth;

  function GetGridWidth(Grid: TStringGrid): Integer;
  var
    i: Integer;
  begin
    with Grid do
    begin
      Result := GridLineWidth * (ColCount - 1);
      for i := 0 to ColCount - 1 do Result := Result + ColWidths[i];
    end;
  end;

var
  CellWidth: Integer;
begin
  CellWidth := Grid.ClientWidth - GetGridWidth(Grid);
  CellWidth := Grid.ColWidths[Grid.ColCount - 1] + CellWidth;
  Grid.ColWidths[Grid.ColCount - 1] := CellWidth
end;

procedure TfmCatalog.UpdatePage;
var
  i: Integer;
  Count: Integer;
begin
  Count := Driver.SectorCount;
  Grid.RowCount := Count + 1;
  // Названия столбцов
  Grid.Cells[0, 0] := 'Сектор';
  Grid.Cells[1, 0] := 'Фирма';
  Grid.Cells[2, 0] := 'Приложение';
  // Значения столбцов
  for i := 0 to Count - 1 do
  begin
    Driver.SectorIndex := i;
    Check(Driver.GetSectorParams);
    Grid.Cells[0, i + 1] := IntToStr(Driver.SectorNumber);
    Grid.Cells[1, i + 1] := IntToStr(Driver.FirmCode);
    Grid.Cells[2, i + 1] := IntToStr(Driver.AppCode);
  end;
  edtStatus.Text := 'Состояние:    ' + Driver.DirectoryStatusText;
end;

procedure TfmCatalog.ClearDirectory;
var
  i: Integer;
  Count: Integer;
begin
  Count := Driver.SectorCount;
  for i := 0 to Count - 1 do
  begin
    Grid.Cells[1, i + 1] := '0';
    Grid.Cells[2, i + 1] := '0';
  end;
end;

procedure TfmCatalog.UpdateObject;
var
  i: Integer;
  Count: Integer;
begin
  Count := Driver.SectorCount;
  for i := 0 to Count - 1 do
  begin
    Driver.SectorIndex := i;
    Driver.FirmCode := StrToInt(Grid.Cells[1, i + 1]);
    Driver.AppCode := StrToInt(Grid.Cells[2, i + 1]);
    Check(Driver.SetSectorParams);
  end;
end;

procedure TfmCatalog.btnReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Check(Driver.ReadDirectory);
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmCatalog.btnSaveClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.WriteDirectory);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmCatalog.FormResize(Sender: TObject);
begin
  UpdateLastColWidth;
end;

procedure TfmCatalog.DeleteSector(SectorIndex: Integer);
var
  S: string;
  Result: Integer;
  Password: string;
begin
  Driver.SectorIndex := SectorIndex;
  Check(Driver.GetSectorParams);
  Driver.KeyB := Driver.PasswordHeader;
  repeat
    Result := Driver.DeleteSector;
    if Result = 0 then Break;

    if Result <> 0 then
    begin
      S := Format('При удалении сектора %d произошла ошибка: %s',
        [Driver.SectorNumber, Driver.ErrorText]);

      if ShowErrorDlg(Handle, S, Password) then
        Driver.KeyB := Password
      else
        Break;
    end;
  until False;
end;

procedure TfmCatalog.btnClearClick(Sender: TObject);
var
  i: Integer;
  Count: Integer;
begin
  EnableButtons(False);
  try
    // Удаление секторов
    Count := Driver.SectorCount;
    for i := 0 to Count - 1 do
      DeleteSector(i);
    // Если все сектора удалены
    ClearDirectory;
    UpdateObject;
    Check(Driver.WriteDirectory);
  finally
    EnableButtons(True);
  end;
end;

{ Удаление сектора }

procedure TfmCatalog.btnDeleteClick(Sender: TObject);
begin
  DeleteSector(Grid.Row-1);
  Grid.Cells[1, Grid.Row] := '0';
  Grid.Cells[2, Grid.Row] := '0';
end;

procedure TfmCatalog.btnFirmsClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ShowFirmsDlg;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmCatalog.FormShow(Sender: TObject);
begin
  UpdateLastColWidth;
end;

end.

