unit View.Frame.Servicos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ListBox;

type
  TFrameServicos = class(TFrame)
    rectFundoServicos: TRectangle;
    lytHeaderWeb: TLayout;
    lblTituloServicos: TLabel;
    lytTituloServicos: TLayout;
    lblSubTituloServicos: TLabel;
    lytAcoesDireita: TLayout;
    rectBtnNovoServico: TRectangle;
    lblBtnNovoServico: TLabel;
    circleSinoServicos: TCircle;
    rectBuscaServicos: TRectangle;
    edtBuscaServicos: TEdit;
    gridKpiServicos: TGridPanelLayout;
    lytContainerKpi1: TLayout;
    rectKpi1: TRectangle;
    lytTopKpi1: TLayout;
    rectIconeKpi1: TRectangle;
    lblTitKpi1: TLabel;
    lblValKpi1: TLabel;
    lblSubKpi1: TLabel;
    lytContainerKpi2: TLayout;
    rectKpi2: TRectangle;
    lytTopKpi2: TLayout;
    rectIconeKpi2: TRectangle;
    lblTitKpi2: TLabel;
    lblValKpi2: TLabel;
    lblSubKpi2: TLabel;
    lytContainerKpi3: TLayout;
    rectKpi3: TRectangle;
    lytTopKpi3: TLayout;
    rectIconeKpi3: TRectangle;
    lblTitKpi3: TLabel;
    lblValKpi3: TLabel;
    lblSubKpi3: TLabel;
    lytContainerKpi4: TLayout;
    rectKpi4: TRectangle;
    lytTopKpi4: TLayout;
    rectIconeKpi4: TRectangle;
    lblTitKpi4: TLabel;
    lblValKpi4: TLabel;
    lblSubKpi4: TLabel;
    lytFiltrosContainer: TLayout;
    scrollFiltrosCategorias: THorzScrollBox;
    rectFiltroTodos: TRectangle;
    lblFiltroTodos: TLabel;
    rectFiltroEstetica: TRectangle;
    lblFiltroEstetica: TLabel;
    rectFiltroBarba: TRectangle;
    lblFiltroBarba: TLabel;
    rectFiltroCabelo: TRectangle;
    lblFiltroCabelo: TLabel;
    rectToggleStatus: TRectangle;
    gridToggle: TGridPanelLayout;
    rectToggleTodos: TRectangle;
    lblToggleTodos: TLabel;
    rectToggleAtivos: TRectangle;
    lblToggleAtivos: TLabel;
    rectToggleInativos: TRectangle;
    lblToggleInativos: TLabel;
    lblResultadosTotal: TLabel;
    lytHeaderTabela: TLayout;
    Rectangle1: TRectangle;
    lblColServico: TLabel;
    lblColCategoria: TLabel;
    lblColPreco: TLabel;
    lblColDuracao: TLabel;
    lblColAgendamentos: TLabel;
    lblColAcoes: TLabel;
    scrollListaServicos: TVertScrollBox;
    lytRodapeResumo: TLayout;
    rectLinhaRodape: TRectangle;
    lblContadorRodape: TLabel;
    lytValoresRodape: TLayout;
    lblTextoReceita: TLabel;
    lblValorReceitaTotal: TLabel;
    imgIconeBuscaServ: TImage;
    imgIconeNotificacaoServ: TImage;
    imgIconeNovoServ: TImage;
    imgIconeKpi1: TImage;
    imgIconeKpi2: TImage;
    imgIconeKpi3: TImage;
    imgIconeKpi4: TImage;
    procedure FiltroTodosClick(Sender: TObject);
    procedure FiltroCabeloClick(Sender: TObject);
    procedure FiltroBarbaClick(Sender: TObject);
    procedure FiltroEsteticaClick(Sender: TObject);
    procedure ToggleTodosClick(Sender: TObject);
    procedure ToggleAtivosClick(Sender: TObject);
    procedure ToggleInativosClick(Sender: TObject);
    procedure BuscaServicoChange(Sender: TObject);
    procedure EditarServicoClick(Sender: TObject);
    procedure EliminarServicoClick(Sender: TObject);
  private
    FFiltroCategoria: string;
    FFiltroStatus: string;
    FBusca: string;
    FEditServicoID: Integer;
    FOverlayEdicao: TRectangle;
    FEdtNome: TEdit;
    FEdtDescricao: TEdit;
    FEdtPreco: TEdit;
    FEdtDuracao: TEdit;
    FEdtBadge: TEdit;
    FCboCategoria: TComboBox;
    procedure CarregarServicos;
    procedure AtualizarKPIs;
    procedure AtualizarFiltros(FiltroAtivo: TRectangle);
    procedure AtualizarToggle(Ativo: Integer);
    function GetIDFromRow(Row: TFMXObject): Integer;
    procedure CriarModalEdicao;
    procedure AbrirModalEdicao(AID: Integer);
    procedure FecharModalEdicaoClick(Sender: TObject);
    procedure SalvarEdicaoClick(Sender: TObject);
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  System.StrUtils, FMX.DialogService;

{$R *.fmx}

procedure TFrameServicos.AfterConstruction;
begin
  inherited;
  FFiltroCategoria := '';
  FFiltroStatus := '';
  FBusca := '';
  AtualizarKPIs;
  CarregarServicos;
end;

procedure TFrameServicos.AtualizarKPIs;
var
  Query: TFDQuery;
  Total, Ativos, Inativos: Integer;
  Receita: Double;
