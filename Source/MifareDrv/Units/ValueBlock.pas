unit ValueBlock;

interface

uses
  // VCL
  SysUtils,
  // This
  untUtil;

type
  { TValueBlockRec }

  TValueBlockRec = record
    Value: Integer;
    Address: Integer;
  end;

function EncodeValueBlock(const Block: TValueBlockRec): string;
function DecodeValueBlock(const BlockData: string): TValueBlockRec;

implementation

function EncodeValueBlock(const Block: TValueBlockRec): string;
begin
  Result :=
    IntToBin(Block.Value, 4) +
    IntToBin(not Block.Value, 4) +
    IntToBin(Block.Value, 4) +
    Chr(Block.Address) +
    Chr(not Block.Address) +
    Chr(Block.Address) +
    Chr(not Block.Address);
end;

function DecodeValueBlock(const BlockData: string): TValueBlockRec;
var
  V: Integer;
  i, j: Integer;
  CorrectValue: Boolean;
  BlockAddrs: array[0..3] of Byte;
  BlockValues: array[0..2] of Integer;
begin
  BlockValues[0] := BinToInt(BlockData, 1, 4);
  BlockValues[1] := not BinToInt(BlockData, 5, 4);
  BlockValues[2] := BinToInt(BlockData, 9, 4);
  BlockAddrs[0] := BinToInt(BlockData, 13, 1);
  BlockAddrs[1] := not BinToInt(BlockData, 14, 1);
  BlockAddrs[2] := BinToInt(BlockData, 15, 1);
  BlockAddrs[1] := not BinToInt(BlockData, 16, 1);
  // BlockValue
  CorrectValue := False;
  for i := 0 to 1 do
  begin
    V := BlockValues[i];
    for j := i + 1 to 2 do
    begin
      if V = BlockValues[j] then
      begin
        Result.Value := V;
        CorrectValue := True;
        Break;
      end;
    end;
    if CorrectValue then Break;
  end;
  if not CorrectValue then
    raise Exception.Create('Неверные даные блока');

  CorrectValue := False;
  for i := 0 to 2 do
  begin
    V := BlockAddrs[i];
    for j := i + 1 to 3 do
    begin
      if V = BlockAddrs[j] then
      begin
        Result.Address := V;
        CorrectValue := True;
        Break;
      end;
    end;
    if CorrectValue then Break;
  end;
  if not CorrectValue then
    raise Exception.Create('Неверные даные блока');
end;

end.
