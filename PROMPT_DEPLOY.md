# PROMPT_DEPLOY — Contexto para Nova Sessão Claude: Deploy do BarberManager

Usa este ficheiro como ponto de partida numa nova conversa com Claude Code focada exclusivamente no deploy.

---

## Pedido

Quero expor o BarberManager publicamente na internet com uma URL acessível de qualquer lugar, sem custos ou com custo mínimo. O servidor corre localmente no meu PC Windows e precisa de permanecer assim — não posso mover para Linux.

---

## O que é o BarberManager

Sistema de gestão de barbearia com:
- **REST API** em Object Pascal (Delphi 12 + Horse framework) — servidor HTTP na porta 9000
- **Frontend Web** HTML/CSS/JS puro (single-file `index.html`) servido pelo mesmo processo
- **Base de dados** Firebird 3.0 local (protocolo Local, ficheiro `.FDB`)
- **App nativo** Delphi FMX (Windows/Android) — secundário, não relevante para o deploy

O servidor é um **executável Windows** (`BarberManagerAPI.exe`) que ao correr imprime:
```
BarberManager API running on http://localhost:9000
Press Enter to stop...
```

Abrindo `http://localhost:9000` no browser aparece o Web App completo (login, dashboard admin, área cliente, agendamentos, etc.).

---

## Restrição Crítica

> **O executável é um `.exe` compilado para Windows. Não corre em Linux. Não é possível fazer deploy numa VPS Linux standard.**

Opções que **não funcionam**:
- Heroku, Railway, Render, Fly.io (todos Linux)
- Docker com imagem Linux
- Qualquer PaaS que não suporte Windows nativo

---

## Estado Actual

- `BarberManagerAPI.exe` corre perfeitamente em `localhost:9000`
- Todos os endpoints funcionais e testados
- Frontend completo em `index.html` (servido pelo próprio .exe em `GET /`)
- Base de dados Firebird em `C:\ProjetosDelphi\BarberManager\BarberManager\database\BARBERMANAGER.FDB`
- `fbclient.dll` em `C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll`
- Repositório GitHub: `https://github.com/miguettohuertas/BarberManager`

---

## Opções a Explorar (por ordem de preferência)

### 1. Cloudflare Tunnel (`cloudflared`) — preferida
- Instala o agente `cloudflared` no Windows
- Cria um túnel permanente: `cloudflared tunnel --url http://localhost:9000`
- Dá uma URL pública `https://xxx.trycloudflare.com` (gratuita, sem conta) ou URL personalizada (com conta Cloudflare grátis)
- Sem necessidade de abrir portas no router ou firewall
- O `.exe` continua a correr localmente

### 2. ngrok
- `ngrok http 9000` → URL `https://xxx.ngrok.io`
- Plano gratuito tem URL que muda a cada reinício
- Plano pago ($8/mês) dá URL estática

### 3. VPS Windows
- Azure (tem VMs Windows) ou AWS EC2 com Windows Server
- Copiar o `.exe`, `fbclient.dll`, `BARBERMANAGER.FDB` e `index.html` para a VM
- Abrir porta 9000 no firewall
- Custo: ~$15-30/mês (não ideal para projecto académico)

### 4. Tailscale / ZeroTier
- VPN mesh — dá acesso à máquina por IP privado
- Não dá URL pública real, apenas acesso dentro da rede Tailscale

---

## Ficheiros Relevantes

```
BarberManager/
├── BarberManagerAPI.dpr          — projecto Delphi (compilar com Delphi 12)
├── Win32/Debug/BarberManagerAPI.exe  — executável compilado
├── index.html                    — frontend servido em GET /
├── database/BARBERMANAGER.FDB    — base de dados Firebird
└── src/
    ├── API/                      — handlers Horse REST
    └── Web/index.html            — fonte do frontend
```

**Porta:** `9000` (configurada em `BarberManagerAPI.dpr`, linha `THorse.Listen(9000)`)

---

## O que Quero no Final

1. URL pública estável (idealmente HTTPS) acessível de qualquer browser
2. Que o servidor continue a correr no meu PC Windows
3. Custo zero ou próximo de zero (projecto académico)
4. Solução simples de configurar e re-iniciar quando necessário

---

## Contexto Técnico Adicional

- **OS:** Windows 11 Home Single Language
- **Delphi:** 12 Athens (reinstalado recentemente)
- **Horse framework:** `C:\Horse\horse-master\src`
- **Firebird:** 3.0, protocolo Local (não TCP/IP), `fbclient.dll` em `C:\Program Files (x86)\Firebird\Firebird_3_0\`
- **CORS:** já configurado no middleware do Horse (aceita qualquer origem)
- **API_BASE:** `''` (URLs relativas) no `index.html` — funciona correctamente quando servido pelo mesmo servidor

---

## O que NÃO fazer

- Não sugerir migrar a BD para PostgreSQL/MySQL (implicaria reescrever toda a camada de dados)
- Não sugerir reescrever a API em Node.js/Python (o objectivo é fazer deploy do .exe existente)
- Não sugerir Docker Linux
- Não abrir portas directamente no router sem VPN/túnel (segurança)
