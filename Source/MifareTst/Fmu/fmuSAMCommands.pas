unit fmuSAMCommands;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage, ComCtrls, Spin;

type
  { TfmSAMCommands }

  TfmSAMCommands = class(TPage)
    btnSAM_WriteHostAuthKey: TButton;
    edtKeyUncoded: TEdit;
    lblKey: TLabel;
    btnSAM_GetKeyEntry: TButton;
    Memo: TMemo;
    lblKeyEntryNumber: TLabel;
    btnReadFullSerialNumber: TButton;
    btnSAM_SetProtection: TButton;
    btnSAM_SetProtectionSN: TButton;
    lblSerialNumber: TLabel;
    edtSerialNumberHex: TEdit;
    seKeyEntryNumber: TSpinEdit;
    btnSAMGetKeyEntries: TButton;
    procedure btnSAM_WriteHostAuthKeyClick(Sender: TObject);
    procedure btnSAM_GetKeyEntryClick(Sender: TObject);
    procedure btnReadFullSerialNumberClick(Sender: TObject);
    procedure btnSAM_SetProtectionClick(Sender: TObject);
    procedure btnSAM_SetProtectionSNClick(Sender: TObject);
    procedure btnSAMGetKeyEntriesClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmSAMCommands }

procedure TfmSAMCommands.btnSAM_WriteHostAuthKeyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DataFormat := dfHex;
    Driver.KeyUncoded := edtKeyUncoded.Text;
    Driver.SAM_WriteHostAuthKey;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSAMCommands.btnSAM_GetKeyEntryClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Driver.KeyEntryNumber := seKeyEntryNumber.Value;
    if Driver.SAM_GetKeyEntry = 0 then
    begin
      Memo.Lines.Add(Format('Номер ключа       : %d', [Driver.KeyEntryNumber]));
      Memo.Lines.Add(Format('Тип ключа         : %d, %s', [Driver.KeyType,
        Driver.KeyTypeText]));
      Memo.Lines.Add(Format('Количество ключей : %d', [Driver.KeyNumber]));
      Memo.Lines.Add(Format('Версия ключа 0    : %d', [Driver.KeyVersion0]));
      Memo.Lines.Add(Format('Версия ключа 1    : %d', [Driver.KeyVersion1]));
      Memo.Lines.Add(Format('Версия ключа 2    : %d', [Driver.KeyVersion2]));
    end else
    begin
      Memo.Lines.Add(Format('Ошибка: %d, %s', [
        Driver.ResultCode, Driver.ResultDescription]));
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSAMCommands.btnReadFullSerialNumberClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.ReadFullSerialNumber = 0 then
    begin
      Memo.Lines.Add(Format('Серийный номер, hex : %s', [Driver.SerialNumberHex]));
    end else
    begin
      Memo.Lines.Add(Format('Ошибка: %d, %s', [
        Driver.ResultCode, Driver.ResultDescription]));
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSAMCommands.btnSAM_SetProtectionClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SAM_SetProtection;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSAMCommands.btnSAM_SetProtectionSNClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SerialNumberHex := edtSerialNumberHex.Text;
    Driver.SAM_SetProtectionSN;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSAMCommands.btnSAMGetKeyEntriesClick(Sender: TObject);
var
  KeyEntryNumber: Integer;
const
  Separator = '-------------------------------------------------------------';
begin
  EnableButtons(False);
  try
    Memo.Clear;
    KeyEntryNumber := 0;
    while True do
    begin
      Driver.KeyEntryNumber := KeyEntryNumber;
      if Driver.SAM_GetKeyEntry = 0 then
      begin
        Memo.Lines.Add(Separator);
        Memo.Lines.Add(Format('Номер ключа       : %d', [Driver.KeyEntryNumber]));
        Memo.Lines.Add(Format('Тип ключа         : %d, %s', [Driver.KeyType,
          Driver.KeyTypeText]));
        Memo.Lines.Add(Format('Количество ключей : %d', [Driver.KeyNumber]));
        Memo.Lines.Add(Format('Версия ключа 0    : %d', [Driver.KeyVersion0]));
        Memo.Lines.Add(Format('Версия ключа 1    : %d', [Driver.KeyVersion1]));
        Memo.Lines.Add(Format('Версия ключа 2    : %d', [Driver.KeyVersion2]));
      end else
      begin
        Driver.ClearResult;
        Break;
      end;
      Inc(KeyEntryNumber);
      if KeyEntryNumber = 256 then Break;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
