# BarberManager — Contexto do Projecto para Claude

## Descrição
Sistema de gestão de barbearia desenvolvido em Delphi 12 FMX.
Inclui painel de cliente (agendamento de serviços) e painel de administrador (dashboard com KPIs, gestão de serviços).

---

## Stack Tecnológica

| Componente    | Versão / Detalhe                                      |
|---------------|-------------------------------------------------------|
| IDE           | Delphi 12 Athens                                      |
| UI Framework  | FireMonkey (FMX) — cross-platform, mobile-first       |
| Base de dados | Firebird 3.0                                          |
| Acesso a dados| FireDAC (componentes criados por código, nunca no designer) |
| Linguagem     | Object Pascal                                         |

---

## Caminhos Importantes

| Recurso          | Caminho                                                                          |
|------------------|----------------------------------------------------------------------------------|
| Raiz do projecto | `C:\ProjetosDelphi\BarberManager\BarberManager\`                                 |
| Banco de dados   | `C:\ProjetosDelphi\BarberManager\BarberManager\database\BARBERMANAGER.FDB`       |
| fbclient.dll     | `C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll`                     |
| Utilizador DB    | `SYSDBA`                                                                         |
| Password DB      | `masterkey`                                                                      |
| CharacterSet     | `UTF8`                                                                           |
| Protocol         | `Local`                                                                          |

---

## Estrutura de Pastas

```
BarberManager/
├── database/
│   └── BARBERMANAGER.FDB
├── docs/
├── src/
│   ├── Model/
│   │   ├── Model.Conexao.pas   — DataModule de ligação ao Firebird (FireDAC por código)
│   │   └── Model.Conexao.dfm
│   └── View/
│       ├── View.Principal.pas  — Form principal (Login, Home cliente, Agendamento)
│       ├── View.Principal.fmx
│       ├── View.DashboardAdmin.pas  — Dashboard do administrador
│       ├── View.DashboardAdmin.fmx
│       ├── View.Frame.Servicos.pas  — Frame de gestão de serviços (visual pronto, lógica pendente)
│       └── View.Frame.Servicos.fmx
├── CLAUDE.md
└── README.md
```

---

## Tabelas da Base de Dados

| Tabela            | Descrição                                          |
|-------------------|----------------------------------------------------|
| `TB_USUARIOS`     | Clientes e utilizadores do sistema. Colunas: ID, NOME_COMPLETO, EMAIL, SENHA_HASH (SHA-256 uppercase), PERFIL ('ADMIN'/'CLIENTE'), ATIVO, DT_CADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP |
| `TB_SERVICOS`     | Catálogo de serviços. Colunas: ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, CATEGORIA_ID (FK → TB_CATEGORIAS), BADGE, ATIVO |
| `TB_CATEGORIAS`   | Categorias de serviços. Colunas: ID, NOME (ex: 'Cabelo', 'Barba', 'Estética') |
| `TB_BARBEIROS`    | Barbeiros. Colunas: ID, USUARIO_ID (FK → TB_USUARIOS), CARGO, AVALIACAO_MEDIA, ATIVO |
| `TB_AGENDAMENTOS` | Agendamentos. Colunas: ID, CLIENTE_ID, BARBEIRO_ID, SERVICO_ID, DT_AGENDAMENTO, HR_INICIO, HR_FIM, STATUS ('PENDENTE'/'EM_ANDAMENTO'/'CONCLUIDO'/'CANCELADO'), VALOR_COBRADO |
| `TB_AVALIACOES`   | Avaliações de serviço. Colunas: ID, AGENDAMENTO_ID (FK TB_AGENDAMENTOS), CLIENTE_ID (FK TB_USUARIOS), BARBEIRO_ID (FK TB_BARBEIROS), NOTA INTEGER (1-5), COMENTARIO VARCHAR(500), DT_AVALIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP |
| `TB_CONFIGURACOES` | Configurações da barbearia. Colunas: ID, CHAVE VARCHAR(50) UNIQUE, VALOR VARCHAR(255), DESCRICAO VARCHAR(255) |

---

## O que já está implementado

### Model.Conexao.pas
- `TdmConexao` DataModule criado inteiramente por código (sem componentes no .dfm)
- `FDConnection1` e `FDPhysFBDriverLink1` declarados como `public` (acedidos externamente)
- Função `Conectar` configura VendorLib, DriverID='FB', Protocol=Local, UTF8
- Variável global `dmConexao` instanciada no arranque da aplicação

### View.Principal.pas — Form principal com 4 tabs:
1. **TabLogin** — Login real: query a TB_USUARIOS com SHA-256 (`THashSHA2.GetHashString` + `UpperCase`). Redireciona para Home (CLIENTE) ou DashboardAdmin (ADMIN).
2. **TabNovaConta** — Cadastro real de utilizador:
   - Campos: nome completo, email, senha, confirmar senha, checkbox de termos
   - Validações: nome obrigatório, `ValidarEmail` (verifica `@` e `.`), senha ≥ 6 chars, confirmação, termos aceites
   - Verifica email duplicado via `COUNT(*)` antes do INSERT
   - INSERT em TB_USUARIOS com `SENHA_HASH = HashSenha(senha)` e `PERFIL = 'CLIENTE'`
   - Evento: `rectBtnCadastrarClick` (ligado via `OnClick` no `.fmx`; `SpeedButton1` sobreposto tem `HitTest = False`)
3. **TabHome** — Home do cliente:
   - Banner de oferta dinâmico (`CarregarBannerOferta`): primeiro serviço com `BADGE <> ''` de TB_SERVICOS; mostra nome + "com 20% de desconto"
   - Cards de serviços carregados dinamicamente via JOIN TB_SERVICOS + TB_CATEGORIAS (`CarregarServicos(Filtro, Busca)`)
   - Filtros de categoria: Todos / Cabelo / Barba / Estética (`AplicarFiltroCategoria`) — fix de encoding: comparação com `Pos('EST', UpperCase(...))` em vez de `= 'ESTÉTICA'`
   - Campo de busca em tempo real (`edtBuscaChange` via `OnChangeTracking`): usa `CONTAINING` do Firebird; quando activo reseta visual dos filtros para "Todos"
   - "Ver Todos >" (`lblVerTodosClick`): limpa busca + aplica filtro Todos + scroll para lista
   - Clique num card abre o ecrã de agendamento (`AbrirAgendamento`)
4. **TabAgendamento** — Agendamento completo:
   - Acessível pelo menu inferior mesmo sem serviço seleccionado (`lytMenuAgendaClick`): mostra estado neutro com placeholders, carrega barbeiros e horários
   - Cards de barbeiros carregados de TB_BARBEIROS + TB_USUARIOS com CARGO e AVALIACAO_MEDIA (`CarregarBarbeiros`)
   - 20 slots de horário em `flowHorarios` com estados disponível/ocupado (`CarregarHorarios`) — horários ocupados hardcoded (pendente: verificar TB_AGENDAMENTOS)
   - Variáveis de sessão: `FServicoIDSelecionado`, `FBarbeiroIDSelecionado`, `FHoraSelecionada`, `FDataSelecionada`, etc.
   - `AbrirAgendamento`: preenche todos os labels do card `rectServicoAgendar` incluindo `lblBadgeSelecionado` e `lblResumoData` com data formatada
   - Botão Confirmar: valida sessão com mensagens específicas por campo, calcula `HR_FIM` com `IncMinute`, insere em TB_AGENDAMENTOS
   - Após confirmação: reset completo do estado + `CarregarHorarios` + `CarregarBarbeiros` + `CarregarServicos('')`; labels `lblPrecoServico` e `lblTempoServico` (AutoSize=True) resetados para `'R$ 0,00'` e `'-- min'` para evitar colapso de layout

### Novas funcionalidades implementadas (View.Principal.pas):

**Banner de Oferta — botão "Aproveitar >"**
- `rectBtnAproveitarClick`: query a `TB_SERVICOS WHERE BADGE <> '' AND ATIVO = 1`, aplica 20% de desconto e chama `AbrirAgendamento`
- `HitTest = True` no `rectBtnAproveitar`, `HitTest = False` no `lblAproveitar` (regra crítica respeitada)

**Reset ao voltar do Agendamento**
- `rectBtnVoltarAgendarClick`: após `SetActiveTabWithTransition`, reset completo de todas as variáveis de sessão e labels
- `lblPrecoServico='R$ 0,00'`, `lblTempoServico='-- min'` (nunca `''` — regra AutoSize respeitada)
- `rectBadgeSelecionado.Visible := False`

**Imagens reais nos cards de serviços**
- `GetImagemPorCategoria(Categoria): string` — função private que resolve caminho absoluto via `ExtractFilePath(ParamStr(0)) + '..\..\..'` + `src\assets\img\servico_[categoria].jpg`
- Imagens: `servico_cabelo.jpg`, `servico_barba.jpg`, `servico_estetica.jpg`, `servico_combo.jpg`
- `TImage` criado em runtime dentro de `RectIcone` com `WrapMode=Stretch`, `Align=Client`, `HitTest=False`
- `FileExists()` protege o `LoadFromFile`
- `System.IOUtils` adicionado às uses da implementation

**Popup de Notificações**
- `rectOverlayNotif`: overlay `Align=Contents`, `Fill=$CC000000`, `Visible=False` — inserido como último filho de `rectFundoHome`
- `rectPainelNotif`: painel 380×400 com `XRadius=16`
- `scrollNotificacoes`: `TVertScrollBox` `Width=360` (margem 10px)
- `CarregarNotificacoes`: query `TB_AGENDAMENTOS JOIN TB_SERVICOS ORDER BY DT_AGENDAMENTO DESC ROWS 10`; cards dinâmicos com `Tag=88`, `TImage` com ícone de sino (`docs\images\iconamoon--notification.png`), cor por status
- `imgNotificacaoClick`: `CarregarNotificacoes` + overlay visible + `BringToFront`
- `lblFecharNotifClick`: overlay invisible
- `CLIENTE_ID` usa agora `FUsuarioID` real (hardcode removido)

**Sessão de utilizador — completa**
- Variáveis de sessão declaradas na `private`: `FUsuarioID: Integer`, `FUsuarioNome: string`, `FUsuarioEmail: string`, `FUsuarioPerfil: string`
- `rectBtnEntrarClick`: SELECT inclui EMAIL, preenche as 4 variáveis de sessão após login, redirecionamento condicional: `ADMIN → FrmDashboardAdmin.Show` / `CLIENTE → TabClienteHome`
- `LimparSessao`: método `public` que zera as 4 variáveis de sessão
- `rectMenuSairClick` (DashboardAdmin): chama `FrmPrincipal.LimparSessao` antes de esconder o dashboard
- `CLIENTE_ID` real em `CarregarNotificacoes` e `rectBtnConfirmarClick` (substituído o hardcode `= 1`)

**Segurança — atalho de dev removido**
- `imgLogoAppClick` removido completamente (`.fmx` + `.pas`) — era atalho directo para DashboardAdmin
- `imgIconePerfil`: `HitTest = False` adicionado — fix de cliques bloqueados pelo filho com `Align=Client`

**Popup de Perfil do utilizador**
- `rectOverlayPerfil`: overlay `Align=Contents`, `Fill=$CC000000`, `Visible=False` — após `rectOverlayNotif` dentro de `rectFundoHome`
- `circleAvatarPerfil`: círculo laranja `$FFF58A00` com inicial do nome (`lblInicialPerfil`)
- `lblNomePerfilPopup`, `lblEmailPerfilPopup`: dados da sessão
- `rectBadgePerfil` + `lblBadgePerfil`: badge colorido por perfil — ADMIN → roxo (`$FF3B1F6B` / `$FFA78BFA`), CLIENTE → azul (`$FF1E3A5F` / `$FF60A5FA`)
- `rectBtnLogout`: botão vermelho `$FF7F1D1D`, texto `$FFEF4444`
- `AbrirPopupPerfil`: preenche dados da sessão + badge por perfil + `BringToFront`
- `circlePerfilClick` → `AbrirPopupPerfil`; `lblFecharPerfilClick` → fecha overlay; `rectBtnLogoutClick` → fecha overlay + `LimparSessao` + `TabLogin`

**Calendário dinâmico (Agendamento)**
- `FMesAtual: TDate`, `FDatasCalendario: array[0..6] of TDate`
- `PopularCalendario`: preenche os 7 slots com dias reais, `lblMesAtual` com mês/ano em português, visual laranja no dia seleccionado (`$FFF58A00`), neutro (`$FF1E293B`)
- `DiaSemanaAbrev`: função que retorna `Dom`/`Seg`/`Ter`/`Qua`/`Qui`/`Sex`/`Sáb`
- `DiaSelecionadoClick`: handler único para os 7 `rectDia*`, actualiza `FDataSelecionada` e redesenha calendário
- `rectSetaAnteriorClick` / `rectSetaProximoClick`: navegação entre meses com `IncMonth`
- 20 `rectHora*` estáticos removidos do `.fmx` e `.pas` (491 linhas eliminadas — código mais limpo)
- `flowHorarios.Height` ajustado para 220
- Margem `lblTituloBarbeiros` ajustada para 20

**Segurança adicional**
- `LimparSessao`: limpa também `edtEmail` e `edtSenha` para não deixar dados do login anterior visíveis

**Menu inferior dinâmico**
- `AtualizarMenuAtivo(Index)`: actualiza cor dos 4 labels do menu — laranja (`$FFF58A00`) para activo, cinzento (`$FF94A3B8`) para inactivo
- `lytMenuInicioClick`, `lytMenuCarrinhoClick`, `lytMenuPerfilClick`: novos handlers ligados no `.fmx`
- `imgMenuInicio`, `imgMenuCarrinho`, `imgMenuPerfil`: `HitTest = False` adicionado (fix de cliques — `TImage` tem `HitTest = True` por defeito e interceptava os toques)
- Fix margens popup Notificações e Perfil: `rectPainelNotif` Width 380→360, `rectPainelPerfil` Width 380→360, elementos internos ajustados; `lblFecharNotif`/`lblFecharPerfil` `Position.X` 340→320

**Tela Carrinho (Meus Agendamentos)**
- `tabCarrinho`: nova `TTabItem` após `tabAgendamento`
- `CarregarCarrinho`: query `TB_AGENDAMENTOS JOIN TB_SERVICOS JOIN TB_BARBEIROS JOIN TB_USUARIOS WHERE CLIENTE_ID = FUsuarioID ORDER BY DT_AGENDAMENTO DESC`
- Cards dinâmicos `Tag=85` com: nome serviço (branco, bold), barbeiro (cinzento), data+hora, valor (laranja), badge de status colorido (CONCLUIDO→verde, PENDENTE→laranja, CANCELADO→vermelho, EM_ANDAMENTO→azul)
- Cards `CONCLUIDO` têm `HitTest=True` + `OnClick=CardAvaliacaoClick` + `TLabel` oculto (Visible=False) com `Text='AgendID|BarbID|BarbNome'` para transportar dados
- `rectMenuInfCarrinho`: menu inferior replicado na tab Carrinho com `TGridPanelLayout` e 4 botões (Inicio/Agenda/Carrinho/Perfil) reutilizando os handlers existentes; "Carrinho" aparece laranja (estado activo)
- `imgMenuInicioC/AgendaC/CarrinhoC/PerfilC`: `TImage` nos 4 botões do menu Carrinho; `CarregarIconesMenuCarrinho` carrega os PNG em runtime via `LoadFromFile`
- `rectOverlayPerfilC`: overlay de perfil duplicado para a tab Carrinho (`*C` suffix); `lytMenuPerfilClick` detecta tab activa e abre o overlay correcto
- `AtualizarMenuAtivo(Index)`: array[0..7] — Labels[0..3] = Home, Labels[4..7] = Carrinho; ambos coloridos simultaneamente
- `rectOverlayAvaliacao`: overlay de avaliação em `rectFundoCarrinho`; painel X=10/Y=70/W=360/H=380; contém: título, subtítulo com nome barbeiro, 5 estrelas clicáveis (`lblEstrela1-5`, `Tag=1-5`, `OnClick=EstrelaAvaliacaoClick`), `lblNotaAtual`, separador, `edtComentarioAvaliacao`, `rectBtnAvaliar`
- `AtualizarEstrelas(Nota)`: pinta ★ (amarelo `$FFFBBF24`) até Nota, ☆ (cinzento) acima; actualiza `lblNotaAtual`
- `rectBtnAvaliarClick`: valida nota>0, verifica duplicado em `TB_AVALIACOES`, INSERT + UPDATE `AVALIACAO_MEDIA` em `TB_BARBEIROS`; exibe mensagem; chama `CarregarCarrinho`
- **Pré-requisito**: tabela `TB_AVALIACOES` deve ser criada no Firebird antes de usar esta funcionalidade

**Dashboard Admin — melhorias**
- Header duplicado corrigido: `rectMenuServicosClick` esconde `lytHeaderDashboard` ao injectar frame; `rectMenuInicioClick` restaura ao voltar ao início
- Memory leak corrigido: `rectMenuServicosClick` tem agora loop de limpeza de frames antes de criar novo
- Sidebar dinâmico: `AtualizarMenuLateral(ItemAtivo)` com helpers locais `SetAtivo`/`SetInativo`
  — XRadius=8 activo, XRadius=0 inactivo
  — Stroke laranja activo, None inactivo
  — FontColor laranja activo, branco inactivo
  — `lblSetaAgenda` mostra `'>'` quando activo (único item com seta)
- Chamado em: `FormShow` ('inicio'), `rectMenuInicioClick`, `rectMenuServicosClick`, `rectMenuAgendaClick` (novo handler)
- `rectMenuAgenda`: `OnClick` ligado no `.fmx`

**Navegação de datas na Linha do Tempo**
- `FDataAgenda: TDate` — variável de estado da data activa
- `lytNavData`: layout com setas `<` `>` e `lblDataAgenda` (laranja) inserido dentro de `lytTitulosAgenda`
- Ícones carregados em runtime via `CarregarIconesSetas`: `iconamoon--arrow-left-2-light.png` e `iconamoon--arrow-right-2-light.png`
- `AtualizarDataAgenda`: mostra "Hoje"/"Ontem"/dd/mm/yyyy; seta direita desactivada (`$FF0B1220`) quando em "Hoje"
- `rectSetaAnteriorAgendaClick`: `FDataAgenda - 1`
- `rectSetaProximaAgendaClick`: `FDataAgenda + 1` (bloqueado em Hoje)
- `AtualizarKPIs` e `CarregarLinhaTempo`: `CURRENT_DATE` substituído por `:DATA` com `FDataAgenda` como parâmetro
- `lblSubLinhaTempo` dinâmico: "N Agendamento(s) em Hoje/dd/mm"
- `scrollLinhaTempo` `Margins.Top`: 60 → 100 (evita sobreposição com o header de navegação)

**Resumo Financeiro — dados reais**
- `lblValFaturamentoPrincipal`: FATURAMENTO da query principal, formato `#,##0.00`
- `lblBtnHojeResumo`: "Hoje"/"Ontem"/dd/mm conforme `FDataAgenda`
- `lblBadgeCrescimento`: comparação com dia anterior via segunda query (`QOntem`); mostra `±X.X% vs. Dia Ant.`
- `lblSubFaturamentoMeta`: % da meta diária (meta fixa R$430); formato "X% da meta diária (R$430,00)"
- `lblValConcluidos`, `lblValorPendentes`, `lblValTickets`, `lblValorCancelamentos`: preenchidos dinamicamente em `AtualizarKPIs` com dados reais da BD

