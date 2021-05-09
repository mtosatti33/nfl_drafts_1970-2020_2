unit upaintgrid;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DBGrids, ZDataset, Graphics, UColors;

type

  { TPaintGrid }

  TPaintGrid = class
  private
    FGrid: TDBGrid;
    FQuery: TZQuery;
    FDatacol: integer;
  public
    procedure Paint(index: byte); overload;
    procedure Paint; overload;
    constructor Create(grid: TDBGrid; qry: TZQuery; datacol: integer);
  end;

implementation

{ TPaintGrid }

procedure TPaintGrid.Paint(index: byte);
var
  rnd, car_av, tm_av, res, starter: word;
  draft_yr, team: string;
  TeamColor: TTeamColor;
  MarginColor: TMarginColor;
  RoundColor: TRoundColor;

  function SetValue(field: string): integer;
  begin
    if FQuery.FieldByName(field).IsNull then
      Result := 0
    else
      Result := FQuery.FieldByName(field).Value;
  end;

begin
  draft_yr := FQuery.FieldByName('draft_yr').AsString;
  team := FQuery.FieldByName('Tm').AsString;

  TeamColor := TTeamColor.Create;
  MarginColor := TMarginColor.Create;
  RoundColor := TRoundColor.Create;

  //RecordCount should be different from 0
  //Define carrer av to 0 if it's null
  try
    if FQuery.RecordCount <> 0 then
    begin
      car_av := SetValue('carAV');
      tm_av := SetValue('DrAV');
      rnd := SetValue('rnd');
      starter := SetValue('ST');
      res := car_av - tm_av;

      case Index of
        //Team Colors
        0:
        begin
          if FDataCol = 3 then
          begin
            FGrid.Canvas.Font.Color := TeamColor.GetColor(draft_yr, team, FORECOLOR);
            FGrid.Canvas.Brush.Color := TeamColor.GetColor(draft_yr, team, BACKCOLOR);
          end;
        end;
        // AV Margin
        1:
        begin
          if FDatacol in [0..10] then
          begin
            FGrid.Canvas.Font.Color := MarginColor.GetColor(res, FORECOLOR);
            FGrid.Canvas.Brush.Color := MarginColor.GetColor(res, BACKCOLOR);
          end;
        end;
        //Av by Round
        2:
        begin
          if FDatacol in [0..10] then
          begin
            FGrid.Canvas.Font.Color := RoundColor.GetColor(rnd, FORECOLOR);
            FGrid.Canvas.Brush.Color := RoundColor.GetColor(rnd, BACKCOLOR);
          end;
        end;
        //Efficiency
        3:
        begin
        {if starter = 0 then
        if starter = 1 then
        if starter = 2 then
        if starter = 3 then
        if starter = 4 then
        if starter >=5 then}
        end;
      end;

    end;

  finally
    TeamColor.Free;
    MarginColor.Free;
    RoundColor.Free;
  end;
end;

procedure TPaintGrid.Paint;
var
  draft_yr, team: string;
  TeamColor: TTeamColor;
begin
  draft_yr := FQuery.FieldByName('draft_yr').AsString;
  team := FQuery.FieldByName('Tm').AsString;

  TeamColor := TTeamColor.Create;

  try
    if FDataCol = 4 then
    begin
      FGrid.Canvas.Font.Color := TeamColor.GetColor(draft_yr, team, FORECOLOR);
      FGrid.Canvas.Brush.Color := TeamColor.GetColor(draft_yr, team, BACKCOLOR);
    end;

  finally
    TeamColor.Free;
  end;
end;

constructor TPaintGrid.Create(grid: TDBGrid; qry: TZQuery; datacol: integer);
begin
  FGrid := grid;
  FQuery := qry;
  FDatacol := datacol;
end;

end.
