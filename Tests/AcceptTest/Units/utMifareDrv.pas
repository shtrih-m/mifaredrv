unit utMifareDrv;

interface

uses
  // VCL
  Windows, SysUtils, Classes, Forms, ComObj, ActiveX,
  // DUnit
  TestFramework,
  // This
  MifareLib_TLB, DriverEvent, EventItem;

type
  { TMifareDrvTest }

  TMifareDrvTest = class(TTestCase)
  private
    Driver: TMifareDrv;
    FEvents: TEventItems;
    procedure DriverOnEvent(Sender: TObject; EventID: Integer);
  protected
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure CheckDriverEvents;
    procedure CheckDriverEvents2;
    procedure CheckPollStart;
    procedure CheckPollStart2;
    procedure CheckPollStart3;
    procedure CheckDriverID;
  end;

implementation

{ TMifareDrvTest }

procedure TMifareDrvTest.Setup;
begin
  OleCheck(CoInitialize(nil));
  FEvents := TEventItems.Create;
  Driver := TMifareDrv.Create(nil);
  Driver.DeviceType := dtEmulator;
end;

procedure TMifareDrvTest.TearDown;
begin
  Driver.Free;
  FEvents.Free;
end;

procedure TMifareDrvTest.DriverOnEvent(Sender: TObject; EventID: Integer);
begin
  FEvents.Add(Sender, EventID, GetCurrentThreadID);
end;

procedure TMifareDrvTest.CheckDriverEvents;
var
  Event: TEventItem;
begin
  FEvents.Clear;
  Driver.OnDriverEvent := DriverOnEvent;
  Driver.PollAutoDisable := True;
  CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
  //CheckEquals(0, Driver.PollStop, 'Driver.PollStop');
  Sleep(100);
  Application.ProcessMessages;
  CheckEquals(1, FEvents.Count, 'FList.Count');
  Event := FEvents[0];
  //CheckEquals(GetCurrentThreadID, Event.ThreadID, 'Event.ThreadID'); { !!! }
  CheckEquals(Integer(Driver), Integer(Event.Sender), 'Event.Sender');
  CheckEquals(1, Driver.EventCount, 'Driver.EventCount');
  Driver.EventID := Event.EventID;
  CheckEquals(0, Driver.FindEvent, 'Driver.FindEvent');
  CheckEquals(EVENT_TYPE_CARD_FOUND, Driver.EventType, 'Driver.EventType');
  CheckEquals(0, Driver.EventErrorCode, 'Driver.EventErrorCode');
  CheckEquals(Driver.PortNumber, Driver.EventPortNumber, 'Driver.EventPortNumber');
  CheckEquals('', Driver.EventErrorText, 'Driver.EventErrorText');
  CheckEquals('', Driver.EventCardUIDHex, 'Driver.EventCardUIDHex');

  CheckEquals(0, Driver.DeleteEvent, 'Driver.DeleteEvent');
  CheckEquals(0, Driver.EventCount, 'Driver.EventCount');

  CheckEquals(Integer(E_EVENT_NOT_FOUND), Driver.FindEvent, 'Driver.FindEvent');
end;

procedure TMifareDrvTest.CheckDriverEvents2;
var
  Event: TEventItem;
begin
  FEvents.Clear;
  Driver.OnDriverEvent := DriverOnEvent;
  Driver.PollAutoDisable := False;
  CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
  Sleep(100);
  Application.ProcessMessages;
  Driver.OnDriverEvent := nil;
  CheckEquals(0, Driver.PollStop, 'Driver.PollStop');

  Check(FEvents.Count > 1, 'FList.Count');
  Event := FEvents[0];
  //CheckEquals(GetCurrentThreadID, Event.ThreadID, 'Event.ThreadID'); { !!! }
  CheckEquals(Integer(Driver), Integer(Event.Sender), 'Event.Sender');
  Check(Driver.EventCount > 1, 'Driver.EventCount');
  Driver.EventID := Event.EventID;
  CheckEquals(0, Driver.FindEvent, 'Driver.FindEvent');
  CheckEquals(EVENT_TYPE_CARD_FOUND, Driver.EventType, 'Driver.EventType');
  CheckEquals(0, Driver.EventErrorCode, 'Driver.EventErrorCode');
  CheckEquals(Driver.PortNumber, Driver.EventPortNumber, 'Driver.EventPortNumber');
  CheckEquals('', Driver.EventErrorText, 'Driver.EventErrorText');
  CheckEquals('', Driver.EventCardUIDHex, 'Driver.EventCardUIDHex');

  CheckEquals(0, Driver.ClearEvents, 'Driver.ClearEvents');
  CheckEquals(0, Driver.EventCount, 'Driver.EventCount');

  CheckEquals(Integer(E_EVENT_NOT_FOUND), Driver.FindEvent, 'Driver.FindEvent');
