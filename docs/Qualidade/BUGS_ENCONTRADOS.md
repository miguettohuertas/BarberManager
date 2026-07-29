# Bugs e Melhorias Encontrados — Testes Automatizados (Postman/Newman)

Este documento registra os achados dos testes automatizados de API do BarberManager
(Postman + Newman), com passo a passo para reprodução, comportamento esperado, e
sugestão de correção. Atualizado conforme os módulos vão sendo testados.

---

## Módulo: Servicos (`API.Servicos.pas`)

### 🐛 Bug #1 — FK de categoria inválida trava a API (exceção não tratada)

**Severidade:** Alta

**Como reproduzir:**
1. Com a API rodando, enviar `POST /api/servicos`
2. Body com um campo de categoria em formato incorreto ou inexistente, por exemplo:
```json
{
  "nome": "Teste",
  "descricao": "Teste",
  "preco": 50.00,
  "duracaoMin": 30,
  "categoria": "Cabelo"
}
```
(nesse exemplo o campo correto seria `categoriaId` numérico, não `categoria` string —
mas o efeito é o mesmo com qualquer `categoriaId` inexistente, como `0` ou `999`)

**Comportamento observado:**
- A API não valida a categoria antes do `INSERT`
- O Firebird rejeita com `[FireDAC][Phys][FB] violation of FOREIGN KEY constraint "FK_SERVICOS_CAT"`
- A exceção **não é tratada** pelo endpoint — o processo Delphi abre o Debugger Exception
  Notification e trava, esperando interação manual (`Continue`/`Break`)
- Em produção (sem o Delphi IDE anexado), isso provavelmente derrubaria o processo da API
  inteiro para todos os usuários, a partir de um único request malformado

**Comportamento esperado:**
- Validar se `categoriaId` foi enviado e existe em `TB_CATEGORIAS` **antes** do INSERT
- Retornar `400 Bad Request` com mensagem clara, ex: `{"erro": "Categoria inválida"}`

**Sugestão de correção:**
```pascal
// Antes do INSERT em API.Servicos.pas (RotaCriar):
QueryCategoria.SQL.Text := 'SELECT ID FROM TB_CATEGORIAS WHERE ID = :ID';
QueryCategoria.ParamByName('ID').AsInteger := CategoriaId;
QueryCategoria.Open;
if QueryCategoria.IsEmpty then
begin
  Res.Status(400).Send<TJSONObject>(TJSONObject.Create.AddPair('erro', 'Categoria inválida'));
  Exit;
end;
```
Também vale envolver o `ExecSQL` num `try/except` que capture `EIBNativeException` e
outras exceções de banco, convertendo para uma resposta HTTP `400`/`500` limpa em vez de
deixar a exceção subir sem tratamento.

---

### 🐛 Bug #2 — Encoding incorreto nas mensagens de resposta (acentuação corrompida)

**Severidade:** Média

**Como reproduzir:**
1. `POST /api/servicos` com um serviço válido → resposta: `"ServiÃ§o criado com sucesso"`
2. `PUT /api/servicos/:id` (editar) → resposta: `"ServiÃ§o atualizado"`
3. `DELETE /api/servicos/:id` → resposta: `"ServiÃ§o removido"`
4. `POST /api/servicos` sem campo `nome` → resposta: `"Nome obrigatÃ³rio"`

**Comportamento observado:**
Todas as mensagens de texto com acentuação vêm corrompidas no formato clássico de
mojibake UTF-8 mal interpretado (`ç` → `Ã§`, `ó` → `Ã³`).

**Comportamento esperado:**
Mensagens devolvidas com acentuação correta (`Serviço criado com sucesso`).

**Observação:** o projeto já corrigiu esse tipo de problema antes no banco de dados
(via `FixDB.pas`, `CharacterSet=UTF8` na conexão) — este é o mesmo tipo de problema,
mas ocorrendo na **resposta HTTP** da API Horse, não nos dados armazenados. Provável
causa: o header `Content-Type` da resposta não está declarando `charset=utf-8`, ou o
`Res.Send` não está codificando a string corretamente antes de enviar.

**Sugestão de correção:**
- Garantir `Res.AddHeader('Content-Type', 'application/json; charset=utf-8')` em todas
  as respostas (ou middleware global que aplique isso a todas as rotas)
