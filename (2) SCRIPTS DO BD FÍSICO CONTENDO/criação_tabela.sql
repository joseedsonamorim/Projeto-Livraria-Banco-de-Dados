-- Criação_Table - Livraria.sql
-- Alunos: Juliana Lima, José Edson, Mateus Rodrigo e Samuel Bezerra
-- Licenciatura em Computação 

-- DEFINIR O BANCO DE DADOS "LIVRARIA"
CREATE SCHEMA LIVRARIA;
USE LIVRARIA;

-- Tabela GENERO
CREATE TABLE GENERO (
    cod INT PRIMARY KEY,
    descricao VARCHAR(250)
);

-- Tabela PLANO_FIDELIDADE
CREATE TABLE PLANO_FIDELIDADE (
    cod INT PRIMARY KEY,
    tipo VARCHAR(30),
    dt_inicio DATE,
    dt_fim DATE,
    descricao VARCHAR(250)
);

-- Tabela COMISSAO
CREATE TABLE COMISSAO (
    id INT PRIMARY KEY,
    tipo VARCHAR(30),
    dt_inicio DATE,
    dt_fim DATE,
    percentual DECIMAL(5, 2)
);

-- Tabela PAGAMENTO
CREATE TABLE PAGAMENTO (
    cod_pag INT PRIMARY KEY,
    vl_pago DECIMAL(10, 2),
    tipo_pagamento VARCHAR(30),
    bandeira VARCHAR(30)
);

-- Tabela BOOKSTORE
CREATE TABLE BOOKSTORE (
    cnpj VARCHAR(14) PRIMARY KEY,
    razao_social VARCHAR(50),
    nome_fantasia VARCHAR(50),
    qtd_funcionarios INT,
    endereco VARCHAR(100)
);

-- Tabela ESTOQUE
CREATE TABLE ESTOQUE (
    id INT PRIMARY KEY,
    serial_ VARCHAR(50),
    descricao VARCHAR(250),
    data_ult_compra DATE,
    cnpj_bookstore VARCHAR(14),
    FOREIGN KEY (cnpj_bookstore) REFERENCES LIVRARIA.BOOKSTORE(cnpj)
);

-- Tabela ESTANTE
CREATE TABLE ESTANTE (
    serial_ VARCHAR(50) PRIMARY KEY,
    descricao VARCHAR(250)
);

-- Tabela PRATELEIRA
CREATE TABLE PRATELEIRA (
    serial_ VARCHAR(50) PRIMARY KEY,
    num_nivel INT,
    serial_estante VARCHAR(50),
    FOREIGN KEY (serial_estante) REFERENCES LIVRARIA.ESTANTE(serial_)
);

-- Tabela FORNECEDOR
CREATE TABLE FORNECEDOR (
    cnpj VARCHAR(14) PRIMARY KEY,
    nome_fantasia VARCHAR(50),
    dt_inicio DATE,
    dt_fim DATE
);

-- Tabela CLIENTE
CREATE TABLE CLIENTE (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(50),
    idade INT,
    dt_nasc DATE,
    flag_professor BOOLEAN,
    status VARCHAR(30),
    dt_fim_adesao DATE,
    dt_inic_adesao DATE,
    cnpj_bookstore VARCHAR(14),
    cod_plano_fid INT,
    pontos_fidelidade INT,
    FOREIGN KEY (cnpj_bookstore) REFERENCES LIVRARIA.BOOKSTORE(cnpj),
    FOREIGN KEY (cod_plano_fid) REFERENCES LIVRARIA.PLANO_FIDELIDADE(cod)
);

-- Tabela GERENTE
CREATE TABLE GERENTE (
    cpf VARCHAR(11) PRIMARY KEY,
    salario_base DECIMAL(10, 2),
    ramal INT,
    nome VARCHAR(50),
    idade INT,
    dt_nasc DATE,
    cnpj_bookstore VARCHAR(14),
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (cnpj_bookstore) REFERENCES LIVRARIA.BOOKSTORE(cnpj)
);

