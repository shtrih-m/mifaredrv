unit SCardUtil;

interface

uses
  // VCL
  Windows, SysUtils,
  // This
  MifareLib_TLB;

const
  UNKNOWNCARD 	        = $0000;
  Mifare_Standard_1K    = $0001;
  Mifare_Standard_4K    = $0002;
  Mifare_Ultra_light    = $0003;
  SLE55R_XXXX 	        = $0004;
  SR176		              = $0006;
  SRI_X4K 	            = $0007;
  AT88RF020	            = $0008;
  AT88SC0204CRF	        = $0009;
  AT88SC0808CRF	        = $000A;
  AT88SC1616CRF	        = $000B;
  AT88SC3216CRF	        = $000C;
  AT88SC6416CRF	        = $000D;
  SRF55V10P	            = $000E;
  SRF55V02P	            = $000F;
  SRF55V10S	            = $0010;
  SRF55V02S	            = $0011;
  TAG_IT	              = $0012;
  LRI512	              = $0013;
  ICODESLI	            = $0014;
  TEMPSENS	            = $0015;
  I_CODE1 	            = $0016;
  ICLASS2KS	            = $0018;
  ICLASS16KS	          = $001A;
  ICLASS8x2KS 	        = $001C;
  ICLASS32KS_16_16      = $001D;
  ICLASS32KS_16_8x2     = $001E;
  ICLASS32KS_8x2_16     = $001F;
  ICLASS32KS_8x2_8x2    = $0020;
  LRI64                 = $0021;
  I_CODE_UID            = $0022;
  I_CODE_EPC            = $0023;
  LRI12                 = $0024;
  LRI128                = $0025;
  Mifare_Mini           = $0026;
  myd_move_SLE_66R01P  = $0027;
  myd_NFC_SLE_66RxxP   = $0028;
  myd_proximity_2_SLE_66RxxS = $0029;
  myd_proximity_enhanced_SLE_55RxxE = $002A;
  myd_light_SRF_55V01P = $002B;
  PJM_Stack_Tag_SRF_66V10ST = $002C;
  PJM_Item_Tag_SRF_66V10IT = $002D;
  PJM_Light_SRF_66V01ST = $002E;
  Jewel_Tag = $002F;
  Topaz_NFC_Tag = $0030;
  AT88SC0104CRF = $0031;
  AT88SC0404CRF = $0032;
  AT88RF01C = $0033;
  AT88RF04C = $0034;
  iCode_SL2 = $0035;
  MIFARE_Plus_SL1_2K = $0036;
  MIFARE_Plus_SL1_4K = $0037;
  MIFARE_Plus_SL2_2K = $0038;
  MIFARE_Plus_SL2_4K = $0039;
  MIFARE_Ultralight_C = $003A;
  FeliCa = $003B;
  Melexis_Sensor_Tag_MLX90129 = $003C;
  MIFARE_Ultralight_EV1 = $003D;


  MIFARE_AUTHENT1A      = $60; // for authentication with Mifare key A
  MIFARE_AUTHENT1B      = $61; // for authentication with Mifare key B

  MIFARE_KEY_INPUT	= $00; // If key is provided
  MIFARE_KEYNR_INPUT	= $01; // If key is taken from the reader Mifare key storage

function SCardGetErrorMessage(Code: Integer): string;
function ATRToCardCode(const ATR: string): Integer;
function GetCardName(Code: Integer): string;
function CardCodeToCardType(Code: Integer): TCardType;

implementation

{ System error messages }

function ModErrorMessage(ErrorCode: Integer): string;
var
  Len: Integer;
  Buffer: array[0..255] of Char;
