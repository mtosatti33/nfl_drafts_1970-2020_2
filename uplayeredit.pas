unit UPlayerEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList,
  ExtCtrls, ZDataset, ZSqlUpdate;

type

  { TfrmPlayerEdit }

  TfrmPlayerEdit = class(TForm)
    actApply: TAction;
    actCancel: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    cmbHofer: TComboBox;
    cmbActive: TComboBox;
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
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblID: TLabel;
    lblName: TLabel;
    lblPosition: TLabel;
    lblCollege: TLabel;
    qryStats: TZQuery;
    qryPlayer: TZQuery;
    Shape1: TShape;
    procedure actApplyExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    FHofer: Byte;
    FActive: Byte;
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
    property Hofer: byte read FHofer write FHofer;
    property Active: byte read FActive write FActive;
    property LastYearPlayed: string read FLastYear write FLastYear;
    property IsSave: Boolean read FIsSave write FIsSave;
  end;

var
  frmPlayerEdit: TfrmPlayerEdit;

implementation

uses UDM;

{$R *.lfm}

{ TfrmPlayerEdit }

procedure TfrmPlayerEdit.FormShow(Sender: TObject);
begin
  lblID.Caption:=FId;
  lblName.Caption:=FName;
  lblPosition.Caption:=FPosition;
  lblCollege.Caption:=FCollege;

  cmbActive.ItemIndex:=FActive;
  cmbHofer.ItemIndex:=FHofer;
  edtLastYear.Text:=FLastYear;
  edtAllPro.Text:=FAllPro;
  edtProBowl.Text:=FProBowl;
  edtStarter.Text:=FStarter;
  edtGames.Text:=FGames;
  edtCarAV.Text:=FCarAV;
  edtTmAV.Text:=FTmAV;
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
  FActive:=cmbActive.ItemIndex;
  FHofer:=cmbHofer.ItemIndex;
  FLastYear:=edtLastYear.Text;

  qryStats.ParamByName('all_pro').AsString:=FAllPro;
  qryStats.ParamByName('PRO_BOWL').AsString:=FProBowl;
  qryStats.ParamByName('YEARS_STARTER').AsString:=FStarter;

  if FGames <> EmptyStr then
     qryStats.ParamByName('GAMES').AsString:=FGames
  else
      qryStats.ParamByName('GAMES').IsNull;

  if FCarAV <> EmptyStr then
     qryStats.ParamByName('CAREER_AV').AsString:=FCarAV
  else
      qryStats.ParamByName('CAREER_AV').IsNull;

  if FTmAV <> EmptyStr then
      qryStats.ParamByName('TEAM_AV').AsString:=FTmAV
  else
      qryStats.ParamByName('TEAM_AV').IsNull;

  qryStats.ParamByName('PLAYER_ID').AsString:=FId;

  qryPlayer.ParamByName('active').AsInteger:=FActive;
  qryPlayer.ParamByName('hofer').AsInteger:=FHofer;

  if FLastYear <> EmptyStr then
     qryPlayer.ParamByName('yrs_to').AsString:=FLastYear
  else
     qryPlayer.ParamByName('yrs_to').IsNull;

  qryPlayer.ParamByName('id').AsString:=FId;

  try
    qryStats.ExecSQL;
    qryStats.ApplyUpdates;

    qryPlayer.ExecSQL;
    qryPlayer.ApplyUpdates;
  finally
    Close;
  end;
end;

end.

