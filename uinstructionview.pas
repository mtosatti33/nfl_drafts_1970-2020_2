unit UInstructionView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList;

type

  { TfrmInstructionView }

  TfrmInstructionView = class(TForm)
    actExit: TAction;
    actions: TActionList;
    mmoSQL: TMemo;
    procedure actExitExecute(Sender: TObject);
  private

  public

  end;

var
  frmInstructionView: TfrmInstructionView;

implementation

{$R *.lfm}

{ TfrmInstructionView }

procedure TfrmInstructionView.actExitExecute(Sender: TObject);
begin
  Close;
end;

end.

