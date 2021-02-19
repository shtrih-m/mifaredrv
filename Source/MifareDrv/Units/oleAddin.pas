unit oleAddin;

interface

uses
  // VCL
  Windows, ActiveX, SysUtils, AxCtrls,
  // This
  oleMain, untAddin, AddInLib, untConst, LogFile;

type
  { ToleAddin }

  ToleAddin = class(TMifareDrv, ILanguageExtender)
  private
    FProps: TAddinItems;
    FMethods: TAddinItems;
    procedure UpdateAddinLists;
  private
    // ILanguageExtender
    function GetNProps(var Count: Integer): HResult; stdcall;
    function GetNMethods(var Count: Integer): HResult; stdcall;
    function RegisterExtensionAs(var ExtensionName: WideString): HResult; stdcall;
    function GetNParams(Index: Integer; var Count: Integer): HResult; stdcall;
    function HasRetVal(Index: Integer; var RetValue: Integer): HResult; stdcall;
    function GetPropVal(Index: Integer; var Value: OleVariant): HResult; stdcall;
    function SetPropVal(Index: Integer; var Value: OleVariant): HResult; stdcall;
    function CallAsProc(Index: Integer; var Params: PSafeArray): HResult; stdcall;
    function IsPropReadable(Index: Integer; var Value: Integer): HResult; stdcall;
    function IsPropWritable(Index: Integer; var Value: Integer): HResult; stdcall;
    function FindProp(const PropName: WideString; var Index: Integer): HResult; stdcall;
    function FindMethod(const MethodName: WideString; var Index: Integer): HResult; stdcall;
    function GetMethodName(Index, Alias: Integer; var MethodName: WideString): HResult; stdcall;
    function GetPropName(Index, Alias: Integer; var PropName: WideString): HResult; stdcall;
    function CallAsFunc(Index: Integer; var RetValue: OleVariant; var Params: PSafeArray): HResult; stdcall;
    function GetParamDefValue(mIndex, pIndex: Integer; var ParamDefValue: OleVariant): HResult; stdcall;
  public
    destructor Destroy; override;
    procedure Initialize; override;

    property Props: TAddinItems read FProps;
    property Methods: TAddinItems read FMethods;
  end;

implementation

const
  BoolToInt: array[Boolean] of Integer = (0, 1);

{ ToleAddin }

procedure ToleAddin.Initialize;
begin
  inherited Initialize;
  FProps := TAddinItems.Create;
  FMethods := TAddinItems.Create;
  UpdateAddinLists;
end;

destructor ToleAddin.Destroy;
begin
  FProps.Free;
  FMethods.Free;
  inherited Destroy;
end;


