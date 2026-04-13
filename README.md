BarberManager

BarberManager é um sistema completo e moderno para a gestão de barbearias, projetado para revolucionar a conexão entre barbeiros e clientes. O projeto visa eliminar o atrito dos agendamentos manuais e oferecer um controle financeiro e administrativo robusto para os proprietários.

Este projeto é desenvolvido como requisito da disciplina de Programação Web, aplicando boas práticas de Engenharia de Software, UI/UX Design moderno e Arquitetura Limpa.

Sumário

Visão Geral do Sistema

Arquitetura e Tecnologias

Telas e Navegação (Protótipo Interativo)

Módulos e Funcionalidades

Estrutura do Repositório

Próximos Passos (Roadmap)

Como Executar

Visão Geral do Sistema

O sistema é dividido em dois universos distintos, compartilhando a mesma base de código (Single Codebase) graças ao poder do Delphi FMX:

App Mobile (Para Clientes): Focado na experiência do utilizador (UX), permitindo cadastro ágil, escolha de serviços e agendamento de horários em poucos cliques.

Dashboard Web/Desktop (Para Administradores): Um painel de controle de alta produtividade (resolução 1280x720) para os barbeiros gerirem a fila de espera, serviços oferecidos e a faturação diária.

Arquitetura e Tecnologias

Linguagem: Delphi (Object Pascal)

Framework de Interface: FMX (FireMonkey) - Permitindo a compilação nativa para Windows, Android, iOS e Web.

Paradigma UI: Single Page Application (SPA) utilizando TTabControl com transições fluidas (Slide) no Mobile e injeção de TFrames na arquitetura Desktop.

Modelagem: C4 Model (Diagramas de Contexto, Componentes e Servidor disponíveis na pasta docs/diagramas_c4/).

Base de Dados (Planeado): SQLite (Mobile) / Firebird ou MySQL (Servidor) com framework de persistência a ser definido.

Telas e Navegação (Protótipo Interativo)

Atualmente, o projeto encontra-se na fase de Protótipo de Alta Fidelidade, onde todas as telas foram desenhadas e a navegação (roteamento) está 100% funcional, simulando a experiência final do utilizador.

Universo Cliente (App Mobile)

[!Login] (docs/Telas/01_login.png)

Nova Conta





Acesso seguro com design limpo e logo em destaque.

Formulário amigável com ícones e identificação visual.

Home Principal

Agendamento





Carrossel de categorias, banners de oferta e serviços.

Calendário, grelha de horários via FlowLayout e confirmação.

Universo Administrador (Desktop / Web)

Dashboard Administrativo

Gestão de Serviços





Visão geral financeira, KPIs e Linha do Tempo da agenda.

Catálogo dinâmico com filtros, contadores e ações rápidas.

Nota: Para visualizar as imagens em alta resolução e no tamanho original, acesse o diretório docs/Telas/ neste repositório.

Módulos e Funcionalidades

Módulo Cliente (Concluído no Front-End)

[x] Autenticação (Login e Cadastro com ícones nos inputs).

[x] Navegação por "Bottom Navigation" (Início, Agenda, Carrinho, Perfil).

[x] Catálogo de Serviços com rolagem inteligente horizontal.

[x] Motor de Agendamento (Seleção intuitiva de Dia, Horário e Barbeiro).

Módulo Barbeiro/Admin (Concluído no Front-End)

[x] Sidebar de Navegação responsiva.

[x] Cards de Resumo Financeiro (KPIs: Faturação, Ticket Médio, Pendentes).

[x] Linha do Tempo (Agenda do Dia) com avatares e status de serviço.

[x] Tela de Gestão de Serviços (Tabela de dados customizada sem uso de componentes de terceiros).

Estrutura do Repositório

 BarberManager
 ┣  docs
 ┃ ┣  diagramas_c4      # Arquivos .puml e renders da arquitetura
 ┃ ┗  Telas             # Prints das telas de UI/UX aprovadas
 ┣  src                 # Códigos fonte Delphi (.pas, .fmx)
 ┃ ┣  View.Principal.pas       # Casca do App Mobile e Navegação
 ┃ ┣  View.DashboardAdmin.pas  # Painel principal do Admin
 ┃ ┗  View.Frame.Servicos.pas  # Frame injetável de Serviços
 ┗  README.md           # Esta documentação


 Próximos Passos (Roadmap)

A metodologia de desenvolvimento adotada separa estritamente o Front-end do Back-end. Os próximos passos são:

[x] Fase 1: Definição de Escopo e Requisitos.

[x] Fase 2: Design System e Protótipos no Figma.

[x] Fase 3: Construção do Front-End (UI) no Delphi FMX.

[x] Fase 4: Navegação, Transições e UX interativa (Mockups).

[ ] Fase 5: Modelagem da Base de Dados Relacional (DER).

[ ] Fase 6: Criação do Back-End (Regras de Negócio e APIs).

[ ] Fase 7: Integração Front x Back (Data Binding e Persistência).

 Como Executar o Protótipo

Para testar a interface e a navegação atual do sistema:

Clone este repositório: git clone https://github.com/seu-usuario/BarberManager.git

Abra o arquivo .dproj no Embarcadero Delphi (Community Edition ou superior).

Defina a plataforma alvo como Windows 32-bit ou Android para visualizar a responsividade.

Pressione F9 (Run).

Navegação de Teste:

Clique em "Criar Nova Conta" para ver a transição em Slide.

Clique em "Entrar" para aceder à Home do cliente.

Na tela de Login, clique na Logo do aplicativo para aceder instantaneamente à área Administrativa (Desktop).

Dentro do Admin, utilize o menu lateral para alternar entre "Agenda" (Início) e "Serviços".
