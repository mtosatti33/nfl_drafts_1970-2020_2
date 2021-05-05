unit UPlayerEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList,
  ExtCtrls, Buttons, ZDataset;

type

  { TfrmPlayerEdit }

  TfrmPlayerEdit = class(TForm)
    actApply: TAction;
    actCancel: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    edtAllPro: TEdit;
    edtLastYear: TEdit;
    edtProBowl: TEdit;
    edtStarter: TEdit;
    edtGames: TEdit;
    edtCarAV: TEdit;
    edtTmAV: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    lblID: TLabel;
    lblName: TLabel;
    lblPosition: TLabel;
    lblCollege: TLabel;
    Panel1: TPanel;
    qryDrafts: TZQuery;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    procedure actApplyExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FId: string;
    FName: string;
    FPosition: string;
    FCollege: string;
    FAllPro: String;
    FProBowl: String;
    FStarter: String;
    FGames: String;
    FCarAV: String;
    FTmAV: String;
    FLastYear: string;
    FIsSave: Boolean;
  public
    property ID: string read FId write FId;
    property Name: string read FName write FName;
    property Position: string read FPosition write FPosition;
    property College: string read FCollege write FCollege;
    property AllPro: string read FAllPro write FAllPro;
    property ProBowl: string read FProBowl write FProBowl;
    property Starter: string read FStarter write FStarter;
    property Games: string read FGames write FGames;
    property CarAV: string read FCarAV write FCarAV;
    property TmAV: string read FTmAV write FTmAV;
    property LastYearPlayed: string read FLastYear write FLastYear;
    property IsSave: Boolean read FIsSave write FIsSave;
  end;

var
  frmPlayerEdit: TfrmPlayerEdit;

implementation

{$R *.lfm}

{ TfrmPlayerEdit }

procedure TfrmPlayerEdit.FormShow(Sender: TObject);
begin
  lblID.Caption:=FId;
  lblName.Caption:=FName;
  lblPosition.Caption:=FPosition;
  lblCollege.Caption:=FCollege;

  edtLastYear.Text:=FLastYear;
  edtAllPro.Text:=FAllPro;
  edtProBowl.Text:=FProBowl;
  edtStarter.Text:=FStarter;
  edtGames.Text:=FGames;
  edtCarAV.Text:=FCarAV;
  edtTmAV.Text:=FTmAV;
end;

procedure TfrmPlayerEdit.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlayerEdit.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlayerEdit.FormCreate(Sender: TObject);
begin
  FIsSave:= false;
end;

procedure TfrmPlayerEdit.actApplyExecute(Sender: TObject);
begin
  FIsSave:=true;
  FAllPro:=edtAllPro.Text;
  FProBowl:=edtProBowl.Text;
  FStarter:=edtStarter.Text;
  FGames:=edtGames.Text;
  FCarAV:=edtCarAV.Text;
  FTmAV:=edtTmAV.Text;
  FLastYear:=edtLastYear.Text;

  qryDrafts.ParamByName('AP1').AsString:=FAllPro;
  qryDrafts.ParamByName('PB').AsString:=FProBowl;
  qryDrafts.ParamByName('ST').AsString:=FStarter;

  if FGames <> EmptyStr then
     qryDrafts.ParamByName('G').AsString:=FGames
  else
      qryDrafts.ParamByName('G').IsNull;

  if FCarAV <> EmptyStr then
     qryDrafts.ParamByName('CARAV').AsString:=FCarAV
  else
      qryDrafts.ParamByName('CARAV').IsNull;

  if FTmAV <> EmptyStr then
      qryDrafts.ParamByName('DRAV').AsString:=FTmAV
  else
      qryDrafts.ParamByName('DRAV').IsNull;

  if FLastYear <> EmptyStr then
     qryDrafts.ParamByName('TO').AsString:=FLastYear
  else
     qryDrafts.ParamByName('TO').IsNull;

  qryDrafts.ParamByName('ID').AsString:=FId;

  try
    qryDrafts.ExecSQL;
    qryDrafts.ApplyUpdates;
  finally
    Close;
  end;
end;

end.

