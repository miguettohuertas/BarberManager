# BarberManager — Contexto do Projecto para Claude

## Descrição
Sistema de gestão de barbearia com duas camadas:
- **App Desktop/Mobile (Delphi FMX):** painel do cliente e dashboard do administrador nativos
- **Frontend Web + REST API (Horse):** mesma BD Firebird, servida via HTTP na porta 9000 com UI em HTML/CSS/JS puro

---

## Stack Tecnológica

| Componente      | Versão / Detalhe                                                    |
|-----------------|---------------------------------------------------------------------|
| IDE             | Delphi 12 Athens                                                    |
| UI Framework    | FireMonkey (FMX) — cross-platform, mobile-first                     |
| REST API        | Horse framework (`C:\Horse\horse-master\src`) — servidor porta 9000 |
| Frontend Web    | HTML/CSS/JS puro (single file `src/Web/index.html`)                 |
| Base de dados   | Firebird 3.0                                                        |
| Acesso a dados  | FireDAC (componentes criados por código, nunca no designer)         |
| Linguagem       | Object Pascal                                                       |

---

## Caminhos Importantes

| Recurso              | Caminho                                                                              |
|----------------------|--------------------------------------------------------------------------------------|
| Raiz do projecto     | `C:\ProjetosDelphi\BarberManager\BarberManager\`                                     |
| Banco de dados       | `C:\ProjetosDelphi\BarberManager\BarberManager\database\BARBERMANAGER.FDB`           |
| fbclient.dll         | `C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll`                         |
| Utilizador DB        | `SYSDBA`                                                                             |
| Password DB          | `masterkey`                                                                          |
| CharacterSet         | `UTF8`                                                                               |
| Protocol             | `Local`                                                                              |
| Horse framework      | `C:\Horse\horse-master\src`                                                          |
| API project          | `BarberManagerAPI.dpr` (raiz do projecto)                                            |
| Web frontend         | `src\Web\index.html` → copiado para `index.html` na raiz após cada alteração        |
| Screenshots web      | `docs\Telas_Web\` — 11 PNGs das telas do Web App                                    |

---

## Estrutura de Pastas

```
BarberManager/
├── database/
│   └── BARBERMANAGER.FDB
├── docs/
│   ├── Diagramas_C4/             — diagramas C4 Model (.png)
│   └── Telas_Web/                — 11 screenshots do Web App (login, dashboard, etc.)
├── src/
│   ├── API/
│   │   ├── API.Conexao.pas       — CreateConnection per-request (sem global)
│   │   ├── API.Auth.pas          — POST /api/auth/login, POST /api/auth/cadastro
│   │   ├── API.Agendamentos.pas  — GET/POST /api/agendamentos, PUT /status, AutoAtualizarStatus
│   │   ├── API.Avaliacoes.pas    — GET recentes/barbeiro/cliente, POST /api/avaliacoes
│   │   ├── API.Barbeiros.pas     — GET /api/barbeiros
│   │   ├── API.Clientes.pas      — GET /api/clientes, PUT /toggle
│   │   ├── API.Dashboard.pas     — GET /api/dashboard/kpis|timeline|financeiro
│   │   ├── API.Servicos.pas      — CRUD /api/servicos
│   │   └── API.Usuarios.pas      — GET+PUT /api/usuarios/:id (perfil editável)
│   ├── Model/
│   │   ├── Model.Conexao.pas     — DataModule de ligação ao Firebird (app FMX)
│   │   └── Model.Conexao.dfm
│   ├── View/
│   │   ├── View.Principal.pas    — Form principal (Login, Home cliente, Agendamento)
│   │   ├── View.Principal.fmx
│   │   ├── View.DashboardAdmin.pas
│   │   ├── View.DashboardAdmin.fmx
│   │   ├── View.Frame.Servicos.pas
│   │   └── View.Frame.Servicos.fmx
│   └── Web/
│       └── index.html            — SPA: login + área admin + área cliente
├── BarberManagerAPI.dpr          — projecto Horse REST API (porta 9000)
├── BarberManagerAPI.exe          — servidor API compilado (porta 9000)
├── cloudflared.exe               — Cloudflare Tunnel (expõe porta 9000 publicamente)
├── start-barbermanager.ps1       — script de arranque automático (dois terminais)
├── index.html                    — cópia de src/Web/index.html servida pelo .exe
├── CLAUDE.md
└── README.md
```

---

## Tabelas da Base de Dados

| Tabela             | Descrição                                                                                                                                          |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `TB_USUARIOS`      | ID, NOME_COMPLETO, EMAIL, SENHA_HASH (SHA-256 uppercase), PERFIL ('ADMIN'/'CLIENTE'), ATIVO, DT_CADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP, TELEFONE VARCHAR(20) |
| `TB_SERVICOS`      | ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, CATEGORIA_ID (FK → TB_CATEGORIAS), BADGE, ATIVO                                                          |
| `TB_CATEGORIAS`    | ID, NOME (ex: 'Cabelo', 'Barba', 'Estética')                                                                                                      |
| `TB_BARBEIROS`     | ID, USUARIO_ID (FK → TB_USUARIOS), CARGO, AVALIACAO_MEDIA, ATIVO                                                                                  |
| `TB_AGENDAMENTOS`  | ID, CLIENTE_ID, BARBEIRO_ID, SERVICO_ID, DT_AGENDAMENTO, HR_INICIO (TIME), HR_FIM (TIME), STATUS ('PENDENTE'/'EM_ANDAMENTO'/'CONCLUIDO'/'CANCELADO'), VALOR_COBRADO |
| `TB_AVALIACOES`    | ID, AGENDAMENTO_ID (FK), CLIENTE_ID (FK), BARBEIRO_ID (FK), NOTA INTEGER (1-5), COMENTARIO VARCHAR(500), DT_AVALIACAO TIMESTAMP DEFAULT CURRENT_TIMESTAMP |
| `TB_CONFIGURACOES` | ID, CHAVE VARCHAR(50) UNIQUE, VALOR VARCHAR(255), DESCRICAO VARCHAR(255)                                                                           |

### Migrations aplicadas
```sql
ALTER TABLE TB_USUARIOS ADD DT_CADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE TB_USUARIOS ADD TELEFONE VARCHAR(20);
```

---

## O que já está implementado

### Model.Conexao.pas (app FMX)
- `TdmConexao` DataModule criado inteiramente por código (sem componentes no .dfm)
- `FDConnection1` e `FDPhysFBDriverLink1` declarados como `public` (acedidos externamente)
- Função `Conectar` configura VendorLib, DriverID='FB', Protocol=Local, UTF8
- Variável global `dmConexao` instanciada no arranque da aplicação

### View.Principal.pas — Form principal com 4 tabs:
1. **TabLogin** — Login real: query a TB_USUARIOS com SHA-256 + UpperCase. Redireciona para Home (CLIENTE) ou DashboardAdmin (ADMIN).
2. **TabNovaConta** — Cadastro real com validações completas e verificação de email duplicado.
3. **TabHome** — Cards de serviços dinâmicos, filtros de categoria, busca em tempo real, banner de oferta.
4. **TabAgendamento** — Calendário dinâmico, seleção de barbeiro, slots de horário, confirmação com INSERT.

### Novas funcionalidades implementadas (View.Principal.pas):
- Banner de Oferta com botão "Aproveitar >"
- Reset completo ao voltar do Agendamento
- Imagens reais nos cards por categoria
- Popup de Notificações com agendamentos reais do utilizador
- Sessão de utilizador completa (FUsuarioID, FUsuarioNome, FUsuarioEmail, FUsuarioPerfil)
- Popup de Perfil com avatar, badge por perfil, logout
- Calendário dinâmico com navegação por meses
- Menu inferior dinâmico com cores activo/inactivo
- Tela Carrinho (Meus Agendamentos) com avaliação de serviço (estrelas + comentário)
- Atualização de AVALIACAO_MEDIA em TB_BARBEIROS após avaliação

### View.DashboardAdmin.pas
- Menu lateral, KPIs reais, linha do tempo, navegação de datas (← →)
- Timer automático de status (TTimer 60s): PENDENTE→EM_ANDAMENTO→CONCLUIDO
- Sidebar dinâmico com estado activo/inactivo
- Notificações admin (avaliações recentes)
- Busca na linha do tempo (CONTAINING)
- Gráfico de faturamento semanal dinâmico
- Relatório semanal em overlay
- Resumo financeiro com comparação vs. dia anterior

### View.Frame.Servicos.pas / Frame.Agenda.pas / Frame.Clientes.pas / Frame.Financeiro.pas / Frame.Configuracoes.pas
- Todos criados com UI por código em AfterConstruction
- CRUD completo de Serviços (lista dinâmica, filtros, toggle, editar, novo, deletar)
- Frame Agenda: lista, filtros de status, KPIs, ComboBox por linha para alterar status
- Frame Clientes: lista, KPIs, busca, toggle ativo/inativo
- Frame Financeiro: relatório mensal, KPIs, filtros por mês/ano
- Frame Configurações: leitura e escrita em TB_CONFIGURACOES

---

### Horse REST API (BarberManagerAPI.dpr — porta 9000)

#### API.Conexao.pas — padrão per-request
```pascal
function CreateConnection: TFDConnection;
```
- Cria uma nova `TFDConnection` por cada chamada — nunca partilhada entre threads Horse
- `IniciarConexao` apenas inicializa o `FDPhysFBDriverLink` (load da DLL); não cria conexão global
- `TxOptions.Isolation := xiReadCommitted` configurado em cada conexão

#### API.Agendamentos.pas
- `RotaListar`: filtros opcionais por `status`, `data`, `clienteId`, `busca` (CONTAINING); LEFT JOIN + COALESCE em todos os joins; `CAST(HR_INICIO AS VARCHAR(13))` e `CAST(HR_FIM AS VARCHAR(13))` para evitar AV no campo TIME do FireDAC
- `RotaCriar`: parse 'YYYY-MM-DD' com `EncodeDate`; parse 'HH:MM' com `StrToTimeDef + ':00'`; calcula HR_FIM com `IncMinute`
- `RotaAtualizarStatus`: valida whitelist PENDENTE/EM_ANDAMENTO/CONCLUIDO/CANCELADO
- `AutoAtualizarStatus`: exportada no interface; 3 UPDATEs sequenciais numa conexão per-call:
  1. PENDENTE → EM_ANDAMENTO (hoje, HR_INICIO <= CURRENT_TIME)
  2. EM_ANDAMENTO → CONCLUIDO (HR_FIM passou ou dia anterior)
  3. PENDENTE/EM_ANDAMENTO → CONCLUIDO (dias passados — missed appointments)
  - Silent except — nunca falha a request

#### API.Dashboard.pas
- `RotaKPIs`: padrão `FROM RDB$DATABASE LEFT JOIN (SELECT aggregates...) Q ON 1=1` para garantir uma linha mesmo sem dados (evita 'Field not found' no FireDAC em resultado vazio)
- `RotaTimeline`: LEFT JOIN em todas as 4 tabelas; COALESCE em strings; CAST HR para VARCHAR(13)
- `RotaFinanceiro`: Q1 usa RDB$DATABASE LEFT JOIN; Q2 agrupa por dia; COALESCE em todos os campos

#### API.Avaliacoes.pas
- Todas as routes usam LEFT JOIN + COALESCE — sem INNER JOIN (evita AV em FKs orfãs)
- `RotaCriar`: verifica duplicado, depois `Conn.StartTransaction` / `QInsert` / `QUpdate AVALIACAO_MEDIA` / `Conn.Commit`; `Conn.Rollback` no except

#### API.Usuarios.pas (novo)
- `GET /api/usuarios/:id` — retorna `{ id, nome, email, perfil, telefone }`
- `PUT /api/usuarios/:id` — valida nome/email/senha; verifica unicidade de email (excluindo self); UPDATE com ou sem SENHA_HASH; retorna `{ id, nome, email, telefone }`
- Requer migration: `ALTER TABLE TB_USUARIOS ADD TELEFONE VARCHAR(20);`

#### BarberManagerAPI.dpr — middleware
```pascal
// 1. CORS middleware
THorse.Use(...CORS headers + OPTIONS shortcircuit...);