{*****************************************************************************}
{
{  Обновление информации о свойствах и методах
{
{*****************************************************************************}

procedure ToleAddin.UpdateAddinLists;
var
  I, J: Integer;
  Item: TAddinItem;
  TypeAttr: PTypeAttr;
  TypeInfo: ITypeInfo;
  FuncDesc: PFuncDesc;
  EngName: WideString;
  RusName: WideString;
begin
  Props.Clear;
  Methods.Clear;
  GetTypeInfo(0, 0, typeInfo);
  if TypeInfo = nil then Exit;
  TypeInfo.GetTypeAttr(TypeAttr);
  try
    for i := 0 to TypeAttr.cFuncs - 1 do
    begin
      TypeInfo.GetFuncDesc(i, FuncDesc);
      try
        TypeInfo.GetDocumentation(FuncDesc.memid, @EngName, @RusName, nil, nil);

        case FuncDesc.invkind of

          INVOKE_PROPERTYGET:
            begin
              Item := TAddinItem.Create(Props);
              Item.MemId := FuncDesc.memid;
              Item.EngName := PChar(string(EngName));
              Item.RusName := PChar(string(RusName));
              Item.IsReadable := True;
              Item.vt := FuncDesc.elemdescFunc.tdesc.vt;
            end;

          INVOKE_FUNC:
            begin
              Item := TAddinItem.Create(Methods);
              Item.MemId := FuncDesc.memid;
              Item.EngName := PChar(string(EngName));
              Item.RusName := PChar(string(RusName));
            end;

        else
          begin
            for j := Props.Count - 1 downto 0 do
            begin
              if Props[j].MemId = FuncDesc.memid then
              begin
                Props[j].IsWritable := True;
                Break;
              end;
            end;
          end;
        end;
      finally
        TypeInfo.ReleaseFuncDesc(FuncDesc);
      end;
    end;
  finally
    TypeInfo.ReleaseTypeAttr(TypeAttr);
  end;
end;

{ ILanguageExtender }

function ToleAddin.RegisterExtensionAs(var ExtensionName: WideString): HResult;
begin
  ExtensionName := 'MifareDrv';
  Result := S_OK;
end;

function ToleAddin.CallAsFunc(Index: Integer; var RetValue: OleVariant;
  var Params: PSafeArray): HResult; stdcall;
var
  DispParams: TDispParams;
begin
  FillChar(DispParams, SizeOf(DispParams), 0);
  Result := Invoke(Methods[Index].MemId, GUID_NULL,
    0, DISPATCH_METHOD, DispParams, @RetValue,
    nil, nil);
end;

function ToleAddin.CallAsProc(Index: Integer; var Params: PSafeArray): HResult;
var
  DispParams: TDispParams;
begin
  FillChar(DispParams, SizeOf(DispParams), 0);
  Result := Invoke(Methods[Index].MemId, GUID_NULL,
    0, DISPATCH_METHOD, DispParams, nil,
    nil, nil);
end;

function ToleAddin.FindMethod(const MethodName: WideString;
  var Index: Integer): HResult;
var
  S: string;
  i: Integer;
  Method: TAddinItem;
begin
  Index := -1;
  Result := S_FALSE;

  S := string(MethodName);
  for i := 0 to Methods.Count - 1 do
  begin
    Method := Methods[i];
    if (AnsiCompareText(Method.EngName, S) = 0) or
      (AnsiCompareText(Method.RusName, S) = 0) then
    begin
      Index := i;
      Result := S_OK;
      Break;
    end;
  end;
end;

function ToleAddin.FindProp(const PropName: WideString;
  var Index: Integer): HResult;
var
  i: Integer;
  S: string;
  Prop: TAddinItem;
begin
  Index := -1;
  Result := S_FALSE;
  S := string(PropName);
  for i := 0 to Props.Count - 1 do
  begin
    Prop := Props[i];
    if (AnsiCompareText(Prop.EngName, S) = 0) or
      (AnsiCompareText(Prop.RusName, S) = 0) then
    begin
      Index := i;
      Result := S_OK;
      Break;
    end;
  end;
end;

function ToleAddin.GetMethodName(Index, Alias: Integer;
  var MethodName: WideString): HResult;
begin
  if (Index >= 0) and (Index < Methods.Count) then
  begin
    case Alias of
      0: MethodName := Methods[Index].EngName;
    else
      MethodName := Methods[Index].RusName;
    end;
    Result := S_OK;
  end
  else begin
    MethodName := '';
    Result := S_FALSE;
  end;
end;

function ToleAddin.GetNMethods(var Count: Integer): HResult;
begin
  Count := Methods.Count;
  Result := S_OK;
end;

{******************************************************************************}
{
{  Мы делаем все методы без параметров
{
{******************************************************************************}

function ToleAddin.GetNParams(Index: Integer; var Count: Integer): HResult;
begin
  Result := S_FALSE;
  if (Index >= 0) and (Index < Methods.Count) then
  begin
    Count := 0;
    Result := S_OK;
  end;
end;

{ Количество свойств }

function ToleAddin.GetNProps(var Count: Integer): HResult;
begin
  Count := Props.Count;
  Result := S_OK;
end;

function ToleAddin.GetParamDefValue(mIndex, pIndex: Integer;
  var ParamDefValue: OleVariant): HResult;
begin
  VarClear(ParamDefValue);
  Result := S_OK;
end;

function ToleAddin.GetPropName(Index, Alias: Integer;
  var PropName: WideString): HResult;
begin
  if (Index >= 0) and (Index < Props.Count) then
  begin
    case Alias of
      0: PropName := Props[Index].EngName;
    else
      PropName := Props[Index].RusName;
    end;
    Result := S_OK;
  end
  else begin
    PropName := '';
    Result := S_FALSE;
  end;
end;

{ Получение значения свойства }

function ToleAddin.GetPropVal(Index: Integer; var Value: OleVariant): HResult;
var
  DispParams: TDispParams;
begin
  VarClear(Value);
  FillChar(DispParams, SizeOf(DispParams), 0);
  Result := Invoke(Props[Index].MemId, GUID_NULL,
    0, DISPATCH_PROPERTYGET, DispParams, @Value,
    nil, nil);

  // Свойства BOOL преобразуются в Integer
  if Props[Index].vt = VT_BOOL then
    Value := BoolToInt[Boolean(Value)];
  // Свойства CURRENCY преобразуются в Double
  if Props[Index].vt = VT_CY then
    Value := Double(Value);
end;

{ Все методы возвращают значения }

function ToleAddin.HasRetVal(Index: Integer; var RetValue: Integer): HResult;
begin
  RetValue := 1;
  Result := S_OK;
end;

{ Читается ли свойство }

function ToleAddin.IsPropReadable(Index: Integer; var Value: Integer): HResult;
begin
  Result := S_FALSE;
  if (Index >= 0) and (Index < Props.Count) then
  begin
    Value := BoolToInt[Props[Index].IsReadable];
    Result := S_OK;
  end;
end;

{ Записывается ли свойство }

function ToleAddin.IsPropWritable(Index: Integer; var Value: Integer): HResult;
begin
  Result := S_FALSE;
  if (Index >= 0) and (Index < Props.Count) then
  begin
    Value := BoolToInt[Props[Index].IsWritable];
    Result := S_OK;
  end;
end;

{ Запись свойства }

const
  DispIDArgs: Longint = DISPID_PROPERTYPUT;

function ToleAddin.SetPropVal(Index: Integer; var Value: OleVariant): HResult;
var
  DispParams: TDispParams;
begin
  with DispParams do
  begin
    rgvarg := @Value;
    rgdispidNamedArgs := @DispIDArgs;
    cArgs := 1;
    cNamedArgs := 1;
  end;
  Result := Invoke(Props[Index].MemId, GUID_NULL, 0,
    DISPATCH_PROPERTYPUT, DispParams, nil, nil, nil);
end;

end.
