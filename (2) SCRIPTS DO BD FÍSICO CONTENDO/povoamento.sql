-- Povoamento - Livraria.sql
-- povoamento de tabela
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO GENERO (cod, descricao)
VALUES
    (1, 'Ficção Científica'),
    (2, 'Romance'),
    (3, 'Fantasia'),
    (4, 'Mistério'),
    (5, 'História');
-- ==================================
INSERT INTO PLANO_FIDELIDADE (cod, tipo, dt_inicio, dt_fim, descricao)
VALUES
    (1, 'Prata', '2023-01-01', '2023-12-31', 'Plano Prata: Descontos especiais em compras e acumulação de pontos.'),
    (2, 'Ouro', '2023-01-01', '2023-12-31', 'Plano Ouro: Descontos ainda maiores e benefícios exclusivos.'),
    (3, 'Bronze', '2023-01-01', '2023-12-31', 'Plano Bronze: Descontos básicos e oportunidades de ganhar pontos.'),
    (4, 'VIP', '2023-01-01', '2023-12-31', 'Plano VIP: Acesso a eventos exclusivos, descontos premium e recompensas únicas.'),
    (5, 'Básico', '2023-01-01', '2023-12-31', 'Plano Básico: Descontos mínimos e vantagens limitadas para novos clientes.');
-- =========================================================
INSERT INTO COMISSAO (id, tipo, dt_inicio, dt_fim, percentual)
VALUES
    (1, 'Venda', '2023-01-01', '2040-08-08', 5.00),
    (2, 'Indicação', '2023-01-01', '2040-02-08', 10.00),
    (3, 'Promoção', '2023-02-15', '2023-03-15', 3.00),
    (4, 'Desconto', '2023-03-01', '2040-02-18', 2.00),
    (5, 'Evento', '2023-04-01', '2040-01-28', 7.00);
-- =============================================================
INSERT INTO PAGAMENTO (cod_pag, vl_pago, tipo_pagamento, bandeira)
VALUES
    (1, 50.00, 'Cartão de Crédito', 'Visa'),
    (2, 30.00, 'Dinheiro', null),
    (3, 25.00, 'PIX', 'Inter'),
    (4, 15.00, 'Boleto Bancário', 'Caixa'),
    (5, 40.00, 'Cartão de Débito', 'Mastercard');
-- =============================================================
INSERT INTO BOOKSTORE (cnpj, razao_social, nome_fantasia, qtd_funcionarios, endereco)
VALUES
    ('12345678901234', 'Livros Ltda.', 'Livros Express', 20, 'Rua dos Livros, 123'),
    ('23456789012345', 'Livraria ABC', 'ABC Livros', 15, 'Avenida das Páginas, 456'),
    ('34567890123456', 'Mundo dos Livros', 'Mundo Literário', 30, 'Praça das Histórias, 789'),
    ('45678901234567', 'Leitura Rápida', 'Leitura Rápida', 10, 'Rua das Leituras, 101'),
    ('56789012345678', 'Páginas Mágicas', 'Páginas Mágicas', 25, 'Avenida da Imaginação, 202');
-- ==============================================================
INSERT INTO ESTOQUE (id, serial_, descricao, data_ult_compra, cnpj_bookstore)
VALUES
    (1, 'EST001', 'Estoque Principal', '2023-07-10', '12345678901234'),
    (2, 'EST002', 'Estoque Secundário', '2023-06-20', '23456789012345'),
    (3, 'EST003', 'Estoque de Promoção', '2023-08-05', '34567890123456'),
    (4, 'EST004', 'Estoque de Lançamentos', '2023-07-15', '45678901234567'),
    (5, 'EST005', 'Estoque de Reservas', '2023-05-30', '56789012345678');
-- =============================================================
INSERT INTO ESTANTE (serial_, descricao)
VALUES
    ('EST56789', 'Estante A - Ficção'),
    ('EST45678', 'Estante B - Não Ficção'),
    ('EST34567', 'Estante C - Infantojuvenil'),
    ('EST23456', 'Estante D - Mistério'),
    ('EST12345', 'Estante E - Romance');