begin
  Total := 0;
  Ativos := 0;
  Inativos := 0;
  Receita := 0;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT COUNT(*) AS TOTAL,' +
      ' SUM(CASE WHEN ATIVO=1 THEN 1 ELSE 0 END) AS ATIVOS,' +
      ' SUM(CASE WHEN ATIVO=0 THEN 1 ELSE 0 END) AS INATIVOS' +
      ' FROM TB_SERVICOS';
    Query.Open;
    Total   := Query.FieldByName('TOTAL').AsInteger;
    Ativos  := Query.FieldByName('ATIVOS').AsInteger;
    Inativos := Query.FieldByName('INATIVOS').AsInteger;
  finally
    Query.Free;
  end;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT SUM(VALOR_COBRADO) AS RECEITA' +
      ' FROM TB_AGENDAMENTOS WHERE STATUS = ''CONCLUIDO''';
    Query.Open;
    if not Query.FieldByName('RECEITA').IsNull then
      Receita := Query.FieldByName('RECEITA').AsFloat;
  finally
    Query.Free;
  end;

  lblTitKpi1.StyledSettings := [];
  lblTitKpi1.TextSettings.FontColor := $FF94A3B8;
  lblTitKpi1.Text := 'Total de Servi'#231'os';
  lblValKpi1.StyledSettings := [];
  lblValKpi1.TextSettings.FontColor := $FFFFFFFF;
  lblValKpi1.Text := IntToStr(Total);
  lblSubKpi1.StyledSettings := [];
  lblSubKpi1.TextSettings.FontColor := $FF64748B;
  lblSubKpi1.Text := 'no cat'#225'logo';

  lblTitKpi2.StyledSettings := [];
  lblTitKpi2.TextSettings.FontColor := $FF94A3B8;
  lblTitKpi2.Text := 'Ativos';
  lblValKpi2.StyledSettings := [];
  lblValKpi2.TextSettings.FontColor := $FF05C871;
  lblValKpi2.Text := IntToStr(Ativos);
  lblSubKpi2.StyledSettings := [];
  lblSubKpi2.TextSettings.FontColor := $FF64748B;
  lblSubKpi2.Text := 'dispon'#237'veis';

  lblTitKpi3.StyledSettings := [];
  lblTitKpi3.TextSettings.FontColor := $FF94A3B8;
  lblTitKpi3.Text := 'Inativos';
  lblValKpi3.StyledSettings := [];
  lblValKpi3.TextSettings.FontColor := $FFEF4444;
  lblValKpi3.Text := IntToStr(Inativos);
  lblSubKpi3.StyledSettings := [];
  lblSubKpi3.TextSettings.FontColor := $FF64748B;
  lblSubKpi3.Text := 'desativados';

  lblTitKpi4.StyledSettings := [];
  lblTitKpi4.TextSettings.FontColor := $FF94A3B8;
  lblTitKpi4.Text := 'Receita Total';
  lblValKpi4.StyledSettings := [];
  lblValKpi4.TextSettings.FontColor := $FFF58A00;
  lblValKpi4.Text := Format('R$ %.2f', [Receita]);
  lblSubKpi4.StyledSettings := [];
  lblSubKpi4.TextSettings.FontColor := $FF64748B;
  lblSubKpi4.Text := 'em servi'#231'os';

  lblSubTituloServicos.StyledSettings := [];
  lblSubTituloServicos.TextSettings.FontColor := $FF94A3B8;
  lblSubTituloServicos.Text :=
    IntToStr(Ativos) + ' Ativos '#183' ' +
    IntToStr(Inativos) + ' Inativos '#183' ' +
    IntToStr(Total) + ' No Total';
end;

procedure TFrameServicos.CarregarServicos;
var
  Query: TFDQuery;
  SQL: string;
  Row: TRectangle;
  RectIcone, RectCat, RectToggle: TRectangle;
  LblNome, LblDesc, LblCat, LblPreco, LblDur: TLabel;
  LblAgend, LblReceita, LblToggle, LblEdit, LblDel, LblID: TLabel;
  I, Count: Integer;
  IsAtivo: Boolean;
  CorFundo: TAlphaColor;
  ReceitaServ, TotalReceita: Double;
