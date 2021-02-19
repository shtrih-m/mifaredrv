unit utOmnikeyReader;

interface

uses
  // VCL
  Windows, SysUtils, Classes, Forms, ComObj, ActiveX,
  // DUnit
  TestFramework,
  // This
  OmnikeyReader5422, SCardSyn, WinSCard, WinSmCrd, SCardErr, ValueBlock, untConst;

type
  { TOmnikeyReaderTest }

  TOmnikeyReaderTest = class(TTestCase)
  private
    Reader: TOmnikeyReader5422;
  protected
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure CheckIncrement;
  end;

implementation

{ TOmnikeyReaderTest }

procedure TOmnikeyReaderTest.Setup;
begin
  Reader := TOmnikeyReader5422.Create;
end;

procedure TOmnikeyReaderTest.TearDown;
begin
  Reader.Free;
end;

procedure TOmnikeyReaderTest.CheckIncrement;
var
  BlockData: string;
  Block: TValueBlockRec;
  ReaderNames: TStrings;
begin
  ReaderNames := TStringList.Create;
  try
    ReaderNames.Text := Reader.ListReaders;
    Check(ReaderNames.Count > 0, 'No readers connected');

    Reader.ReaderName := ReaderNames[1];
    Reader.Connect;
    CheckEquals(SCARD_PROTOCOL_T1, Reader.Protocol, 'Reader.Protocol');

    Reader.Authenticate(0, PICC_AUTHENT1A, 0);

    Block.Value := 123;
    Block.Address := 0;
    BlockData := EncodeValueBlock(Block);
    Reader.WriteBinary(1, BlockData);

    Reader.MifareIncrement(1, $768736E7);

    BlockData := Reader.ReadBinary(1);
    Block := DecodeValueBlock(BlockData);
    CheckEquals($76873762, Block.Value, 'Block.Value');
    CheckEquals(0, Block.Address, 'Block.Address');

    Reader.MifareDecrement(1, 123);
    BlockData := Reader.ReadBinary(1);
    Block := DecodeValueBlock(BlockData);
    CheckEquals($768736E7, Block.Value, 'Block.Value');
    CheckEquals(0, Block.Address, 'Block.Address');
  finally
    ReaderNames.Free;
  end;
end;

initialization
  RegisterTest('', TOmnikeyReaderTest.Suite);

end.
