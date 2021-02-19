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
    Memo.Lines.Add(' ��������    ������, 4 �����');
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
          Line := Line + Format('������: %d, %s', [
            ResultCode, Driver.ResultDescription]);
        end;
        Memo.Lines.Add(Line);
      end;
    end;
    Memo.Lines.Add(Separator);

    if Pages.Count >= 4 then
    begin
      SerialNumber := StrToHex(Copy(Pages[0], 1, 3) + Pages[1]);
      Memo.Lines.Add('�������� �����: ' + SerialNumber);
      Memo.Lines.Add('OTP ������: ' + StrToHex(Pages[3]));

      Data := Pages[3];
      Memo.Lines.Add(Format('OTP ��������: %d, %s', [
        BinToInt(Data, 1, 4), StrToHex(Data)]));
      Memo.Lines.Add(Separator);
    end;

    if Pages.Count >= 3 then
    begin
      Data := Pages[2];
      if Length(Data) >= 4 then
      begin
        LockByte := Ord(Data[3]);
        Memo.Lines.Add(Format('������� 0: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, '����������� ������ OTP');
        AddBit(LockByte, 1, '����������� ������� 9-4');
        AddBit(LockByte, 2, '����������� ������� 15-10');
        AddBit(LockByte, 3, '����������� OTP');
        AddBit(LockByte, 4, '����������� �������� 4');
        AddBit(LockByte, 5, '����������� �������� 5');
        AddBit(LockByte, 6, '����������� �������� 6');
        AddBit(LockByte, 7, '����������� �������� 7');

        LockByte := Ord(Data[4]);
        Memo.Lines.Add(Format('������� 1: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, '����������� �������� 8');
        AddBit(LockByte, 1, '����������� �������� 9');
        AddBit(LockByte, 2, '����������� �������� 10');
        AddBit(LockByte, 3, '����������� �������� 11');
        AddBit(LockByte, 4, '����������� �������� 12');
        AddBit(LockByte, 5, '����������� �������� 13');
        AddBit(LockByte, 6, '����������� �������� 14');
        AddBit(LockByte, 7, '����������� �������� 15');
      end;
    end;

    if Pages.Count >= 41 then
    begin
      Data := Pages[40];
      if Length(Data) > 1 then
      begin
        LockByte := Ord(Data[1]);
        Memo.Lines.Add(Format('������� 2: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, '����������� ������� 1-3');
        AddBit(LockByte, 1, '����������� �������� 16-19');
        AddBit(LockByte, 2, '����������� �������� 20-23');
        AddBit(LockByte, 3, '����������� �������� 24-27');
        AddBit(LockByte, 4, '����������� ������� 5-7');
        AddBit(LockByte, 5, '����������� �������� 28-31');
        AddBit(LockByte, 6, '����������� �������� 32-35');
        AddBit(LockByte, 7, '����������� �������� 36-39');

        LockByte := Ord(Data[2]);
        Memo.Lines.Add(Format('������� 3: 0x%.2x', [LockByte]));
        AddBit(LockByte, 0, '����������� ������ COUNT');
        AddBit(LockByte, 0, '����������� ������ AUTH0');
        AddBit(LockByte, 0, '����������� ������ AUTH1');
        AddBit(LockByte, 0, '����������� ������ KEY');
        AddBit(LockByte, 0, '������ COUNT, �������� 41');
        AddBit(LockByte, 0, '������ AUTH0, �������� 42');
        AddBit(LockByte, 0, '������ AUTH1, �������� 43');
        AddBit(LockByte, 0, '������ KEY, �������� 44-47');
      end;
    end;
  finally
    Pages.Free;
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

end.
