unit uquerybuilder;
//TODO: implementar as queries que estão no DataModule pra dinamizar o sql do programa
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TQueryBuilder }
  TChooseQuery = (cqSelect, cqTeamCount, cqTeamAV, cqTeamName,
    cqCollegeCount, cqCollegeAV, cqCollegeName,
    cqPosCount, cqPosAV, cqPosName);

  TQueryBuilder = class
  private
    Ffields: string;
    FTables: string;
    Fgroup: string;
    Forder: string;
    Fyear: string;
    Fteam: string;
    Fround: string;
    Fposition: string;
    Fcollege: string;
    Fsupplem: string;
    Ffirst_picks: string;
    Fnever_played: string;
    Fall_pro: string;
    Fpro_bowl: string;
    procedure SetSelect;
    procedure SetTeamCount;
    procedure SetTeamAV;
    procedure SetTeamName;
    procedure SetCollegeCount;
    procedure SetCollegeAV;
    procedure SetCollegeName;
    procedure SetPosCount;
    procedure SetPosAV;
    procedure SetPosName;
    function GetResultQuery: TStringList;
  public
    function Get(AChooseQuery: TChooseQuery): TStringList;
    constructor Create;
  end;

implementation

{ TQueryBuilder }

procedure TQueryBuilder.SetSelect;
begin
  Ffields := 'SELECT * ';
  FTables := 'FROM drafts';
  Fgroup := '';
  Forder := 'order by Draft_Yr ,RND, PICK';
end;

procedure TQueryBuilder.SetTeamCount;
begin
  Ffields := 'select a.Tm , count(a.Player) as count';
  FTables := 'from drafts a';
  Fgroup := 'group by a.Tm ';
  Forder := 'order by 2 desc, a.Tm asc';
end;

procedure TQueryBuilder.SetTeamAV;
begin
  Ffields := 'select a.Tm, SUM(a.DrAV) as sum';
  FTables := 'from drafts a';
  Fgroup := 'group by a.Tm ';
  Forder := 'order by 2 DESC, A.Tm ASC';
end;

procedure TQueryBuilder.SetTeamName;
begin
  Ffields := 'select a.Tm ,count(a.Player) as count';
  FTables := 'from drafts a ';
  Fgroup := 'group by a.Tm ';
  Forder := 'order by A.Tm ASC, 2 DESC';
end;

procedure TQueryBuilder.SetCollegeCount;
begin
  Ffields := 'select a.College , COUNT(A.College) as count';
  FTables := 'from drafts a ';
  Fgroup := 'group by a.College';
  Forder := 'order by 2 DESC, A.College ASC';
end;

procedure TQueryBuilder.SetCollegeAV;
begin
  Ffields := 'select a.College ,SUM(a.CarAV) as sum';
  FTables := 'from drafts a ';
  Fgroup := 'group by a.College ';
  Forder := 'order by 2 DESC, A.College ASC';
end;

procedure TQueryBuilder.SetCollegeName;
begin
  Ffields := 'select a.College , COUNT(A.College) as count';
  FTables := 'from drafts a ';
  Fgroup := 'group by a.College ';
  Forder := 'order by A.College ASC, 2 DESC';
end;

procedure TQueryBuilder.SetPosCount;
begin
  Ffields := 'select a.Pos,COUNT(A.Pos) as count';
  FTables := 'from drafts a ';
  Fgroup := 'group by a.Pos ';
  Forder := 'order by 2 DESC, A.Pos ASC';
end;

procedure TQueryBuilder.SetPosAV;
begin
  Ffields := 'select a.Pos,SUM(a.CarAV) as sum';
  FTables := 'from drafts a ';
  Fgroup := 'group by a.Pos ';
  Forder := 'order by 2 DESC, a.Pos ASC';
end;

procedure TQueryBuilder.SetPosName;
begin
  Ffields := 'select a.Pos,COUNT(a.Pos) as count';
  FTables := 'from drafts a ';
  Fgroup := 'group by a.Pos ';
  Forder := 'order by a.Pos ASC, 2 DESC';
end;

function TQueryBuilder.GetResultQuery: TStringList;
var
  List: TStringList;
begin
  List := TStringList.Create;

  List.Add(Ffields);
  List.Add(FTables);
  List.Add(Fyear);
  List.Add(Fteam);
  List.Add(Fround);
  List.Add(Fposition);
  List.Add(Fcollege);
  List.Add(Fsupplem);
  List.Add(Ffirst_picks);
  List.Add(Fnever_played);
  List.Add(Fall_pro);
  List.Add(Fpro_bowl);
  List.Add(Fgroup);
  List.Add(Forder);


  Result := List;
end;

function TQueryBuilder.Get(AChooseQuery: TChooseQuery): TStringList;
begin
  case AChooseQuery of

    cqSelect:
    begin
      SetSelect;
    end;

    cqTeamCount:
    begin
      SetTeamCount;
    end;

    cqTeamAV:
    begin    
      SetTeamAV;
    end;

    cqTeamName:
    begin      
      SetTeamName;
    end;

    cqCollegeCount:
    begin
      SetCollegeCount;
    end;

    cqCollegeAV:
    begin
      SetCollegeAV;
    end;

    cqCollegeName:
    begin
      SetCollegeName;
    end;

    cqPosCount:
    begin
      SetPosCount;
    end;

    cqPosAV:
    begin
      SetPosAV;
    end;

    cqPosName:
    begin
      SetPosName;
    end;
  end;

  Result := GetResultQuery
end;

constructor TQueryBuilder.Create;
begin
  Ffields := '';
  FTables := '';
  Fgroup := '';
  Forder := '';
  Fyear := 'WHERE (-1=:yr_from or Draft_Yr between :yr_from and :yr_to)';
  Fteam := 'and ('+QuotedStr('')+'=:team_id or Tm=:team_id)';
  Fround := 'and (0=:rnd_from or Rnd BETWEEN :rnd_from and :rnd_to)';
  Fposition := 'and ('+QuotedStr('')+'=:position or "Pos"=:position)';
  Fcollege := 'and ('+QuotedStr('')+'=:college or College=:college)';
  Fsupplem := 'and (-1=:is_suppl or Is_Suppl=:is_suppl)';
  Ffirst_picks := 'and (0=:first_pick or Pick=1)';
  Fnever_played := 'and (0=:never_played or (G=0 or G is null))';
  Fall_pro := 'and (0=:all_pro or AP1 > 0)';
  Fpro_bowl := 'and (0=:pro_bowl or PB > 0)';
end;

end.