begin
  for I := scrollListaServicos.Content.ChildrenCount - 1 downto 0 do
    if scrollListaServicos.Content.Children[I].Tag = 82 then
      scrollListaServicos.Content.Children[I].Free;

  SQL :=
    'SELECT S.ID, S.NOME, S.DESCRICAO, S.PRECO, S.DURACAO_MIN, S.ATIVO,' +
    ' C.NOME AS CATEGORIA,' +
    ' (SELECT COUNT(*) FROM TB_AGENDAMENTOS A' +
    '  WHERE A.SERVICO_ID = S.ID) AS TOTAL_AGEND,' +
    ' (SELECT SUM(A.VALOR_COBRADO) FROM TB_AGENDAMENTOS A' +
    '  WHERE A.SERVICO_ID = S.ID AND A.STATUS = ''CONCLUIDO'') AS RECEITA' +
    ' FROM TB_SERVICOS S' +
    ' JOIN TB_CATEGORIAS C ON C.ID = S.CATEGORIA_ID' +
    ' WHERE 1=1';

  if FFiltroCategoria <> '' then
    SQL := SQL + ' AND UPPER(C.NOME) CONTAINING UPPER(:CAT)';
  if FFiltroStatus = 'ATIVO' then
    SQL := SQL + ' AND S.ATIVO = 1'
  else if FFiltroStatus = 'INATIVO' then
    SQL := SQL + ' AND S.ATIVO = 0';
  if FBusca <> '' then
    SQL := SQL +
      ' AND (UPPER(S.NOME) CONTAINING UPPER(:BUSCA)' +
      ' OR UPPER(S.DESCRICAO) CONTAINING UPPER(:BUSCA))';
  SQL := SQL + ' ORDER BY C.NOME, S.NOME';

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text := SQL;
    if FFiltroCategoria <> '' then
      Query.ParamByName('CAT').AsString := FFiltroCategoria;
    if FBusca <> '' then
      Query.ParamByName('BUSCA').AsString := FBusca;
    Query.Open;

    Count := 0;
    TotalReceita := 0;

    while not Query.EOF do
    begin
      IsAtivo := Query.FieldByName('ATIVO').AsInteger = 1;

      if Count mod 2 = 0 then
        CorFundo := $FF1E293B
      else
        CorFundo := $FF141C2B;

      Row := TRectangle.Create(scrollListaServicos);
      Row.Parent := scrollListaServicos;
      Row.Tag := 82;
      Row.Align := TAlignLayout.Top;
      Row.Height := 70;
      Row.Margins.Bottom := 4;
      Row.Fill.Color := CorFundo;
      Row.Stroke.Kind := TBrushKind.None;

      LblID := TLabel.Create(Row);
      LblID.Parent := Row;
      LblID.Visible := False;
      LblID.Text := IntToStr(Query.FieldByName('ID').AsInteger);
      LblID.Tag := 82;

      RectIcone := TRectangle.Create(Row);
      RectIcone.Parent := Row;
      RectIcone.Fill.Color := $FF2E3B52;
      RectIcone.Stroke.Kind := TBrushKind.None;
      RectIcone.XRadius := 8;
      RectIcone.YRadius := 8;
      RectIcone.Width := 40;
      RectIcone.Height := 40;
      RectIcone.Position.X := 10;
      RectIcone.Position.Y := 15;
      RectIcone.HitTest := False;

      LblNome := TLabel.Create(Row);
      LblNome.Parent := Row;
      LblNome.StyledSettings := [];
      LblNome.TextSettings.Font.Size := 13;
      LblNome.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblNome.TextSettings.FontColor := $FFFFFFFF;
      LblNome.Width := 275;
      LblNome.Height := 22;
      LblNome.Position.X := 58;
      LblNome.Position.Y := 8;
      LblNome.Text := Query.FieldByName('NOME').AsString;
      LblNome.HitTest := False;

      LblDesc := TLabel.Create(Row);
      LblDesc.Parent := Row;
      LblDesc.StyledSettings := [];
      LblDesc.TextSettings.Font.Size := 11;
      LblDesc.TextSettings.FontColor := $FF94A3B8;
      LblDesc.Width := 275;
      LblDesc.Height := 20;
      LblDesc.Position.X := 58;
      LblDesc.Position.Y := 33;
      LblDesc.Text := Query.FieldByName('DESCRICAO').AsString;
      LblDesc.HitTest := False;

      RectCat := TRectangle.Create(Row);
      RectCat.Parent := Row;
      RectCat.Width := 110;
      RectCat.Height := 28;
      RectCat.Position.X := 355;
      RectCat.Position.Y := 21;
      RectCat.XRadius := 14;
      RectCat.YRadius := 14;
      RectCat.Stroke.Kind := TBrushKind.None;
      RectCat.Fill.Color := $FF1A2B3E;
      RectCat.HitTest := False;

      LblCat := TLabel.Create(RectCat);
      LblCat.Parent := RectCat;
      LblCat.Align := TAlignLayout.Client;
      LblCat.StyledSettings := [];
      LblCat.TextSettings.FontColor := $FF60A5FA;
      LblCat.TextSettings.Font.Size := 11;
      LblCat.TextSettings.HorzAlign := TTextAlign.Center;
      LblCat.Text := Query.FieldByName('CATEGORIA').AsString;
      LblCat.HitTest := False;

      LblPreco := TLabel.Create(Row);
      LblPreco.Parent := Row;
      LblPreco.StyledSettings := [];
      LblPreco.TextSettings.Font.Size := 13;
      LblPreco.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblPreco.TextSettings.FontColor := $FFF58A00;
      LblPreco.Width := 110;
      LblPreco.Height := 26;
      LblPreco.Position.X := 475;
      LblPreco.Position.Y := 22;
      LblPreco.Text := Format('R$ %.2f', [Query.FieldByName('PRECO').AsFloat]);
      LblPreco.HitTest := False;

      LblDur := TLabel.Create(Row);
      LblDur.Parent := Row;
      LblDur.StyledSettings := [];
      LblDur.TextSettings.Font.Size := 13;
      LblDur.TextSettings.FontColor := $FF94A3B8;
      LblDur.Width := 110;
      LblDur.Height := 26;
      LblDur.Position.X := 595;
      LblDur.Position.Y := 22;
      LblDur.Text := IntToStr(Query.FieldByName('DURACAO_MIN').AsInteger) + ' min';
      LblDur.HitTest := False;

      LblAgend := TLabel.Create(Row);
      LblAgend.Parent := Row;
      LblAgend.StyledSettings := [];
      LblAgend.TextSettings.Font.Size := 13;
      LblAgend.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblAgend.TextSettings.FontColor := $FFFFFFFF;
      LblAgend.Width := 135;
      LblAgend.Height := 22;
      LblAgend.Position.X := 715;
      LblAgend.Position.Y := 8;
      LblAgend.Text := IntToStr(Query.FieldByName('TOTAL_AGEND').AsInteger);
      LblAgend.HitTest := False;

      if Query.FieldByName('RECEITA').IsNull then
        ReceitaServ := 0
      else
        ReceitaServ := Query.FieldByName('RECEITA').AsFloat;
      TotalReceita := TotalReceita + ReceitaServ;

      LblReceita := TLabel.Create(Row);
      LblReceita.Parent := Row;
      LblReceita.StyledSettings := [];
      LblReceita.TextSettings.Font.Size := 10;
      LblReceita.TextSettings.FontColor := $FF64748B;
      LblReceita.Width := 135;
      LblReceita.Height := 20;
      LblReceita.Position.X := 715;
      LblReceita.Position.Y := 33;
      LblReceita.Text := Format('R$ %.2f', [ReceitaServ]);
      LblReceita.HitTest := False;

      LblEdit := TLabel.Create(Row);
      LblEdit.Parent := Row;
      LblEdit.StyledSettings := [];
      LblEdit.TextSettings.Font.Size := 18;
      LblEdit.TextSettings.FontColor := $FF60A5FA;
      LblEdit.TextSettings.HorzAlign := TTextAlign.Center;
      LblEdit.TextSettings.VertAlign := TTextAlign.Center;
      LblEdit.Width := 30;
      LblEdit.Height := 70;
      LblEdit.Position.X := 860;
      LblEdit.Position.Y := 0;
      LblEdit.Text := #$270E;
      LblEdit.HitTest := True;
      LblEdit.OnClick := EditarServicoClick;

      LblDel := TLabel.Create(Row);
      LblDel.Parent := Row;
      LblDel.StyledSettings := [];
      LblDel.TextSettings.Font.Size := 18;
      LblDel.TextSettings.FontColor := $FFEF4444;
      LblDel.TextSettings.HorzAlign := TTextAlign.Center;
      LblDel.TextSettings.VertAlign := TTextAlign.Center;
      LblDel.Width := 30;
      LblDel.Height := 70;
      LblDel.Position.X := 900;
      LblDel.Position.Y := 0;
      LblDel.Text := #$2715;
      LblDel.HitTest := True;
      LblDel.OnClick := EliminarServicoClick;

      RectToggle := TRectangle.Create(Row);
      RectToggle.Parent := Row;
      RectToggle.Width := 60;
      RectToggle.Height := 24;
      RectToggle.Position.X := 940;
      RectToggle.Position.Y := 23;
      RectToggle.XRadius := 12;
      RectToggle.YRadius := 12;
      RectToggle.Stroke.Kind := TBrushKind.None;
      if IsAtivo then
        RectToggle.Fill.Color := $FF16A34A
      else
        RectToggle.Fill.Color := $FF7F1D1D;

      LblToggle := TLabel.Create(RectToggle);
      LblToggle.Parent := RectToggle;
      LblToggle.Align := TAlignLayout.Client;
      LblToggle.StyledSettings := [];
      LblToggle.TextSettings.FontColor := $FFFFFFFF;
      LblToggle.TextSettings.Font.Size := 11;
      LblToggle.TextSettings.HorzAlign := TTextAlign.Center;
      LblToggle.HitTest := False;
      if IsAtivo then
        LblToggle.Text := 'ON'
      else
        LblToggle.Text := 'OFF';

      Query.Next;
      Inc(Count);
    end;

    scrollListaServicos.Content.Height := Count * 74 + 20;

    lblResultadosTotal.StyledSettings := [];
    lblResultadosTotal.TextSettings.FontColor := $FF64748B;
    lblResultadosTotal.Text :=
      IntToStr(Count) + IfThen(Count = 1, ' Resultado', ' Resultados');

    lblContadorRodape.StyledSettings := [];
    lblContadorRodape.TextSettings.FontColor := $FF64748B;
    lblContadorRodape.Text :=
      'Exibindo ' + IntToStr(Count) + ' de ' + IntToStr(Count) + ' Servi'#231'os';

    lblValorReceitaTotal.StyledSettings := [];
    lblValorReceitaTotal.TextSettings.FontColor := $FFF58A00;
    lblValorReceitaTotal.Text := Format('R$ %.2f', [TotalReceita]);

  finally
    Query.Free;
  end;
