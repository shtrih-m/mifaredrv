unit fmuSerialParams;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,
  // This
  BaseForm, untConst, SerialParams;

type
  { TfmParams }

  TfmSerialParams = class(TBaseForm)
    lblPortNumber: TLabel;
    cbPortNumber: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    lblBaudRate: TLabel;
    cbBaudRate: TComboBox;
    lblParity: TLabel;
    cbParity: TComboBox;
  private
    FParams: TSerialParams;
    procedure UpdatePage;
    procedure UpdateObject;
  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure ShowSerialParamsDlg(ParentWnd: HWND; AParams: TSerialParams);

implementation

{$R *.DFM}

procedure ShowSerialParamsDlg(ParentWnd: HWND; AParams: TSerialParams);
var
  fm: TfmSerialParams;
begin
  fm := TfmSerialParams.Create(nil);
  try
    SetWindowLong(fm.Handle, GWL_HWNDPARENT, ParentWnd);
    fm.FParams := AParams;
    fm.UpdatePage;
    if fm.ShowModal = mrOK then
      fm.UpdateObject;
  finally
    fm.Free;
  end;
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

function GetItem(ComboBox: TComboBox): Integer;
begin
  Result := Integer(ComboBox.Items.Objects[ComboBox.ItemIndex]);
end;

function GetIndex(ComboBox: TComboBox; Value: Integer): Integer;
begin
  Result := ComboBox.Items.IndexOfObject(TObject(Value));
end;

{ TfmParams }

constructor TfmSerialParams.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FillBaudRates(cbBaudRate.Items);
  FillPortNumbers(cbPortNumber.Items);
  FillParity(cbParity.Items);
end;

procedure TfmSerialParams.UpdateObject;
begin
  FParams.Parity := GetItem(cbParity);
  FParams.BaudRate := GetItem(cbBaudRate);
  FParams.PortNumber := GetItem(cbPortNumber);
end;

procedure TfmSerialParams.UpdatePage;
begin
  cbParity.ItemIndex := GetIndex(cbParity, FParams.Parity);
  cbBaudRate.ItemIndex := GetIndex(cbBaudRate, FParams.BaudRate);
  cbPortNumber.ItemIndex := GetIndex(cbPortNumber, FParams.PortNumber);
end;

end.
