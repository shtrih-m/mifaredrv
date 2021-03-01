unit utOmnikey5422;

interface

uses
  // VCL
  Windows, SysUtils, Classes, Forms, Registry,
  // DUnit
  TestFramework,
  // This
  OmnikeyReader5422, DebugUtils, untUtil, SCardUtil;

type
  { TOmnikey5422Test }

  TOmnikey5422Test = class(TTestCase)
  private
    Reader: TOmnikeyReader5422;
  protected
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure TestReaderCapabilities;
    procedure TestUserEEPROM;
    procedure TestConfiguration;
    procedure TestContactlessSlot;
    procedure TestContactSlot;
    procedure TestMifareClassic;
    procedure TestMifareUltralight;
    procedure TestConactCard;
  end;

implementation

{ TOmnikey5422Test }

(*
 HID Global OMNIKEY 5422 Smartcard Reader 0
 HID Global OMNIKEY 5422CL Smartcard Reader 0
*)

procedure TOmnikey5422Test.Setup;
begin
  Reader := TOmnikeyReader5422.Create;
  Reader.ReaderName := 'HID Global OMNIKEY 5422CL Smartcard Reader 0';
  //Reader.ConnectionMode := ConnectionModeDirect;
  //Reader.ConnectionMode := ConnectionModeCard;
end;

procedure TOmnikey5422Test.TearDown;
begin
  Reader.Free;
end;

procedure TOmnikey5422Test.TestReaderCapabilities;
begin
  // Direct mode - no card is needed
  CheckEquals(1, Reader.ReadTlvVersion, 'Reader.ReadTlvVersion');
  CheckEquals('0007', Reader.ReadDeviceId, 'Reader.ReadDeviceId');
  CheckEquals('OMNIKEY 5422', Reader.ReadProductName, 'Reader.ReadProductName');
  CheckEquals('AViatoR', Reader.ReadProductPlatform, 'Reader.ReadProductPlatform');
  CheckEquals('1.0.0', Reader.ReadFirmwareVersion, 'Reader.ReadFirmwareVersion');
  CheckEquals('24', Reader.ReadHfControllerVersion, 'Reader.ReadHfControllerVersion');
  CheckEquals('PCB-00175 REV2', Reader.ReadHardwareVersion, 'Reader.ReadHardwareVersion');
  CheckEquals($B80, Reader.ReadEnabledClFeatures, 'Reader.ReadEnabledClFeatures');
  CheckEquals($02, Reader.ReadHostInterfaces, 'Reader.ReadHostInterfaces');
  CheckEquals(1, Reader.ReadNumberOfContactlessSlots, 'Reader.ReadNumberOfContactlessSlots');
  CheckEquals(1, Reader.ReadNumberOfAntennas, 'Reader.ReadNumberOfAntennas');
  CheckEquals(0, Reader.ReadHumanInterfaces, 'Reader.ReadHumanInterfaces');
  CheckEquals('HID Global', Reader.ReadVendorName, 'Reader.ReadVendorName');
  CheckEquals(4, Reader.ReadExchangeLevel, 'Reader.ReadExchangeLevel');
  CheckEquals('KJ0J0G00X01110202', Reader.ReadSerialNumber, 'Reader.ReadSerialNumber');
  CheckEquals('RC663', Reader.ReadHfControllerType, 'Reader.ReadHfControllerType');
  CheckEquals(1024, Reader.ReadSizeOfUserEEPROM, 'Reader.ReadSizeOfUserEEPROM');
  CheckEquals('OK5422-1.0.0.260-20170621T081213-3EA6F2C53A18-FLAS', Reader.ReadFirmwareLabel, 'Reader.ReadFirmwareLabel');
end;


procedure TOmnikey5422Test.TestUserEEPROM;
begin
  // 9D009000 - OK
  // 6700 - Invalid command
  Reader.WriteEEPROM($0000, HexToStr('AB'));

  CheckEquals('AB', StrToHex(Reader.ReadEEPROM($0000, 1)),
    'Reader.ReadEEPROM($0000, 1)');

    // write 16 bytes of FF starting from address 0x0001
  Reader.WriteEEPROM($0001, HexToStr('0123456789ABCDEF0123456789ABCDEF'));

  CheckEquals('0123456789ABCDEF0123456789ABCDEF',
    StrToHex(Reader.ReadEEPROM($0001, 16)), 'Reader.ReadEEPROM($0001, 16)');

