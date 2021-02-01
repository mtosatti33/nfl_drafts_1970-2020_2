unit UTeamColors;

{mode objfpc}{H+}

interface

uses
  Classes, SysUtils, Graphics;

const
  Niners: array [1..2] of TColor = ($5D99B3, $0000AA);
  Bears: array [1..2] of TColor = ($0338C8, $2A160B);
  Bengals: array [1..2] of TColor = ($000000, $144FFB);
  Bills: array [1..2] of TColor = ($FFFFFF, $8D3300);
  Broncos: array [1..2] of TColor = ($442200, $144FFB);
  Browns: array [1..2] of TColor = ($003CFF, $001D31);
  Buccaneers: array [1..2] of TColor = ($0079FF, $0A0AD5);
  Cardinals: array [1..2] of TColor = ($FFFFFF, $3F2397);
  Chargers: array [1..2] of TColor = ($0EC2FF, $5E2A00);
  Chiefs: array [1..2] of TColor = ($1CB8FF, $3718E3);
  Colts: array [1..2] of TColor = ($FFFFFF, $5F2C00);
  Cowboys: array [1..2] of TColor = ($FFFFFF, $421E04);
  Dolphins: array [1..2] of TColor = ($FFFFFF, $978E00);
  Eagles: array [1..2] of TColor = ($AFACA5, $544C00);
  Falcons: array [1..2] of TColor = ($FFFFFF, $3019A7);
  Giants: array [1..2] of TColor = ($FFFFFF, $65220B);
  Jaguars: array [1..2] of TColor = ($FFFFFF, $786700);
  Jets: array [1..2] of TColor = ($FFFFFF, $405712);
  Lions: array [1..2] of TColor = ($BCB7B0, $B67600);
  Oilers: array [1..2] of TColor = ($2E10C8, $DE8F41);
  Packers: array [1..2] of TColor = ($12B6FF, $313720);
  Panthers: array [1..2] of TColor = ($000000, $CA8500);
  Patriots: array [1..2] of TColor = ($BCB7B0, $442200);
  Raiders: array [1..2] of TColor = ($AFACA5, $000000);
  Rams: array [1..2] of TColor = ($00A3FF, $943500);
  Ravens: array [1..2] of TColor = ($0C7C9E, $731724);
  Washington: array [1..2] of TColor = ($12B6FF, $413177);
  Saints: array [1..2] of TColor = ($000000, $8DBCD3);
  Seahawks: array [1..2] of TColor = ($28BE69, $442200);
  Steelers: array [1..2] of TColor = ($000000, $12B6FF);
  Texans: array [1..2] of TColor = ($FFFFFF, $3019A7);
  Titans: array [1..2] of TColor = ($DB924B, $40230C);
  Vikings: array [1..2] of TColor = ($2FC6FF, $83264F);

type

  { TTeamColor }

  TTeamColor = class
    function GetForeColor(year, team: string): TColor;
    function GetBackColor(year, team: string): TColor;
  end;

implementation

{ TTeamColor }

