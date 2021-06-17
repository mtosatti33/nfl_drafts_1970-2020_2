unit UroundDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TfrmRoundDialog }

  TfrmRoundDialog = class(TForm)
    edtRoundFrom: TEdit;
    edtRoundTo: TEdit;
    lblRound: TLabel;
    lblRound1: TLabel;
    Panel1: TPanel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure edtRoundFromChange(Sender: TObject);
    procedure edtRoundFromKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtRoundToKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FRoundFrom: string;
    FRoundTo: string;
    procedure SetRoundFrom(AValue: string);
    procedure SetRoundTo(AValue: string);

  public
    property RoundFrom: string read FRoundFrom write SetRoundFrom;
    property RoundTo: string read FRoundTo write SetRoundTo;
  end;

var
  frmRoundDialog: TfrmRoundDialog;

implementation

{$R *.lfm}

{ TfrmRoundDialog }

procedure TfrmRoundDialog.edtRoundFromKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
     edtRoundTo.SetFocus;
end;

procedure TfrmRoundDialog.edtRoundToKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if StrToInt(edtRoundFrom.Text) > StrToInt(edtRoundTo.Text) then
    begin
      ShowMessage('Final Round < Initial Round');
      Exit;
    end;
    FRoundFrom := edtRoundFrom.Text;
    FRoundTo := edtRoundTo.Text;
    Close;
  end;
end;

procedure TfrmRoundDialog.edtRoundFromChange(Sender: TObject);
begin
  if edtRoundFrom.Text <> '' then
     edtRoundTo.Text := edtRoundFrom.Text;
end;

procedure TfrmRoundDialog.FormShow(Sender: TObject);
begin
  if FRoundFrom <> '' then
     edtRoundFrom.Text:=FRoundFrom;

  if FRoundTo <> '' then
     edtRoundTo.Text:=FRoundTo;
end;

procedure TfrmRoundDialog.SetRoundFrom(AValue: string);
begin
  if FRoundFrom = AValue then Exit;
  FRoundFrom := AValue;
end;

procedure TfrmRoundDialog.SetRoundTo(AValue: string);
begin
  if FRoundTo = AValue then Exit;
  FRoundTo := AValue;
end;

end.