end;

procedure TOmnikey5422Test.TestConfiguration;
begin
  Reader.ApplySettings;
  Reader.ResotoreFactoryDefaults;
  Reader.RebootReader;
end;

procedure TOmnikey5422Test.TestContactlessSlot;
begin
  // Iso14443TypeAEnable
  Reader.WriteIso14443TypeAEnable(False);
  CheckEquals(False, Reader.ReadIso14443TypeAEnable, 'Reader.ReadIso14443TypeAEnable');
  Reader.WriteIso14443TypeAEnable(True);
  CheckEquals(True, Reader.ReadIso14443TypeAEnable, 'Reader.ReadIso14443TypeAEnable');

  // MifareKeyCache
  Reader.WriteMifareKeyCache(True);
  CheckEquals(True, Reader.ReadMifareKeyCache, 'Reader.ReadMifareKeyCache');
  Reader.WriteMifareKeyCache(False);
  CheckEquals(False, Reader.ReadMifareKeyCache, 'Reader.ReadMifareKeyCache');

  // MifarePreferred
  Reader.WriteMifarePreferred(True);
  CheckEquals(True, Reader.ReadMifarePreferred, 'Reader.ReadMifarePreferred');
  Reader.WriteMifarePreferred(False);
  CheckEquals(False, Reader.ReadMifarePreferred, 'Reader.ReadMifarePreferred');

  // Iso14443TypeARxTxBaudRate
  Reader.WriteIso14443TypeARxTxBaudRate($22);
  CheckEquals($22, Reader.ReadIso14443TypeARxTxBaudRate, 'Reader.ReadIso14443TypeARxTxBaudRate');
  Reader.WriteIso14443TypeARxTxBaudRate($33);
  CheckEquals($33, Reader.ReadIso14443TypeARxTxBaudRate, 'Reader.ReadIso14443TypeARxTxBaudRate');

  // Iso14443TypeBEnable
  Reader.WriteIso14443TypeBEnable(False);
  CheckEquals(False, Reader.ReadIso14443TypeBEnable, 'Reader.ReadIso14443TypeBEnable');
  Reader.WriteIso14443TypeBEnable(True);
  CheckEquals(True, Reader.ReadIso14443TypeBEnable, 'Reader.ReadIso14443TypeBEnable');

  // Iso14443TypeBRxTxBaudRate
  Reader.WriteIso14443TypeBRxTxBaudRate($22);
  CheckEquals($22, Reader.ReadIso14443TypeBRxTxBaudRate, 'Reader.ReadIso14443TypeBRxTxBaudRate');
  Reader.WriteIso14443TypeBRxTxBaudRate($33);
  CheckEquals($33, Reader.ReadIso14443TypeBRxTxBaudRate, 'Reader.ReadIso14443TypeBRxTxBaudRate');
(*
  // Iso15693Enable
  Reader.WriteIso15693Enable(False);
  CheckEquals(False, Reader.ReadIso15693Enable, 'Reader.ReadIso15693Enable');
  Reader.WriteIso15693Enable(True);
  CheckEquals(True, Reader.ReadIso15693Enable, 'Reader.ReadIso15693Enable');
*)
  Sleep(500);
end;

procedure TOmnikey5422Test.TestMifareClassic;
begin
  Reader.LoadKey(0, HexToStr('FFFFFFFFFFFF'));

  Reader.Disconnect;
  Reader.ConnectionMode := ConnectionModeCard;
  CheckEquals('EA3B732E', StrToHex(Reader.ReadUID), 'Reader.ReadUID');

  Reader.GetStatus;
  CheckEquals(Mifare_Standard_1K, Reader.CardType, 'Reader.CardType');
  CheckEquals('3B8F8001804F0CA000000306030001000000006A', StrToHex(Reader.ATR), 'Reader.ATR');
  //CheckEquals('', StrToHex(Reader.ReadBinary(0)), 'Reader.ReadBinary(0)');
