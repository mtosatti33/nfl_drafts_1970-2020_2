unit uplayercomp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  DBGrids, UDM, ZDataset, Grids, upaintgrid;

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
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
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
end;

procedure TfrmPlayerComp.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  MouseX := X + Panel1.Left;
  MouseY := Y + Panel1.Top;
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

procedure TfrmPlayerComp.Panel1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  if ssLeft in Shift then
  begin
    Left := Mouse.CursorPos.x - MouseX;
    Top := Mouse.CursorPos.y - MouseY;
  end;
end;

end.









