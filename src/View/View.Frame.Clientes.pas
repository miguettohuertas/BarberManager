unit View.Frame.Clientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.ListBox,
  FMX.ScrollBox;

type
  TFrameClientes = class(TFrame)
  private
    FBusca: string;
    FScrollLista: TVertScrollBox;
    FLblSubtitulo: TLabel;
    FLblRodape: TLabel;
    FLblKpiTotal: TLabel;
    FLblKpiAtivos: TLabel;
    FLblKpiNovos: TLabel;
    FEdtBusca: TEdit;
    procedure CarregarClientes;
    procedure LimparLinhas;
    procedure AtualizarKPIs;
    procedure BuscaChange(Sender: TObject);
    procedure AcaoVerAgendamentosClick(Sender: TObject);
    procedure AcaoToggleAtivoClick(Sender: TObject);
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  FMX.DialogService;

procedure TFrameClientes.AfterConstruction;
var
  RectFundo: TRectangle;
  LytRodape: TLayout;
  LytHeader: TLayout;
  LblTitulo: TLabel;
  LytKpis: TLayout;
  LytBusca: TLayout;
  RectBg: TRectangle;
  LytHeaderTabela: TLayout;
  RectHeaderTab: TRectangle;

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
  FBusca := '';

  // === FUNDO ===
  RectFundo := TRectangle.Create(Self);
  RectFundo.Parent := Self;
  RectFundo.Align := TAlignLayout.Client;
  RectFundo.Fill.Color := $FF0B1220;
  RectFundo.Stroke.Kind := TBrushKind.None;
  RectFundo.HitTest := False;

  // === RODAP'#202' (Bottom — deve vir antes do Client) ===
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
  LblTitulo.Text := 'Gest'#227'o de Clientes';
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

  CriarKpiCard(LytKpis, 0,   380, 'Total de Clientes',  FLblKpiTotal,  'cadastrados');
  CriarKpiCard(LytKpis, 388, 380, 'Clientes Ativos',    FLblKpiAtivos, 'com acesso');
  CriarKpiCard(LytKpis, 776, 300, 'Novos este M'#234's', FLblKpiNovos, 'cadastros');

  // === BUSCA ===
  LytBusca := TLayout.Create(RectFundo);
  LytBusca.Parent := RectFundo;
  LytBusca.Align := TAlignLayout.Top;
  LytBusca.Height := 52;
  LytBusca.Margins.Left   := 16;
  LytBusca.Margins.Right  := 16;
  LytBusca.Margins.Bottom := 8;

  RectBg := TRectangle.Create(LytBusca);
  RectBg.Parent := LytBusca;
  RectBg.Align := TAlignLayout.Client;
  RectBg.Fill.Color := $FF141C2B;
  RectBg.Stroke.Kind := TBrushKind.None;
  RectBg.XRadius := 8;
  RectBg.YRadius := 8;

  FEdtBusca := TEdit.Create(RectBg);
  FEdtBusca.Parent := RectBg;
  FEdtBusca.Align := TAlignLayout.Client;
  FEdtBusca.Margins.Left   := 12;
  FEdtBusca.Margins.Right  := 12;
  FEdtBusca.Margins.Top    := 6;
  FEdtBusca.Margins.Bottom := 6;
  FEdtBusca.TextPrompt := 'Buscar cliente por nome ou e-mail...';
  FEdtBusca.OnChangeTracking := BuscaChange;

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

  CriarColHeader('CLIENTE',       8,   280);
  CriarColHeader('E-MAIL',        288, 240);
  CriarColHeader('CADASTRO',      528, 130);
  CriarColHeader('STATUS',        658, 100);
  CriarColHeader('A'#199#213'ES', 758, 120);

  // === SCROLL DA LISTA (Client — ap'#243's Bottom e Top) ===
  FScrollLista := TVertScrollBox.Create(RectFundo);
  FScrollLista.Parent := RectFundo;
  FScrollLista.Align := TAlignLayout.Client;
  FScrollLista.Margins.Left   := 16;
  FScrollLista.Margins.Right  := 16;
  FScrollLista.Margins.Bottom := 4;

  AtualizarKPIs;
  CarregarClientes;
end;

procedure TFrameClientes.AtualizarKPIs;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text :=
      'SELECT ' +
      '(SELECT COUNT(*) FROM TB_USUARIOS WHERE PERFIL=''CLIENTE'') AS TOTAL,' +
      '(SELECT COUNT(*) FROM TB_USUARIOS WHERE PERFIL=''CLIENTE'' AND ATIVO=1) AS ATIVOS,' +
      '(SELECT COUNT(*) FROM TB_USUARIOS WHERE PERFIL=''CLIENTE''' +
      ' AND EXTRACT(MONTH FROM DT_CADASTRO)=EXTRACT(MONTH FROM CURRENT_DATE)' +
      ' AND EXTRACT(YEAR FROM DT_CADASTRO)=EXTRACT(YEAR FROM CURRENT_DATE)) AS NOVOS ' +
      'FROM RDB$DATABASE';
    Q.Open;
    FLblKpiTotal.StyledSettings := [];
    FLblKpiTotal.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiTotal.Text := Q.FieldByName('TOTAL').AsString;
    FLblKpiAtivos.StyledSettings := [];
    FLblKpiAtivos.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiAtivos.Text := Q.FieldByName('ATIVOS').AsString;
    FLblKpiNovos.StyledSettings := [];
    FLblKpiNovos.TextSettings.FontColor := $FFFFFFFF;
    FLblKpiNovos.Text := Q.FieldByName('NOVOS').AsString;
  finally
    Q.Free;
  end;
end;

procedure TFrameClientes.LimparLinhas;
var
  I: Integer;
begin
  for I := FScrollLista.Content.ChildrenCount - 1 downto 0 do
    if FScrollLista.Content.Children[I].Tag = 92 then
      FScrollLista.Content.Children[I].Free;
end;

procedure TFrameClientes.CarregarClientes;
var
  Q: TFDQuery;
  SQL: string;
  Row: TRectangle;
  RectAvatar: TRectangle;
  LblInicial, LblNome, LblEmail, LblCadastro: TLabel;
  RectBadge: TRectangle;
  LblStatus: TLabel;
  LytAcoes: TLayout;
  LblAgend, LblToggle: TLabel;
  Ativo: Integer;
  Nome: string;
  CorFundo: TAlphaColor;
  Total: Integer;
begin
  LimparLinhas;
  Total := 0;

  SQL :=
    'SELECT ID, NOME_COMPLETO, EMAIL, DT_CADASTRO, ATIVO ' +
    'FROM TB_USUARIOS WHERE PERFIL = ''CLIENTE''';
  if FBusca <> '' then
    SQL := SQL +
      ' AND (UPPER(NOME_COMPLETO) CONTAINING UPPER(:BUSCA)' +
      ' OR UPPER(EMAIL) CONTAINING UPPER(:BUSCA))';
  SQL := SQL + ' ORDER BY NOME_COMPLETO';

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text := SQL;
    if FBusca <> '' then
      Q.ParamByName('BUSCA').AsString := FBusca;
    Q.Open;

    while not Q.EOF do
    begin
      Inc(Total);
      Nome := Q.FieldByName('NOME_COMPLETO').AsString;
      Ativo := Q.FieldByName('ATIVO').AsInteger;

      if Total mod 2 = 0 then
        CorFundo := $FF141C2B
      else
        CorFundo := $FF0F1929;

      Row := TRectangle.Create(FScrollLista);
      Row.Parent := FScrollLista;
      Row.Tag := 92;
      Row.Align := TAlignLayout.Top;
      Row.Height := 60;
      Row.Margins.Bottom := 2;
      Row.Fill.Color := CorFundo;
      Row.Stroke.Kind := TBrushKind.None;
      Row.HitTest := False;

      // Avatar
      RectAvatar := TRectangle.Create(Row);
      RectAvatar.Parent := Row;
      RectAvatar.Position.X := 8;
      RectAvatar.Position.Y := 12;
      RectAvatar.Width := 36;
      RectAvatar.Height := 36;
      RectAvatar.XRadius := 20;
      RectAvatar.YRadius := 20;
      RectAvatar.Fill.Color := $FF1D4ED8;
      RectAvatar.Stroke.Kind := TBrushKind.None;
      RectAvatar.HitTest := False;

      LblInicial := TLabel.Create(RectAvatar);
      LblInicial.Parent := RectAvatar;
      LblInicial.Align := TAlignLayout.Client;
      LblInicial.Text := Copy(Nome, 1, 1);
      LblInicial.StyledSettings := [];
      LblInicial.TextSettings.FontColor := $FFFFFFFF;
      LblInicial.TextSettings.Font.Size := 15;
      LblInicial.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblInicial.TextSettings.HorzAlign := TTextAlign.Center;
      LblInicial.TextSettings.VertAlign := TTextAlign.Center;
      LblInicial.HitTest := False;

      // Nome
      LblNome := TLabel.Create(Row);
      LblNome.Parent := Row;
      LblNome.Position.X := 52;
      LblNome.Position.Y := 10;
      LblNome.Width := 224;
      LblNome.Height := 20;
      LblNome.Text := Nome;
      LblNome.StyledSettings := [];
      LblNome.TextSettings.FontColor := $FFFFFFFF;
      LblNome.TextSettings.Font.Size := 13;
      LblNome.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblNome.HitTest := False;

      // Email
      LblEmail := TLabel.Create(Row);
      LblEmail.Parent := Row;
      LblEmail.Position.X := 52;
      LblEmail.Position.Y := 30;
      LblEmail.Width := 224;
      LblEmail.Height := 18;
      LblEmail.Text := Q.FieldByName('EMAIL').AsString;
      LblEmail.StyledSettings := [];
      LblEmail.TextSettings.FontColor := $FF94A3B8;
      LblEmail.TextSettings.Font.Size := 11;
      LblEmail.HitTest := False;

      // Data de cadastro
      LblCadastro := TLabel.Create(Row);
      LblCadastro.Parent := Row;
      LblCadastro.Position.X := 288;
      LblCadastro.Position.Y := 20;
      LblCadastro.Width := 238;
      LblCadastro.Height := 20;
      LblCadastro.Text := FormatDateTime('dd/mm/yyyy',
        Q.FieldByName('DT_CADASTRO').AsDateTime);
      LblCadastro.StyledSettings := [];
      LblCadastro.TextSettings.FontColor := $FF94A3B8;
      LblCadastro.TextSettings.Font.Size := 12;
      LblCadastro.HitTest := False;

      // Badge de status
      RectBadge := TRectangle.Create(Row);
      RectBadge.Parent := Row;
      RectBadge.Position.X := 528;
      RectBadge.Position.Y := 16;
      RectBadge.Width := 80;
      RectBadge.Height := 28;
      RectBadge.XRadius := 8;
      RectBadge.YRadius := 8;
      RectBadge.Stroke.Kind := TBrushKind.None;
      RectBadge.HitTest := False;

      LblStatus := TLabel.Create(RectBadge);
      LblStatus.Parent := RectBadge;
      LblStatus.Align := TAlignLayout.Client;
      LblStatus.StyledSettings := [];
      LblStatus.TextSettings.Font.Size := 11;
      LblStatus.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblStatus.TextSettings.HorzAlign := TTextAlign.Center;
      LblStatus.TextSettings.VertAlign := TTextAlign.Center;
      LblStatus.HitTest := False;

      if Ativo = 1 then
      begin
        RectBadge.Fill.Color := $FF166534;
        LblStatus.Text := 'Ativo';
        LblStatus.TextSettings.FontColor := $FF4ADE80;
      end
      else
      begin
        RectBadge.Fill.Color := $FF7F1D1D;
        LblStatus.Text := 'Inativo';
        LblStatus.TextSettings.FontColor := $FFEF4444;
      end;

      // Layout de a'#231#245'es
      LytAcoes := TLayout.Create(Row);
      LytAcoes.Parent := Row;
      LytAcoes.Position.X := 658;
      LytAcoes.Position.Y := 0;
      LytAcoes.Width := 160;
      LytAcoes.Height := 60;

      LblAgend := TLabel.Create(LytAcoes);
      LblAgend.Parent := LytAcoes;
      LblAgend.Position.X := 4;
      LblAgend.Position.Y := 18;
      LblAgend.Width := 60;
      LblAgend.Height := 24;
      LblAgend.Text := #$D83D#$DCC5; // emoji calendario
      LblAgend.StyledSettings := [];
      LblAgend.TextSettings.Font.Size := 18;
      LblAgend.TextSettings.HorzAlign := TTextAlign.Center;
      LblAgend.HitTest := True;
      LblAgend.Cursor := crHandPoint;
      LblAgend.Tag := Q.FieldByName('ID').AsInteger;
      LblAgend.OnClick := AcaoVerAgendamentosClick;

      LblToggle := TLabel.Create(LytAcoes);
      LblToggle.Parent := LytAcoes;
      LblToggle.Position.X := 68;
      LblToggle.Position.Y := 18;
      LblToggle.Width := 60;
      LblToggle.Height := 24;
      LblToggle.StyledSettings := [];
      LblToggle.TextSettings.Font.Size := 12;
      LblToggle.TextSettings.Font.Style := [TFontStyle.fsBold];
      LblToggle.TextSettings.HorzAlign := TTextAlign.Center;
      LblToggle.HitTest := True;
      LblToggle.Cursor := crHandPoint;
      LblToggle.Tag := Q.FieldByName('ID').AsInteger;
      LblToggle.OnClick := AcaoToggleAtivoClick;

      if Ativo = 1 then
      begin
        LblToggle.Text := 'ON';
        LblToggle.TextSettings.FontColor := $FF4ADE80;
      end
      else
      begin
        LblToggle.Text := 'OFF';
        LblToggle.TextSettings.FontColor := $FFEF4444;
      end;

      Q.Next;
    end;

    FScrollLista.Content.Height := Total * 62 + 20;
  finally
    Q.Free;
  end;

  FLblSubtitulo.StyledSettings := [];
  FLblSubtitulo.TextSettings.FontColor := $FF94A3B8;
  FLblSubtitulo.Text := IntToStr(Total) + ' cliente(s) encontrado(s)';
  FLblRodape.Text := 'Exibindo ' + IntToStr(Total) + ' cliente(s)';
end;

procedure TFrameClientes.BuscaChange(Sender: TObject);
begin
  FBusca := FEdtBusca.Text;
  CarregarClientes;
end;

procedure TFrameClientes.AcaoVerAgendamentosClick(Sender: TObject);
begin
  TDialogService.ShowMessage(
    'Agendamentos do cliente ID: ' + IntToStr(TLabel(Sender).Tag));
end;

procedure TFrameClientes.AcaoToggleAtivoClick(Sender: TObject);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmConexao.FDConnection1;
    Q.SQL.Text :=
      'UPDATE TB_USUARIOS SET ATIVO = (1 - ATIVO) WHERE ID = :ID';
    Q.ParamByName('ID').AsInteger := TLabel(Sender).Tag;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
  AtualizarKPIs;
  CarregarClientes;
end;

end.