// 2. Auto-status middleware (antes de todas as rotas)
THorse.Use(
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
  begin
    if Req.Method = 'GET' then
      API.Agendamentos.AutoAtualizarStatus;
    Next;
  end
);

// 3. Registar rotas
API.Auth.RegistrarRotas; ... etc.
```

#### src/Web/index.html — SPA
- **Login/cadastro** com validação e redirecionamento por perfil (ADMIN/CLIENTE)
- **Área Admin:** dashboard KPIs, timeline, agenda com busca, serviços com busca, clientes com busca, financeiro mensal, configurações
- **Área Cliente:** serviços disponíveis, meus agendamentos com avaliação, perfil editável
- **Notificações admin:** `loadNotificacoes` usa `localStorage.lastSeenNotifId` — badge mostra apenas avaliações novas (id > lastSeenNotifId); polling `setInterval(loadNotificacoes, 30000)` ativo apenas para ADMIN
- **toggleNotificacoes:** ao abrir, persiste `lastSeenNotifId = notifMaxId` no localStorage e esconde badge
- **Busca admin:** `agenda-search` → `agendaBusca` → `loadAgenda()`; `servicos-search` → `servicosBusca` → `loadServicos()`; `clientes-search` → `clientesBusca` → `loadClientes()`
- **loadMeusAgendamentos:** usa `?clienteId=${currentUser.id}` — filtragem no backend, não no JS
- **Perfil editável:** form com 5 campos (nome, email, telefone, nova senha, confirmar senha); `loadClientePerfil` é async — faz GET /api/usuarios/:id para buscar telefone; `saveClientePerfil` faz PUT e atualiza `currentUser` + topbar
- **Mobile hamburger:** `#cli-mobile-topbar` fixo (56px, display:none no desktop); `#cli-sidebar` com `transform:translateX(-100%)` por defeito, `translateX(0)` com class `.open`; `#cli-sidebar-overlay` fecha ao clicar; `toggleCliSidebar()` + auto-close em `showClienteSection` quando `window.innerWidth <= 768`
- **`index.html` na raiz:** cópia de `src/Web/index.html` que o .exe serve em `GET /`; copiar manualmente com `cp src/Web/index.html index.html` após cada alteração

