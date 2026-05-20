unit View.Frame.Configuracoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ListBox,
  FMX.ScrollBox;

type
  TFrameConfiguracoes = class(TFrame)
  private
    FEdtNomeBarbearia: TEdit;
    FEdtMetaDiaria: TEdit;
    FEdtHorarioAbertura: TEdit;
    FEdtHorarioFechamento: TEdit;
    FEdtTelefone: TEdit;
    FEdtEndereco: TEdit;
    procedure CarregarConfiguracoes;
    procedure SalvarConfiguracoes;
    procedure SalvarClick(Sender: TObject);
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  FMX.DialogService;

procedure TFrameConfiguracoes.AfterConstruction;
var
  RectFundo: TRectangle;
  LytHeader: TLayout;
  LblTitulo, LblSub: TLabel;
  ScrollConf: TVertScrollBox;
  LytForm: TLayout;
  LblSec: TLabel;
  Sep: TRectangle;
  Card: TRectangle;
  LblCampo: TLabel;
  LytBtn: TLayout;
  RectBtn: TRectangle;
  LblSalvar: TLabel;
begin
  inherited;

  // === FUNDO ===
  RectFundo := TRectangle.Create(Self);
  RectFundo.Parent := Self;
  RectFundo.Align := TAlignLayout.Client;
  RectFundo.Fill.Color := $FF0B1220;
  RectFundo.Stroke.Kind := TBrushKind.None;
  RectFundo.HitTest := False;

  // === HEADER (Top) ===
  LytHeader := TLayout.Create(RectFundo);
  LytHeader.Parent := RectFundo;
  LytHeader.Align := TAlignLayout.Top;
  LytHeader.Height := 80;
  LytHeader.Padding.Left   := 24;
  LytHeader.Padding.Top    := 12;
  LytHeader.Padding.Right  := 24;
  LytHeader.Padding.Bottom := 4;

  LblTitulo := TLabel.Create(LytHeader);
  LblTitulo.Parent := LytHeader;
  LblTitulo.Position.X := 24;
  LblTitulo.Position.Y := 14;
  LblTitulo.Width := 700;
  LblTitulo.Height := 30;
  LblTitulo.Text := 'Configura'#231#245'es';
  LblTitulo.StyledSettings := [];
  LblTitulo.TextSettings.FontColor := $FFFFFFFF;
  LblTitulo.TextSettings.Font.Size := 20;
  LblTitulo.TextSettings.Font.Style := [TFontStyle.fsBold];
  LblTitulo.HitTest := False;

  LblSub := TLabel.Create(LytHeader);
  LblSub.Parent := LytHeader;
  LblSub.Position.X := 24;
  LblSub.Position.Y := 48;
  LblSub.Width := 700;
  LblSub.Height := 20;
  LblSub.Text := 'Personalize as informa'#231#245'es da sua barbearia';
  LblSub.StyledSettings := [];
  LblSub.TextSettings.FontColor := $FF94A3B8;
  LblSub.TextSettings.Font.Size := 13;
  LblSub.HitTest := False;

  // === SCROLL (Client — ap'#243's Top) ===
  ScrollConf := TVertScrollBox.Create(RectFundo);
  ScrollConf.Parent := RectFundo;
  ScrollConf.Align := TAlignLayout.Client;
  ScrollConf.Margins.Left   := 16;
  ScrollConf.Margins.Right  := 16;
  ScrollConf.Margins.Top    := 8;
  ScrollConf.Margins.Bottom := 8;

  // === LAYOUT PRINCIPAL DO FORMUL'#193'RIO ===
  LytForm := TLayout.Create(ScrollConf);
  LytForm.Parent := ScrollConf;
  LytForm.Align := TAlignLayout.Top;
  LytForm.Height := 600;

  // ── SE'#199#195'O 1: Informa'#231#245'es da Barbearia ──
  LblSec := TLabel.Create(LytForm);
  LblSec.Parent := LytForm;
  LblSec.Align := TAlignLayout.Top;
  LblSec.Height := 36;
  LblSec.Margins.Top := 16;
  LblSec.Text := 'Informa'#231#245'es da Barbearia';
  LblSec.StyledSettings := [];
  LblSec.TextSettings.FontColor := $FFFFFFFF;
  LblSec.TextSettings.Font.Size := 14;
  LblSec.TextSettings.Font.Style := [TFontStyle.fsBold];
  LblSec.TextSettings.VertAlign := TTextAlign.Center;
  LblSec.HitTest := False;

  Sep := TRectangle.Create(LytForm);
  Sep.Parent := LytForm;
  Sep.Align := TAlignLayout.Top;
  Sep.Height := 1;
  Sep.Margins.Top := 8;
  Sep.Fill.Color := $FF1E293B;
  Sep.Stroke.Kind := TBrushKind.None;
  Sep.HitTest := False;

  // Card 1 — Informa'#231#245'es
  Card := TRectangle.Create(LytForm);
  Card.Parent := LytForm;
  Card.Align := TAlignLayout.Top;
  Card.Height := 280;
  Card.Margins.Top := 12;
  Card.Fill.Color := $FF141C2B;
  Card.Stroke.Kind := TBrushKind.None;
  Card.XRadius := 12;
  Card.YRadius := 12;

  // Campo: Nome da Barbearia
  LblCampo := TLabel.Create(Card);
  LblCampo.Parent := Card;
  LblCampo.Position.X := 20;
  LblCampo.Position.Y := 16;
  LblCampo.Width := 300;
  LblCampo.Height := 18;
  LblCampo.Text := 'Nome da Barbearia';
  LblCampo.StyledSettings := [];
  LblCampo.TextSettings.FontColor := $FF94A3B8;
  LblCampo.TextSettings.Font.Size := 12;
  LblCampo.HitTest := False;

  FEdtNomeBarbearia := TEdit.Create(Card);
  FEdtNomeBarbearia.Parent := Card;
  FEdtNomeBarbearia.Position.X := 20;
  FEdtNomeBarbearia.Position.Y := 38;
  FEdtNomeBarbearia.Width := 500;
  FEdtNomeBarbearia.Height := 40;

  // Campo: Telefone
  LblCampo := TLabel.Create(Card);
  LblCampo.Parent := Card;
  LblCampo.Position.X := 20;
  LblCampo.Position.Y := 94;
  LblCampo.Width := 200;
  LblCampo.Height := 18;
  LblCampo.Text := 'Telefone';
  LblCampo.StyledSettings := [];
  LblCampo.TextSettings.FontColor := $FF94A3B8;
  LblCampo.TextSettings.Font.Size := 12;
  LblCampo.HitTest := False;

  FEdtTelefone := TEdit.Create(Card);
  FEdtTelefone.Parent := Card;
  FEdtTelefone.Position.X := 20;
  FEdtTelefone.Position.Y := 116;
  FEdtTelefone.Width := 240;
  FEdtTelefone.Height := 40;

  // Campo: Endere'#231'o
  LblCampo := TLabel.Create(Card);
  LblCampo.Parent := Card;
  LblCampo.Position.X := 20;
  LblCampo.Position.Y := 172;
  LblCampo.Width := 200;
  LblCampo.Height := 18;
  LblCampo.Text := 'Endere'#231'o';
  LblCampo.StyledSettings := [];
  LblCampo.TextSettings.FontColor := $FF94A3B8;
  LblCampo.TextSettings.Font.Size := 12;
  LblCampo.HitTest := False;

  FEdtEndereco := TEdit.Create(Card);
  FEdtEndereco.Parent := Card;
  FEdtEndereco.Position.X := 20;
  FEdtEndereco.Position.Y := 194;
  FEdtEndereco.Width := 500;
  FEdtEndereco.Height := 40;

  // ── SE'#199#195'O 2: Funcionamento ──
  LblSec := TLabel.Create(LytForm);
  LblSec.Parent := LytForm;
  LblSec.Align := TAlignLayout.Top;
  LblSec.Height := 30;
  LblSec.Margins.Top := 24;
  LblSec.Text := 'Funcionamento';
  LblSec.StyledSettings := [];
  LblSec.TextSettings.FontColor := $FFFFFFFF;
  LblSec.TextSettings.Font.Size := 14;
  LblSec.TextSettings.Font.Style := [TFontStyle.fsBold];
  LblSec.TextSettings.VertAlign := TTextAlign.Center;
  LblSec.HitTest := False;

  Sep := TRectangle.Create(LytForm);
  Sep.Parent := LytForm;
  Sep.Align := TAlignLayout.Top;
  Sep.Height := 1;
  Sep.Margins.Top := 8;
  Sep.Fill.Color := $FF1E293B;
  Sep.Stroke.Kind := TBrushKind.None;
  Sep.HitTest := False;

  // Card 2 — Funcionamento
  Card := TRectangle.Create(LytForm);
  Card.Parent := LytForm;
  Card.Align := TAlignLayout.Top;
  Card.Height := 200;
  Card.Margins.Top := 12;
  Card.Fill.Color := $FF141C2B;
  Card.Stroke.Kind := TBrushKind.None;
  Card.XRadius := 12;
  Card.YRadius := 12;

  // Campo: Meta Di'#225'ria
  LblCampo := TLabel.Create(Card);
  LblCampo.Parent := Card;
  LblCampo.Position.X := 20;
  LblCampo.Position.Y := 16;
  LblCampo.Width := 210;
  LblCampo.Height := 18;
  LblCampo.Text := 'Meta de Faturamento Di'#225'rio (R$)';
  LblCampo.StyledSettings := [];
  LblCampo.TextSettings.FontColor := $FF94A3B8;
  LblCampo.TextSettings.Font.Size := 12;
  LblCampo.HitTest := False;

  FEdtMetaDiaria := TEdit.Create(Card);
  FEdtMetaDiaria.Parent := Card;
  FEdtMetaDiaria.Position.X := 20;
  FEdtMetaDiaria.Position.Y := 38;
  FEdtMetaDiaria.Width := 200;
  FEdtMetaDiaria.Height := 40;

  // Campo: Hor'#225'rio de Abertura
  LblCampo := TLabel.Create(Card);
  LblCampo.Parent := Card;
  LblCampo.Position.X := 240;
  LblCampo.Position.Y := 16;
  LblCampo.Width := 160;
  LblCampo.Height := 18;
  LblCampo.Text := 'Hor'#225'rio de Abertura';
  LblCampo.StyledSettings := [];
  LblCampo.TextSettings.FontColor := $FF94A3B8;
  LblCampo.TextSettings.Font.Size := 12;
  LblCampo.HitTest := False;

  FEdtHorarioAbertura := TEdit.Create(Card);
  FEdtHorarioAbertura.Parent := Card;
  FEdtHorarioAbertura.Position.X := 240;
  FEdtHorarioAbertura.Position.Y := 38;
  FEdtHorarioAbertura.Width := 150;
  FEdtHorarioAbertura.Height := 40;

  // Campo: Hor'#225'rio de Fechamento
  LblCampo := TLabel.Create(Card);
  LblCampo.Parent := Card;
  LblCampo.Position.X := 410;
  LblCampo.Position.Y := 16;
  LblCampo.Width := 160;
  LblCampo.Height := 18;
  LblCampo.Text := 'Hor'#225'rio de Fechamento';
  LblCampo.StyledSettings := [];
  LblCampo.TextSettings.FontColor := $FF94A3B8;
  LblCampo.TextSettings.Font.Size := 12;
  LblCampo.HitTest := False;

  FEdtHorarioFechamento := TEdit.Create(Card);
  FEdtHorarioFechamento.Parent := Card;
  FEdtHorarioFechamento.Position.X := 410;
  FEdtHorarioFechamento.Position.Y := 38;
  FEdtHorarioFechamento.Width := 150;
  FEdtHorarioFechamento.Height := 40;

  // ── BOT'#195'O SALVAR ──
  LytBtn := TLayout.Create(LytForm);
  LytBtn.Parent := LytForm;
  LytBtn.Align := TAlignLayout.Top;
  LytBtn.Height := 52;
  LytBtn.Margins.Top := 24;

  RectBtn := TRectangle.Create(LytBtn);
  RectBtn.Parent := LytBtn;
  RectBtn.Align := TAlignLayout.None;
  RectBtn.Position.X := 0;
  RectBtn.Position.Y := 6;
  RectBtn.Width := 200;
  RectBtn.Height := 40;
  RectBtn.Fill.Color := $FFF58A00;
  RectBtn.Stroke.Kind := TBrushKind.None;
  RectBtn.XRadius := 10;
  RectBtn.YRadius := 10;
  RectBtn.Cursor := crHandPoint;
  RectBtn.OnClick := SalvarClick;

  LblSalvar := TLabel.Create(RectBtn);
  LblSalvar.Parent := RectBtn;
  LblSalvar.Align := TAlignLayout.Client;
  LblSalvar.Text := 'Salvar Configura'#231#245'es';
  LblSalvar.StyledSettings := [];
  LblSalvar.TextSettings.FontColor := $FFFFFFFF;
  LblSalvar.TextSettings.Font.Size := 14;
  LblSalvar.TextSettings.Font.Style := [TFontStyle.fsBold];
  LblSalvar.TextSettings.HorzAlign := TTextAlign.Center;
  LblSalvar.TextSettings.VertAlign := TTextAlign.Center;
  LblSalvar.HitTest := False;

  CarregarConfiguracoes;
