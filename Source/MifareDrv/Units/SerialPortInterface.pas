unit SerialPortInterface;

interface

uses
  // VCL
  Windows,
  // This
  SerialParams;

type
  { ISerialPort }

  ISerialPort = interface
    ['{50958146-2F13-47BA-A3C9-B29FC7F59B9C}']
    procedure Close;
    function Opened: Boolean;
    function GetRxData: string;
    function GetTxData: string;
    function GetParams: TSerialParams;
    procedure ShowProperties(ParentWnd: HWND);
    procedure Open(const Params: TSerialParams);
    function SendCommand(const Data: string): string;

    property RxData: string read GetRxData;
    property TxData: string read GetTxData;
    property Params: TSerialParams read GetParams;
  end;

implementation

end.