**Notificações do Admin**
- `circleSino`: `OnClick = circleSinoClick` ligado no `.fmx`
- `imgIconeNotificacaoDash`: `HitTest = False` (fix de cliques interceptados pelo filho)
- `rectOverlayNotifDash`: overlay `Align=Contents` inserido como último filho de `rectFundoDashboard`
- `CarregarNotificacoesDash`: query `TB_AVALIACOES JOIN TB_USUARIOS` (cliente) `JOIN TB_BARBEIROS JOIN TB_USUARIOS` (barbeiro) `ORDER BY DT_AVALIACAO DESC ROWS 20`
- Cards `Tag=84` com estrelas ★☆, nome do cliente, "para " + barbeiro, comentário e data
- `lblFecharNotifDashClick`: fecha overlay

**Busca na Linha do Tempo**
- `edtBuscaAdmin`: `OnChangeTracking = edtBuscaAdminChange` ligado no `.fmx`
- `CarregarLinhaTempo`: SQL dinâmico — filtro `CONTAINING` por `NOME_COMPLETO` do cliente ou `NOME` do serviço inserido antes do `ORDER BY` quando `edtBuscaAdmin.Text <> ''`
- Parâmetros `:DATA` e `:BUSCA` definidos após construção completa do SQL, antes de `Open`