-- ============================================================
INSERT INTO PRATELEIRA (serial_, num_nivel, serial_estante)
VALUES
    ('PRAT001', 3, 'EST001'),
    ('PRAT002', 2, 'EST001'),
    ('PRAT003', 4, 'EST002'),
    ('PRAT004', 1, 'EST002'),
    ('PRAT005', 2, 'EST003');
-- =============================================================
INSERT INTO FORNECEDOR (cnpj, nome_fantasia, dt_inicio, dt_fim)
VALUES
    ('12345678901234', 'Fornecedor A', '2023-01-01', NULL),
    ('23456789012345', 'Fornecedor B', '2023-01-01', NULL),
    ('34567890123456', 'Fornecedor C', '2023-01-01', NULL),
    ('45678901234567', 'Fornecedor D', '2023-01-01', NULL),
    ('56789012345678', 'Fornecedor E', '2023-01-01', NULL);
-- =============================================================
INSERT INTO CLIENTE (cpf, nome, idade, dt_nasc, flag_professor, status, dt_fim_adesao, dt_inic_adesao, cnpj_bookstore, cod_plano_fid, pontos_fidelidade)
VALUES
    ('12345678901', 'Cliente A', 30, '1993-05-15', false, 'Ativo', '2040-01-28', '2023-01-01', '12345678901234', 1, 150),
    ('23456789012', 'Cliente B', 25, '1998-08-20', true, 'Ativo', '2040-05-18', '2023-02-15', '23456789012345', 2, 200),
    ('34567890123', 'Cliente C', 40, '1982-03-10', false, 'Inativo', '2023-03-01', '2023-01-15', '34567890123456', 3, 100),
    ('45678901234', 'Cliente D', 28, '1995-11-07', false, 'Ativo', '2040-03-08', '2023-04-10', '45678901234567', 4, 50),
    ('56789012345', 'Cliente E', 22, '2000-06-25', true, 'Ativo', '2040-02-28', '2023-05-20', '56789012345678', 5, 75);
-- ==============================================================
INSERT INTO GERENTE (cpf, salario_base, ramal, nome, idade, dt_nasc, cnpj_bookstore, data_inicio, data_fim)
VALUES
    ('12345678901', 5000.00, 101, 'Gerente A', 35, '1988-02-10', '12345678901234', '2023-01-01', '2040-01-23'),
    ('23456789012', 4500.00, 102, 'Gerente B', 32, '1991-09-25', '23456789012345', '2023-01-01','2040-08-24'),
    ('34567890123', 5200.00, 103, 'Gerente C', 40, '1983-12-05', '34567890123456', '2023-01-01','2031-02-20'),
    ('45678901234', 4800.00, 104, 'Gerente D', 28, '1995-07-15', '45678901234567', '2023-01-01','2030-03-18'),
    ('56789012345', 5100.00, 105, 'Gerente E', 33, '1990-04-30', '56789012345678', '2023-01-01','2040-05-08');
-- ==============================================================
INSERT INTO PESSOA (cpf, sexo, dt_nascimento, nome, idade, endereco)
VALUES
    ('12345678901', 'M', '1988-02-10', 'Pessoa A', 35, 'Rua das Pessoas, 123'),
    ('23456789012', 'F', '1991-09-25', 'Pessoa B', 32, 'Avenida das Vidas, 456'),
    ('34567890123', 'M', '1983-12-05', 'Pessoa C', 40, 'Praça dos Sonhos, 789'),
    ('45678901234', 'F', '1995-07-15', 'Pessoa D', 28, 'Rua das Ideias, 101'),
    ('56789012345', 'M', '1990-04-30', 'Pessoa E', 33, 'Avenida da Imaginação, 202');
-- ===============================================================
INSERT INTO VENDEDOR (cpf, salario_base, ramal, nome, idade, dt_nasc, cnpj_bookstore, cpf_gerente)
VALUES
    ('12345678901', 3000.00, 201, 'Vendedor A', 28, '1995-03-12', '12345678901234', '12345678901'),
    ('23456789012', 2800.00, 202, 'Vendedor B', 24, '1998-08-05', '23456789012345', '23456789012'),
    ('34567890123', 3200.00, 203, 'Vendedor C', 35, '1986-11-20', '34567890123456', '34567890123'),
    ('45678901234', 2900.00, 204, 'Vendedor D', 29, '1994-07-03', '45678901234567', '45678901234'),
    ('56789012345', 3100.00, 205, 'Vendedor E', 31, '1992-04-18', '56789012345678', '56789012345');