---

## Estado Actual do Projecto

### Sistema completo e em produção ✅

| Módulo | Estado |
|--------|--------|
| App FMX nativo — Login, Cadastro, Home, Agendamento | ✅ |
| App FMX — Carrinho (Meus Agendamentos) + Avaliação | ✅ |
| App FMX — Dashboard Admin (KPIs, timeline, frames) | ✅ |
| Horse REST API — todos os endpoints (porta 9000) | ✅ |
| Web SPA — Área Cliente (serviços, agendamento, perfil) | ✅ |
| Web SPA — Área Admin (dashboard, agenda, serviços, clientes, financeiro, configurações) | ✅ |
| Notificações admin com badge localStorage | ✅ |
| Mobile hamburger drawer (≤768px) | ✅ |
| Perfil editável (nome, email, telefone, senha) | ✅ |
| Auto-status middleware (PENDENTE→EM_ANDAMENTO→CONCLUIDO) | ✅ |
| Deploy via Cloudflare Tunnel (URL pública temporária) | ✅ |
| Script de arranque automático (`start-barbermanager.ps1`) | ✅ |
| README + CLAUDE.md actualizados | ✅ |
| Screenshots web em `docs/Telas_Web/` | ✅ |

### Deploy — Cloudflare Tunnel

O sistema é exposto publicamente através do **Cloudflare Tunnel** (`cloudflared.exe`) sem necessidade de servidor dedicado, IP fixo ou abertura de portas no router.

