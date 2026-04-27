unit View.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  System.Hash;

type
  TFrmPrincipal = class(TForm)
    TabControlPrincipal: TTabControl;
    TabLogin: TTabItem;
    TabNovaConta: TTabItem;
    lytPrincipalLogin: TLayout;
    rectLogoApp: TRectangle;
    lytLogoCentralizado: TLayout;
    lblTituloApp: TLabel;
    rectFundoTabLogin: TRectangle;
    lblSubTituloApp: TLabel;
    lytCampoEmail: TLayout;
    lblEmail: TLabel;
    rectFundoEmail: TRectangle;
    edtEmail: TEdit;
    lytCampoSenha: TLayout;
    lblSenha: TLabel;
    rectFundoSenha: TRectangle;
    edtSenha: TEdit;
    rectBtnEntrar: TRectangle;
    lblBtnEntrar: TLabel;
    btnAcessarLogin: TSpeedButton;
    rectBtnNovaConta: TRectangle;
    lblBtnNovaConta: TLabel;
    btnNovaConta: TSpeedButton;
    rectFundoTabNovaConta: TRectangle;
    scrollNovaConta: TVertScrollBox;
    lytVoltar: TLayout;
    lblVoltar: TLabel;
    lytLogoCentralizadoNovaConta: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    lytCampoConfirma: TLayout;
    lblConfirma: TLabel;
    Rectangle2: TRectangle;
    edtConfirmarSenha: TEdit;
    lytCampoSenhaCad: TLayout;
    lblSenhaCad: TLabel;
    Rectangle3: TRectangle;
    edtSenhaCadastro: TEdit;
    lytCampoEmailCad: TLayout;
    lblEmailCad: TLabel;
    Rectangle4: TRectangle;
    edtEmailCadastro: TEdit;
    lytCampoNome: TLayout;
    lblNome: TLabel;
    Rectangle5: TRectangle;
    edtNomeCadastro: TEdit;
    lytTermos: TLayout;
    chkTermos: TCheckBox;
    Label3: TLabel;
    rectBtnCadastrar: TRectangle;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    lytRodapeCadastro: TLayout;
    lblJaTenhoConta: TLabel;
    tabClienteHome: TTabItem;
    rectFundoHome: TRectangle;
    rectMenuInferior: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    lytMenuInicio: TLayout;
    lytMenuAgenda: TLayout;
    lytMenuCarrinho: TLayout;
    lytMenuPerfil: TLayout;
    lblMenuInicio: TLabel;
    imgMenuInicio: TImage;
    lblMenuAgenda: TLabel;
    imgMenuAgenda: TImage;
    lblMenuCarrinho: TLabel;
    imgMenuCarrinho: TImage;
    lblMenuPerfil: TLabel;
    imgMenuPerfil: TImage;
    scrollHome: TVertScrollBox;
    lytHeaderHome: TLayout;
    lblBemVindo: TLabel;
    lblNomeCliente: TLabel;
    lytAcoesHeader: TLayout;
    imgNotificacao: TImage;
    circlePerfil: TCircle;
    lytBusca: TLayout;
    rectFundoBusca: TRectangle;
    edtBusca: TEdit;
    rectBannerOferta: TRectangle;
    lblSubtituloOferta: TLabel;
    lblTituloOferta: TLabel;
    lytBtnOferta: TLayout;
    rectBtnAproveitar: TRectangle;
    lblAproveitar: TLabel;
    scrollCategorias: THorzScrollBox;
    rectFiltroTodos: TRectangle;
    lblFiltroTodos: TLabel;
    rectFiltroEstetica: TRectangle;
    lblFiltroEstetica: TLabel;
    rectFiltroCabelo: TRectangle;
    lblFiltroCabelo: TLabel;
    rectFiltroBarba: TRectangle;
    lblFiltroBarba: TLabel;
    lytTituloServicos: TLayout;
    lblTituloServicos: TLabel;
    lblVerTodos: TLabel;
    rectCardCorte: TRectangle;
    imgFotoCorte: TImage;
    lytInfoCorte: TLayout;
    lblNomeCorte: TLabel;
    lblDescCorte: TLabel;
    lblPrecoCorte: TLabel;
    rectBtnAddCorte: TRectangle;
    lblBtnAddCorte: TLabel;
    rectCardBarba: TRectangle;
    imgFotoBarba: TImage;
    lytInfoBarba: TLayout;
    lblNomeBarba: TLabel;
    lblDescBarba: TLabel;
    lblPrecoBarba: TLabel;
    rectBtnAddBarba: TRectangle;
    lblBtnAddBarba: TLabel;
    rectCardSobrancelha: TRectangle;
    imgFotoSobrancelha: TImage;
    lytInfoSobrancelha: TLayout;
    lblNomeSobrancelha: TLabel;
    lblDescSobrancelha: TLabel;
    lblPrecoSobrancelha: TLabel;
    rectBtnAddSobrancelha: TRectangle;
    lblBtnAddSobrancelha: TLabel;
    tabAgendamento: TTabItem;
    rectFundoAgendamento: TRectangle;
    rectRodapeConfirma: TRectangle;
    lytResumoValores: TLayout;
    lblResumoServico: TLabel;
    lblResumoData: TLabel;
    lblResumoBarbeiro: TLabel;
    lytResumoPreco: TLayout;
    lblTextoTotal: TLabel;
    lblValorTotal: TLabel;
    rectBtnConfirmar: TRectangle;
    lblBtnConfirmar: TLabel;
    scrollAgendamento: TVertScrollBox;
    lytHeaderAgendar: TLayout;
    rectBtnVoltarAgendar: TRectangle;
    lytTextosHeader: TLayout;
    lblTituloAgendar: TLabel;
    lblSubTituloAgendar: TLabel;
    rectServicoAgendar: TRectangle;
    rectIconeServico: TRectangle;
    lytContainerBadge: TLayout;
    rectBadgeSelecionado: TRectangle;
    lblBadgeSelecionado: TLabel;
    lytInfoServicoAgendar: TLayout;
    lblNomeServicoAgendar: TLabel;
    lytDetalhesServico: TLayout;
    lblTempoServico: TLabel;
    lblPrecoServico: TLabel;
    lytMesAgendar: TLayout;
    lblMesAtual: TLabel;
    lytSetasMes: TLayout;
    rectSetaAnterior: TRectangle;
    rectSetaProximo: TRectangle;
    scrollDatas: THorzScrollBox;
    rectDiaSabado: TRectangle;
    lblDiaSemanaSabado: TLabel;
    lblDiaNumeroSabado: TLabel;
    rectDiaDomingo: TRectangle;
    lblDiaSemanaDomingo: TLabel;
    lblDiaNumeroDomingo: TLabel;
    rectDiaSegunda: TRectangle;
    lblDiaSemanaSegunda: TLabel;
    lblDiaNumeroSegunda: TLabel;
    rectDiaTerca: TRectangle;
    lblDiaSemanaTerca: TLabel;
    lblDiaNumeroTerca: TLabel;
    rectDiaQuarta: TRectangle;
    lblDiaSemanaQuarta: TLabel;
    lblDiaNumeroQuarta: TLabel;
    rectDiaQuinta: TRectangle;
    lblDiaSemanaQuinta: TLabel;
    lblDiaNumeroQuinta: TLabel;
    rectDiaSexta: TRectangle;
    lblDiaSemanaSexta: TLabel;
    lblDiaNumeroSexta: TLabel;
    lytTituloHorarios: TLayout;
    lblHorariosDisponiveis: TLabel;
    lytLegendaCores: TLayout;
    lytLegendaDisp: TLayout;
    circleLegendaDisp: TCircle;
    lblLegendaDisp: TLabel;
    lytLegendaOcup: TLayout;
    circleLegendaOcup: TCircle;
    lblLegendaOcup: TLabel;
    flowHorarios: TFlowLayout;
    rectHora0900: TRectangle;
    lblHora0900: TLabel;
    rectHora0930: TRectangle;
    lblHora0930: TLabel;
    rectHora1000: TRectangle;
    lblHora1000: TLabel;
    rectHora1030: TRectangle;
    lblHora1030: TLabel;
    rectHora1100: TRectangle;
    lblHora1100: TLabel;
    rectHora1130: TRectangle;
    lblHora1130: TLabel;
    rectHora1200: TRectangle;
    lblHora1200: TLabel;
    rectHora1230: TRectangle;
    lblHora1230: TLabel;
    rectHora1300: TRectangle;
    lblHora1300: TLabel;
    rectHora1330: TRectangle;
    lblHora1330: TLabel;
    rectHora1400: TRectangle;
    lblHora1400: TLabel;
    rectHora1430: TRectangle;
    lblHora1430: TLabel;
    rectHora1500: TRectangle;
    lblHora1500: TLabel;
    rectHora1530: TRectangle;
    lblHora1530: TLabel;
    rectHora1600: TRectangle;
    lblHora1600: TLabel;
    rectHora1630: TRectangle;
    lblHora1630: TLabel;
    rectHora1700: TRectangle;
    lblHora1700: TLabel;
    rectHora1730: TRectangle;
    lblHora1730: TLabel;
    rectHora1800: TRectangle;
    lblHora1800: TLabel;
    rectHora1830: TRectangle;
    lblHora1830: TLabel;
    lblTituloBarbeiros: TLabel;
    rectBarbeiroPedro: TRectangle;
    Circle1: TCircle;
    Layout1: TLayout;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    imgLogoApp: TImage;
    imgLogoAppNovaConta: TImage;
    imgIconeNome: TImage;
    imgIconeEmail: TImage;
    imgIconeSenha: TImage;
    imgIconeConfirmSenha: TImage;
    imgIconeNomeLogin: TImage;
    imgIconeSenhaLogin: TImage;
    imgIconePerfil: TImage;
    imgIconeBusca: TImage;
    imgIconeMais: TImage;
    imgIconeMais2: TImage;
    imgIconeMais3: TImage;
    imgIconeVoltar: TImage;
    imgIconeLogoAgend: TImage;
    imgIconeVoltar2: TImage;
    imgIconeIr: TImage;
    imgIconeBotaoConfirmAgend: TImage;
    procedure lblVoltarClick(Sender: TObject);
    procedure lblJaTenhoContaClick(Sender: TObject);
    procedure rectBtnNovaContaClick(Sender: TObject);
    procedure rectBtnEntrarClick(Sender: TObject);
    procedure rectBtnAddCorteClick(Sender: TObject);
    procedure rectBtnVoltarAgendarClick(Sender: TObject);
    procedure imgLogoAppClick(Sender: TObject);
    procedure lytMenuAgendaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rectFiltroTodosClick(Sender: TObject);
    procedure rectFiltroCabeloClick(Sender: TObject);
    procedure rectFiltroBarbaClick(Sender: TObject);
    procedure rectFiltroEsteticaClick(Sender: TObject);
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BarbeiroSelecionadoClick(Sender: TObject);
    procedure rectBtnConfirmarClick(Sender: TObject);
    procedure HorarioSelecionadoClick(Sender: TObject);
  private
    FFiltroCategoria: string;
    FServicoIDSelecionado: Integer;
    FServicoNomeSelecionado: string;
    FServicoPrecSelecionado: Currency;
    FServicoTempoSelecionado: Integer;
    FDataSelecionada: TDate;
    FHoraSelecionada: string;
    FBarbeiroIDSelecionado: Integer;
    FBarbeiroNomeSelecionado: string;
    function HashSenha(const Senha: string): string;
    procedure CarregarServicos(const Filtro: string = '');
    procedure AplicarFiltroCategoria(const Categoria: string);
    procedure AbrirAgendamento(ServicoID: Integer; const Nome: string;
                               Preco: Currency; DuracaoMin: Integer);
    procedure CarregarBarbeiros;
    procedure CarregarHorarios;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses View.DashboardAdmin, Model.Conexao, FireDAC.Comp.Client, Data.DB,
  System.DateUtils, FireDAC.Stan.Param;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  TabControlPrincipal.ActiveTab := TabLogin;
