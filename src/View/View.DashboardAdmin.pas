unit View.DashboardAdmin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmDashboardAdmin = class(TForm)
    rectFundoDashboard: TRectangle;
    rectMenuLateral: TRectangle;
    lytLogoAdmin: TLayout;
    rectIconeLogo: TRectangle;
    lytTextosLogo: TLayout;
    lblNomeLogo: TLabel;
    lblSubLogo: TLabel;
    lytBotoesMenu: TLayout;
    lblSecaoPrincipal: TLabel;
    rectMenuInicio: TRectangle;
    lblMenuInicio: TLabel;
    lblSecaoGerenciar: TLabel;
    rectMenuAgenda: TRectangle;
    lblMenuAgenda: TLabel;
    lblSetaAgenda: TLabel;
    rectMenuServicos: TRectangle;
    lblMenuServicos: TLabel;
    rectMenuClientes: TRectangle;
    lblMenuClientes: TLabel;
    rectMenuFinanceiro: TRectangle;
    lblMenuFinanceiro: TLabel;
    lytRodapeMenu: TLayout;
    rectMenuConfig: TRectangle;
    lblMenuConfig: TLabel;
    rectMenuSair: TRectangle;
    lblMenuSair: TLabel;
    lytAreaPrincipal: TLayout;
    lytHeaderDashboard: TLayout;
    lytTitulosDash: TLayout;
    lblTituloDash: TLabel;
    lblDataDash: TLabel;
    lytAcoesDash: TLayout;
    circleAdmin: TCircle;
    lytTextosAdmin: TLayout;
    lblAdminNome: TLabel;
    lblAdminCargo: TLabel;
    circleSino: TCircle;
    rectBuscaAdmin: TRectangle;
    edtBuscaAdmin: TEdit;
    scrollDashboard: TVertScrollBox;
    gridCardsKPI: TGridPanelLayout;
    lytContainerFaturamento: TLayout;
    rectKpiFaturamento: TRectangle;
    lytTopFaturamento: TLayout;
    lblTitFaturamento: TLabel;
    lblValFaturamento: TLabel;
    lblSubFaturamento: TLabel;
    lytContainerAgendamentos: TLayout;
    rectKpiAgendamentos: TRectangle;
    lytTopAgendamentos: TLayout;
    lblTitAgendamentos: TLabel;
    lblValAgendamentos: TLabel;
    lblSubAgendamentos: TLabel;
    lytContainerPendentes: TLayout;
    rectKpiPendentes: TRectangle;
    lytTopPendentes: TLayout;
    lblTitPendentes: TLabel;
    lblValPendentes: TLabel;
    lblSubPendentes: TLabel;
    lytContainerCancelamentos: TLayout;
    rectKpiCancelamentos: TRectangle;
    lytTopCancelamentos: TLayout;
    lblTitCancelamentos: TLabel;
    lblValCancelamentos: TLabel;
    lblSubCancelamentos: TLabel;
    lytCorpoDashboard: TLayout;
    lytColunaDireita: TLayout;
    lytColunaEsquerda: TLayout;
    rectFundoLinhaTempo: TRectangle;
    lytHeaderAgenda: TLayout;
    lytTitulosAgenda: TLayout;
    lblTitLinhaTempo: TLabel;
    lblSubLinhaTempo: TLabel;
    lytLegendaAgenda: TLayout;
    lytLegConcluido: TLayout;
    circleLegConcluido: TCircle;
    lblLegConcluido: TLabel;
    lytLegAgendamento: TLayout;
    circleLegAgendamento: TCircle;
    lblLegAgendamento: TLabel;
    lytLegPendente: TLayout;
    circleLegPendente: TCircle;
    lblLegPendente: TLabel;
    scrollLinhaTempo: TVertScrollBox;
    lytCardAgendamento1: TLayout;
    lytHoraAgendamento1: TLayout;
    lblHoraInicio1: TLabel;
    lblHoraFim1: TLabel;
    rectFundoAgendamento1: TRectangle;
    circleFotoCliente1: TCircle;
    Label2: TLabel;
    lytTextosAgendamento1: TLayout;
    lblNomeCliente1: TLabel;
    lblNomeProfissional1: TLabel;
    lytValoresAgendamento1: TLayout;
    lblPrecoServico1: TLabel;
    rectBadgeStatus1: TRectangle;
    lblTextoStatus1: TLabel;
    lytCardAgendamento4: TLayout;
    lytHoraAgendamento4: TLayout;
    lblHoraInicio4: TLabel;
    lblHoraFim4: TLabel;
    rectFundoAgendamento4: TRectangle;
    circleFotoCliente4: TCircle;
    Label5: TLabel;
    lytTextosAgendamento4: TLayout;
    lblNomeCliente4: TLabel;
    lblNomeProfissional4: TLabel;
    lytValoresAgendamento4: TLayout;
    lblPrecoServico4: TLabel;
    rectBadgeStatus4: TRectangle;
    lblTextoStatus4: TLabel;
    lytCardAgendamento3: TLayout;
    lytHoraAgendamento3: TLayout;
    lblHoraInicio3: TLabel;
    lblHoraFim3: TLabel;
    rectFundoAgendamento3: TRectangle;
    circleFotoCliente3: TCircle;
    Label12: TLabel;
    lytTextosAgendamento3: TLayout;
    lblNomeCliente3: TLabel;
    lblNomeProfissional3: TLabel;
    lytValoresAgendamento3: TLayout;
    lblPrecoServico3: TLabel;
    rectBadgeStatus3: TRectangle;
    lblTextoStatus3: TLabel;
    lytCardAgendamento2: TLayout;
    lytHoraAgendamento2: TLayout;
    lblHoraInicio2: TLabel;
    lblHoraFim2: TLabel;
    rectFundoAgendamento2: TRectangle;
    circleFotoCliente2: TCircle;
    Label19: TLabel;
    lytTextosAgendamento2: TLayout;
    lblNomeCliente2: TLabel;
    lblNomeProfissional2: TLabel;
    lytValoresAgendamento2: TLayout;
    lblPrecoServico2: TLabel;
    rectBadgeStatus2: TRectangle;
    lblStatus2: TLabel;
    rectCardResumoFin: TRectangle;
    lytHeaderResumoFin: TLayout;
    lblTitResumoFin: TLabel;
    lytBlocoFaturado: TLayout;
    rectBtnHojeResumo: TRectangle;
    lblBtnHojeResumo: TLabel;
    lytTitFaturado: TLayout;
    lblTxtFaturamento: TLabel;
    lblBadgeCrescimento: TLabel;
    lblValFaturamentoPrincipal: TLabel;
    lblSubFaturamentoMeta: TLabel;
    rectFundoBarraMeta: TRectangle;
    rectProgressoMeta: TRectangle;
    gridEstatisticas: TGridPanelLayout;
    lytCellConcluidos: TLayout;
    rectCardConcluidos: TRectangle;
    lytTitGridConcluidos: TLayout;
    lblTitGridConcluidos: TLabel;
    lblValConcluidos: TLabel;
    lblSubConcluidos: TLabel;
    lytCellPendentes: TLayout;
    rectCardPendentes: TRectangle;
    lytTitGridPendentes: TLayout;
    lblTitGridPendentes: TLabel;
    lblValorPendentes: TLabel;
    lblSubTituloPendentes: TLabel;
    circleIconGrid2: TCircle;
    circleIconGrid1: TCircle;
    lytCellTicket: TLayout;
    rectCardTicket: TRectangle;
    lytTitGridTicket: TLayout;
    lblTitGridTicket: TLabel;
    circleIconGrid3: TCircle;
    lblValTickets: TLabel;
    lblSubTickets: TLabel;
    lytCellCancelamentos: TLayout;
    rectCardCancelamentos: TRectangle;
    lytTitGirdCancelamentos: TLayout;
    lblTitGridCancelamentos: TLabel;
    circleIconGridCancelamentos: TCircle;
    lblValorCancelamentos: TLabel;
    lblSubTituloCancelamentos: TLabel;
    rectCardGrafico: TRectangle;
    lblTitGrafico: TLabel;
    lytRodapeGrafico: TLayout;
    lblTotalGrafico: TLabel;
    lblLinkGrafico: TLabel;
    lytAreaBarras: TLayout;
    lytColunaSeg: TLayout;
    lblDiaSeg: TLabel;
    rectBarraSeg: TRectangle;
    LytColunaDom: TLayout;
    lblDiaDom: TLabel;
    rectBarraDom: TRectangle;
    lytColunaSab: TLayout;
    lblDiaSab: TLabel;
    rectBarraSab: TRectangle;
    lytColunaSex: TLayout;
    lblDiaSex: TLabel;
    rectBarraSex: TRectangle;
    lytColunaQui: TLayout;
    lblDiaQui: TLabel;
    rectBarraQui: TRectangle;
    lytColunaQuar: TLayout;
    lblDiaQuar: TLabel;
    rectBarraQuar: TRectangle;
    lytColunaTer: TLayout;
    lblDiaTer: TLabel;
    rectBarraTer: TRectangle;
    imgIconeLogoDash: TImage;
    imgIconeBuscaDash: TImage;
    imgIconeNotificacaoDash: TImage;
    imgIconePerfilDash: TImage;
    imgIconeMenuInicioDash: TImage;
    imgIconeMenuAgendaDash: TImage;
    imgIconeMenuServicoDash: TImage;
    imgIconeMenuUsuariosDash: TImage;
    imgIconeMenuFinanDash: TImage;
    imgIconeMenuConfigDash: TImage;
    imgIconeMenuSairDash: TImage;
    rectIconeFaturamento: TRectangle;
    imgIconeFaturamento: TImage;
    rectIconeAgendamentos: TRectangle;
    imgIconeAgendamento: TImage;
    rectIconePendentes: TRectangle;
    imgIconePendentes: TImage;
    rectIconeCancelamentos: TRectangle;
    imgIconeCancelamentos: TImage;
    lytNavData: TLayout;
    rectSetaAnteriorAgenda: TRectangle;
    imgSetaAnteriorAgenda: TImage;
    lblDataAgenda: TLabel;
    rectSetaProximaAgenda: TRectangle;
    imgSetaProximaAgenda: TImage;
    rectOverlayNotifDash: TRectangle;
    rectPainelNotifDash: TRectangle;
    lblTituloNotifDash: TLabel;
    lblFecharNotifDash: TLabel;
    scrollNotifDash: TVertScrollBox;
    rectOverlayRelatorio: TRectangle;
    lytHeaderRelatorio: TLayout;
    rectBtnVoltarRel: TRectangle;
    lblBtnVoltarRel: TLabel;
    lblTituloRelatorio: TLabel;
    scrollRelatorio: TVertScrollBox;
    procedure rectMenuServicosClick(Sender: TObject);
    procedure rectMenuInicioClick(Sender: TObject);
    procedure rectMenuSairClick(Sender: TObject);
    procedure rectMenuAgendaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rectSetaAnteriorAgendaClick(Sender: TObject);
    procedure rectSetaProximaAgendaClick(Sender: TObject);
    procedure circleSinoClick(Sender: TObject);
    procedure lblFecharNotifDashClick(Sender: TObject);
    procedure edtBuscaAdminChange(Sender: TObject);
    procedure rectBtnVoltarRelClick(Sender: TObject);
    procedure lblLinkGraficoClick(Sender: TObject);
  private
    FDataAgenda: TDate;
    procedure AtualizarKPIs;
    procedure CarregarLinhaTempo;
    procedure AtualizarMenuLateral(const ItemAtivo: string);
    procedure AtualizarDataAgenda;
    procedure CarregarIconesSetas;
    procedure CarregarNotificacoesDash;
    procedure AtualizarGraficoSemanal;
    procedure CarregarRelatorioSemanal;
  public
    { Public declarations }
  end;