-- Tabela PESSOA
CREATE TABLE PESSOA (
    cpf VARCHAR(11) PRIMARY KEY,
    sexo VARCHAR(1),
    dt_nascimento DATE,
    nome VARCHAR(50),
    idade INT,
    endereco VARCHAR(100)
);

-- Tabela VENDEDOR
CREATE TABLE VENDEDOR (
    cpf VARCHAR(11) PRIMARY KEY,
    salario_base DECIMAL(10, 2),
    ramal INT,
    nome VARCHAR(50),
    idade INT,
    dt_nasc DATE,
    cnpj_bookstore VARCHAR(14),
    cpf_gerente VARCHAR(11),
    FOREIGN KEY (cnpj_bookstore) REFERENCES LIVRARIA.BOOKSTORE(cnpj),
    FOREIGN KEY (cpf_gerente) REFERENCES LIVRARIA.PESSOA(cpf)
);

-- Tabela PDV
CREATE TABLE PDV (
    cod INT PRIMARY KEY,
    dt_ult_manutencao DATE,
    descricao VARCHAR(250)
);


-- Tabela CAIXA
CREATE TABLE CAIXA (
    cpf VARCHAR(11) PRIMARY KEY,
    salario_base DECIMAL(10, 2),
    ramal INT,
    nome VARCHAR(50),
    idade INT,
    dt_nasc DATE,
    cnpj_bookstore VARCHAR(14),
    cpf_gerente VARCHAR(11),
    dt_inicio DATE,
    dt_fim DATE,
    cod_pdv INT,
    FOREIGN KEY (cnpj_bookstore) REFERENCES LIVRARIA.BOOKSTORE(cnpj),
    FOREIGN KEY (cpf_gerente) REFERENCES LIVRARIA.PESSOA(cpf),
    FOREIGN KEY (cod_pdv) REFERENCES LIVRARIA.PDV(cod)
);

-- Tabela AUTOR
CREATE TABLE AUTOR (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(50),
    idade INT,
    dt_nasc DATE,
    flag_best_seller BOOLEAN,
    cod_livro INT
);

-- Tabela LIVRO_REF
CREATE TABLE LIVRO_REF (
    cod_barra VARCHAR(13) PRIMARY KEY,
    preco_fornec DECIMAL(10, 2),
    preco DECIMAL(10, 2),
    titulo VARCHAR(50),
    tipo_livro VARCHAR(50),
    ISBN VARCHAR(13),
    num_edicao INT,
    cnpj_fornecedor VARCHAR(14),
    FOREIGN KEY (cnpj_fornecedor) REFERENCES LIVRARIA.FORNECEDOR(cnpj)
);

CREATE INDEX idx_isbn ON LIVRO_REF (ISBN);
CREATE INDEX idx_estoque_serial ON ESTOQUE(serial_);

-- Tabela GENERO_LIVRO
CREATE TABLE GENERO_LIVRO (
    isbn_livro VARCHAR(13),
    cod_gen INT,
    FOREIGN KEY (isbn_livro) REFERENCES LIVRARIA.LIVRO_REF(isbn),
    FOREIGN KEY (cod_gen) REFERENCES LIVRARIA.GENERO(cod)
);

-- Tabela AUTOR_LIVRO
CREATE TABLE AUTOR_LIVRO (
    isbn_livro VARCHAR(13),
    cpf_autor VARCHAR(11),
    FOREIGN KEY (isbn_livro) REFERENCES LIVRARIA.LIVRO_REF(isbn),
    FOREIGN KEY (cpf_autor) REFERENCES LIVRARIA.AUTOR(cpf)
);

-- Tabela NOTA_FISCAL
CREATE TABLE NOTA_FISCAL (
    codNF VARCHAR(50) PRIMARY KEY,
    dt_emissao DATE,
    vl_total DECIMAL(10, 2),
    cod_pag INT,
    FOREIGN KEY (cod_pag) REFERENCES LIVRARIA.PAGAMENTO(cod_pag)
);

