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

  qryPicks.SQL := QueryBuilder.GetSQL(cqSelect);
  qryTeamCount.SQL := QueryBuilder.GetSQL(cqTeamCount);
  qryTeamAV.SQL := QueryBuilder.GetSQL(cqTeamAV);
  qryTeamName.SQL := QueryBuilder.GetSQL(cqTeamName);
  qryCollegeCount.SQL := QueryBuilder.GetSQL(cqCollegeCount);
  qryCollegeAV.SQL := QueryBuilder.GetSQL(cqCollegeAV);
  qryCollegeName.SQL := QueryBuilder.GetSQL(cqCollegeName);
  qryPositionCount.SQL := QueryBuilder.GetSQL(cqPosCount);
  qryPositionAV.SQL := QueryBuilder.GetSQL(cqPosAV);
  qryPositionName.SQL := QueryBuilder.GetSQL(cqPosName);
end;

end.