end;


procedure TMifareDrvTest.CheckPollStart;
var
  Driver1: TMifareDrv;
  Driver2: TMifareDrv;
begin
  Driver1 := TMifareDrv.Create(nil);
  Driver2 := TMifareDrv.Create(nil);
  try
    Driver1.PortNumber := 11;
    Driver2.PortNumber := 12;
    Driver1.PollAutoDisable := False;
    Driver2.PollAutoDisable := False;
    CheckEquals(0, Driver1.PollStart, 'Driver1.PollStart');
    CheckEquals(0, Driver2.PollStart, 'Driver2.PollStart');
    Sleep(1000);
    CheckEquals(0, Driver1.PollStop, 'Driver1.PollStop');
    CheckEquals(0, Driver2.PollStop, 'Driver2.PollStop');
  finally
    Driver1.Free;
    Driver2.Free;
  end;
end;

procedure TMifareDrvTest.CheckPollStart2;
var
  Driver1: TMifareDrv;
  Driver2: TMifareDrv;
begin
  Driver1 := TMifareDrv.Create(nil);
  Driver2 := TMifareDrv.Create(nil);
  try
    Driver1.PortNumber := 11;
    Driver2.PortNumber := 11;
    Driver1.PollAutoDisable := False;
    Driver2.PollAutoDisable := False;
    CheckEquals(0, Driver1.PollStart, 'Driver1.PollStart');
    CheckEquals(0, Driver2.PollStart, 'Driver2.PollStart');
    Sleep(1000);
    CheckEquals(0, Driver1.PollStop, 'Driver1.PollStop');
    CheckEquals(0, Driver2.PollStop, 'Driver2.PollStop');
  finally
    Driver1.Free;
    Driver2.Free;
  end;
end;

procedure TMifareDrvTest.CheckPollStart3;
var
  i: Integer;
begin
  Driver.PortNumber := 11;
  Driver.PollAutoDisable := False;
  for i := 1 to 10 do
  begin
    CheckEquals(0, Driver.PollStart, 'Driver1.PollStart');
  end;
  for i := 1 to 10 do
  begin
    CheckEquals(0, Driver.PollStop, 'Driver2.PollStop');
  end;
end;

procedure TMifareDrvTest.CheckDriverID;
var
  Driver1: TMifareDrv;
  Driver2: TMifareDrv;
  Driver3: OleVariant;
  Driver4: OleVariant;
  LastDriverID: Integer;
begin
  LastDriverID := Driver.DriverID;

  Driver1 := TMifareDrv.Create(nil);
  Driver2 := TMifareDrv.Create(nil);
  try
    CheckEquals(LastDriverID + 1, Driver1.DriverID, 'Driver1.DriverID');
    CheckEquals(LastDriverID + 2, Driver2.DriverID, 'Driver2.DriverID');
  finally
    Driver1.Free;
    Driver2.Free;
  end;

  Driver3 := CreateOleObject('Addin.MifareDrv');
  Driver4 := CreateOleObject('Addin.MifareDrv');
  CheckEquals(LastDriverID + 3, Driver3.DriverID, 'Driver3.DriverID');
  CheckEquals(LastDriverID + 4, Driver4.DriverID, 'Driver4.DriverID');
end;

initialization
  RegisterTest('', TMifareDrvTest.Suite);

end.