end;

procedure TFrmPrincipal.imgLogoAppClick(Sender: TObject);
begin
  Self.Hide;

  FrmDashboardAdmin.Show;
end;

procedure TFrmPrincipal.lblJaTenhoContaClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabLogin, TTabTransition.Slide, TTabTransitionDirection.Reversed);
end;

procedure TFrmPrincipal.lblVoltarClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabLogin, TTabTransition.Slide, TTabTransitionDirection.Reversed);
end;

procedure TFrmPrincipal.lytMenuAgendaClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabAgendamento, TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

procedure TFrmPrincipal.rectBtnAddCorteClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabAgendamento, TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

function TFrmPrincipal.HashSenha(const Senha: string): string;
begin
  Result := UpperCase(THashSHA2.GetHashString(Senha));
end;

procedure TFrmPrincipal.CarregarServicos(const Filtro: string = '');
var
  Query: TFDQuery;
  I: Integer;
  LytContainer: TLayout;
  Card, RectIcone, RectBtn: TRectangle;
  LblNome, LblDesc, LblPreco, LblBtnAdd: TLabel;
  CorIcone: TAlphaColor;
  Categoria: string;
  TotalHeight, StartY: Single;
begin
  // Y explícito: imediatamente abaixo de lytTituloServicos
  StartY := lytTituloServicos.Position.Y + lytTituloServicos.Height + 8;

  // Procura container existente (Tag=98) ou cria um novo
  LytContainer := nil;
  for I := 0 to scrollHome.Content.ControlsCount - 1 do
    if (scrollHome.Content.Controls[I] is TLayout) and
       (scrollHome.Content.Controls[I].Tag = 98) then
    begin
      LytContainer := TLayout(scrollHome.Content.Controls[I]);
      Break;
    end;

  if LytContainer = nil then
  begin
    LytContainer := TLayout.Create(scrollHome);
    LytContainer.Parent := scrollHome;
    LytContainer.Tag := 98;
    LytContainer.Align := TAlignLayout.None;  // posição explícita, sem Align=Top
    LytContainer.Width := scrollHome.Width;
  end
  else
  begin
    // Limpa cards anteriores do container
    for I := LytContainer.ControlsCount - 1 downto 0 do
      LytContainer.Controls[I].Free;
  end;

  // Posiciona o container logo abaixo de "Nossos Serviços"
  LytContainer.Position.X := 0;
  LytContainer.Position.Y := StartY;
  LytContainer.Width := scrollHome.Width;

  Query := TFDQuery.Create(nil);
  TotalHeight := 0;
  try
    Query.Connection := dmConexao.FDConnection1;
    if (Filtro = '') or (UpperCase(Filtro) = 'TODOS') then
    begin
      Query.SQL.Text :=
        'SELECT S.ID, S.NOME, S.DESCRICAO, S.PRECO, S.DURACAO_MIN, ' +
        '       S.BADGE, C.NOME AS CATEGORIA ' +
        'FROM TB_SERVICOS S ' +
        'INNER JOIN TB_CATEGORIAS C ON C.ID = S.CATEGORIA_ID ' +
        'WHERE S.ATIVO = 1 ' +
        'ORDER BY S.ID';
    end
    else
    begin
      Query.SQL.Text :=
        'SELECT S.ID, S.NOME, S.DESCRICAO, S.PRECO, S.DURACAO_MIN, ' +
        '       S.BADGE, C.NOME AS CATEGORIA ' +
        'FROM TB_SERVICOS S ' +
        'INNER JOIN TB_CATEGORIAS C ON C.ID = S.CATEGORIA_ID ' +
        'WHERE S.ATIVO = 1 AND UPPER(C.NOME) = UPPER(:CATEGORIA) ' +
        'ORDER BY S.ID';
      Query.ParamByName('CATEGORIA').AsString := Filtro;
    end;
    Query.Open;

    while not Query.EOF do
    begin
      Categoria := LowerCase(Query.FieldByName('CATEGORIA').AsString);
      if Pos('cabelo', Categoria) > 0 then
        CorIcone := $FF1E3A2A
      else if Pos('barba', Categoria) > 0 then
        CorIcone := $FF1A2F4A
      else if Pos('est', Categoria) > 0 then
        CorIcone := $FF2D1A3D
      else if Pos('combo', Categoria) > 0 then
        CorIcone := $FF2D2A1A
      else
        CorIcone := $FF1A2A2D;

      // Card principal dentro do container
      Card := TRectangle.Create(LytContainer);
      Card.Parent := LytContainer;
      Card.Tag := 99;
      Card.Height := 120;
      Card.Align := TAlignLayout.Top;
      Card.Fill.Color := $FF0F1923;
      Card.Stroke.Color := $FF1E293B;
      Card.XRadius := 12;
      Card.YRadius := 12;
      Card.Margins.Left := 20;
      Card.Margins.Right := 20;
      Card.Margins.Top := 8;
      Card.Margins.Bottom := 12;
      Card.HitTest := False;
      TotalHeight := TotalHeight + 120 + 8 + 12;

      // Ícone colorido à esquerda
      RectIcone := TRectangle.Create(Card);
      RectIcone.Parent := Card;
      RectIcone.Width := 80;
      RectIcone.Height := 80;
      RectIcone.Position.X := 16;
      RectIcone.Position.Y := 20;
      RectIcone.Fill.Color := CorIcone;
      RectIcone.Stroke.Kind := TBrushKind.None;
      RectIcone.XRadius := 10;
      RectIcone.YRadius := 10;
      RectIcone.HitTest := False;

      // Nome do serviço
      LblNome := TLabel.Create(Card);
      LblNome.Parent := Card;
      LblNome.Position.X := 112;
      LblNome.Position.Y := 18;
      LblNome.Width := Card.Width - 180;
      LblNome.Text := Query.FieldByName('NOME').AsString;
      LblNome.StyledSettings := [];
      LblNome.TextSettings.Font.Size := 14;
      LblNome.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblNome.TextSettings.FontColor := $FFFFFFFF;
      LblNome.HitTest := False;

      // Descrição
      LblDesc := TLabel.Create(Card);
      LblDesc.Parent := Card;
      LblDesc.Position.X := 112;
      LblDesc.Position.Y := 42;
      LblDesc.Width := Card.Width - 180;
      LblDesc.Height := 28;
      LblDesc.Text := Query.FieldByName('DESCRICAO').AsString;
      LblDesc.StyledSettings := [];
      LblDesc.TextSettings.Font.Size := 11;
      LblDesc.TextSettings.FontColor := $FF94A3B8;
      LblDesc.WordWrap := True;
      LblDesc.HitTest := False;

      // Preço
      LblPreco := TLabel.Create(Card);
      LblPreco.Parent := Card;
      LblPreco.Position.X := 112;
      LblPreco.Position.Y := 76;
      LblPreco.Text := 'R$ ' + FormatFloat('0.00', Query.FieldByName('PRECO').AsFloat);
      LblPreco.StyledSettings := [];
      LblPreco.TextSettings.Font.Size := 13;
      LblPreco.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblPreco.TextSettings.FontColor := $FFF58A00;
      LblPreco.HitTest := False;

      // Botão Adicionar
      RectBtn := TRectangle.Create(Card);
      RectBtn.Parent := Card;
      RectBtn.Width := 90;
      RectBtn.Height := 32;
      RectBtn.Position.X := Card.Width - 106;
      RectBtn.Position.Y := 76;
      RectBtn.Fill.Color := $FFF58A00;
      RectBtn.Stroke.Kind := TBrushKind.None;
      RectBtn.XRadius := 8;
      RectBtn.YRadius := 8;
      RectBtn.Tag := Query.FieldByName('ID').AsInteger;
      RectBtn.HitTest := True;
      RectBtn.OnClick := BtnAdicionarClick;

      LblBtnAdd := TLabel.Create(RectBtn);
      LblBtnAdd.Parent := RectBtn;
      LblBtnAdd.Align := TAlignLayout.Client;
      LblBtnAdd.Text := '+ Adicionar';
      LblBtnAdd.StyledSettings := [];
      LblBtnAdd.TextSettings.Font.Size := 11;
      LblBtnAdd.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblBtnAdd.TextSettings.FontColor := $FFFFFFFF;
      LblBtnAdd.TextSettings.HorzAlign := TTextAlign.Center;
      LblBtnAdd.HitTest := False;

      Query.Next;
    end;

    // Altura do container = soma dos cards
    LytContainer.Height := TotalHeight + 16;
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.rectBtnEntrarClick(Sender: TObject);
var
  Query: TFDQuery;
  PrimeiroNome: string;