- Confirmar que a origem da string (literal no código `.pas`) está salva como UTF-8 sem BOM

**Abrangência:** confirmado em pelo menos 4 respostas do módulo Servicos (criar, editar,
deletar, validação). Deve ser verificado nos demais módulos também.

---

### 🐛 Bug #3 — Nomes de serviço duplicados são permitidos

**Severidade:** Baixa/Média

**Como reproduzir:**
1. `POST /api/servicos` com `"nome": "Servico Teste Postman"` → sucesso
2. `POST /api/servicos` novamente com o mesmo `"nome": "Servico Teste Postman"` → sucesso também, cria um segundo registro idêntico

**Comportamento observado:**
Nenhuma validação de unicidade de nome — dois (ou mais) serviços com nome idêntico
podem existir simultaneamente na tabela `TB_SERVICOS`.

**Comportamento esperado:**
Rejeitar criação de serviço com nome já existente (ativo), ou pelo menos alertar/confirmar.

**Sugestão de correção:**
```pascal
QueryDup.SQL.Text := 'SELECT COUNT(*) AS TOTAL FROM TB_SERVICOS WHERE UPPER(NOME) = UPPER(:NOME) AND ATIVO = 1';
QueryDup.ParamByName('NOME').AsString := Nome;
QueryDup.Open;
if QueryDup.FieldByName('TOTAL').AsInteger > 0 then
begin
  Res.Status(400).Send<TJSONObject>(TJSONObject.Create.AddPair('erro', 'Já existe um serviço ativo com esse nome'));
  Exit;
end;
```

---

## Módulo: Agendamentos (`API.Agendamentos.pas`)

### 🐛 Bug #4 — Sem validação de conflito de horário do barbeiro

**Severidade:** Crítica

**Como reproduzir:**
1. `POST /api/agendamentos` com `barbeiroId: 3`, `data: "2026-12-15"`, `horaInicio: "10:00"`
   (serviço de 30min, então ocupa `10:00–11:00` considerando o horário de exemplo usado)
   → sucesso, `201 Created`
2. `POST /api/agendamentos` novamente, **mesmo barbeiro (3)**, **mesma data**, agora com
   `horaInicio: "10:30"` (horário que se sobrepõe ao primeiro) → também retorna sucesso,
   `201 Created` — deveria ter sido rejeitado

**Comportamento observado:**
A API aceita dois (ou mais) agendamentos para o mesmo barbeiro, na mesma data, em
horários que se sobrepõem, sem qualquer validação ou aviso.

**Comportamento esperado:**
Rejeitar com `400 Bad Request` (ex: `{"erro": "Barbeiro já possui agendamento nesse
horário"}`) quando o intervalo `[horaInicio, horaFim]` do novo agendamento colide com
outro agendamento existente do mesmo barbeiro na mesma data (considerar apenas status
`PENDENTE`/`EM_ANDAMENTO`/`CONCLUIDO` — agendamentos `CANCELADO` não devem contar).

**Evidência adicional:** os próprios dados de desenvolvimento já continham este problema
antes do teste automatizado confirmar formalmente — agendamentos `id 5` e `id 6` (ambos
`Pedro Alves`, `26/04/2026`, `09:00–11:00`) e `id 7`/`id 8` (mesmo barbeiro, mesma data,
`18:00–18:30`).

**Impacto no negócio:** este é o bug de maior severidade encontrado até agora — permite
que a barbearia aceite, na prática, compromissos impossíveis de cumprir (um barbeiro
não pode atender dois clientes simultaneamente), gerando conflitos reais de agenda.