**Gráfico de Faturamento Semanal — dinâmico**
- `AtualizarGraficoSemanal`: calcula Segunda/Domingo da semana de `FDataAgenda` usando `(DayOfWeek+5) mod 7`
- Query agrupada por `DT_AGENDAMENTO` com `SUM(VALOR_COBRADO WHERE STATUS='CONCLUIDO')` para os 7 dias
- Campo `DT_AGENDAMENTO` é `TDateTimeField` no FireDAC — usar `.AsDateTime` + `Trunc()` para obter `TDate` (`.AsDate` não existe)
- Barras normalizadas entre `AlturaMinima=4` e `AlturaMaxima=120` proporcionalmente ao `MaxFat`
- `lblTotalGrafico` actualizado com total da semana; `StyledSettings := []` antes do texto
- Chamado em `FormShow`, `rectSetaAnteriorAgendaClick`, `rectSetaProximaAgendaClick`

**Relatório Semanal**
- `lblLinkGrafico`: `HitTest = True` + `OnClick = lblLinkGraficoClick` adicionados no `.fmx`
- `rectOverlayRelatorio`: overlay `Align=Contents`, `Fill=$FF0B1220`, `Visible=False` — após `rectOverlayNotifDash` dentro de `rectFundoDashboard`
- `lytHeaderRelatorio` (Align=Top, 70px) com `rectBtnVoltarRel` (botão `<`, `OnClick=rectBtnVoltarRelClick`) e `lblTituloRelatorio` (bold 20px, Align=Client)
- `scrollRelatorio`: `TVertScrollBox` `Align=Client` com margens 30px laterais
- `CarregarRelatorioSemanal`: query expandida com `COUNT(*)`, `CONCLUIDOS`, `CANCELADOS`, `FATURAMENTO` por dia; actualiza `lblTituloRelatorio` com período "dd/mm a dd/mm/yyyy"
- Tabela dinâmica `Tag=83` com cabeçalho (`$FF0F172A`), linhas alternadas (par=`$FF1E293B`, ímpar=`$FF141C2B`, 50px) e rodapé bold (`$FF0B1220`) com totais
- Colunas: Dia (branco) | Agend. (branco) | Concluídos (`$FF22C55E`) | Faturamento (`$FFF58A00`)
- `DiaSemanaAbrevDash`: função local com `const array[1..7]` indexado por `DayOfWeek` (1=Dom..7=Sáb)
- `lblLinkGraficoClick` → `CarregarRelatorioSemanal` + overlay visible + `BringToFront`
- `rectBtnVoltarRelClick` → overlay invisible