-- ================================================================
INSERT INTO PDV (cod, dt_ult_manutencao, descricao)
VALUES
    (101, '2023-07-15', 'PDV Caixa 1'),
    (102, '2023-06-20', 'PDV Caixa 2'),
    (103, '2023-08-05', 'PDV Caixa 3'),
    (104, '2023-07-10', 'PDV Caixa 4'),
    (105, '2023-05-30', 'PDV Caixa 5');
-- ==============================================================
INSERT INTO CAIXA (cpf, salario_base, ramal, nome, idade, dt_nasc, cnpj_bookstore, cpf_gerente, dt_inicio, dt_fim, cod_pdv)
VALUES
    ('12345678901', 2500.00, 301, 'Caixa A', 27, '1996-02-20', '12345678901234', '12345678901', '2023-01-01', '2040-01-08', 101),
    ('23456789012', 2400.00, 302, 'Caixa B', 23, '1999-07-10', '23456789012345', '23456789012', '2023-02-15', '2040-03-18', 102),
    ('34567890123', 2700.00, 303, 'Caixa C', 32, '1990-11-05', '34567890123456', '34567890123', '2023-03-01', '2040-05-28', 103),
    ('45678901234', 2300.00, 304, 'Caixa D', 28, '1994-05-15', '45678901234567', '45678901234', '2023-04-10', '2040-07-24', 104),
    ('56789012345', 2600.00, 305, 'Caixa E', 29, '1993-08-30', '56789012345678', '56789012345', '2023-05-20', '2040-08-22', 105);
-- ==============================================================
INSERT INTO AUTOR (cpf, nome, idade, dt_nasc, flag_best_seller, cod_livro)
VALUES
    ('12345678901', 'Autor A', 40, '1983-03-12', true, 101),
    ('23456789012', 'Autor B', 32, '1991-09-25', false, 102),
    ('34567890123', 'Autor C', 55, '1968-12-05', true, 103),
    ('45678901234', 'Autor D', 28, '1995-07-15', false, 104),
    ('56789012345', 'Autor E', 47, '1976-04-30', true, 105);
-- ==============================================================
INSERT INTO LIVRO_REF (cod_barra, preco_fornec, preco, titulo, tipo_livro, ISBN, num_edicao, cnpj_fornecedor)
VALUES
    ('1234567890123', 20.00, 35.00, 'SENHOR DOS ANEIS', 'Ficção', '9781234567890', 1, '12345678901234'),
    ('2345678901234', 18.00, 30.00, 'HOMEM NA LUA', 'Não Ficção', '9782345678901', 2, '23456789012345'),
    ('3456789012345', 22.00, 40.00, 'AMOR SEM LIMITES', 'Infantojuvenil', '9783456789012', 1, '34567890123456'),
    ('4567890123456', 25.00, 45.00, 'A VIDA DE JULIA', 'Mistério', '9784567890123', 3, '45678901234567'),
    ('5678901234567', 15.00, 28.00, 'PRIMEIRO AMOR', 'Romance', '9785678901234', 1, '56789012345678');
-- ==============================================================
INSERT INTO GENERO_LIVRO (isbn_livro, cod_gen)
VALUES
    ('9781234567890', 1),
    ('9782345678901', 2),
    ('9783456789012', 3),
    ('9784567890123', 4),
    ('9785678901234', 5);
-- ==============================================================
INSERT INTO AUTOR_LIVRO (isbn_livro, cpf_autor)
VALUES
    ('9781234567890', '12345678901'),
    ('9782345678901', '23456789012'),
    ('9783456789012', '34567890123'),
    ('9784567890123', '45678901234'),
    ('9785678901234', '56789012345');
-- ==============================================================
INSERT INTO NOTA_FISCAL (codNF, dt_emissao, vl_total, cod_pag)
VALUES
    ('NF123456', '2023-07-15', 250.00, 1),
    ('NF234567', '2023-06-20', 180.50, 2),
    ('NF345678', '2023-08-05', 320.00, 3),
    ('NF456789', '2023-07-10', 150.00, 4),
    ('NF567890', '2023-05-30', 220.75, 5);
