unit fmuSAMVersion;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  // This
  MifareLib_TLB, untPage;

type
  TfmSAMVersion = class(TPage)
    btnSAM_GetVersion: TButton;
    Memo: TMemo;
    procedure btnSAM_GetVersionClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmSAM }

procedure TfmSAMVersion.btnSAM_GetVersionClick(Sender: TObject);
const
  Separator = '---------------------------------';
begin
  EnableButtons(False);
  try
    if Driver.SAM_GetVersion = 0 then
    begin
      Memo.Clear;
      Memo.Lines.Add(Separator);
      Memo.Lines.Add(' Hardware info');
      Memo.Lines.Add(Separator);
      Memo.Lines.Add(' Vendor ID     : ' +
        IntToStr(Driver.SAMHWVendorID) + ', ' + Driver.SAMHWVendorName);
      Memo.Lines.Add(' Type          : ' + IntToStr(Driver.SAMHWType));
      Memo.Lines.Add(' Sub Type      : ' + IntToStr(Driver.SAMHWSubType));
      Memo.Lines.Add(' Major Version : ' + IntToStr(Driver.SAMHWMajorVersion));
      Memo.Lines.Add(' Minor Version : ' + IntToStr(Driver.SAMHWMinorVersion));
      Memo.Lines.Add(' Storage Size  : ' + Format('0x%.2xh = %d KB', [
        Driver.SAMHWStorageSizeCode, Driver.SAMHWStorageSize div 1024]));
      Memo.Lines.Add(' Protocol      : ' + IntToStr(Driver.SAMHWProtocol));

      Memo.Lines.Add(Separator);
      Memo.Lines.Add(' Software info');
      Memo.Lines.Add(Separator);
      Memo.Lines.Add(' Vendor ID     : ' +
        IntToStr(Driver.SAMSWVendorID) + ', ' + Driver.SAMSWVendorName);
      Memo.Lines.Add(' Type          : ' + IntToStr(Driver.SAMSWType));
      Memo.Lines.Add(' Sub Type      : ' + IntToStr(Driver.SAMSWSubType));
      Memo.Lines.Add(' Major Version : ' + IntToStr(Driver.SAMSWMajorVersion));
      Memo.Lines.Add(' Minor Version : ' + IntToStr(Driver.SAMSWMinorVersion));
      Memo.Lines.Add(' Storage Size  : ' + Format('0x%.2xh = %d KB', [
        Driver.SAMSWStorageSizeCode, Driver.SAMSWStorageSize div 1024]));
      Memo.Lines.Add(' Protocol      : ' + IntToStr(Driver.SAMSWProtocol));

      Memo.Lines.Add(Separator);
      Memo.Lines.Add(' Manufacturing data');
      Memo.Lines.Add(Separator);

      Memo.Lines.Add(' UID             : 0x' + Driver.SAMMDUIDHex);
      Memo.Lines.Add(' BatchNo         : ' + Format('0x%.10x', [Driver.SAMMDBatchNo]));
      Memo.Lines.Add(' Production date : ' + Format('%.2d.%.2d.%.4d', [
        Driver.SAMMDProductionDay,
        Driver.SAMMDProductionMonth,
        Driver.SAMMDProductionYear + 2000]));
      Memo.Lines.Add(' Crypto settings : ' +
        IntToStr(Driver.SAMMDGlobalCryptoSettings));
      Memo.Lines.Add(' Mode            : ' + Format('0x%.2x, %d, %s', [
        Driver.SAMMode, Driver.SAMMode, Driver.SAMModeName]));
      Memo.Lines.Add(Separator);
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