-- Tabela COMPRA
CREATE TABLE COMPRA (
    cod INT PRIMARY KEY,
    vl_desconto DECIMAL(10, 2),
    v_imposto DECIMAL(10, 2),
    dt_compra DATE,
    vl_total_bruto DECIMAL(10, 2),
    vl_total_a_pagar DECIMAL(10, 2),
    vl_comissao DECIMAL(10, 2),
    cod_pdv INT,
    cpf_vend VARCHAR(11),
    cod_NF VARCHAR(50),
    cpf_cliente VARCHAR(11),
    FOREIGN KEY (cod_pdv) REFERENCES LIVRARIA.PDV(cod),
    FOREIGN KEY (cpf_vend) REFERENCES LIVRARIA.VENDEDOR(cpf),
    FOREIGN KEY (cod_NF) REFERENCES LIVRARIA.NOTA_FISCAL(codNF),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);



-- Tabela ENCOMENDA
CREATE TABLE ENCOMENDA (
    id INT PRIMARY KEY,
    data_pedido DATE,
    dt_prevista DATE,
    status_ VARCHAR(50),
    cpf_cliente VARCHAR(11),
    FOREIGN KEY (cpf_cliente) REFERENCES LIVRARIA.CLIENTE(cpf)
);

-- Tabela ITEM_COMPRA
CREATE TABLE ITEM_COMPRA (
    cod_compra INT,
    isbn_livro VARCHAR(13),
    qtd INT,
    vl_unitario DECIMAL(10, 2),
    FOREIGN KEY (cod_compra) REFERENCES LIVRARIA.COMPRA(cod),
    FOREIGN KEY (isbn_livro) REFERENCES LIVRARIA.LIVRO_REF(isbn)
);

-- Tabela ITEM_ENCOMENDA
CREATE TABLE ITEM_ENCOMENDA (
    id_encomenda INT,
    isbn_livro VARCHAR(13),
    qtd INT,
    FOREIGN KEY (id_encomenda) REFERENCES LIVRARIA.ENCOMENDA(id),
    FOREIGN KEY (isbn_livro) REFERENCES LIVRARIA.LIVRO_REF(isbn)
);

-- Tabela COMISSAO_VENDEDOR
CREATE TABLE COMISSAO_VENDEDOR (
    id_com INT,
    cpf_vend VARCHAR(11),
    FOREIGN KEY (id_com) REFERENCES LIVRARIA.COMISSAO(id),
    FOREIGN KEY (cpf_vend) REFERENCES LIVRARIA.VENDEDOR(cpf)
);


-- Tabela ITEM_ESTOQUE
CREATE TABLE ITEM_ESTOQUE (
    serial_estoque VARCHAR(50),
    isbn_livro VARCHAR(13),
    qtd INT,
    vl_unitario DECIMAL(10, 2),
    qtd_atual INT,
    dt_entrada DATE,
    qtd_minima INT,
    preco_venda DECIMAL(10, 2),
    cod_serial_prateleira VARCHAR(50),
    FOREIGN KEY (serial_estoque) REFERENCES LIVRARIA.ESTOQUE(serial_),
    FOREIGN KEY (isbn_livro) REFERENCES LIVRARIA.LIVRO_REF(isbn),
    FOREIGN KEY (cod_serial_prateleira) REFERENCES LIVRARIA.PRATELEIRA(serial_)
);

CREATE TABLE PRODUTO (
    cod INT PRIMARY KEY,
    marca VARCHAR(255),
    descricao VARCHAR(255),
    cod_barra VARCHAR(50),
    preco DECIMAL(10, 2),
    preco_fornecedor DECIMAL(10, 2),
    cnpj_fornecedor VARCHAR(14),
    FOREIGN KEY (cnpj_fornecedor) REFERENCES FORNECEDOR (cnpj)
);