begin
  if (Trim(edtEmail.Text) = '') or (Trim(edtSenha.Text) = '') then
  begin
    ShowMessage('Preencha o e-mail e a senha');
    Exit;
  end;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT ID, NOME_COMPLETO, PERFIL FROM TB_USUARIOS ' +
      'WHERE EMAIL = :EMAIL AND SENHA_HASH = :SENHA AND ATIVO = 1';
    Query.ParamByName('EMAIL').AsString := edtEmail.Text;
    Query.ParamByName('SENHA').AsString := HashSenha(edtSenha.Text);
    Query.Open;

    if not Query.IsEmpty then
    begin
      PrimeiroNome := Query.FieldByName('NOME_COMPLETO').AsString;
      if Pos(' ', PrimeiroNome) > 0 then
        PrimeiroNome := Copy(PrimeiroNome, 1, Pos(' ', PrimeiroNome) - 1);
      lblNomeCliente.Text := PrimeiroNome;

      // Oculta cards estáticos
      rectCardCorte.Visible := False;
      rectCardBarba.Visible := False;
      rectCardSobrancelha.Visible := False;

      TabControlPrincipal.SetActiveTabWithTransition(TabClienteHome, TTabTransition.Slide, TTabTransitionDirection.Normal);
      CarregarServicos('');
    end
    else
      ShowMessage('E-mail ou senha incorrectos');
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.AplicarFiltroCategoria(const Categoria: string);
  procedure ResetarBotao(Rect: TRectangle; Lbl: TLabel);
  begin
    Rect.Fill.Color := $FF1E293B;
    Lbl.StyledSettings := [];
    Lbl.TextSettings.FontColor := $FFFFFFFF;
  end;
  procedure AtivarBotao(Rect: TRectangle; Lbl: TLabel);
  begin
    Rect.Fill.Color := $FFF58A00;
    Lbl.StyledSettings := [];
    Lbl.TextSettings.FontColor := $FF0B1220;
  end;
