unit UConfiguration;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

const
  DB_CONFIG = 'database_config';
  GENERAL_CONFIG = 'general_config';
  INI_FILE = 'drafts.ini';


type
  TIniStrings = record
    database: string;
    databaseLinux: string;
    library32: string;
    library64: string;
    protocol: string;
    year: string;
  end;

function ReadIniFile: TIniStrings;

var
  ini: TIniFile;

implementation

function ReadIniFile: TIniStrings;
var
  iniStrings: TIniStrings;
begin
  ini := TIniFile.Create(INI_FILE);
  try
    {$IfDef MSWINDOWS}
    iniStrings.database := ini.ReadString(DB_CONFIG, 'database', '');
    {$EndIf}
    //Linux works with "/" directories instead "\" on windows.
    //The app should see the database drafts.db
    {$IfDef LINUX}
    iniStrings.databaseLinux := ini.ReadString(DB_CONFIG, 'databaseLinux', '');
    {$EndIf}

    {$IfDef WIN32}
    iniStrings.library32 := ini.ReadString(DB_CONFIG, 'library32', '');
    {$EndIf}

    {$IfDef WIN64}
    iniStrings.library64 := ini.ReadString(DB_CONFIG, 'library64', '');
    {$EndIf}

    iniStrings.protocol := ini.ReadString(DB_CONFIG, 'protocol', '');
    iniStrings.year := ini.ReadString(GENERAL_CONFIG, 'year', '');
  finally
    ini.Free;
  end;

  Result := iniStrings;
end;

end.