var
  FrmDashboardAdmin: TFrmDashboardAdmin;

implementation

{$R *.fmx}

uses View.Frame.Servicos, View.Principal,
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  System.DateUtils, System.IOUtils;

procedure TFrmDashboardAdmin.FormShow(Sender: TObject);
begin
  AtualizarMenuLateral('inicio');
  lblDataDash.StyledSettings := [];
  lblDataDash.Text := FormatDateTime('dddd, d "de" MMMM "de" yyyy', Now);
  FDataAgenda := Date;
  CarregarIconesSetas;
  AtualizarDataAgenda;
  AtualizarKPIs;
  CarregarLinhaTempo;
  AtualizarGraficoSemanal;
end;

procedure TFrmDashboardAdmin.AtualizarKPIs;
var
  Query: TFDQuery;
  Concluidos: Integer;
  TicketMedio: Currency;
  QOntem: TFDQuery;
  FatOntem, FatHoje, Meta: Currency;
  Crescimento, PctMeta: Double;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT ' +
      '  COUNT(*) AS TOTAL, ' +
      '  SUM(CASE WHEN STATUS = ''CONCLUIDO'' THEN 1 ELSE 0 END) AS CONCLUIDOS, ' +
      '  SUM(CASE WHEN STATUS = ''PENDENTE'' THEN 1 ELSE 0 END) AS PENDENTES, ' +
      '  SUM(CASE WHEN STATUS = ''CANCELADO'' THEN 1 ELSE 0 END) AS CANCELADOS, ' +
      '  SUM(CASE WHEN STATUS = ''CONCLUIDO'' THEN VALOR_COBRADO ELSE 0 END) AS FATURAMENTO ' +
      'FROM TB_AGENDAMENTOS ' +
      'WHERE DT_AGENDAMENTO = :DATA';
    Query.ParamByName('DATA').AsDate := FDataAgenda;
    Query.Open;

    lblValFaturamento.StyledSettings := [];
    lblValFaturamento.Text := 'R$ ' + FormatFloat('0.00',
      Query.FieldByName('FATURAMENTO').AsFloat);

    lblValAgendamentos.StyledSettings := [];
    lblValAgendamentos.Text := Query.FieldByName('TOTAL').AsString;

    lblValPendentes.StyledSettings := [];
    lblValPendentes.Text := Query.FieldByName('PENDENTES').AsString;

    lblValCancelamentos.StyledSettings := [];
    lblValCancelamentos.Text := Query.FieldByName('CANCELADOS').AsString;

    lblSubAgendamentos.StyledSettings := [];
    lblSubAgendamentos.Text := Query.FieldByName('CONCLUIDOS').AsString + ' concluídos';

    lblSubPendentes.StyledSettings := [];
    lblSubPendentes.Text := 'Aguardando atendimento';

    lblSubCancelamentos.StyledSettings := [];
    lblSubCancelamentos.Text := 'Hoje';

    var SubTexto: string;
    if Trunc(FDataAgenda) = Trunc(Date) then
      SubTexto := 'Hoje'
    else
      SubTexto := FormatDateTime('dd/mm', FDataAgenda);
    lblSubLinhaTempo.StyledSettings := [];
    lblSubLinhaTempo.Text :=
      IntToStr(Query.FieldByName('TOTAL').AsInteger) +
      ' Agendamento(s) em ' + SubTexto;

    Concluidos := Query.FieldByName('CONCLUIDOS').AsInteger;

    lblValConcluidos.StyledSettings := [];
    lblValConcluidos.Text := IntToStr(Concluidos);

    lblValorPendentes.StyledSettings := [];
    lblValorPendentes.Text := IntToStr(Query.FieldByName('PENDENTES').AsInteger);

    lblValorCancelamentos.StyledSettings := [];
    lblValorCancelamentos.Text := IntToStr(Query.FieldByName('CANCELADOS').AsInteger);

    if Concluidos > 0 then
      TicketMedio := Query.FieldByName('FATURAMENTO').AsCurrency / Concluidos
    else
      TicketMedio := 0;
    lblValTickets.StyledSettings := [];
    lblValTickets.Text := 'R$ ' + FormatFloat('#,##0.00', TicketMedio);

    lblValFaturamentoPrincipal.StyledSettings := [];
    lblValFaturamentoPrincipal.Text := 'R$ ' +
      FormatFloat('#,##0.00', Query.FieldByName('FATURAMENTO').AsCurrency);

    lblBtnHojeResumo.StyledSettings := [];
    if Trunc(FDataAgenda) = Trunc(Date) then
      lblBtnHojeResumo.Text := 'Hoje'
    else if Trunc(FDataAgenda) = Trunc(Date - 1) then
      lblBtnHojeResumo.Text := 'Ontem'
    else
      lblBtnHojeResumo.Text := FormatDateTime('dd/mm', FDataAgenda);

    FatHoje := Query.FieldByName('FATURAMENTO').AsCurrency;

    QOntem := TFDQuery.Create(nil);
    try
      QOntem.Connection := dmConexao.FDConnection1;
      QOntem.SQL.Text :=
        'SELECT SUM(CASE WHEN STATUS = ''CONCLUIDO'' ' +
        'THEN VALOR_COBRADO ELSE 0 END) AS FAT_ONTEM ' +
        'FROM TB_AGENDAMENTOS ' +
        'WHERE DT_AGENDAMENTO = :DATA';
      QOntem.ParamByName('DATA').AsDate := FDataAgenda - 1;
      QOntem.Open;
      FatOntem := QOntem.Fields[0].AsCurrency;
    finally
      QOntem.Free;
    end;

    lblBadgeCrescimento.StyledSettings := [];
    if FatOntem > 0 then
    begin
      Crescimento := ((FatHoje - FatOntem) / FatOntem) * 100;
      if Crescimento >= 0 then
        lblBadgeCrescimento.Text :=
          '+' + FormatFloat('0.0', Crescimento) + '% vs. Dia Ant.'
      else
        lblBadgeCrescimento.Text :=
          FormatFloat('0.0', Crescimento) + '% vs. Dia Ant.';
    end
    else if FatHoje > 0 then
      lblBadgeCrescimento.Text := 'Novo faturamento'
    else
      lblBadgeCrescimento.Text := 'Sem faturamento';

    Meta := 430.00;
    lblSubFaturamentoMeta.StyledSettings := [];
    if Meta > 0 then
    begin
      PctMeta := (FatHoje / Meta) * 100;
      lblSubFaturamentoMeta.Text :=
        FormatFloat('0', PctMeta) +
        '% da meta diária (R$' +
        FormatFloat('#,##0.00', Meta) + ')';
    end
    else
      lblSubFaturamentoMeta.Text := 'Meta não definida';
  finally
    Query.Free;
  end;
