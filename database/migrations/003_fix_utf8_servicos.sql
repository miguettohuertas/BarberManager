-- Migration 003: Corrigir nomes e descrições corrompidos em TB_SERVICOS
-- Base de dados: BARBERMANAGER.FDB (Firebird 3.0)
-- Ligacao: SYSDBA / masterkey / Protocol=Local
-- Encoding: UTF-8
-- Problema: dados inseridos com encoding errado (Latin-1/Windows-1252 em vez de UTF-8)

UPDATE TB_SERVICOS SET NOME='Manutenção de Barba',   DESCRICAO='Manutenção completa de barba'                            WHERE ID=9;
UPDATE TB_SERVICOS SET NOME='Pigmentação de Barba',  DESCRICAO='Coloração e preenchimento para barba rala ou grisalha.' WHERE ID=6;
UPDATE TB_SERVICOS SET NOME='Hidratação Capilar',    DESCRICAO='Tratamento profundo para restaurar os fios.'             WHERE ID=5;
UPDATE TB_SERVICOS SET                               DESCRICAO='O combo completo para um visual impecável.'              WHERE ID=3;
UPDATE TB_SERVICOS SET CATEGORIA_ID=(SELECT ID FROM TB_CATEGORIAS WHERE NOME='Estética')                                 WHERE ID=4;
UPDATE TB_SERVICOS SET                               DESCRICAO='Descoloração e aplicação de tons platinados.'            WHERE ID=7;

COMMIT;
