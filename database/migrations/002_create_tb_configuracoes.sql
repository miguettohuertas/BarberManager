-- Migration 002: Criar tabela TB_CONFIGURACOES
-- Base de dados: BARBERMANAGER.FDB (Firebird 3.0)
-- Ligacao: SYSDBA / masterkey / Protocol=Local

CREATE TABLE TB_CONFIGURACOES (
  ID       INTEGER      NOT NULL PRIMARY KEY,
  CHAVE    VARCHAR(50)  NOT NULL UNIQUE,
  VALOR    VARCHAR(255),
  DESCRICAO VARCHAR(255)
);

INSERT INTO TB_CONFIGURACOES (ID, CHAVE, VALOR, DESCRICAO) VALUES (1, 'NOME_BARBEARIA',    'BarberManager', 'Nome da barbearia exibido no sistema');
INSERT INTO TB_CONFIGURACOES (ID, CHAVE, VALOR, DESCRICAO) VALUES (2, 'META_DIARIA',        '430.00',        'Meta de faturamento diario em R$');
INSERT INTO TB_CONFIGURACOES (ID, CHAVE, VALOR, DESCRICAO) VALUES (3, 'HORARIO_ABERTURA',   '09:00',         'Horario de abertura da barbearia');
INSERT INTO TB_CONFIGURACOES (ID, CHAVE, VALOR, DESCRICAO) VALUES (4, 'HORARIO_FECHAMENTO', '18:30',         'Horario de fechamento da barbearia');
INSERT INTO TB_CONFIGURACOES (ID, CHAVE, VALOR, DESCRICAO) VALUES (5, 'TELEFONE',           '',              'Telefone de contato');
INSERT INTO TB_CONFIGURACOES (ID, CHAVE, VALOR, DESCRICAO) VALUES (6, 'ENDERECO',           '',              'Endereco da barbearia');
COMMIT;
