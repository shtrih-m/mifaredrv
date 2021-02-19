unit fmuDeviceSearch;

interface

uses
  // VCL
  Windows, ComCtrls, StdCtrls, Controls, ExtCtrls, Classes, Forms,
  SysUtils, ActiveX, ComObj, Graphics, Registry, Buttons,
  // 3'd
  PngBitBtn,
  // Tnt
  TntComCtrls, TntStdCtrls,
  // This
  BaseForm, MifareLib_TLB, untUtil, DeviceSearch, SearchPort,
  DebugUtils, LogFile;

type
  { TfmDeviceSearch }

  TfmDeviceSearch = class(TBaseForm)
    ListView: TTntListView;
    btnSelectAll: TPngBitBtn;
    btnDeselectAll: TPngBitBtn;
    btnStart: TPngBitBtn;
    btnStop: TPngBitBtn;
    btnClose: TPngBitBtn;
    Timer: TTimer;
    procedure btnStopClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnDeselectAllClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    FDriver: IMifareDrv3;
    FBaudRate: Integer;
    FPortNumber: Integer;
    FSearch: TDeviceSearch;


    procedure UpdatePage;
    procedure SelectPorts;
    procedure UpdateStatus;
    procedure UpdateObject;
    procedure SelectDevice;
    procedure CreateListItems;
    procedure UpdateListItems;

    property Search: TDeviceSearch read FSearch;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

procedure ShowFindDlg(ParentWnd: HWND; ADriver: IMifareDrv3);

implementation

{$R *.DFM}

procedure ShowFindDlg(ParentWnd: HWND; ADriver: IMifareDrv3);
var
  fm: TfmDeviceSearch;
begin
  fm := TfmDeviceSearch.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, ParentWnd);
    fm.FDriver := ADriver;
    fm.UpdatePage;
    fm.ShowModal;
    fm.UpdateObject;
  finally
    fm.Free;
  end;
end;

{ TfmDeviceSearch }

constructor TfmDeviceSearch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSearch := TDeviceSearch.Create;
  CreateListItems;
end;

destructor TfmDeviceSearch.Destroy;
begin
  FSearch.Free;
  inherited Destroy;
end;

procedure TfmDeviceSearch.UpdatePage;
begin
  FBaudRate := FDriver.BaudRate;
  FPortNumber := FDriver.PortNumber;
end;

procedure TfmDeviceSearch.UpdateObject;
begin
  FDriver.BaudRate := FBaudRate;
  FDriver.PortNumber := FPortNumber;
end;

procedure TfmDeviceSearch.UpdateStatus;
begin
  if FSearch.Completed then
  begin
    btnStop.Enabled := False;
    btnStart.Enabled := True;
    btnSelectAll.Enabled := True;
    btnDeselectAll.Enabled := True;
    if btnStart.CanFocus then
      btnStart.SetFocus;
    Timer.Enabled := False;
  end;
  UpdateListItems;
end;

procedure TfmDeviceSearch.SelectDevice;
var
  PortID: Integer;
  Port: TSearchPort;
  ListItem: TTntListItem;
begin
  Search.Stop;
  ListItem := ListView.Selected;
  if ListItem <> nil then
  begin
    PortID := Integer(ListItem.Data);
    Search.Ports.Lock;
    try
      Port := Search.Ports.ItemByID(PortID);
      if (Port <> nil)and(Port.DeviceFound) then
      begin
        FBaudRate := Port.BaudRate;
        FPortNumber := Port.PortNumber;
      end;
    finally
      Search.Ports.Unlock;
    end;
  end;
  Close;
end;

procedure TfmDeviceSearch.btnStopClick(Sender: TObject);
begin
  Search.Stop;
  btnStop.Enabled := False;
end;

procedure TfmDeviceSearch.btnStartClick(Sender: TObject);
begin
  Search.Stop;
  SelectPorts;
  Search.Start;
  btnSelectAll.Enabled := False;
  btnDeselectAll.Enabled := False;
  btnStart.Enabled := False;
  btnStop.Enabled := True;

  if btnStop.CanFocus then
    btnStop.SetFocus;
  UpdateListItems;
  Timer.Enabled := True;
end;

procedure TfmDeviceSearch.ListViewDblClick(Sender: TObject);
begin
  SelectDevice;
end;

procedure TfmDeviceSearch.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    SelectDevice;
end;

procedure TfmDeviceSearch.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmDeviceSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Search.Stop;
end;

procedure TfmDeviceSearch.btnSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListView.Items.Count - 1 do
    ListView.Items[i].Checked := True;
end;

procedure TfmDeviceSearch.btnDeselectAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListView.Items.Count - 1 do
    ListView.Items[i].Checked := False;
end;

procedure TfmDeviceSearch.UpdateListItems;
var
  i: Integer;
  ID: Integer;
  Port: TSearchPort;
  ListItem: TTntListItem;
begin
  Search.Ports.Lock;
  try
    for i := 0 to ListView.Items.Count-1 do
    begin
      ListItem := ListView.Items[i];
      ID := Integer(ListItem.Data);
      Port := Search.Ports.ItemByID(ID);
      if Port <> nil then
      begin
        ListItem.SubItems.BeginUpdate;
        try
          ListItem.SubItems[0] := Port.ParamsText;
          ListItem.SubItems[1] := Port.Text;
        finally
          ListItem.SubItems.EndUpdate;
        end;
      end;
    end;
  finally
    Search.Ports.Unlock;
  end;
end;

procedure TfmDeviceSearch.CreateListItems;
var
  i: Integer;
  Port: TSearchPort;
  ListItem: TTntListItem;
begin
  Search.Ports.Lock;
  ListView.Items.BeginUpdate;
  try
    ListView.Items.Clear;

    for i := 0 to Search.Ports.Count-1 do
    begin
      Port := Search.Ports[i];

      ListItem := ListView.Items.Add;
      ListItem.Caption := Port.PortName;
      ListItem.SubItems.Add('');
      ListItem.SubItems.Add('');
      ListItem.Checked := True;
      ListItem.Data := Pointer(Port.ID);
    end;
  finally
    Search.Ports.Unlock;
    ListView.Items.EndUpdate;
  end;
end;

procedure TfmDeviceSearch.SelectPorts;
var
  i: Integer;
  ID: Integer;
  Port: TSearchPort;
  ListItem: TTntListItem;
begin
  Search.Ports.Lock;
  ListView.Items.BeginUpdate;
  try
    for i := 0 to ListView.Items.Count-1 do
    begin
      ListItem := ListView.Items[i];
      ID := Integer(ListItem.Data);
      Port := Search.Ports.ItemByID(ID);
      if Port <> nil then
      begin
        Port.Selected := ListItem.Checked;
      end;
    end;
  finally
    Search.Ports.Unlock;
    ListView.Items.EndUpdate;
  end;
end;

procedure TfmDeviceSearch.TimerTimer(Sender: TObject);
begin
  try
    UpdateStatus;
  except
    on E: Exception do
    begin
      Timer.Enabled := False;
      raise;
    end;
  end;
end;

end.
