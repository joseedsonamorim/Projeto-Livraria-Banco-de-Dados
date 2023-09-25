-- views livraria - orig.sql
-- Visão 1
CREATE VIEW RelatorioCompras AS
SELECT
    C.cpf AS cpf_cliente,
    C.nome AS nome_cliente,
    PD.cod AS cod_pdv,
    PD.descricao AS descricao_pdv,
    V.cpf AS cpf_vendedor,
    V.nome AS nome_vendedor,
    COUNT(CMP.cod) AS total_compras
FROM
    COMPRA CMP
JOIN
    CLIENTE C ON CMP.cpf_vend = C.cpf
JOIN
    PDV PD ON CMP.cod_pdv = PD.cod
JOIN
    VENDEDOR V ON C.cpf = V.cpf
WHERE
    CMP.dt_compra BETWEEN '2023-01-01' AND '2023-12-31' 
GROUP BY
    C.cpf, PD.cod, V.cpf;    

-- Visão 2
CREATE VIEW RelatorioProdutos AS
SELECT
    lr.tipo_livro AS livro_tipo_livro,
    p.cod AS produto_cod,
    p.marca AS produto_marca,
    p.descricao AS produto_descricao,
    p.preco AS produto_preco,
    p.cnpj_fornecedor AS produto_cnpj_fornecedor,
    est.serial_ AS estoque_serial,
    est.data_ult_compra AS estoque_data_ult_compra,
    lr.preco_fornec AS livro_preco_fornec,
    lr.preco AS livro_preco,
    lr.titulo AS livro_titulo,
    lr.cnpj_fornecedor AS livro_cnpj_fornecedor,
    ie.qtd_atual AS item_estoque_qtd_atual,
    ie.qtd_minima AS item_estoque_qtd_minima,
    f.nome_fantasia AS fornecedor_nome_fantasia
 
FROM
    produto p
JOIN
    estoque est ON p.cnpj_fornecedor = est.cnpj_bookstore
JOIN
    livro_ref lr ON p.cnpj_fornecedor = lr.cnpj_fornecedor
JOIN
    item_estoque ie ON ie.isbn_livro = lr.ISBN
JOIN
    fornecedor f ON p.cnpj_fornecedor = f.cnpj;
#drop view RelatorioProdutos;
-- Visão 3
CREATE VIEW RelatorioVendedor AS
SELECT
    V.nome AS VENDEDOR,
    B.nome_fantasia AS BOOKSTORE,
    C.status AS STATUS_CLIENTE,
    PF.tipo AS PLANO_FIDELIDADE
FROM
    VENDEDOR V
JOIN
    BOOKSTORE B ON V.cnpj_bookstore = B.cnpj
JOIN
    CLIENTE C ON V.cpf = C.cpf
JOIN
    PLANO_FIDELIDADE PF ON C.cod_plano_fid = PF.cod
WHERE
    C.dt_inic_adesao BETWEEN PF.dt_inicio AND PF.dt_fim;
    
-- Visão 4
CREATE VIEW RelatorioCompraNotaFiscal AS
SELECT
    C.cod AS CODIGO_COMPRA,
    NF.codNF AS CODIGO_NOTA_FISCAL,
    P.cod_pag AS CODIGO_PAGAMENTO,
    V.nome AS NOME_VENDEDOR,
    PDV.descricao AS PDV_DESCRICAO,
    C.dt_compra AS DATA_COMPRA,
    NF.dt_emissao AS DATA_EMISSAO_NF,
    PDV.dt_ult_manutencao AS DATA_MANUTENCAO_PDV
FROM
    COMPRA C
JOIN
    NOTA_FISCAL NF ON C.cod_NF = NF.codNF
JOIN
    PAGAMENTO P ON NF.cod_pag = P.cod_pag
JOIN
    VENDEDOR V ON C.cpf_vend = V.cpf
JOIN
    PDV PDV ON C.cod_pdv = PDV.cod
WHERE
    C.dt_compra BETWEEN '2023-01-01' AND '2023-12-31'
    AND NF.dt_emissao BETWEEN '2023-01-01' AND '2023-12-31'
    AND PDV.dt_ult_manutencao BETWEEN '2023-01-01' AND '2023-12-31';

-- Consulta na visão 1
SELECT * FROM RelatorioCompras;

-- Consulta na visão 2
SELECT * FROM RelatorioProdutos;

-- Consulta na visão 3 para Funcionario
SELECT * FROM RelatorioVendedor;

-- Consulta na visão 4
SELECT * FROM RelatorioCompraNotaFiscal;

