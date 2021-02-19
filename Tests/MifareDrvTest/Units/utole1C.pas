unit utole1C;

interface

uses
  // VCL
  Windows, AxCtrls, ComServ, ActiveX, ComObj, Controls, SysUtils, Variants,
  // This
  TestFramework, Addinlib, ole1C, untAddin, DriverUtils, MifareLib_TLB;

{*****************************************************************************}
{
{       ����� ��������� ��� ������ ����� ��������� 1�
{       ����� �������� HelpString � TypeLibrary,
{       ���������� ���� ��������
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
  CheckTrue(IsPropReadable = 1, AEngName); // ��� �������� ����� ��������
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

  ����� ��������� ��� ������ ����� ��������� 1� ILanguageExtender

  1. ����� �������� HelpString � TypeLibrary, ���������� ���� ��������
  2. ��� � ��� �������������� TypeLibrary �������� ��� ������.
  3. ��� ������ (������ ��� ������������� ��������) ����� �����

*******************************************************************************}

procedure Tole1CTest.TestEngPropNames;
begin
  { ������ }
  CheckMethod('AboutBox', '����������');
  CheckMethod('AddField', '������������');
  CheckMethod('AuthStandard', '����������������������������');
  CheckMethod('ClearBlock', '������������');
  CheckMethod('ClearFieldValues', '���������������������');
  CheckMethod('ClosePort', '�����������');
  CheckMethod('Connect', '��������������������');
  CheckMethod('DecodeValueBlock', '�������������������������');
  CheckMethod('DeleteAllFields', '��������������');
  CheckMethod('DeleteAppSectors', '������������������������');
  CheckMethod('DeleteField', '�����������');
  CheckMethod('DeleteSector', '�������������');
  CheckMethod('Disconnect', '�������������������');
  CheckMethod('EncodeKey', '��������������');
  CheckMethod('EncodeValueBlock', '�����������������������');
  CheckMethod('FindDevice', '���������������');
  CheckMethod('GetFieldParams', '���������������������');
  CheckMethod('GetSectorParams', '������������������������');
  CheckMethod('InterfaceSetTimeout', '�����������������');
  CheckMethod('LoadFieldsFromFile', '��������������������');
  CheckMethod('LoadParams', '������������������');
  CheckMethod('OpenPort', '�����������');
  CheckMethod('PcdBeep', '�����');
  CheckMethod('PcdConfig', '��������������������');
  CheckMethod('PcdGetFwVersion', '����������������');
  CheckMethod('PcdGetRicVersion', '��������������rRIC');
  CheckMethod('PcdGetSerialNumber', '���������������������');
  CheckMethod('PcdLoadKeyE2', '������������');
  CheckMethod('PcdReadE2', '�������������');
  CheckMethod('PcdReset', '�������������������');
  CheckMethod('PcdRfReset', '�������������');
  CheckMethod('PcdSetDefaultAttrib', '����������������������������');
  CheckMethod('PcdSetTmo', '������������������������');
  CheckMethod('PcdWriteE2', '������������16');
  CheckMethod('PiccActivateIdle', '�������Idle�����');
  CheckMethod('PiccActivateWakeup', '���������������');
  CheckMethod('PiccAnticoll', '������������');
  CheckMethod('PiccAuth', '��������������');
  CheckMethod('PiccAuthE2', '����������������������');
  CheckMethod('PiccAuthKey', '���������������������');
  CheckMethod('PiccCascAnticoll', '����������������������������');
  CheckMethod('PiccCascSelect', '���������������������');
  CheckMethod('PiccCommonRead', '���������������');
  CheckMethod('PiccCommonRequest', '��������������');
  CheckMethod('PiccCommonWrite', '��������������');
  CheckMethod('PiccHalt', '���������������');
  CheckMethod('PiccRead', '���������������16');
  CheckMethod('PiccSelect', '��������������������');
  CheckMethod('PiccValue', '����������������');
  CheckMethod('PiccValueDebit', '���������������������');
  CheckMethod('PiccWrite', '��������������16');
  CheckMethod('PortOpened', '����������');
  CheckMethod('ReadDirectory', '���������������');
  CheckMethod('ReadFields', '�������������');
  CheckMethod('RequestAll', '�����������������');
  CheckMethod('RequestIdle', '���������Idle�����');
  CheckMethod('ResetCard', '�������������');
  CheckMethod('SaveFieldsToFile', '�������������������');
  CheckMethod('SaveParams', '������������������');
  CheckMethod('SendEvent', '��������������');
  CheckMethod('SetDefaults', '��������������������');
  CheckMethod('SetFieldParams', '�����������������������');
  CheckMethod('SetSectorParams', '��������������������������');
  CheckMethod('ShowDirectoryDlg', '���������������');
  CheckMethod('ShowFirmsDlg', '����������');
  CheckMethod('ShowProperties', '�����������������������');
  CheckMethod('ShowSearchDlg', '������������');
  CheckMethod('PollStart', '�����������');
  CheckMethod('StartTransTimer', '���������������');
  CheckMethod('PollStop', '�������������');
  CheckMethod('StopTransTimer', '�����������������');
  CheckMethod('TestBit', '������������');
  CheckMethod('WriteDirectory', '���������������');
  CheckMethod('WriteFields', '������������');
  { �������� }
  CheckProp('AppCode', '�������������', 1);
  CheckProp('ATQ', '����������', 0);
  CheckProp('BaudRate', '��������', 1);
  CheckProp('BeepTone', '����������', 1);
  CheckProp('BitCount', '�������������', 1);
  CheckProp('BlockAddr', '����������', 1);
  CheckProp('BlockData', '����������', 1);
  CheckProp('BlockDataHex', '����������Hex', 1);
  CheckProp('BlockNumber', '����������', 1);
  CheckProp('BlockValue', '�������������', 1);
  CheckProp('CardDescription', '�������������', 0);
  CheckProp('CardType', '��������', 0);
  CheckProp('Command', '�������', 1);
  CheckProp('Connected', '���������������������', 0);
  CheckProp('DataLength', '�����������', 1);
  CheckProp('DeltaValue', '���������', 1);
  CheckProp('DirectoryStatus', '�����������������', 0);
  CheckProp('DirectoryStatusText', '�������������������������', 0);
  CheckProp('ErrorText', '�����������', 0);
  CheckProp('ExecutionTime', '���������������', 0);
  CheckProp('FieldCount', '���������������', 0);
  CheckProp('FieldIndex', '����������', 1);
  CheckProp('FieldSize', '����������', 1);
  CheckProp('FieldType', '�������', 1);
  CheckProp('FieldValue', '������������', 1);
  CheckProp('FileName', '��������', 1);
  CheckProp('FirmCode', '��������', 1);
  CheckProp('IsClient1C', '������1�', 0);
  CheckProp('IsShowProperties', '����������������������', 0);
  CheckProp('KeyA', '����A', 1);
  CheckProp('KeyB', '����B', 1);
  CheckProp('KeyEncoded', '����������������', 1);
  CheckProp('KeyNumber', '����������', 1);
  CheckProp('KeyType', '��������', 1);
  CheckProp('KeyUncoded', '������������������', 1);
  CheckProp('LibInfoKey', '������������������������', 1);
  CheckProp('LockDevices', '�������������', 1);
  CheckProp('ParentWnd', '��������������', 1);
  CheckProp('PasswordHeader', '���������������', 0);
  CheckProp('PcdFwVersion', '��������', 0);
  CheckProp('PcdRicVersion', '������RIC', 0);
  CheckProp('PortNumber', '����������', 1);
  CheckProp('ReqCode', '����������', 1);
  CheckProp('ResultCode', '���������', 0);
  CheckProp('ResultDescription', '������������������', 0);
  CheckProp('RfResetTime', '�������������������', 1);
  CheckProp('RICValue', '��������RIC', 1);
  CheckProp('SAK', 'SAK', 0);
  CheckProp('SectorCount', '������������������', 0);
  CheckProp('SectorIndex', '�������������', 1);
  CheckProp('SectorNumber', '������������', 1);
  CheckProp('SelectCode', '���������', 1);
  CheckProp('Timeout', '�������', 1);
  CheckProp('TransBlockNumber', '������������������', 1);
  CheckProp('TransTime', '�������������', 1);
  CheckProp('UID', 'UID', 1);
  CheckProp('UIDHex', 'UIDHex', 1);
  CheckProp('UIDLen', '�����UID', 0);
  CheckProp('ValueOperation', '��������������������', 1);
  CheckProp('Version', '�����������', 0);
  CheckProp('PollStarted', '����������', 0);
  CheckProp('PollInterval', '��������������', 1);
end;

{*****************************************************************************}
{
{       ����� ���� �������� � ���, ��� �������� ���� WordBool ������
{       ������������ � 1� ��� Integer (0;1) ��� ����� ����������� VarType
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
{  �������� ���� ���������� ������� �������� � �������� ������
{
{*****************************************************************************}

procedure Tole1CTest.CheckBoolProps;
begin
  CheckBoolProp('LockDevices');
end;

{*****************************************************************************}
{
{       ��� ������ � �������� ������ ����� ������� ��������
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
{  ����� ����� ����� � ���, ��� �������� ������� �� ������ ��������� �
{  ���������� Get � Set ������� ��� �������.
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
