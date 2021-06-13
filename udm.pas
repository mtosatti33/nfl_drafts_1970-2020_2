unit UDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, Dialogs, UConfiguration,
  UDatasetConstants;
  //TODO: adicionar esta instrução abaixo

  {
      SELECT * FROM drafts
      WHERE (-1=:yr_from or Draft_Yr between :yr_from and :yr_to)
      and (''=:team_id or Tm=:team_id)
      and (0=:rnd_from or Rnd BETWEEN :rnd_from and :rnd_to)
      and (''=:position or "Pos"=:position)
      and (''=:college or College=:college)
      and (-1=:is_suppl or Is_Suppl=:is_suppl)
      and (0=:first_pick or Pick=1)
      and (0=:never_played or (G=0 or G=''))
      and (0=:all_pro or AP1 > 0)
      and (0=:pro_bowl or PB > 0)
      order by Draft_Yr ,RND, PICK

  }
type

  { Tdm }

  Tdm = class(TDataModule)
    conn: TZConnection;
    qryCollegeName: TZQuery;
    qryCollegeCount: TZQuery;
    qryCollegeAV: TZQuery;
    qryPositionName: TZQuery;
    qryPositionCount: TZQuery;
    qryPicks: TZQuery;
    qryPositionAV: TZQuery;
    qryTeamName: TZQuery;
    qryTeamCount: TZQuery;
    qryTeamAV: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  dm: Tdm;
  iniStrings: TIniStrings;

implementation

{$R *.lfm}


{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  dir, arch: string;
begin
  iniStrings := ReadIniFile;

  {$IfDef MSWINDOWS}
  dir:= WIN_DIR;
  {$EndIf}

  //Linux works with "/" directories instead "\" on windows.
  //The app should see the database drafts.db
  {$IFDEF LINUX}
  dir:= LINUX_DIR;
  {$EndIf}

  {$IfDef WIN32}
  arch := ARCH_X86;
  {$EndIf}

  {$IfDef WIN64}
  arch := ARCH_X64;
  {$EndIf}

  conn.LibraryLocation := arch + iniStrings.lib;
  conn.Database := dir + iniStrings.database;
  conn.Protocol := iniStrings.protocol;

  try
    conn.Connected := True;
  except
    on E: Exception do
      ShowMessage('A error ocurred: ' + E.Message);
  end;
end;

end.
