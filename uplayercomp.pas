unit uplayercomp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  DBGrids, UDM, ZDataset, Grids, upaintgrid, uextendcomponents;

type

  { TfrmPlayerComp }

  TfrmPlayerComp = class(TForm)
    dsStats: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    qryStats: TZQuery;
    procedure DBGrid1PrepareCanvas(Sender: TObject; DataCol: integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FDateFinal: string;
    FDateInitial: string;
    FPosition: string;
    FAsc: boolean;
    MouseX: integer;
    MouseY: integer;
    procedure setColumnVisibilityByPosition;
    procedure HideColumns;
    procedure LoadComponents;
  public
    property DateInitial: string read FDateInitial write FDateInitial;
    property DateFinal: string read FDateFinal write FDateFinal;
    property Position: string read FPosition write FPosition;

  end;

var
  frmPlayerComp: TfrmPlayerComp;

implementation

{$R *.lfm}

{ TfrmPlayerComp }

procedure TfrmPlayerComp.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlayerComp.setColumnVisibilityByPosition;
var
  i: integer;
begin
  //Quarterbacks
  if FPosition = 'QB' then
  begin
    for i := 6 to 10 do
    begin
      DBGrid1.Columns[i].Visible := True;
    end;
  end;

  //Running Backs and Fullbacks
  if (FPosition = 'RB') or (FPosition = 'FB') then
  begin
    for i := 11 to 13 do
    begin
      DBGrid1.Columns[i].Visible := True;
    end;
  end;
  //Wide Receivers and Tight Ends
  if (FPosition = 'WR') or (FPosition = 'TE') then
  begin
    for i := 14 to 16 do
    begin
      DBGrid1.Columns[i].Visible := True;
    end;
  end;
  //Defense
  if (FPosition = 'DE') or (FPosition = 'DT') or (FPosition = 'DL') or
    (FPosition = 'NT') or (FPosition = 'OLB') or (FPosition = 'ILB') or
    (FPosition = 'LB') or (FPosition = 'CB') or (FPosition = 'DB') or (FPosition = 'S') then
  begin
    for i := 17 to 19 do
    begin
      DBGrid1.Columns[i].Visible := True;
    end;
  end;
end;

procedure TfrmPlayerComp.HideColumns;
var
  i: integer;
begin
  for i := 6 to DBGrid1.Columns.Count - 1 do
  begin
    DBGrid1.Columns[i].Visible := False;
  end;
end;

procedure TfrmPlayerComp.LoadComponents;
begin
  FAsc := False; 
  panel1.MoveMousePanel:=true;
end;

procedure TfrmPlayerComp.DBGrid1PrepareCanvas(Sender: TObject;
  DataCol: integer; Column: TColumn; AState: TGridDrawState);
var
  PaintGrid: TPaintGrid;
begin
  PaintGrid := TPaintGrid.Create(DBGrid1, qryStats, DataCol);
  try
    PaintGrid.Paint;
  finally
    FreeAndNil(PaintGrid);
  end;
end;

procedure TfrmPlayerComp.DBGrid1TitleClick(Column: TColumn);
begin
  FAsc := not FAsc;
  if FAsc then
    qryStats.IndexFieldNames := Column.FieldName
  else
    qryStats.IndexFieldNames := Column.FieldName + ' DESC';

  qryStats.First;
end;

procedure TfrmPlayerComp.FormCreate(Sender: TObject);
begin
  LoadComponents;
end;

procedure TfrmPlayerComp.FormShow(Sender: TObject);
begin
  qryStats.ParamByName('dti').AsString := FDateInitial;
  qryStats.ParamByName('dtf').AsString := FDateFinal;
  qryStats.ParamByName('pos').AsString := FPosition;
  qryStats.Open;

  HideColumns;
  setColumnVisibilityByPosition;
end;

end.









