unit UDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, IniFiles, Dialogs;

const
  DB_CONFIG = 'database_config';
  INI_FILE = 'Drafts.ini';

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
    procedure ReadIniFile;
  public

  end;

  TIniStrings = record
   database: string;
   library32: string;
   library64: string;
   protocol: string;
  end;

var
  dm: Tdm;
  ini : TIniFile;
  iniStrings: TIniStrings;
implementation

{$R *.lfm}


{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ReadIniFile;

  conn.Database:=iniStrings.database;
  {$IfDef WIN32}
         conn.LibraryLocation:=iniStrings.library32;
  {$ELSE}
         conn.LibraryLocation:=iniStrings.library64;
  {$EndIf}
  conn.Protocol:=iniStrings.protocol;

  try
    conn.Connected:=true;
  except on E: Exception do
    ShowMessage('A error ocurred: '+ E.Message);
  end;
end;

procedure Tdm.ReadIniFile;
begin
   ini := TIniFile.Create(INI_FILE);
   try
     iniStrings.database:=ini.ReadString(DB_CONFIG,'database','');
     iniStrings.library32:=ini.ReadString(DB_CONFIG,'library32','');
     iniStrings.library64:=ini.ReadString(DB_CONFIG,'library64','');
     iniStrings.protocol:=ini.ReadString(DB_CONFIG,'protocol','');
   finally
     ini.Free;
   end;
end;

end.

