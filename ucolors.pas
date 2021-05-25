unit UColors;

{mode objfpc}{H+}

interface

uses
  Classes, SysUtils, Graphics, UColorConstants;

const
  FORECOLOR = 1;
  BACKCOLOR = 2;

type
  { TGenericColorClass }

  TGenericColorClass = class
  protected
    FColor: TColor;
  public
    constructor Create;
  end;

  { TTeamColor }

  TTeamColor = class(TGenericColorClass)
  public
    function GetColor(year, team: string; index: byte): TColor;
    constructor Create;
  end;

  { TMarginColor }

  TMarginColor = class(TGenericColorClass)
  public
    function GetColor(res, index: byte): TColor;
    constructor Create;
  end;

  { TRoundColor }

  TRoundColor = class(TGenericColorClass)
  public
    function GetColor(rnd, index: byte): TColor;
    constructor Create;
  end;

implementation

{ TRoundColor }

function TRoundColor.GetColor(rnd, index: byte): TColor;
begin
  //Round 1
  if rnd = 1 then
    FColor:=Round1[index];

  //Round 2
  if rnd = 2 then
    FColor:=Round2[index];

  //Round 3
  if rnd = 3 then
    FColor:=Round3[index];

  //Round 4
  if rnd = 4 then
    FColor:=Round4[index];

  //Round 5
  if rnd = 5 then
    FColor:=Round5[index];

  //Round 6
  if rnd = 6 then
    FColor:=Round6[index];

  //Round 7 and other rounds before 1994
  if rnd >= 7 then
    FColor:=Round7[index];

  Result := FColor;
end;

constructor TRoundColor.Create;
begin
  inherited Create;
end;

{ TGenericColorClass }

constructor TGenericColorClass.Create;
begin
  inherited Create;
  FColor := $000000;
end;

{ TMarginColor }

function TMarginColor.GetColor(res, index: byte): TColor;
begin
  if res = 0 then
    FColor := SameYear[index];
  if (res > 0) and (res <= 3) then
  begin
    FColor := UntilThreeYear[index];
  end;

  if (res > 3) then
    FColor := ThreeYearAndMore[index];

  Result := FColor;
end;

constructor TMarginColor.Create;
begin
  inherited Create;
end;

{ TTeamColor }

function TTeamColor.GetColor(year, team: string; index: byte): TColor;
begin
  if (team = 'ARI') or (team = 'PHO') then
    FColor := Cardinals[index];

  if team = 'ATL' then
    FColor := Falcons[index];

  if team = 'BAL' then
    if StrToInt(year) <= 1983 then
      FColor := Colts[index]
    else if StrToInt(year) >= 1996 then
      FColor := Ravens[index];

  if (team = 'BOS') or (team = 'NWE') then
    FColor := Patriots[index];

  if team = 'BUF' then
    FColor := Bills[index];

  if team = 'CAR' then
    FColor := Panthers[index];

  if team = 'CHI' then
    FColor := Bears[index];

  if team = 'CIN' then
    FColor := Bengals[index];

  if team = 'CLE' then
    FColor := Browns[index];

  if team = 'DAL' then
    FColor := Cowboys[index];

  if team = 'DEN' then
    FColor := Broncos[index];

  if team = 'DET' then
    FColor := Lions[index];

  if team = 'GNB' then
    FColor := Packers[index];

  if team = 'HOU' then
    if StrToInt(year) <= 1996 then
      FColor := Oilers[index]
    else if StrToInt(year) >= 2002 then
      FColor := Texans[index];

  if team = 'IND' then
    FColor := Colts[index];

  if team = 'JAX' then
    FColor := Jaguars[index];

  if team = 'KAN' then
    FColor := Chiefs[index];

  if (team = 'LAC') or (team = 'SDG') then
    FColor := Chargers[index];

  if (team = 'LVR') or (team = 'OAK') or (team = 'RAI') then
    FColor := Raiders[index];

  if team = 'MIA' then
    FColor := Dolphins[index];

  if team = 'MIN' then
    FColor := Vikings[index];

  if team = 'NOR' then
    FColor := Saints[index];

  if team = 'NYG' then
    FColor := Giants[index];

  if team = 'NYJ' then
    FColor := Jets[index];

  if team = 'PHI' then
    FColor := Eagles[index];

  if team = 'PIT' then
    FColor := Steelers[index];

  if (team = 'RAM') or (team = 'LAR') then
    FColor := Rams[index];

  if team = 'STL' then
    if StrToInt(year) <= 1987 then
       FColor:=Cardinals[index]
    else if StrToInt(year) >= 1995 then
       FColor:=Rams[index];

  if team = 'SEA' then
    FColor := Seahawks[index];

  if team = 'SFO' then
    FColor := Niners[index];

  if team = 'TAM' then
    FColor := Buccaneers[index];

  if team = 'TEN' then
    FColor := Titans[index];

  if team = 'WAS' then
    FColor := Washington[index];

  Result := FColor;

end;

constructor TTeamColor.Create;
begin
  inherited Create;
end;

end.

