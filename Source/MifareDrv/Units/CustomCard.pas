unit CustomCard;

interface

uses
  // This
  untDriver, untError, Directory;

type
  { TCustomCard }

  TCustomCard = class
  private
    FDriver: TDriver;
    function GetDirectory: TCardDirectory;
  protected
    function GetDataSize: Integer; virtual;
    function GetDescription: string; virtual;

    property Driver: TDriver read FDriver;
    property Directory: TCardDirectory read GetDirectory;
  public
    constructor Create(ADriver: TDriver); virtual;

    procedure ReadDirectory; virtual;
    procedure WriteDirectory; virtual;
    procedure FormatDirectory; virtual;
    procedure DeleteAppSectors; virtual;
    procedure MikleWriteData(const Data: string); virtual;
    function MikleReadData(DataSize: Integer): string; virtual;
    procedure WriteData(const Data: string); virtual;
    function ReadData(DataSize: Integer): string; virtual;

    property DataSize: Integer read GetDataSize;
    property Description: string read GetDescription;
  end;

implementation

{ TCustomCard }

constructor TCustomCard.Create(ADriver: TDriver);
begin
  inherited Create;
  FDriver := ADriver;
end;

// Размер данных карты

procedure TCustomCard.DeleteAppSectors;
begin
  { !!! }
end;

procedure TCustomCard.FormatDirectory;
begin
  RaiseNotSupportedError;
end;

function TCustomCard.GetDataSize: Integer;
begin
  Result := 0;
end;

function TCustomCard.GetDescription: string;
begin
  Result := 'Неизвестный тип карты';
end;

function TCustomCard.GetDirectory: TCardDirectory;
begin
  Result := Driver.Directory;
end;

procedure TCustomCard.ReadDirectory;
begin
  RaiseNotSupportedError;
end;

procedure TCustomCard.WriteData(const Data: string);
begin
  RaiseNotSupportedError;
end;

function TCustomCard.ReadData(DataSize: Integer): string;
begin
  RaiseNotSupportedError;
end;

procedure TCustomCard.WriteDirectory;
begin
  RaiseNotSupportedError;
end;

function TCustomCard.MikleReadData(DataSize: Integer): string;
begin
  RaiseNotSupportedError;
end;

procedure TCustomCard.MikleWriteData(const Data: string);
begin
  RaiseNotSupportedError;
end;

end.
