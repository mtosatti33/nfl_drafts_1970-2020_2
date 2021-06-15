program Drafts;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, UMain, UDM, UBrowser, UPlayerEdit, UInstructionView,
  ureport, upaintgrid, ufillitems, uPrepareQuery, UColorConstants, UColors,
  TestIfIs64, UConfiguration, uplayercomp, uextendcomponents, UDatasetConstants,
  UroundDialog, uYearDialog, uquerybuilder, uquerybuilderconstants;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmBrowser, frmBrowser);
  Application.CreateForm(TfrmInstructionView, frmInstructionView);
  Application.CreateForm(TfrmYearDialog, frmYearDialog);
  Application.Run;
end.

