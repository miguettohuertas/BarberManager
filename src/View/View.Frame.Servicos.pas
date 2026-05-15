unit View.Frame.Servicos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit;

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
  private
    FFiltroCategoria: string;
    FFiltroStatus: string;
    FBusca: string;
    procedure CarregarServicos;
    procedure AtualizarKPIs;
    procedure AtualizarFiltros(FiltroAtivo: TRectangle);
    procedure AtualizarToggle(Ativo: Integer);
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  System.StrUtils;

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
  lblValKpi1.TextSettings.FontColor := claWhite;
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
  LblAgend, LblReceita, LblToggle, LblEdit, LblDel: TLabel;
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
      LblNome.TextSettings.FontColor := claWhite;
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
      LblAgend.TextSettings.FontColor := claWhite;
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
      LblEdit.Position.X := 870;
      LblEdit.Position.Y := 0;
      LblEdit.Text := #$270E;
      LblEdit.HitTest := False;

      LblDel := TLabel.Create(Row);
      LblDel.Parent := Row;
      LblDel.StyledSettings := [];
      LblDel.TextSettings.Font.Size := 18;
      LblDel.TextSettings.FontColor := $FFEF4444;
      LblDel.TextSettings.HorzAlign := TTextAlign.Center;
      LblDel.TextSettings.VertAlign := TTextAlign.Center;
      LblDel.Width := 30;
      LblDel.Height := 70;
      LblDel.Position.X := 910;
      LblDel.Position.Y := 0;
      LblDel.Text := #$2715;
      LblDel.HitTest := False;

      RectToggle := TRectangle.Create(Row);
      RectToggle.Parent := Row;
      RectToggle.Width := 46;
      RectToggle.Height := 24;
      RectToggle.Position.X := 928;
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
      LblToggle.TextSettings.FontColor := claWhite;
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
      L.TextSettings.FontColor := claWhite;
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

end.
