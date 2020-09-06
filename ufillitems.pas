unit ufillitems;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, Controls, StdCtrls;

type

  { TFillItems }

  TFillItems = class
	public
      function Fill(qry: TZQuery; fields: array of string): TStringList; overload;
  end;

implementation

{ TFillItems }

function TFillItems.Fill(qry: TZQuery; fields: array of string): TStringList;
var
  field: string;
  i: byte;
  list: TStringList;
begin
  list := TStringList.Create;

  qry.First;
  while not qry.EOF do
  begin
	for i:=0 to Length(fields) - 1 do
    begin
     if i = 0 then
     	field := qry.FieldByName(fields[i]).AsString else
        field := field + ' ' + qry.FieldByName(fields[i]).AsString ;
    end;
   list.Add(field);
   qry.Next;
  end;

  Result := list;
end;

end.