### View.DashboardAdmin.pas — Dashboard do administrador:
- Menu lateral com navegação: Início, Serviços, Sair
- `FormShow`: define `lblDataDash` com data actual formatada em português
- `AtualizarKPIs`: query agregada a TB_AGENDAMENTOS (hoje) → preenche 4 cards KPI (Faturamento, Total, Pendentes, Cancelamentos)
- `CarregarLinhaTempo`: query com JOIN a 4 tabelas → cria cards dinâmicos (Tag=95) em `scrollLinhaTempo` com cores por status
- `rectMenuServicosClick`: carrega `TFrameServicos` em `lytAreaPrincipal`
- `rectMenuSairClick`: chama `FrmPrincipal.LimparSessao` + volta a `FrmPrincipal.TabLogin`

### View.Frame.Servicos.pas
- Visual completo: KPIs de serviços, filtros, toggle Todos/Ativos/Inativos, tabela dinâmica

**Frame Serviços — dinâmico (parcial)**
- 3 rectRowServico* estáticos removidos do .fmx (2066 linhas eliminadas)
- 63 declarações published removidas do .pas
- AfterConstruction: inicializa filtros e chama AtualizarKPIs + CarregarServicos
- AtualizarKPIs: Total, Ativos, Inativos, Receita Total preenchidos via query; subtítulo dinâmico
- CarregarServicos: SQL dinâmico com filtros condicionais por categoria (CONTAINING), status (ATIVO/INATIVO) e busca; linhas Tag=82 com Align=Top; 11 elementos por linha
- AtualizarFiltros / AtualizarToggle: helpers locais SetFiltro/SetToggle com visual laranja/neutro
- 8 eventos ligados no .fmx: 4 filtros categoria, 3 toggles, 1 busca OnChangeTracking
- PENDENTE: INSERT, UPDATE, DELETE, toggle por linha

