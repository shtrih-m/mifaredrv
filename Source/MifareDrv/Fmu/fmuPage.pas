unit fmuPage;

interface

uses
  // VCL
  Windows, Messages, Forms, AxCtrls, ComCtrls, StdCtrls, Controls, Classes,
  SysUtils, Graphics, ComServ, ExtCtrls, Buttons, Spin,
  // This
  MifareLib_TLB, untUtil, untError, untConst, fmuTrailer, fmuParams,
  OmnikeyReader5422;

const
  Class_fmPage: TGUID = '{31807AD9-ACD1-4165-8359-5A92C54A09B8}';

type
  { TfmPage }

  TfmPage = class(TPropertyPage)
    lblResult: TLabel;
    btnAbout: TButton;
    btnSearch: TButton;
    btnConnect: TButton;
    btnDefaults: TButton;
    btnShowDirectoryDlg: TButton;
    btnTrailer: TButton;
    gbParams: TGroupBox;
    lblDevice: TLabel;
    cbDeviceType: TComboBox;
    gbDriver: TGroupBox;
    edtVersion: TEdit;
    lblInfo: TLabel;
    lblVersion_: TLabel;
    pnlMksReader: TPanel;
    lblTimeout: TLabel;
    cbPortNumber: TComboBox;
    lblPortNumber: TLabel;
    lblBaudRate: TLabel;
    cbBaudRate: TComboBox;
    cbParity: TComboBox;
    lblParity: TLabel;
    pnlCardmanReader: TPanel;
    Label1: TLabel;
    cbReaderName: TComboBox;
    btnUpdateDevices: TButton;
    edtResult: TMemo;
    btnWriteBaudRate: TButton;
    btnParams: TButton;
    seTimeout: TSpinEdit;
    procedure btnAboutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure btnShowDirectoryDlgClick(Sender: TObject);
    procedure btnTrailerClick(Sender: TObject);
    procedure cbDeviceTypeChange(Sender: TObject);
    procedure btnUpdateDevicesClick(Sender: TObject);
    procedure btnWriteBaudRateClick(Sender: TObject);
    procedure btnParamsClick(Sender: TObject);
  private
    FDriver: IMifareDrv3;
    FButton: TWinControl;
    FFormShowCounter: Integer;

    procedure UpdatePage;
    procedure ClearResult;
    procedure UpdateResult;
    function GetDriver: IMifareDrv3;
    procedure EnableButtons(Value: Boolean);
    procedure CMChanged(var Msg: TCMChanged); message CM_CHANGED;

    property Driver: IMifareDrv3 read GetDriver;
    function GetResultText: string;
  public
    procedure UpdateObject; override;
    procedure UpdatePropertyPage; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.DFM}

procedure FillDevices(Items: TStrings);
begin
  Items.Clear;
  Items.AddObject('—читыватель MiReader', TObject(dtMiReader));
  Items.AddObject('—читыватель Cardman5321', TObject(dtCardman5321));
  Items.AddObject('—читыватель Omnikey5422', TObject(dtOmnikey5422));
  //Items.AddObject('Ёмул€тор считывател€', TObject(dtEmulator));
end;

function GetItem(ComboBox: TComboBox): Integer;
begin
  Result := Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);
end;

function GetIndex(ComboBox: TComboBox; Value: Integer): Integer;
begin
  Result := ComboBox.Items.IndexOfObject(TObject(Value));
end;

procedure FillPortNumbers(Items: TStrings);
var
  i: Integer;
begin
  Items.Clear;
  for i := 1 to MAX_PORT_NUMBER do
    Items.AddObject('COM ' + IntToStr(i), TObject(i));
end;

procedure FillBaudRates(Items: TStrings);
begin
  Items.Clear;
  Items.AddObject('1200', TObject(1200));
  Items.AddObject('2400', TObject(2400));
  Items.AddObject('4800', TObject(4800));
  Items.AddObject('9600', TObject(9600));
  Items.AddObject('14400', TObject(14400));
  Items.AddObject('19200', TObject(19200));
  Items.AddObject('38400', TObject(38400));
  Items.AddObject('57600', TObject(57600));
  Items.AddObject('115200', TObject(115200));
end;

procedure FillParity(Items: TStrings);
begin
  Items.Clear;
  Items.AddObject('нет', TObject(NOPARITY));
  Items.AddObject('четность', TObject(EVENPARITY));
end;

{ TfmPropPage }

constructor TfmPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := btnConnect.Left + btnConnect.Width + 16;
  Height := edtResult.Top + edtResult.Height + 33;
  FillDevices(cbDeviceType.Items);
  FillBaudRates(cbBaudRate.Items);
  FillPortNumbers(cbPortNumber.Items);
  FillParity(cbParity.Items);
end;

destructor TfmPage.Destroy;
begin
  FDriver := nil;
  inherited Destroy;
end;

function TfmPage.GetDriver: IMifareDrv3;
begin
  if FDriver = nil then
    FDriver := IUnknown(OleObject) as IMifareDrv3;
  Result := FDriver;
end;

