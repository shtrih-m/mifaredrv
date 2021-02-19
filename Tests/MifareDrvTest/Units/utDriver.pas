unit utDriver;

interface

uses
  // VCL
  Windows, SysUtils, Classes, Forms, Registry,
  // DUnit
  TestFramework,
  // This
  untDriver, untConst, DriverEvent, MifareLib_TLB, EventItem, MifareDevice,
  DriverUtils;

type
  { TDriverTest }

  TDriverTest = class(TTestCase)
  private
    Driver: TDriver;
    FEvents: TEventItems;
    procedure DriverOnEvent(Sender: TObject; EventID: Integer);
  protected
    procedure Setup; override;
    procedure TearDown; override;
  public
    procedure CheckDriverPort;
  published
    procedure CheckDriverEvents;
    procedure CheckDriverEvents2;
    procedure CheckPollInterval;
    procedure CheckPollStart;
    procedure CheckPollStart2;
    procedure CheckPollStart3;
  end;

implementation

{ TDriverTest }

procedure TDriverTest.Setup;
begin
  DisableDriverLog;
  FEvents := TEventItems.Create;
  Driver := TDriver.Create;
  Driver.DeviceType := dtEmulator;
  Driver.LogEnabled := False;
end;

procedure TDriverTest.TearDown;
begin
  Driver.Free;
  FEvents.Free;
end;

procedure TDriverTest.DriverOnEvent(Sender: TObject; EventID: Integer);
begin
  FEvents.Add(Sender, EventID, GetCurrentThreadID);
end;

procedure TDriverTest.CheckDriverEvents;
var
  Event: TEventItem;
begin
  FEvents.Clear;
  Driver.OnEvent := DriverOnEvent;
  Driver.PollAutoDisable := True;
  CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
  //CheckEquals(0, Driver.PollStop, 'Driver.PollStop');
  Sleep(100);
  Application.ProcessMessages;
  CheckEquals(1, FEvents.Count, 'FList.Count');
  Event := FEvents[0];
  CheckEquals(GetCurrentThreadID, Event.ThreadID, 'Event.ThreadID');
  CheckEquals(Integer(Driver), Integer(Event.Sender), 'Event.Sender');
  CheckEquals(1, Driver.EventCount, 'Driver.EventCount');
  Driver.EventID := Event.EventID;

  CheckEquals(0, Driver.FindEvent, 'Driver.FindEvent');
  CheckEquals(EVENT_TYPE_CARD_FOUND, Driver.EventType, 'Driver.EventType');
  CheckEquals(Driver.ID, Driver.EventDriverID, 'Driver.EventDriverID');
  CheckEquals(0, Driver.EventErrorCode, 'Driver.EventErrorCode');
  CheckEquals(Driver.PortNumber, Driver.EventPortNumber, 'Driver.EventPortNumber');
  CheckEquals('', Driver.EventErrorText, 'Driver.EventErrorText');
  CheckEquals('', Driver.EventCardUIDHex, 'Driver.EventCardUIDHex');

  CheckEquals(0, Driver.DeleteEvent, 'Driver.DeleteEvent');
  CheckEquals(0, Driver.EventCount, 'Driver.EventCount');

  CheckEquals(Integer(E_EVENT_NOT_FOUND), Driver.FindEvent, 'Driver.FindEvent');
end;

procedure TDriverTest.CheckDriverEvents2;
var
  Event: TEventItem;
begin
  FEvents.Clear;
  Driver.OnEvent := DriverOnEvent;
  Driver.PollAutoDisable := False;
  CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
  Sleep(100);
  Application.ProcessMessages;
  Driver.OnEvent := nil;
  CheckEquals(0, Driver.PollStop, 'Driver.PollStop');

  Check(FEvents.Count > 1, 'FList.Count');
  Event := FEvents[0];
  //CheckEquals(GetCurrentThreadID, Event.ThreadID, 'Event.ThreadID'); { !!! }
  CheckEquals(Integer(Driver), Integer(Event.Sender), 'Event.Sender');
  Check(Driver.EventCount > 1, 'Driver.EventCount');
  Driver.EventID := Event.EventID;
  CheckEquals(0, Driver.FindEvent, 'Driver.FindEvent');
  CheckEquals(EVENT_TYPE_CARD_FOUND, Driver.EventType, 'Driver.EventType');
  CheckEquals(Driver.ID, Driver.EventDriverID, 'Driver.EventDriverID');
  CheckEquals(0, Driver.EventErrorCode, 'Driver.EventErrorCode');
  CheckEquals(Driver.PortNumber, Driver.EventPortNumber, 'Driver.EventPortNumber');
  CheckEquals('', Driver.EventErrorText, 'Driver.EventErrorText');
  CheckEquals('', Driver.EventCardUIDHex, 'Driver.EventCardUIDHex');

  CheckEquals(0, Driver.ClearEvents, 'Driver.ClearEvents');
  CheckEquals(0, Driver.EventCount, 'Driver.EventCount');

  CheckEquals(Integer(E_EVENT_NOT_FOUND), Driver.FindEvent, 'Driver.FindEvent');
end;

procedure TDriverTest.CheckPollInterval;
var
  Event: TEventItem;