---

## Próximos Passos Pendentes

1. **Frame Serviços — CONCLUÍDO** (`View.Frame.Servicos.pas`):
   - ✅ Lista dinâmica de TB_SERVICOS com filtros de categoria e toggle Ativos/Inativos
   - ✅ Busca em tempo real via edtBuscaServicos (CONTAINING)
   - ✅ KPIs reais: total, receita acumulada, preço médio, total agendamentos
   - ✅ Toggle ativo/inativo por linha (UPDATE ATIVO)
   - ✅ Deletar com confirmação (TDialogService)
   - ✅ Editar serviço — modal com UPDATE (nome, descrição, preço, duração, categoria, badge)
   - ✅ Novo Serviço — mesmo modal com INSERT, ATIVO=1
   - ⚠️ Sino de notificações — implementado mas não funciona (overlay criado, query correcta, debug pendente)

2. **Frame Agenda — CONCLUÍDO** (`View.Frame.Agenda.pas`):
   - ✅ Criado do zero — todo o UI por código em AfterConstruction (sem designer)
   - ✅ Lista de agendamentos com JOIN a TB_USUARIOS, TB_SERVICOS, TB_BARBEIROS
   - ✅ Filtros de status: Todos / Pendente / Em Andamento / Concluído / Cancelado
   - ✅ KPIs reais: Total Geral, Pendentes, Em Andamento, Concluídos (subqueries em RDB$DATABASE)
   - ✅ Badge colorido por status por linha
   - ✅ ComboBox por linha para alterar status (UPDATE TB_AGENDAMENTOS)
   - ✅ Injectado em lytAreaPrincipal via rectMenuAgendaClick (mesmo padrão de TFrameServicos)

