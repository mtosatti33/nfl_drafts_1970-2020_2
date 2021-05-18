unit UMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  Menus, ActnList, Buttons, ExtCtrls, ZDataset, LCLIntf, Grids, ComCtrls,
  LR_Class, ufillitems, uPrepareQuery, LCLType, UConfiguration, uplayercomp, uextendcomponents;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actExit: TAction;
    actClear: TAction;
    actEditPlayer: TAction;
    actCmbClear: TAction;
    actChkSetToFalse: TAction;
    actViewNCAAProfile: TAction;
    actViewNFLProfile: TAction;
    actLstClear: TAction;
    actReport: TAction;
    actSearch: TAction;
    actPreferences: TAction;
    ActionList1: TActionList;
    btnClear: TButton;
    btnCollegeClear: TSpeedButton;
    btnPositionClear: TSpeedButton;
    btnReport: TButton;
    btnRoundClear: TSpeedButton;
    btnSearch: TButton;
    btnTeamClear: TSpeedButton;
    chkAllPros: TCheckBox;
    chkFirstPicks: TCheckBox;
    chkNeverPlayed: TCheckBox;
    chkProBowlers: TCheckBox;
    cmbCollegeList: TComboBox;
    cmbHighlight: TComboBox;
    cmbPositionList: TComboBox;
    cmbRoundList: TComboBox;
    cmbSortByList: TComboBox;
    cmbSuppl: TComboBox;
    cmbTeamList: TComboBox;
    cmbYearFromList: TComboBox;
    cmbYearToList: TComboBox;
    DBGrid1: TDBGrid;
    dsTable: TDataSource;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    lstCollegeList: TListBox;
    lstPositionList: TListBox;
    lstTeamList: TListBox;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem7: TMenuItem;
    miTeam: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    miPos: TMenuItem;
    miCollege: TMenuItem;
    MenuItem9: TMenuItem;
    mnuOptions: TPopupMenu;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pgcMain: TPageControl;
    qryCollegeList: TZQuery;
    qryYearList: TZQuery;
    qryTeamList: TZQuery;
    qryPositionList: TZQuery;
    qryRoundList: TZQuery;
    SpeedButton1: TSpeedButton;
    tsMainData: TTabSheet;
    tsFilters: TTabSheet;
    procedure actChkSetToFalseExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actCmbClearExecute(Sender: TObject);
    procedure actEditPlayerExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actLstClearExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure actViewNCAAProfileExecute(Sender: TObject);
    procedure actViewNFLProfileExecute(Sender: TObject);
    procedure btnRoundClearClick(Sender: TObject);
    procedure chkAllProsChange(Sender: TObject);
    procedure chkFirstPicksChange(Sender: TObject);
    procedure chkNeverPlayedChange(Sender: TObject);
    procedure chkProBowlersChange(Sender: TObject);
    procedure cmbHighlightChange(Sender: TObject);
    procedure cmbSortByListChange(Sender: TObject);
    procedure cmbSupplChange(Sender: TObject);
    procedure cmbYearFromListChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1PrepareCanvas(Sender: TObject; DataCol: integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LoadComponents;
    procedure lstClick(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure miTeamClick(Sender: TObject);
    procedure miPosClick(Sender: TObject);
    procedure miCollegeClick(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    function ValidateSearch: boolean;
    procedure OpenLink(field_url: string);
  private
    FAsc: boolean;
  public

  end;

var
  frmMain: TfrmMain;
  FillItems: TFillItems;
  iniStrings : TIniStrings;

implementation

uses UDM, UPlayerEdit, upaintgrid, ureport;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.actLstClearExecute(Sender: TObject);
var
  i: word;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TListBox then
      if TListBox(Components[i]).Items.Count <> 0 then
        TListBox(Components[i]).Items.Clear;
  end;
end;

procedure TfrmMain.actReportExecute(Sender: TObject);
var
  filter1, filter2: string;
  i, j: word;
  chkText: string;
begin
  frmReport := TfrmReport.Create(Application);
  try
    with frmReport do
    begin
      mmoDetails.Visible := ValidateSearch;
      lblCheckboxes.Visible := ValidateSearch;

      filter1 := 'Filter: ' + #13 + #13;
      if (cmbYearFromList.ItemIndex = -1) and (cmbYearToList.ItemIndex <> -1) then
        filter1 := filter1 + 'Year: ' + cmbYearToList.Text + #13;

      if (cmbYearFromList.ItemIndex <> -1) and (cmbYearToList.ItemIndex <> -1) then
        filter1 := filter1 + 'Year: ' + cmbYearFromList.Text + ' to ' +
          cmbYearToList.Text + #13;

      if cmbRoundList.ItemIndex <> -1 then
        filter1 := filter1 + 'Round: ' + cmbRoundList.Text + #13;

      if cmbTeamList.ItemIndex <> -1 then
        filter1 := filter1 + 'Team: ' + cmbTeamList.Text + #13;

      if cmbPositionList.ItemIndex <> -1 then
        filter1 := filter1 + 'Position: ' + cmbPositionList.Text + #13;

      if cmbCollegeList.ItemIndex <> -1 then
        filter1 := filter1 + 'College: ' + cmbCollegeList.Text + #13;

      filter2 := 'Other Filters: ';
      j := 0;
      for i := 0 to self.ComponentCount - 1 do
      begin
        if self.Components[i] is TCheckBox then
          if TCheckBox(self.Components[i]).Checked then
          begin
            if self.Components[i] = chkNeverPlayed then
            begin
              chkText := chkNeverPlayed.Caption;
            end;

            if self.Components[i] = chkFirstPicks then
            begin
              chkText := chkFirstPicks.Caption;
            end;

            if self.Components[i] = chkAllPros then
            begin
              chkText := chkAllPros.Caption;
            end;

            if self.Components[i] = chkProBowlers then
            begin
              chkText := chkProBowlers.Caption;
            end;

            if j = 0 then
              filter2 := filter2 + chkText
            else
              filter2 := filter2 + ', ' + chkText;
            J := j + 1;
          end;
      end;

      mmoDetails.Lines.Text := filter1;
      lblCheckboxes.Caption := filter2;

      FrReport.Preview();
    end;
  finally
    FreeAndNil(frmReport);
  end;
end;

procedure TfrmMain.actClearExecute(Sender: TObject);
begin
  actLstClear.Execute;
  actCmbClear.Execute;
  actChkSetToFalse.Execute;

  cmbHighlight.Enabled := False;
  dm.qryPicks.Close;
  cmbYearFromList.SetFocus;
  if btnReport.Enabled then
    btnReport.Enabled := False;
end;

procedure TfrmMain.actChkSetToFalseExecute(Sender: TObject);
var
  i: word;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
      TCheckBox(Components[i]).Checked := False;
  end;
end;

procedure TfrmMain.actCmbClearExecute(Sender: TObject);
var
  i: word;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if Components[i] is TComboBox then
      TComboBox(Components[i]).ItemIndex := -1;
  end;
  cmbHighlight.ItemIndex := 0;
  cmbSuppl.ItemIndex := 0;
end;

procedure TfrmMain.actEditPlayerExecute(Sender: TObject);
begin
  if (not dm.qryPicks.Active) or (dm.qryPicks.RecordCount = 0) then
  begin
    ShowMessage('Dataset closed or no data for show');
    Exit;
  end;

  frmPlayerEdit := TfrmPlayerEdit.Create(Application);

  try
    with frmPlayerEdit do
    begin
      qryStats.ParamByName('id').AsInteger:= dm.qryPicks['ID'];
      qryStats.Open;

      ID := dm.qryPicks['ID'];
      Name := dm.qryPicks['PLAYER'];
      Position := dm.qryPicks['POS'];
      College := dm.qryPicks['COLLEGE'];
      AllPro := dm.qryPicks['AP1'];
      ProBowl := dm.qryPicks['PB'];
      Starter := dm.qryPicks['ST'];

      if not dm.qryPicks.FieldByName('G').IsNull then
        Games := dm.qryPicks['G'];

      if not dm.qryPicks.FieldByName('CarAV').IsNull then
        CarAV := dm.qryPicks['CarAV'];

      if not dm.qryPicks.FieldByName('DrAv').IsNull then
        TmAV := dm.qryPicks['DrAv'];

      if not dm.qryPicks.FieldByName('TO').IsNull then
        LastYearPlayed := dm.qryPicks['TO'];

      ShowModal;

    end;

  finally
    if frmPlayerEdit.IsSave then
      actSearch.Execute;

    frmPlayerEdit.Free;
  end;
end;

procedure TfrmMain.actSearchExecute(Sender: TObject);
var
  PrepareQuery: TPrepareQuery;
begin

  PrepareQuery := TPrepareQuery.Create(cmbYearFromList.Text,
    cmbYearToList.Text, cmbTeamList.Text, cmbPositionList.Text,
    cmbCollegeList.Text, cmbRoundList.ItemIndex, cmbSuppl.ItemIndex,
    chkFirstPicks.Checked, chkNeverPlayed.Checked, chkAllPros.Checked,
    chkProBowlers.Checked);

  // because of the cmbYearToListChange event, this line has addicted,
  // else the itemindex of the combobox doesn't works
  cmbRoundList.ItemIndex := cmbRoundList.items.IndexOf(trim(cmbRoundList.Text));

  if not cmbHighlight.Enabled then
    cmbHighlight.Enabled := True;

  actLstClear.Execute;

  if not ValidateSearch then
  begin
    ShowMessage('Initial and/or Final date won´t be blank');
    cmbYearFromList.SetFocus;
    Exit;
  end;

  if cmbYearFromList.ItemIndex <> -1 then
  begin
    if cmbYearToList.ItemIndex = -1 then
    begin
      ShowMessage('Final year can`t be empty');
      Exit;
    end;

    if StrToInt(cmbYearFromList.Text) > StrToInt(cmbYearToList.Text) then
    begin
      ShowMessage('Inicial year can`t be greater than final year');
      Exit;
    end;
  end;

  PrepareQuery.Load;

  if not cmbSortByList.ItemIndex = 0 then
    cmbSortByList.ItemIndex := 0;

  cmbSortByListChange(nil);
  pgcMain.ActivePage := tsMainData;
  btnReport.Enabled := (dsTable.DataSet.RecordCount <> 0) or (dsTable.DataSet.Active);
end;

procedure TfrmMain.actViewNCAAProfileExecute(Sender: TObject);
begin
  OpenLink('PLAYER_NCAA_LINK');
end;

procedure TfrmMain.actViewNFLProfileExecute(Sender: TObject);
begin
  OpenLink('PLAYER_NFL_LINK');
end;

procedure TfrmMain.btnRoundClearClick(Sender: TObject);
var
  btn: TSpeedButton;
  ComboBox: TComboBox;
begin
  btn := Sender as TSpeedButton;
  ComboBox := nil;
  if btn = btnRoundClear then
    ComboBox := cmbRoundList;
  if btn = btnTeamClear then
    ComboBox := cmbTeamList;
  if btn = btnPositionClear then
    ComboBox := cmbPositionList;
  if btn = btnCollegeClear then
    ComboBox := cmbCollegeList;

  ComboBox.ItemIndex := -1;

  //actSearch.Execute;
end;

procedure TfrmMain.chkAllProsChange(Sender: TObject);
begin
  chkNeverPlayed.Enabled := not chkAllPros.Checked;
end;

procedure TfrmMain.chkFirstPicksChange(Sender: TObject);
begin
  if chkFirstPicks.Checked then
  begin
    cmbRoundList.ItemIndex := -1;
    cmbSuppl.ItemIndex := 1;
  end;

  cmbRoundList.Enabled := not chkFirstPicks.Checked;
  cmbSuppl.Enabled := not chkFirstPicks.Checked;
end;

procedure TfrmMain.chkNeverPlayedChange(Sender: TObject);
begin
  chkProBowlers.Enabled := not chkNeverPlayed.Checked;
  chkAllPros.Enabled := not chkNeverPlayed.Checked;
end;

procedure TfrmMain.chkProBowlersChange(Sender: TObject);
begin
  chkNeverPlayed.Enabled := not chkProBowlers.Checked;
end;

procedure TfrmMain.cmbHighlightChange(Sender: TObject);
begin
  DBGrid1.OnPrepareCanvas := @DBGrid1PrepareCanvas;
  actSearch.Execute;
end;

procedure TfrmMain.cmbSortByListChange(Sender: TObject);
begin
  actLstClear.Execute;

  with dm do
  begin
    with FillItems do
    begin
      case cmbSortByList.ItemIndex of
        //Name
        0:
        begin
          lstTeamList.Items := Fill(qryTeamName, ['count', 'tm']);
          lstCollegeList.Items := Fill(qryCollegeName, ['count', 'college']);
          lstPositionList.Items := Fill(qryPositionName, ['count', 'pos']);
        end;
        //Draft Picks
        1:
        begin
          lstTeamList.Items := Fill(qryTeamCount, ['count', 'tm']);
          lstCollegeList.Items := Fill(qryCollegeCount, ['count', 'college']);
          lstPositionList.Items := Fill(qryPositionCount, ['count', 'pos']);
        end;
        //Team AV
        2:
        begin
          lstTeamList.Items := Fill(qryTeamAV, ['sum', 'tm']);
          lstCollegeList.Items := Fill(qryCollegeAV, ['sum', 'college']);
          lstPositionList.Items := Fill(qryPositionAV, ['sum', 'pos']);
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.cmbSupplChange(Sender: TObject);
begin
  chkFirstPicks.Enabled := cmbSuppl.ItemIndex <> 2;
end;

procedure TfrmMain.cmbYearFromListChange(Sender: TObject);
begin
  if cmbYearFromList.Text <> '' then
    cmbYearToList.Text := cmbYearFromList.Text;

  if cmbRoundList.Items.Count <> 0 then
    cmbRoundList.Items.Clear;

  if cmbTeamList.Items.Count <> 0 then
    cmbTeamList.Items.Clear;

  qryRoundList.Close;
  qryRoundList.ParamByName('yr_from').AsString := cmbYearFromList.Text;
  qryRoundList.ParamByName('yr_to').AsString := cmbYearToList.Text;
  qryRoundList.Open;

  qryTeamList.Close;
  qryTeamList.ParamByName('yr_from').AsString := cmbYearFromList.Text;
  qryTeamList.ParamByName('yr_to').AsString := cmbYearToList.Text;
  qryTeamList.Open;

  cmbRoundList.Items := FillItems.Fill(qryRoundList, ['RND']);
  cmbTeamList.Items := FillItems.Fill(qryTeamList, ['Tm']);
end;

procedure TfrmMain.DBGrid1DblClick(Sender: TObject);
begin
  actViewNFLProfile.Execute;
end;

procedure TfrmMain.DBGrid1PrepareCanvas(Sender: TObject; DataCol: integer;
  Column: TColumn; AState: TGridDrawState);
var
  PaintGrid: TPaintGrid;
begin
  PaintGrid := TPaintGrid.Create(DBGrid1, dm.qryPicks, DataCol);
  try
    PaintGrid.Paint(cmbHighlight.ItemIndex);
  finally
    FreeAndNil(PaintGrid);
  end;
end;

procedure TfrmMain.DBGrid1TitleClick(Column: TColumn);
begin
  //turns true if false, and vice-versa
  FAsc := not FAsc;
  if FAsc then
    dm.qryPicks.IndexFieldNames := Column.FieldName
  else
    dm.qryPicks.IndexFieldNames := Column.FieldName + ' DESC';

  dm.qryPicks.First;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  LoadComponents;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  i: integer;
begin
    iniStrings := ReadIniFile;
    pgcMain.ActivePage := tsFilters;

    cmbYearFromList.Text:=iniStrings.year;
    cmbYearToList.Text:=iniStrings.year;

    cmbYearFromListChange(nil);

    {$IfDef LINUX}
    for i := 0 to self.ComponentCount - 1 do
    begin
      if self.Components[i] is TLabel then
         TLabel(self.Components[i]).Font.Color:=clWhite; 
      if self.Components[i] is TCheckBox then
         TCheckBox(self.Components[i]).Font.Color:=clWhite;


      if self.Components[i] = Panel2 then
         Panel2.Color:=$0076521A;
    end;
    {$endif}
end;

procedure TfrmMain.LoadComponents;
begin
  FillItems := TFillItems.Create;
  FAsc := False;
  panel1.MoveMousePanel:=true;
  panel2.MoveMousePanel:=false;

  if not qryYearList.active then
    qryYearList.active := True;
  if not qryPositionList.active then
    qryPositionList.active := True;
  if not qryCollegeList.Active then
    qryCollegeList.Active := True;
  if not qryRoundList.Active then
    qryRoundList.Active := True;

  with FillItems do
  begin
    cmbYearFromList.Items := Fill(qryYearList, ['Draft_yr']);
    cmbYearToList.Items := Fill(qryYearList, ['Draft_yr']);
    cmbPositionList.Items := Fill(qryPositionList, ['Pos']);
    cmbCollegeList.Items := Fill(qryCollegeList, ['College']);
  end;
end;

procedure TfrmMain.lstClick(Sender: TObject);
var
  str: string;
  ListBox: TListBox;
  ComboBox: TComboBox;
begin
  ListBox := Sender as TListBox;
  ComboBox := nil;

  if ListBox.Items.Count <> 0 then
    if ListBox.ItemIndex <> -1 then
    begin
      str := ListBox.Items[ListBox.ItemIndex];

      if ListBox = lstTeamList then
        ComboBox := cmbTeamList;
      if ListBox = lstPositionList then
        ComboBox := cmbPositionList;
      if ListBox = lstCollegeList then
        ComboBox := cmbCollegeList;

      ComboBox.ItemIndex := ComboBox.Items.IndexOf(trim(Copy(str, Pos(' ', str), 25)));

      actSearch.Execute;
      pgcMain.ActivePage := tsMainData;
    end;
end;

procedure TfrmMain.MenuItem7Click(Sender: TObject);
begin
  if cmbTeamList.Text <> '' then
     cmbTeamList.ItemIndex:=-1;
  if cmbPositionList.Text <> '' then
     cmbPositionList.ItemIndex:=-1;
  if cmbCollegeList.Text <> '' then
     cmbCollegeList.ItemIndex:=-1;

  actSearch.Execute;
end;

procedure TfrmMain.miTeamClick(Sender: TObject);
begin
  if dm.qryPicks.RecordCount <> 0 then
  begin
    cmbTeamList.Text:= dm.qryPicks['tm'];
    actSearch.Execute;
  end;
end;

procedure TfrmMain.miPosClick(Sender: TObject);
begin
  if dm.qryPicks.RecordCount <> 0 then
  begin
    cmbPositionList.Text:=dm.qryPicks['pos'];
    actSearch.Execute;
  end;
end;

procedure TfrmMain.miCollegeClick(Sender: TObject);
begin
  if dm.qryPicks.RecordCount <> 0 then
  begin
    cmbCollegeList.Text:=dm.qryPicks['college'];
    actSearch.Execute;
  end;
end;

procedure TfrmMain.MenuItem9Click(Sender: TObject);
begin
  //TODO: make comparision from players in the same position
  //ShowMessage('Comming Soon');

  frmPlayerComp := TfrmPlayerComp.Create(Application);

  try
    with frmPlayerComp do
    begin
      DateInitial:=cmbYearFromList.Text;
      DateFinal:=cmbYearToList.Text;
      Position:=dm.qryPicks['pos'];
    end;
    frmPlayerComp.ShowModal;
  finally
    FreeAndNil(frmPlayerComp);
  end;
end;

function TfrmMain.ValidateSearch: boolean;
begin
  Result := True;
  if (cmbYearFromList.ItemIndex = -1) and (cmbYearToList.ItemIndex = -1) and
    (cmbRoundList.ItemIndex = -1) and (cmbTeamList.ItemIndex = -1) and
    (cmbPositionList.ItemIndex = -1) and (cmbCollegeList.ItemIndex = -1) and
    not (chkNeverPlayed.Checked) and not (chkFirstPicks.Checked) and
    not (chkProBowlers.Checked) and not (chkAllPros.Checked) then
    Result := False;
end;

procedure TfrmMain.OpenLink(field_url: string);
begin
  if dm.qryPicks.Active then
    if dm.qryPicks.RecordCount <> 0 then
      if not dm.qryPicks.FieldByName(field_url).IsNull then
        OpenURL(dm.qryPicks.FieldByName(field_url).AsString);
end;

end.
