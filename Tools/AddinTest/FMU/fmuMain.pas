unit fmuMain;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ActiveX, ComObj;

type
  { TArrayMember }

  TArrayMember = record
    MemId: Integer;
    EngName: string;
    RusName: string;
    IsReadable: Boolean;
    IsWritable: Boolean;
  end;

  { TfmMain }

  TfmMain = class(TForm)
    btnGetTypeInfo: TButton;
    Memo: TMemo;
    btnClose: TButton;
    lblClassName: TLabel;
    edtClassName: TEdit;
    procedure btnGetTypeInfoClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    TypeInfo: ITypeInfo;
    TypeAttr: PTypeAttr;
    Props: array of TArrayMember;
    Methods: array of TArrayMember;

    procedure CreateTestText;
    procedure CreateEngTestText;
    procedure Get1CInfo(ADriver: OleVariant);
    procedure GetTLBInfo(ADriver: OleVariant);
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

type
  { IInitDone Interface }

  IInitDone = interface(IUnknown)
    ['{AB634001-F13D-11D0-A459-004095E1DAEA}']
    function Init(pConnection: IDispatch): HResult; stdcall;
    function Done: HResult; stdcall;
    function GetInfo(var pInfo: PSafeArray{(OleVariant)}): HResult; stdcall;
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
    function CallAsProc(lMethodNum: Integer; var paParams: PSafeArray{(OleVariant)}): HResult; stdcall;
    function CallAsFunc(lMethodNum: Integer; var pvarRetValue: OleVariant; var paParams: PSafeArray{(OleVariant)}): HResult; stdcall;
  end;

{ TfmMain }

procedure TfmMain.GetTLBInfo(ADriver: OleVariant);
var
  I, J: Integer;
  FuncDesc: PFuncDesc;
  nProps, nMeths: Integer;
  name,RusName:Widestring;
  Driver: IDispatch;
begin
  Driver := ADriver;
  Driver.GetTypeInfo(0,0,TypeInfo);
  if TypeInfo = nil then Exit;

  TypeInfo.GetTypeAttr(TypeAttr);
  try
    SetLength(Props,TypeAttr.cFuncs);
    SetLength(Methods,TypeAttr.cFuncs);
    nProps:=0;
    nMeths:=0;
    For I:=0 To TypeAttr.cFuncs - 1 do Begin
      TypeInfo.GetFuncDesc(I, FuncDesc);
      try
        TypeInfo.GetDocumentation(FuncDesc.memid,@name,@Rusname,
          nil,nil);
        case FuncDesc.invkind of
          INVOKE_PROPERTYGET: begin
            Props[nProps].MemId:=FuncDesc.memid;
            Props[nProps].engName:=name;
            Props[nProps].rusName:=RusName;
            Props[nProps].IsReadable:=True;
            Inc(nProps);
          end;
          INVOKE_FUNC:begin
            Methods[nMeths].MemId:=FuncDesc.memid;
            Methods[nMeths].engName:=name;
            Methods[nMeths].rusName:=RusName;
            Inc(nMeths);
          end;
          else begin
            For J:=nProps-1 Downto 0 Do
              If Props[j].MemId= FuncDesc.memid then begin
                Props[j].isWritable:=True;
                Break;
              end;
          end;
        end;
      finally
        TypeInfo.ReleaseFuncDesc(FuncDesc);
      end;
    end;
    SetLength(Methods, nMeths);
    SetLength(Props,nProps);
  finally
    TypeInfo.ReleaseTypeAttr(TypeAttr);
  end;
end;

procedure TfmMain.Get1CInfo(ADriver: OleVariant);
var
  i: Integer;
  Count: Integer;
  Prop: TArrayMember;
  EngName: WideString;
  RusName: WideString;
  IsWritable: Integer;
  Method: TArrayMember;
  InitDone: IInitDone;
  Driver: ILanguageExtender;
begin
  Driver := IUnknown(ADriver) as ILanguageExtender;
  //InitDone := Driver as IInitDone;
  //OleCheck(InitDone.Init(nil));
  { Ìועמהû }
  OleCheck(Driver.GetNMethods(Count));
  SetLength(Methods, Count);
  for i := 0 to Count-1 do
  begin
    OleCheck(Driver.GetMethodName(i, 0, EngName));
    OleCheck(Driver.GetMethodName(i, 1, RusName));
    Method.EngName := EngName;
    Method.RusName := RusName;
    Methods[i] := Method;
  end;
  { Ñגמיסעגא }
  OleCheck(Driver.GetNProps(Count));
  SetLength(Props, Count);
  for i := 0 to Count-1 do
  begin
    OleCheck(Driver.GetPropName(i, 0, EngName));
    OleCheck(Driver.GetPropName(i, 1, RusName));
    OleCheck(Driver.IsPropWritable(i, IsWritable));
    Prop.EngName := EngName;
    Prop.RusName := RusName;
    Prop.IsWritable := IsWritable = 1;
    Props[i] := Prop;
  end;
end;

procedure TfmMain.CreateTestText;
var
  S: string;
  i:  Integer;
  IsWritable: Integer;
  Prop: TArrayMember;
  Method: TArrayMember;
begin
  { Ìועמהû }
  Memo.Lines.Add('  { Ìועמהû }');
  for i := Low(Methods) to High(Methods) do
  begin
    Method := Methods[i];
    S := Format('  CheckMethod(''%s'', ''%s'');', [Method.EngName, Method.RusName]);
    Memo.Lines.Add(S);
  end;
  { Ñגמיסעגא }
  Memo.Lines.Add('  { Ñגמיסעגא }');
  for i := Low(Props) to High(Props) do
  begin
    Prop := Props[i];
    if Prop.IsWritable then IsWritable := 1 else IsWritable := 0;
    S := '  CheckProp(''%s'', ''%s'', %d);';
    S := Format(S, [Prop.EngName, Prop.RusName, IsWritable]);
    Memo.Lines.Add(S);
  end;
end;

procedure TfmMain.CreateEngTestText;
var
  S: string;
  i:  Integer;
  IsWritable: Integer;
  Prop: TArrayMember;
  Method: TArrayMember;
begin
  { Ìועמהû }
  Memo.Lines.Add('  { Ìועמהû }');
  for i := Low(Methods) to High(Methods) do
  begin
    Method := Methods[i];
    S := Format('  CheckMethod(''%s'', '''');', [Method.EngName]);
    Memo.Lines.Add(S);
  end;
  { Ñגמיסעגא }
  Memo.Lines.Add('  { Ñגמיסעגא }');
  for i := Low(Props) to High(Props) do
  begin
    Prop := Props[i];
    if Prop.IsWritable then IsWritable := 1 else IsWritable := 0;
    S := '  CheckProp(''%s'', '''', %d);';
    S := Format(S, [Prop.EngName, IsWritable]);
    Memo.Lines.Add(S);
  end;
end;

procedure TfmMain.btnGetTypeInfoClick(Sender: TObject);
var
  Driver: OleVariant;
begin
  Driver := CreateOleObject(edtClassName.Text);
  Get1CInfo(Driver);
  //GetTLBInfo(Driver);

  Memo.Lines.Clear;
  CreateTestText;
end;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
