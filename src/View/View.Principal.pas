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
    imgIconeVoltar: TImage;
    imgIconeLogoAgend: TImage;
    imgIconeVoltar2: TImage;
    imgIconeIr: TImage;
    imgIconeBotaoConfirmAgend: TImage;
    rectOverlayNotif: TRectangle;
    rectPainelNotif: TRectangle;
    lblTituloNotif: TLabel;
    lblFecharNotif: TLabel;
    scrollNotificacoes: TVertScrollBox;
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
    procedure rectBtnCadastrarClick(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
    procedure lblVerTodosClick(Sender: TObject);
    procedure rectBtnAproveitarClick(Sender: TObject);
    procedure imgNotificacaoClick(Sender: TObject);
    procedure lblFecharNotifClick(Sender: TObject);
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
    function ValidarEmail(const Email: string): Boolean;
    procedure CarregarServicos(const Filtro: string = ''; const Busca: string = '');
    procedure CarregarBannerOferta;
    procedure AplicarFiltroCategoria(const Categoria: string);
    procedure AbrirAgendamento(ServicoID: Integer; const Nome: string;
                               Preco: Currency; DuracaoMin: Integer);
    procedure CarregarBarbeiros;
    procedure CarregarHorarios;
    function GetImagemPorCategoria(const Categoria: string): string;
    procedure CarregarNotificacoes;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses View.DashboardAdmin, Model.Conexao, FireDAC.Comp.Client, Data.DB,
  System.DateUtils, FireDAC.Stan.Param, System.IOUtils;

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
  if FServicoIDSelecionado = 0 then
  begin
    FServicoIDSelecionado    := 0;
    FServicoNomeSelecionado  := 'Nenhum serviço seleccionado';
    FServicoPrecSelecionado  := 0;
    FServicoTempoSelecionado := 0;
    FDataSelecionada         := Date;
    FHoraSelecionada         := '';
    FBarbeiroIDSelecionado   := 0;
    FBarbeiroNomeSelecionado := '';

    lblNomeServicoAgendar.Text := 'Escolha um serviço primeiro';
    lblPrecoServico.Text       := 'R$ 0,00';
    lblTempoServico.Text       := '-- min';
    lblResumoBarbeiro.Text     := '-';
    lblResumoServico.Text      := 'Nenhum serviço';
    lblValorTotal.Text         := 'R$ 0,00';

    TabControlPrincipal.SetActiveTabWithTransition(TabAgendamento,
      TTabTransition.Slide, TTabTransitionDirection.Normal);
    CarregarHorarios;
    CarregarBarbeiros;
  end
  else
    TabControlPrincipal.SetActiveTabWithTransition(TabAgendamento,
      TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

procedure TFrmPrincipal.rectBtnAddCorteClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabAgendamento, TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

function TFrmPrincipal.HashSenha(const Senha: string): string;
begin
  Result := UpperCase(THashSHA2.GetHashString(Senha));
end;

function TFrmPrincipal.GetImagemPorCategoria(const Categoria: string): string;
var
  Cat, BaseDir: string;
begin
  Cat := UpperCase(Categoria);
  // .exe fica em src\Win32\Debug\ — sobe 3 níveis para a raiz do projecto
  BaseDir := ExtractFilePath(ParamStr(0));
  BaseDir := TPath.Combine(BaseDir, '..\..\..');
  BaseDir := TPath.Combine(BaseDir, 'src\assets\img');
  if Pos('CAB', Cat) > 0 then
    Result := TPath.Combine(BaseDir, 'servico_cabelo.jpg')
  else if Pos('BAR', Cat) > 0 then
    Result := TPath.Combine(BaseDir, 'servico_barba.jpg')
  else if Pos('EST', Cat) > 0 then
    Result := TPath.Combine(BaseDir, 'servico_estetica.jpg')
  else if Pos('COM', Cat) > 0 then
    Result := TPath.Combine(BaseDir, 'servico_combo.jpg')
  else
    Result := TPath.Combine(BaseDir, 'servico_cabelo.jpg');
end;

procedure TFrmPrincipal.CarregarServicos(const Filtro: string = ''; const Busca: string = '');
var
  Query: TFDQuery;
  I: Integer;
  LytContainer: TLayout;
  Card, RectIcone, RectBtn: TRectangle;
  LblNome, LblDesc, LblPreco, LblBtnAdd: TLabel;
  ImgServico: TImage;
  CorIcone: TAlphaColor;
  Categoria, SQL: string;
  TotalHeight, StartY: Single;
  FiltroActivo: Boolean;
begin
  StartY := lytTituloServicos.Position.Y + lytTituloServicos.Height + 8;

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
    LytContainer.Align := TAlignLayout.None;
    LytContainer.Width := scrollHome.Width;
  end
  else
  begin
    for I := LytContainer.ControlsCount - 1 downto 0 do
      LytContainer.Controls[I].Free;
  end;

  LytContainer.Position.X := 0;
  LytContainer.Position.Y := StartY;
  LytContainer.Width := scrollHome.Width;

  Query := TFDQuery.Create(nil);
  TotalHeight := 0;
  try
    Query.Connection := dmConexao.FDConnection1;

    FiltroActivo := (Filtro <> '') and (UpperCase(Filtro) <> 'TODOS');
    SQL :=
      'SELECT S.ID, S.NOME, S.DESCRICAO, S.PRECO, S.DURACAO_MIN, ' +
      '       S.BADGE, C.NOME AS CATEGORIA ' +
      'FROM TB_SERVICOS S ' +
      'INNER JOIN TB_CATEGORIAS C ON C.ID = S.CATEGORIA_ID ' +
      'WHERE S.ATIVO = 1';
    if FiltroActivo then
      SQL := SQL + ' AND UPPER(C.NOME) = UPPER(:CATEGORIA)';
    if Busca <> '' then
      SQL := SQL +
        ' AND (UPPER(S.NOME) CONTAINING UPPER(:BUSCA)' +
        ' OR UPPER(S.DESCRICAO) CONTAINING UPPER(:BUSCA))';
    SQL := SQL + ' ORDER BY S.ID';

    Query.SQL.Text := SQL;
    if FiltroActivo then
      Query.ParamByName('CATEGORIA').AsString := Filtro;
    if Busca <> '' then
      Query.ParamByName('BUSCA').AsString := Busca;
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

      // Imagem real do serviço (sobreposta ao fundo colorido do ícone)
      ImgServico := TImage.Create(RectIcone);
      ImgServico.Parent := RectIcone;
      ImgServico.Align := TAlignLayout.Client;
      ImgServico.WrapMode := TImageWrapMode.Stretch;
      ImgServico.HitTest := False;
      if FileExists(GetImagemPorCategoria(Categoria)) then
        ImgServico.Bitmap.LoadFromFile(GetImagemPorCategoria(Categoria));

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

      TabControlPrincipal.SetActiveTabWithTransition(TabClienteHome, TTabTransition.Slide, TTabTransitionDirection.Normal);
      CarregarServicos('');
      CarregarBannerOferta;
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
  else if Pos('EST', UpperCase(Categoria)) > 0 then
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
  lblPrecoServico.Text       := 'R$ ' + FormatFloat('0.00', Preco);
  lblTempoServico.Text       := IntToStr(DuracaoMin) + ' min';
  lblBadgeSelecionado.Text   := 'Selecionado';
  lblResumoBarbeiro.Text     := '-';
  lblResumoServico.Text      := Nome;
  lblResumoData.Text         := FormatDateTime('d "de" MMMM', FDataSelecionada);
  lblValorTotal.Text         := 'R$ ' + FormatFloat('0.00', Preco);

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
  if FServicoIDSelecionado = 0 then
  begin
    ShowMessage('Primeiro escolha um serviço na tela inicial antes de confirmar');
    Exit;
  end;

  Faltando := '';
  if FBarbeiroIDSelecionado = 0 then
    Faltando := 'barbeiro';
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

    FServicoIDSelecionado    := 0;
    FServicoNomeSelecionado  := '';
    FServicoPrecSelecionado  := 0;
    FServicoTempoSelecionado := 0;
    FDataSelecionada         := 0;
    FHoraSelecionada         := '';
    FBarbeiroIDSelecionado   := 0;
    FBarbeiroNomeSelecionado := '';

    lblNomeServicoAgendar.Text := '';
    lblPrecoServico.Text       := 'R$ 0,00';
    lblTempoServico.Text       := '-- min';
    lblResumoBarbeiro.Text     := '-';
    lblResumoServico.Text      := '';
    lblResumoData.Text         := '';
    lblValorTotal.Text         := '';

    CarregarHorarios;
    CarregarBarbeiros;
    CarregarServicos('');

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

function TFrmPrincipal.ValidarEmail(const Email: string): Boolean;
var
  AtPos: Integer;
begin
  AtPos := Pos('@', Email);
  Result := (AtPos > 1) and
            (Pos('.', Copy(Email, AtPos, Length(Email))) > 0);
end;

procedure TFrmPrincipal.rectBtnCadastrarClick(Sender: TObject);
var
  Query: TFDQuery;
  Nome, Email, Senha, Confirma: string;
begin
  Nome    := Trim(edtNomeCadastro.Text);
  Email   := Trim(edtEmailCadastro.Text);
  Senha   := edtSenhaCadastro.Text;
  Confirma := edtConfirmarSenha.Text;

  if Nome = '' then
  begin ShowMessage('Preencha o nome completo'); Exit; end;

  if not ValidarEmail(Email) then
  begin ShowMessage('E-mail inválido'); Exit; end;

  if Length(Senha) < 6 then
  begin ShowMessage('A senha deve ter pelo menos 6 caracteres'); Exit; end;

  if Senha <> Confirma then
  begin ShowMessage('As senhas não coincidem'); Exit; end;

  if not chkTermos.IsChecked then
  begin ShowMessage('Aceite os termos para continuar'); Exit; end;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT COUNT(*) FROM TB_USUARIOS WHERE EMAIL = :EMAIL';
    Query.ParamByName('EMAIL').AsString := Email;
    Query.Open;
    if Query.Fields[0].AsInteger > 0 then
    begin
      ShowMessage('Este e-mail já está registado');
      Exit;
    end;
    Query.Close;

    Query.SQL.Text :=
      'INSERT INTO TB_USUARIOS ' +
      '(NOME_COMPLETO, EMAIL, SENHA_HASH, PERFIL, ATIVO) ' +
      'VALUES (:NOME, :EMAIL, :SENHA, ''CLIENTE'', 1)';
    Query.ParamByName('NOME').AsString  := Nome;
    Query.ParamByName('EMAIL').AsString := Email;
    Query.ParamByName('SENHA').AsString := HashSenha(Senha);
    Query.ExecSQL;

    edtNomeCadastro.Text   := '';
    edtEmailCadastro.Text  := '';
    edtSenhaCadastro.Text  := '';
    edtConfirmarSenha.Text := '';
    chkTermos.IsChecked    := False;

    ShowMessage('Conta criada com sucesso! Faça login.');
    TabControlPrincipal.SetActiveTabWithTransition(
      TabLogin, TTabTransition.Slide, TTabTransitionDirection.Reversed);
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.rectBtnVoltarAgendarClick(Sender: TObject);
begin
  TabControlPrincipal.SetActiveTabWithTransition(TabClienteHome, TTabTransition.Slide, TTabTransitionDirection.Reversed);
  FServicoIDSelecionado    := 0;
  FBarbeiroIDSelecionado   := 0;
  FHoraSelecionada         := '';
  FDataSelecionada         := 0;
  lblNomeServicoAgendar.Text := 'Selecione um serviço';
  lblPrecoServico.Text       := 'R$ 0,00';
  lblTempoServico.Text       := '-- min';
  lblResumoServico.Text      := 'Nenhum serviço';
  lblResumoData.Text         := 'Data não selecionada';
  lblResumoBarbeiro.Text     := 'Barbeiro não selecionado';
  lblValorTotal.Text         := 'R$ 0,00';
  lblBadgeSelecionado.Text   := '';
  rectBadgeSelecionado.Visible := False;
end;

procedure TFrmPrincipal.lblVerTodosClick(Sender: TObject);
begin
  edtBusca.Text := '';
  AplicarFiltroCategoria('');
  scrollHome.ScrollBy(0, lytTituloServicos.Position.Y);
end;

procedure TFrmPrincipal.rectBtnAproveitarClick(Sender: TObject);
var
  Query: TFDQuery;
  PrecoComDesconto: Currency;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT ID, NOME, PRECO, DURACAO_MIN FROM TB_SERVICOS ' +
      'WHERE ATIVO = 1 AND BADGE <> '''' ' +
      'ORDER BY ID ROWS 1';
    Query.Open;
    if not Query.IsEmpty then
    begin
      PrecoComDesconto := Query.FieldByName('PRECO').AsCurrency * 0.80;
      AbrirAgendamento(
        Query.FieldByName('ID').AsInteger,
        Query.FieldByName('NOME').AsString,
        PrecoComDesconto,
        Query.FieldByName('DURACAO_MIN').AsInteger
      );
    end;
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.CarregarNotificacoes;
var
  Query: TFDQuery;
  I, CardCount: Integer;
  CardNotif: TRectangle;
  ImgIconeNotif: TImage;
  LblTexto, LblStatus: TLabel;
  StatusText: string;
  StatusColor: TAlphaColor;
  StartY: Single;
  IconePath: string;
begin
  for I := scrollNotificacoes.Content.ControlsCount - 1 downto 0 do
    if scrollNotificacoes.Content.Controls[I].Tag = 88 then
      scrollNotificacoes.Content.Controls[I].Free;

  Query := TFDQuery.Create(nil);
  CardCount := 0;
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT A.ID, S.NOME AS SERVICO, A.DT_AGENDAMENTO, ' +
      '       A.HR_INICIO, A.STATUS ' +
      'FROM TB_AGENDAMENTOS A ' +
      'JOIN TB_SERVICOS S ON S.ID = A.SERVICO_ID ' +
      'WHERE A.CLIENTE_ID = :ID ' +
      'ORDER BY A.DT_AGENDAMENTO DESC, A.HR_INICIO DESC ' +
      'ROWS 10';
    Query.ParamByName('ID').AsInteger := 1; // hardcoded até sessão implementada
    Query.Open;

    IconePath := TPath.Combine(
      TPath.Combine(ExtractFilePath(ParamStr(0)), '..\..\..'),
      'docs\images\iconamoon--notification.png');

    StartY := 8;
    while not Query.EOF do
    begin
      StatusText := Query.FieldByName('STATUS').AsString;

      if StatusText = 'CONCLUIDO' then
        StatusColor := $FF22C55E
      else if StatusText = 'CANCELADO' then
        StatusColor := $FFEF4444
      else if StatusText = 'EM_ANDAMENTO' then
        StatusColor := $FF3B82F6
      else // PENDENTE
        StatusColor := $FFF58A00;

      CardNotif := TRectangle.Create(scrollNotificacoes);
      CardNotif.Parent := scrollNotificacoes;
      CardNotif.Tag := 88;
      CardNotif.Align := TAlignLayout.None;
      CardNotif.Position.X := 10;
      CardNotif.Position.Y := StartY + CardCount * 90;
      CardNotif.Width := scrollNotificacoes.Width - 20;
      CardNotif.Height := 80;
      CardNotif.Fill.Color := $FF1E293B;
      CardNotif.Stroke.Color := $FF2D3F55;
      CardNotif.XRadius := 12;
      CardNotif.YRadius := 12;
      CardNotif.HitTest := False;

      ImgIconeNotif := TImage.Create(CardNotif);
      ImgIconeNotif.Parent := CardNotif;
      ImgIconeNotif.Position.X := 14;
      ImgIconeNotif.Position.Y := 18;
      ImgIconeNotif.Width := 28;
      ImgIconeNotif.Height := 28;
      ImgIconeNotif.WrapMode := TImageWrapMode.Fit;
      ImgIconeNotif.HitTest := False;
      ImgIconeNotif.Tag := 88;
      if FileExists(IconePath) then
        ImgIconeNotif.Bitmap.LoadFromFile(IconePath);

      LblTexto := TLabel.Create(CardNotif);
      LblTexto.Parent := CardNotif;
      LblTexto.Position.X := 50;
      LblTexto.Position.Y := 12;
      LblTexto.Width := CardNotif.Width - 60;
      LblTexto.Height := 32;
      LblTexto.StyledSettings := [];
      LblTexto.TextSettings.Font.Size := 12;
      LblTexto.TextSettings.FontColor := $FFFFFFFF;
      LblTexto.WordWrap := False;
      LblTexto.Text := Query.FieldByName('SERVICO').AsString + ' · ' +
        FormatDateTime('dd/mm', Query.FieldByName('DT_AGENDAMENTO').AsDateTime) +
        ' às ' + Query.FieldByName('HR_INICIO').AsString;
      LblTexto.HitTest := False;

      LblStatus := TLabel.Create(CardNotif);
      LblStatus.Parent := CardNotif;
      LblStatus.Position.X := 50;
      LblStatus.Position.Y := 50;
      LblStatus.Width := 120;
      LblStatus.Height := 20;
      LblStatus.StyledSettings := [];
      LblStatus.TextSettings.Font.Size := 10;
      LblStatus.TextSettings.FontColor := StatusColor;
      LblStatus.Text := StatusText;
      LblStatus.HitTest := False;

      Inc(CardCount);
      Query.Next;
    end;

    scrollNotificacoes.Content.Height := StartY + CardCount * 90 + 8;
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.imgNotificacaoClick(Sender: TObject);
begin
  CarregarNotificacoes;
  rectOverlayNotif.Visible := True;
  rectOverlayNotif.BringToFront;
end;

procedure TFrmPrincipal.lblFecharNotifClick(Sender: TObject);
begin
  rectOverlayNotif.Visible := False;
end;

procedure TFrmPrincipal.CarregarBannerOferta;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT NOME, DESCRICAO, BADGE FROM TB_SERVICOS ' +
      'WHERE ATIVO = 1 AND BADGE <> '''' ' +
      'ORDER BY ID ROWS 1';
    Query.Open;
    if not Query.IsEmpty then
    begin
      lblTituloOferta.StyledSettings := [];
      lblTituloOferta.Text := Query.FieldByName('NOME').AsString + ' com 20% de desconto';
      lblSubtituloOferta.StyledSettings := [];
      lblSubtituloOferta.Text := 'Oferta da Semana';
    end;
  finally
    Query.Free;
  end;
end;

procedure TFrmPrincipal.edtBuscaChange(Sender: TObject);
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
  if edtBusca.Text = '' then
    CarregarServicos(FFiltroCategoria)
  else
  begin
    ResetarBotao(rectFiltroTodos,    lblFiltroTodos);
    ResetarBotao(rectFiltroCabelo,   lblFiltroCabelo);
    ResetarBotao(rectFiltroBarba,    lblFiltroBarba);
    ResetarBotao(rectFiltroEstetica, lblFiltroEstetica);
    AtivarBotao(rectFiltroTodos, lblFiltroTodos);
    CarregarServicos('', edtBusca.Text);
  end;
end;

end.
