unit fmuUltraLight;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, Buttons;

type
  TfmUltraLight = class(TPage)
    Memo: TMemo;
    btnRead: TBitBtn;
    btnWrite: TBitBtn;
    procedure btnReadClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

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
    if Driver.PiccActivateWakeUp <> 0 then
      Driver.PiccActivateWakeUp;
    // Данные 16 блоков
    for i := 0 to 3 do
    begin
      Driver.BlockNumber := i*4;
      Check(Driver.PiccRead);
      for j := 0 to 3 do
      begin
        BlockData := Copy(Driver.BlockDataHex, j*8+1, 8);
        Memo.Lines.Add(BlockData);
      end;
    end;
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

procedure TfmUltraLight.btnWriteClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    if Driver.PiccActivateWakeUp <> 0 then
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

end.