end;

(*
  // Auth

  byte keySlotNumber = 0x00;
  keyType := MifareKeyA;
  byte blockNumber = 0x04;
  byte blockSize = 0x10;
  Reader.MifareAuth(
  )

                // Authenticate block 4 with key loaded to reader
                command = contactlessCommands.GeneralAuthenticate.GetMifareApdu(blockNumber, keyType, keySlotNumber);
                response = reader.Transmit(command);
                string result = response == "9000" ? "Success" : "Error";
                PrintData($"Authenticate Block 0x{blockNumber:X2} ", command, response,
                    $"Key type: {keyType}, Key from slot {keySlotNumber:D}, {result}");

                // Update block 4 with write operation in value block format:
                // 4 byte value LSByte first, 4 byte bit inverted represetaton of value LSByte first, 4 byte value LSByte first, 1 byte block address, 1 byte bit inverted block address, 1 byte block address, 1 byte bit inverted block address
                int value = 1234567;

                string bigEndianValue = BitConverter.IsLittleEndian
                    ? BitConverter.ToString(BitConverter.GetBytes(value)).Replace("-", "")
                    : value.ToString("X8");
                string bigEndianInvertedValue = BitConverter.IsLittleEndian
                    ? BitConverter.ToString(BitConverter.GetBytes(~value)).Replace("-", "")
                    : (~value).ToString("X8");

                string data = bigEndianValue + bigEndianInvertedValue + bigEndianValue + $"{blockNumber:X2}" +
                              ((byte) ~blockNumber).ToString("X2") + $"{blockNumber:X2}" +
                              ((byte) ~blockNumber).ToString("X2");

                command = contactlessCommands.UpdateBinary.GetApdu(UpdateBinaryCommand.Type.Default, blockNumber, data);
                response = reader.Transmit(command);
                PrintData($"Write Block 0x{blockNumber:X2} with data: {data}", command, response, "");

                // Read current value
                command = contactlessCommands.ReadBinary.GetMifareReadApdu(blockNumber, blockSize);
                response = reader.Transmit(command);
                PrintData($"Read Block 0x{blockNumber:X2}", command, response,
                    $"Data: {response.Substring(0, response.Length - 4)}");

                // Increment value in block 4 by 1
                int incrementValue = 1;
                string incrementData = BitConverter.IsLittleEndian
                    ? BitConverter.ToString(BitConverter.GetBytes(incrementValue)).Replace("-", "")
                    : incrementValue.ToString("X8");
                command = contactlessCommands.Increment.GetApdu(blockNumber, incrementData);
                response = reader.Transmit(command);
                PrintData($"Increment by 1 the value in block 0x{blockNumber:X2}", command, response, "");

                // Read value after incrementation
                command = contactlessCommands.ReadBinary.GetMifareReadApdu(blockNumber, blockSize);
                response = reader.Transmit(command);
                PrintData($"Read Block 0x{blockNumber:X2}", command, response,
                    $"Data: {response.Substring(0, response.Length - 4)}");

                reader.Disconnect(CardDisposition.Unpower);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

*)


procedure TOmnikey5422Test.TestMifareUltralight;
var
  Answer: string;
  Command: string;
