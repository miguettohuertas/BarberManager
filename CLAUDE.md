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
| `TB_USUARIOS`     | Clientes e utilizadores do sistema. Colunas: ID, NOME_COMPLETO, EMAIL, SENHA_HASH (SHA-256 uppercase), PERFIL ('ADMIN'/'CLIENTE'), ATIVO |
| `TB_SERVICOS`     | Catálogo de serviços. Colunas: ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, CATEGORIA_ID (FK → TB_CATEGORIAS), BADGE, ATIVO |
| `TB_CATEGORIAS`   | Categorias de serviços. Colunas: ID, NOME (ex: 'Cabelo', 'Barba', 'Estética') |
| `TB_BARBEIROS`    | Barbeiros. Colunas: ID, USUARIO_ID (FK → TB_USUARIOS), CARGO, AVALIACAO_MEDIA, ATIVO |
| `TB_AGENDAMENTOS` | Agendamentos. Colunas: ID, CLIENTE_ID, BARBEIRO_ID, SERVICO_ID, DT_AGENDAMENTO, HR_INICIO, HR_FIM, STATUS ('PENDENTE'/'EM_ANDAMENTO'/'CONCLUIDO'/'CANCELADO'), VALOR_COBRADO |

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

### View.DashboardAdmin.pas — Dashboard do administrador:
- Menu lateral com navegação: Início, Serviços, Sair
- `FormShow`: define `lblDataDash` com data actual formatada em português
- `AtualizarKPIs`: query agregada a TB_AGENDAMENTOS (hoje) → preenche 4 cards KPI (Faturamento, Total, Pendentes, Cancelamentos)
- `CarregarLinhaTempo`: query com JOIN a 4 tabelas → cria cards dinâmicos (Tag=95) em `scrollLinhaTempo` com cores por status
- `rectMenuServicosClick`: carrega `TFrameServicos` em `lytAreaPrincipal`
- `rectMenuSairClick`: volta a `FrmPrincipal.TabLogin`

### View.Frame.Servicos.pas
- Visual completo: KPIs de serviços, filtros, toggle Todos/Ativos/Inativos, tabela com 3 linhas estáticas
- **Sem lógica implementada** — dados todos estáticos/hardcoded

---

## Próximos Passos Pendentes

1. **Frame Serviços — CRUD dinâmico** (`View.Frame.Servicos.pas`):
   - Carregar lista de serviços de TB_SERVICOS dinamicamente (substituir as 3 linhas estáticas)
   - Filtros Todos/Ativos/Inativos funcionais (query com WHERE ATIVO=...)
   - Filtros de categoria (Estética/Barba/Cabelo) funcionais
   - Busca por nome (`edtBuscaServicos`) com `CONTAINING`
   - KPIs reais: total de serviços, ticket médio, serviço mais popular
   - Botão "Novo Serviço": formulário de cadastro (INSERT em TB_SERVICOS)
   - Acções por linha: editar (UPDATE), eliminar (DELETE), toggle ativo/inativo

2. **Dashboard Admin — dados reais**:
   - Gráfico de barras semanal com receita por dia (TB_AGENDAMENTOS por DT_AGENDAMENTO)
   - Barra de meta: receita do dia vs meta configurável
   - Gestão de barbeiros (CRUD em TB_BARBEIROS)

3. **Sessão de utilizador**:
   - Guardar ID e PERFIL do utilizador logado em variável global ou singleton
   - Substituir `CLIENTE_ID = 1` hardcoded em `rectBtnConfirmarClick` pelo ID real da sessão
   - Mostrar agendamentos do utilizador logado no histórico

4. **Horários ocupados reais** (`CarregarHorarios`):
   - Substituir o array `Ocupados` hardcoded por query a TB_AGENDAMENTOS
   - Filtrar por BARBEIRO_ID + DT_AGENDAMENTO = FDataSelecionada + STATUS ≠ 'CANCELADO'

5. **Deploy com D2Bridge** — empacotamento para Android/iOS

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
- Fórmula usada: `7 linhas × 48px + padding = 380`

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

### View.Principal.pas (implementation uses a adicionar)
```
Model.Conexao, FireDAC.Comp.Client, Data.DB,
System.DateUtils, FireDAC.Stan.Param, System.Hash,
View.DashboardAdmin
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
