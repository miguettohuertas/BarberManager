program BarberManager;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  Model.Conexao in 'Model\Model.Conexao.pas' {dmConexao: TDataModule},
  View.DashboardAdmin in 'View\View.DashboardAdmin.pas' {FrmDashboardAdmin},
  View.Frame.Servicos in 'View\View.Frame.Servicos.pas' {FrameServicos: TFrame},
  View.Frame.Agenda in 'View\View.Frame.Agenda.pas' {FrameAgenda: TFrame},
  View.Frame.Clientes in 'View\View.Frame.Clientes.pas' {FrameClientes: TFrame},
  View.Frame.Financeiro in 'View\View.Frame.Financeiro.pas' {FrameFinanceiro: TFrame},
  View.Frame.Configuracoes in 'View\View.Frame.Configuracoes.pas' {FrameConfiguracoes: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TFrmDashboardAdmin, FrmDashboardAdmin);
  Application.Run;
end.