end;

procedure TFrameServicos.AtualizarFiltros(FiltroAtivo: TRectangle);

  procedure SetFiltro(R: TRectangle; L: TLabel; Ativo: Boolean);
  begin
    if Ativo then
    begin
      R.Fill.Kind := TBrushKind.Solid;
      R.Fill.Color := $FFF58A00;
      R.Stroke.Kind := TBrushKind.None;
      L.StyledSettings := [];
      L.TextSettings.FontColor := $FF0B1220;
    end
    else
    begin
      R.Fill.Kind := TBrushKind.None;
      R.Stroke.Kind := TBrushKind.Solid;
      R.Stroke.Color := $FF2E3B52;
      L.StyledSettings := [];
      L.TextSettings.FontColor := $FF94A3B8;
    end;
  end;

begin
  SetFiltro(rectFiltroTodos,    lblFiltroTodos,    FiltroAtivo = rectFiltroTodos);
  SetFiltro(rectFiltroCabelo,   lblFiltroCabelo,   FiltroAtivo = rectFiltroCabelo);
  SetFiltro(rectFiltroBarba,    lblFiltroBarba,    FiltroAtivo = rectFiltroBarba);
  SetFiltro(rectFiltroEstetica, lblFiltroEstetica, FiltroAtivo = rectFiltroEstetica);
