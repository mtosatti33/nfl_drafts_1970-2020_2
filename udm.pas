unit UDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, IniFiles, Dialogs;

const
  MAIN = 'main';
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
   libraryLoc: string;
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
  conn.LibraryLocation:=iniStrings.libraryLoc;
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
     iniStrings.database:=ini.ReadString(MAIN,'database','');
     iniStrings.libraryLoc:=ini.ReadString(MAIN,'library','');
     iniStrings.protocol:=ini.ReadString(MAIN,'protocol','');
   finally
     ini.Free;
   end;
end;

end.

