unit uPrepareQuery;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, udm, ZDataset;

type

  { TPrepareQuery }

  TPrepareQuery = class
  private
    Fyr_from: string;
    Fyr_to: string;
    Fteam: string;
    Fround: integer;
    Fposition: string;
    Fcollege: string;
    Fsupplemental: integer;
    Ffirst_pick: boolean;
    Fnever_played: boolean;
    Fall_pro: boolean;
    Fpro_bowl: boolean;
  public
    procedure Load;
    constructor Create(yr_from, yr_to, team, position, college: string;
      round, supplemental: integer;
      first_pick, never_played, all_pro, pro_bowl: boolean);
  end;

implementation

{ TPrepareQuery }

procedure TPrepareQuery.Load;
var
  qry: TZQuery;
  i: integer;
begin
  with dm do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TZQuery then
      begin
        qry := Components[i] as TZQuery;

        qry.Close;

        if Fyr_from <> '' then
          qry.ParamByName('yr_from').AsString := Fyr_from
        else
          qry.ParamByName('yr_from').AsInteger := -1;

        qry.ParamByName('yr_to').AsString := Fyr_to;
        qry.ParamByName('team_id').AsString := Fteam;
        qry.ParamByName('rnd').AsInteger := Fround;
        qry.ParamByName('position').AsString := Fposition;
        qry.ParamByName('college').AsString := Fcollege;
        qry.ParamByName('is_suppl').AsInteger := Fsupplemental;
        qry.ParamByName('first_pick').AsInteger := integer(Ffirst_pick);
        qry.ParamByName('never_played').AsInteger := integer(Fnever_played);
        qry.ParamByName('all_pro').AsInteger := integer(Fall_pro);
        qry.ParamByName('pro_bowl').AsInteger := integer(Fpro_bowl);
        qry.Open;

        qry.First;
      end;
    end;
  end;
end;

constructor TPrepareQuery.Create(yr_from, yr_to, team, position, college: string;
  round, supplemental: integer; first_pick, never_played, all_pro, pro_bowl: boolean);
begin
  Fyr_from := yr_from;
  Fyr_to := yr_to;
  Fteam := team;
  Fround := round + 1;
  Fposition := position;
  Fcollege := college;
  Fsupplemental := supplemental - 1;
  Ffirst_pick := first_pick;
  Fnever_played := never_played;
  Fall_pro := all_pro;
  Fpro_bowl := pro_bowl;
end;

end.