end;

procedure TFrameServicos.AtualizarToggle(Ativo: Integer);

  procedure SetToggle(R: TRectangle; L: TLabel; Activo: Boolean);
  begin
    if Activo then
    begin
      R.Fill.Kind := TBrushKind.Solid;
      R.Fill.Color := $FF2E3B52;
      L.StyledSettings := [];
      L.TextSettings.FontColor := $FFFFFFFF;
    end
    else
    begin
      R.Fill.Kind := TBrushKind.None;
      L.StyledSettings := [];
      L.TextSettings.FontColor := $FF94A3B8;
    end;
  end;

begin
  SetToggle(rectToggleTodos,    lblToggleTodos,    Ativo = 0);
  SetToggle(rectToggleAtivos,   lblToggleAtivos,   Ativo = 1);
  SetToggle(rectToggleInativos, lblToggleInativos, Ativo = 2);
end;

procedure TFrameServicos.FiltroTodosClick(Sender: TObject);
begin
  FFiltroCategoria := '';
  AtualizarFiltros(rectFiltroTodos);
  CarregarServicos;
end;

procedure TFrameServicos.FiltroCabeloClick(Sender: TObject);
begin
  FFiltroCategoria := 'Cabelo';
  AtualizarFiltros(rectFiltroCabelo);
  CarregarServicos;
end;

procedure TFrameServicos.FiltroBarbaClick(Sender: TObject);
begin
  FFiltroCategoria := 'Barba';
  AtualizarFiltros(rectFiltroBarba);
  CarregarServicos;
end;

procedure TFrameServicos.FiltroEsteticaClick(Sender: TObject);
begin
  FFiltroCategoria := 'Est';
  AtualizarFiltros(rectFiltroEstetica);
  CarregarServicos;
end;

procedure TFrameServicos.ToggleTodosClick(Sender: TObject);
begin
  FFiltroStatus := '';
  AtualizarToggle(0);
  CarregarServicos;
end;

procedure TFrameServicos.ToggleAtivosClick(Sender: TObject);
begin
  FFiltroStatus := 'ATIVO';
  AtualizarToggle(1);
  CarregarServicos;
end;

procedure TFrameServicos.ToggleInativosClick(Sender: TObject);
begin
  FFiltroStatus := 'INATIVO';
  AtualizarToggle(2);
  CarregarServicos;
end;

procedure TFrameServicos.BuscaServicoChange(Sender: TObject);
begin
  FBusca := Trim(edtBuscaServicos.Text);
  CarregarServicos;
end;

function TFrameServicos.GetIDFromRow(Row: TFMXObject): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Row.ChildrenCount - 1 do
    if (Row.Children[I] is TLabel) and
       (not TLabel(Row.Children[I]).Visible) then
    begin
      Result := StrToIntDef(TLabel(Row.Children[I]).Text, 0);
      Break;
    end;
end;

procedure TFrameServicos.EditarServicoClick(Sender: TObject);
var
  ServicoID: Integer;
begin
  ServicoID := GetIDFromRow(TFMXObject(Sender).Parent);
  if ServicoID = 0 then Exit;
  if FOverlayEdicao = nil then
    CriarModalEdicao;
  AbrirModalEdicao(ServicoID);
end;

procedure TFrameServicos.EliminarServicoClick(Sender: TObject);
var
  ServicoID: Integer;
  NomeServico: string;
  P: TFMXObject;
  I: Integer;
begin
  ServicoID := GetIDFromRow(TFMXObject(Sender).Parent);
  if ServicoID = 0 then Exit;

  NomeServico := '';
  P := TFMXObject(Sender).Parent;
  for I := 0 to P.ChildrenCount - 1 do
    if (P.Children[I] is TLabel) and
       TLabel(P.Children[I]).Visible and
       (TLabel(P.Children[I]).TextSettings.Font.Style = [TFontStyle.fsBold]) then
    begin
      NomeServico := TLabel(P.Children[I]).Text;
      Break;
    end;

  TDialogService.MessageDialog(
    'Eliminar o servi'#231'o "' + NomeServico + '"?' + #13#10 +
    'Esta ac'#231#227'o n'#227'o pode ser desfeita.',
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    var
      Q: TFDQuery;
    begin
      if AResult <> mrYes then Exit;
      Q := TFDQuery.Create(nil);
      try
        Q.Connection := dmConexao.FDConnection1;
        Q.SQL.Text := 'DELETE FROM TB_SERVICOS WHERE ID = :ID';
        Q.ParamByName('ID').AsInteger := ServicoID;
        Q.ExecSQL;
      finally
        Q.Free;
      end;
      AtualizarKPIs;
      CarregarServicos;
    end);
end;

procedure TFrameServicos.CriarModalEdicao;
var
  LytCenter: TLayout;
  PainelEdicao: TRectangle;
  LblTitulo, LblFechar: TLabel;
  Sep1, Sep2: TRectangle;
  LblNome, LblDesc, LblPreco, LblDur, LblBadge, LblCat: TLabel;
  BtnCancelar, BtnSalvar: TRectangle;
  LblCancel, LblSalvar: TLabel;