function TfmPage.GetResultText: string;
begin
  if Driver.ResultCode = E_REMOVED_CARD then
    Result := Format('%d, %s', [0,   Driver.ResultDescription])
  else
    Result := Format('%d, %s', [Driver.ResultCode,   Driver.ResultDescription]);
end;

procedure TfmPage.UpdateResult;
begin
  edtResult.Text := GetResultText;
end;

procedure TfmPage.ClearResult;
begin
  edtResult.Clear;
  edtResult.Update;
end;

procedure TfmPage.UpdatePage;
begin
  pnlMksReader.Visible := Driver.DeviceType = dtMiReader;
  pnlCardmanReader.Visible := Driver.DeviceType in [dtCardman5321, dtOmnikey5422];

  cbReaderName.Items.Text := SCardGetReaderNames;
  cbReaderName.Text := Driver.ReaderName;
  cbDeviceType.ItemIndex := GetIndex(cbDeviceType, Driver.DeviceType);
  lblPortNumber.Visible := Driver.DeviceType = 0;
  cbPortNumber.Visible := Driver.DeviceType = 0;
  lblBaudRate.Visible := Driver.DeviceType = 0;
  cbBaudRate.Visible := Driver.DeviceType = 0;
  lblParity.Visible := Driver.DeviceType = 0;
  cbParity.Visible := Driver.DeviceType = 0;

  edtVersion.Text := Driver.Version;
  seTimeout.Value := Driver.Timeout;
  cbParity.ItemIndex := GetIndex(cbParity, Driver.Parity);
  cbBaudRate.ItemIndex := GetIndex(cbBaudRate, Driver.PortBaudRate);
  cbPortNumber.ItemIndex := GetIndex(cbPortNumber, Driver.PortNumber);
end;

procedure TfmPage.UpdatePropertyPage;
begin
  UpdatePage;
end;

procedure TfmPage.UpdateObject;
begin
  Driver.DeviceType := GetItem(cbDeviceType);
  Driver.Timeout := seTimeout.Value;
  Driver.Parity := GetItem(cbParity);
  Driver.PortNumber := GetItem(cbPortNumber);
  Driver.PortBaudRate := GetItem(cbBaudRate);
  Driver.ReaderName := cbReaderName.Text;

  Driver.SaveParams;
end;

procedure TfmPage.EnableButtons(Value: Boolean);
begin
  EnableFormButtons(Self, Value, FButton);
end;

procedure TfmPage.btnAboutClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AboutBox;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPage.btnConnectClick(Sender: TObject);
begin
  UpdateObject;
  EnableButtons(False);
  try
    ClearResult;
    if (Driver.Connect = 0) and
      (Driver.PcdGetFwVersion = 0) then
    begin
      edtResult.Lines.Add(GetResultText);
      edtResult.Lines.Add(Driver.PcdFwVersion);
    end else
    begin
      UpdateResult;
    end;
    Driver.Disconnect;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPage.FormShow(Sender: TObject);

  procedure CenterClientSite;
  var
    R: TRect;
    intWidth, intHeight: Integer;
    hwndParent: HWnd;
  begin
    hwndParent := GetParent(GetParent(Handle));
    if IsWindow(hwndParent) then
    begin
      GetWindowRect(hwndParent, R);
      intWidth := R.Right - R.Left;
      intHeight := R.Bottom - R.Top;
      MoveWindow(hwndParent, (Screen.Width - intWidth) div 2,
        (Screen.Height - intHeight) div 2, intWidth, intHeight, TRUE);
    end;
  end;

begin
  // WS_EX_CONTROLPARENT is cleared by property frame
  // We need to set it back to avoid page hang
  SetWindowLong(Handle, GWL_EXSTYLE,
    GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_CONTROLPARENT);

  if FFormShowCounter = 0 then
  begin
    if (Driver.IsClient1C and Driver.IsShowProperties) then
    begin
      CenterClientSite;
    end;
  end;
  Inc(FFormShowCounter);
end;

procedure TfmPage.CMChanged(var Msg: TCMChanged);
begin

end;

procedure TfmPage.btnSearchClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Driver.ParentWnd := Handle;
    Driver.ShowSearchDlg;
    UpdateResult;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPage.btnDefaultsClick(Sender: TObject);
begin
  Driver.SetDefaults;
  UpdatePage;
end;

procedure TfmPage.btnShowDirectoryDlgClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ParentWnd := Handle;
    Driver.ShowDirectoryDlg;
    UpdateResult;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPage.btnTrailerClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ParentWnd := Handle;
    Driver.ShowTrailerDlg;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPage.cbDeviceTypeChange(Sender: TObject);
begin
  UpdateObject;
  UpdatePage;
end;

procedure TfmPage.btnUpdateDevicesClick(Sender: TObject);
begin
  cbReaderName.Items.Text := SCardGetReaderNames;
end;

procedure TfmPage.btnWriteBaudRateClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.NewBaudRate := GetItem(cbBaudRate);
    Driver.WriteConnectionParams;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPage.btnParamsClick(Sender: TObject);
begin
  ShowParamsDlg(Handle, Driver);
end;

initialization
  TActiveXPropertyPageFactory.Create(ComServer, TfmPage, Class_fmPage);

end.
