program Drafts;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, UMain, UDM, UBrowser, UPlayerEdit, UInstructionView,
  ureport, upaintgrid, ufillitems, uPrepareQuery, UColorConstants, UColors,
  TestIfIs64, UConfiguration, uplayercomp;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmBrowser, frmBrowser);
  Application.CreateForm(TfrmInstructionView, frmInstructionView);
  Application.CreateForm(TfrmPlayerComp, frmPlayerComp);
  Application.Run;
end.