begin
  Len := FormatMessage(FORMAT_MESSAGE_FROM_HMODULE or
    FORMAT_MESSAGE_ARGUMENT_ARRAY, Pointer(hInstance), ErrorCode, 0, Buffer,
    SizeOf(Buffer), nil);
  while (Len > 0) and (Buffer[Len - 1] in [#0..#32, '.']) do Dec(Len);
  SetString(Result, Buffer, Len);
end;

function SCardGetErrorMessage(Code: Integer): string;
begin
  Result := SysErrorMessage(Code);
  if Result = '' then
    Result := ModErrorMessage(Code);
    if Result = '' then
      Result := 'Описание ошибки недоступно';
  Result := Format('0x%.8xh, %s', [Code, Result]);
end;

(*
// 3B8F8001804F0CA00000030603003A0000000051 - MifareUltraLightC

3B 8F 80 01
80 - TLV
4F - AppID
0C - length
A000000306 = appID
03 - SS - standard
003A - card name
00000000 - RFU
51 - XOR CRC


// '3B 8F 80 01 80 4F 0C A0 00 00 03 06 03 00 01 00 00 00 00 6A'

*)

function ATRToCardCode(const ATR: string): Integer;
begin
  Result := UNKNOWNCARD;
  //old driver version
  if (Length(ATR) = 17) and(ATR[1] = #$0F) and (ATR[2] = #$FF) then
  begin
    case Ord(ATR[16]) of
      $11: Result := Mifare_Standard_1K;
      $21: Result := Mifare_Standard_4K;
      $31: Result := Mifare_Ultra_light;
      $93: Result := ICLASS2KS;
      $A3: Result := ICLASS16KS;
      $B3: Result := ICLASS8x2KS;
    end;
  end;
  //new driver ps/sc atr
  if (Length(ATR) = 20) then
  begin
    Result := (Ord(ATR[14]) shl 8) + Ord(ATR[15]);
  end;
end;

function GetCardName(Code: Integer): string;
begin
  case Code of
    $0000: Result := 'No information given';
    $0001: Result := 'Mifare Standard 1K';
    $0002: Result := 'Mifare Standard 4K';
    $0003: Result := 'Mifare Ultra light';
    $0004: Result := 'SLE55R_XXXX';
    $0006: Result := 'SR176';
    $0007: Result := 'SRI X4K';
    $0008: Result := 'AT88RF020';
    $0009: Result := 'AT88SC0204CRF';
    $000A: Result := 'AT88SC0808CRF';
    $000B: Result := 'AT88SC1616CRF';
    $000C: Result := 'AT88SC3216CRF';
    $000D: Result := 'AT88SC6416CRF';
    $000E: Result := 'SRF55V10P';
    $000F: Result := 'SRF55V02P';
    $0010: Result := 'SRF55V10S';
    $0011: Result := 'SRF55V02S';
    $0012: Result := 'TAG_IT';
    $0013: Result := 'LRI512';
    $0014: Result := 'ICODESLI';
    $0015: Result := 'TEMPSENS';
    $0016: Result := 'I.CODE1';
    $0017: Result := 'PicoPass 2K';
    $0018: Result := 'PicoPass 2KS';
    $0019: Result := 'PicoPass 16K';
    $001A: Result := 'PicoPass 16Ks';
    $001B: Result := 'PicoPass 16K(8x2)';
    $001C: Result := 'PicoPass 16KS(8x2)';
    $001D: Result := 'PicoPass 32KS(16+16)';
    $001E: Result := 'PicoPass 32KS(16+8x2)';
    $001F: Result := 'PicoPass 32KS(8x2+16)';
    $0020: Result := 'PicoPass 32KS(8x2+8x2)';
    $0021: Result := 'LRI64';
    $0022: Result := 'I.CODE UID';
    $0023: Result := 'I.CODE EPC';
    $0024: Result := 'LRI12';
    $0025: Result := 'LRI128';
    $0026: Result := 'Mifare Mini';
    $0027: Result := 'my-d move (SLE 66R01P)';
    $0028: Result := 'my-d NFC (SLE 66RxxP)';
    $0029: Result := 'my-d proximity 2 (SLE 66RxxS)';
    $002A: Result := 'my-d proximity enhanced (SLE 55RxxE)';
    $002B: Result := 'my-d light (SRF 55V01P))';
    $002C: Result := 'PJM Stack Tag (SRF 66V10ST)';
    $002D: Result := 'PJM Item Tag (SRF 66V10IT)';
    $002E: Result := 'PJM Light (SRF 66V01ST)';
    $002F: Result := 'Jewel Tag';
    $0030: Result := 'Topaz NFC Tag';
    $0031: Result := 'AT88SC0104CRF';
    $0032: Result := 'AT88SC0404CRF';
    $0033: Result := 'AT88RF01C';
    $0034: Result := 'AT88RF04C';
    $0035: Result := 'i-Code SL2';
    $0036: Result := 'MIFARE Plus SL1_2K';
    $0037: Result := 'MIFARE Plus SL1_4K';
    $0038: Result := 'MIFARE Plus SL2_2K';
    $0039: Result := 'MIFARE Plus SL2_4K';
    $003A: Result := 'MIFARE Ultralight C';
    $003B: Result := 'FeliCa';
    $003C: Result := 'Melexis Sensor Tag (MLX90129)';
    $003D: Result := 'MIFARE Ultralight EV1';
  else
    Result := 'Unknown card';
  end;
end;
function CardCodeToCardType(Code: Integer): TCardType;
begin
  case Code of
    $0000: Result := ctUnknown;
    $0001: Result := ctMifare1K;
    $0002: Result := ctMifare4K;
    $0003: Result := ctMifareUltraLight;
    $0026: Result := ctMifareMini;
    $0036: Result := ctMifarePlus_2K_4UID_SL1;
    $0037: Result := ctMifarePlus_4K_4UID_SL1;
    $003A: Result := ctMifareUltraLight;
    $003D: Result := ctMifareUltraLight;
  else
    Result := ctUnknown;
  end;
end;

end.
