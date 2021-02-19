unit fmuConnection;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  untPage, MifareLib_TLB;

type
  { TfmConn }

  TfmConnection = class(TPage)
    gsConnection: TGroupBox;
    lblComPort: TLabel;
    lblPcdConfig: TLabel;
    Bevel1: TBevel;
    btnPcdConfig: TButton;
    btnOpenPort: TButton;
    btnClosePort: TButton;
    cbPortNumber: TComboBox;
    btnConnect: TButton;
    btnDisconnect: TButton;
    procedure btnPcdConfigClick(Sender: TObject);
    procedure btnOpenPortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnClosePortClick(Sender: TObject);
    procedure btnPcdSetDefaultAttribClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
  public
    procedure UpdatePage; override;
  end;

implementation

{$R *.DFM}

procedure FillPortNumbers(Items: TStrings);
var
  i: Integer;
begin
  Items.Clear;
  for i := 1 to 256 do
    Items.AddObject('COM '+ IntToStr(i), TObject(i));
end;

{ TfmConn }

procedure TfmConnection.FormCreate(Sender: TObject);
begin
  FillPortNumbers(cbPortNumber.Items);
end;

procedure TfmConnection.btnPcdConfigClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PcdConfig;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnOpenPortClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PortNumber := cbPortNumber.ItemIndex + 1;
    Driver.OpenPort;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnClosePortClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ClosePort;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnPcdSetDefaultAttribClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PcdSetDefaultAttrib;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.UpdatePage;
begin
  cbPortNumber.ItemIndex := Driver.PortNumber-1;
end;

procedure TfmConnection.btnConnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PortNumber := cbPortNumber.ItemIndex + 1;
    Driver.Connect;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnDisconnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Disconnect;
  finally
    EnableButtons(True);
  end;
end;

end.