end;

procedure TFrmDashboardAdmin.CarregarLinhaTempo;
var
  Query: TFDQuery;
  I: Integer;
  Card: TLayout;
  RectCorpo, RectBadge: TRectangle;
  LblHrInicio, LblHrFim, LblCliente, LblBarbeiro,
  LblServico, LblPreco, LblBadge: TLabel;
  Status, TextoBadge, Busca: string;
  CorFundo, CorBadge: TAlphaColor;
  CardWidth: Single;
begin
  // Oculta os 4 cards estáticos
  lytCardAgendamento1.Visible := False;
  lytCardAgendamento2.Visible := False;
  lytCardAgendamento3.Visible := False;
  lytCardAgendamento4.Visible := False;

  // Limpa cards dinâmicos anteriores (Tag=95)
  for I := scrollLinhaTempo.Content.ControlsCount - 1 downto 0 do
    if (scrollLinhaTempo.Content.Controls[I] is TLayout) and
       (scrollLinhaTempo.Content.Controls[I].Tag = 95) then
      scrollLinhaTempo.Content.Controls[I].Free;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT A.ID, A.HR_INICIO, A.HR_FIM, A.STATUS, A.VALOR_COBRADO, ' +
      '       U.NOME_COMPLETO AS CLIENTE, ' +
      '       UB.NOME_COMPLETO AS BARBEIRO, ' +
      '       S.NOME AS SERVICO ' +
      'FROM TB_AGENDAMENTOS A ' +
      'INNER JOIN TB_USUARIOS U ON U.ID = A.CLIENTE_ID ' +
      'INNER JOIN TB_BARBEIROS B ON B.ID = A.BARBEIRO_ID ' +
      'INNER JOIN TB_USUARIOS UB ON UB.ID = B.USUARIO_ID ' +
      'INNER JOIN TB_SERVICOS S ON S.ID = A.SERVICO_ID ' +
      'WHERE A.DT_AGENDAMENTO = :DATA';
    Busca := Trim(edtBuscaAdmin.Text);
    if Busca <> '' then
      Query.SQL.Text := Query.SQL.Text +
        ' AND (UPPER(U.NOME_COMPLETO) CONTAINING UPPER(:BUSCA)' +
        ' OR UPPER(S.NOME) CONTAINING UPPER(:BUSCA))';
    Query.SQL.Text := Query.SQL.Text + ' ORDER BY A.HR_INICIO';
    Query.ParamByName('DATA').AsDate := FDataAgenda;
    if Busca <> '' then
      Query.ParamByName('BUSCA').AsString := Busca;
    Query.Open;

    CardWidth := scrollLinhaTempo.Width - 16;

    while not Query.EOF do
    begin
      Status := Query.FieldByName('STATUS').AsString;

      // Define cores por status
      if Status = 'CONCLUIDO' then
      begin
        CorFundo := $FF0D2B1A; CorBadge := $FF16A34A; TextoBadge := 'Concluído';
      end
      else if Status = 'EM_ANDAMENTO' then
      begin
        CorFundo := $FF2B1E0A; CorBadge := $FFF58A00; TextoBadge := 'Em andamento';
      end
      else if Status = 'CANCELADO' then
      begin
        CorFundo := $FF2B0A0A; CorBadge := $FFDC2626; TextoBadge := 'Cancelado';
      end
      else // PENDENTE
      begin
        CorFundo := $FF0A1A2B; CorBadge := $FF3B82F6; TextoBadge := 'Pendente';
      end;

      // Card container (TLayout)
      Card := TLayout.Create(scrollLinhaTempo);
      Card.Parent := scrollLinhaTempo;
      Card.Tag := 95;
      Card.Height := 80;
      Card.Align := TAlignLayout.Top;
      Card.Margins.Bottom := 8;
      Card.HitTest := False;

      // Hora início
      LblHrInicio := TLabel.Create(Card);
      LblHrInicio.Parent := Card;
      LblHrInicio.Position.X := 0;
      LblHrInicio.Position.Y := 10;
      LblHrInicio.Width := 52;
      LblHrInicio.Text := Query.FieldByName('HR_INICIO').AsString;
      LblHrInicio.StyledSettings := [];
      LblHrInicio.TextSettings.Font.Size := 12;
      LblHrInicio.TextSettings.FontColor := $FF94A3B8;
      LblHrInicio.TextSettings.HorzAlign := TTextAlign.Center;
      LblHrInicio.HitTest := False;

      // Hora fim
      LblHrFim := TLabel.Create(Card);
      LblHrFim.Parent := Card;
      LblHrFim.Position.X := 0;
      LblHrFim.Position.Y := 28;
      LblHrFim.Width := 52;
      LblHrFim.Text := Query.FieldByName('HR_FIM').AsString;
      LblHrFim.StyledSettings := [];
      LblHrFim.TextSettings.Font.Size := 11;
      LblHrFim.TextSettings.FontColor := $FF4A5568;
      LblHrFim.TextSettings.HorzAlign := TTextAlign.Center;
      LblHrFim.HitTest := False;

      // Corpo do card
      RectCorpo := TRectangle.Create(Card);
      RectCorpo.Parent := Card;
      RectCorpo.Position.X := 56;
      RectCorpo.Position.Y := 0;
      RectCorpo.Width := CardWidth - 56;
      RectCorpo.Height := 72;
      RectCorpo.Fill.Color := CorFundo;
      RectCorpo.Stroke.Kind := TBrushKind.None;
      RectCorpo.XRadius := 10;
      RectCorpo.YRadius := 10;
      RectCorpo.HitTest := False;

      // Nome cliente
      LblCliente := TLabel.Create(RectCorpo);
      LblCliente.Parent := RectCorpo;
      LblCliente.Position.X := 12;
      LblCliente.Position.Y := 8;
      LblCliente.Width := RectCorpo.Width - 100;
      LblCliente.Text := Query.FieldByName('CLIENTE').AsString;
      LblCliente.StyledSettings := [];
      LblCliente.TextSettings.Font.Size := 13;
      LblCliente.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblCliente.TextSettings.FontColor := $FFFFFFFF;
      LblCliente.HitTest := False;

      // Barbeiro
      LblBarbeiro := TLabel.Create(RectCorpo);
      LblBarbeiro.Parent := RectCorpo;
      LblBarbeiro.Position.X := 12;
      LblBarbeiro.Position.Y := 27;
      LblBarbeiro.Width := RectCorpo.Width - 100;
      LblBarbeiro.Text := 'com ' + Query.FieldByName('BARBEIRO').AsString;
      LblBarbeiro.StyledSettings := [];
      LblBarbeiro.TextSettings.Font.Size := 11;
      LblBarbeiro.TextSettings.FontColor := $FF94A3B8;
      LblBarbeiro.HitTest := False;

      // Serviço
      LblServico := TLabel.Create(RectCorpo);
      LblServico.Parent := RectCorpo;
      LblServico.Position.X := 12;
      LblServico.Position.Y := 43;
      LblServico.Width := RectCorpo.Width - 100;
      LblServico.Text := Query.FieldByName('SERVICO').AsString;
      LblServico.StyledSettings := [];
      LblServico.TextSettings.Font.Size := 11;
      LblServico.TextSettings.FontColor := $FF64748B;
      LblServico.HitTest := False;

      // Preço
      LblPreco := TLabel.Create(RectCorpo);
      LblPreco.Parent := RectCorpo;
      LblPreco.Position.X := RectCorpo.Width - 88;
      LblPreco.Position.Y := 43;
      LblPreco.Width := 80;
      LblPreco.Text := 'R$ ' + FormatFloat('0.00',
        Query.FieldByName('VALOR_COBRADO').AsFloat);
      LblPreco.StyledSettings := [];
      LblPreco.TextSettings.Font.Size := 13;
      LblPreco.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblPreco.TextSettings.FontColor := $FFF58A00;
      LblPreco.TextSettings.HorzAlign := TTextAlign.Trailing;
      LblPreco.HitTest := False;

      // Badge de status
      RectBadge := TRectangle.Create(RectCorpo);
      RectBadge.Parent := RectCorpo;
      RectBadge.Width := 86;
      RectBadge.Height := 20;
      RectBadge.Position.X := RectCorpo.Width - 94;
      RectBadge.Position.Y := 8;
      RectBadge.Fill.Color := CorBadge;
      RectBadge.Stroke.Kind := TBrushKind.None;
      RectBadge.XRadius := 6;
      RectBadge.YRadius := 6;
      RectBadge.HitTest := False;

      LblBadge := TLabel.Create(RectBadge);
      LblBadge.Parent := RectBadge;
      LblBadge.Align := TAlignLayout.Client;
      LblBadge.Text := TextoBadge;
      LblBadge.StyledSettings := [];
      LblBadge.TextSettings.Font.Size := 10;
      LblBadge.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblBadge.TextSettings.FontColor := $FFFFFFFF;
      LblBadge.TextSettings.HorzAlign := TTextAlign.Center;
      LblBadge.HitTest := False;

      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TFrmDashboardAdmin.rectMenuInicioClick(Sender: TObject);