begin
  FEvents.Clear;
  Driver.OnEvent := DriverOnEvent;
  Driver.PollInterval := 300;
  Driver.PollAutoDisable := False;
  CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
  Sleep(100);
  Application.ProcessMessages;
  Driver.OnEvent := nil;
  CheckEquals(0, Driver.PollStop, 'Driver.PollStop');

  CheckEquals(1, FEvents.Count, 'FList.Count');
  Event := FEvents[0];
  //CheckEquals(GetCurrentThreadID, Event.ThreadID, 'Event.ThreadID'); { !!! }
  CheckEquals(Integer(Driver), Integer(Event.Sender), 'Event.Sender');
  CheckEquals(1, Driver.EventCount, 'Driver.EventCount');
  Driver.EventID := Event.EventID;

  CheckEquals(0, Driver.FindEvent, 'Driver.FindEvent');
  CheckEquals(EVENT_TYPE_CARD_FOUND, Driver.EventType, 'Driver.EventType');
  CheckEquals(Driver.ID, Driver.EventDriverID, 'Driver.EventDriverID');
  CheckEquals(0, Driver.EventErrorCode, 'Driver.EventErrorCode');
  CheckEquals(Driver.PortNumber, Driver.EventPortNumber, 'Driver.EventPortNumber');
  CheckEquals('', Driver.EventErrorText, 'Driver.EventErrorText');
  CheckEquals('', Driver.EventCardUIDHex, 'Driver.EventCardUIDHex');

  CheckEquals(0, Driver.DeleteEvent, 'Driver.DeleteEvent');
  CheckEquals(0, Driver.EventCount, 'Driver.EventCount');

  CheckEquals(Integer(E_EVENT_NOT_FOUND), Driver.FindEvent, 'Driver.FindEvent');
end;

procedure TDriverTest.CheckPollStart;
var
  i: Integer;
begin
  for i := 1 to 10 do
  begin
    CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
  end;
  for i := 1 to 10 do
  begin
    CheckEquals(0, Driver.PollStop, 'Driver.PollStop');
  end;
end;

procedure TDriverTest.CheckPollStart2;
var
  i: Integer;
  Device: TMifareDevice;
begin
  Driver.DeviceType := dtMiReader;
  for i := 0 to 9 do
  begin
    Driver.PortNumber := i + 1;
    CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
    CheckEquals(True, Driver.PollStarted, 'Driver.PollStarted');

    Device := Driver.Devices[i];
    CheckEquals(i+1, Driver.Devices.Count, 'Driver.Devices.Count');
    CheckEquals(i+1, Device.PortNumber, 'Device.PortNumber');
    CheckEquals(True, Device.PollStarted, 'Device.PollStarted');
  end;
  CheckEquals(10, Driver.Devices.Count, 'Driver.PollStart');
  Sleep(1000);
end;

procedure TDriverTest.CheckDriverPort;
var
  Driver1: TDriver;
  Driver2: TDriver;
  ResultCode1: Integer;
  ResultCode2: Integer;
begin
  Driver1 := TDriver.Create;
  Driver2 := TDriver.Create;
  try
    Driver1.PortNumber := 2;
    Driver2.PortNumber := 3;
    ResultCode1 := Driver1.Connect;
    ResultCode2 := Driver2.Connect;
    Check(ResultCode1 <> 0, 'ResultCode1 = 0');
    Check(ResultCode2 <> 0, 'ResultCode2 = 0');
  finally
    Driver1.Free;
    Driver2.Free;
  end;
end;

procedure TDriverTest.CheckPollStart3;

  function GetPortsCount: Integer;
  var
    i: Integer;
    List: TList;
    PortNumber: Integer;
  begin
    List := TList.Create;
    try
      for i := 0 to FEvents.Count-1 do
      begin
        Driver.EventID := FEvents[i].EventID;
        if Driver.FindEvent = 0 then
        begin
          PortNumber := Driver.EventPortNumber;
          if List.IndexOf(Pointer(PortNumber)) = -1 then
            List.Add(Pointer(PortNumber));
        end;
      end;
      Result := List.Count;
    finally
      List.Free;
    end;
  end;

var
  i: Integer;
begin
  Driver.OnEvent := DriverOnEvent;
  Driver.DeviceType := dtEmulator;
  Driver.PollAutoDisable := False;
  for i := 1 to 3 do
  begin
    Driver.PortNumber := i;
    CheckEquals(0, Driver.PollStart, 'Driver.PollStart');
    CheckEquals(True, Driver.PollStarted, 'Driver.PollStarted');
  end;
  Driver.PortNumber := 1;
  CheckEquals(0, Driver.PollStop, 'Driver.PollStop');
  Application.ProcessMessages;
  CheckEquals(3, GetPortsCount, 'GetPortsCount.1');
  FEvents.Clear;
  Application.ProcessMessages;
  Sleep(100);
  Application.ProcessMessages;
  Check(FEvents.Count > 0, 'FEvents.Count.2');
  CheckEquals(2, GetPortsCount, 'GetPortsCount.2');
end;

initialization
  RegisterTest('', TDriverTest.Suite);

end.
