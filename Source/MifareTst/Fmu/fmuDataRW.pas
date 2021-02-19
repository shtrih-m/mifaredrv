unit fmuDataRW;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, Spin;

type
  TfmDataRW = class(TPage)
    btnRead: TButton;
    btnWrite: TButton;
    procedure btnReadClick(Sender: TObject);
    procedure btnWriteHexClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmData }

procedure TfmDataRW.btnReadClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    // Активация карты
    Driver.BaudRate := 0;
    Check(Driver.PiccActivateWakeUp);
    // Авторизация ключом по умолчанию для Mifare Classic
    Driver.KeyType := ktKeyA;
    Driver.KeyEncoded := '0F0F0F0F0F0F0F0F0F0F0F0F';
    Driver.BlockNumber := 0;
    Check(Driver.PiccAuthKey);
    // Чтение данных
    Check(Driver.PiccRead);

  finally
    EnableButtons(True);
  end;
end;

procedure TfmDataRW.btnWriteHexClick(Sender: TObject);
begin
(*
  EnableButtons(False);
  try
    Driver.BlockDataHex := edtBlockDataHex.Text;
    Driver.BlockNumber := seBlockNumber.Value;
    Driver.PiccWrite;
  finally
    EnableButtons(True);
  end;
*)
end;

end.