begin
  FFiltroCategoria := Categoria;

  // Repõe todos os botões no estado inactivo
  ResetarBotao(rectFiltroTodos,    lblFiltroTodos);
  ResetarBotao(rectFiltroCabelo,   lblFiltroCabelo);
  ResetarBotao(rectFiltroBarba,    lblFiltroBarba);
  ResetarBotao(rectFiltroEstetica, lblFiltroEstetica);

  // Activa o botão correspondente
  if (Categoria = '') or (UpperCase(Categoria) = 'TODOS') then
    AtivarBotao(rectFiltroTodos, lblFiltroTodos)
  else if UpperCase(Categoria) = 'CABELO' then
    AtivarBotao(rectFiltroCabelo, lblFiltroCabelo)
  else if UpperCase(Categoria) = 'BARBA' then
    AtivarBotao(rectFiltroBarba, lblFiltroBarba)
  else if UpperCase(Categoria) = 'ESTÉTICA' then
    AtivarBotao(rectFiltroEstetica, lblFiltroEstetica);

  CarregarServicos(Categoria);
end;

procedure TFrmPrincipal.rectFiltroTodosClick(Sender: TObject);
begin
  AplicarFiltroCategoria('');
end;

procedure TFrmPrincipal.rectFiltroCabeloClick(Sender: TObject);
begin
  AplicarFiltroCategoria('Cabelo');
