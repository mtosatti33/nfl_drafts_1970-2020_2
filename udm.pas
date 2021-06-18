unit UDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, Dialogs, UConfiguration,
  UDatasetConstants, uquerybuilder;
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
  QueryBuilder: TQueryBuilder;
implementation

{$R *.lfm}


{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  dir, arch: string;
begin
  iniStrings := ReadIniFile;
  QueryBuilder:= TQueryBuilder.Create;

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

  qryPicks.SQL := QueryBuilder.Get(cqSelect);
  qryTeamCount.SQL := QueryBuilder.Get(cqTeamCount);
  qryTeamAV.SQL := QueryBuilder.Get(cqTeamAV);
  qryTeamName.SQL := QueryBuilder.Get(cqTeamName);
  qryCollegeCount.SQL := QueryBuilder.Get(cqCollegeCount);
  qryCollegeAV.SQL := QueryBuilder.Get(cqCollegeAV);
  qryCollegeName.SQL := QueryBuilder.Get(cqCollegeName);
  qryPositionCount.SQL := QueryBuilder.Get(cqPosCount);
  qryPositionAV.SQL := QueryBuilder.Get(cqPosAV);
  qryPositionName.SQL := QueryBuilder.Get(cqPosName);
end;

end.