end;

procedure TFrameConfiguracoes.CarregarConfiguracoes;
var
  Q: TFDQuery;
  Chave: string;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text := 'SELECT CHAVE, VALOR FROM TB_CONFIGURACOES ORDER BY ID';
    Q.Open;
    while not Q.EOF do
    begin
      Chave := Q.FieldByName('CHAVE').AsString;
      if Chave = 'NOME_BARBEARIA' then
        FEdtNomeBarbearia.Text := Q.FieldByName('VALOR').AsString
      else if Chave = 'META_DIARIA' then
        FEdtMetaDiaria.Text := Q.FieldByName('VALOR').AsString
      else if Chave = 'HORARIO_ABERTURA' then
        FEdtHorarioAbertura.Text := Q.FieldByName('VALOR').AsString
      else if Chave = 'HORARIO_FECHAMENTO' then
        FEdtHorarioFechamento.Text := Q.FieldByName('VALOR').AsString
      else if Chave = 'TELEFONE' then
        FEdtTelefone.Text := Q.FieldByName('VALOR').AsString
      else if Chave = 'ENDERECO' then
        FEdtEndereco.Text := Q.FieldByName('VALOR').AsString;
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

procedure TFrameConfiguracoes.SalvarConfiguracoes;

  procedure UpdateConfig(const Chave, Valor: string);
  var
    Q: TFDQuery;
  begin
    Q := TFDQuery.Create(nil);
    try
      Q.Connection := dmConexao.FDConnection1;
      Q.SQL.Text :=
        'UPDATE TB_CONFIGURACOES SET VALOR = :VALOR WHERE CHAVE = :CHAVE';
      Q.ParamByName('VALOR').AsString := Valor;
      Q.ParamByName('CHAVE').AsString := Chave;
      Q.ExecSQL;
    finally
      Q.Free;
    end;
  end;

begin
  UpdateConfig('NOME_BARBEARIA',    FEdtNomeBarbearia.Text);
  UpdateConfig('META_DIARIA',       FEdtMetaDiaria.Text);
  UpdateConfig('HORARIO_ABERTURA',  FEdtHorarioAbertura.Text);
  UpdateConfig('HORARIO_FECHAMENTO',FEdtHorarioFechamento.Text);
  UpdateConfig('TELEFONE',          FEdtTelefone.Text);
  UpdateConfig('ENDERECO',          FEdtEndereco.Text);
  TDialogService.ShowMessage('Configura'#231#245'es salvas com sucesso!');
end;

procedure TFrameConfiguracoes.SalvarClick(Sender: TObject);
begin
  SalvarConfiguracoes;
end;

end.