end;

procedure TFrmPrincipal.rectFiltroBarbaClick(Sender: TObject);
begin
  AplicarFiltroCategoria('Barba');
end;

procedure TFrmPrincipal.rectFiltroEsteticaClick(Sender: TObject);
begin
  AplicarFiltroCategoria('Estética');
end;

procedure TFrmPrincipal.AbrirAgendamento(ServicoID: Integer; const Nome: string;
                                         Preco: Currency; DuracaoMin: Integer);
begin
  FServicoIDSelecionado := ServicoID;
  FServicoNomeSelecionado := Nome;
  FServicoPrecSelecionado := Preco;
  FServicoTempoSelecionado := DuracaoMin;
  FDataSelecionada := Date;
  FHoraSelecionada := '';
  FBarbeiroIDSelecionado := 0;
  FBarbeiroNomeSelecionado := '';

  lblNomeServicoAgendar.Text := Nome;
  lblPrecoServico.Text := 'R$ ' + FormatFloat('0.00', Preco);
  lblTempoServico.Text := IntToStr(DuracaoMin) + ' min';
  lblResumoBarbeiro.Text := '-';
  lblResumoServico.Text := Nome;
  lblValorTotal.Text := 'R$ ' + FormatFloat('0.00', Preco);

  TabControlPrincipal.SetActiveTabWithTransition(TabAgendamento,
    TTabTransition.Slide, TTabTransitionDirection.Normal);

  CarregarHorarios;
  CarregarBarbeiros;