3. **Frame Clientes — CONCLUÍDO** (`View.Frame.Clientes.pas`):
   - ✅ Lista de clientes de TB_USUARIOS WHERE PERFIL='CLIENTE'
   - ✅ KPIs reais: Total, Ativos, Novos este mês (DT_CADASTRO)
   - ✅ Busca em tempo real por nome e email (CONTAINING)
   - ✅ Badge de status por linha (Ativo/Inativo)
   - ✅ Toggle ativo/inativo por linha (UPDATE TB_USUARIOS)
   - ✅ Migration: DT_CADASTRO adicionado à TB_USUARIOS

4. **Frame Financeiro — CONCLUÍDO** (`View.Frame.Financeiro.pas`):
   - ✅ Relatório de transações com JOIN a 4 tabelas
   - ✅ KPIs reais: Faturamento Total, Concluídos, Ticket Médio, Cancelamentos
   - ✅ Filtros por mês e ano (ComboBox reactivos)
   - ✅ Lista com badges coloridos por status
   - ✅ COALESCE para evitar NULL em queries agregadas

5. **Frame Configurações — CONCLUÍDO** (`View.Frame.Configuracoes.pas`):
   - ✅ Criado do zero — todo o UI por código em AfterConstruction
   - ✅ Tabela TB_CONFIGURACOES criada (migration 002)
   - ✅ Campos: Nome da Barbearia, Meta Diária, Horário Abertura/Fechamento, Telefone, Endereço
   - ✅ CarregarConfiguracoes — SELECT CHAVE/VALOR e preenche campos
   - ✅ SalvarConfiguracoes — UPDATE por CHAVE para cada campo
   - ✅ Injectado via rectMenuConfigClick (mesmo padrão dos outros frames)

