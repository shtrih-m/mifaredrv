unit SerialParams;

interface

uses
  // VCL
  Windows,
  // Uses
  MifareLib_TLB;

type
  { TSerialParams }

  TSerialParams = class
  public
    Mode: LongWord;
    Parity: DWORD;
    Timeout: DWORD;
    BaudRate: DWORD;
    ReaderName: string;
    PortNumber: Integer;
    CardBaudRate: DWORD;
    PollInterval: Integer;
    PollAutoDisable: Boolean;
    PollActivateMethod: Integer;
    DeviceType: TDeviceType;

    procedure Assign(Src: TSerialParams);
  end;

implementation

{ TSerialParams }

procedure TSerialParams.Assign(Src: TSerialParams);
begin
  Mode := Src.Mode;
  Parity := Src.Parity;
  Timeout := Src.Timeout;
  BaudRate := Src.BaudRate;
  ReaderName := Src.ReaderName;
  PortNumber := Src.PortNumber;
  CardBaudRate := Src.CardBaudRate;
  PollInterval := Src.PollInterval;
  PollAutoDisable := Src.PollAutoDisable;
  PollActivateMethod := Src.PollActivateMethod;
  DeviceType := Src.DeviceType;
end;

end.