end;

procedure TFrmPrincipal.CarregarBarbeiros;
var
  Query: TFDQuery;
  I: Integer;
  Card: TRectangle;
  CircIniciais: TCircle;
  LblIniciais, LblNome, LblCargo, LblAvaliacao: TLabel;
  NomeCompleto, Iniciais: string;
  StartY, YPos, CardWidth: Single;
begin
  // Oculta o card estático de barbeiro
  rectBarbeiroPedro.Visible := False;

  // Remove cards de barbeiro anteriores (Tag=97)
  for I := scrollAgendamento.Content.ControlsCount - 1 downto 0 do
    if (scrollAgendamento.Content.Controls[I] is TRectangle) and
       (scrollAgendamento.Content.Controls[I].Tag = 97) then
      scrollAgendamento.Content.Controls[I].Free;

  // Y de início: logo abaixo de lblTituloBarbeiros (Position.Y=680, Height=17, Margins.Bottom=15)
  StartY := lblTituloBarbeiros.Position.Y + lblTituloBarbeiros.Height +
            lblTituloBarbeiros.Margins.Bottom;
  YPos := 0;
  CardWidth := scrollAgendamento.Width - 32; // 16px margem esquerda + 16px direita

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT B.ID, U.NOME_COMPLETO, B.CARGO, B.AVALIACAO_MEDIA ' +
      'FROM TB_BARBEIROS B ' +
      'INNER JOIN TB_USUARIOS U ON U.ID = B.USUARIO_ID ' +
      'WHERE B.ATIVO = 1 ' +
      'ORDER BY B.AVALIACAO_MEDIA DESC';
    Query.Open;

    while not Query.EOF do
    begin
      NomeCompleto := Query.FieldByName('NOME_COMPLETO').AsString;

      // Extrai iniciais (até 2 letras)
      Iniciais := '';
      if Length(NomeCompleto) > 0 then
        Iniciais := UpperCase(NomeCompleto[1]);
      if Pos(' ', NomeCompleto) > 0 then
        Iniciais := Iniciais + UpperCase(NomeCompleto[Pos(' ', NomeCompleto) + 1]);

      // Card do barbeiro — Align=None com posição explícita
      Card := TRectangle.Create(scrollAgendamento);
      Card.Parent := scrollAgendamento;
      Card.Tag := Query.FieldByName('ID').AsInteger;
      Card.Height := 70;
      Card.Width := CardWidth;
      Card.Align := TAlignLayout.None;
      Card.Position.X := 16;
      Card.Position.Y := StartY + YPos;
      Card.Fill.Color := $FF141C2B;
      Card.Stroke.Color := $FF1E293B;
      Card.XRadius := 12;
      Card.YRadius := 12;
      Card.HitTest := True;
      Card.OnClick := BarbeiroSelecionadoClick;

      YPos := YPos + 70 + 8 + 4; // height + margin top + margin bottom

      // Círculo com iniciais
      CircIniciais := TCircle.Create(Card);
      CircIniciais.Parent := Card;
      CircIniciais.Width := 44;
      CircIniciais.Height := 44;
      CircIniciais.Position.X := 12;
      CircIniciais.Position.Y := 13;
      CircIniciais.Fill.Color := $FF1E293B;
      CircIniciais.Stroke.Color := $FFF58A00;
      CircIniciais.HitTest := False;

      LblIniciais := TLabel.Create(CircIniciais);
      LblIniciais.Parent := CircIniciais;
      LblIniciais.Align := TAlignLayout.Client;
      LblIniciais.Text := Iniciais;
      LblIniciais.StyledSettings := [];
      LblIniciais.TextSettings.Font.Size := 15;
      LblIniciais.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblIniciais.TextSettings.FontColor := $FFF58A00;
      LblIniciais.TextSettings.HorzAlign := TTextAlign.Center;
      LblIniciais.HitTest := False;

      // Nome completo
      LblNome := TLabel.Create(Card);
      LblNome.Parent := Card;
      LblNome.Position.X := 68;
      LblNome.Position.Y := 10;
      LblNome.Width := CardWidth - 120;
      LblNome.Text := NomeCompleto;
      LblNome.StyledSettings := [];
      LblNome.TextSettings.Font.Size := 14;
      LblNome.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblNome.TextSettings.FontColor := $FFFFFFFF;
      LblNome.HitTest := False;

      // Cargo
      LblCargo := TLabel.Create(Card);
      LblCargo.Parent := Card;
      LblCargo.Position.X := 68;
      LblCargo.Position.Y := 32;
      LblCargo.Width := CardWidth - 120;
      LblCargo.Text := Query.FieldByName('CARGO').AsString;
      LblCargo.StyledSettings := [];
      LblCargo.TextSettings.Font.Size := 12;
      LblCargo.TextSettings.FontColor := $FF94A3B8;
      LblCargo.HitTest := False;

      // Avaliação
      LblAvaliacao := TLabel.Create(Card);
      LblAvaliacao.Parent := Card;
      LblAvaliacao.Position.X := CardWidth - 58;
      LblAvaliacao.Position.Y := 26;
      LblAvaliacao.Width := 50;
      LblAvaliacao.Text := '★ ' + FormatFloat('0.0',
        Query.FieldByName('AVALIACAO_MEDIA').AsFloat);
      LblAvaliacao.StyledSettings := [];
      LblAvaliacao.TextSettings.Font.Size := 13;
      LblAvaliacao.TextSettings.FontColor := $FFF58A00;
      LblAvaliacao.HitTest := False;

      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.CarregarHorarios;
