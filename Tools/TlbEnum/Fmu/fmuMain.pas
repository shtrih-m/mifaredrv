unit fmuMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfmMain = class(TForm)
    Memo: TMemo;
    btnConvert: TButton;
    btnClose: TButton;
    lblStartID: TLabel;
    edtStartID: TEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

function GetItemName(const Data: string): string;
var
  P: Integer;
begin
  Result := Trim(Data);
  P := Pos(' ', Result);
  if P <> 0 then
  begin
    Result := Trim(Copy(Result, P+1, Length(Data)));
    // ' '
    P := Pos(' ', Result);
    if P <> 0 then
    begin
      Result := Copy(Result, 1, P-1);
    end;
    // :
    P := Pos(':', Result);
    if P <> 0 then
    begin
      Result := Copy(Result, 1, P-1);
    end;
    // (
    P := Pos('(', Result);
    if P <> 0 then
    begin
      Result := Copy(Result, 1, P-1);
    end;
  end;
end;

function GetItemType(const Data: string): string;
var
  P: Integer;
begin
  Result := Trim(Data);
  P := Pos(' ', Result);
  if P <> 0 then
  begin
    Result := Copy(Result, 1, P-1);
  end;
end;

function IsProp(const Data: string): Boolean;
begin
  Result := (Pos('propget', Data) <> 0)or(Pos('propput', Data) <> 0);
end;

{ Процедура сортировки }

function SortCompare(List: TStringList; Index1, Index2: Integer): Integer;
var
  Item1, Item2: string;
  Name1, Name2: string;
  Type1, Type2: string;
begin
  Item1 := List[Index1];
  Item2 := List[Index2];
  Name1 := GetItemName(Item1);
  Name2 := GetItemName(Item2);
  Type1 := GetItemType(Item1);
  Type2 := GetItemType(Item2);

  Result := AnsiCompareText(Name1, Name2);
  if Result = 0 then
    Result := AnsiCompareText(Type1, Type2);
  // методы всегда перед свойствами
  if IsProp(Item2) and (not IsProp(Item1)) then Result := -1;
  if IsProp(Item1) and (not IsProp(Item2)) then Result := 1;
end;

{ TfmMain }

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.btnConvertClick(Sender: TObject);
var
  S: string;
  S1: string;
  S2: string;
  Name1: string;
  Name2: string;
  P: Integer;
  i: Integer;
  ID: Integer;
  ItemID: string;
  StartID: Integer;
  Strings: TStringList;
begin
  ID := 0;
  StartID := StrToInt('$' + edtStartID.Text);
  Strings := TStringList.Create;
  try
    Strings.Assign(Memo.Lines);
    Strings.CustomSort(SortCompare);
    // Нумерация
    for i := 0 to Strings.Count-1 do
    begin
      if i > 0 then
        Name1 := GetItemName(Strings[i-1])
      else
        Name1 := '';

      S := Strings[i];
      Name2 := GetItemName(S);
      P := Pos('dispid ', S);
      if P <> 0 then
      begin
        // dispid $00000019
        ItemID := Copy(S, P+7, 9);
        if StrToInt(ItemID) > 0 then
        begin
          if Name1 <> Name2 then Inc(ID);
          S1 := Copy(S, 1, P+6);
          S2 := Copy(S, P + 16, Length(S));
          S := Format('%s$%.8x%s', [S1, StartID + ID, S2]);
          Strings[i] := S;
        end;
      end;
    end;
    Memo.Lines := Strings;
  finally
    Strings.Free;
  end;
end;

end.

