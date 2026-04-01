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
    Circle1: TCircle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