const
  Horarios: array[0..19] of string = (
    '09:00','09:30','10:00','10:30','11:00','11:30',
    '12:00','12:30','13:00','13:30','14:00','14:30',
    '15:00','15:30','16:00','16:30','17:00','17:30',
    '18:00','18:30');
  // Horários ocupados — hardcoded para demonstração
  Ocupados: array[0..5] of string = (
    '09:30','10:30','12:00','14:00','15:30','17:00');
var
  I, J: Integer;
  Rect: TRectangle;
  Lbl: TLabel;
  Ocupado: Boolean;
begin
  // Oculta os 20 rectHora* estáticos
  rectHora0900.Visible := False;  rectHora0930.Visible := False;
  rectHora1000.Visible := False;  rectHora1030.Visible := False;
  rectHora1100.Visible := False;  rectHora1130.Visible := False;
  rectHora1200.Visible := False;  rectHora1230.Visible := False;
  rectHora1300.Visible := False;  rectHora1330.Visible := False;
  rectHora1400.Visible := False;  rectHora1430.Visible := False;
  rectHora1500.Visible := False;  rectHora1530.Visible := False;
  rectHora1600.Visible := False;  rectHora1630.Visible := False;
  rectHora1700.Visible := False;  rectHora1730.Visible := False;
  rectHora1800.Visible := False;  rectHora1830.Visible := False;

  // Limpa horários dinâmicos anteriores (Tag=96)
  for I := flowHorarios.ControlsCount - 1 downto 0 do
    if (flowHorarios.Controls[I] is TRectangle) and
       (flowHorarios.Controls[I].Tag = 96) then
      flowHorarios.Controls[I].Free;

  // Cria os botões de horário dinamicamente
  for I := 0 to High(Horarios) do
  begin
    // Verifica se o horário está ocupado
    Ocupado := False;
    for J := 0 to High(Ocupados) do
      if Ocupados[J] = Horarios[I] then
      begin
        Ocupado := True;
        Break;
      end;

    Rect := TRectangle.Create(flowHorarios);
    Rect.Parent := flowHorarios;
    Rect.Tag := 96;
    Rect.Width := 80;
    Rect.Height := 40;
    Rect.XRadius := 10;
    Rect.YRadius := 10;
    Rect.Margins.Left := 4;
    Rect.Margins.Right := 4;
    Rect.Margins.Top := 4;
    Rect.Margins.Bottom := 4;

    if Ocupado then
    begin
      Rect.Fill.Color := $FF1A1A2E;
      Rect.Stroke.Color := $FF3A4A5C;
      Rect.Stroke.Thickness := 1;
      Rect.HitTest := False;
    end
    else
    begin
      Rect.Fill.Color := $FF141C2B;
      Rect.Stroke.Color := $FFF58A00;
      Rect.Stroke.Thickness := 1.5;
      Rect.HitTest := True;
      Rect.OnClick := HorarioSelecionadoClick;
    end;

    Lbl := TLabel.Create(Rect);
    Lbl.Parent := Rect;
    Lbl.Align := TAlignLayout.Client;
    Lbl.Text := Horarios[I];
    Lbl.StyledSettings := [];
    Lbl.TextSettings.Font.Size := 13;
    Lbl.TextSettings.HorzAlign := TTextAlign.Center;
    Lbl.HitTest := False;

    if Ocupado then
      Lbl.TextSettings.FontColor := $FF4A5568
    else
      Lbl.TextSettings.FontColor := $FFFFFFFF;
  end;

  // Expande o flowHorarios para caber todos os botões (20 horários, ~3 por linha)
  flowHorarios.Height := 380;
end;

procedure TFrmPrincipal.HorarioSelecionadoClick(Sender: TObject);
var
  RectClicado: TRectangle;
  I, J: Integer;
  LblFilho: TLabel;
begin
  RectClicado := TRectangle(Sender);

  // Repõe todos os horários DISPONÍVEIS (HitTest=True) para o estado inactivo
  for I := 0 to flowHorarios.ControlsCount - 1 do
    if (flowHorarios.Controls[I] is TRectangle) and
       (flowHorarios.Controls[I].Tag = 96) and
       flowHorarios.Controls[I].HitTest then
    begin
      TRectangle(flowHorarios.Controls[I]).Fill.Color := $FF141C2B;
      TRectangle(flowHorarios.Controls[I]).Stroke.Color := $FFF58A00;
      for J := 0 to flowHorarios.Controls[I].ControlsCount - 1 do
        if flowHorarios.Controls[I].Controls[J] is TLabel then
          TLabel(flowHorarios.Controls[I].Controls[J]).TextSettings.FontColor := $FFFFFFFF;
    end;

  // Destaca o horário seleccionado
  RectClicado.Fill.Color := $FFF58A00;
  FHoraSelecionada := '';
  for J := 0 to RectClicado.ControlsCount - 1 do
    if RectClicado.Controls[J] is TLabel then
    begin
      LblFilho := TLabel(RectClicado.Controls[J]);
      LblFilho.TextSettings.FontColor := $FF0B1220;
      FHoraSelecionada := LblFilho.Text;
    end;

  // Actualiza o resumo
  lblResumoData.Text := FormatDateTime('d "de" MMMM', FDataSelecionada) +
                        ' · ' + FHoraSelecionada;