-- ==================================================================
INSERT INTO COMPRA (cod, vl_desconto, v_imposto, dt_compra, vl_total_bruto, vl_total_a_pagar, vl_comissao, cod_pdv, cpf_vend, cod_NF,cpf_cliente)
VALUES
    (1, 15.00, 30.00, '2023-07-15', 300.00, 255.00, 25.00, 101, '12345678901', 'NF123456','12345678901'),
    (2, 10.00, 18.50, '2023-06-20', 200.00, 172.50, 15.00, 102, '23456789012', 'NF234567','23456789012'),
    (3, 20.00, 32.00, '2023-08-05', 400.00, 348.00, 30.00, 103, '34567890123', 'NF345678','34567890123'),
    (4, 5.00, 15.00, '2023-07-10', 180.00, 160.00, 12.00, 104, '45678901234', 'NF456789','45678901234'),
    (5, 12.00, 22.75, '2023-05-30', 250.00, 215.25, 18.00, 105, '56789012345', 'NF567890','56789012345');
-- ==============================================================
INSERT INTO ENCOMENDA (id, data_pedido, dt_prevista, status_, cpf_cliente)
VALUES
    (1, '2023-07-15', '2023-07-25', 'Em Processamento', '12345678901'),
    (2, '2023-06-20', '2023-06-30', 'Em Trânsito', '23456789012'),
    (3, '2023-08-05', '2023-08-15', 'Entregue', '34567890123'),
    (4, '2023-07-10', '2023-07-20', 'Em Processamento', '45678901234'),
    (5, '2023-05-30', '2023-06-05', 'Entregue', '56789012345');
-- ==============================================================
INSERT INTO ITEM_COMPRA (cod_compra, isbn_livro, qtd, vl_unitario)
VALUES
    (1, '9781234567890', 2, 25.00),
    (2, '9782345678901', 3, 20.00),
    (3, '9783456789012', 1, 40.00),
    (4, '9784567890123', 4, 15.00),
    (5, '9785678901234', 2, 28.00);
-- ==============================================================
INSERT INTO ITEM_ENCOMENDA (id_encomenda, isbn_livro, qtd)
VALUES
    (1, '9781234567890', 3),
    (2, '9782345678901', 2),
    (3, '9783456789012', 1),
    (4, '9784567890123', 4),
    (5, '9785678901234', 2);
-- ===============================================================
INSERT INTO COMISSAO_VENDEDOR (id_com, cpf_vend)
VALUES
    (1, '12345678901'),
    (2, '23456789012'),
    (3, '34567890123'),
    (4, '45678901234'),
    (5, '56789012345');
-- ===============================================================
INSERT INTO ITEM_ESTOQUE (serial_estoque, isbn_livro, qtd, vl_unitario, qtd_atual, dt_entrada, qtd_minima, preco_venda, cod_serial_prateleira)
VALUES
    ('EST12345', '9781234567890', 10, 20.00, 10, '2023-07-15', 2, 35.00, 'PRAT123'),
    ('EST23456', '9782345678901', 8, 18.00, 8, '2023-06-20', 3, 30.00, 'PRAT234'),
    ('EST34567', '9783456789012', 15, 35.00, 15, '2023-08-05', 5, 50.00, 'PRAT345'),
    ('EST45678', '9784567890123', 12, 12.00, 12, '2023-07-10', 4, 25.00, 'PRAT456'),
    ('EST56789', '9785678901234', 6, 25.00, 6, '2023-05-30', 2, 40.00, 'PRAT567');
    
-- ===============================================================
INSERT INTO PRODUTO (cod, marca, descricao, cod_barra, preco, preco_fornecedor, cnpj_fornecedor)
VALUES
    (1, 'Marca A', 'Produto 1', '1234567890123', 29.99, 20.00, '12345678901234'),
    (2, 'Marca B', 'Produto 2', '2345678901234', 39.99, 30.00, '23456789012345'),
    (3, 'Marca C', 'Produto 3', '3456789012345', 19.99, 15.00, '34567890123456'),
    (4, 'Marca A', 'Produto 4', '4567890123456', 49.99, 35.00, '12345678901234'),
    (5, 'Marca B', 'Produto 5', '5678901234567', 59.99, 40.00, '23456789012345');

SET FOREIGN_KEY_CHECKS = 0;