function TTeamColor.GetForeColor(year, team: string): TColor;
begin
  if team = 'ARI' then
    Result := Cardinals[1];

  if team = 'ATL' then
    Result := Falcons[1];

  if team = 'BAL' then
    if StrToInt(year) <= 1983 then
      Result := Colts[1]
    else if StrToInt(year) >= 1996 then
      Result := Ravens[1];

  if team = 'BOS' then
    Result := Patriots[1];

  if team = 'BUF' then
    Result := Bills[1];

  if team = 'CAR' then
    Result := Panthers[1];

  if team = 'CHI' then
    Result := Bears[1];

  if team = 'CIN' then
    Result := Bengals[1];

  if team = 'CLE' then
    Result := Browns[1];

  if team = 'DAL' then
    Result := Cowboys[1];

  if team = 'DEN' then
    Result := Broncos[1];

  if team = 'DET' then
    Result := Lions[1];

  if team = 'GNB' then
    Result := Packers[1];

  if team = 'HOU' then
    if StrToInt(year) <= 1998 then
      Result := Oilers[1]
    else if StrToInt(year) >= 2002 then
      Result := Texans[1];

  if team = 'IND' then
    Result := Colts[1];

  if team = 'JAX' then
    Result := Jaguars[1];

  if team = 'KAN' then
    Result := Chiefs[1];

  if team = 'LAC' then
    Result := Chargers[1];

  if team = 'LAR' then
    Result := Rams[1];

  if team = 'LVR' then
    Result := Raiders[1];

  if team = 'MIA' then
    Result := Dolphins[1];

  if team = 'MIN' then
    Result := Vikings[1];

  if team = 'NOR' then
    Result := Saints[1];

  if team = 'NWE' then
    Result := Patriots[1];

  if team = 'NYG' then
    Result := Giants[1];

  if team = 'NYJ' then
    Result := Jets[1];

  if team = 'OAK' then
    Result := Raiders[1];

  if team = 'PHI' then
    Result := Eagles[1];

  if team = 'PHO' then
    Result := Cardinals[1];

  if team = 'PIT' then
    Result := Steelers[1];

  if team = 'RAI' then
    Result := Raiders[1];

  if team = 'RAM' then
    Result := Rams[1];

  if team = 'SDG' then
    Result := Chargers[1];

  if team = 'SEA' then
    Result := Seahawks[1];

  if team = 'SFO' then
    Result := Niners[1];

  if team = 'STL' then
    Result := Rams[1];

  if team = 'TAM' then
    Result := Buccaneers[1];

  if team = 'TEN' then
    Result := Titans[1];

  if team = 'WAS' then
    Result := Washington[1];

end;

function TTeamColor.GetBackColor(year, team: string): TColor;
begin
  if team = 'ARI' then
    Result := Cardinals[2];

  if team = 'ATL' then
    Result := Falcons[2];

  if team = 'BAL' then
    if StrToInt(year) <= 1983 then
      Result := Colts[2]
    else if StrToInt(year) >= 1996 then
      Result := Ravens[2];

  if team = 'BOS' then
    Result := Patriots[2];

  if team = 'BUF' then
    Result := Bills[2];

  if team = 'CAR' then
    Result := Panthers[2];

  if team = 'CHI' then
    Result := Bears[2];

  if team = 'CIN' then
    Result := Bengals[2];

  if team = 'CLE' then
    Result := Browns[2];

  if team = 'DAL' then
    Result := Cowboys[2];

  if team = 'DEN' then
    Result := Broncos[2];

  if team = 'DET' then
    Result := Lions[2];

  if team = 'GNB' then
    Result := Packers[2];

  if team = 'HOU' then
    if StrToInt(year) <= 1998 then
      Result := Oilers[2]
    else if StrToInt(year) >= 2002 then
      Result := Texans[2];

  if team = 'IND' then
    Result := Colts[2];

  if team = 'JAX' then
    Result := Jaguars[2];

  if team = 'KAN' then
    Result := Chiefs[2];

  if team = 'LAC' then
    Result := Chargers[2];

  if team = 'LAR' then
    Result := Rams[2];

  if team = 'LVR' then
    Result := Raiders[2];

  if team = 'MIA' then
    Result := Dolphins[2];

  if team = 'MIN' then
    Result := Vikings[2];

  if team = 'NOR' then
    Result := Saints[2];

  if team = 'NWE' then
    Result := Patriots[2];

  if team = 'NYG' then
    Result := Giants[2];

  if team = 'NYJ' then
    Result := Jets[2];

  if team = 'OAK' then
    Result := Raiders[2];

  if team = 'PHI' then
    Result := Eagles[2];

  if team = 'PHO' then
    Result := Cardinals[2];

  if team = 'PIT' then
    Result := Steelers[2];

  if team = 'RAI' then
    Result := Raiders[2];

  if team = 'RAM' then
    Result := Rams[2];

  if team = 'SDG' then
    Result := Chargers[2];

  if team = 'SEA' then
    Result := Seahawks[2];

  if team = 'SFO' then
    Result := Niners[2];

  if team = 'STL' then
    Result := Rams[2];

  if team = 'TAM' then
    Result := Buccaneers[2];

  if team = 'TEN' then
    Result := Titans[2];

  if team = 'WAS' then
    Result := Washington[2];
end;

end.

