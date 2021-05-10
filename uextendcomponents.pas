unit uextendcomponents;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls;

type

  { TPanel }

  TPanel = class(ExtCtrls.TPanel)
  private
    FMouseX: integer;
    FMouseY: integer;
    FMoveMousePanel: boolean;
    procedure SetMoveMousePanel(AValue: boolean);
  public
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
  published
    property MoveMousePanel: boolean read FMoveMousePanel write SetMoveMousePanel default true;
  end;

implementation

{ TPanel }

procedure TPanel.SetMoveMousePanel(AValue: boolean);
begin
  if FMoveMousePanel = AValue then
    Exit;
  FMoveMousePanel := AValue;
end;

procedure TPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FMouseX := X + Left;
  FMouseY := Y + Top;
end;

procedure TPanel.MouseMove(Shift: TShiftState; X, Y: integer);
begin
  inherited MouseMove(Shift, X, Y);

  if FMoveMousePanel then
    if ssLeft in Shift then
    begin
      Parent.Left := Mouse.CursorPos.x - FMouseX;
      Parent.Top := Mouse.CursorPos.y - FMouseY;
    end;
end;

end.
