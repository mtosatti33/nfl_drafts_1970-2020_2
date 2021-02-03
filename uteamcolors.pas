unit UTeamColors;

{mode objfpc}{H+}

interface

uses
  Classes, SysUtils, Graphics, UTeamColorConstants;

const
  FORECOLOR = 1;
  BACKCOLOR = 2;

type

  { TTeamColor }

  TTeamColor = class
    function GetColor(year, team: string; index: byte): TColor;
  end;

implementation

{ TTeamColor }

function TTeamColor.GetColor(year, team: string; index: byte): TColor;
var
  Color: TColor;
begin
  Color := $000000;
  if (team = 'ARI') or (team = 'PHO') then
    Color := Cardinals[index];

  if team = 'ATL' then
    Color := Falcons[index];

  if team = 'BAL' then
    if StrToInt(year) <= 1983 then
      Color := Colts[index]
    else if StrToInt(year) >= 1996 then
      Color := Ravens[index];

  if (team = 'BOS') or (team = 'NWE') then
    Color := Patriots[index];

  if team = 'BUF' then
    Color := Bills[index];

  if team = 'CAR' then
    Color := Panthers[index];

  if team = 'CHI' then
    Color := Bears[index];

  if team = 'CIN' then
    Color := Bengals[index];

  if team = 'CLE' then
    Color := Browns[index];

  if team = 'DAL' then
    Color := Cowboys[index];

  if team = 'DEN' then
    Color := Broncos[index];

  if team = 'DET' then
    Color := Lions[index];

  if team = 'GNB' then
    Color := Packers[index];

  if team = 'HOU' then
    if StrToInt(year) <= 1996 then
      Color := Oilers[index]
    else if StrToInt(year) >= 2002 then
      Color := Texans[index];

  if team = 'IND' then
    Color := Colts[index];

  if team = 'JAX' then
    Color := Jaguars[index];

  if team = 'KAN' then
    Color := Chiefs[index];

  if (team = 'LAC') or (team = 'SDG') then
    Color := Chargers[index];

  if (team = 'LVR') or (team = 'OAK') or (team = 'RAI') then
    Color := Raiders[index];

  if team = 'MIA' then
    Color := Dolphins[index];

  if team = 'MIN' then
    Color := Vikings[index];

  if team = 'NOR' then
    Color := Saints[index];

  if team = 'NYG' then
    Color := Giants[index];

  if team = 'NYJ' then
    Color := Jets[index];

  if team = 'PHI' then
    Color := Eagles[index];

  if team = 'PIT' then
    Color := Steelers[index];

  if (team = 'RAM') or (team = 'LAR') or (team = 'STL') then
    Color := Rams[index];

  if team = 'SEA' then
    Color := Seahawks[index];

  if team = 'SFO' then
    Color := Niners[index];

  if team = 'TAM' then
    Color := Buccaneers[index];

  if team = 'TEN' then
    Color := Titans[index];

  if team = 'WAS' then
    Color := Washington[index];

  Result := Color;

end;

end.

