unit View.Frame.Financeiro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ListBox,
  FMX.ScrollBox;

type
  TFrameFinanceiro = class(TFrame)
  private
    FFiltroMes: Integer;
    FFiltroAno: Integer;
    FScrollLista: TVertScrollBox;
    FLblSubtitulo: TLabel;
    FLblRodape: TLabel;
    FLblKpiFaturamento: TLabel;
    FLblKpiConcluidos: TLabel;
    FLblKpiTicketMedio: TLabel;
    FLblKpiCancelados: TLabel;
    FCboMes: TComboBox;
    FCboAno: TComboBox;
    procedure CarregarTransacoes;
    procedure LimparLinhas;
    procedure AtualizarKPIs;
    procedure FiltroChange(Sender: TObject);
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  System.DateUtils;

procedure TFrameFinanceiro.AfterConstruction;
var
  RectFundo: TRectangle;
  LytRodape: TLayout;
  LytHeader: TLayout;
  LblTitulo: TLabel;
  LytKpis: TLayout;
  LytFiltros: TLayout;
  RectFiltros: TRectangle;
  LblFiltrarPor: TLabel;
  LytHeaderTabela: TLayout;
  RectHeaderTab: TRectangle;
  AnoAtual: Integer;

  procedure CriarKpiCard(Pai: TLayout; X, W: Single;
    const Titulo: string; var LblVal: TLabel; const Sub: string);
  var
    Card: TRectangle;
    LT, LV, LS: TLabel;
  begin
    Card := TRectangle.Create(Pai);
    Card.Parent := Pai;
    Card.Align := TAlignLayout.None;
    Card.Position.X := X;
    Card.Position.Y := 0;
    Card.Width := W;
    Card.Height := 100;
    Card.XRadius := 12;
    Card.YRadius := 12;
    Card.Fill.Color := $FF141C2B;
    Card.Stroke.Kind := TBrushKind.None;

    LT := TLabel.Create(Card);
    LT.Parent := Card;
    LT.Align := TAlignLayout.None;
    LT.Position.X := 16; LT.Position.Y := 12;
    LT.Width := W - 32; LT.Height := 18;
    LT.Text := Titulo;
    LT.StyledSettings := [];
    LT.TextSettings.FontColor := $FF94A3B8;
    LT.TextSettings.Font.Size := 12;
    LT.HitTest := False;

    LV := TLabel.Create(Card);
    LV.Parent := Card;
    LV.Align := TAlignLayout.None;
    LV.Position.X := 16; LV.Position.Y := 34;
    LV.Width := W - 32; LV.Height := 36;
    LV.Text := '0';
    LV.StyledSettings := [];
    LV.TextSettings.FontColor := $FFFFFFFF;
    LV.TextSettings.Font.Size := 28;
    LV.TextSettings.Font.Style := [TFontStyle.fsBold];
    LV.HitTest := False;
    LblVal := LV;

    LS := TLabel.Create(Card);
    LS.Parent := Card;
    LS.Align := TAlignLayout.None;
    LS.Position.X := 16; LS.Position.Y := 74;
    LS.Width := W - 32; LS.Height := 16;
    LS.Text := Sub;
    LS.StyledSettings := [];
    LS.TextSettings.FontColor := $FF64748B;
    LS.TextSettings.Font.Size := 11;
    LS.HitTest := False;
  end;

  procedure CriarColHeader(const Texto: string; X, W: Single);
  var
    L: TLabel;
  begin
    L := TLabel.Create(RectHeaderTab);
    L.Parent := RectHeaderTab;
    L.Align := TAlignLayout.None;
    L.Position.X := X;
    L.Position.Y := 0;
    L.Width := W;
    L.Height := 36;
    L.Text := Texto;
    L.StyledSettings := [];
    L.TextSettings.FontColor := $FF64748B;
    L.TextSettings.Font.Size := 11;
    L.TextSettings.Font.Style := [TFontStyle.fsBold];
    L.TextSettings.VertAlign := TTextAlign.Center;
    L.HitTest := False;
  end;

