-- Migration 004: Reinserir TB_SERVICOS com encoding UTF-8 correcto
-- Base de dados: BARBERMANAGER.FDB (Firebird 3.0)
-- Executar em IBExpert com conexao charset=UTF8

DELETE FROM TB_SERVICOS;

INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (1, 1, 'Corte de Cabelo', 'Corte moderno e personalizado conforme seu estilo.', 45.00, 45, 'Mais Popular', 0);
INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (2, 2, 'Barba Completa', 'Modelagem e acabamento perfeito para sua barba.', 35.00, 30, 'Novo', 1);
INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (3, 4, 'Combo Corte + Barba', 'O combo completo para um visual impecável.', 70.00, 70, '', 1);
INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (4, 3, 'Design de Sobrancelha', 'Alinhamento e design preciso das sobrancelhas.', 30.00, 20, '', 1);
INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (5, 1, 'Hidratação Capilar', 'Tratamento profundo para restaurar os fios.', 55.00, 50, '', 0);
INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (6, 2, 'Pigmentação de Barba', 'Coloração e preenchimento para barba rala ou grisalha.', 45.00, 40, '', 1);
INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (7, 1, 'Platinado', 'Descoloração e aplicação de tons platinados.', 120.00, 120, '', 0);
INSERT INTO TB_SERVICOS (ID, CATEGORIA_ID, NOME, DESCRICAO, PRECO, DURACAO_MIN, BADGE, ATIVO) VALUES (9, 2, 'Manutenção de Barba', 'Manutenção completa de barba', 40.00, 30, '', 1);

UPDATE TB_CATEGORIAS SET NOME='Estética' WHERE ID=3;
UPDATE TB_CATEGORIAS SET NOME='Combo' WHERE ID=4;

COMMIT;