var
  I: Integer;
begin
  AtualizarMenuLateral('inicio');

  for I := lytAreaPrincipal.ControlsCount - 1 downto 0 do
  begin
    if lytAreaPrincipal.Controls[I] is TFrame then
      lytAreaPrincipal.Controls[I].Free;
  end;

  lytHeaderDashboard.Visible := True;
  scrollDashboard.Visible := True;

end;

procedure TFrmDashboardAdmin.rectMenuSairClick(Sender: TObject);
begin
  FrmPrincipal.LimparSessao;
  Self.Hide;
  FrmPrincipal.TabControlPrincipal.ActiveTab := FrmPrincipal.TabLogin;
  FrmPrincipal.Show;
end;

procedure TFrmDashboardAdmin.rectMenuServicosClick(Sender: TObject);
var
  FrameServicos: TFrameServicos;
  I: Integer;
begin
  AtualizarMenuLateral('servicos');

  for I := lytAreaPrincipal.ControlsCount - 1 downto 0 do
    if lytAreaPrincipal.Controls[I] is TFrame then
      lytAreaPrincipal.Controls[I].Free;

  scrollDashboard.Visible := False;
  lytHeaderDashboard.Visible := False;

  FrameServicos := TFrameServicos.Create(Self);
  FrameServicos.Parent := lytAreaPrincipal;
  FrameServicos.Align := TAlignLayout.Client;

