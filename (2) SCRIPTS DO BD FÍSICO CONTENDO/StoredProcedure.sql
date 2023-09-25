-- Stored_Procedures - Livraria.sql
-- Procedure para Gerar "pontos_Fidelidade" baseado no Total de Compras do Cliente
DELIMITER //
CREATE PROCEDURE calcular_pontos_fidelidade(IN cpf_cliente VARCHAR(11))
BEGIN
    DECLARE total_compras DECIMAL(10, 2);
    DECLARE pontos_ganhos INT;
    DECLARE total_compras_para_pontos DECIMAL(10, 2);
    
    SELECT SUM(vl_total_a_pagar) INTO total_compras 
    FROM COMPRA 
    WHERE cpf_cliente = cpf_cliente;
    
    SET total_compras_para_pontos = 2; -- Total de compras necessário para ganhar pontos
    SET pontos_ganhos = FLOOR(total_compras / total_compras_para_pontos);
    
    UPDATE CLIENTE SET pontos_fidelidade = pontos_ganhos WHERE cpf = cpf_cliente;
END;
//
DELIMITER ;

-- Procedure para Retornar "vl_desconto" da Compra com Base nos Pontos de Fidelidade do Cliente
DELIMITER //
CREATE PROCEDURE calcular_desconto_compra(IN cod_compra INT)
BEGIN
    DECLARE pontos_fidelidade_cliente INT;
    DECLARE desconto DECIMAL(5, 2);
    
    SELECT pontos_fidelidade INTO pontos_fidelidade_cliente 
    
    FROM CLIENTE 
    
    WHERE cpf = (SELECT cpf_vend FROM COMPRA WHERE cod = cod_compra);
    
    IF pontos_fidelidade_cliente >= 10 THEN
        SET desconto = 0.05; -- 5% de desconto para clientes com 10 ou mais pontos de fidelidade
    ELSEIF pontos_fidelidade_cliente >= 5 THEN
        SET desconto = 0.03; -- 3% de desconto para clientes com 5 ou mais pontos de fidelidade
    ELSE
        SET desconto = 0.02; -- 2% de desconto para clientes com menos de 5 pontos de fidelidade
    END IF;
    
    UPDATE COMPRA SET vl_desconto = vl_total_a_pagar * desconto WHERE cod = cod_compra;
END;
//
DELIMITER ;

-- Procedure para Retornar Todas as Estantes com Última Reposição Anterior a uma Data
-- Crie a Stored Procedure
DELIMITER //

CREATE PROCEDURE ConsultarItensEmEstoqueAntesDaData(data_referencia DATE)
BEGIN
    SELECT  
		E.descricao,
        IE.serial_estoque,
        IE.isbn_livro,
        IE.preco_venda,
        IE.qtd_atual,
		IE.dt_entrada
        
    FROM ITEM_ESTOQUE IE, estante E
    WHERE E.serial_= IE.serial_estoque AND
    IE.dt_entrada < data_referencia;
END;
//
DELIMITER ;


-- Procedure para Retornar os "ITEM_ESTOQUES" com "qtd_atual" Abaixo da "qtd_minima" por Tipo
DELIMITER //
CREATE PROCEDURE buscar_item_estoque_qtd_baixa()
BEGIN
    SELECT IE.serial_estoque, IE.isbn_livro, IE.qtd_atual, IE.qtd_minima, LR.tipo_livro
    FROM ITEM_ESTOQUE IE
    JOIN LIVRO_REF LR ON IE.isbn_livro = LR.isbn
    WHERE IE.qtd_atual < IE.qtd_minima;
END;
//
DELIMITER ;
-- =================================================================
CALL calcular_pontos_fidelidade('12345678901');
SELECT * FROM cliente;

CALL calcular_desconto_compra(2);
SELECT * FROM compra;

CALL ConsultarItensEmEstoqueAntesDaData('2028-06-01');

CALL buscar_item_estoque_qtd_baixa()