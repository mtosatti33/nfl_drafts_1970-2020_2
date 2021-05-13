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
    lib: string;
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
    iniStrings.database := ini.ReadString(DB_CONFIG, 'database', '');
    iniStrings.lib := ini.ReadString(DB_CONFIG, 'library', '');
    iniStrings.protocol := ini.ReadString(DB_CONFIG, 'protocol', '');
    iniStrings.year := ini.ReadString(GENERAL_CONFIG, 'year', '');
  finally
    ini.Free;
  end;

  Result := iniStrings;
end;

end.

