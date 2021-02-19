unit CardFirm;

interface

Uses
  // VCL
  Classes, SysUtils, IniFiles,
  // This
  CardApp;

type
  TCardFirm = class;

  { TCardFirms }

  TCardFirms = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TCardFirm;
    procedure Clear;
    procedure InsertItem(AItem: TCardFirm);
    procedure RemoveItem(AItem: TCardFirm);
  public
    Index: Integer;
    constructor Create;
    destructor Destroy; override;
    function Add: TCardFirm;
    function GetFreeCode: Integer;
    procedure CheckCode(Value: Integer);
    function IsEqual(Src: TCardFirms): Boolean;
    function ItemByCode(Value: Integer): TCardFirm;
    procedure SaveToIniFile(const FileName: string);
    procedure LoadFromIniFile(const FileName: string);

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TCardFirm read GetItem; default;
  end;

  { TCardFirm }

  TCardFirm = class
  private
    FCode: Integer;
    FOwner: TCardFirms;
    FCardApps: TCardApps;
    function GetDisplayText: string;
    procedure SetCode(Value: Integer);
    procedure SetOwner(AOwner: TCardFirms);
  public
    Name: string;
    constructor Create(AOwner: TCardFirms);
    destructor Destroy; override;
    function IsEqual(Src: TCardFirm): Boolean;

    property Owner: TCardFirms read FOwner;
    property CardApps: TCardApps read FCardApps;
    property Code: Integer read FCode write SetCode;
    property DisplayText: string read GetDisplayText;
  end;

implementation

{ TCardFirms }

constructor TCardFirms.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TCardFirms.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TCardFirms.Clear;
begin
  while Count > 0 do Items[0].Free;
end;

function TCardFirms.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TCardFirms.GetItem(Index: Integer): TCardFirm;
begin
  Result := FList[Index];
end;

procedure TCardFirms.InsertItem(AItem: TCardFirm);
begin
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TCardFirms.RemoveItem(AItem: TCardFirm);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
end;

function TCardFirms.ItemByCode(Value: Integer): TCardFirm;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    Result := Items[i];
    if Result.Code = Value then Exit;
  end;
  Result := nil;
end;

procedure TCardFirms.LoadFromIniFile(const FileName: string);

  // Разбор строки в формате [10=Штрих-М]

  function GetFirmParams(const Data: string; var FirmCode: Integer;
    var FirmName: string): Boolean;
  var
    S: string;
    P: Integer;
    Code: Integer;
  begin
    P := Pos('=', Data);
    Result := P <> 0;
    if Result then
    begin
      S := Copy(Data, 1, P-1);
      Val(S, FirmCode, Code);
      Result := Code = 0;
      if Result then
        FirmName := Copy(Data, P+1, Length(Data));
    end;
  end;

  function GetCode(const Data: string; var Value: Integer): Boolean;
  var
    Code: Integer;
  begin
    Val('$' + Data, Value, Code);
    Result := Code = 0;
  end;

var
  i: Integer;
  j: Integer;
  App: TCardApp;
  AppName: string;
  AppCode: Integer;
  Firm: TCardFirm;
  FirmName: string;
  FirmCode: Integer;
  IniFile: TIniFile;
  Sections: TStrings;
  KeyNames: TStrings;
begin
  Clear;
  Sections := TStringList.Create;
  KeyNames := TStringList.Create;
  IniFile := TIniFile.Create(FileName);
  try
    IniFile.ReadSections(Sections);
    for i := 0 to Sections.Count-1 do
    begin
      if GetCode(Sections[i], FirmCode) then
      begin
        FirmName := IniFile.ReadString(Sections[i], 'FirmName', '');

        Firm := TCardFirm.Create(Self);
        Firm.Code := FirmCode;
        Firm.Name := FirmName;

        IniFile.ReadSection(Sections[i], KeyNames);
        for j := 0 to KeyNames.Count-1 do
        begin
          if GetCode(KeyNames[j], AppCode) then
          begin
            AppName := IniFile.ReadString(Sections[i], KeyNames[j], '');

            App := TCardApp.Create(Firm.CardApps);
            App.Code := AppCode;
            App.Name := AppName;
          end;
        end;
      end;
    end;
  finally
    IniFile.Free;
    Sections.Free;
    KeyNames.Free;
  end;
end;

procedure TCardFirms.SaveToIniFile(const FileName: string);
var
  i: Integer;
  j: Integer;
  Ident: string;
  App: TCardApp;
  Firm: TCardFirm;
  Section: string;
  IniFile: TIniFile;
begin
  if FileExists(FileName) then DeleteFile(FileName);
  IniFile := TIniFile.Create(FileName);
  try
    for i := 0 to Count-1 do
    begin
      Firm := Items[i];
      Section := Format('%.2x', [Firm.Code]);
      IniFile.WriteString(Section, 'FirmName', Firm.Name);
      for j := 0 to Firm.CardApps.Count-1 do
      begin
        App := Firm.CardApps[j];
        Ident := Format('%.2x', [App.Code]);
        IniFile.WriteString(Section, Ident, App.Name);
      end;
    end;
  finally
    IniFile.Free;
  end;
end;

function TCardFirms.IsEqual(Src: TCardFirms): Boolean;
var
  i: Integer;
begin
  Result := Count = Src.Count;
  if not Result then Exit;

  for i := 0 to Count-1 do
  begin
    Result := Items[i].IsEqual(Src[i]);
    if not Result then Exit;
  end;
end;

function TCardFirms.Add: TCardFirm;
begin
  Result := TCardFirm.Create(Self);
end;

function TCardFirms.GetFreeCode: Integer;
var
  i: Integer;
begin
  for i := 0 to 255 do
  begin
    Result := i;
    if ItemByCode(i) = nil then Exit;
  end;
end;

procedure TCardFirms.CheckCode(Value: Integer);
begin
  if (Value < 0)or(Value > 255) then
    raise Exception.Create('Код должен быть в диапазоне 0..255.');

  if ItemByCode(Value) <> nil then
    raise Exception.CreateFmt('Фирма с кодом %d уже существует.', [Value]);
end;

{ TCardFirm }

constructor TCardFirm.Create(AOwner: TCardFirms);
begin
  inherited Create;
  FCardApps := TCardApps.Create;
  SetOwner(AOwner);
end;

destructor TCardFirm.Destroy;
begin
  SetOwner(nil);
  FCardApps.Free;
  inherited Destroy;
end;

procedure TCardFirm.SetOwner(AOwner: TCardFirms);
begin
  if AOwner <> FOwner then
  begin
    if FOwner <> nil then FOwner.RemoveItem(Self);
    if AOwner <> nil then AOwner.InsertItem(Self);
  end;
end;

function TCardFirm.IsEqual(Src: TCardFirm): Boolean;
begin
  Result := (Code = Src.Code)and(Name = Src.Name)and
    CardApps.IsEqual(Src.CardApps);
end;

procedure TCardFirm.SetCode(Value: Integer);
begin
  if Value <> Code then
  begin
    FOwner.CheckCode(Value);
    FCode := Value;
  end;
end;

function TCardFirm.GetDisplayText: string;
begin
  Result := Format('0x%.2x, %s', [Code, Name]);
end;

end.