begin
  inherited;
  FFiltroMes := 0;
  FFiltroAno := YearOf(Today);
  AnoAtual   := YearOf(Today);

  // === FUNDO ===
  RectFundo := TRectangle.Create(Self);
  RectFundo.Parent := Self;
  RectFundo.Align := TAlignLayout.Client;
  RectFundo.Fill.Color := $FF0B1220;
  RectFundo.Stroke.Kind := TBrushKind.None;
  RectFundo.HitTest := False;

  // === RODAP'#202' (Bottom — antes do Client) ===
  LytRodape := TLayout.Create(RectFundo);
  LytRodape.Parent := RectFundo;
  LytRodape.Align := TAlignLayout.Bottom;
  LytRodape.Height := 36;
  LytRodape.Padding.Left  := 16;
  LytRodape.Padding.Right := 16;

  FLblRodape := TLabel.Create(LytRodape);
  FLblRodape.Parent := LytRodape;
  FLblRodape.Align := TAlignLayout.Left;
  FLblRodape.Width := 500;
  FLblRodape.Text := '';
  FLblRodape.StyledSettings := [];
  FLblRodape.TextSettings.FontColor := $FF64748B;
  FLblRodape.TextSettings.Font.Size := 12;
  FLblRodape.TextSettings.VertAlign := TTextAlign.Center;
  FLblRodape.HitTest := False;

  // === HEADER ===
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
  LblTitulo.Text := 'Relat'#243'rio Financeiro';
  LblTitulo.StyledSettings := [];
  LblTitulo.TextSettings.FontColor := $FFFFFFFF;
  LblTitulo.TextSettings.Font.Size := 20;
  LblTitulo.TextSettings.Font.Style := [TFontStyle.fsBold];
  LblTitulo.HitTest := False;

  FLblSubtitulo := TLabel.Create(LytHeader);
  FLblSubtitulo.Parent := LytHeader;
  FLblSubtitulo.Position.X := 24;
  FLblSubtitulo.Position.Y := 48;
  FLblSubtitulo.Width := 700;
  FLblSubtitulo.Height := 20;
  FLblSubtitulo.Text := 'Carregando...';
  FLblSubtitulo.StyledSettings := [];
  FLblSubtitulo.TextSettings.FontColor := $FF94A3B8;
  FLblSubtitulo.TextSettings.Font.Size := 13;
  FLblSubtitulo.HitTest := False;

  // === KPI CARDS ===
  LytKpis := TLayout.Create(RectFundo);
  LytKpis.Parent := RectFundo;
  LytKpis.Align := TAlignLayout.Top;
  LytKpis.Height := 110;
  LytKpis.Margins.Left   := 16;
  LytKpis.Margins.Right  := 16;
  LytKpis.Margins.Bottom := 8;

  CriarKpiCard(LytKpis, 0,   262, 'Faturamento Total',  FLblKpiFaturamento, 'receita acumulada');
  CriarKpiCard(LytKpis, 270, 262, 'Conclu'#237'dos',     FLblKpiConcluidos,  'agendamentos pagos');
  CriarKpiCard(LytKpis, 540, 262, 'Ticket M'#233'dio',   FLblKpiTicketMedio, 'por atendimento');
  CriarKpiCard(LytKpis, 810, 262, 'Cancelamentos',       FLblKpiCancelados,  'agendamentos perdidos');

  // === FILTROS ===
  LytFiltros := TLayout.Create(RectFundo);
  LytFiltros.Parent := RectFundo;
  LytFiltros.Align := TAlignLayout.Top;
  LytFiltros.Height := 52;
  LytFiltros.Margins.Left   := 16;
  LytFiltros.Margins.Right  := 16;
  LytFiltros.Margins.Bottom := 8;

  RectFiltros := TRectangle.Create(LytFiltros);
  RectFiltros.Parent := LytFiltros;
  RectFiltros.Align := TAlignLayout.Client;
  RectFiltros.Fill.Color := $FF141C2B;
  RectFiltros.Stroke.Kind := TBrushKind.None;
  RectFiltros.XRadius := 8;
  RectFiltros.YRadius := 8;
  RectFiltros.HitTest := False;

  LblFiltrarPor := TLabel.Create(RectFiltros);
  LblFiltrarPor.Parent := RectFiltros;
  LblFiltrarPor.Position.X := 12;
  LblFiltrarPor.Position.Y := 16;
  LblFiltrarPor.Width := 72;
  LblFiltrarPor.Height := 20;
  LblFiltrarPor.Text := 'Filtrar por:';
  LblFiltrarPor.StyledSettings := [];
  LblFiltrarPor.TextSettings.FontColor := $FFFFFFFF;
  LblFiltrarPor.TextSettings.Font.Size := 12;
  LblFiltrarPor.HitTest := False;

  FCboMes := TComboBox.Create(RectFiltros);
  FCboMes.Parent := RectFiltros;
  FCboMes.Position.X := 90;
  FCboMes.Position.Y := 10;
  FCboMes.Width := 140;
  FCboMes.Height := 32;
  FCboMes.Items.Add('Todos os Meses');
  FCboMes.Items.Add('Janeiro');
  FCboMes.Items.Add('Fevereiro');
  FCboMes.Items.Add('Mar'#231'o');
  FCboMes.Items.Add('Abril');
  FCboMes.Items.Add('Maio');
  FCboMes.Items.Add('Junho');
  FCboMes.Items.Add('Julho');
  FCboMes.Items.Add('Agosto');
  FCboMes.Items.Add('Setembro');
  FCboMes.Items.Add('Outubro');
  FCboMes.Items.Add('Novembro');
  FCboMes.Items.Add('Dezembro');
  FCboMes.ItemIndex := 0;
  FCboMes.OnChange := FiltroChange;

  FCboAno := TComboBox.Create(RectFiltros);
  FCboAno.Parent := RectFiltros;
  FCboAno.Position.X := 240;
  FCboAno.Position.Y := 10;
  FCboAno.Width := 100;
  FCboAno.Height := 32;
  FCboAno.Items.Add(IntToStr(AnoAtual));
  FCboAno.Items.Add(IntToStr(AnoAtual - 1));
  FCboAno.Items.Add(IntToStr(AnoAtual - 2));
  FCboAno.ItemIndex := 0;
  FCboAno.OnChange := FiltroChange;

  // === CABE'#199'ALHO DA TABELA ===
  LytHeaderTabela := TLayout.Create(RectFundo);
  LytHeaderTabela.Parent := RectFundo;
  LytHeaderTabela.Align := TAlignLayout.Top;
  LytHeaderTabela.Height := 40;
  LytHeaderTabela.Margins.Left  := 16;
  LytHeaderTabela.Margins.Right := 16;

  RectHeaderTab := TRectangle.Create(LytHeaderTabela);
  RectHeaderTab.Parent := LytHeaderTabela;
  RectHeaderTab.Align := TAlignLayout.Client;
  RectHeaderTab.Fill.Color := $FF1E293B;
  RectHeaderTab.Stroke.Kind := TBrushKind.None;
  RectHeaderTab.XRadius := 8;
  RectHeaderTab.YRadius := 8;
  RectHeaderTab.HitTest := False;

  CriarColHeader('DATA',          8,   110);
  CriarColHeader('CLIENTE',       118, 200);
  CriarColHeader('SERVI'#199'O',  318, 180);
  CriarColHeader('BARBEIRO',      498, 150);
  CriarColHeader('DURA'#199#195'O', 648, 80);
  CriarColHeader('VALOR',         728, 110);
  CriarColHeader('STATUS',        838, 120);

  // === SCROLL DA LISTA (Client — ap'#243's Bottom e Top) ===
  FScrollLista := TVertScrollBox.Create(RectFundo);
  FScrollLista.Parent := RectFundo;
  FScrollLista.Align := TAlignLayout.Client;
  FScrollLista.Margins.Left   := 16;
  FScrollLista.Margins.Right  := 16;
  FScrollLista.Margins.Bottom := 4;

  AtualizarKPIs;
  CarregarTransacoes;
end;

procedure TFrameFinanceiro.AtualizarKPIs;
var
  Q: TFDQuery;
  FiltroMes, FiltroAno: string;
  Periodo: string;
const
  MesesNomes: array[1..12] of string = (
    'Janeiro', 'Fevereiro', 'Mar'#231'o', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
begin
  FiltroMes := '';
  if FFiltroMes > 0 then
    FiltroMes := ' AND EXTRACT(MONTH FROM DT_AGENDAMENTO) = ' + IntToStr(FFiltroMes);
  FiltroAno := ' AND EXTRACT(YEAR FROM DT_AGENDAMENTO) = ' + IntToStr(FFiltroAno);

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text :=
      'SELECT ' +
      '(SELECT COALESCE(SUM(VALOR_COBRADO), 0) FROM TB_AGENDAMENTOS ' +
        'WHERE STATUS=''CONCLUIDO''' + FiltroMes + FiltroAno + ') AS FATURAMENTO,' +
      '(SELECT COUNT(*) FROM TB_AGENDAMENTOS ' +
        'WHERE STATUS=''CONCLUIDO''' + FiltroMes + FiltroAno + ') AS CONCLUIDOS,' +
      '(SELECT COALESCE(AVG(VALOR_COBRADO), 0) FROM TB_AGENDAMENTOS ' +
        'WHERE STATUS=''CONCLUIDO''' + FiltroMes + FiltroAno + ') AS TICKET,' +
      '(SELECT COUNT(*) FROM TB_AGENDAMENTOS ' +
        'WHERE STATUS=''CANCELADO''' + FiltroMes + FiltroAno + ') AS CANCELADOS ' +
      'FROM RDB$DATABASE';
    Q.Open;

    FLblKpiFaturamento.StyledSettings := [];
    FLblKpiFaturamento.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiFaturamento.Text := 'R$ ' + FormatFloat('#,##0.00', Q.FieldByName('FATURAMENTO').AsFloat);

    FLblKpiConcluidos.StyledSettings := [];
    FLblKpiConcluidos.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiConcluidos.Text := Q.FieldByName('CONCLUIDOS').AsString;

    FLblKpiTicketMedio.StyledSettings := [];
    FLblKpiTicketMedio.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiTicketMedio.Text := 'R$ ' + FormatFloat('#,##0.00', Q.FieldByName('TICKET').AsFloat);

    FLblKpiCancelados.StyledSettings := [];
    FLblKpiCancelados.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiCancelados.Text := Q.FieldByName('CANCELADOS').AsString;
  finally
    Q.Free;
  end;

  if FFiltroMes = 0 then
    Periodo := IntToStr(FFiltroAno)
  else
    Periodo := MesesNomes[FFiltroMes] + ' ' + IntToStr(FFiltroAno);

  FLblSubtitulo.StyledSettings := [];
  FLblSubtitulo.TextSettings.FontColor := $FF94A3B8;
  FLblSubtitulo.Text := 'Per'#237'odo: ' + Periodo;
end;

procedure TFrameFinanceiro.LimparLinhas;
var
  I: Integer;
begin
  for I := FScrollLista.Content.ChildrenCount - 1 downto 0 do
    if FScrollLista.Content.Children[I].Tag = 91 then
      FScrollLista.Content.Children[I].Free;
end;

procedure TFrameFinanceiro.CarregarTransacoes;
var
  Q: TFDQuery;
  SQL: string;
  Row: TRectangle;
  LblData, LblCliente, LblServico, LblBarbeiro,
  LblDuracao, LblValor, LblStatusTxt: TLabel;
  RectBadge: TRectangle;
  Status: string;
  CorFundoBadge, CorTextoBadge, CorFundo: TAlphaColor;
  TextoBadge: string;
  Total: Integer;
begin
  LimparLinhas;
  Total := 0;

  SQL :=
    'SELECT A.ID, A.DT_AGENDAMENTO, A.HR_INICIO, A.VALOR_COBRADO, A.STATUS,' +
    '       U.NOME_COMPLETO AS CLIENTE,' +
    '       S.NOME AS SERVICO, S.DURACAO_MIN,' +
    '       UB.NOME_COMPLETO AS BARBEIRO' +
    ' FROM TB_AGENDAMENTOS A' +
    ' JOIN TB_USUARIOS U ON U.ID = A.CLIENTE_ID' +
    ' JOIN TB_SERVICOS S ON S.ID = A.SERVICO_ID' +
    ' JOIN TB_BARBEIROS B ON B.ID = A.BARBEIRO_ID' +
    ' JOIN TB_USUARIOS UB ON UB.ID = B.USUARIO_ID' +
    ' WHERE A.STATUS IN (''CONCLUIDO'',''CANCELADO'',''PENDENTE'',''EM_ANDAMENTO'')';
  if FFiltroMes > 0 then
    SQL := SQL + ' AND EXTRACT(MONTH FROM A.DT_AGENDAMENTO) = :MES';
  SQL := SQL + ' AND EXTRACT(YEAR FROM A.DT_AGENDAMENTO) = :ANO';
  SQL := SQL + ' ORDER BY A.DT_AGENDAMENTO DESC, A.HR_INICIO DESC ROWS 100';

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text := SQL;
    if FFiltroMes > 0 then
      Q.ParamByName('MES').AsInteger := FFiltroMes;
    Q.ParamByName('ANO').AsInteger := FFiltroAno;
    Q.Open;

    while not Q.EOF do
    begin
      Inc(Total);
      Status := Q.FieldByName('STATUS').AsString;

      if Status = 'CONCLUIDO' then
      begin
        CorFundoBadge := $FF166534; CorTextoBadge := $FF4ADE80;
        TextoBadge := 'Conclu'#237'do';
      end
      else if Status = 'CANCELADO' then
      begin
        CorFundoBadge := $FF7F1D1D; CorTextoBadge := $FFEF4444;
        TextoBadge := 'Cancelado';
      end
      else if Status = 'EM_ANDAMENTO' then
      begin
        CorFundoBadge := $FF1E3A5F; CorTextoBadge := $FF60A5FA;
        TextoBadge := 'Em Andamento';
      end
      else
      begin
        CorFundoBadge := $FF422006; CorTextoBadge := $FFF58A00;
        TextoBadge := 'Pendente';
      end;

      if Total mod 2 = 0 then
        CorFundo := $FF141C2B
      else
        CorFundo := $FF0F1929;

      Row := TRectangle.Create(FScrollLista);
      Row.Parent := FScrollLista;
      Row.Tag := 91;
      Row.Align := TAlignLayout.Top;
      Row.Height := 52;
      Row.Margins.Bottom := 2;
      Row.Fill.Color := CorFundo;
      Row.Stroke.Kind := TBrushKind.None;
      Row.HitTest := False;

      LblData := TLabel.Create(Row);
      LblData.Parent := Row;
      LblData.Position.X := 8;
      LblData.Position.Y := 16;
      LblData.Width := 108;
      LblData.Height := 20;
      LblData.Text := FormatDateTime('dd/mm/yy',
        Q.FieldByName('DT_AGENDAMENTO').AsDateTime);
      LblData.StyledSettings := [];
      LblData.TextSettings.FontColor := $FF94A3B8;
      LblData.TextSettings.Font.Size := 12;
      LblData.HitTest := False;

      LblCliente := TLabel.Create(Row);
      LblCliente.Parent := Row;
      LblCliente.Position.X := 118;
      LblCliente.Position.Y := 16;
      LblCliente.Width := 198;
      LblCliente.Height := 20;
      LblCliente.Text := Q.FieldByName('CLIENTE').AsString;
      LblCliente.StyledSettings := [];
      LblCliente.TextSettings.FontColor := $FFFFFFFF;
      LblCliente.TextSettings.Font.Size := 12;
      LblCliente.HitTest := False;

      LblServico := TLabel.Create(Row);
      LblServico.Parent := Row;
      LblServico.Position.X := 318;
      LblServico.Position.Y := 16;
      LblServico.Width := 178;
      LblServico.Height := 20;
      LblServico.Text := Q.FieldByName('SERVICO').AsString;
      LblServico.StyledSettings := [];
      LblServico.TextSettings.FontColor := $FF94A3B8;
      LblServico.TextSettings.Font.Size := 12;
      LblServico.HitTest := False;

      LblBarbeiro := TLabel.Create(Row);
      LblBarbeiro.Parent := Row;
      LblBarbeiro.Position.X := 498;
      LblBarbeiro.Position.Y := 16;
      LblBarbeiro.Width := 148;
      LblBarbeiro.Height := 20;
      LblBarbeiro.Text := Q.FieldByName('BARBEIRO').AsString;
      LblBarbeiro.StyledSettings := [];
      LblBarbeiro.TextSettings.FontColor := $FF94A3B8;
      LblBarbeiro.TextSettings.Font.Size := 12;
      LblBarbeiro.HitTest := False;

      LblDuracao := TLabel.Create(Row);
      LblDuracao.Parent := Row;
      LblDuracao.Position.X := 648;
      LblDuracao.Position.Y := 16;
      LblDuracao.Width := 78;
      LblDuracao.Height := 20;
      LblDuracao.Text := IntToStr(Q.FieldByName('DURACAO_MIN').AsInteger) + ' min';
      LblDuracao.StyledSettings := [];
      LblDuracao.TextSettings.FontColor := $FF94A3B8;
      LblDuracao.TextSettings.Font.Size := 12;
      LblDuracao.HitTest := False;

      LblValor := TLabel.Create(Row);
      LblValor.Parent := Row;
      LblValor.Position.X := 728;
      LblValor.Position.Y := 16;
      LblValor.Width := 108;
      LblValor.Height := 20;
      LblValor.Text := 'R$ ' + FormatFloat('#,##0.00',
        Q.FieldByName('VALOR_COBRADO').AsFloat);
      LblValor.StyledSettings := [];
      LblValor.TextSettings.FontColor := $FF4ADE80;
      LblValor.TextSettings.Font.Size := 12;
      LblValor.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblValor.HitTest := False;

      RectBadge := TRectangle.Create(Row);
      RectBadge.Parent := Row;
      RectBadge.Position.X := 838;
      RectBadge.Position.Y := 10;
      RectBadge.Width := 110;
      RectBadge.Height := 28;
      RectBadge.XRadius := 8;
      RectBadge.YRadius := 8;
      RectBadge.Fill.Color := CorFundoBadge;
      RectBadge.Stroke.Kind := TBrushKind.None;
      RectBadge.HitTest := False;

      LblStatusTxt := TLabel.Create(RectBadge);
      LblStatusTxt.Parent := RectBadge;
      LblStatusTxt.Align := TAlignLayout.Client;
      LblStatusTxt.Text := TextoBadge;
      LblStatusTxt.StyledSettings := [];
      LblStatusTxt.TextSettings.FontColor := CorTextoBadge;
      LblStatusTxt.TextSettings.Font.Size := 10;
      LblStatusTxt.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblStatusTxt.TextSettings.HorzAlign := TTextAlign.Center;
      LblStatusTxt.TextSettings.VertAlign := TTextAlign.Center;
      LblStatusTxt.HitTest := False;

      Q.Next;
    end;

    FScrollLista.Content.Height := Total * 54 + 20;
  finally
    Q.Free;
  end;

  FLblRodape.Text := 'Exibindo ' + IntToStr(Total) + ' transa'#231#245'es (m'#225'x. 100)';
end;

procedure TFrameFinanceiro.FiltroChange(Sender: TObject);
begin
  FFiltroMes := FCboMes.ItemIndex;
  FFiltroAno := YearOf(Today) - FCboAno.ItemIndex;
  AtualizarKPIs;
  CarregarTransacoes;
end;

end.
