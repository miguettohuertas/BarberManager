unit View.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

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
    lblIconeVoltarAgendar: TLabel;
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
    procedure lblVoltarClick(Sender: TObject);
    procedure lblJaTenhoContaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.lblJaTenhoContaClick(Sender: TObject);
begin
  TabControlPrincipal.GotoVisibleTab(0, TTabTransition.Slide, TTabTransitionDirection.Reversed);
end;

procedure TFrmPrincipal.lblVoltarClick(Sender: TObject);
begin
  TabControlPrincipal.GotoVisibleTab(0, TTabTransition.Slide);
end;

end.
