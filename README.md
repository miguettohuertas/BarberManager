# BarberManager 

Sistema Web de Gestão para Barbearias e Agendamento Online.

##  Visão do Projeto
Projeto desenvolvido para a disciplina de Programação Web. Trata-se de uma aplicação **Fullstack** desenvolvida em **Delphi** (utilizando framework web D2Bridge/VCL), visando solucionar problemas de agendamento e gestão financeira de barbearias.

##  Domínio do Problema
O objetivo é informatizar barbearias que ainda utilizam papel ou planilhas, resolvendo as seguintes dores:
1.  **Conflito de Horários:** Eliminar o erro humano no agendamento manual (WhatsApp/Telefone).
2.  **Gestão Financeira:** Controle automatizado de comandas, cortes realizados e cálculo de comissão dos barbeiros.
3.  **Fidelização:** Manter histórico do cliente (preferências de corte e frequência).

##  Funcionalidades (Escopo)

### Módulo Cliente (Web/Mobile)
- [ ] Cadastro e Login de usuários.
- [ ] Visualização de agenda disponível em tempo real.
- [ ] Agendamento de horário (CRUD Agendamento).
- [ ] Histórico de cortes realizados.

### Módulo Administrativo (Barbeiro/Gerente)
- [ ] **Dashboard:** Visão geral da agenda do dia/semana.
- [ ] **Gestão de Clientes:** Cadastro completo (CRUD Clientes).
- [ ] **Financeiro:** Lançamento de serviços, controle de caixa e pagamentos pendentes.
- [ ] **Serviços:** Cadastro de tipos de corte e valores.

##  Tecnologias
- **Linguagem:** Delphi (Object Pascal)
- **Web Framework:** D2Bridge (Server-side rendering)
- **Banco de Dados:** Firebird
- **Controle de Versão:** Git & GitHub

---
*Projeto em desenvolvimento ativo - Semestre 2026*

🗺️ Arquitetura do Sistema (Modelo C4)

Abaixo estão os diagramas arquiteturais do projeto BarberManager, modelados segundo a metodologia C4.

Nível 1: Diagrama de Contexto

A visão macro do sistema, mostrando os utilizadores e o valor de negócio.

flowchart TD
    %% Definição das cores oficiais do C4 Model
    classDef person fill:#08427b,stroke:#052e56,color:#fff,rx:20,ry:20
    classDef system fill:#1168bd,stroke:#0b4884,color:#fff,rx:5,ry:5

    C["👤 Cliente<br/><small>Deseja agendar horários</small>"]:::person
    B["👤 Barbeiro / Admin<br/><small>Gere a agenda e finanças</small>"]:::person
    BM["⚙️ BarberManager<br/><small>[Sistema de Software]</small><br/>Sistema Integrado Web"]:::system

    C -->|"Agenda horários (HTTPS)"| BM
    B -->|"Gere o sistema (HTTPS)"| BM


Nível 2: Diagrama de Contêineres

Visão técnica de alto nível, mostrando a distribuição das tecnologias.

flowchart TD
    classDef person fill:#08427b,stroke:#052e56,color:#fff,rx:20,ry:20
    classDef container fill:#438dd5,stroke:#2e6295,color:#fff,rx:5,ry:5
    classDef db fill:#438dd5,stroke:#2e6295,color:#fff

    C["👤 Cliente"]:::person
    B["👤 Barbeiro"]:::person

    subgraph BarberManager ["BarberManager (Sistema)"]
        direction TB
        WEB["🌐 Interface Web (Frontend)<br/><small>[Contêiner: HTML/JS]</small>"]:::container
        API["🖥️ Servidor Delphi (Backend)<br/><small>[Contêiner: Delphi VCL + D2Bridge]</small>"]:::container
        DB[("🗄️ Base de Dados<br/><small>[Contêiner: Firebird/SQLite]</small>")]:::db
    end

    C -->|"Acessa"| WEB
    B -->|"Acessa"| WEB
    WEB -->|"Comunica (HTTP/WS)"| API
    API -->|"Lê/Escreve (FireDAC)"| DB


Nível 3: Diagrama de Componentes (Backend)

Visão interna do servidor Delphi, detalhando a arquitetura MVC do código.

flowchart TD
    classDef comp fill:#85b3e1,stroke:#5d7d9e,color:#000,rx:5,ry:5
    classDef db fill:#438dd5,stroke:#2e6295,color:#fff

    DB[("🗄️ Base de Dados<br/><small>[Firebird/SQLite]</small>")]:::db

    subgraph Backend ["Servidor de Aplicação (Backend Delphi)"]
        direction TB
        D2["Motor D2Bridge<br/><small>[Framework Web]</small>"]:::comp
        VIEW["View.Principal<br/><small>[TForm/Interface]</small>"]:::comp
        CTRL["Regras de Negócio<br/><small>[Controller/Units]</small>"]:::comp
        MODEL["Model.Conexao<br/><small>[TDataModule]</small>"]:::comp
    end

    D2 -->|"Renderiza"| VIEW
    VIEW -->|"Solicita validações"| CTRL
    CTRL -->|"Solicita persistência"| MODEL
    MODEL -->|"Executa SQL"| DB


