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
| `TB_USUARIOS`     | Clientes e utilizadores do sistema. Colunas: ID, NOME_COMPLETO, EMAIL, SENHA (SHA-256 uppercase), PERFIL ('ADMIN'/'CLIENTE') |
| `TB_SERVICOS`     | Catálogo de serviços. Colunas: ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, CATEGORIA, ATIVO |
| `TB_BARBEIROS`    | Barbeiros. Colunas: ID, USUARIO_ID (FK → TB_USUARIOS), ATIVO |
| `TB_AGENDAMENTOS` | Agendamentos. Colunas: ID, CLIENTE_ID, BARBEIRO_ID, SERVICO_ID, DT_AGENDAMENTO, HR_INICIO, HR_FIM, STATUS ('PENDENTE'/'EM_ANDAMENTO'/'CONCLUIDO'/'CANCELADO'), VALOR_COBRADO |

---

## O que já está implementado

### Model.Conexao.pas
- `TdmConexao` DataModule criado inteiramente por código (sem componentes no .dfm)
- `FDConnection1` e `FDPhysFBDriverLink1` declarados como `public` (acedidos externamente)
- Função `Conectar` configura VendorLib, DriverID='FB', Protocol=Local, UTF8
- Variável global `dmConexao` instanciada no arranque da aplicação

### View.Principal.pas — Form principal com 3 tabs:
1. **TabLogin** — Login real: query a TB_USUARIOS com SHA-256 (`THashSHA2.GetHashString` + `UpperCase`). Redireciona para Home (CLIENTE) ou DashboardAdmin (ADMIN).
2. **TabHome** — Home do cliente:
   - Cards de serviços carregados dinamicamente de TB_SERVICOS (`CarregarServicos`)
   - Filtros de categoria funcionais: Todos / Cabelo / Barba / Estética (`AplicarFiltroCategoria`)
   - Clique num card abre o ecrã de agendamento (`AbrirAgendamento`)
3. **TabAgendamento** — Agendamento completo:
   - Cards de barbeiros carregados de TB_BARBEIROS + TB_USUARIOS (`CarregarBarbeiros`)
   - 20 slots de horário em `flowHorarios` com estados disponível/ocupado (`CarregarHorarios`)
   - Variáveis de sessão: `FServicoIDSelecionado`, `FBarbeiroIDSelecionado`, `FHoraSelecionada`, etc.
   - Botão Confirmar: valida sessão, calcula HR_FIM com `IncMinute`, insere em TB_AGENDAMENTOS

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

1. **Frame Serviços dinâmico** (`View.Frame.Servicos.pas`):
   - Carregar lista de serviços de TB_SERVICOS dinamicamente (substituir as 3 linhas estáticas)
   - Filtros Todos/Ativos/Inativos funcionais (query com WHERE ATIVO=...)
   - Filtros de categoria (Estética/Barba/Cabelo) funcionais
   - Busca por nome (edtBuscaServicos)
   - KPIs reais: total de serviços, ticket médio, serviço mais popular
   - Botão "Novo Serviço": formulário de cadastro (INSERT em TB_SERVICOS)
   - Acções por linha: editar (UPDATE), eliminar (DELETE), toggle ativo/inativo

2. **IDE linkage** — eventos ainda não ligados no Object Inspector:
   - `View.DashboardAdmin.fmx` → Form OnShow → `FormShow`
   - `View.Principal.fmx` → filtros de categoria OnClick (rectFiltroTodos, rectFiltroCabelo, rectFiltroBarba, rectFiltroEstetica)
   - `View.Principal.fmx` → rectBtnConfirmar OnClick → `rectBtnConfirmarClick`

3. **Ecrã de cadastro de utilizador** — `rectBtnNovaConta` abre formulário, INSERT em TB_USUARIOS com SHA-256

4. **Gestão de barbeiros** no dashboard admin

5. **Relatórios financeiros** — gráfico de barras semanal com dados reais de TB_AGENDAMENTOS

---

## Regras Críticas — Nunca Quebrar

### FireDAC / Ligação
- Usar sempre `FireDAC.FMXUI.Wait` (NÃO `FireDAC.VCLUI.Wait`) — este é um projecto FMX
- Incluir obrigatoriamente: `FireDAC.DApt`, `FireDAC.Stan.ExprFuncs`, `FireDAC.Stan.Param`
- Não instanciar `TFDGUIxWaitCursor` — incluir a unit é suficiente
- `FDConnection1` deve ser `public` em `TdmConexao` para acesso externo

### Ficheiros .fmx — NUNCA EDITAR MANUALMENTE
- Os ficheiros `.fmx` são o designer do Delphi; editar à mão corrompe o formulário
- Toda a lógica dinâmica é criada por código em `.pas`
- Componentes do designer são referenciados pelo nome na secção `published` do `.pas`

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
