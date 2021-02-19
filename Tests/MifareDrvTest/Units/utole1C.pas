unit utole1C;

interface

uses
  // VCL
  Windows, AxCtrls, ComServ, ActiveX, ComObj, Controls, SysUtils, Variants,
  // This
  TestFramework, Addinlib, ole1C, untAddin, DriverUtils, MifareLib_TLB;

{*****************************************************************************}
{
{       Нужно проверить все методы через интерфейс 1С
{       Вдруг собъется HelpString в TypeLibrary,
{       информация ведь двоичная
{
{*****************************************************************************}

type
  { Tole1CTest }

  Tole1CTest = class(TTestCase)
  private
    Drv: TOle1C;
    Driver: ILanguageExtender;
    procedure CheckBoolProp(const AEngName: string);
    procedure CheckMethod(const AEngName, ARusName: string);
    procedure CheckProp(const AEngName, ARusName: string; PropWritable: Integer);
  public
    procedure Setup; override;
    procedure TearDown; override;

    procedure CheckMultyInstance1;
    procedure CheckMultyInstance2;
    procedure CheckMultyInstance3;
  published
    procedure TestVCNames;
    procedure CheckBoolProps;
    procedure TestEngPropNames;
    procedure TestEmptyNames;
    procedure CheckTestBit;
  end;

implementation

{ Tole1CTest }

procedure Tole1CTest.Setup;
begin
  DisableDriverLog;
  Drv := Tole1C.Create;
  Driver := Drv as ILanguageExtender;
end;

procedure Tole1CTest.TearDown;
begin
  Driver := nil;
end;

procedure Tole1CTest.CheckProp(const AEngName, ARusName: string; PropWritable: Integer);
var
  EngNum: Integer;
  RusNum: Integer;
  EngName: WideString;
  RusName: WideString;
  IsPropReadable: Integer;
  IsPropWritable: Integer;
begin
  CheckTrue(Driver.FindProp(AEngName, EngNum) = 0, AEngName);
  CheckTrue(Driver.GetPropName(EngNum, 0, EngName) = 0, AEngName);
  CheckTrue(EngName = AEngName, AEngName);
  CheckTrue(Driver.IsPropReadable(EngNum, IsPropReadable) = 0, AEngName);
  CheckTrue(Driver.IsPropWritable(EngNum, IsPropWritable) = 0, AEngName);
  CheckTrue(IsPropReadable = 1, AEngName); // все свойства можно прочесть
  CheckTrue(IsPropWritable = PropWritable, AEngName);

  CheckTrue(Driver.FindProp(ARusName, RusNum) = 0, ARusName);
  CheckTrue(EngNum = RusNum, AEngName);
  CheckTrue(Driver.GetPropName(RusNum, 1, RusName) = 0, ARusName);
  CheckTrue(RusName = ARusName, ARusName);
end;

procedure Tole1CTest.CheckMethod(const AEngName, ARusName: string);
var
  EngNum: Integer;
  RusNum: Integer;
  EngName: WideString;
  RusName: WideString;
begin
  CheckTrue(Driver.FindMethod(AEngName, EngNum) = 0, AEngName);
  CheckTrue(Driver.GetMethodName(EngNum, 0, EngName) = 0, AEngName);
  Check(EngName = AEngName, AEngName);

  CheckTrue(Driver.FindMethod(ARusName, RusNum) = 0, ARusName);
  CheckTrue(EngNum = RusNum, AEngName);
  CheckTrue(Driver.GetMethodName(EngNum, 1, RusName) = 0, AEngName);
  Check(RusName = ARusName, AEngName);
end;

{*******************************************************************************

  Нужно проверить все методы через интерфейс 1С ILanguageExtender

  1. Вдруг собъется HelpString в TypeLibrary, информация ведь двоичная
  2. Или я при редактировании TypeLibrary случайно его изменю.
  3. Все ошибки (пустые или повторяющиеся названия) сразу видны

*******************************************************************************}

procedure Tole1CTest.TestEngPropNames;
begin
  { Методы }
  CheckMethod('AboutBox', 'ОПрограмме');
  CheckMethod('AddField', 'ДобавитьПоле');
  CheckMethod('AuthStandard', 'АвторизацияСтандартнымКлючом');
  CheckMethod('ClearBlock', 'ОчиститьБлок');
  CheckMethod('ClearFieldValues', 'ОчиститьЗначенияПолей');
  CheckMethod('ClosePort', 'ЗакрытьПорт');
  CheckMethod('Connect', 'УстановитьСоединение');
  CheckMethod('DecodeValueBlock', 'РаскодироватьБлокЗначение');
  CheckMethod('DeleteAllFields', 'УдалитьВсеПоля');
  CheckMethod('DeleteAppSectors', 'УдалитьСектораПриложения');
  CheckMethod('DeleteField', 'УдалитьПоле');
  CheckMethod('DeleteSector', 'УдалитьСектор');
  CheckMethod('Disconnect', 'РазорватьСоединение');
  CheckMethod('EncodeKey', 'КодироватьКлюч');
  CheckMethod('EncodeValueBlock', 'ФормироватьБлокЗначение');
  CheckMethod('FindDevice', 'ПоискУстройства');
  CheckMethod('GetFieldParams', 'ПолучитьПараметрыПоля');
  CheckMethod('GetSectorParams', 'ПолучитьПараметрыСектора');
  CheckMethod('InterfaceSetTimeout', 'УстановитьТаймаут');
  CheckMethod('LoadFieldsFromFile', 'ЗагрузитьПоляИзФайла');
  CheckMethod('LoadParams', 'ЗагрузитьПараметры');
  CheckMethod('OpenPort', 'ОткрытьПорт');
  CheckMethod('PcdBeep', 'Гудок');
  CheckMethod('PcdConfig', 'НастроитьСчитыватель');
  CheckMethod('PcdGetFwVersion', 'ПолучитьВерсиюПО');
  CheckMethod('PcdGetRicVersion', 'ПолучитьВерсиюrRIC');
  CheckMethod('PcdGetSerialNumber', 'ПолучитьСерийныйНомер');
  CheckMethod('PcdLoadKeyE2', 'ЗаписатьКлюч');
  CheckMethod('PcdReadE2', 'ПрочитатьКлюч');
  CheckMethod('PcdReset', 'СброситьСчитыватель');
  CheckMethod('PcdRfReset', 'ОтключитьПоле');
  CheckMethod('PcdSetDefaultAttrib', 'УстановитьНачальныеПараметры');
  CheckMethod('PcdSetTmo', 'УстановитьТаймаутКоманды');
  CheckMethod('PcdWriteE2', 'ЗаписатьКлюч16');
  CheckMethod('PiccActivateIdle', 'ВыбратьIdleКарты');
  CheckMethod('PiccActivateWakeup', 'ВыбратьВсеКарты');
  CheckMethod('PiccAnticoll', 'Антиколлизия');
  CheckMethod('PiccAuth', 'Авторизоваться');
  CheckMethod('PiccAuthE2', 'АвторизоватьсяПоНомеру');
  CheckMethod('PiccAuthKey', 'АвторизоватьсяПоКлючу');
  CheckMethod('PiccCascAnticoll', 'ПоследовательнаяАнтиколлизия');
  CheckMethod('PiccCascSelect', 'ПоследовательныйВыбор');
  CheckMethod('PiccCommonRead', 'ПрочитатьДанные');
  CheckMethod('PiccCommonRequest', 'ЗапроситьКарту');
  CheckMethod('PiccCommonWrite', 'ЗаписатьДанные');
  CheckMethod('PiccHalt', 'ОстановитьКарту');
  CheckMethod('PiccRead', 'ПрочитатьДанные16');
  CheckMethod('PiccSelect', 'ВыбратьКартуПоНомеру');
  CheckMethod('PiccValue', 'ИзменитьЗначение');
  CheckMethod('PiccValueDebit', 'ИзменитьЗначениеДебит');
  CheckMethod('PiccWrite', 'ЗаписатьДанные16');
  CheckMethod('PortOpened', 'ПортОткрыт');
  CheckMethod('ReadDirectory', 'ПрочестьКаталог');
  CheckMethod('ReadFields', 'ПрочитатьПоля');
  CheckMethod('RequestAll', 'ЗапроситьВсеКарты');
  CheckMethod('RequestIdle', 'ЗапроситьIdleКарты');
  CheckMethod('ResetCard', 'СброситьКарту');
  CheckMethod('SaveFieldsToFile', 'СохранитьПоляВФайле');
  CheckMethod('SaveParams', 'СохранитьПараметры');
  CheckMethod('SendEvent', 'ПослатьСобытие');
  CheckMethod('SetDefaults', 'ПараметрыПоУмолчанию');
  CheckMethod('SetFieldParams', 'УстановитьПараметрыПоля');
  CheckMethod('SetSectorParams', 'УстановитьПараметрыСектора');
  CheckMethod('ShowDirectoryDlg', 'ПоказатьКаталог');
  CheckMethod('ShowFirmsDlg', 'ДиалогФирм');
  CheckMethod('ShowProperties', 'ПоказатьСтраницуСвойств');
  CheckMethod('ShowSearchDlg', 'ДиалогПоиска');
  CheckMethod('PollStart', 'НачатьОпрос');
  CheckMethod('StartTransTimer', 'ЗапуститьТаймер');
  CheckMethod('PollStop', 'ПрерватьОпрос');
  CheckMethod('StopTransTimer', 'ОсттановитьТаймер');
  CheckMethod('TestBit', 'ПроверитьБит');
  CheckMethod('WriteDirectory', 'ЗаписатьКаталог');
  CheckMethod('WriteFields', 'ЗаписатьПоля');
  { Свойства }
  CheckProp('AppCode', 'КодПриложения', 1);
  CheckProp('ATQ', 'ОтветКарты', 0);
  CheckProp('BaudRate', 'Скорость', 1);
  CheckProp('BeepTone', 'НомерЗвука', 1);
  CheckProp('BitCount', 'КоличествоБит', 1);
  CheckProp('BlockAddr', 'АдресБлока', 1);
  CheckProp('BlockData', 'БлокДанных', 1);
  CheckProp('BlockDataHex', 'БлокДанныхHex', 1);
  CheckProp('BlockNumber', 'НомерБлока', 1);
  CheckProp('BlockValue', 'ЗначениеБлока', 1);
  CheckProp('CardDescription', 'ОписаниеКарты', 0);
  CheckProp('CardType', 'ТипКарты', 0);
  CheckProp('Command', 'Команда', 1);
  CheckProp('Connected', 'СоединениеУстановлено', 0);
  CheckProp('DataLength', 'ДлинаДанных', 1);
  CheckProp('DeltaValue', 'Изменение', 1);
  CheckProp('DirectoryStatus', 'СостояниеКаталога', 0);
  CheckProp('DirectoryStatusText', 'ОписаниеСостоянияКаталога', 0);
  CheckProp('ErrorText', 'ТекстОшибки', 0);
  CheckProp('ExecutionTime', 'ВремяВыполнения', 0);
  CheckProp('FieldCount', 'КоличествоПолей', 0);
  CheckProp('FieldIndex', 'ИндексПоля', 1);
  CheckProp('FieldSize', 'РазмерПоля', 1);
  CheckProp('FieldType', 'ТипПоля', 1);
  CheckProp('FieldValue', 'ЗначениеПоля', 1);
  CheckProp('FileName', 'ИмяФайла', 1);
  CheckProp('FirmCode', 'КодФирмы', 1);
  CheckProp('IsClient1C', 'Клиент1С', 0);
  CheckProp('IsShowProperties', 'СтраницаСвойствОткрыта', 0);
  CheckProp('KeyA', 'КлючA', 1);
  CheckProp('KeyB', 'КлючB', 1);
  CheckProp('KeyEncoded', 'КодированныйКлюч', 1);
  CheckProp('KeyNumber', 'НомерКлюча', 1);
  CheckProp('KeyType', 'ТипКлюча', 1);
  CheckProp('KeyUncoded', 'НекодированныйКлюч', 1);
  CheckProp('LibInfoKey', 'ТипИнформацииОБиблиотеке', 1);
  CheckProp('LockDevices', 'БлокироватьЛУ', 1);
  CheckProp('ParentWnd', 'ОкноПриложения', 1);
  CheckProp('PasswordHeader', 'ПарольЗаголовка', 0);
  CheckProp('PcdFwVersion', 'ВерсияПО', 0);
  CheckProp('PcdRicVersion', 'ВерсияRIC', 0);
  CheckProp('PortNumber', 'НомерПорта', 1);
  CheckProp('ReqCode', 'КодЗапроса', 1);
  CheckProp('ResultCode', 'Результат', 0);
  CheckProp('ResultDescription', 'ОписаниеРезультата', 0);
  CheckProp('RfResetTime', 'ВремяОтключенияПоля', 1);
  CheckProp('RICValue', 'ЗначениеRIC', 1);
  CheckProp('SAK', 'SAK', 0);
  CheckProp('SectorCount', 'КоличествоСекторов', 0);
  CheckProp('SectorIndex', 'ИндексСектора', 1);
  CheckProp('SectorNumber', 'НомерСектора', 1);
  CheckProp('SelectCode', 'КодВыбора', 1);
  CheckProp('Timeout', 'Таймаут', 1);
  CheckProp('TransBlockNumber', 'НомерБлокаХранения', 1);
  CheckProp('TransTime', 'ВремяОперации', 1);
  CheckProp('UID', 'UID', 1);
  CheckProp('UIDHex', 'UIDHex', 1);
  CheckProp('UIDLen', 'ДлинаUID', 0);
  CheckProp('ValueOperation', 'ОперацияНадЗначением', 1);
  CheckProp('Version', 'ВерсияФайла', 0);
  CheckProp('PollStarted', 'ОпросНачат', 0);
  CheckProp('PollInterval', 'ИнтервалОпроса', 1);
end;

{*****************************************************************************}
{
{       Смысл этой проверки в том, что свойства типа WordBool должны
{       возвращаться в 1С как Integer (0;1) Для этого проверяется VarType
{
{*****************************************************************************}

procedure Tole1CTest.CheckBoolProp(const AEngName: string);
var
  EngNum: Integer;
  PropVal: OleVariant;
begin
  CheckTrue(Driver.FindProp(AEngName, EngNum) = 0, AEngName);

  PropVal := 1;
  CheckTrue(Driver.SetPropVal(EngNum, PropVal) = 0);

  VarClear(PropVal);
  CheckTrue(Driver.GetPropVal(EngNum, PropVal) = 0);
  CheckTrue(VarType(PropVal) = varInteger);
  CheckTrue(PropVal = 1);
end;

{*****************************************************************************}
{
{  Проверка всех логических свойств сводится к проверке одного
{
{*****************************************************************************}

procedure Tole1CTest.CheckBoolProps;
begin
  CheckBoolProp('LockDevices');
end;

{*****************************************************************************}
{
{       Все методы и свойства должны иметь русские названия
{
{*****************************************************************************}

procedure Tole1CTest.TestEmptyNames;

  function IsDispatchMethod(const MethodName: string): Boolean;
  begin
    Result :=
      (MethodName = 'QueryInterface') or
      (MethodName = 'AddRef') or
      (MethodName = 'Release') or
      (MethodName = 'GetTypeInfoCount') or
      (MethodName = 'GetTypeInfo') or
      (MethodName = 'GetIDsOfNames') or
      (MethodName = 'Invoke');
  end;

  procedure CheckEmptyNames(Items: TAddinItems);
  var
    i: Integer;
    ItemName: string;
  begin
    for i := 0 to Items.Count-1 do
    begin
      ItemName := Items[i].EngName;
      Check(ItemName <> '', ItemName);
      if not IsDispatchMethod(ItemName) then
      begin
        ItemName := Items[i].RusName;
        Check(ItemName <> '', Items[i].EngName);
      end;
    end;
  end;

begin
  CheckEmptyNames(Drv.Props);
  CheckEmptyNames(Drv.Methods);
end;

{*****************************************************************************}
{
{  Смысл этого теста в том, что названия методов не должны совпадать с
{  названиеми Get и Set функций для свойств.
{
{*****************************************************************************}

procedure Tole1CTest.TestVCNames;
var
  i: Integer;
  PropName: string;
  GetPropName: string;
  SetPropName: string;
  Method: TAddinItem;
begin
  for i := 0 to Drv.Props.Count-1 do
  begin
    PropName := Drv.Props[i].EngName;
    GetPropName := 'Get' + PropName;
    SetPropName := 'Set' + PropName;

    Method := Drv.Methods.ItemByEngName(GetPropName);
    Check(Method = nil, GetPropName);

    Method := Drv.Methods.ItemByEngName(SetPropName);
    Check(Method = nil, SetPropName);
  end;
end;

procedure Tole1CTest.CheckTestBit;
begin
  Check(Drv.TestBit(1,0));
  Check(not Drv.TestBit(0,0));
  Check(Drv.TestBit($80,7));
  Check(not Drv.TestBit($7F,7));
end;

procedure Tole1CTest.CheckMultyInstance1;
var
  Drv1: IMifareDrv;
  Drv2: IMifareDrv;
begin
  Drv1 := Tole1C.Create;
  Drv1.PortNumber := 12;
  Drv1 := nil;

  Drv2 := Tole1C.Create;
  CheckEquals(12, Drv2.PortNumber, 'Drv2.PortNumber');
  Drv2 := nil;

  Drv1 := Tole1C.Create;
  Drv1.PortNumber := 15;
  Drv1 := nil;

  Drv2 := Tole1C.Create;
  CheckEquals(15, Drv2.PortNumber, 'Drv2.PortNumber');
  Drv2 := nil;
end;

procedure Tole1CTest.CheckMultyInstance2;
var
  Drv1: IMifareDrv;
  Drv2: IMifareDrv;
begin
  Drv1 := Tole1C.Create;
  Drv2 := Tole1C.Create;
  Drv1.PortNumber := 12;
  Drv2.PortNumber := 15;
  CheckEquals(12, Drv1.PortNumber, 'Drv1.PortNumber');
  CheckEquals(15, Drv2.PortNumber, 'Drv2.PortNumber');

  Drv2.PortNumber := 2;
  CheckEquals(12, Drv1.PortNumber, 'Drv1.PortNumber');
  CheckEquals(2, Drv2.PortNumber, 'Drv2.PortNumber');
end;

procedure Tole1CTest.CheckMultyInstance3;
var
  Drv1: IMifareDrv2;
  Drv2: IMifareDrv2;
begin
  OleCheck(CoInitialize(nil));
  Drv1 := TMifareDrv.Create(nil).ControlInterface;
  Drv2 := TMifareDrv.Create(nil).ControlInterface;
  Drv1.LogEnabled := True;
  Drv2.LogEnabled := True;

  Drv1.PortNumber := 12;
  Drv2.PortNumber := 15;
  CheckEquals(12, Drv1.PortNumber, 'Drv1.PortNumber');
  CheckEquals(15, Drv2.PortNumber, 'Drv2.PortNumber');

  Drv2.PortNumber := 2;
  CheckEquals(12, Drv1.PortNumber, 'Drv1.PortNumber');
  CheckEquals(2, Drv2.PortNumber, 'Drv2.PortNumber');
end;

initialization
  RegisterTest('', Tole1CTest.Suite);

end.
