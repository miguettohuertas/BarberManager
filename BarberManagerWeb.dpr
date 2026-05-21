program BarberManagerWeb;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Launcher       in 'src\Web\View.Launcher.pas'       {FrmLauncher},
  ServerController    in 'src\Web\ServerController.pas',
  UserSessionUnit     in 'src\Web\UserSessionUnit.pas',
  Model.Conexao       in 'src\Model\Model.Conexao.pas'      {dmConexao: TDataModule},
  View.DashboardAdmin in 'src\View\View.DashboardAdmin.pas' {FrmDashboardAdmin},
  View.Frame.Servicos in 'src\View\View.Frame.Servicos.pas' {FrameServicos: TFrame},
  View.Frame.Agenda   in 'src\View\View.Frame.Agenda.pas'   {FrameAgenda: TFrame},
  View.Frame.Clientes in 'src\View\View.Frame.Clientes.pas' {FrameClientes: TFrame},
  View.Frame.Financeiro     in 'src\View\View.Frame.Financeiro.pas'     {FrameFinanceiro: TFrame},
  View.Frame.Configuracoes  in 'src\View\View.Frame.Configuracoes.pas'  {FrameConfiguracoes: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TFrmLauncher, FrmLauncher);
  Application.Run;
end.
