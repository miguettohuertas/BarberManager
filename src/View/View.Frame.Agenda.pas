unit View.Frame.Agenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ListBox,
  FMX.ScrollBox;

type
  TFrameAgenda = class(TFrame)
  private
    FFiltroStatus: string;

    FRectFiltroTodos: TRectangle;
    FRectFiltroPendente: TRectangle;
    FRectFiltroAndamento: TRectangle;
    FRectFiltroConcluido: TRectangle;
    FRectFiltroCancelado: TRectangle;

    FLblKpiTotal: TLabel;
    FLblKpiPendentes: TLabel;
    FLblKpiAndamento: TLabel;
    FLblKpiConcluidos: TLabel;

    FScrollLista: TVertScrollBox;
    FLblSubtitulo: TLabel;
    FLblRodape: TLabel;

    procedure CarregarAgendamentos;
    procedure LimparLinhas;
    procedure AtualizarKPIs;
    procedure AplicarFiltroStatus(const Status: string);
    procedure DefinirFiltroAtivo(RectAtivo: TRectangle);
    procedure FiltroTodosClick(Sender: TObject);
    procedure FiltroPendenteClick(Sender: TObject);
    procedure FiltroAndamentoClick(Sender: TObject);
    procedure FiltroConcluidoClick(Sender: TObject);
    procedure FiltroCanceladoClick(Sender: TObject);
    procedure AlterarStatusClick(Sender: TObject);
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  System.StrUtils, FMX.DialogService, System.Threading;