end;

procedure TFrmDashboardAdmin.AtualizarMenuLateral(const ItemAtivo: string);

  procedure SetAtivo(Rect: TRectangle; Lbl: TLabel; Seta: TLabel = nil);
  begin
    Rect.Fill.Color := $FF1E293B;
    Rect.Fill.Kind := TBrushKind.Solid;
    Rect.Stroke.Color := $FFF58A00;
    Rect.Stroke.Kind := TBrushKind.Solid;
    Rect.XRadius := 8;
    Rect.YRadius := 8;
    Lbl.StyledSettings := [];
    Lbl.TextSettings.FontColor := $FFF58A00;
    if Seta <> nil then
    begin
      Seta.StyledSettings := [];
      Seta.TextSettings.FontColor := $FFF58A00;
      Seta.Text := '>';
    end;
  end;

  procedure SetInativo(Rect: TRectangle; Lbl: TLabel; Seta: TLabel = nil);
  begin
    Rect.Fill.Kind := TBrushKind.None;
    Rect.Stroke.Kind := TBrushKind.None;
    Rect.XRadius := 0;
    Rect.YRadius := 0;
    Lbl.StyledSettings := [];
    Lbl.TextSettings.FontColor := $FFFFFFFF;
    if Seta <> nil then
      Seta.Text := '';
  end;

begin
  if ItemAtivo = 'inicio' then SetAtivo(rectMenuInicio, lblMenuInicio)
  else SetInativo(rectMenuInicio, lblMenuInicio);

  if ItemAtivo = 'agenda' then SetAtivo(rectMenuAgenda, lblMenuAgenda)
  else SetInativo(rectMenuAgenda, lblMenuAgenda);

  if ItemAtivo = 'servicos' then SetAtivo(rectMenuServicos, lblMenuServicos)
  else SetInativo(rectMenuServicos, lblMenuServicos);

  if ItemAtivo = 'clientes' then SetAtivo(rectMenuClientes, lblMenuClientes)
  else SetInativo(rectMenuClientes, lblMenuClientes);

  if ItemAtivo = 'financeiro' then SetAtivo(rectMenuFinanceiro, lblMenuFinanceiro)
  else SetInativo(rectMenuFinanceiro, lblMenuFinanceiro);

  if ItemAtivo = 'configuracoes' then SetAtivo(rectMenuConfig, lblMenuConfig)
  else SetInativo(rectMenuConfig, lblMenuConfig);
end;

procedure TFrmDashboardAdmin.rectMenuAgendaClick(Sender: TObject);
begin
  AtualizarMenuLateral('agenda');
end;

procedure TFrmDashboardAdmin.CarregarIconesSetas;
var
  BaseDir, IconeEsq, IconeDir: string;
begin
  BaseDir := TPath.Combine(ExtractFilePath(ParamStr(0)), '..\..\..');
  IconeEsq := TPath.Combine(BaseDir,
    'docs\images\iconamoon--arrow-left-2-light.png');
  IconeDir := TPath.Combine(BaseDir,
    'docs\images\iconamoon--arrow-right-2-light.png');
  if FileExists(IconeEsq) then
    imgSetaAnteriorAgenda.Bitmap.LoadFromFile(IconeEsq);
  if FileExists(IconeDir) then
    imgSetaProximaAgenda.Bitmap.LoadFromFile(IconeDir);
end;

