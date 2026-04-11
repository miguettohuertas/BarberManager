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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDashboardAdmin: TFrmDashboardAdmin;

implementation

{$R *.fmx}

uses View.Frame.Servicos, View.Principal;

procedure TFrmDashboardAdmin.rectMenuInicioClick(Sender: TObject);
var
  I: Integer;
begin
  for I := lytAreaPrincipal.ControlsCount - 1 downto 0 do
  begin
    if lytAreaPrincipal.Controls[I] is TFrame then
      lytAreaPrincipal.Controls[I].DisposeOf;
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
