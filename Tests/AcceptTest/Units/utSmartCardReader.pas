unit utSmartCardReader;

interface

uses
  // VCL
  Windows, SysUtils, Classes, Forms, ComObj, ActiveX,
  // DUnit
  TestFramework,
  // This
  OmnikeyReader5422, SCardSyn, WinSCard, WinSmCrd, SCardErr, untConst,
  DebugUtils, untUtil, ValueBlock;

type
  { TSmartCardReaderTest }

  TSmartCardReaderTest = class(TTestCase)
  private
    Reader: TOmnikeyReader5422;
  protected
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure CheckWriteKeyToReader;
    procedure CheckMifareCard;
  end;

implementation

{ TSmartCardReaderTest }

procedure TSmartCardReaderTest.Setup;
begin
  Reader := TOmnikeyReader5422.Create;
end;

procedure TSmartCardReaderTest.TearDown;
begin
  Reader.Free;
end;

procedure TSmartCardReaderTest.CheckWriteKeyToReader;
var
  Key: string;
  ReaderNames: TStrings;
begin
  ReaderNames := TStringList.Create;
  try
    ReaderNames.Text := Reader.ListReaders;
    Check(ReaderNames.Count > 0, 'No readers connected');

    Reader.ReaderName := ReaderNames[1];
    Reader.Connect;
    CheckEquals(SCARD_PROTOCOL_T1, Reader.Protocol, 'Reader.Protocol');

    //Key := #$00#$01#$02#$03#$04#$05;
    //Key := #$00#$00#$00#$00#$00#$00;
    Key := #$FF#$FF#$FF#$FF#$FF#$FF;
    Reader.WriteKeyToReader(0, Key, False, 0);
  finally
    ReaderNames.Free;
  end;
end;

procedure TSmartCardReaderTest.CheckMifareCard;
var
  UID: string;
  BlockData: string;
  BlockData2: string;
  BlockNumber: Integer;
  ReaderNames: TStrings;
begin
  ReaderNames := TStringList.Create;
  try
    ReaderNames.Text := Reader.ListReaders;
    Check(ReaderNames.Count > 0, 'No readers connected');

    Reader.ReaderName := ReaderNames[1];
    Reader.Connect;
    CheckEquals(SCARD_PROTOCOL_T1, Reader.Protocol, 'Reader.Protocol');

    UID := Reader.ReadUID;
    ODS('UID: ' + StrToHex(UID));

    Reader.Authenticate(0, PICC_AUTHENT1A, 0);
    for BlockNumber := 0 to 3 do
    begin
      BlockData := Reader.ReadBinary(BlockNumber);
      ODS(Format('Block%d: %s', [BlockNumber, StrToHex(BlockData)]));
    end;

    BlockData := Reader.ReadBinary(1);
    BlockData := StringOfChar('A', Length(BlockData));
    Reader.WriteBinary(1, BlockData);

    BlockData2 := Reader.ReadBinary(1);
    CheckEquals(StrToHex(BlockData), StrToHex(BlockData2), 'BlockData');
  finally
    ReaderNames.Free;
  end;
end;

initialization
  RegisterTest('', TSmartCardReaderTest.Suite);

end.
