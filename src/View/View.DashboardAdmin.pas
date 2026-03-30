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
    lblIniciaisAdmin: TLabel;
    lytTextosAdmin: TLayout;
    lblAdminNome: TLabel;
    lblAdminCargo: TLabel;
    circleSino: TCircle;
    Label1: TLabel;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDashboardAdmin: TFrmDashboardAdmin;

implementation

{$R *.fmx}

end.
