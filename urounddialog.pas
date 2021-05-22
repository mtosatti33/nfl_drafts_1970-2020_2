unit UroundDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfrmRoundDialog }

  TfrmRoundDialog = class(TForm)
    edtRound: TEdit;
    lblRound: TLabel;
    Panel1: TPanel;
    procedure edtRoundKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    FRound: string;
    procedure SetRound(AValue: string);

  public
    property Round: string read FRound write SetRound;
  end;

var
  frmRoundDialog: TfrmRoundDialog;

implementation

{$R *.lfm}

{ TfrmRoundDialog }

procedure TfrmRoundDialog.edtRoundKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    FRound := edtRound.Text;
    Close;
  end;
end;

procedure TfrmRoundDialog.SetRound(AValue: string);
begin
  if FRound = AValue then
    Exit;
  FRound := AValue;
end;

end.

