unit uPrepareQuery;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, udm;

type

  { TPrepareQuery }

  TPrepareQuery = class
  private
    Fyr_from: string;
    Fyr_to: string;
    Fteam: integer;
    Fround: integer;
    Fposition: integer;
    Fcollege: integer;
    Fudfa: integer;
    Factive: integer;
    Fsupplemental: integer;
    Fhofer: integer;
    Ffirst_pick: Boolean;
    Fnever_played: Boolean;
    Fall_pro: Boolean;
    Fpro_bowl: Boolean;
  public
    procedure Load;
    constructor Create(yr_from, yr_to: string; team, round,
  position, college, udfa, active, supplemental, hofer: integer;
  first_pick, never_played, all_pro, pro_bowl: Boolean);
  end;

implementation

{ TPrepareQuery }

procedure TPrepareQuery.Load;
begin
  with dm.qryPicks do
  begin
  	Close;

    if Fyr_from <> '' then
  	  ParamByName('yr_from').AsString:=Fyr_from
     else
	  ParamByName('yr_from').AsInteger:=-1;

    ParamByName('yr_to').AsString:= Fyr_to;
    ParamByName('team').AsInteger:=Fteam;
    ParamByName('rnd').AsInteger:=Fround;
    ParamByName('pos').AsInteger:=Fposition;
    ParamByName('college').AsInteger:=Fcollege;
    ParamByName('udfa').AsInteger:=Fudfa;
    ParamByName('active').AsInteger:=Factive;
    ParamByName('suppl').AsInteger:=Fsupplemental;
    ParamByName('hofer').AsInteger:=Fhofer;
    ParamByName('first_pick').AsBoolean:=Ffirst_pick;
    ParamByName('never_played').AsBoolean:=Fnever_played;
    ParamByName('all_pro').AsBoolean:=Fall_pro;
    ParamByName('pro_bowl').AsBoolean:=Fpro_bowl;
    Open;

    First;
  end;
end;

constructor TPrepareQuery.Create(yr_from, yr_to: string; team, round,
  position, college, udfa, active, supplemental, hofer: integer;
  first_pick, never_played, all_pro, pro_bowl: Boolean);
begin
  Fyr_from:= yr_from;
  Fyr_to:= yr_to;
  Fteam:= team + 1;
  Fround:= round + 1;
  Fposition:= position + 1;
  Fcollege:= college + 1;
  Fudfa:= udfa -1;
  Factive:= active -1;
  Fsupplemental:= supplemental -1;
  Fhofer:= hofer -1;
  Ffirst_pick:= first_pick;
  Fnever_played:= never_played;
  Fall_pro:= all_pro;
  Fpro_bowl:= pro_bowl;
end;

end.