procedure TFrmDashboardAdmin.AtualizarDataAgenda;
begin
  lblDataAgenda.StyledSettings := [];
  lblDataAgenda.TextSettings.FontColor := $FFF58A00;
  if Trunc(FDataAgenda) = Trunc(Date) then
    lblDataAgenda.Text := 'Hoje'
  else if Trunc(FDataAgenda) = Trunc(Date - 1) then
    lblDataAgenda.Text := 'Ontem'
  else
    lblDataAgenda.Text := FormatDateTime('dd/mm/yyyy', FDataAgenda);

  if Trunc(FDataAgenda) < Trunc(Date) then
    rectSetaProximaAgenda.Fill.Color := $FF1E293B
  else
    rectSetaProximaAgenda.Fill.Color := $FF0B1220;
end;

procedure TFrmDashboardAdmin.rectSetaAnteriorAgendaClick(Sender: TObject);
begin
  FDataAgenda := FDataAgenda - 1;
  AtualizarDataAgenda;
  AtualizarKPIs;
  CarregarLinhaTempo;
  AtualizarGraficoSemanal;
end;

procedure TFrmDashboardAdmin.rectSetaProximaAgendaClick(Sender: TObject);
begin
  if Trunc(FDataAgenda) >= Trunc(Date) then Exit;
  FDataAgenda := FDataAgenda + 1;
  AtualizarDataAgenda;
  AtualizarKPIs;
  CarregarLinhaTempo;
  AtualizarGraficoSemanal;
end;

procedure TFrmDashboardAdmin.edtBuscaAdminChange(Sender: TObject);
begin
  CarregarLinhaTempo;
end;

procedure TFrmDashboardAdmin.CarregarNotificacoesDash;
var
  Query: TFDQuery;
  Card: TRectangle;
  LblEstrelas, LblCliente, LblBarbeiro,
  LblComentario, LblData: TLabel;
  CardCount: Integer;
  Nota: Integer;
  Estrelas: string;
  J: Integer;
begin
  for J := scrollNotifDash.Content.ControlsCount - 1 downto 0 do
    if scrollNotifDash.Content.Controls[J].Tag = 84 then
      scrollNotifDash.Content.Controls[J].Free;

  CardCount := 0;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT AV.ID, AV.NOTA, AV.COMENTARIO, AV.DT_AVALIACAO, ' +
      '       UC.NOME_COMPLETO AS CLIENTE, ' +
      '       UB.NOME_COMPLETO AS BARBEIRO ' +
      'FROM TB_AVALIACOES AV ' +
      'JOIN TB_USUARIOS UC ON UC.ID = AV.CLIENTE_ID ' +
      'JOIN TB_BARBEIROS B ON B.ID = AV.BARBEIRO_ID ' +
      'JOIN TB_USUARIOS UB ON UB.ID = B.USUARIO_ID ' +
      'ORDER BY AV.DT_AVALIACAO DESC ' +
      'ROWS 20';
    Query.Open;

    while not Query.EOF do
    begin
      Nota := Query.FieldByName('NOTA').AsInteger;

      Estrelas := '';
      for J := 1 to Nota do
        Estrelas := Estrelas + '★';
      for J := Nota + 1 to 5 do
        Estrelas := Estrelas + '☆';

      Card := TRectangle.Create(scrollNotifDash);
      Card.Parent := scrollNotifDash;
      Card.Tag := 84;
      Card.Fill.Color := $FF1E293B;
      Card.Stroke.Kind := TBrushKind.None;
      Card.XRadius := 12;
      Card.YRadius := 12;
      Card.Height := 110;
      Card.Width := scrollNotifDash.Width - 20;
      Card.Position.X := 10;
      Card.Position.Y := 10 + CardCount * 120;
      Card.HitTest := False;

      LblEstrelas := TLabel.Create(Card);
      LblEstrelas.Parent := Card;
      LblEstrelas.Position.X := 12;
      LblEstrelas.Position.Y := 8;
      LblEstrelas.Width := Card.Width - 24;
      LblEstrelas.Height := 20;
      LblEstrelas.Text := Estrelas;
      LblEstrelas.StyledSettings := [];
      LblEstrelas.TextSettings.Font.Size := 14;
      LblEstrelas.TextSettings.FontColor := $FFFBBF24;
      LblEstrelas.HitTest := False;

      LblCliente := TLabel.Create(Card);
      LblCliente.Parent := Card;
      LblCliente.Position.X := 12;
      LblCliente.Position.Y := 30;
      LblCliente.Width := Card.Width - 24;
      LblCliente.Height := 18;
      LblCliente.Text := Query.FieldByName('CLIENTE').AsString;
      LblCliente.StyledSettings := [];
      LblCliente.TextSettings.Font.Size := 13;
      LblCliente.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblCliente.TextSettings.FontColor := $FFFFFFFF;
      LblCliente.HitTest := False;

      LblBarbeiro := TLabel.Create(Card);
      LblBarbeiro.Parent := Card;
      LblBarbeiro.Position.X := 12;
      LblBarbeiro.Position.Y := 50;
      LblBarbeiro.Width := Card.Width - 24;
      LblBarbeiro.Height := 16;
      LblBarbeiro.Text := 'para ' + Query.FieldByName('BARBEIRO').AsString;
      LblBarbeiro.StyledSettings := [];
      LblBarbeiro.TextSettings.Font.Size := 11;
      LblBarbeiro.TextSettings.FontColor := $FF94A3B8;
      LblBarbeiro.HitTest := False;

      LblComentario := TLabel.Create(Card);
      LblComentario.Parent := Card;
      LblComentario.Position.X := 12;
      LblComentario.Position.Y := 68;
      LblComentario.Width := Card.Width - 100;
      LblComentario.Height := 30;
      LblComentario.Text := Query.FieldByName('COMENTARIO').AsString;
      LblComentario.WordWrap := True;
      LblComentario.StyledSettings := [];
      LblComentario.TextSettings.Font.Size := 11;
      LblComentario.TextSettings.FontColor := $FF94A3B8;
      LblComentario.HitTest := False;

      LblData := TLabel.Create(Card);
      LblData.Parent := Card;
      LblData.Position.X := Card.Width - 100;
      LblData.Position.Y := 88;
      LblData.Width := 88;
      LblData.Height := 16;
      LblData.Text := FormatDateTime('dd/mm/yyyy hh:nn',
        Query.FieldByName('DT_AVALIACAO').AsDateTime);
      LblData.StyledSettings := [];
      LblData.TextSettings.Font.Size := 10;
      LblData.TextSettings.FontColor := $FF64748B;
      LblData.TextSettings.HorzAlign := TTextAlign.Trailing;
      LblData.HitTest := False;

      Inc(CardCount);
      Query.Next;
    end;

    scrollNotifDash.Content.Height := 10 + CardCount * 120 + 10;
  finally
    Query.Free;
  end;