begin
  FOverlayEdicao := TRectangle.Create(Self);
  FOverlayEdicao.Parent := Self;
  FOverlayEdicao.Align := TAlignLayout.Contents;
  FOverlayEdicao.Fill.Color := $CC000000;
  FOverlayEdicao.Stroke.Kind := TBrushKind.None;
  FOverlayEdicao.Visible := False;
  FOverlayEdicao.HitTest := True;

  LytCenter := TLayout.Create(FOverlayEdicao);
  LytCenter.Parent := FOverlayEdicao;
  LytCenter.Align := TAlignLayout.Client;

  PainelEdicao := TRectangle.Create(LytCenter);
  PainelEdicao.Parent := LytCenter;
  PainelEdicao.Align := TAlignLayout.Center;
  PainelEdicao.Width := 480;
  PainelEdicao.Height := 500;
  PainelEdicao.Fill.Color := $FF141C2B;
  PainelEdicao.XRadius := 16;
  PainelEdicao.YRadius := 16;
  PainelEdicao.Stroke.Kind := TBrushKind.Solid;
  PainelEdicao.Stroke.Color := $FF2E3B52;
  PainelEdicao.HitTest := True;

  LblTitulo := TLabel.Create(PainelEdicao);
  LblTitulo.Parent := PainelEdicao;
  LblTitulo.Position.X := 20;
  LblTitulo.Position.Y := 18;
  LblTitulo.Width := 380;
  LblTitulo.Height := 28;
  LblTitulo.StyledSettings := [];
  LblTitulo.TextSettings.FontColor := $FFFFFFFF;
  LblTitulo.TextSettings.Font.Size := 18;
  LblTitulo.TextSettings.Font.Style := [TFontStyle.fsBold];
  LblTitulo.Text := 'Editar Servi'#231'o';
  LblTitulo.HitTest := False;

  LblFechar := TLabel.Create(PainelEdicao);
  LblFechar.Parent := PainelEdicao;
  LblFechar.Position.X := 436;
  LblFechar.Position.Y := 14;
  LblFechar.Width := 30;
  LblFechar.Height := 30;
  LblFechar.StyledSettings := [];
  LblFechar.TextSettings.FontColor := $FF94A3B8;
  LblFechar.TextSettings.Font.Size := 18;
  LblFechar.TextSettings.HorzAlign := TTextAlign.Center;
  LblFechar.TextSettings.VertAlign := TTextAlign.Center;
  LblFechar.Text := #$2715;
  LblFechar.HitTest := True;
  LblFechar.OnClick := FecharModalEdicaoClick;

  Sep1 := TRectangle.Create(PainelEdicao);
  Sep1.Parent := PainelEdicao;
  Sep1.Position.X := 0;
  Sep1.Position.Y := 56;
  Sep1.Width := 480;
  Sep1.Height := 1;
  Sep1.Fill.Color := $FF2E3B52;
  Sep1.Stroke.Kind := TBrushKind.None;
  Sep1.HitTest := False;

  // --- Nome ---
  LblNome := TLabel.Create(PainelEdicao);
  LblNome.Parent := PainelEdicao;
  LblNome.Position.X := 20;
  LblNome.Position.Y := 68;
  LblNome.StyledSettings := [];
  LblNome.TextSettings.FontColor := $FF94A3B8;
  LblNome.TextSettings.Font.Size := 11;
  LblNome.Text := 'Nome';
  LblNome.HitTest := False;

  FEdtNome := TEdit.Create(PainelEdicao);
  FEdtNome.Parent := PainelEdicao;
  FEdtNome.Align := TAlignLayout.None;
  FEdtNome.Position.X := 20;
  FEdtNome.Position.Y := 88;
  FEdtNome.Width := 440;
  FEdtNome.Height := 40;
  FEdtNome.TabOrder := 0;

  // --- Descricao ---
  LblDesc := TLabel.Create(PainelEdicao);
  LblDesc.Parent := PainelEdicao;
  LblDesc.Position.X := 20;
  LblDesc.Position.Y := 140;
  LblDesc.StyledSettings := [];
  LblDesc.TextSettings.FontColor := $FF94A3B8;
  LblDesc.TextSettings.Font.Size := 11;
  LblDesc.Text := 'Descri'#231#227'o';
  LblDesc.HitTest := False;

  FEdtDescricao := TEdit.Create(PainelEdicao);
  FEdtDescricao.Parent := PainelEdicao;
  FEdtDescricao.Align := TAlignLayout.None;
  FEdtDescricao.Position.X := 20;
  FEdtDescricao.Position.Y := 160;
  FEdtDescricao.Width := 440;
  FEdtDescricao.Height := 40;
  FEdtDescricao.TabOrder := 1;

  // --- Preco ---
  LblPreco := TLabel.Create(PainelEdicao);
  LblPreco.Parent := PainelEdicao;
  LblPreco.Position.X := 20;
  LblPreco.Position.Y := 212;
  LblPreco.StyledSettings := [];
  LblPreco.TextSettings.FontColor := $FF94A3B8;
  LblPreco.TextSettings.Font.Size := 11;
  LblPreco.Text := 'Pre'#231'o (R$)';
  LblPreco.HitTest := False;

  FEdtPreco := TEdit.Create(PainelEdicao);
  FEdtPreco.Parent := PainelEdicao;
  FEdtPreco.Align := TAlignLayout.None;
  FEdtPreco.Position.X := 20;
  FEdtPreco.Position.Y := 232;
  FEdtPreco.Width := 200;
  FEdtPreco.Height := 40;
  FEdtPreco.TabOrder := 2;

  // --- Duracao ---
  LblDur := TLabel.Create(PainelEdicao);
  LblDur.Parent := PainelEdicao;
  LblDur.Position.X := 240;
  LblDur.Position.Y := 212;
  LblDur.StyledSettings := [];
  LblDur.TextSettings.FontColor := $FF94A3B8;
  LblDur.TextSettings.Font.Size := 11;
  LblDur.Text := 'Dura'#231#227'o (min)';
  LblDur.HitTest := False;

  FEdtDuracao := TEdit.Create(PainelEdicao);
  FEdtDuracao.Parent := PainelEdicao;
  FEdtDuracao.Align := TAlignLayout.None;
  FEdtDuracao.Position.X := 240;
  FEdtDuracao.Position.Y := 232;
  FEdtDuracao.Width := 220;
  FEdtDuracao.Height := 40;
  FEdtDuracao.TabOrder := 3;

  // --- Badge ---
  LblBadge := TLabel.Create(PainelEdicao);
  LblBadge.Parent := PainelEdicao;
  LblBadge.Position.X := 20;
  LblBadge.Position.Y := 284;
  LblBadge.StyledSettings := [];
  LblBadge.TextSettings.FontColor := $FF94A3B8;
  LblBadge.TextSettings.Font.Size := 11;
  LblBadge.Text := 'Badge (opcional)';
  LblBadge.HitTest := False;

  FEdtBadge := TEdit.Create(PainelEdicao);
  FEdtBadge.Parent := PainelEdicao;
  FEdtBadge.Align := TAlignLayout.None;
  FEdtBadge.Position.X := 20;
  FEdtBadge.Position.Y := 304;
  FEdtBadge.Width := 440;
  FEdtBadge.Height := 40;
  FEdtBadge.TabOrder := 4;

  // --- Categoria ---
  LblCat := TLabel.Create(PainelEdicao);
  LblCat.Parent := PainelEdicao;
  LblCat.Position.X := 20;
  LblCat.Position.Y := 356;
  LblCat.StyledSettings := [];
  LblCat.TextSettings.FontColor := $FF94A3B8;
  LblCat.TextSettings.Font.Size := 11;
  LblCat.Text := 'Categoria';
  LblCat.HitTest := False;

  FCboCategoria := TComboBox.Create(PainelEdicao);
  FCboCategoria.Parent := PainelEdicao;
  FCboCategoria.Position.X := 20;
  FCboCategoria.Position.Y := 376;
  FCboCategoria.Width := 440;
  FCboCategoria.Height := 40;
  FCboCategoria.Items.Add('Cabelo');
  FCboCategoria.Items.Add('Barba');
  FCboCategoria.Items.Add('Est'#233'tica');
  FCboCategoria.Items.Add('Combo');
  FCboCategoria.ItemIndex := 0;

  Sep2 := TRectangle.Create(PainelEdicao);
  Sep2.Parent := PainelEdicao;
  Sep2.Position.X := 0;
  Sep2.Position.Y := 428;
  Sep2.Width := 480;
  Sep2.Height := 1;
  Sep2.Fill.Color := $FF2E3B52;
  Sep2.Stroke.Kind := TBrushKind.None;
  Sep2.HitTest := False;

  BtnCancelar := TRectangle.Create(PainelEdicao);
  BtnCancelar.Parent := PainelEdicao;
  BtnCancelar.Position.X := 20;
  BtnCancelar.Position.Y := 442;
  BtnCancelar.Width := 195;
  BtnCancelar.Height := 44;
  BtnCancelar.Fill.Color := $FF1E293B;
  BtnCancelar.Stroke.Kind := TBrushKind.Solid;
  BtnCancelar.Stroke.Color := $FF2E3B52;
  BtnCancelar.XRadius := 10;
  BtnCancelar.YRadius := 10;
  BtnCancelar.OnClick := FecharModalEdicaoClick;

  LblCancel := TLabel.Create(BtnCancelar);
  LblCancel.Parent := BtnCancelar;
  LblCancel.Align := TAlignLayout.Client;
  LblCancel.StyledSettings := [];
  LblCancel.TextSettings.FontColor := $FF94A3B8;
  LblCancel.TextSettings.Font.Size := 14;
  LblCancel.TextSettings.HorzAlign := TTextAlign.Center;
  LblCancel.TextSettings.VertAlign := TTextAlign.Center;
  LblCancel.Text := 'Cancelar';
  LblCancel.HitTest := False;

  BtnSalvar := TRectangle.Create(PainelEdicao);
  BtnSalvar.Parent := PainelEdicao;
  BtnSalvar.Position.X := 225;
  BtnSalvar.Position.Y := 442;
  BtnSalvar.Width := 235;
  BtnSalvar.Height := 44;
  BtnSalvar.Fill.Color := $FFF58A00;
  BtnSalvar.Stroke.Kind := TBrushKind.None;
  BtnSalvar.XRadius := 10;
  BtnSalvar.YRadius := 10;
  BtnSalvar.OnClick := SalvarEdicaoClick;

  LblSalvar := TLabel.Create(BtnSalvar);
  LblSalvar.Parent := BtnSalvar;
  LblSalvar.Align := TAlignLayout.Client;
  LblSalvar.StyledSettings := [];
  LblSalvar.TextSettings.FontColor := $FF0B1220;
  LblSalvar.TextSettings.Font.Size := 14;
  LblSalvar.TextSettings.Font.Style := [TFontStyle.fsBold];
  LblSalvar.TextSettings.HorzAlign := TTextAlign.Center;
  LblSalvar.TextSettings.VertAlign := TTextAlign.Center;
  LblSalvar.Text := 'Guardar Altera'#231#245'es';
  LblSalvar.HitTest := False;
end;

procedure TFrameServicos.AbrirModalEdicao(AID: Integer);
var
  Query: TFDQuery;
  Categoria: string;
  Idx: Integer;
begin
  FEditServicoID := AID;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT S.NOME, S.DESCRICAO, S.PRECO, S.DURACAO_MIN, S.BADGE,' +
      ' C.NOME AS CATEGORIA' +
      ' FROM TB_SERVICOS S' +
      ' JOIN TB_CATEGORIAS C ON C.ID = S.CATEGORIA_ID' +
      ' WHERE S.ID = :ID';
    Query.ParamByName('ID').AsInteger := AID;
    Query.Open;

    if not Query.EOF then
    begin
      FEdtNome.Text      := Query.FieldByName('NOME').AsString;
      FEdtDescricao.Text := Query.FieldByName('DESCRICAO').AsString;
      FEdtPreco.Text     := FormatFloat('0.00', Query.FieldByName('PRECO').AsFloat);
      FEdtDuracao.Text   := IntToStr(Query.FieldByName('DURACAO_MIN').AsInteger);
      FEdtBadge.Text     := Query.FieldByName('BADGE').AsString;

      Categoria := Query.FieldByName('CATEGORIA').AsString;
      Idx := FCboCategoria.Items.IndexOf(Categoria);
      if Idx < 0 then
      begin
        for Idx := 0 to FCboCategoria.Items.Count - 1 do
          if Pos(UpperCase(Copy(Categoria, 1, 3)),
                 UpperCase(FCboCategoria.Items[Idx])) > 0 then
            Break;
        if Idx >= FCboCategoria.Items.Count then
          Idx := 0;
      end;
      FCboCategoria.ItemIndex := Idx;
    end;
  finally
    Query.Free;
  end;

  FOverlayEdicao.Visible := True;
  FOverlayEdicao.BringToFront;
end;

procedure TFrameServicos.FecharModalEdicaoClick(Sender: TObject);
begin
  FOverlayEdicao.Visible := False;
end;

procedure TFrameServicos.SalvarEdicaoClick(Sender: TObject);
var
  Nome, Desc, Badge, CatNome: string;
  Preco: Double;
  Duracao, CatID: Integer;
  FS: TFormatSettings;
  Q: TFDQuery;
begin
  Nome  := Trim(FEdtNome.Text);
  Desc  := Trim(FEdtDescricao.Text);
  Badge := Trim(FEdtBadge.Text);

  if Nome = '' then
  begin
    ShowMessage('O nome do servi'#231'o '#233' obrigat'#243'rio.');
    Exit;
  end;

  FS := FormatSettings;
  FS.DecimalSeparator  := '.';
  FS.ThousandSeparator := #0;
  Preco := 0;
  if not TryStrToFloat(
       StringReplace(FEdtPreco.Text, ',', '.', [rfReplaceAll]),
       Preco, FS) or (Preco <= 0) then
  begin
    ShowMessage('Pre'#231'o inv'#225'lido. Use um valor maior que zero.');
    Exit;
  end;

  Duracao := 0;
  if not TryStrToInt(Trim(FEdtDuracao.Text), Duracao) or (Duracao <= 0) then
  begin
    ShowMessage('Dura'#231#227'o inv'#225'lida. Indique um valor inteiro maior que zero.');
    Exit;
  end;

  if FCboCategoria.ItemIndex < 0 then
  begin
    ShowMessage('Seleccione uma categoria.');
    Exit;
  end;
  CatNome := FCboCategoria.Items[FCboCategoria.ItemIndex];

  CatID := 0;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text :=
      'SELECT ID FROM TB_CATEGORIAS WHERE UPPER(NOME) = UPPER(:NOME)';
    Q.ParamByName('NOME').AsString := CatNome;
    Q.Open;
    if not Q.EOF then
      CatID := Q.FieldByName('ID').AsInteger;
  finally
    Q.Free;
  end;

  if CatID = 0 then
  begin
    ShowMessage('Categoria n'#227'o encontrada na base de dados.');
    Exit;
  end;

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text :=
      'UPDATE TB_SERVICOS SET' +
      ' NOME        = :NOME,' +
      ' DESCRICAO   = :DESCRICAO,' +
      ' PRECO       = :PRECO,' +
      ' DURACAO_MIN = :DURACAO,' +
      ' CATEGORIA_ID = :CATEGORIA_ID,' +
      ' BADGE       = :BADGE' +
      ' WHERE ID = :ID';
    Q.ParamByName('NOME').AsString        := Nome;
    Q.ParamByName('DESCRICAO').AsString   := Desc;
    Q.ParamByName('PRECO').AsFloat        := Preco;
    Q.ParamByName('DURACAO').AsInteger    := Duracao;
    Q.ParamByName('CATEGORIA_ID').AsInteger := CatID;
    Q.ParamByName('BADGE').AsString       := Badge;
    Q.ParamByName('ID').AsInteger         := FEditServicoID;
    Q.ExecSQL;
  finally
    Q.Free;
  end;

  FOverlayEdicao.Visible := False;
  AtualizarKPIs;
  CarregarServicos;
end;

end.
