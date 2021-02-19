unit DriverTest;

interface

uses
  // VCL
  Windows, Variants, SysUtils,
  // This
  TestFramework, ole1C, MifareLib_TLB, untUtil, CardField, untError, untConst;

{******************************************************************************

   ���� �������� � �������: Mifare1K, Mifare4K, MifareUltraLight
   ����� ���������� �����: ~ 30 ������

   ��� ������ � ������� ���� ���������� ����� 4 � 5
   ��� ������ ����� ����� Mifare1K � Mifare4K ������
   ��������� ������ ������ � ����� 4 � 5. � ������
   MifareUltraLight ��� ���������� �� ������\������.

{******************************************************************************}

type
  { TDriverTest }

  TDriverTest = class(TTestCase)
  private
    Driver: IMifareDrv;
    SavePortNumber: Integer;
    procedure CheckBlock(BlockNumber, BlockValue, BlockAddr: Integer);
    function GetValueBlock(BlockValue, BlockAddr: Integer): string;
    procedure CheckResult(Code1, Code2: Integer; const MethodName: string);
    procedure CheckValue(Value1, Value2: Variant; const Text: string);
    procedure CreateTestFields(Fields: TCardFields);
    procedure DriverToFields(Fields: TCardFields);
    procedure FieldsToDriver(Fields: TCardFields);
    function WriteField(FirmCode, AppCode, DataSize: Integer): Integer;
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure ShowProperties;
    procedure CheckDevice;
    procedure CheckCloseAfterDestroy;
    procedure ClosePort;
    procedure Connect;
    procedure DecodeValueBlock;
    procedure Disconnect;
    procedure EncodeKey;
    procedure EncodeValueBlock;
    procedure LoadParams;
    procedure OpenPort;
    procedure PcdBeep;
    procedure PcdConfig;
    procedure PcdGetFwVersion;
    procedure PcdGetRicVersion;
    procedure PcdGetSerialNumber;
    procedure PcdLoadKeyE2;
    procedure PcdReadE2;
    procedure PcdReset;
    procedure PcdRfReset;
    procedure PcdSetDefaultAttrib;
    procedure PcdSetTmo;
    procedure PcdWriteE2;
    procedure PiccActivateIdle;
    procedure PiccActivateWakeup;
    procedure PiccAnticoll;
    procedure PiccAuth;
    procedure PiccAuthE2;
    procedure PiccAuthKey;
    procedure PiccCascAnticoll;
    procedure PiccCascSelect;
    procedure PiccCommonRead;
    procedure PiccCommonRequest;
    procedure PiccCommonWrite;
    procedure PiccHalt;
    procedure PiccRead;
    procedure PiccSelect;
    procedure PiccValue;
    procedure PiccValueDebit;
    procedure PiccWrite;
    procedure PortOpened;
    procedure RequestAll;
    procedure RequestIdle;
    procedure SaveParams;
    procedure SetDefaults;
    procedure StartTransTimer;
    procedure StopTransTimer;
    procedure WriteFields;
    procedure CheckDirectory;
    procedure WriteEmptyField;
    procedure WriteLongField48;
    procedure WriteLongField1K;
    procedure WriteLongFieldEx;
    procedure WriteData;
    procedure KeyA;
    procedure KeyB;

  end;

implementation

function IsPortOpened(PortNumber: Integer): Boolean;
var
  DeviceName: string;
  DeviceHandle: THandle;
begin
  DeviceName := '\\.\COM' + IntToStr(PortNumber);
  DeviceHandle := CreateFile(PCHAR(DeviceName),
    GENERIC_READ or GENERIC_WRITE, 0, nil,
    OPEN_EXISTING, 0, 0);

  Result := DeviceHandle = INVALID_HANDLE_VALUE;
  if not Result then CloseHandle(DeviceHandle);
end;

{ TDriverTest }

procedure TDriverTest.Setup;
begin
  Driver := Tole1C.Create;
end;

procedure TDriverTest.TearDown;
begin
  Driver := nil;
end;

procedure TDriverTest.CheckResult(Code1, Code2: Integer;
  const MethodName: string);
var
  S: string;
begin
  S := Format('%s: %d <> %d, %s', [MethodName, Code1, Code2, Driver.ResultDescription]);
  Check(Code1 = Code2, S);
end;

procedure TDriverTest.CheckValue(Value1, Value2: Variant; const Text: string);
var
  S1: string;
  S2: string;
begin
  S1 := VarToStr(Value1);
  S2 := VarToStr(Value2);
  Check(S1 = S2, Format('%s: %s <> %s',[Text, S1, S2]));
end;

procedure TDriverTest.ShowProperties;
begin
  Driver.ShowProperties;
end;

(*******************************************************************************

  ������ ����� ������ ������ DataSize ��� ���������� ����� FirmCode � �����
  AppCode. ����� ��������� ������ ����� �� �����, ����� ������ ��� � ����������
  � ����������. ��� ������������� ������ ������ ��� ������ ������������ ��� ������

*******************************************************************************)

function TDriverTest.WriteField(FirmCode, AppCode, DataSize: Integer): Integer;

  procedure DriverCheck(Code: Integer);
  begin
    if Code <> 0 then
      RaiseError(Driver.ResultCode, GetResultDescription(Driver.ResultCode));
  end;

var
  i: Integer;
  Src: TCardFields;
  Dst: TCardFields;
  Field: TCardField;
begin
  Result := 0;
  Src := TCardFields.Create;
  Dst := TCardFields.Create;
  try
    try
      // ��������� ����������
      Driver.KeyA := 'KeyA';
      Driver.KeyB := 'KeyB';
      Driver.FirmCode := FirmCode;
      Driver.AppCode := AppCode;

      Field := Src.Add;
      Field.FieldType := ftString;
        for i := 1 to DataSize do
          Field.Value := Field.Value + 'A';

      Field.Size := Length(Field.Value);
      FieldsToDriver(Src);
      // ����� ���� � ��������� ��
      DriverCheck(Driver.WriteFields);
      DriverCheck(Driver.ClearFieldValues);
      DriverCheck(Driver.ReadFields);
      DriverToFields(Dst);
      Check(Src.IsEqual(Dst));
    finally
      Result := Driver.ResultCode;
      Src.Free;
      Dst.Free;
    end;
  except
  { !!! }
  end;
end;

// ����� ������ ������ ����� �������� ����,
// �� ������� ��� ������ �����������

procedure TDriverTest.CheckDevice;
begin
  CheckResult(Driver.FindDevice, 0, 'FindDevice');
end;

procedure TDriverTest.CheckCloseAfterDestroy;
var
  PortNumber: Integer;
begin
  PortNumber := Driver.PortNumber;
  CheckResult(Driver.Connect, 0, 'Connect');
  Check(IsPortOpened(Driver.PortNumber));
  Driver := nil;
  Check(not IsPortOpened(PortNumber));
end;

procedure TDriverTest.ClosePort;
begin
  CheckResult(Driver.Connect, 0, 'Connect');
  Check(IsPortOpened(Driver.PortNumber));
  CheckResult(Driver.ClosePort, 0, 'ClosePort');
  Check(not IsPortOpened(Driver.PortNumber));
end;

procedure TDriverTest.Connect;
begin
  Check(not IsPortOpened(Driver.PortNumber));
  CheckResult(Driver.Connect, 0, 'Connect');
  Check(IsPortOpened(Driver.PortNumber));
end;

procedure TDriverTest.Disconnect;
begin
  Connect;
  CheckResult(Driver.Disconnect, 0, 'Disconnect');
  Check(not IsPortOpened(Driver.PortNumber));
end;

procedure TDriverTest.DecodeValueBlock;
const
  BlockAddr  = $0F;
  BlockValue = $12345678;
begin
  Driver.BlockAddr := BlockAddr;
  Driver.BlockValue := BlockValue;
  CheckResult(Driver.EncodeValueBlock, 0, 'EncodeValueBlock');
  CheckValue(Driver.BlockDataHex, '7856341287A9CBED785634120FF00FF0', 'BlockDataHex');

  Driver.BlockAddr := 0;
  Driver.BlockValue := 0;
  CheckResult(Driver.DecodeValueBlock, 0, 'DecodeValueBlock');
  Check(Driver.BlockAddr = BlockAddr);
  Check(Driver.BlockValue = BlockValue);
end;

{ !!! }

procedure TDriverTest.EncodeKey;
begin
  Driver.KeyUncoded := '000000000000';
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  Check(Driver.KeyEncoded = 'F0F0F0F0F0F0F0F0F0F0F0F0');
end;

procedure TDriverTest.EncodeValueBlock;
const
  BlockAddr  = $0F;
  BlockValue = $12345678;
begin
  Driver.BlockAddr := BlockAddr;
  Driver.BlockValue := BlockValue;
  CheckResult(Driver.EncodeValueBlock, 0, 'EncodeValueBlock');
  Check(Driver.BlockDataHex = '12345678EDCBA987123456780FF00FF0');

  Driver.BlockAddr := 0;
  Driver.BlockValue := 0;
  Check(Driver.DecodeValueBlock = 0);
  Check(Driver.BlockAddr = BlockAddr);
  Check(Driver.BlockValue = BlockValue);
end;

procedure TDriverTest.LoadParams;
begin
  SavePortNumber := Driver.PortNumber;
  try
    Driver.PortNumber := 10;
    Check(Driver.SaveParams = 0);
    Driver.PortNumber := 1;
    Check(Driver.LoadParams = 0);
    Check(Driver.PortNumber = 10);
  finally
    Driver.PortNumber := SavePortNumber;
  end;
end;

procedure TDriverTest.OpenPort;
begin
  Check(not IsPortOpened(Driver.PortNumber));
  Check(Driver.OpenPort = 0);
  Check(IsPortOpened(Driver.PortNumber));
end;

procedure TDriverTest.PcdBeep;
begin
  Check(Driver.PcdBeep = 0);
end;

procedure TDriverTest.PcdConfig;
begin
  Check(Driver.PcdConfig = 0);
end;

procedure TDriverTest.PcdGetFwVersion;
begin
  Check(Driver.PcdFWVersion = '');
  Check(Driver.PcdGetFwVersion = 0);
  Check(Driver.PcdFWVersion <> '');
end;

procedure TDriverTest.PcdGetRicVersion;
begin
  Check(Driver.PcdRicVersion = '');
  Check(Driver.PcdGetRicVersion = 0);
  Check(Driver.PcdRicVersion <> '');
end;

procedure TDriverTest.PcdGetSerialNumber;
begin
  Check(Driver.UIDHex = '');
  Check(Driver.PcdGetSerialNumber = 0);
  Check(Driver.UIDHex <> '');
end;

(*
���������� 6-�������� (��������������) ���� �� ���������� ���������� EEPROM ������.
������� ���������:
key_type - ��� ����� (���� � ��� ���� �): PICC_AUTHENT1A ��� PICC_AUTHENT1B
sector - ����� ������� � ������ (0..15), ���� ������������ ����
uncoded_keys - ��������� �� 6-�������� ���� � �������������� ����
*)

procedure TDriverTest.PcdLoadKeyE2;
begin
  // ����� �
  Driver.KeyType := ktKeyA;
  Driver.KeyUncoded := '828347682374';
  Driver.KeyNumber := 0;
  Check(Driver.PcdLoadKeyE2 = 0);
  Driver.KeyNumber := 15;
  Check(Driver.PcdLoadKeyE2 = 0);
  // ����� �
  Driver.KeyType := ktKeyB;
  Driver.KeyUncoded := '828347682374';
  Driver.KeyNumber := 0;
  Check(Driver.PcdLoadKeyE2 = 0);
  Driver.KeyNumber := 15;
  Check(Driver.PcdLoadKeyE2 = 0);
  // �������� ����� �����
  Driver.KeyNumber := 16;
  Check(Driver.PcdLoadKeyE2 <> 0);

  Check(Driver.PiccActivateWakeup = 0);
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    // Key A
    Driver.KeyType := ktKeyA;
    Driver.KeyUncoded := 'FFFFFFFFFFFF'; //HexToStr('F0F0F0F0F0F0F0F0F0F0F0F');
    Driver.KeyNumber := 0;
    Check(Driver.PcdLoadKeyE2 = 0);
    Driver.BlockNumber := 0;
    Check(Driver.PiccAuth = 0);
    // Key B
    Driver.KeyType := ktKeyB;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Driver.KeyNumber := 0;
    Check(Driver.PcdLoadKeyE2 = 0);
    Driver.BlockNumber := 0;
    Check(Driver.PiccAuth = 0);
  end;
end;

procedure TDriverTest.PcdReadE2;
begin
  Driver.BlockNumber := 0;
  Driver.DataLength := 16;
  CheckResult(Driver.PcdReadE2, 0, 'PcdReadE2');
end;

procedure TDriverTest.PcdReset;
begin
  Check(Driver.PcdReset = 0);
  Check(Driver.PcdConfig = 0);
end;

(*

������� ��������� ��������� �� ��������� ����� �����������,
��� ����� � ������ ���� ���� � ���� � �������� �� � ��������� IDLE (��������).
������� ���������:
ms - ����� � �������������, �� ������� ����� ��������� ����.
��� ������ ���� Mifare Standard ���������� 10��.

� ����� �������� �����, ���������� ���� � ��������� �� ���������.
������ ���� ����������� � ������ ���� �����.
*)

(*
FCT_PREF Mf500PiccActivateWakeup(unsigned char br, unsigned char *atq,
unsigned char *sak, unsigned char *uid, unsigned char *uid_len);

������� ��������� ���������� ����������, �� ����������� ����,
��� �������� ����� �� ������ � ��������� IDLE (��������), �� � HALT (�������).
*)

procedure TDriverTest.PcdRfReset;
begin
  // ��������� ��������� �� ��������
  Check(Driver.PiccActivateWakeup = 0);
  Check(Driver.PiccActivateWakeup <> 0);
  // ����� ������ ��������� ��������� ��������
  Check(Driver.PiccActivateWakeup = 0);
  Driver.RfResetTime := 10;
  Check(Driver.PcdRfReset = 0);
  Check(Driver.PiccActivateWakeup = 0);
end;

procedure TDriverTest.PcdSetDefaultAttrib;
begin
  Check(Driver.PcdSetDefaultAttrib = 0);
end;

procedure TDriverTest.PcdSetTmo;
begin
  Check(Driver.PcdSetTmo = 0);
end;

procedure TDriverTest.PcdWriteE2;
begin
  { !!! }
  Check(Driver.PcdWriteE2 = 0);
end;

procedure TDriverTest.PiccActivateIdle;
begin
  Check(Driver.PiccActivateIdle = 0);
  Check(Driver.PiccActivateIdle <> 0);
end;

procedure TDriverTest.PiccActivateWakeup;
begin
  Check(Driver.PiccActivateWakeup = 0);
  Check(Driver.PiccActivateWakeup <> 0);
end;

procedure TDriverTest.PiccAnticoll;
begin
  // �� ������ ��������
  Driver.UIDHex := '';
  Driver.BitCount := 0;
  Check(Driver.PiccAnticoll <> 0);

  Check(Driver.PiccActivateWakeup = 0);
  Check(Driver.RequestAll <> 0);
  Check(Driver.RequestAll = 0);
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    // 32 ����
    Driver.BitCount := 32;
    Check(Driver.PiccAnticoll = 0);
    // 16 ���
    Driver.BitCount := 16;
    Driver.UIDHex := Copy(Driver.UIDHex, 1, 4);
    Check(Driver.PiccAnticoll = 0);
    // 8 ���
    Driver.BitCount := 8;
    Driver.UIDHex := Copy(Driver.UIDHex, 1, 2);
    Check(Driver.PiccAnticoll = 0);
  end;
end;

procedure TDriverTest.PiccAuth;
begin
  Check(Driver.PiccActivateWakeup = 0);
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.KeyType := ktKeyA;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Driver.KeyNumber := 0;
    Check(Driver.PcdLoadKeyE2 = 0);
    Driver.BlockNumber := 0;
    Check(Driver.PiccAuth = 0);
  end;
end;

procedure TDriverTest.PiccAuthE2;
begin
  Check(Driver.PiccActivateWakeup = 0);
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    // ���� A0
    Driver.KeyNumber := 0;
    Driver.KeyType := ktKeyA;
    Driver.BlockNumber := 0;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Check(Driver.PcdLoadKeyE2 = 0);
    Check(Driver.PiccAuthE2 = 0);
    // ���� �15
    Driver.KeyNumber := 15;
    Driver.KeyType := ktKeyB;
    Driver.BlockNumber := 0;
    Driver.KeyUncoded := 'FFFFFFFFFFFF';
    Check(Driver.PcdLoadKeyE2 = 0);
    Check(Driver.PiccAuthE2 = 0);
  end;
end;

procedure TDriverTest.PiccAuthKey;
begin
  Check(Driver.PiccActivateWakeup = 0);
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    // ����������� � 0 ����� �� ����������� ������
    Driver.KeyType := ktKeyA;
    Driver.KeyEncoded := '0F0F0F0F0F0F0F0F0F0F0F0F';
    Driver.BlockNumber := 0;
    Check(Driver.PiccAuthKey = 0);
    // ����������� � 0 ����� �� ����������� ������
    Driver.KeyType := ktKeyA;
    Driver.KeyEncoded := '1F0F0F0F0F0F0F0F0F0F0F0F';
    Driver.BlockNumber := 0;
    Check(Driver.PiccActivateWakeup <> 0);
    Check(Driver.PiccActivateWakeup = 0);
    Check(Driver.PiccAuthKey <> 0);
  end;
end;

(*
������� ��� ���������� ��������� ������������.
������������ ��� ������ � ������� UltraLight.
������� ���������:
select_code - ��� ������� (��� ������� ������ - 0x95)
bcnt - ����� ��������� ��� � ������ ����� (�� ������ ������)
snr - ��������������� ����, ���������� �������� ������
����������:
snr - ��������������� ����, ���������� ����� ����� ��������� (��� ������� ������)
*)

procedure TDriverTest.PiccCascAnticoll;
begin
  Driver.BitCount := 0;
  // �������� �����
  Driver.RfResetTime := 10;
  Check(Driver.PcdRfReset = 0);
  Check(Driver.RequestAll = 0);
  // 0 - invalid SelectCode
  Driver.SelectCode := 0;
  Check(Driver.PiccCascAnticoll <> 0);
  // scAnticoll1
  Check(Driver.RequestAll = 0);
  Driver.SelectCode := scAnticoll1;
  Check(Driver.PiccCascAnticoll = 0);
end;

procedure TDriverTest.PiccCommonRead;
var
  Data: string;
begin
  // ��������� �����
  Check(Driver.PiccActivateWakeup = 0);
  // ����������� � �����
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.KeyType := ktKeyA;
    Driver.BlockNumber := 0;
    Driver.KeyEncoded := '0F0F0F0F0F0F0F0F0F0F0F0F';
    Check(Driver.PiccAuthKey = 0);
  end;
  // dcRead16
  Driver.BlockNumber := 0;
  Driver.DataLength := 16;
  Driver.Command := dcRead16;
  Check(Driver.PiccCommonRead = 0);
  Data := Driver.BlockDataHex;
  Driver.BlockDataHex := '';
  Check(Driver.BlockDataHex = '');
  Check(Driver.PiccRead = 0);
  Check(Data = Driver.BlockDataHex);
  // �������� �������� ��������� Command
  Driver.DataLength := 16;
  Driver.Command := 0;
  Check(Driver.PiccCommonRead <> 0);
end;

procedure TDriverTest.PiccCommonRequest;
begin
  // ����� �����
  Driver.RfResetTime := 10;
  Check(Driver.PcdRfReset = 0);
  // ����� �� ������� - ������ ������ ���������
  Driver.ReqCode := rcIDLE;
  Check(Driver.PiccCommonRequest = 0);
  Check(Driver.PiccCommonRequest <> 0);
  // �������, ������� ����� ��� ��� - ������ ������ ���������
  Driver.ReqCode := rcALL;
  Check(Driver.PiccCommonRequest = 0);
  Check(Driver.PiccCommonRequest <> 0);

  Driver.ReqCode := 0;
  Check(Driver.PiccCommonRequest <> 0);
end;

{ ������ ������ �� ����� }

procedure TDriverTest.PiccCommonWrite;
const
  BlockData = '12345678901234567890123456789012';
begin
  // ��������� �����
  Check(Driver.PiccActivateWakeup = 0);
  // ����������� � ����� 4
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.KeyType := ktKeyA;
    Driver.BlockNumber := 4;
    Driver.KeyEncoded := '0F0F0F0F0F0F0F0F0F0F0F0F';
    Check(Driver.PiccAuthKey = 0);
    // dcWrite16
    Driver.DataLength := 16;
    Driver.Command := dcWrite16;
    Driver.BlockDataHex := BlockData;
    CheckResult(Driver.PiccCommonWrite, 0, 'PiccCommonWrite');

    Driver.BlockDataHex := '';
    Driver.Command := dcRead16;
    Check(Driver.PiccCommonRead = 0);
    Check(Driver.BlockDataHex = BlockData);
  end;
  // �� �������� ��� ���� ctMifare1K, ctMifare4K, ctMifareUltraLight
  // ��������� ������ � ��� ����� ���� ��������
  (*
    // dcWrite4
    Driver.DataLength := 4;
    Driver.Command := dcWrite4;
    Driver.BlockDataHex := BlockData;
    CheckResult(Driver.PiccCommonWrite, 0, 'PiccCommonWrite');

    Driver.BlockDataHex := '';
    Driver.Command := dcRead16;
    Check(Driver.PiccCommonRead = 0);
    Check(Driver.BlockDataHex = BlockData);
  *)
  // �������� �������� ��������� Command
  Driver.Command := 0;
  Driver.DataLength := 16;
  Check(Driver.PiccCommonWrite <> 0);
end;

{ ��� �������� �������� Halt ������ ������� PiccActivateIdle }
{ ��� �� ������ �����������, ������ ��� ����� � ��������� Halt }
{ � ��������� Halt ����� ����� ������������ ������ �������� WUPA }
{ �� ���� ������� PiccActivateWakeup }

procedure TDriverTest.PiccHalt;
begin
  Check(Driver.PiccActivateWakeup = 0);
  Check(Driver.PiccHalt = 0);
  Check(Driver.PiccActivateIdle <> 0);
  Check(Driver.PiccActivateWakeup = 0);
end;

procedure TDriverTest.PiccRead;
const
  BlockData = '1234567890123456';
var
  Block1: string;
  Block2: string;
begin
  // ��������� �����
  Check(Driver.PiccActivateWakeup = 0);
  // ����������� � �����
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.KeyType := ktKeyA;
    Driver.BlockNumber := 4;
    Driver.KeyEncoded := '0F0F0F0F0F0F0F0F0F0F0F0F';
    Check(Driver.PiccAuthKey = 0);
  end;
  // ������ �����
  Driver.BlockNumber := 4;
  Driver.BlockData := BlockData;
  Check(Driver.PiccWrite = 0);
  // ������ �����
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.BlockData := '';
    Driver.BlockNumber := 4;
    Check(Driver.PiccRead = 0);
    Check(Driver.BlockData = BlockData);
  end;
  // ��� ���� Mifare UltraLight ������� PiccWrite ������ ���������� 4 �����
  // ������� �� � ��������� ������ ������ 4 �����
  if Driver.CardType = ctMifareUltraLight then
  begin
    Driver.BlockData := '';
    Driver.BlockNumber := 4;
    Check(Driver.PiccRead = 0);
    Block1 := Copy(BlockData, 1, 4);
    Block2 := Copy(Driver.BlockData, 1, 4);
    Check(Block1 = Block2);
  end;
end;

procedure TDriverTest.PiccCascSelect;
begin
  // �������� �����
  Driver.RfResetTime := 10;
  Check(Driver.PcdRfReset = 0);
  Check(Driver.RequestAll = 0);
  Driver.BitCount := 0;
  Driver.SelectCode := scAnticoll1;
  Check(Driver.PiccCascAnticoll = 0);
  // 0 - invalid SelectCode
  Driver.SelectCode := 0;
  Check(Driver.PiccCascSelect <> 0);
  // scAnticoll1
  Check(Driver.RequestAll = 0);
  Driver.BitCount := 0;
  Driver.SelectCode := scAnticoll1;
  Check(Driver.PiccCascAnticoll = 0);
  Driver.SelectCode := scAnticoll1;
  CheckResult(Driver.PiccCascSelect, 0, 'PiccCascSelect');
end;

procedure TDriverTest.PiccSelect;
begin
  Driver.RfResetTime := 10;
  Check(Driver.PcdRfReset = 0);
  Check(Driver.RequestAll = 0);
  Driver.BitCount := 0;
  Driver.SelectCode := scAnticoll1;
  Check(Driver.PiccCascAnticoll = 0);
  CheckResult(Driver.PiccSelect, 0, 'PiccSelect');
end;

{ �������� �������� �����-�������� }
{ �������: ����� ���� �������������� � ����� ����� }

procedure TDriverTest.CheckBlock(BlockNumber, BlockValue, BlockAddr: Integer);
begin
  Driver.BlockNumber := BlockNumber;
  Check(Driver.PiccRead = 0);
  Check(Driver.DecodeValueBlock = 0);
  Check(Driver.BlockAddr = BlockAddr);
  Check(Driver.BlockValue = BlockValue);
end;

{ �������� ����� - �������� }

function TDriverTest.GetValueBlock(BlockValue, BlockAddr: Integer): string;
begin
  Driver.BlockAddr := BlockAddr;
  Driver.BlockValue := BlockValue;
  Check(Driver.EncodeValueBlock = 0);
  Result := Driver.BlockDataHex;
end;

procedure TDriverTest.PiccValue;
const
  BlockAddr = 6;
  BlockValue = 10;
begin
  // ������������
  Check(Driver.PiccActivateWakeup = 0);
  // ������ ��� ���� Mifare1K � Mifare4K
  // ����� Mifare UltraLight �� ������������ �������� � �������-���������� 
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.BlockNumber := 4;
    Driver.KeyType := ktKeyA;
    Driver.KeyEncoded := '0F0F0F0F0F0F0F0F0F0F0F0F';
    Check(Driver.PiccAuthKey = 0);
    // ���������� ����-��������
    Driver.BlockDataHex := GetValueBlock(BlockValue, BlockAddr);
    Check(Driver.PiccWrite = 0);
    // ��������� Increment
    Driver.DeltaValue := 5;
    Driver.BlockNumber := 4;
    Driver.TransBlockNumber := 5;
    Driver.ValueOperation := voIncrement;
    CheckResult(Driver.PiccValue, 0, 'PiccValue');
    CheckBlock(4, BlockValue, BlockAddr);
    CheckBlock(5, BlockValue + Driver.DeltaValue, BlockAddr);
    // ��������� Decrement
    Driver.DeltaValue := 5;
    Driver.BlockNumber := 4;
    Driver.TransBlockNumber := 5;
    Driver.ValueOperation := voDecrement;
    CheckResult(Driver.PiccValue, 0, 'PiccValue');
    CheckBlock(4, BlockValue, BlockAddr);
    CheckBlock(5, BlockValue - Driver.DeltaValue, BlockAddr);
    // ��������� Restore
    // � ���� 2 ���������� ����� ������,
    // ������� ������ ���� �������� �� �������� ����� 1
    Driver.BlockNumber := 5;
    Driver.BlockDataHex := '023850345872958';
    Check(Driver.PiccWrite = 0);
    Check(Driver.PiccRead = 0);
    Check(Driver.BlockDataHex = '02385034587295800000000000000000');

    Driver.DeltaValue := 5;
    Driver.BlockNumber := 4;
    Driver.TransBlockNumber := 5;
    Driver.ValueOperation := voRestore;
    CheckResult(Driver.PiccValue, 0, 'PiccValue');
    CheckBlock(4, BlockValue, BlockAddr);
    CheckBlock(5, BlockValue, BlockAddr);
    // ��������� Transfer
    // ������-�� �� ��������... { !!! }
  (*
    Driver.BlockNumber := 4;
    Driver.BlockDataHex := GetValueBlock(1, 6);
    Check(Driver.PiccWrite = 0);
    Driver.BlockNumber := 5;
    Driver.BlockDataHex := GetValueBlock(3, 6);
    Check(Driver.PiccWrite = 0);

  (*
    Driver.DeltaValue := 0;
    Driver.BlockNumber := 4;
    Driver.TransBlockNumber := 5;
    Driver.ValueOperation := voTransfer;
    CheckResult(Driver.PiccValue, 0, 'PiccValue');
    CheckBlock(4, BlockValue, BlockAddr);
    CheckBlock(5, BlockValue, BlockAddr);
  *)
  end;
end;

procedure TDriverTest.PiccValueDebit;
begin
  // �� �������� ��� ���� Mifare1K, Mifare4K, MifareUltraLight
  // ��� ����� ���� �������� - �� ����.
end;

procedure TDriverTest.PiccWrite;
const
  BlockData = '1234567890123456';
var
  Block1: string;
  Block2: string;
begin
  // ��������� �����
  Check(Driver.PiccActivateWakeup = 0);
  // ����������� � �����
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.KeyType := ktKeyA;
    Driver.BlockNumber := 4;
    Driver.KeyEncoded := '0F0F0F0F0F0F0F0F0F0F0F0F';
    Check(Driver.PiccAuthKey = 0);
  end;
  // ������ �����
  Driver.BlockNumber := 4;
  Driver.BlockData := BlockData;
  Check(Driver.PiccWrite = 0);
  // ������ �����
  if (Driver.CardType in [ctMifare1K, ctMifare4K]) then
  begin
    Driver.BlockData := '';
    Driver.BlockNumber := 4;
    Check(Driver.PiccRead = 0);
    Check(Driver.BlockData = BlockData);
  end;
  // ��� ���� Mifare UltraLight ������� PiccWrite ������ ���������� 4 �����
  // ������� �� � ��������� ������ ������ 4 �����
  if Driver.CardType = ctMifareUltraLight then
  begin
    Driver.BlockData := '';
    Driver.BlockNumber := 4;
    Check(Driver.PiccRead = 0);
    Block1 := Copy(BlockData, 1, 4);
    Block2 := Copy(Driver.BlockData, 1, 4);
    Check(Block1 = Block2);
  end;
end;

procedure TDriverTest.PortOpened;
begin
  Check(Driver.PortOpened <> 0);
  Check(Driver.OpenPort = 0);
  Check(Driver.PortOpened = 0);
end;

procedure TDriverTest.RequestAll;
begin
  // � ��������� Halt ����� ���������� �������� RequestAll
  Check(Driver.PiccActivateWakeup = 0);
  Check(Driver.PiccHalt = 0);
  Check(Driver.RequestAll = 0);
  // ����� ��������� ����� ��������� � ��������� Idle
  Driver.RfResetTime := 10;
  Check(Driver.PcdRfReset = 0);
  Check(Driver.RequestAll = 0);
end;

procedure TDriverTest.RequestIdle;
begin
  // � ��������� Halt ����� �� �������� �� ������ REQA
  Check(Driver.PiccActivateWakeup = 0);
  Check(Driver.PiccHalt = 0);
  Check(Driver.RequestIdle <> 0);
  // ����� ��������� ����� ��������� � ��������� Idle
  Driver.RfResetTime := 10;
  Check(Driver.PcdRfReset = 0);
  Check(Driver.RequestIdle = 0);
end;

procedure TDriverTest.SaveParams;
begin
  SavePortNumber := Driver.PortNumber;
  try
    Driver.PortNumber := 10;
    Check(Driver.SaveParams = 0);
    Driver.PortNumber := 1;
    Check(Driver.LoadParams = 0);
    Check(Driver.PortNumber = 10);
  finally
    Driver.PortNumber := SavePortNumber;
  end;
end;

procedure TDriverTest.SetDefaults;
begin
  SavePortNumber := Driver.PortNumber;
  try
    Driver.PortNumber := 10;
    Check(Driver.SetDefaults = 0);
    Check(Driver.PortNumber = 1);
  finally
    Driver.PortNumber := SavePortNumber;
  end;
end;

procedure TDriverTest.StartTransTimer;
begin
  Check(Driver.StartTransTimer = 0);
  Check(Driver.TransTime <= Integer(GetTickCount));
end;

procedure TDriverTest.StopTransTimer;
var
  TickCount: DWORD;
begin
  Check(Driver.TransTime = 0);
  TickCount := GetTickCount;
  Check(Driver.StartTransTimer = 0);
  Sleep(30);
  Check(Driver.StopTransTimer = 0);
  TickCount := GetTickCount - TickCount;
  Check(Driver.TransTime > 0);
  Check(Driver.TransTime <= Integer(TickCount));
end;

procedure TDriverTest.CheckDirectory;
begin
  Check(Driver.ReadDirectory = 0, 'ReadDirectory');
  Check(Driver.WriteDirectory = 0, 'WriteDirectory');
end;

procedure TDriverTest.CreateTestFields(Fields: TCardFields);
var
  Field: TCardField;
begin
  // �������� �����
  // ftByte
  Field := Fields.Add;
  Field.FieldType := ftByte;
  Field.Value := IntToStr(56);
  // ftSmallint
  Field := Fields.Add;
  Field.FieldType := ftSmallint;
  Field.Value := IntToStr(65534);
  // ftInteger
  Field := Fields.Add;
  Field.FieldType := ftInteger;
  Field.Value := IntToStr(50238402);
  // ftDouble
  Field := Fields.Add;
  Field.FieldType := ftDouble;
  Field.Value := FloatToStr(129.789);
  // ftBool
  Field := Fields.Add;
  Field.FieldType := ftBool;
  Field.Value := IntToStr(0);
  // ftString
  Field := Fields.Add;
  Field.FieldType := ftString;
  Field.Value := '0123456789';
  Field.Size := 10;
end;

procedure TDriverTest.FieldsToDriver(Fields: TCardFields);
var
  i: Integer;
  Field: TCardField;
begin
  Check(Driver.DeleteAllFields = 0);
  for i := 0 to Fields.Count-1 do
  begin
    Field := Fields[i];
    Driver.FieldSize := Field.Size;
    Driver.FieldType := Field.FieldType;
    Driver.FieldValue := Field.Value;
    Check(Driver.AddField = 0);
  end;
end;

procedure TDriverTest.DriverToFields(Fields: TCardFields);
var
  i: Integer;
  Count: Integer;
  Field: TCardField;
begin
  Count := Driver.FieldCount;
  for i := 0 to Count-1 do
  begin
    Driver.FieldIndex := i;
    Check(Driver.GetFieldParams = 0);
    Field := Fields.Add;
    Field.Size := Driver.FieldSize;
    Field.Value := Driver.FieldValue;
    Field.FieldType := Driver.FieldType;
  end;
end;

procedure TDriverTest.WriteFields;
var
  Src: TCardFields;
  Dst: TCardFields;
begin
  Src := TCardFields.Create;
  Dst := TCardFields.Create;
  try
    // ��������� ����������
    Driver.KeyA := 'KeyA';
    Driver.KeyB := 'KeyB';
    Driver.FirmCode := 1;
    Driver.AppCode := 10;

    CreateTestFields(Src);
    FieldsToDriver(Src);
    // ����� ���� � ��������� ��
    CheckResult(Driver.WriteFields, 0, 'WriteFields');
    Check(Driver.ClearFieldValues = 0);
    CheckResult(Driver.ReadFields, 0, 'ReadFields');

    DriverToFields(Dst);
    Check(Src.IsEqual(Dst));
  finally
    Src.Free;
    Dst.Free;
  end;
end;

(*******************************************************************************

      ������ ������ ������ - ������ ������������� �����

*******************************************************************************)

procedure TDriverTest.WriteEmptyField;
begin
  // ������ �� ����� ���� ������ ���������� 10
  CheckResult(WriteField(1, 10, 16), 0, 'WriteField');
  // ������ ������������ ������ 3 - �� ������� ������� ����������
  CheckResult(WriteField(1, 10, 0), 3, 'WriteField');
end;

(*******************************************************************************

      ������ ������ ������ ����� 48 ����

*******************************************************************************)

procedure TDriverTest.WriteLongField48;
begin
  CheckResult(WriteField(1, 10, 62), 0, 'WriteField');
end;

(*******************************************************************************

      ������ ������ ����� ������ ������� �����

*******************************************************************************)

procedure TDriverTest.WriteLongField1K;
begin
  CheckResult(WriteField(1, 11, 0), 3, 'WriteField');
  // ����� ����, ������ 14 ��������
  CheckResult(WriteField(1, 10, 14*48), 0, 'WriteField');
  // ������ ���� ������� 15 ��������, ������ ��������� ������ 4
  // (��� ��������� �������� ��� ������)
  CheckResult(WriteField(1, 10, 14*48+1), 4, 'WriteField');
end;

(*******************************************************************************

      ������ ������ ��� ���� ����������

*******************************************************************************)

procedure TDriverTest.WriteLongFieldEx;
begin
  // ������ 2 ����� ����������� 10
  CheckResult(WriteField(1, 10, 48), 0, 'WriteField');
  // ������� 3 � 4 ������ ����������� 11
  CheckResult(WriteField(1, 11, 96), 0, 'WriteField');
  // ������� 2 � 5 ������ ����������� 10
  CheckResult(WriteField(1, 10, 96), 0, 'WriteField');
  // �� ������� ��������� ��� ����� ������� ���������� 10,
  // ��� ��� ��� ������� ������ ����������� 11
  CheckResult(WriteField(1, 10, 14*48), 4, 'WriteField');
end;

(*******************************************************************************

        ������ ������ � �������������� �������� MikleSoft � ���
        (������ ������ � ��������)

********************************************************************************)

procedure TDriverTest.WriteData;

  function GetData(Size: Integer): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := 0 to Size-1 do
      Result := Result + Char(i mod 255);
  end;

  var
  Data: string;
begin
  // ������ � �������������� ��������
  Driver.DataMode := dmMikleSoftDir;
  Driver.FirmCode := 1;
  Driver.AppCode := 10;
  Driver.KeyA := 'KeyA';
  Driver.KeyB := 'KeyB';
  Data := GetData(48);
  Driver.Data := Data;
  CheckResult(Driver.WriteData, 0, 'WriteData');
  Driver.Data := '';
  Driver.DataSize := 48;
  CheckResult(Driver.ReadData, 0, 'ReadData');
  CheckValue(Driver.Data, Data, 'Data');

  // ������ ��� ������������� ��������
  Driver.DataMode := dmDirNotUsed;
  Driver.SectorNumber := 5;

  // ������ ������ ������ 48 ����
  CheckResult(Driver.WriteData, 0, 'WriteData');
  Driver.Data := '';
  CheckResult(Driver.ReadData, 0, 'ReadData');
  CheckValue(Driver.Data, Data, 'Data');

  // ������ ������ ������ ����� 48 ����
  Driver.Data := Data+'1';
  CheckResult(Driver.WriteData, 0, 'WriteData');
  Driver.Data := '';
  Driver.DataSize := 49;
  CheckResult(Driver.ReadData, 0, 'ReadData');
  CheckValue(Driver.Data, Data+'1', 'Data');

  // ������ ������ ������ 14*48 ����
  Driver.SectorNumber := 2;
  Data := GetData(14*48);
  Driver.Data := Data;
  CheckResult(Driver.WriteData, 0, 'WriteData');
  Driver.Data := '';
  // ������� �������� ������, ��� ���� � ��������� ������ ������� �� ����� �����.
  // � ���������� ����������� ������ � ��������� ������� �� ����� ����� � ������
  // �� ���������
  Driver.DataSize := 15*48;
  CheckResult(Driver.ReadData, 0, 'ReadData');
  CheckValue(Driver.Data, Data, 'Data');
  // ������ ������ ������ ����� 14*48 ����
  Driver.Data := Driver.Data + '1';
  //������ 4 -  ��� ��������� �������� ��� ������
  CheckResult(Driver.WriteData, 4, 'WriteData');

  // ������ �� ��������� � ��������� ������ �������,
  //������ 4 -  ��� ��������� �������� ��� ������
  Driver.Data := GetData(4*48);
  Driver.SectorNumber := 14;
  CheckResult(Driver.WriteData, 4, 'WriteData');

  // ����� �������� ����� �������
  Driver.SectorNumber := 1;
  CheckResult(Driver.WriteData, 12, 'WriteData');
  CheckResult(Driver.ReadData, 12, 'ReadData');
  Driver.SectorNumber := 16;
  CheckResult(Driver.WriteData, 12, 'WriteData');
  CheckResult(Driver.ReadData, 12, 'ReadData');
end;

procedure TDriverTest.KeyA;
begin
  Driver.BlockNumber := 7;
  Driver.KeyType := ktKeyA;
  Driver.PiccActivateWakeup;
  CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  Driver.KeyUncoded := 'FFFFFFFFFFFF';
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  CheckResult(Driver.PiccAuthKey, 0, 'PiccAuthKey');
  CheckResult(Driver.PiccRead, 0, 'PiccRead');
  // ���� � ��� ������ �������� ���������� ���������
  CheckValue(Driver.BlockDataHex, '000000000000FF078069FFFFFFFFFFFF', 'BlockDataHex');
  // ����� ����� ����
  Driver.BlockDataHex := '010203040506FF078069FFFFFFFFFFFF';
  CheckResult(Driver.PiccWrite, 0, 'PiccWrite');
  // ������������ � ����� ������
  Driver.PiccActivateWakeup;
  CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  Driver.KeyUncoded := '010203040506';
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  CheckResult(Driver.PiccAuthKey, 0, 'PiccAuthKey');
  // ��������������� ������ ����
  Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069FFFFFFFFFFFF';
  CheckResult(Driver.PiccWrite, 0, 'PiccWrite');
  Driver.PiccActivateWakeup;
end;

procedure TDriverTest.KeyB;
begin
  Driver.BlockNumber := 3;
  // ������������ � ������ B
  Driver.KeyType := ktKeyB;
  CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  Driver.KeyUncoded := 'FFFFFFFFFFFF';
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  CheckResult(Driver.PiccAuthKey, 0, 'PiccAuthKey');
  // �� ����� B ������ ������ �������
  CheckResult(Driver.PiccRead, -12, 'PiccRead');
  // �� ����� B ������ ������ � �������
  Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069010203040506';
  CheckResult(Driver.PiccWrite, -1, 'PiccWrite');
  // ������������ � ������ �
  Driver.KeyType := ktKeyA;
  CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  CheckResult(Driver.PiccAuthKey, 0, 'PiccAuthKey');
  CheckResult(Driver.PiccWrite, 0, 'PiccWrite');
  Driver.KeyType := ktKeyB;
  // ������������ � ����� ������ B
  Driver.PiccActivateWakeup;
  CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  Driver.KeyUncoded := '010203040506';
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  // ����������� �������� = ���� B ��� ������������� �������
  CheckResult(Driver.PiccAuthKey, 0, 'PiccAuthKey');
  // �� ����� B ������ ������ �������
  CheckResult(Driver.PiccRead, -12, 'PiccRead');
  CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  // ������������ ������ B � ����� ������
  Driver.BlockNumber := 2;
  Driver.KeyUncoded := '010203040506';
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  CheckResult(Driver.PiccAuthKey, 0, 'PiccAuthKey');
  // �� ����� B ������ ������ ������ � ������ transport configuration
  CheckResult(Driver.PiccRead, -12, 'PiccRead');
   CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  // �� ����� B ������ ������ ������ � ������ transport configuration
  CheckResult(Driver.PiccWrite, -1, 'PiccWrite');
  Driver.BlockNumber := 3;
  // ������������ � ������ A
  Driver.KeyType := ktKeyA;
  Driver.KeyUncoded := 'FFFFFFFFFFFF';
  CheckResult(Driver.PiccActivateWakeup, 0, 'PiccActivateWakeup');
  CheckResult(Driver.EncodeKey, 0, 'EncodeKey');
  CheckResult(Driver.PiccAuthKey, 0, 'PiccAuthKey');
  // ������ ������� �� ����� A
  CheckResult(Driver.PiccRead, 0, 'PiccRead');
  // ���� B = 010203040506
  CheckValue(Driver.BlockDataHex, '000000000000FF078069010203040506', 'BlockDataHex');
  // ��������������� ������ ����
  Driver.BlockDataHex := 'FFFFFFFFFFFFFF078069FFFFFFFFFFFF';
  CheckResult(Driver.PiccWrite, 0, 'PiccWrite');
  Driver.PiccActivateWakeup;
end;

initialization
  RegisterTest('', TDriverTest.Suite);

end.