end;

procedure TFrmDashboardAdmin.circleSinoClick(Sender: TObject);
begin
  CarregarNotificacoesDash;
  rectOverlayNotifDash.Visible := True;
  rectOverlayNotifDash.BringToFront;
end;

procedure TFrmDashboardAdmin.lblFecharNotifDashClick(Sender: TObject);
begin
  rectOverlayNotifDash.Visible := False;
end;

procedure TFrmDashboardAdmin.AtualizarGraficoSemanal;
var
  Query: TFDQuery;
  Fats: array[0..6] of Currency;
  Barras: array[0..6] of TRectangle;
  Segunda, Domingo: TDate;
  DiasDesdeSegunda, DiaSemana, Idx, I: Integer;
  MaxFat, TotalSemana: Currency;
  Altura, AlturaMaxima, AlturaMinima: Single;
begin
  DiasDesdeSegunda := (DayOfWeek(FDataAgenda) + 5) mod 7;
  Segunda := FDataAgenda - DiasDesdeSegunda;
  Domingo := Segunda + 6;

  for I := 0 to 6 do
    Fats[I] := 0;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT DT_AGENDAMENTO, ' +
      '  SUM(CASE WHEN STATUS = ''CONCLUIDO'' THEN VALOR_COBRADO ELSE 0 END) AS FATURAMENTO ' +
      'FROM TB_AGENDAMENTOS ' +
      'WHERE DT_AGENDAMENTO >= :SEGUNDA ' +
      '  AND DT_AGENDAMENTO <= :DOMINGO ' +
      'GROUP BY DT_AGENDAMENTO ' +
      'ORDER BY DT_AGENDAMENTO';
    Query.ParamByName('SEGUNDA').AsDate := Segunda;
    Query.ParamByName('DOMINGO').AsDate := Domingo;
    Query.Open;

    while not Query.EOF do
    begin
      DiaSemana := DayOfWeek(Trunc(Query.FieldByName('DT_AGENDAMENTO').AsDateTime));
      Idx := (DiaSemana + 5) mod 7;
      Fats[Idx] := Query.FieldByName('FATURAMENTO').AsCurrency;
      Query.Next;
    end;
  finally
    Query.Free;
  end;

  MaxFat := 0;
  for I := 0 to 6 do
    if Fats[I] > MaxFat then
      MaxFat := Fats[I];

  Barras[0] := rectBarraSeg;
  Barras[1] := rectBarraTer;
  Barras[2] := rectBarraQuar;
  Barras[3] := rectBarraQui;
  Barras[4] := rectBarraSex;
  Barras[5] := rectBarraSab;
  Barras[6] := rectBarraDom;

  AlturaMaxima := 120.0;
  AlturaMinima := 4.0;

  for I := 0 to 6 do
  begin
    if MaxFat > 0 then
      Altura := AlturaMinima + (Fats[I] / MaxFat) * (AlturaMaxima - AlturaMinima)
    else
      Altura := AlturaMinima;
    Barras[I].Height := Altura;
  end;

  TotalSemana := 0;
  for I := 0 to 6 do
    TotalSemana := TotalSemana + Fats[I];
  lblTotalGrafico.StyledSettings := [];
  lblTotalGrafico.Text := 'Total na Semana: R$' + FormatFloat('#,##0.00', TotalSemana);
end;

procedure TFrmDashboardAdmin.lblLinkGraficoClick(Sender: TObject);
begin
  CarregarRelatorioSemanal;
  rectOverlayRelatorio.Visible := True;
  rectOverlayRelatorio.BringToFront;
end;

procedure TFrmDashboardAdmin.rectBtnVoltarRelClick(Sender: TObject);
begin
  rectOverlayRelatorio.Visible := False;
end;

procedure TFrmDashboardAdmin.CarregarRelatorioSemanal;

  function DiaSemanaAbrevDash(DW: Integer): string;
  const
    Dias: array[1..7] of string = ('Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb');
  begin
    Result := Dias[DW];
  end;

var
  Query: TFDQuery;
  Segunda, Domingo: TDate;
  DiasDesdeSegunda, J, CardCount: Integer;
  TotalAgend, TotalConc, SumAgend, SumConc: Integer;
  TotalFat, SumFat: Currency;
  LinhaFundo: TAlphaColor;
  Rect: TRectangle;
  Lbl: TLabel;
  Data: TDate;
  YPos, CardW: Single;
