unit UDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, Dialogs, UConfiguration;

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
begin
  iniStrings := ReadIniFile;

  {$IfDef MSWINDOWS}
  conn.Database := iniStrings.database;
  {$EndIf}

  //Linux works with "/" directories instead "\" on windows.
  //The app should see the database drafts.db
  {$IFDEF LINUX}
  conn.Database := iniStrings.databaseLinux;
  {$EndIf}

  {$IfDef WIN32}
  conn.LibraryLocation := iniStrings.library32;
  {$EndIf}

  {$IfDef WIN64}
  conn.LibraryLocation := iniStrings.library64;
  {$EndIf}
  conn.Protocol := iniStrings.protocol;

  try
    conn.Connected := True;
  except
    on E: Exception do
      ShowMessage('A error ocurred: ' + E.Message);
  end;
end;

end.
