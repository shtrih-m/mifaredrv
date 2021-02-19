unit AddInLib;

interface

uses
  // VCL
  Windows, ActiveX;

const
  IID_IInitDone: TIID = '{AB634001-F13D-11D0-A459-004095E1DAEA}';
  IID_ILanguageExtender: TIID = '{AB634003-F13D-11D0-A459-004095E1DAEA}';
  IID_IAsyncEvent: TIID = '{AB634004-F13D-11D0-A459-004095E1DAEA}';

type
  { IInitDone Interface }

  IInitDone = interface(IUnknown)
    ['{AB634001-F13D-11D0-A459-004095E1DAEA}']
    function Init(pConnection: IDispatch): HResult; stdcall;
    function Done: HResult; stdcall;
    function GetInfo(var pInfo: PSafeArray {(OleVariant)}): HResult; stdcall;
  end;

  { ILanguageExtender Interface }

  ILanguageExtender = interface(IUnknown)
    ['{AB634003-F13D-11D0-A459-004095E1DAEA}']
    function RegisterExtensionAs(var bstrExtensionName: WideString): HResult; stdcall;
    function GetNProps(var plProps: Integer): HResult; stdcall;
    function FindProp(const bstrPropName: WideString; var plPropNum: Integer): HResult; stdcall;
    function GetPropName(lPropNum, lPropAlias: Integer; var pbstrPropName: WideString): HResult; stdcall;
    function GetPropVal(lPropNum: Integer; var pvarPropVal: OleVariant): HResult; stdcall;
    function SetPropVal(lPropNum: Integer; var varPropVal: OleVariant): HResult; stdcall;
    function IsPropReadable(lPropNum: Integer; var pboolPropRead: Integer): HResult; stdcall;
    function IsPropWritable(lPropNum: Integer; var pboolPropWrite: Integer): HResult; stdcall;
    function GetNMethods(var plMethods: Integer): HResult; stdcall;
    function FindMethod(const bstrMethodName: WideString; var plMethodNum: Integer): HResult; stdcall;
    function GetMethodName(lMethodNum, lMethodAlias: Integer; var pbstrMethodName: WideString): HResult; stdcall;
    function GetNParams(lMethodNum: Integer; var plParams: Integer): HResult; stdcall;
    function GetParamDefValue(lMethodNum, lParamNum: Integer; var pvarParamDefValue: OleVariant): HResult; stdcall;
    function HasRetVal(lMethodNum: Integer; var pboolRetValue: Integer): HResult; stdcall;
    function CallAsProc(lMethodNum: Integer; var paParams: PSafeArray {(OleVariant)}): HResult; stdcall;
    function CallAsFunc(lMethodNum: Integer; var pvarRetValue: OleVariant; var paParams: PSafeArray {(OleVariant)}): HResult; stdcall;
  end;

  { IAsyncEvent Interface }

  IAsyncEvent = interface(IUnknown)
    ['{AB634004-F13D-11D0-A459-004095E1DAEA}']
    procedure SetEventBufferDepth(lDepth: Integer); safecall;
    procedure GetEventBufferDepth(var plDepth: Integer); safecall;
    procedure ExternalEvent(const bstrSource, bstrMessage, bstrData: WideString); safecall;
    procedure CleanBuffer; safecall;
  end;

implementation

end.
