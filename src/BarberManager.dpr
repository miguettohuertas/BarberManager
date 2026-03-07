program BarberManager;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  Model.Conexao in 'Model\Model.Conexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.