begin
  for J := scrollRelatorio.Content.ControlsCount - 1 downto 0 do
    if scrollRelatorio.Content.Controls[J].Tag = 83 then
      scrollRelatorio.Content.Controls[J].Free;

  DiasDesdeSegunda := (DayOfWeek(FDataAgenda) + 5) mod 7;
  Segunda := FDataAgenda - DiasDesdeSegunda;
  Domingo := Segunda + 6;

  lblTituloRelatorio.StyledSettings := [];
  lblTituloRelatorio.Text := 'Relatório Semanal  ' +
    FormatDateTime('dd/mm', Segunda) + ' a ' +
    FormatDateTime('dd/mm/yyyy', Domingo);

  CardW := scrollRelatorio.Width - 20;
  YPos := 10;

  Rect := TRectangle.Create(scrollRelatorio);
  Rect.Parent := scrollRelatorio;
  Rect.Tag := 83;
  Rect.Fill.Color := $FF0F172A;
  Rect.Stroke.Kind := TBrushKind.None;
  Rect.XRadius := 8;
  Rect.YRadius := 8;
  Rect.Height := 40;
  Rect.Width := CardW;
  Rect.Position.X := 10;
  Rect.Position.Y := YPos;
  Rect.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 10; Lbl.Position.Y := 10;
  Lbl.Width := 100; Lbl.Height := 20;
  Lbl.Text := 'Dia';
  Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 12;
  Lbl.TextSettings.FontColor := $FF94A3B8; Lbl.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 120; Lbl.Position.Y := 10;
  Lbl.Width := 90; Lbl.Height := 20;
  Lbl.Text := 'Agend.';
  Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 12;
  Lbl.TextSettings.FontColor := $FF94A3B8; Lbl.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 220; Lbl.Position.Y := 10;
  Lbl.Width := 70; Lbl.Height := 20;
  Lbl.Text := 'Concluídos';
  Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 12;
  Lbl.TextSettings.FontColor := $FF94A3B8; Lbl.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 300; Lbl.Position.Y := 10;
  Lbl.Width := CardW - 310; Lbl.Height := 20;
  Lbl.Text := 'Faturamento';
  Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 12;
  Lbl.TextSettings.FontColor := $FF94A3B8; Lbl.HitTest := False;

  YPos := YPos + 44;
  TotalAgend := 0;
  TotalConc := 0;
  TotalFat := 0;
  CardCount := 0;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text :=
      'SELECT DT_AGENDAMENTO, ' +
      '  COUNT(*) AS TOTAL, ' +
      '  SUM(CASE WHEN STATUS = ''CONCLUIDO'' THEN 1 ELSE 0 END) AS CONCLUIDOS, ' +
      '  SUM(CASE WHEN STATUS = ''CANCELADO'' THEN 1 ELSE 0 END) AS CANCELADOS, ' +
      '  SUM(CASE WHEN STATUS = ''CONCLUIDO'' THEN VALOR_COBRADO ELSE 0 END) AS FATURAMENTO ' +
      'FROM TB_AGENDAMENTOS ' +
      'WHERE DT_AGENDAMENTO >= :SEGUNDA ' +
      '  AND DT_AGENDAMENTO <= :DOMINGO ' +
      'GROUP BY DT_AGENDAMENTO ' +
      'ORDER BY DT_AGENDAMENTO';
    Query.ParamByName('SEGUNDA').AsDate := Segunda;
    Query.ParamByName('DOMINGO').AsDate := Domingo;
    Query.Open;

    while not Query.EOF do
    begin
      Data := Trunc(Query.FieldByName('DT_AGENDAMENTO').AsDateTime);
      SumAgend := Query.FieldByName('TOTAL').AsInteger;
      SumConc := Query.FieldByName('CONCLUIDOS').AsInteger;
      SumFat := Query.FieldByName('FATURAMENTO').AsCurrency;

      Inc(TotalAgend, SumAgend);
      Inc(TotalConc, SumConc);
      TotalFat := TotalFat + SumFat;

      if CardCount mod 2 = 0 then
        LinhaFundo := $FF1E293B
      else
        LinhaFundo := $FF141C2B;

      Rect := TRectangle.Create(scrollRelatorio);
      Rect.Parent := scrollRelatorio;
      Rect.Tag := 83;
      Rect.Fill.Color := LinhaFundo;
      Rect.Stroke.Kind := TBrushKind.None;
      Rect.Height := 50;
      Rect.Width := CardW;
      Rect.Position.X := 10;
      Rect.Position.Y := YPos;
      Rect.HitTest := False;

      Lbl := TLabel.Create(Rect);
      Lbl.Parent := Rect;
      Lbl.Position.X := 10; Lbl.Position.Y := 15;
      Lbl.Width := 100;
      Lbl.Text := DiaSemanaAbrevDash(DayOfWeek(Data)) + ' ' +
        FormatDateTime('dd/mm', Data);
      Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 13;
      Lbl.TextSettings.FontColor := $FFFFFFFF; Lbl.HitTest := False;

      Lbl := TLabel.Create(Rect);
      Lbl.Parent := Rect;
      Lbl.Position.X := 120; Lbl.Position.Y := 15;
      Lbl.Width := 80;
      Lbl.Text := IntToStr(SumAgend);
      Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 13;
      Lbl.TextSettings.FontColor := $FFFFFFFF; Lbl.HitTest := False;

      Lbl := TLabel.Create(Rect);
      Lbl.Parent := Rect;
      Lbl.Position.X := 220; Lbl.Position.Y := 15;
      Lbl.Width := 70;
      Lbl.Text := IntToStr(SumConc);
      Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 13;
      Lbl.TextSettings.FontColor := $FF22C55E; Lbl.HitTest := False;

      Lbl := TLabel.Create(Rect);
      Lbl.Parent := Rect;
      Lbl.Position.X := 300; Lbl.Position.Y := 15;
      Lbl.Width := CardW - 310;
      Lbl.Text := 'R$ ' + FormatFloat('#,##0.00', SumFat);
      Lbl.StyledSettings := []; Lbl.TextSettings.Font.Size := 13;
      Lbl.TextSettings.FontColor := $FFF58A00; Lbl.HitTest := False;

      YPos := YPos + 52;
      Inc(CardCount);
      Query.Next;
    end;
  finally
    Query.Free;
  end;

  YPos := YPos + 6;
  Rect := TRectangle.Create(scrollRelatorio);
  Rect.Parent := scrollRelatorio;
  Rect.Tag := 83;
  Rect.Fill.Color := $FF0B1220;
  Rect.Stroke.Kind := TBrushKind.None;
  Rect.XRadius := 8;
  Rect.YRadius := 8;
  Rect.Height := 50;
  Rect.Width := CardW;
  Rect.Position.X := 10;
  Rect.Position.Y := YPos;
  Rect.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 10; Lbl.Position.Y := 15;
  Lbl.Width := 100;
  Lbl.Text := 'TOTAL';
  Lbl.StyledSettings := [];
  Lbl.TextSettings.Font.Size := 13;
  Lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
  Lbl.TextSettings.FontColor := $FFFFFFFF; Lbl.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 120; Lbl.Position.Y := 15;
  Lbl.Width := 80;
  Lbl.Text := IntToStr(TotalAgend);
  Lbl.StyledSettings := [];
  Lbl.TextSettings.Font.Size := 13;
  Lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
  Lbl.TextSettings.FontColor := $FFFFFFFF; Lbl.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 220; Lbl.Position.Y := 15;
  Lbl.Width := 70;
  Lbl.Text := IntToStr(TotalConc);
  Lbl.StyledSettings := [];
  Lbl.TextSettings.Font.Size := 13;
  Lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
  Lbl.TextSettings.FontColor := $FF22C55E; Lbl.HitTest := False;

  Lbl := TLabel.Create(Rect);
  Lbl.Parent := Rect;
  Lbl.Position.X := 300; Lbl.Position.Y := 15;
  Lbl.Width := CardW - 310;
  Lbl.Text := 'R$ ' + FormatFloat('#,##0.00', TotalFat);
  Lbl.StyledSettings := [];
  Lbl.TextSettings.Font.Size := 13;
  Lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
  Lbl.TextSettings.FontColor := $FFF58A00; Lbl.HitTest := False;

  scrollRelatorio.Content.Height := YPos + 60;
end;

end.