end;

procedure TFrmPrincipal.BtnAdicionarClick(Sender: TObject);
var
  Btn: TRectangle;
  Query: TFDQuery;
begin
  Btn := TRectangle(Sender);
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT NOME, PRECO, DURACAO_MIN FROM TB_SERVICOS WHERE ID = :ID';
    Query.ParamByName('ID').AsInteger := Btn.Tag;
    Query.Open;
    if not Query.IsEmpty then
      AbrirAgendamento(
        Btn.Tag,
        Query.FieldByName('NOME').AsString,
        Query.FieldByName('PRECO').AsCurrency,
        Query.FieldByName('DURACAO_MIN').AsInteger);
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.BarbeiroSelecionadoClick(Sender: TObject);
var
  Card: TRectangle;
  I: Integer;
begin
  Card := TRectangle(Sender);
  FBarbeiroIDSelecionado := Card.Tag;

  // Obtém o nome do barbeiro a partir do label filho
  FBarbeiroNomeSelecionado := '';
  for I := 0 to Card.ControlsCount - 1 do
    if (Card.Controls[I] is TLabel) and
       (TLabel(Card.Controls[I]).TextSettings.FontColor = TAlphaColorRec.White) then
    begin
      FBarbeiroNomeSelecionado := TLabel(Card.Controls[I]).Text;
      Break;
    end;

  lblResumoBarbeiro.Text := FBarbeiroNomeSelecionado;

  // Remove destaque de todos os cards de barbeiro
  for I := 0 to scrollAgendamento.Content.ControlsCount - 1 do
    if (scrollAgendamento.Content.Controls[I] is TRectangle) and
       (scrollAgendamento.Content.Controls[I].Tag > 0) then
      TRectangle(scrollAgendamento.Content.Controls[I]).Fill.Color := $FF141C2B;

  // Destaca o card seleccionado
  Card.Fill.Color := $FF1E2D42;
end;

procedure TFrmPrincipal.rectBtnConfirmarClick(Sender: TObject);
var
  Query: TFDQuery;
  HrFim: TTime;
  HrInicio: TTime;
  Faltando: string;
begin
  // Validação
  Faltando := '';
  if FServicoIDSelecionado = 0 then
    Faltando := 'serviço';
  if FBarbeiroIDSelecionado = 0 then
  begin
    if Faltando <> '' then Faltando := Faltando + ', ';
    Faltando := Faltando + 'barbeiro';
  end;
  if FHoraSelecionada = '' then
  begin
    if Faltando <> '' then Faltando := Faltando + ', ';
    Faltando := Faltando + 'horário';
  end;

  if Faltando <> '' then
  begin
    ShowMessage('Por favor seleccione: ' + Faltando);
    Exit;
  end;

  // Calcula HR_FIM
  HrInicio := StrToTime(FHoraSelecionada);
  HrFim := IncMinute(HrInicio, FServicoTempoSelecionado);

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'INSERT INTO TB_AGENDAMENTOS ' +
      '  (CLIENTE_ID, BARBEIRO_ID, SERVICO_ID, DT_AGENDAMENTO, ' +
      '   HR_INICIO, HR_FIM, VALOR_COBRADO, STATUS) ' +
      'VALUES (:CID, :BID, :SID, :DTA, :HRI, :HRF, :VAL, ''PENDENTE'')';
    Query.ParamByName('CID').AsInteger := 1; // hardcoded até sessão implementada
    Query.ParamByName('BID').AsInteger := FBarbeiroIDSelecionado;
    Query.ParamByName('SID').AsInteger := FServicoIDSelecionado;
    Query.ParamByName('DTA').AsDate := FDataSelecionada;
    Query.ParamByName('HRI').AsString := FormatDateTime('HH:MM', HrInicio);
    Query.ParamByName('HRF').AsString := FormatDateTime('HH:MM', HrFim);
    Query.ParamByName('VAL').AsCurrency := FServicoPrecSelecionado;
    Query.ExecSQL;

    ShowMessage('Agendamento confirmado!');
    TabControlPrincipal.SetActiveTabWithTransition(TabClienteHome,
      TTabTransition.Slide, TTabTransitionDirection.Reversed);
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.rectBtnNovaContaClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabNovaConta, TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

procedure TFrmPrincipal.rectBtnVoltarAgendarClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabClienteHome, TTabTransition.Slide, TTabTransitionDirection.Reversed);
end;

end.
