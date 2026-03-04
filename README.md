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

A visão macro do sistema, mostrando os utilizadores e o valor de negócio do BarberManager.

C4Context
  title Diagrama de Contexto (Nível 1) - BarberManager

  Person(cliente, "Cliente", "Cliente da barbearia que deseja agendar horários de forma autónoma.")
  Person(barbeiro, "Barbeiro / Admin", "Profissional que gere a agenda, serviços e finanças.")
  
  System(barberManager, "BarberManager", "Sistema Integrado de Gestão e Agendamento Web.")

  Rel(cliente, barberManager, "Visualiza horários disponíveis e efetua agendamentos", "HTTPS")
  Rel(barbeiro, barberManager, "Gere a agenda diária, clientes e faturação", "HTTPS")


Nível 2: Diagrama de Contêineres

Visão técnica de alto nível, mostrando a distribuição das tecnologias e como a aplicação Delphi se comunica com a Web e com a Base de Dados.

C4Container
  title Diagrama de Contêineres (Nível 2) - BarberManager

  Person(cliente, "Cliente", "Utiliza o telemóvel ou computador.")
  Person(barbeiro, "Barbeiro", "Utiliza o tablet ou computador do balcão.")

  System_Boundary(c1, "Sistema BarberManager") {
      Container(web_app, "Interface Web (Frontend)", "HTML, CSS, JS", "Interface do utilizador gerada dinamicamente pelo servidor.")
      Container(backend, "Servidor de Aplicação (Backend)", "Delphi VCL + D2Bridge", "Processa as regras de negócio e renderiza a interface Web através do D2Bridge.")
      ContainerDb(database, "Base de Dados", "Firebird / SQLite", "Armazena clientes, agendamentos, serviços e registos financeiros.")
  }

  Rel(cliente, web_app, "Acede a", "HTTPS")
  Rel(barbeiro, web_app, "Acede a", "HTTPS")
  Rel(web_app, backend, "Comunica com", "WebSockets / HTTP")
  Rel(backend, database, "Lê e Escreve dados", "FireDAC / TCP")


Nível 3: Diagrama de Componentes (Backend)

Visão interna do servidor Delphi, detalhando a estrutura de pastas e responsabilidades (MVC/Arquitetura do Código) que criámos.

C4Component
  title Diagrama de Componentes (Nível 3) - Servidor Delphi

  ContainerDb(database, "Base de Dados", "Firebird / SQLite", "Armazenamento relacional.")

  Container_Boundary(backend, "Servidor de Aplicação (Delphi)") {
      Component(d2bridge, "Motor D2Bridge", "Framework Web", "Responsável por intercetar a VCL e transformá-la em Web.")
      
      Component(view, "View.Principal", "TForm (Interface)", "Gere o layout da página, botões e painéis laterais.")
      Component(controller, "Regras de Negócio", "Units Pascal", "Valida choque de horários (RN01) e calcula valores.")
      Component(model, "Model.Conexao", "TDataModule", "Centraliza a ligação FireDAC, Querys e Transações.")
      
      Rel(d2bridge, view, "Renderiza para Web")
      Rel(view, controller, "Solicita validações e envia dados", "Pascal Method Call")
      Rel(controller, model, "Solicita persistência", "Pascal Method Call")
  }

  Rel(model, database, "Executa scripts SQL (CRUD)", "FireDAC")

