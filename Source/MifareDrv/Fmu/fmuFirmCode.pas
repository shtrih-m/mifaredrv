unit fmuFirmCode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TfmFirmCode = class(TForm)
    btnAdd: TButton;
    btnDelete: TButton;
    ListView1: TListView;
    btnClose: TButton;
    btnEdit: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFirmCode: TfmFirmCode;

implementation

{$R *.DFM}

end.
