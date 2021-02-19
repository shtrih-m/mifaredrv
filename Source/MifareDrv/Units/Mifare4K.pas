unit Mifare4K;

interface

uses
  // This
  CustomCard, CardField, MifareLib_TLB, untDriver, untConst;

type
  { TMifare4K }

  TMifare4K = class(TCustomCard)
  protected
    function GetDescription: string; override;
  end;

implementation

function TMifare4K.GetDescription: string;
begin
  Result := 'MIFARE® 4K';
end;

end.
