-- Grant.sql
-- Criar funções
CREATE ROLE ADMINISTRATOR;
CREATE ROLE GERENTE;
CREATE ROLE VENDEDOR;
CREATE ROLE AUXILIAR;
CREATE ROLE CAIXA;

-- Conceda permissões para funções

-- Permissões da função ADMINISTRADOR
GRANT ALL PRIVILEGES ON *.* TO ADMINISTRATOR;

-- Permissões da função GERENTE
GRANT SELECT, INSERT, UPDATE, DELETE ON LIVRARIA.* TO GERENTE;

-- Permissões da função VENDEDOR
GRANT SELECT, INSERT, UPDATE ON Livraria.CLIENTE TO VENDEDOR;
GRANT SELECT, INSERT, UPDATE ON Livraria.ENCOMENDA TO VENDEDOR;

-- Permissões de função AUXILIAR
GRANT SELECT, INSERT, UPDATE ON Livraria.FORNECEDOR TO AUXILIAR;
GRANT SELECT ON Livraria.LIVRO_REF TO AUXILIAR;

-- Permissões de função CAIXA
GRANT SELECT, INSERT, UPDATE ON Livraria.COMPRA TO CAIXA;
GRANT SELECT ON Livraria.NOTA_FISCAL TO CAIXA;

-- Criar usuários
CREATE USER admin_user IDENTIFIED BY '12314';
CREATE USER gerente_user IDENTIFIED BY '43536567';
CREATE USER vendedor_user IDENTIFIED BY '54647887';
CREATE USER auxiliar_user IDENTIFIED BY '34536';
CREATE USER caixa_user IDENTIFIED BY '7867654';

-- Atribuir funções aos usuários
GRANT ADMINISTRATOR TO admin_user;
GRANT GERENTE TO gerente_user;
GRANT VENDEDOR TO vendedor_user;
GRANT AUXILIAR TO auxiliar_user;
GRANT CAIXA TO caixa_user;


-- Testar permissões para o GERENTE
-- O papel GERENTE pode selecionar, inserir, atualizar e excluir da tabela Livraria.CLIENTE
USE Livraria;
SELECT * FROM CLIENTE;
INSERT INTO CLIENTE (cpf, nome, idade, dt_nasc, flag_professor, status_, dt_fim_adesao, dt_inic_adesao, cnpj_bookstore, cod_plano_fid, pontos_fidelidade) VALUES ('12345678999', 'Cliente de Teste', 25, '1998-01-01', false, 'Ativo', '2040-01-01', '2023-01-01', '12345678901234', 1, 100);
UPDATE CLIENTE SET nome = 'Cliente Atualizado' WHERE cpf = '12345678999';
DELETE FROM CLIENTE WHERE cpf = '12345678999';

-- Testar permissões para o VENDEDOR
-- O papel VENDEDOR pode selecionar, inserir e atualizar as tabelas Livraria.CLIENTE e Livraria.ENCOMENDA
SELECT * FROM CLIENTE;
INSERT INTO ENCOMENDA (id, data_pedido, dt_prevista, status_, cpf_cliente) VALUES (6, '2023-09-01', '2023-09-10', 'Em Processamento', '23456789012');
UPDATE CLIENTE SET nome = 'Cliente Atualizado' WHERE cpf = '23456789012';
UPDATE ENCOMENDA SET status = 'Entregue' WHERE id = 6;

-- Testar permissões para o AUXILIAR
-- O papel AUXILIAR pode selecionar a partir das tabelas Livraria.FORNECEDOR e Livraria.LIVRO_REF
SELECT * FROM FORNECEDOR;
SELECT * FROM LIVRO_REF;

-- Testar permissões para o CAIXA
-- O papel CAIXA pode selecionar, inserir e atualizar as tabelas Livraria.COMPRA e Livraria.NOTA_FISCAL
SELECT * FROM COMPRA;
INSERT INTO COMPRA (cod, vl_desconto, v_imposto, dt_compra, vl_total_bruto, vl_total_a_pagar, vl_comissao, cod_pdv, cpf_vend, cod_NF, cpf_cliente) VALUES (6, 10.00, 20.00, '2023-09-01', 200.00, 170.00, 15.00, 101, '12345678901', 'NF123456', '12345678901');
UPDATE COMPRA SET vl_desconto = 5.00 WHERE cod = 6;

-- Revogar permissões para o AUXILIAR (apenas para fins de teste)
REVOKE SELECT ON Livraria.FORNECEDOR FROM AUXILIAR;
-- A linha abaixo deve produzir um erro devido à permissão revogada
SELECT * FROM FORNECEDOR;