unit View.Frame.Servicos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit;

type
  TFrameServicos = class(TFrame)
    rectFundoServicos: TRectangle;
    lytHeaderWeb: TLayout;
    lblTituloServicos: TLabel;
    lytTituloServicos: TLayout;
    lblSubTituloServicos: TLabel;
    lytAcoesDireita: TLayout;
    rectBtnNovoServico: TRectangle;
    lblBtnNovoServico: TLabel;
    circleSinoServicos: TCircle;
    Label1: TLabel;
    rectBuscaServicos: TRectangle;
    edtBuscaServicos: TEdit;
    gridKpiServicos: TGridPanelLayout;
    lytContainerKpi1: TLayout;
    rectKpi1: TRectangle;
    lytTopKpi1: TLayout;
    rectIconeKpi1: TRectangle;
    lblTitKpi1: TLabel;
    lblValKpi1: TLabel;
    lblSubKpi1: TLabel;
    lytContainerKpi2: TLayout;
    rectKpi2: TRectangle;
    lytTopKpi2: TLayout;
    rectIconeKpi2: TRectangle;
    lblTitKpi2: TLabel;
    lblValKpi2: TLabel;
    lblSubKpi2: TLabel;
    lytContainerKpi3: TLayout;
    rectKpi3: TRectangle;
    lytTopKpi3: TLayout;
    rectIconeKpi3: TRectangle;
    lblTitKpi3: TLabel;
    lblValKpi3: TLabel;
    lblSubKpi3: TLabel;
    lytContainerKpi4: TLayout;
    rectKpi4: TRectangle;
    lytTopKpi4: TLayout;
    rectIconeKpi4: TRectangle;
    lblTitKpi4: TLabel;
    lblValKpi4: TLabel;
    lblSubKpi4: TLabel;
    lytFiltrosContainer: TLayout;
    scrollFiltrosCategorias: THorzScrollBox;
    rectFiltroTodos: TRectangle;
    lblFiltroTodos: TLabel;
    rectFiltroEstetica: TRectangle;
    lblFiltroEstetica: TLabel;
    rectFiltroBarba: TRectangle;
    lblFiltroBarba: TLabel;
    rectFiltroCabelo: TRectangle;
    lblFiltroCabelo: TLabel;
    rectToggleStatus: TRectangle;
    gridToggle: TGridPanelLayout;
    rectToggleTodos: TRectangle;
    lblToggleTodos: TLabel;
    rectToggleAtivos: TRectangle;
    lblToggleAtivos: TLabel;
    rectToggleInativos: TRectangle;
    lblToggleInativos: TLabel;
    lblResultadosTotal: TLabel;
    lytHeaderTabela: TLayout;
    Rectangle1: TRectangle;
    lblColServico: TLabel;
    lblColCategoria: TLabel;
    lblColPreco: TLabel;
    lblColDuracao: TLabel;
    lblColAgendamentos: TLabel;
    lblColAcoes: TLabel;
    scrollListaServicos: TVertScrollBox;
    rectRowServico1: TRectangle;
    lytRowServicoCol1: TLayout;
    rectIconServ1: TRectangle;
    lytTextosServico1: TLayout;
    lblNomeServico1: TLabel;
    lblDescServico1: TLabel;
    lytRowCatCol2: TLayout;
    rectTagCat1: TRectangle;
    lblTextCat1: TLabel;
    lytRowPrecoCol3: TLayout;
    lblPrecoServico1: TLabel;
    lytRowDuracaoCol4: TLayout;
    lblDuracaoServico1: TLabel;
    lytRowAgendCol5: TLayout;
    lytTextosAgend1: TLayout;
    lblTotalAgend1: TLabel;
    lblReceitaAgend1: TLabel;
    lytRowAcoesCol6: TLayout;
    imgActionDel1: TImage;
    imgActionEdit1: TImage;
    imgActionToggle1: TImage;
    rectRowServico3: TRectangle;
    lytRowServicoCol3: TLayout;
    rectIconServ3: TRectangle;
    lytTextosServico3: TLayout;
    lblNomeServico3: TLabel;
    lblDescServico3: TLabel;
    lytRowCatCol2Serv3: TLayout;
    rectTagCat3: TRectangle;
    lblTextCat3: TLabel;
    lytPrecoCol3Serv3: TLayout;
    lblPrecoServico3: TLabel;
    lytRowDuracaoCol4Serv3: TLayout;
    lblDuracaoServico3: TLabel;
    lytRowAgendCol5Serv3: TLayout;
    lytTextosAgend3: TLayout;
    lblTotalAgend3: TLabel;
    lblTotalReceitaAgend3: TLabel;
    lytRowAcoesCol6Serv3: TLayout;
    imgActionDel3: TImage;
    imgActionEdit3: TImage;
    imgActionToggle3: TImage;
    rectRowServico2: TRectangle;
    lytRowServicoCol2: TLayout;
    rectIconServ2: TRectangle;
    lytTextosServico2: TLayout;
    lblNomeServico2: TLabel;
    lblDescServico2: TLabel;
    lytRowCatCol2Serv2: TLayout;
    rectTagCat2: TRectangle;
    lblTextCat2: TLabel;
    lytPrecoCol3Serv2: TLayout;
    lblPrecoServico2: TLabel;
    lytRowDuracaoCol4Serv2: TLayout;
    lblDuracaoServico2: TLabel;
    lytRowAgendCol5Serv2: TLayout;
    lytTextosAgend2: TLayout;
    lblTotalAgend2: TLabel;
    lblReceitaAgend2: TLabel;
    lytRowAcoesCol6Serv2: TLayout;
    imgActionDel2: TImage;
    imgActionEdit2: TImage;
    imgActionToggle2: TImage;
    lytRodapeResumo: TLayout;
    rectLinhaRodape: TRectangle;
    lblContadorRodape: TLabel;
    lytValoresRodape: TLayout;
    lblTextoReceita: TLabel;
    lblValorReceitaTotal: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