**Sugestão de correção:**
```pascal
// Antes do INSERT em API.Agendamentos.pas (RotaCriar):
QueryConflito.SQL.Text :=
  'SELECT COUNT(*) AS TOTAL FROM TB_AGENDAMENTOS ' +
  'WHERE BARBEIRO_ID = :BARBEIRO_ID ' +
  '  AND DT_AGENDAMENTO = :DATA ' +
  '  AND STATUS NOT IN (''CANCELADO'') ' +
  '  AND (:HR_INICIO < HR_FIM AND :HR_FIM > HR_INICIO)'; // sobreposição de intervalos
QueryConflito.ParamByName('BARBEIRO_ID').AsInteger := BarbeiroId;
QueryConflito.ParamByName('DATA').AsDate := DataAgendamento;
QueryConflito.ParamByName('HR_INICIO').AsTime := HoraInicio;
QueryConflito.ParamByName('HR_FIM').AsTime := HoraFim;
QueryConflito.Open;
if QueryConflito.FieldByName('TOTAL').AsInteger > 0 then
begin
  Res.Status(400).Send<TJSONObject>(TJSONObject.Create.AddPair('erro', 'Barbeiro já possui agendamento nesse horário'));
  Exit;
end;
```

---

### 🐛 Bug #5 — Valor do agendamento não é calculado na criação

**Severidade:** Alta (impacto financeiro/relatórios)

**Como reproduzir:**
1. `POST /api/agendamentos` com um `servicoId` cujo `preco` é, por exemplo, `35.0`
2. Consultar o agendamento criado via `GET /api/agendamentos`

**Comportamento observado:**
O campo `valor` do agendamento criado vem como `0.0`, independente do preço real do
serviço selecionado.

**Comportamento esperado:**
Segundo a própria documentação do projeto (`CLAUDE.md`), `VALOR_COBRADO` deveria ser um
"snapshot do preço no momento do agendamento" — ou seja, ao criar o agendamento, a API
deveria buscar o `PRECO` atual do `servicoId` e gravá-lo em `VALOR_COBRADO`.

**Impacto no negócio:** KPIs de faturamento (Dashboard) e relatórios financeiros que
somam `VALOR_COBRADO` ficam incorretos para todo agendamento criado via API sem esse
cálculo — o que compromete diretamente as métricas mais importantes do painel do admin.

**Sugestão de correção:**
```pascal
// Ao montar o INSERT em API.Agendamentos.pas (RotaCriar), buscar o preço antes:
QueryServico.SQL.Text := 'SELECT PRECO, DURACAO_MIN FROM TB_SERVICOS WHERE ID = :ID';
QueryServico.ParamByName('ID').AsInteger := ServicoId;
QueryServico.Open;
ValorCobrado := QueryServico.FieldByName('PRECO').AsFloat;
// ... usar ValorCobrado no INSERT como VALOR_COBRADO
```

---

## Observações de Ambiente (não são bugs de código)

### ⚠️ IBExpert conectado bloqueia a API
A conexão Firebird da API usa `Protocol=Local` (acesso direto ao arquivo `.fdb`). Se o
IBExpert estiver com uma conexão aberta no mesmo `BARBERMANAGER.FDB` durante os testes,
qualquer escrita da API falha com erro de I/O (`arquivo já está sendo usado por outro
processo`), e — como no Bug #1 — a exceção não tratada trava o processo no debugger.

**Prática recomendada:** sempre desconectar o IBExpert do banco antes de rodar testes
de escrita (`POST`/`PUT`/`DELETE`) contra a API local.

### ⚠️ Ausência de banco de dados isolado para testes
Os testes automatizados gravam, editam e removem dados diretamente no
`BARBERMANAGER.FDB` de desenvolvimento — não existe hoje um banco `.fdb` dedicado a
testes. Isso já gerou registros de teste "sujando" a base (ex: serviços `Servico Teste
Postman`, criados e depois removidos manualmente durante a sessão de testes).

**Sugestão futura:** criar um `BARBERMANAGER_TEST.FDB` separado (cópia do schema) e uma
variável de ambiente/configuração que aponte a API para ele quando rodando em modo de
teste, evitando qualquer risco de corromper dados de desenvolvimento ou produção.

---

## Como este documento deve ser usado

- Cada novo módulo testado (`Agendamentos`, `Dashboard`, `Clientes`, `Barbeiros`,
  `Avaliacoes`, `Usuarios`) deve adicionar sua própria seção aqui, seguindo o mesmo
  formato: **Severidade → Como reproduzir → Comportamento observado → Comportamento
  esperado → Sugestão de correção**
- Bugs corrigidos devem ser marcados com ~~riscado~~ e a data da correção, mantendo o
  histórico (não apagar o registro)
- Este arquivo serve tanto como evidência do processo de QA quanto como backlog técnico
  de correções
