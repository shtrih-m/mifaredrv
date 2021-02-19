unit fmuUltraLightCData;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  // This
  MifareLib_TLB, untPage, untUtil;

type
  TfmUltraLightCData = class(TPage)
    Memo: TMemo;
    btnRead: TBitBtn;
    procedure btnReadClick(Sender: TObject);
  private
    procedure AddBit(Value, BitNumber: Integer; const BitName: string);
  end;

implementation

{$R *.DFM}

procedure TfmUltraLightCData.AddBit(Value, BitNumber: Integer;
  const BitName: string);
var
  Line: string;
const
  BoolToStr: array [Boolean] of string = ('[ ]', '[X]');
begin
  Line := Format('  %s, %s', [BoolToStr[TestBit(Value, BitNumber)], BitName]);
  Memo.Lines.Add(Line);
end;

procedure TfmUltraLightCData.btnReadClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  Line: string;
  Data: string;
  LockByte: Byte;
  Pages: TStrings;
  BlockData: string;
  PageNumber: Integer;
  ResultCode: Integer;
  SerialNumber: string;
const
  Separator = '----------------------------------------';
begin
  SerialNumber := '';

  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  Pages := TStringList.Create;
  try
    Memo.Clear;
    Memo.Lines.Add(Separator);
    Memo.Lines.Add(' Страница    Данные, 4 байта');
    Memo.Lines.Add(Separator);

    //Check(Driver.PiccActivateWakeUp);

    for i := 0 to 11 do
    begin
      Driver.BlockNumber := i*4;
      ResultCode := Driver.UltralightRead;
      for j := 0 to 3 do
      begin
        PageNumber := i*4 + j;
        BlockData := Copy(Driver.BlockDataHex, j*8+1, 8);
        Line := Format('  %.2d    0x%.3x  ', [PageNumber, PageNumber]);
        if ResultCode = 0 then
        begin
          Pages.Add(HexToStr(BlockData));
          Line := Line + BlockData;
        end else
        begin
          Pages.Add('');
          Line := Line + Format('Ошибка: %d, %s', [
            ResultCode, Driver.ResultDescription]);
        end;
        Memo.Lines.Add(Line);
      end;
    end;
    Memo.Lines.Add(Separator);

    if Pages.Count >= 4 then
    begin
      SerialNumber := StrToHex(Copy(Pages[0], 1, 3) + Pages[1]);
      Memo.Lines.Add('Серийный номер: ' + SerialNumber);
      Memo.Lines.Add('OTP данные: ' + StrToHex(Pages[3]));

      Data := Pages[3];
      Memo.Lines.Add(Format('OTP значение: %d, %s', [
        BinToInt(Data, 1, 4), StrToHex(Data)]));
      Memo.Lines.Add(Separator);
    end;

    if Pages.Count >= 3 then
    begin
      Data := Pages[2];
      if Length(Data) >= 4 then
      begin
        LockByte := Ord(Data[3]);
        Memo.Lines.Add(Format('Локбайт 0: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, 'Блокировать локбит OTP');
        AddBit(LockByte, 1, 'Блокировать локбиты 9-4');
        AddBit(LockByte, 2, 'Блокировать локбиты 15-10');
        AddBit(LockByte, 3, 'Блокировать OTP');
        AddBit(LockByte, 4, 'Блокировать страницу 4');
        AddBit(LockByte, 5, 'Блокировать страницу 5');
        AddBit(LockByte, 6, 'Блокировать страницу 6');
        AddBit(LockByte, 7, 'Блокировать страницу 7');

        LockByte := Ord(Data[4]);
        Memo.Lines.Add(Format('Локбайт 1: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, 'Блокировать страницу 8');
        AddBit(LockByte, 1, 'Блокировать страницу 9');
        AddBit(LockByte, 2, 'Блокировать страницу 10');
        AddBit(LockByte, 3, 'Блокировать страницу 11');
        AddBit(LockByte, 4, 'Блокировать страницу 12');
        AddBit(LockByte, 5, 'Блокировать страницу 13');
        AddBit(LockByte, 6, 'Блокировать страницу 14');
        AddBit(LockByte, 7, 'Блокировать страницу 15');
      end;
    end;

    if Pages.Count >= 41 then
    begin
      Data := Pages[40];
      if Length(Data) > 1 then
      begin
        LockByte := Ord(Data[1]);
        Memo.Lines.Add(Format('Локбайт 2: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, 'Блокировать локбиты 1-3');
        AddBit(LockByte, 1, 'Блокировать страницы 16-19');
        AddBit(LockByte, 2, 'Блокировать страницы 20-23');
        AddBit(LockByte, 3, 'Блокировать страницы 24-27');
        AddBit(LockByte, 4, 'Блокировать локбиты 5-7');
        AddBit(LockByte, 5, 'Блокировать страницы 28-31');
        AddBit(LockByte, 6, 'Блокировать страницы 32-35');
        AddBit(LockByte, 7, 'Блокировать страницы 36-39');

        LockByte := Ord(Data[2]);
        Memo.Lines.Add(Format('Локбайт 3: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, 'Блокировать локбит COUNT');
        AddBit(LockByte, 0, 'Блокировать локбит AUTH0');
        AddBit(LockByte, 0, 'Блокировать локбит AUTH1');
        AddBit(LockByte, 0, 'Блокировать локбит KEY');
        AddBit(LockByte, 0, 'Локбит COUNT, страница 41');
        AddBit(LockByte, 0, 'Локбит AUTH0, страница 42');
        AddBit(LockByte, 0, 'Локбит AUTH1, страница 43');
        AddBit(LockByte, 0, 'Локбит KEY, страницы 44-47');
      end;
    end;
  finally
    Pages.Free;
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

end.
