unit fmuLogFile;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  // This
  MifareLib_TLB, untUtil, LogFile;

type
  { TfmLogParams }

  TfmLogFile = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbParams: TGroupBox;
    lblLogFileName: TLabel;
    chbLogEnabled: TCheckBox;
    edtLogFilePath: TEdit;
    btnDefaults: TButton;
    procedure btnDefaultsClick(Sender: TObject);
  public
    procedure UpdatePage(Driver: IMifareDrv3);
    procedure UpdateObject(Driver: IMifareDrv3);
  end;

function ShowLogFileDlg(AParentWnd: HWND; ADriver: IMifareDrv3): Boolean;

implementation

{$R *.DFM}

function ShowLogFileDlg(AParentWnd: HWND; ADriver: IMifareDrv3): Boolean;
var
  fm: TfmLogFile;
begin
  fm := TfmLogFile.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, AParentWnd);
    fm.UpdatePage(ADriver);
    Result := fm.ShowModal = mrOK;
    if Result then
      fm.UpdateObject(ADriver);
  finally
    fm.Free;
  end;
end;

{ TfmLogFile }

procedure TfmLogFile.UpdatePage(Driver: IMifareDrv3);
begin
  edtLogFilePath.Text := Driver.LogFilePath;
  chbLogEnabled.Checked := Driver.LogEnabled;
end;

procedure TfmLogFile.UpdateObject(Driver: IMifareDrv3);
begin
  Driver.LogFilePath := edtLogFilePath.Text;
  Driver.LogEnabled := chbLogEnabled.Checked;
end;

procedure TfmLogFile.btnDefaultsClick(Sender: TObject);
begin
  chbLogEnabled.Checked := False;
  edtLogFilePath.Text := TLogFile.GetDefaultPath;
end;

end.
