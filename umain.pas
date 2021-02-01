unit UMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  Menus, ActnList, Buttons, ExtCtrls, ZDataset, LCLIntf, Grids, ComCtrls,
  LR_Class, ufillitems, uPrepareQuery, LCLType;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actExit: TAction;
    actClear: TAction;
    actEditPlayer: TAction;
    actCmbClear: TAction;
    actChkSetToFalse: TAction;
    actLstClear: TAction;
    actReport: TAction;
    actSearch: TAction;
    actPreferences: TAction;
    ActionList1: TActionList;
    btnReport: TButton;
    btnSearch: TButton;
    btnTeamClear: TSpeedButton;
    btnPositionClear: TSpeedButton;
    btnCollegeClear: TSpeedButton;
    btnClear: TButton;
    chkProBowlers: TCheckBox;
    chkAllPros: TCheckBox;
    chkFirstPicks: TCheckBox;
    chkNeverPlayed: TCheckBox;
    cmbCollegeList: TComboBox;
    cmbSuppl: TComboBox;
    cmbHighlight: TComboBox;
    cmbRoundList: TComboBox;
    cmbSortByList: TComboBox;
    cmbYearToList: TComboBox;
    cmbTeamList: TComboBox;
    cmbPositionList: TComboBox;
    cmbYearFromList: TComboBox;
    dsTable: TDataSource;
    DBGrid1: TDBGrid;
    Label11: TLabel;
    Label13: TLabel;
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
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    N1: TMenuItem;
    mnuOptions: TPopupMenu;
    qryCollegeList: TZQuery;
    qryYearList: TZQuery;
    qryTeamList: TZQuery;
    qryPositionList: TZQuery;
    qryRoundList: TZQuery;
    btnRoundClear: TSpeedButton;
    procedure actChkSetToFalseExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actCmbClearExecute(Sender: TObject);
    procedure actEditPlayerExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actLstClearExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure btnRoundClearClick(Sender: TObject);
    procedure chkChange(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure cmbSortByListChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1PrepareCanvas(Sender: TObject; DataCol: integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure LoadComponents;
    procedure lstClick(Sender: TObject);
    function ValidateSearch: boolean;
  private
    FAsc: boolean;
  public

  end;

var
  frmMain: TfrmMain;
  FillItems: TFillItems;

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
            if j = 0 then
              filter2 := filter2 + TCheckBox(self.Components[i]).Caption
            else
              filter2 := filter2 + ', ' + TCheckBox(self.Components[i]).Caption;
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

  cmbRoundList.Enabled := False;
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
    frmPlayerEdit.ID := dm.qryPicks['ID'];
    frmPlayerEdit.Name := dm.qryPicks['PLAYER'];
    frmPlayerEdit.Position := dm.qryPicks['POS'];
    frmPlayerEdit.College := dm.qryPicks['COLLEGE'];
    frmPlayerEdit.AllPro := dm.qryPicks['AP1'];
    frmPlayerEdit.ProBowl := dm.qryPicks['PB'];
    frmPlayerEdit.Starter := dm.qryPicks['ST'];

    if not dm.qryPicks.FieldByName('G').IsNull then
      frmPlayerEdit.Games := dm.qryPicks['G'];

    if not dm.qryPicks.FieldByName('CarAV').IsNull then
      frmPlayerEdit.CarAV := dm.qryPicks['CarAV'];

    if not dm.qryPicks.FieldByName('DrAv').IsNull then
      frmPlayerEdit.TmAV := dm.qryPicks['DrAv'];

    if not dm.qryPicks.FieldByName('TO').IsNull then
      frmPlayerEdit.LastYearPlayed := dm.qryPicks['TO'];

    frmPlayerEdit.ShowModal;

  finally
    if frmPlayerEdit.IsSave then
      actSearch.Execute;

    frmPlayerEdit.Free;
  end;
end;

procedure TfrmMain.actSearchExecute(Sender: TObject);
var
  PrepareQuery: TPrepareQuery;
  i: integer;
  qry: TZQuery;
begin

  //TODO: implement the parameter`s cconstructor
  //PrepareQuery:= TPrepareQuery.Create();

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

  with dm do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TZQuery then
      begin
        qry := Components[i] as TZQuery;

        qry.Close;

        if cmbYearFromList.Text <> '' then
          qry.ParamByName('yr_from').AsString := cmbYearFromList.Text
        else
          qry.ParamByName('yr_from').AsInteger := -1;

        qry.ParamByName('yr_to').AsString := cmbYearToList.Text;
        qry.ParamByName('team_id').AsString := cmbTeamList.Text;
        qry.ParamByName('rnd').AsInteger := cmbRoundList.ItemIndex + 1;
        qry.ParamByName('position').AsString := cmbPositionList.Text;
        qry.ParamByName('college').AsString := cmbCollegeList.Text;
        qry.ParamByName('is_suppl').AsInteger := cmbSuppl.ItemIndex - 1;
        qry.ParamByName('first_pick').AsInteger := integer(chkFirstPicks.Checked);
        qry.ParamByName('never_played').AsInteger := integer(chkNeverPlayed.Checked);
        qry.ParamByName('all_pro').AsInteger := integer(chkAllPros.Checked);
        qry.ParamByName('pro_bowl').AsInteger := integer(chkProBowlers.Checked);
        qry.Open;

        qry.First;

      end;

    end;
  end;
  if not cmbSortByList.ItemIndex = 0 then
    cmbSortByList.ItemIndex := 0;

  cmbSortByListChange(nil);
  btnReport.Enabled := (dsTable.DataSet.RecordCount <> 0) or (dsTable.DataSet.Active);
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

  actSearch.Execute;
end;

procedure TfrmMain.chkChange(Sender: TObject);
begin
  //chkNeverPlayed
  if Sender = chkNeverPlayed then
  begin

    chkProBowlers.Enabled := not chkNeverPlayed.Checked;
    chkAllPros.Enabled := not chkNeverPlayed.Checked;
  end;

  //chkFirstPicks
  if Sender = chkFirstPicks then
  begin
    if chkFirstPicks.Checked then
    begin
      cmbRoundList.ItemIndex := -1;
      cmbSuppl.ItemIndex := 1;
    end;

    cmbRoundList.Enabled := not chkFirstPicks.Checked;
    cmbSuppl.Enabled := not chkFirstPicks.Checked;
  end;

  //chkProBowlers
  if Sender = chkProBowlers then
  begin
    chkNeverPlayed.Enabled := not chkProBowlers.Checked;
  end;

  //chkAllPro
  if Sender = chkAllPros then
  begin
    chkNeverPlayed.Enabled := not chkAllPros.Checked;
  end;
end;

procedure TfrmMain.cmbChange(Sender: TObject);
begin
  if not cmbSuppl.Enabled then
    cmbSuppl.Enabled := True;
  if not chkFirstPicks.Enabled then
    chkFirstPicks.Enabled := True;
  if not chkNeverPlayed.Enabled then
    chkNeverPlayed.Enabled := True;

  //cmbYearFromList event
  if Sender = cmbYearFromList then
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

  //cmbYearToList event
  if Sender = cmbYearToList then
  begin

  end;

  //cmbRoundList event
  if Sender = cmbRoundList then
  begin

  end;

  //cmbTeamList event
  if Sender = cmbTeamList then
  begin

  end;

  //cmbPositionList event
  if Sender = cmbPositionList then
  begin

  end;

  //cmbCollegeList event
  if Sender = cmbCollegeList then
  begin

  end;

  //cmbSuppl event
  if Sender = cmbSuppl then
  begin
    chkFirstPicks.Enabled := cmbSuppl.ItemIndex <> 2;
  end;

  //cmbHighlight event
  if Sender = cmbHighlight then
  begin
    DBGrid1.OnPrepareCanvas := @DBGrid1PrepareCanvas;
    actSearch.Execute;
  end;
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

procedure TfrmMain.DBGrid1DblClick(Sender: TObject);
var
  str: string;
begin
  if dm.qryPicks.Active then
    if dm.qryPicks.RecordCount <> 0 then
      if not dm.qryPicks.FieldByName('PLAYER_NFL_LINK').IsNull then
      begin
        //ShowMessage(BoolToStr(dm.qryPicks.FieldByName('PFR_SITE').IsNull));
        str := dm.qryPicks.FieldByName('PLAYER_NFL_LINK').AsString;
        OpenURL('https://www.pro-football-reference.com' + str);
      end;
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

procedure TfrmMain.LoadComponents;
begin
  FillItems := TFillItems.Create;
  FAsc := False;

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

end.