begin
  Reader.Disconnect;
  Reader.ConnectionMode := ConnectionModeCard;
  CheckEquals('047158E1ED2580', StrToHex(Reader.ReadUID), 'Reader.ReadUID');

  Reader.GetStatus;
  CheckEquals('3B8F8001804F0CA00000030603003A0000000051', StrToHex(Reader.ATR), 'Reader.ATR');
  CheckEquals(MIFARE_Ultralight_C, Reader.CardCode, 'Reader.CardCode');
  CheckEquals('047158A5E1ED2580A948000000000000', StrToHex(Reader.ReadBinary(0)), 'Reader.ReadBinary(0)');
  // User memmory 4..39
  Reader.WriteBinary(4, HexToStr('12345678123456781234567812345678'));
  CheckEquals('12345678123456781234567812345678', StrToHex(Reader.ReadBinary(4)), 'Reader.ReadBinary(4)');
  Reader.WriteBinary(4, HexToStr('00000000000000000000000000000000'));
  CheckEquals('00000000000000000000000000000000', StrToHex(Reader.ReadBinary(4)), 'Reader.ReadBinary(4)');
  CheckEquals('00000000000000000000000000000000', StrToHex(Reader.ReadBinary(8)), 'Reader.ReadBinary(8)');
  CheckEquals('00000000000000000000000000000000', StrToHex(Reader.ReadBinary(12)), 'Reader.ReadBinary(12)');
  // ...
  Command := 'FF96350000';
  CheckEquals($6A85, Reader.CardCommand(HexToStr(Command), Answer), Command);
  Command := 'FF96010900';
  CheckEquals($6400, Reader.CardCommand(HexToStr(Command), Answer), Command);
  Command := 'FF9601020A00000000000000000000';
  CheckEquals($6700, Reader.CardCommand(HexToStr(Command), Answer), Command);
  Command := 'FF9692090000';
  CheckEquals($6700, Reader.CardCommand(HexToStr(Command), Answer), Command);



  //CheckEquals('', StrToHex(Reader.ReadBinary(40)), 'Reader.ReadBinary(40)');

(*
  Reader.LoadKey(iClass3DESKeySlot, HexToStr('00000000000000000000000000000000'));
  Reader.Authenticate(41, MifareKeyA, 0);
  CheckEquals('', StrToHex(Reader.ReadBinary(41)), 'Reader.ReadBinary(41)');
*)
end;

// 6990

procedure TOmnikey5422Test.TestContactSlot;
var
  Flags: TVoltageSequenceFlags;
begin
  // ContactSlotEnable
  CheckEquals(True, Reader.ReadContactSlotEnable, 'Reader.ReadContactSlotEnable');
  Reader.WriteContactSlotEnable(False);
  CheckEquals(False, Reader.ReadContactSlotEnable, 'Reader.ReadContactSlotEnable');
  Reader.WriteContactSlotEnable(True);
  CheckEquals(True, Reader.ReadContactSlotEnable, 'Reader.ReadContactSlotEnable');
  // OperatingMode
  CheckEquals(Ord(Iso7816), Ord(Reader.ReadOperatingMode), 'Reader.ReadOperatingMode');
  Reader.WriteOperatingMode(EMVCo);
  CheckEquals(Ord(EMVCo), Ord(Reader.ReadOperatingMode), 'Reader.ReadOperatingMode');
  Reader.WriteOperatingMode(Iso7816);
  CheckEquals(Ord(Iso7816), Ord(Reader.ReadOperatingMode), 'Reader.ReadOperatingMode');
  // VoltageSequence
  Reader.SetAutomaticSequenceVoltageSequence;
  Flags := Reader.ReadVoltageSequence;
  CheckEquals(0, Ord(Flags[0]), 'ReadVoltageSequence[0]');
  CheckEquals(0, Ord(Flags[1]), 'ReadVoltageSequence[1]');
  CheckEquals(0, Ord(Flags[2]), 'ReadVoltageSequence[2]');

  Flags[0] := TVoltageFlag(1);
  Flags[1] := TVoltageFlag(2);
  Flags[2] := TVoltageFlag(3);
  Reader.WriteVoltageSequence(Flags);
  Flags := Reader.ReadVoltageSequence;
  CheckEquals(1, Ord(Flags[0]), 'ReadVoltageSequence[0]');
  CheckEquals(2, Ord(Flags[1]), 'ReadVoltageSequence[1]');
  CheckEquals(3, Ord(Flags[2]), 'ReadVoltageSequence[2]');
end;

procedure TOmnikey5422Test.TestConactCard;
begin
  CheckEquals(0, Reader.ReadErrorCounter, 'Reader.ReadErrorCounter');

end;

initialization
  RegisterTest('', TOmnikey5422Test.Suite);

end.
