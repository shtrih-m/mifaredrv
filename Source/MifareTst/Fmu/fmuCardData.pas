unit fmuCardData;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, Buttons;

type
  TfmCardData = class(TPage)
    Memo: TMemo;
    btnRead: TBitBtn;
    btnWrite: TBitBtn;
    btnReadTrailers: TBitBtn;
    procedure btnReadClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure btnReadTrailersClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmData }

(*

procedure TfmUltraLight.btnReadClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  BlockData: string;
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    Check(Driver.PiccActivateWakeUp);
    Memo.Lines.Add(StringOfChar('-', 35));
    //
    Memo.Lines.Add('Тип карты   : ' + Driver.CardDescription);
    Memo.Lines.Add('Номер карты : ' + Driver.UIDHex);
    // Данные 16 блоков
    Memo.Lines.Add(StringOfChar('-', 35));
    for i := 0 to 3 do
    begin
      Driver.BlockNumber := i*4;
      Check(Driver.PiccRead);
      for j := 0 to 3 do
      begin
        BlockData := Copy(Driver.BlockDataHex, j*8+1, 8);
        Memo.Lines.Add(Format('%.2d %s', [i*4 + j, BlockData]));
      end;
    end;
    Memo.Lines.Add(StringOfChar('-', 35));
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

*)

procedure TfmCardData.btnReadClick(Sender: TObject);
var
  i, j: Integer;
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Check(Driver.PiccActivateWakeup);
    // Данные 16 блоков
    for i := 0 to 15 do
    begin
      Driver.BlockNumber := i*4;
      Driver.KeyType := ktKeyA;
      Driver.KeyUncoded := 'FFFFFFFFFFFF';
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);

      for j := 0 to 3 do
      begin
        Driver.BlockNumber := i*4 + j;
        Check(Driver.PiccRead);
        Memo.Lines.Add(Format('Блок %.2d: %s',
          [Driver.BlockNumber, Driver.BlockDataHex]));
      end;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmCardData.btnWriteClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Driver.PiccActivateWakeUp;
    // Данные 16 блоков
    for i := 4 to 15 do
    begin
      Driver.BlockNumber := i;
      Driver.BlockDataHex := Memo.Lines[i];
      Check(Driver.PiccWrite);
    end;
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

procedure TfmCardData.btnReadTrailersClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Check(Driver.PiccActivateWakeup);
    // Данные 16 блоков
    for i := 0 to 15 do
    begin
      Driver.BlockNumber := i*4 + 3;
      Driver.KeyType := ktKeyA;
      Driver.KeyUncoded := 'FFFFFFFFFFFF';
      Check(Driver.EncodeKey);
      Check(Driver.PiccAuthKey);
      Check(Driver.PiccRead);
      Memo.Lines.Add(Format('Блок %.2d: %s',
        [Driver.BlockNumber, Driver.BlockDataHex]));
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
