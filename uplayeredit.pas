unit UPlayerEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList,
  ExtCtrls, Buttons, ComCtrls, DBGrids, DBCtrls, ZDataset, Types, uextendcomponents;

type

  { TfrmPlayerEdit }

  TfrmPlayerEdit = class(TForm)
    actApply: TAction;
    actCancel: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    dsStats: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    edtAllPro: TEdit;
    edtCarAV: TEdit;
    edtGames: TEdit;
    edtLastYear: TEdit;
    edtProBowl: TEdit;
    edtStarter: TEdit;
    edtTmAV: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblID: TLabel;
    lblName: TLabel;
    lblPosition: TLabel;
    lblCollege: TLabel;
    Panel1: TPanel;
    pgcMain: TPageControl;
    qryDrafts: TZQuery;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    SpeedButton1: TSpeedButton;
    tsStats: TTabSheet;
    tsInformation: TTabSheet;
    qryStats: TZQuery;
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
    FAllPro: string;
    FProBowl: string;
    FStarter: string;
    FGames: string;
    FCarAV: string;
    FTmAV: string;
    FLastYear: string;
    FIsSave: boolean;

    MouseX: integer;
    MouseY: integer;
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
    property IsSave: boolean read FIsSave write FIsSave;
  end;

var
  frmPlayerEdit: TfrmPlayerEdit;

implementation

{$R *.lfm}

{ TfrmPlayerEdit }

procedure TfrmPlayerEdit.FormShow(Sender: TObject);
begin
  lblID.Caption := FId;
  lblName.Caption := FName;
  lblPosition.Caption := FPosition;
  lblCollege.Caption := FCollege;

  edtLastYear.Text := FLastYear;
  edtAllPro.Text := FAllPro;
  edtProBowl.Text := FProBowl;
  edtStarter.Text := FStarter;
  edtGames.Text := FGames;
  edtCarAV.Text := FCarAV;
  edtTmAV.Text := FTmAV;

  pgcMain.ActivePage := tsInformation;
end;

procedure TfrmPlayerEdit.SpeedButton1Click(Sender: TObject);
begin
  actCancel.Execute;
end;

procedure TfrmPlayerEdit.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlayerEdit.FormCreate(Sender: TObject);
begin
  FIsSave := False;
  panel1.MoveMousePanel:=true;
end;

procedure TfrmPlayerEdit.actApplyExecute(Sender: TObject);
begin
  FIsSave := True;
  FAllPro := edtAllPro.Text;
  FProBowl := edtProBowl.Text;
  FStarter := edtStarter.Text;
  FGames := edtGames.Text;
  FCarAV := edtCarAV.Text;
  FTmAV := edtTmAV.Text;
  FLastYear := edtLastYear.Text;

  qryDrafts.ParamByName('AP1').AsString := FAllPro;
  qryDrafts.ParamByName('PB').AsString := FProBowl;
  qryDrafts.ParamByName('ST').AsString := FStarter;

  if FGames <> EmptyStr then
    qryDrafts.ParamByName('G').AsString := FGames
  else
    qryDrafts.ParamByName('G').IsNull;

  if FCarAV <> EmptyStr then
    qryDrafts.ParamByName('CARAV').AsString := FCarAV
  else
    qryDrafts.ParamByName('CARAV').IsNull;

  if FTmAV <> EmptyStr then
    qryDrafts.ParamByName('DRAV').AsString := FTmAV
  else
    qryDrafts.ParamByName('DRAV').IsNull;

  if FLastYear <> EmptyStr then
    qryDrafts.ParamByName('TO').AsString := FLastYear
  else
    qryDrafts.ParamByName('TO').IsNull;

  qryDrafts.ParamByName('ID').AsString := FId;

  try
    qryDrafts.ExecSQL;
    qryDrafts.ApplyUpdates;
  finally
    Close;
  end;
end;

end.