**Ficheiros necessários na raiz do projecto:**
- `BarberManagerAPI.exe` — servidor Horse (porta 9000)
- `cloudflared.exe` — cliente do túnel Cloudflare

**Arranque manual (dois terminais):**
```powershell
# Terminal 1 — API
.\BarberManagerAPI.exe

# Terminal 2 — Túnel
.\cloudflared.exe tunnel --url http://localhost:9000
```

**Arranque automático (script):**
```powershell
.\start-barbermanager.ps1
```
O script abre dois terminais PowerShell separados.

**Nota importante sobre a URL:** A URL pública (formato `https://xxxx.trycloudflare.com`) é **temporária** — muda a cada reinício do `cloudflared`. Para URL permanente seria necessário criar um túnel nomeado com conta Cloudflare gratuita.

### Nota sobre o ambiente de desenvolvimento

- Delphi 12 Athens foi **reinstalado** nesta máquina (nova instalação limpa)
- Horse framework foi **clonado de novo** em `C:\Horse\horse-master\`
- A base de dados `BARBERMANAGER.FDB` foi **transferida manualmente** para o caminho correcto
- Tudo compilado e funcional após reinstalação — sem dependências adicionais necessárias

---

## Regras Críticas — Nunca Quebrar

### Horse API — Conexões (per-request obrigatório)
- **NUNCA** usar uma `TFDConnection` global partilhada — Horse é multi-thread, conexões não são thread-safe
- **Sempre** usar `Conn := CreateConnection; try ... finally Conn.Free; end;` em cada handler
- `CreateConnection` cria conexão nova, conecta, define `TxOptions.Isolation := xiReadCommitted`, retorna
- `IniciarConexao` (chamado uma vez no arranque) apenas carrega a DLL via `FDPhysFBDriverLink`

### Horse API — Outras regras
- `FireDAC.ConsoleUI.Wait` (não `FireDAC.FMXUI.Wait`) nos projectos console (`BarberManagerAPI`)
- `Req.Method = 'OPTIONS'` para CORS preflight — `TMethodType.mtAny` colapsa OPTIONS/TRACE/CONNECT, não usar
- `Res.AddHeader(name, value)` é a forma correcta de definir headers no Horse
- `API_BASE = ''` (URLs relativas) no `index.html` — evita CORS quando servido pelo mesmo servidor
- Post-build MSBuild no `BarberManagerAPI.dproj` copia `src/Web/index.html` → `Win32\$(Config)\` automaticamente
- `TStringList.LoadFromFile(path, TEncoding.UTF8)` + `Res.Send(HTML.Text)` para servir HTML estático
- UTF-8 no Firebird: `CharacterSet=UTF8` na ligação; IBExpert deve ter Charset=UTF8 + Font=DEFAULT_CHARSET

### Firebird — Padrões de query seguros
- **LEFT JOIN + COALESCE obrigatório** em todos os JOINs — INNER JOIN em FK orfã provoca AV no FireDAC (campo nil)
- **CAST(HR_INICIO AS VARCHAR(13))** e **CAST(HR_FIM AS VARCHAR(13))** — campo TIME do Firebird tem formato `HH:MM:SS.0000` (13 chars); acesso directo via FireDAC como campo TIME causa AV
- **RDB$DATABASE LEFT JOIN** — padrão para agregados que podem ter zero linhas:
  ```sql
  SELECT COALESCE(Q.CAMPO, 0) FROM RDB$DATABASE LEFT JOIN (SELECT ... FROM TB_X WHERE ...) Q ON 1=1
  ```
  Garante sempre uma linha no resultado — sem isto, o FireDAC perde os aliases dos campos agregados
- **UPPER(campo) CONTAINING UPPER(:PARAM)** — busca substring case-insensitive nativa do Firebird

### FireDAC / Ligação (app FMX)
- Usar sempre `FireDAC.FMXUI.Wait` (NÃO `FireDAC.VCLUI.Wait`) — projecto FMX
- Incluir obrigatoriamente: `FireDAC.DApt`, `FireDAC.Stan.ExprFuncs`, `FireDAC.Stan.Param`
- Não instanciar `TFDGUIxWaitCursor` — incluir a unit é suficiente
- `FDConnection1` deve ser `public` em `TdmConexao` para acesso externo

### Ficheiros .fmx — NUNCA EDITAR MANUALMENTE (regra geral)
- Os ficheiros `.fmx` são o designer do Delphi; editar à mão corrompe o formulário
- Excepção aceite: remoção de blocos completos `object...end` e adição de propriedades simples (OnClick, HitTest, OnChangeTracking)
- Quando se remove um componente do `.fmx`, remover também a declaração na secção `published` do `.pas`

### TLabel — HitTest e cliques
- `TLabel` tem `HitTest = False` por defeito em FMX — adicionar `HitTest = True` no `.fmx` E ligar `OnClick`
- `TSpeedButton` com `Align = Client` dentro de `TRectangle` intercepta todos os cliques — definir `HitTest = False`

### AutoSize em labels com Align = Left
- `AutoSize = True` + `Align = Left`: quando `Text = ''` a largura colapsa para 0 e não recupera
- **Nunca** definir como `''` no reset — usar placeholders como `'-- min'`, `'R$ 0,00'`

### Comparações com strings acentuadas
- `UpperCase()` em Delphi é byte-level — não converte acentos correctamente
- Usar `Pos('SUBSTR_SEM_ACENTO', UpperCase(str)) > 0` em vez de `= 'STRING_COM_ACENTO'`

### Cores em labels dinâmicos
- **Sempre** fazer `Label.StyledSettings := []` antes de `Label.TextSettings.FontColor := $FF...`
- Cores em formato `TAlphaColor` hexadecimal: `$AARRGGBB`
- Não usar `StringToAlphaColor` — não existe em FMX

### Posicionamento de controlos dinâmicos em ScrollBox
- `Align := TAlignLayout.None` + `Position.Y` explícito calculado a partir do último componente
- `Align := TAlignLayout.Top` não é fiável para controlos criados por código em `TVertScrollBox`
- Excepção: `scrollLinhaTempo` (DashboardAdmin) funciona com `Align=Top` porque os cards são o único conteúdo

### SHA-256 para passwords
- `UpperCase(THashSHA2.GetHashString(senha, THashSHA2.TSHA2Version.SHA256))`

### Tags de controlos dinâmicos (convenção estabelecida)
| Tag | Tipo de controlo                                                   |
|-----|--------------------------------------------------------------------|
| 99  | Cards de serviços (TLayout, Home cliente)                          |
| 98  | Container-pai dos cards de serviços                                |
| 97  | Cards de barbeiros (TLayout, Agendamento)                          |
| 96  | Slots de horário (TRectangle, Agendamento)                         |
| 95  | Cards da linha de tempo (TLayout, Dashboard)                       |
| 88  | Cards de notificações (TRectangle, scrollNotificacoes)             |
| 85  | Cards de agendamento no Carrinho                                   |
| 84  | Cards de avaliação no popup Admin                                  |
| 83  | Linhas do Relatório Semanal                                        |
| 82  | Linhas dinâmicas do Frame Serviços                                 |

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

### API.*.pas (implementation uses)
```
System.SysUtils, System.JSON,
FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
Horse,
API.Conexao
```

---

## Padrão de Query FireDAC — Horse API (per-request)

```pascal
var
  Conn: TFDConnection;
  Query: TFDQuery;
begin
  Conn := CreateConnection;   // nova conexão por request — nunca partilhar
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := Conn;
      Query.SQL.Text :=
        'SELECT COALESCE(CAMPO, '''') AS CAMPO ' +
        'FROM TB_X ' +
        'LEFT JOIN TB_Y ON TB_Y.ID = TB_X.Y_ID ' +  // LEFT JOIN sempre
        'WHERE ...';
      Query.ParamByName('PARAM').AsString := valor;
      Query.Open;   // SELECT
      // Query.ExecSQL; // INSERT/UPDATE/DELETE
      while not Query.EOF do
      begin
        Query.FieldByName('CAMPO').AsString;
        Query.Next;
      end;
    finally
      Query.Free;
    end;
  finally
    Conn.Free;
  end;
end;
```

## Padrão de Query FireDAC — App FMX (conexão global)

```pascal
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := dmConexao.FDConnection1;
    Query.SQL.Text := 'SELECT ... FROM ... WHERE ...';
    Query.ParamByName('PARAM').AsString := valor;
    Query.Open;
    while not Query.EOF do
    begin
      Query.FieldByName('COLUNA').AsString;
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;
```