6. **Dashboard Admin — melhorias implementadas** (`View.DashboardAdmin.pas`):
   - ✅ Timer automático de status (TTimer 60s): PENDENTE→EM_ANDAMENTO→CONCLUIDO baseado em CURRENT_DATE/CURRENT_TIME
   - ✅ AtualizarStatusAutomatico executado no FormShow e a cada minuto
   - ✅ ForceQueue em todos os toggles/deletes (Serviços e Agenda) — fix Access Violation
   - ✅ Ícone cadeado (login) alinhado com ícone email — Margins e Height corrigidos no .fmx
   - ✅ Ícone calendário real (proicons--calendar.png) na tela Clientes — substituiu emoji
   - ✅ Campo busca Clientes: StyleLookup transparente, fonte branca, largura reduzida
   - ✅ Colunas tabela Clientes alinhadas com os dados (4 colunas reais)

7. **Deploy com D2Bridge** — PRÓXIMO PASSO:
   - Configurar D2Bridge para servir FrmDashboardAdmin como aplicação Web
   - Adaptar layouts para responsividade Web
   - Configurar servidor/hospedagem

---

## Regras Críticas — Nunca Quebrar

### FireDAC / Ligação
- Usar sempre `FireDAC.FMXUI.Wait` (NÃO `FireDAC.VCLUI.Wait`) — este é um projecto FMX
- Incluir obrigatoriamente: `FireDAC.DApt`, `FireDAC.Stan.ExprFuncs`, `FireDAC.Stan.Param`
- Não instanciar `TFDGUIxWaitCursor` — incluir a unit é suficiente
- `FDConnection1` deve ser `public` em `TdmConexao` para acesso externo

### Ficheiros .fmx — NUNCA EDITAR MANUALMENTE (regra geral)
- Os ficheiros `.fmx` são o designer do Delphi; editar à mão corrompe o formulário
- Toda a lógica dinâmica é criada por código em `.pas`
- Componentes do designer são referenciados pelo nome na secção `published` do `.pas`
- Excepção aceite: remoção de blocos completos `object...end` e adição de propriedades simples (OnClick, HitTest, OnChangeTracking) podem ser feitas via PowerShell/Edit com validação prévia de limites de linha
- Quando se remove um componente do `.fmx`, remover também a declaração de campo na secção `published` do `.pas` (e vice-versa)

### TLabel — HitTest e cliques
- `TLabel` tem `HitTest = False` por defeito em FMX — para receber cliques, adicionar `HitTest = True` no `.fmx` E ligar `OnClick`
- Se um `TSpeedButton` com `Align = Client` estiver dentro de um `TRectangle`, intercepta todos os cliques; definir `HitTest = False` no SpeedButton para deixar passar os cliques para o rectângulo

### AutoSize em labels com Align = Left
- `AutoSize = True` + `Align = Left`: quando `Text` é definido como `''`, a largura colapsa para 0
- Após colapso, o FMX não recalcula o layout automaticamente quando o texto é restaurado
- **Nunca** definir estes labels como `''` no reset; usar placeholders não-vazios (ex: `'-- min'`, `'R$ 0,00'`)

