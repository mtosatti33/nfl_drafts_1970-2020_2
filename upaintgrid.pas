unit upaintgrid;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DBGrids, ZDataset, Graphics, UTeamColors;

type

  { TPaintGrid }

  TPaintGrid = class
  private
    FGrid: TDBGrid;
    FQuery: TZQuery;
    FDatacol: integer;
  public
    procedure Paint(index: byte);
    constructor Create(grid: TDBGrid; qry: TZQuery; datacol: integer);
  end;

implementation

{ TPaintGrid }

procedure TPaintGrid.Paint(index: byte);
var
  rnd, car_av, tm_av, res, starter: word;
  draft_yr, team: string;
  TeamColor: TTeamColor;
begin
  draft_yr := FQuery.FieldByName('draft_yr').AsString;
  team := FQuery.FieldByName('Tm').AsString;

  if TeamColor = nil then
    TeamColor := TTeamColor.Create;

  //RecordCount should be different from 0
  if FQuery.RecordCount <> 0 then
  begin
    //Define carrer av to 0 if it's null
    if FQuery.FieldByName('carAV').IsNull then
      car_av := 0
    else
      car_av := FQuery.FieldByName('carAV').Value;

    //Define team av to 0 if it's null
    if FQuery.FieldByName('DrAV').IsNull then
      tm_av := 0
    else
      tm_av := FQuery.FieldByName('DrAV').Value;

    //Define round av to 0 if it's null
    if FQuery.FieldByName('rnd').IsNull then
      rnd := 0
    else
      rnd := FQuery.FieldByName('rnd').Value;

    starter := FQuery.FieldByName('ST').Value;
  end;

  case Index of
    //Team Colors
    0:
    begin
      if FQuery.RecordCount <> 0 then
        if FDataCol = 3 then
        begin
          FGrid.Canvas.Font.Color := TeamColor.GetColor(draft_yr, team, FORECOLOR);
          FGrid.Canvas.Brush.Color := TeamColor.GetColor(draft_yr, team, BACKCOLOR);
        end;
    end;
    // AV Margin
    1:
    begin
      if FQuery.RecordCount <> 0 then
      begin
        if FDatacol in [0..10] then
        begin
          FGrid.Canvas.Font.Color := clWhite;
          //Res is difference between car_av - tm_av
          res := car_av - tm_av;
          if res = 0 then
            FGrid.Canvas.Brush.Color := $007BBE63;
          if (res > 0) and (res <= 3) then
          begin
            FGrid.Canvas.Brush.Color := $0084EBFF;
            FGrid.Canvas.Font.Color := $005E4934;
          end;

          if (res > 3) then
            FGrid.Canvas.Brush.Color := $006B69F8;
        end;
      end;
    end;
    //Av by Round
    2:
    begin
      if FQuery.RecordCount <> 0 then
      begin
        if FDatacol in [0..10] then
        begin
          FGrid.Canvas.Font.Color := clWhite;

          //Round 0 (Undrafted)
          if rnd = 0 then
            FGrid.Canvas.Brush.Color := clBlue;

          //Round 1
          if rnd = 1 then
            FGrid.Canvas.Brush.Color := $006B69F8;

          //Round 2
          if rnd = 2 then
            FGrid.Canvas.Brush.Color := $007394FA;

          //Round 3
          if rnd = 3 then
          begin
            FGrid.Canvas.Brush.Color := $007BBFFC;
            FGrid.Canvas.Font.Color := $005E4934;
          end;

          //Round 4
          if rnd = 4 then
          begin
            FGrid.Canvas.Brush.Color := $0084EBFF;
            FGrid.Canvas.Font.Color := $005E4934;
          end;
          //Round 5
          if rnd = 5 then
          begin
            FGrid.Canvas.Brush.Color := $0082DDCC;
            FGrid.Canvas.Font.Color := $005E4934;
          end;

          //Round 6
          if rnd = 6 then
            FGrid.Canvas.Brush.Color := $007FCE98;

          //Round 7 and other rounds before 1994
          if rnd >= 7 then
            FGrid.Canvas.Brush.Color := $007BBE63;
        end;

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

constructor TPaintGrid.Create(grid: TDBGrid; qry: TZQuery; datacol: integer);
begin
  FGrid := grid;
  FQuery := qry;
  FDatacol := datacol;
end;

end.