procedure TFrameAgenda.AfterConstruction;
var
  RectFundo: TRectangle;
  LytHeader: TLayout;
  LblTitulo: TLabel;
  LytKpis: TLayout;
  RectCard: TRectangle;
  LblTit, LblSub: TLabel;
  LytFiltros: TLayout;
  ScrollFiltros: THorzScrollBox;
  LytHeaderTabela: TLayout;
  RectHeaderTab: TRectangle;
  LytRodape: TLayout;

  procedure CriarFiltroBtn(Pai: THorzScrollBox; const Texto: string;
    var RectRef: TRectangle);
  var
    Btn: TRectangle;
    Lbl: TLabel;
  begin
    Btn := TRectangle.Create(Pai);
    Btn.Parent := Pai;
    Btn.Align := TAlignLayout.Left;
    Btn.Width := 130;
    Btn.Margins.Left   := 0;
    Btn.Margins.Top    := 4;
    Btn.Margins.Right  := 8;
    Btn.Margins.Bottom := 4;
    Btn.XRadius := 17;
    Btn.YRadius := 17;
    Btn.Fill.Color := $FF1E293B;
    Btn.Stroke.Kind := TBrushKind.None;
    Btn.Cursor := crHandPoint;

    Lbl := TLabel.Create(Btn);
    Lbl.Parent := Btn;
    Lbl.Align := TAlignLayout.Client;
    Lbl.Text := Texto;
    Lbl.StyledSettings := [];
    Lbl.TextSettings.FontColor := $FF94A3B8;
    Lbl.TextSettings.Font.Size := 13;
    Lbl.TextSettings.HorzAlign := TTextAlign.Center;
    Lbl.HitTest := False;

    RectRef := Btn;
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
  FFiltroStatus := '';

  // === FUNDO GERAL ===
  RectFundo := TRectangle.Create(Self);
  RectFundo.Parent := Self;
  RectFundo.Align := TAlignLayout.Client;
  RectFundo.Fill.Color := $FF0B1220;
  RectFundo.Stroke.Kind := TBrushKind.None;
  RectFundo.HitTest := False;

  // === RODAPÉ (Bottom — must be before Client) ===
  LytRodape := TLayout.Create(RectFundo);
  LytRodape.Parent := RectFundo;
  LytRodape.Align := TAlignLayout.Bottom;
  LytRodape.Height := 36;
  LytRodape.Padding.Left  := 16;
  LytRodape.Padding.Right := 16;

  FLblRodape := TLabel.Create(LytRodape);
  FLblRodape.Parent := LytRodape;
  FLblRodape.Align := TAlignLayout.Left;
  FLblRodape.Width := 400;
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
  LblTitulo.Text := 'Agenda de Agendamentos';
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

  // Card 1 — Total Hoje
  RectCard := TRectangle.Create(LytKpis);
  RectCard.Parent := LytKpis;
  RectCard.Align := TAlignLayout.None;
  RectCard.Position.X := 0;
  RectCard.Position.Y := 0;
  RectCard.Width := 280;
  RectCard.Height := 100;
  RectCard.XRadius := 12;
  RectCard.YRadius := 12;
  RectCard.Fill.Color := $FF141C2B;
  RectCard.Stroke.Kind := TBrushKind.None;
  LblTit := TLabel.Create(RectCard);
  LblTit.Parent := RectCard;
  LblTit.Align := TAlignLayout.None;
  LblTit.Position.X := 16; LblTit.Position.Y := 12;
  LblTit.Width := 200; LblTit.Height := 18;
  LblTit.Text := 'Total Geral';
  LblTit.StyledSettings := [];
  LblTit.TextSettings.FontColor := $FF94A3B8;
  LblTit.TextSettings.Font.Size := 12;
  LblTit.HitTest := False;
  FLblKpiTotal := TLabel.Create(RectCard);
  FLblKpiTotal.Parent := RectCard;
  FLblKpiTotal.Align := TAlignLayout.None;
  FLblKpiTotal.Position.X := 16; FLblKpiTotal.Position.Y := 34;
  FLblKpiTotal.Width := 150; FLblKpiTotal.Height := 36;
  FLblKpiTotal.Text := '0';
  FLblKpiTotal.StyledSettings := [];
  FLblKpiTotal.TextSettings.FontColor := $FFFFFFFF;
  FLblKpiTotal.TextSettings.Font.Size := 28;
  FLblKpiTotal.TextSettings.Font.Style := [TFontStyle.fsBold];
  FLblKpiTotal.HitTest := False;
  LblSub := TLabel.Create(RectCard);
  LblSub.Parent := RectCard;
  LblSub.Align := TAlignLayout.None;
  LblSub.Position.X := 16; LblSub.Position.Y := 74;
  LblSub.Width := 200; LblSub.Height := 16;
  LblSub.Text := 'agendamentos';
  LblSub.StyledSettings := [];
  LblSub.TextSettings.FontColor := $FF64748B;
  LblSub.TextSettings.Font.Size := 11;
  LblSub.HitTest := False;

  // Card 2 — Pendentes
  RectCard := TRectangle.Create(LytKpis);
  RectCard.Parent := LytKpis;
  RectCard.Align := TAlignLayout.None;
  RectCard.Position.X := 288;
  RectCard.Position.Y := 0;
  RectCard.Width := 280;
  RectCard.Height := 100;
  RectCard.XRadius := 12;
  RectCard.YRadius := 12;
  RectCard.Fill.Color := $FF141C2B;
  RectCard.Stroke.Kind := TBrushKind.None;
  LblTit := TLabel.Create(RectCard);
  LblTit.Parent := RectCard;
  LblTit.Align := TAlignLayout.None;
  LblTit.Position.X := 16; LblTit.Position.Y := 12;
  LblTit.Width := 200; LblTit.Height := 18;
  LblTit.Text := 'Pendentes';
  LblTit.StyledSettings := [];
  LblTit.TextSettings.FontColor := $FF94A3B8;
  LblTit.TextSettings.Font.Size := 12;
  LblTit.HitTest := False;
  FLblKpiPendentes := TLabel.Create(RectCard);
  FLblKpiPendentes.Parent := RectCard;
  FLblKpiPendentes.Align := TAlignLayout.None;
  FLblKpiPendentes.Position.X := 16; FLblKpiPendentes.Position.Y := 34;
  FLblKpiPendentes.Width := 150; FLblKpiPendentes.Height := 36;
  FLblKpiPendentes.Text := '0';
  FLblKpiPendentes.StyledSettings := [];
  FLblKpiPendentes.TextSettings.FontColor := $FFFFFFFF;
  FLblKpiPendentes.TextSettings.Font.Size := 28;
  FLblKpiPendentes.TextSettings.Font.Style := [TFontStyle.fsBold];
  FLblKpiPendentes.HitTest := False;
  LblSub := TLabel.Create(RectCard);
  LblSub.Parent := RectCard;
  LblSub.Align := TAlignLayout.None;
  LblSub.Position.X := 16; LblSub.Position.Y := 74;
  LblSub.Width := 200; LblSub.Height := 16;
  LblSub.Text := 'aguardando';
  LblSub.StyledSettings := [];
  LblSub.TextSettings.FontColor := $FF64748B;
  LblSub.TextSettings.Font.Size := 11;
  LblSub.HitTest := False;

  // Card 3 — Em Andamento
  RectCard := TRectangle.Create(LytKpis);
  RectCard.Parent := LytKpis;
  RectCard.Align := TAlignLayout.None;
  RectCard.Position.X := 576;
  RectCard.Position.Y := 0;
  RectCard.Width := 280;
  RectCard.Height := 100;
  RectCard.XRadius := 12;
  RectCard.YRadius := 12;
  RectCard.Fill.Color := $FF141C2B;
  RectCard.Stroke.Kind := TBrushKind.None;
  LblTit := TLabel.Create(RectCard);
  LblTit.Parent := RectCard;
  LblTit.Align := TAlignLayout.None;
  LblTit.Position.X := 16; LblTit.Position.Y := 12;
  LblTit.Width := 200; LblTit.Height := 18;
  LblTit.Text := 'Em Andamento';
  LblTit.StyledSettings := [];
  LblTit.TextSettings.FontColor := $FF94A3B8;
  LblTit.TextSettings.Font.Size := 12;
  LblTit.HitTest := False;
  FLblKpiAndamento := TLabel.Create(RectCard);
  FLblKpiAndamento.Parent := RectCard;
  FLblKpiAndamento.Align := TAlignLayout.None;
  FLblKpiAndamento.Position.X := 16; FLblKpiAndamento.Position.Y := 34;
  FLblKpiAndamento.Width := 150; FLblKpiAndamento.Height := 36;
  FLblKpiAndamento.Text := '0';
  FLblKpiAndamento.StyledSettings := [];
  FLblKpiAndamento.TextSettings.FontColor := $FFFFFFFF;
  FLblKpiAndamento.TextSettings.Font.Size := 28;
  FLblKpiAndamento.TextSettings.Font.Style := [TFontStyle.fsBold];
  FLblKpiAndamento.HitTest := False;
  LblSub := TLabel.Create(RectCard);
  LblSub.Parent := RectCard;
  LblSub.Align := TAlignLayout.None;
  LblSub.Position.X := 16; LblSub.Position.Y := 74;
  LblSub.Width := 200; LblSub.Height := 16;
  LblSub.Text := 'em curso';
  LblSub.StyledSettings := [];
  LblSub.TextSettings.FontColor := $FF64748B;
  LblSub.TextSettings.Font.Size := 11;
  LblSub.HitTest := False;

  // Card 4 — Concluídos
  RectCard := TRectangle.Create(LytKpis);
  RectCard.Parent := LytKpis;
  RectCard.Align := TAlignLayout.None;
  RectCard.Position.X := 864;
  RectCard.Position.Y := 0;
  RectCard.Width := 280;
  RectCard.Height := 100;
  RectCard.XRadius := 12;
  RectCard.YRadius := 12;
  RectCard.Fill.Color := $FF141C2B;
  RectCard.Stroke.Kind := TBrushKind.None;
  LblTit := TLabel.Create(RectCard);
  LblTit.Parent := RectCard;
  LblTit.Align := TAlignLayout.None;
  LblTit.Position.X := 16; LblTit.Position.Y := 12;
  LblTit.Width := 200; LblTit.Height := 18;
  LblTit.Text := 'Conclu'#237'dos';
  LblTit.StyledSettings := [];
  LblTit.TextSettings.FontColor := $FF94A3B8;
  LblTit.TextSettings.Font.Size := 12;
  LblTit.HitTest := False;
  FLblKpiConcluidos := TLabel.Create(RectCard);
  FLblKpiConcluidos.Parent := RectCard;
  FLblKpiConcluidos.Align := TAlignLayout.None;
  FLblKpiConcluidos.Position.X := 16; FLblKpiConcluidos.Position.Y := 34;
  FLblKpiConcluidos.Width := 150; FLblKpiConcluidos.Height := 36;
  FLblKpiConcluidos.Text := '0';
  FLblKpiConcluidos.StyledSettings := [];
  FLblKpiConcluidos.TextSettings.FontColor := $FFFFFFFF;
  FLblKpiConcluidos.TextSettings.Font.Size := 28;
  FLblKpiConcluidos.TextSettings.Font.Style := [TFontStyle.fsBold];
  FLblKpiConcluidos.HitTest := False;
  LblSub := TLabel.Create(RectCard);
  LblSub.Parent := RectCard;
  LblSub.Align := TAlignLayout.None;
  LblSub.Position.X := 16; LblSub.Position.Y := 74;
  LblSub.Width := 200; LblSub.Height := 16;
  LblSub.Text := 'finalizados';
  LblSub.StyledSettings := [];
  LblSub.TextSettings.FontColor := $FF64748B;
  LblSub.TextSettings.Font.Size := 11;
  LblSub.HitTest := False;

  // === FILTROS DE STATUS ===
  LytFiltros := TLayout.Create(RectFundo);
  LytFiltros.Parent := RectFundo;
  LytFiltros.Align := TAlignLayout.Top;
  LytFiltros.Height := 52;
  LytFiltros.Padding.Left  := 16;
  LytFiltros.Padding.Right := 16;

  ScrollFiltros := THorzScrollBox.Create(LytFiltros);
  ScrollFiltros.Parent := LytFiltros;
  ScrollFiltros.Align := TAlignLayout.Client;

  CriarFiltroBtn(ScrollFiltros, 'Todos',          FRectFiltroTodos);
  CriarFiltroBtn(ScrollFiltros, 'Pendente',       FRectFiltroPendente);
  CriarFiltroBtn(ScrollFiltros, 'Em Andamento',   FRectFiltroAndamento);
  CriarFiltroBtn(ScrollFiltros, 'Conclu'#237'do', FRectFiltroConcluido);
  CriarFiltroBtn(ScrollFiltros, 'Cancelado',      FRectFiltroCancelado);

  FRectFiltroTodos.OnClick     := FiltroTodosClick;
  FRectFiltroPendente.OnClick  := FiltroPendenteClick;
  FRectFiltroAndamento.OnClick := FiltroAndamentoClick;
  FRectFiltroConcluido.OnClick := FiltroConcluidoClick;
  FRectFiltroCancelado.OnClick := FiltroCanceladoClick;

  DefinirFiltroAtivo(FRectFiltroTodos);

  // === CABEÇALHO DA TABELA ===
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

  CriarColHeader('CLIENTE',       8,   220);
  CriarColHeader('SERVI'#199'O',  228, 180);
  CriarColHeader('BARBEIRO',      408, 150);
  CriarColHeader('DATA / HORA',   558, 130);
  CriarColHeader('VALOR',         688, 90);
  CriarColHeader('STATUS',        778, 220);

  // === SCROLL DA LISTA (Client — after Bottom) ===
  FScrollLista := TVertScrollBox.Create(RectFundo);
  FScrollLista.Parent := RectFundo;
  FScrollLista.Align := TAlignLayout.Client;
  FScrollLista.Margins.Left   := 16;
  FScrollLista.Margins.Right  := 16;
  FScrollLista.Margins.Bottom := 4;

  AtualizarKPIs;
  CarregarAgendamentos;
end;

procedure TFrameAgenda.DefinirFiltroAtivo(RectAtivo: TRectangle);
var
  Rects: array[0..4] of TRectangle;
  I: Integer;
begin
  Rects[0] := FRectFiltroTodos;
  Rects[1] := FRectFiltroPendente;
  Rects[2] := FRectFiltroAndamento;
  Rects[3] := FRectFiltroConcluido;
  Rects[4] := FRectFiltroCancelado;
  for I := 0 to 4 do
  begin
    if Rects[I] = RectAtivo then
    begin
      Rects[I].Fill.Color := $FFF58A00;
      TLabel(Rects[I].Controls[0]).StyledSettings := [];
      TLabel(Rects[I].Controls[0]).TextSettings.FontColor := $FF0B1220;
    end
    else
    begin
      Rects[I].Fill.Color := $FF1E293B;
      TLabel(Rects[I].Controls[0]).StyledSettings := [];
      TLabel(Rects[I].Controls[0]).TextSettings.FontColor := $FF94A3B8;
    end;
  end;
end;

procedure TFrameAgenda.AtualizarKPIs;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text :=
      'SELECT ' +
      '(SELECT COUNT(*) FROM TB_AGENDAMENTOS) AS TOTAL,' +
      '(SELECT COUNT(*) FROM TB_AGENDAMENTOS WHERE STATUS = ''PENDENTE'') AS PEND,' +
      '(SELECT COUNT(*) FROM TB_AGENDAMENTOS WHERE STATUS = ''EM_ANDAMENTO'') AS ANDAMENTO,' +
      '(SELECT COUNT(*) FROM TB_AGENDAMENTOS WHERE STATUS = ''CONCLUIDO'') AS CONC ' +
      'FROM RDB$DATABASE';
    Q.Open;
    FLblKpiTotal.StyledSettings      := [];
    FLblKpiTotal.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiTotal.Text := Q.FieldByName('TOTAL').AsString;

    FLblKpiPendentes.StyledSettings         := [];
    FLblKpiPendentes.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiPendentes.Text := Q.FieldByName('PEND').AsString;

    FLblKpiAndamento.StyledSettings         := [];
    FLblKpiAndamento.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiAndamento.Text := Q.FieldByName('ANDAMENTO').AsString;

    FLblKpiConcluidos.StyledSettings         := [];
    FLblKpiConcluidos.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiConcluidos.Text := Q.FieldByName('CONC').AsString;
  finally
    Q.Free;
  end;
end;

procedure TFrameAgenda.LimparLinhas;
var
  I: Integer;
begin
  for I := FScrollLista.Content.ChildrenCount - 1 downto 0 do
    if FScrollLista.Content.Children[I].Tag = 93 then
      FScrollLista.Content.Children[I].Free;
end;

procedure TFrameAgenda.CarregarAgendamentos;
var
  Q: TFDQuery;
  SQL: string;
  Row: TRectangle;
  LblCliente, LblServico, LblBarbeiro, LblDataHora, LblValor: TLabel;
  RectStatus: TRectangle;
  LblStatus: TLabel;
  LytAcoes: TLayout;
  CboStatus: TComboBox;
  CorStatus: TAlphaColor;
  CorFundo: TAlphaColor;
  Status, DataHora: string;
  AgendID, Total: Integer;
begin
  LimparLinhas;
  Total := 0;

  SQL :=
    'SELECT A.ID, A.STATUS, A.DT_AGENDAMENTO, A.HR_INICIO, A.VALOR_COBRADO,' +
    ' U.NOME_COMPLETO AS CLIENTE,' +
    ' S.NOME AS SERVICO,' +
    ' UB.NOME_COMPLETO AS BARBEIRO' +
    ' FROM TB_AGENDAMENTOS A' +
    ' JOIN TB_USUARIOS U ON U.ID = A.CLIENTE_ID' +
    ' JOIN TB_SERVICOS S ON S.ID = A.SERVICO_ID' +
    ' JOIN TB_BARBEIROS B ON B.ID = A.BARBEIRO_ID' +
    ' JOIN TB_USUARIOS UB ON UB.ID = B.USUARIO_ID' +
    ' WHERE 1=1';

  if FFiltroStatus <> '' then
    SQL := SQL + ' AND A.STATUS = :STATUS';

  SQL := SQL + ' ORDER BY A.DT_AGENDAMENTO DESC, A.HR_INICIO DESC ROWS 50';

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text := SQL;
    if FFiltroStatus <> '' then
      Q.ParamByName('STATUS').AsString := FFiltroStatus;
    Q.Open;

    while not Q.EOF do
    begin
      Inc(Total);
      AgendID  := Q.FieldByName('ID').AsInteger;
      Status   := Q.FieldByName('STATUS').AsString;
      DataHora :=
        FormatDateTime('dd/mm/yy', Q.FieldByName('DT_AGENDAMENTO').AsDateTime) +
        ' ' + FormatDateTime('hh:nn', Q.FieldByName('HR_INICIO').AsDateTime);

      if Status = 'CONCLUIDO' then
        CorStatus := $FF22C55E
      else if Status = 'CANCELADO' then
        CorStatus := $FFEF4444
      else if Status = 'EM_ANDAMENTO' then
        CorStatus := $FF3B82F6
      else
        CorStatus := $FFF58A00;

      if Total mod 2 = 0 then
        CorFundo := $FF141C2B
      else
        CorFundo := $FF0F1929;

      Row := TRectangle.Create(FScrollLista);
      Row.Parent := FScrollLista;
      Row.Tag := 93;
      Row.Align := TAlignLayout.Top;
      Row.Height := 60;
      Row.Margins.Bottom := 2;
      Row.Fill.Color := CorFundo;
      Row.Stroke.Kind := TBrushKind.None;
      Row.HitTest := False;

      LblCliente := TLabel.Create(Row);
      LblCliente.Parent := Row;
      LblCliente.Position.X := 8;
      LblCliente.Position.Y := 12;
      LblCliente.Width := 218;
      LblCliente.Height := 36;
      LblCliente.Text := Q.FieldByName('CLIENTE').AsString;
      LblCliente.StyledSettings := [];
      LblCliente.TextSettings.FontColor := $FFFFFFFF;
      LblCliente.TextSettings.Font.Size := 13;
      LblCliente.WordWrap := True;
      LblCliente.HitTest := False;

      LblServico := TLabel.Create(Row);
      LblServico.Parent := Row;
      LblServico.Position.X := 228;
      LblServico.Position.Y := 20;
      LblServico.Width := 178;
      LblServico.Height := 20;
      LblServico.Text := Q.FieldByName('SERVICO').AsString;
      LblServico.StyledSettings := [];
      LblServico.TextSettings.FontColor := $FF94A3B8;
      LblServico.TextSettings.Font.Size := 12;
      LblServico.HitTest := False;

      LblBarbeiro := TLabel.Create(Row);
      LblBarbeiro.Parent := Row;
      LblBarbeiro.Position.X := 408;
      LblBarbeiro.Position.Y := 20;
      LblBarbeiro.Width := 148;
      LblBarbeiro.Height := 20;
      LblBarbeiro.Text := Q.FieldByName('BARBEIRO').AsString;
      LblBarbeiro.StyledSettings := [];
      LblBarbeiro.TextSettings.FontColor := $FF94A3B8;
      LblBarbeiro.TextSettings.Font.Size := 12;
      LblBarbeiro.HitTest := False;

      LblDataHora := TLabel.Create(Row);
      LblDataHora.Parent := Row;
      LblDataHora.Position.X := 558;
      LblDataHora.Position.Y := 20;
      LblDataHora.Width := 128;
      LblDataHora.Height := 20;
      LblDataHora.Text := DataHora;
      LblDataHora.StyledSettings := [];
      LblDataHora.TextSettings.FontColor := $FF94A3B8;
      LblDataHora.TextSettings.Font.Size := 12;
      LblDataHora.HitTest := False;

      LblValor := TLabel.Create(Row);
      LblValor.Parent := Row;
      LblValor.Position.X := 688;
      LblValor.Position.Y := 20;
      LblValor.Width := 88;
      LblValor.Height := 20;
      LblValor.Text := 'R$ ' + FormatFloat('#,##0.00', Q.FieldByName('VALOR_COBRADO').AsFloat);
      LblValor.StyledSettings := [];
      LblValor.TextSettings.FontColor := $FF4ADE80;
      LblValor.TextSettings.Font.Size := 12;
      LblValor.HitTest := False;

      LytAcoes := TLayout.Create(Row);
      LytAcoes.Parent := Row;
      LytAcoes.Position.X := 778;
      LytAcoes.Position.Y := 0;
      LytAcoes.Width := 310;
      LytAcoes.Height := 60;

      RectStatus := TRectangle.Create(LytAcoes);
      RectStatus.Parent := LytAcoes;
      RectStatus.Position.X := 0;
      RectStatus.Position.Y := 16;
      RectStatus.Width := 110;
      RectStatus.Height := 26;
      RectStatus.XRadius := 8;
      RectStatus.YRadius := 8;
      RectStatus.Fill.Color := CorStatus;
      RectStatus.Stroke.Kind := TBrushKind.None;
      RectStatus.HitTest := False;

      LblStatus := TLabel.Create(RectStatus);
      LblStatus.Parent := RectStatus;
      LblStatus.Align := TAlignLayout.Client;
      LblStatus.Text := IfThen(Status = 'EM_ANDAMENTO', 'EM ANDAMENTO', Status);
      LblStatus.StyledSettings := [];
      LblStatus.TextSettings.FontColor := $FF0B1220;
      LblStatus.TextSettings.Font.Size := 10;
      LblStatus.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblStatus.TextSettings.HorzAlign := TTextAlign.Center;
      LblStatus.TextSettings.VertAlign := TTextAlign.Center;
      LblStatus.HitTest := False;

      CboStatus := TComboBox.Create(LytAcoes);
      CboStatus.Parent := LytAcoes;
      CboStatus.Position.X := 118;
      CboStatus.Position.Y := 14;
      CboStatus.Width := 130;
      CboStatus.Height := 30;
      CboStatus.Items.Add('PENDENTE');
      CboStatus.Items.Add('EM_ANDAMENTO');
      CboStatus.Items.Add('CONCLUIDO');
      CboStatus.Items.Add('CANCELADO');
      CboStatus.ItemIndex := CboStatus.Items.IndexOf(Status);
      CboStatus.Tag := AgendID;
      CboStatus.OnChange := AlterarStatusClick;

      Q.Next;
    end;

    FScrollLista.Content.Height := Total * 62 + 20;
  finally
    Q.Free;
  end;

  FLblSubtitulo.StyledSettings := [];
  FLblSubtitulo.TextSettings.FontColor := $FF94A3B8;
  FLblSubtitulo.Text := IntToStr(Total) + ' agendamento(s) encontrado(s)';
  FLblRodape.Text := 'Exibindo ' + IntToStr(Total) + ' de 50 mais recentes';
end;

procedure TFrameAgenda.AlterarStatusClick(Sender: TObject);
var
  Cbo: TComboBox;
  Q: TFDQuery;
  NovoStatus: string;
  AgendID: Integer;
begin
  Cbo := TComboBox(Sender);
  if Cbo.ItemIndex < 0 then Exit;
  NovoStatus := Cbo.Items[Cbo.ItemIndex];
  AgendID    := Cbo.Tag;

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text :=
      'UPDATE TB_AGENDAMENTOS SET STATUS = :STATUS WHERE ID = :ID';
    Q.ParamByName('STATUS').AsString  := NovoStatus;
    Q.ParamByName('ID').AsInteger     := AgendID;
    Q.ExecSQL;
  finally
    Q.Free;
  end;

  AtualizarKPIs;
  TThread.ForceQueue(nil, procedure begin CarregarAgendamentos; end);
end;

procedure TFrameAgenda.AplicarFiltroStatus(const Status: string);
begin
  FFiltroStatus := Status;
  CarregarAgendamentos;
end;

procedure TFrameAgenda.FiltroTodosClick(Sender: TObject);
begin
  DefinirFiltroAtivo(FRectFiltroTodos);
  AplicarFiltroStatus('');
end;

procedure TFrameAgenda.FiltroPendenteClick(Sender: TObject);
begin
  DefinirFiltroAtivo(FRectFiltroPendente);
  AplicarFiltroStatus('PENDENTE');
end;

procedure TFrameAgenda.FiltroAndamentoClick(Sender: TObject);
begin
  DefinirFiltroAtivo(FRectFiltroAndamento);
  AplicarFiltroStatus('EM_ANDAMENTO');
end;

procedure TFrameAgenda.FiltroConcluidoClick(Sender: TObject);
begin
  DefinirFiltroAtivo(FRectFiltroConcluido);
  AplicarFiltroStatus('CONCLUIDO');
end;

procedure TFrameAgenda.FiltroCanceladoClick(Sender: TObject);
begin
  DefinirFiltroAtivo(FRectFiltroCancelado);
  AplicarFiltroStatus('CANCELADO');
end;

end.
