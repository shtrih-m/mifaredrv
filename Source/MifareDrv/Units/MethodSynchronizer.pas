unit MethodSynchronizer;

interface

uses
  // VCL
  Windows, Classes, Messages, SysUtils,
  // This
  LogFile;

const
  WM_EXECUTE = WM_USER + 1;


type
  { TMethodItem }

  TMethodItem = class
  private
    FMethod: TThreadMethod;
  public
    constructor Create(AMethod: TThreadMethod);
    property Method: TThreadMethod read FMethod;
  end;

  { TMethodSynchronizer }

  TMethodSynchronizer = class
  private
    FHandle: HWND;
    FList: TThreadList;
    FThreadID: Integer;
    procedure WndProc(var AMsg: TMessage);
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Synchronize(Method: TThreadMethod);
  end;

implementation

{ TMethodSynchronizer }

constructor TMethodSynchronizer.Create;
begin
  inherited Create;
  FList := TThreadList.Create;
  FHandle:= AllocateHWnd(WndProc);
  FThreadID := GetCurrentThreadID;
end;

destructor TMethodSynchronizer.Destroy;
begin
  Clear;
  FList.Free;
  DeallocateHWnd(FHandle);
  inherited Destroy;
end;

procedure TMethodSynchronizer.Clear;
var
  List: TList;
  Item: TMethodItem;
begin
  List := FList.LockList;
  try
    while List.Count > 0 do
    begin
      Item := TMethodItem(List[0]);
      Item.Free;
      List.Delete(0);
    end;
  finally
    FList.UnlockList;
  end;
end;

procedure TMethodSynchronizer.WndProc(var AMsg: TMessage);
var
  List: TList;
  Item: TMethodItem;
begin
  try
    if AMsg.Msg = WM_EXECUTE then
    begin
      List := FList.LockList;
      try
        while List.Count > 0 do
        begin
          Item := TMethodItem(List[0]);
          try
            Item.Method;
          except
            on E: Exception do
              Logger.Error('TMethodSynchronizer.Method: ' + E.Message);
          end;
          Item.Free;
          List.Delete(0);
        end;
      finally
        FList.UnlockList;
      end;
    end else
    begin
      AMsg.Result := DefWindowProc(FHandle, AMsg.Msg, AMsg.WParam, AMsg.LParam);
    end;
  except
    on E: Exception do
      Logger.Error('TMethodSynchronizer.WndProc: ' + E.Message);
  end;
end;

procedure TMethodSynchronizer.Synchronize(Method: TThreadMethod);
begin
  if FThreadID = Integer(GetCurrentThreadID) then
  begin
    Method;
  end else
  begin
    FList.Add(TMethodItem.Create(Method));
    PostMessage(FHandle, WM_EXECUTE, 0, 0);
  end;
end;

{ TMethodItem }

constructor TMethodItem.Create(AMethod: TThreadMethod);
begin
  inherited Create;
  FMethod := AMethod;
end;

end.
