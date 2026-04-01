program BarberManager;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  Model.Conexao in 'Model\Model.Conexao.pas' {dmConexao: TDataModule},
  View.DashboardAdmin in 'View\View.DashboardAdmin.pas' {FrmDashboardAdmin},
  View.Frame.Servicos in 'View\View.Frame.Servicos.pas' {FrameServicos: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TFrmDashboardAdmin, FrmDashboardAdmin);
  Application.Run;
end.
