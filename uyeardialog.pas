unit uYearDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TfrmYearDialog }

  TfrmYearDialog = class(TForm)
    edtYrFrom: TEdit;
    edtYrTo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure edtYrFromChange(Sender: TObject);
    procedure edtYrFromKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtYrToKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FYearFrom: string;
    FYearTo: string;

  public
    property YearFrom: string read FYearFrom write FYearFrom;
    property YearTo: string read FYearTo write FYearTo;
  end;

var
  frmYearDialog: TfrmYearDialog;

implementation

{$R *.lfm}

{ TfrmYearDialog }

procedure TfrmYearDialog.edtYrFromChange(Sender: TObject);
begin
  if edtYrFrom.Text <> '' then
    edtYrTo.Text := edtYrFrom.Text;
end;

procedure TfrmYearDialog.edtYrFromKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
    edtYrTo.SetFocus;
end;

procedure TfrmYearDialog.edtYrToKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    if StrToInt(edtYrFrom.Text) > StrToInt(edtYrTo.Text) then
    begin
      ShowMessage('Inicial year can`t be greater than final year');
      Exit;
    end;
    FYearFrom := edtYrFrom.Text;
    FYearTo := edtYrTo.Text;

    Close;
  end;
end;

procedure TfrmYearDialog.FormShow(Sender: TObject);
begin
  edtYrFrom.Text:=FYearFrom;
  edtYrTo.Text:=FYearTo;
end;

end.


