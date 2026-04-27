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
    procedure rectMenuServicosClick(Sender: TObject);
    procedure rectMenuInicioClick(Sender: TObject);
    procedure rectMenuSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure AtualizarKPIs;
    procedure CarregarLinhaTempo;
  public
    { Public declarations }
  end;

var
  FrmDashboardAdmin: TFrmDashboardAdmin;

implementation

{$R *.fmx}

uses View.Frame.Servicos, View.Principal,
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param;

procedure TFrmDashboardAdmin.FormShow(Sender: TObject);
begin
  lblDataDash.StyledSettings := [];
  lblDataDash.Text := FormatDateTime('dddd, d "de" MMMM "de" yyyy', Now);
  AtualizarKPIs;
  CarregarLinhaTempo;
end;

procedure TFrmDashboardAdmin.AtualizarKPIs;
var
  Query: TFDQuery;
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
      'WHERE DT_AGENDAMENTO = CURRENT_DATE';
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
  Status, TextoBadge: string;
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
      'WHERE A.DT_AGENDAMENTO = CURRENT_DATE ' +
      'ORDER BY A.HR_INICIO';
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
  for I := lytAreaPrincipal.ControlsCount - 1 downto 0 do
  begin
    if lytAreaPrincipal.Controls[I] is TFrame then
      lytAreaPrincipal.Controls[I].Free;
  end;

  scrollDashboard.Visible := True;

end;

procedure TFrmDashboardAdmin.rectMenuSairClick(Sender: TObject);
begin
  Self.Hide;

  FrmPrincipal.TabControlPrincipal.ActiveTab := FrmPrincipal.TabLogin;

  FrmPrincipal.Show;
end;

procedure TFrmDashboardAdmin.rectMenuServicosClick(Sender: TObject);
var
  FrameServicos: TFrameServicos;
begin
  scrollDashboard.Visible := False;

  FrameServicos := TFrameServicos.Create(Self);

  FrameServicos.Parent := lytAreaPrincipal;

  FrameServicos.Align := TAlignLayout.Client;

end;

end.
