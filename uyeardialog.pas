unit uYearDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, ActnList;

type

  { TfrmYearDialog }

  TfrmYearDialog = class(TForm)
    actExit: TAction;
    actions: TActionList;
    edtYrFrom: TEdit;
    edtYrTo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    procedure actExitExecute(Sender: TObject);
    procedure edtYrFromChange(Sender: TObject);
    procedure edtYrFromKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtYrToKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FIsEscPressed: boolean;
    FYearFrom: string;
    FYearTo: string;
    procedure SetYearFrom(AValue: string);
    procedure SetYearTo(AValue: string);

  public
    property YearFrom: string read FYearFrom write SetYearFrom;
    property YearTo: string read FYearTo write SetYearTo;
    property IsEscPressed: boolean read FIsEscPressed write FIsEscPressed default false;
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

procedure TfrmYearDialog.actExitExecute(Sender: TObject);
begin     
  FIsEscPressed:=true;
  Close;
end;

procedure TfrmYearDialog.edtYrFromKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if StrToInt(edtYrFrom.Text) > UpDown1.Max then
    begin
      ShowMessage('Year Max: ' + IntToStr(UpDown1.Max));
      Exit;
    end;

    edtYrTo.SetFocus;
  end;
end;

procedure TfrmYearDialog.edtYrToKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    if StrToInt(edtYrFrom.Text) > StrToInt(edtYrTo.Text) then
    begin
      ShowMessage('Initial Year > Final Year');
      Exit;
    end;

    if StrToInt(edtYrTo.Text) > UpDown2.Max then
    begin
      ShowMessage('Year Max: ' + IntToStr(UpDown2.Max));
      Exit;
    end;

    FYearFrom := edtYrFrom.Text;
    FYearTo := edtYrTo.Text;

    Close;
  end;
end;

procedure TfrmYearDialog.FormShow(Sender: TObject);
begin
  if FYearFrom <> '' then
    edtYrFrom.Text := FYearFrom;
  if FYearTo <> '' then
    edtYrTo.Text := FYearTo;
end;

procedure TfrmYearDialog.SetYearFrom(AValue: string);
begin
  if FYearFrom = AValue then
    Exit;
  FYearFrom := AValue;
end;

procedure TfrmYearDialog.SetYearTo(AValue: string);
begin
  if FYearTo = AValue then
    Exit;
  FYearTo := AValue;
end;

end.
