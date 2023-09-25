#   para retornar se o CLIENTE esta em dias com seus pagamentos de FATURAS

DELIMITER //
CREATE FUNCTION LivroMaisCaroCliente(cpf_cliente VARCHAR(11))
RETURNS VARCHAR(50)
deterministic
BEGIN
    DECLARE livro_mais_caro VARCHAR(50);
    
    SELECT LR.titulo INTO livro_mais_caro
    FROM CLIENTE C
    JOIN COMPRA CO ON C.cpf = CO.cpf_vend
    JOIN ITEM_COMPRA IC ON CO.cod = IC.cod_compra
    JOIN LIVRO_REF LR ON IC.isbn_livro = LR.isbn
    WHERE C.cpf = cpf_cliente
    ORDER BY LR.preco DESC
    LIMIT 1;

    RETURN livro_mais_caro;
END;
//
DELIMITER ;

SELECT LivroMaisCaroCliente('23456789012');

-- Crie uma função que recebe o código de cliente como entrada


DELIMITER //

CREATE FUNCTION VerificarClienteOK(codigo_cliente VARCHAR(11)) RETURNS BOOLEAN
deterministic
BEGIN
    DECLARE cliente_ok BOOLEAN;
    
    -- Inicialize a variável cliente_ok como TRUE
    SET cliente_ok = TRUE;
    
    -- Verifique se existem compras associadas ao cliente
    IF EXISTS (SELECT 1 FROM COMPRA WHERE cpf_cliente = codigo_cliente) THEN
        -- Verifique se todas as compras têm uma nota fiscal correspondente
        IF NOT EXISTS (
            SELECT 1 FROM COMPRA C
            LEFT JOIN NOTA_FISCAL NF ON C.cod_NF = NF.codNF
            WHERE C.cpf_cliente = codigo_cliente AND NF.codNF IS NULL
        ) THEN
            -- Verifique se todas as notas fiscais têm um pagamento correspondente
            IF NOT EXISTS (
                SELECT 1 FROM NOTA_FISCAL NF
                LEFT JOIN PAGAMENTO P ON NF.cod_pag = P.cod_pag
                WHERE NF.cod_pag IS NOT NULL AND P.cod_pag IS NULL
            ) THEN
                -- Todos os registros estão ok
                SET cliente_ok = TRUE;
            ELSE
                -- Algumas notas fiscais não possuem pagamento correspondente
                SET cliente_ok = FALSE;
            END IF;
        ELSE
            -- Algumas compras não possuem nota fiscal correspondente
            SET cliente_ok = FALSE;
        END IF;
    ELSE
        -- Não há compras associadas ao cliente
        SET cliente_ok = FALSE;
    END IF;
    
    -- Retorne o valor booleano indicando se o cliente está ok
    RETURN cliente_ok;
END;
//

DELIMITER ;

SELECT VerificarClienteOK('1234567901') AS ClienteOK;



-- Crie a função que recebe o CPF como parâmetro e retorna o valor do desconto.
DELIMITER //
CREATE FUNCTION calcularDesconto(cpf_cliente VARCHAR(11),valor int)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE desconto DECIMAL(10, 2);

    -- Obtém o código do plano de fidelidade do cliente
    DECLARE cod_plano_fid_cliente INT;
    
    SELECT cod_plano_fid INTO cod_plano_fid_cliente FROM CLIENTE WHERE cpf = cpf_cliente;
    -- obter valor a pagar
   
 
    
    -- Calcula o desconto com base no código do plano de fidelidade
    SELECT CASE
        WHEN cod_plano_fid_cliente IS NULL THEN 0.00 -- Cliente não encontrado
        WHEN cod_plano_fid_cliente = 1 THEN 0.10   -- Exemplo de desconto para o Plano 1
        WHEN cod_plano_fid_cliente = 2 THEN 0.15   -- Exemplo de desconto para o Plano 2
		WHEN cod_plano_fid_cliente = 3 THEN 0.20   -- Exemplo de desconto para o Plano 2
		WHEN cod_plano_fid_cliente = 4 THEN 0.25   -- Exemplo de desconto para o Plano 2
		WHEN cod_plano_fid_cliente = 5 THEN 0.30   -- Exemplo de desconto para o Plano 2
        ELSE 0.00 -- Se o código do plano não corresponder a nenhum plano conhecido
    END INTO desconto;
    
    RETURN desconto*valor;
END;
//
DELIMITER ;

#DROP FUNCTION calcularDesconto;
SELECT * FROM livraria.compra;
SELECT * FROM livraria.cliente;

SELECT calcularDesconto('34567890123',100)



-- Função endereço cliente

DELIMITER //

CREATE FUNCTION obter_endereco_por_cpf(cpf_pessoa VARCHAR(11))
RETURNS VARCHAR(100) READS SQL DATA
BEGIN
    DECLARE endereco VARCHAR(100);
    
    -- Verifica se o CPF existe na tabela CLIENTE
    SELECT p.endereco INTO endereco
    FROM PESSOA p
    WHERE p.cpf = cpf_pessoa;

    -- Se o endereço não estiver na tabela CLIENTE, retorna NULL
    IF endereco IS NULL THEN
        RETURN NULL;
    END IF;
    
    RETURN endereco;
END;
//
DELIMITER ;

SELECT * FROM PESSOA;
SELECT obter_endereco_por_cpf('23456789012') AS Endereco;