### Comparações com strings acentuadas
- `UpperCase()` em Delphi é byte-level e não converte correctamente caracteres acentuados (ex: `'é'` → `'É'` falha)
- Para comparar strings com acentos: usar `Pos('SUBSTR_SEM_ACENTO', UpperCase(str)) > 0` em vez de `= 'STRING_COM_ACENTO'`
- Exemplo: `Pos('EST', UpperCase(Categoria)) > 0` em vez de `UpperCase(Categoria) = 'ESTÉTICA'`

### Busca com CONTAINING no Firebird
- `UPPER(campo) CONTAINING UPPER(:PARAM)` — busca substring case-insensitive nativa do Firebird
- Preferir a este padrão em vez de `LIKE '%' || :PARAM || '%'`

### Cores em labels dinâmicos
- O StyleBook do projecto sobrepõe-se a `FontColor` quando `StyledSettings` não está vazio
- **Sempre** fazer `Label.StyledSettings := []` antes de `Label.TextSettings.FontColor := $FF...`
- Cores em formato `TAlphaColor` hexadecimal: `$AARRGGBB` (ex: `$FF94A3B8`)
- Não usar `StringToAlphaColor` — não existe em FMX; usar literais `$FF...` directamente

### Posicionamento de controlos dinâmicos em ScrollBox
- `Align := TAlignLayout.None` + `Position.Y` explícito calculado a partir do último componente do designer
- Padrão: `StartY := RefComponent.Position.Y + RefComponent.Height + margem`
- `Align := TAlignLayout.Top` não é fiável para controlos criados por código em `TVertScrollBox`
- Excepção: dentro de `scrollLinhaTempo` (DashboardAdmin), `Align=Top` funciona porque os cards são o único conteúdo

### TFlowLayout
- Não tem propriedade `.Content` — usar `flowHorarios.Height` com valor fixo calculado
- Valor actual: `flowHorarios.Height = 220` (20 slots × 80px wide, ~4 por linha = 5 linhas × 40px + margens)

### SHA-256 para passwords
- `System.Hash.THashSHA2.GetHashString(senha, THashSHA2.TSHA2Version.SHA256)`
- Resultado em `UpperCase` para comparar com o valor na BD

### `IncMinute` para HR_FIM
- `System.DateUtils.IncMinute(HoraInicio, DuracaoMinutos)` para calcular fim do agendamento

### Tags de controlos dinâmicos (convenção estabelecida)
| Tag | Tipo de controlo                          |
|-----|-------------------------------------------|
| 99  | Cards de serviços (TLayout, Home cliente) |
| 98  | Container-pai dos cards de serviços       |
| 97  | Cards de barbeiros (TLayout, Agendamento) |
| 96  | Slots de horário (TRectangle, Agendamento)|
| 95  | Cards da linha de tempo (TLayout, Dashboard) |
| 88  | Cards de notificações (TRectangle + TImage dentro de scrollNotificacoes) |
| 87  | Componentes do popup de perfil (reservado para futuro uso dinâmico) |
| 86  | Cards de avaliação (reservado para tela de feedback) |
| 85  | Cards de agendamento no Carrinho (TRectangle dentro de scrollCarrinho) |
| 84  | Cards de avaliação no popup do Admin (TRectangle dentro de scrollNotifDash) |
| 83  | Linhas do Relatório Semanal (TRectangle dentro de scrollRelatorio) |
| 82  | Linhas dinâmicas do Frame Serviços (TRectangle dentro de scrollListaServicos) |

---

## Units Obrigatórias por Ficheiro

### Model.Conexao.pas (interface uses)
```
System.SysUtils, System.Classes, FMX.Dialogs,
FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.Intf,
FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.DataSet, FireDAC.DApt,
FireDAC.Stan.ExprFuncs
```

### View.Principal.pas (implementation uses)
```
View.DashboardAdmin, Model.Conexao, FireDAC.Comp.Client, Data.DB,
System.DateUtils, FireDAC.Stan.Param, System.IOUtils
```

### View.DashboardAdmin.pas (implementation uses)
```
View.Frame.Servicos, View.Principal,
Model.Conexao, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param
```

---

## Padrão de Query FireDAC (reutilizar sempre)

```pascal
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text := 'SELECT ... FROM ... WHERE ...';
    // Para queries com parâmetros:
    // Query.ParamByName('PARAM').AsString := valor;
    Query.Open;  // para SELECT
    // Query.ExecSQL; // para INSERT/UPDATE/DELETE
    while not Query.EOF do
    begin
      // Query.FieldByName('COLUNA').AsString / .AsInteger / .AsFloat
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;
```
