-- triggers_Livraria.sql
-- Trigger para Calcular o Atributo "idade" na Tabela PESSOA:

DELIMITER //

CREATE TRIGGER calcular_idade BEFORE INSERT ON PESSOA
FOR EACH ROW
BEGIN
    DECLARE data_nascimento DATE;
    DECLARE hoje DATE;
    DECLARE idade INT;
    
    SELECT NEW.dt_nascimento INTO data_nascimento;
    SELECT CURDATE() INTO hoje;
    
    SET idade = YEAR(hoje) - YEAR(data_nascimento);
    
    IF MONTH(data_nascimento) > MONTH(hoje) OR (MONTH(data_nascimento) = MONTH(hoje) AND DAY(data_nascimento) > DAY(hoje)) THEN
        SET idade = idade - 1;
    END IF;

    -- Defina a idade calculada na linha recém-inserida
    SET NEW.idade = idade;
END;
//

DELIMITER ;

#drop trigger calcular_idade;
INSERT INTO PESSOA (cpf,sexo, nome, dt_nascimento) VALUES ('02649678951','M', 'samuel', '1999-11-18');

DELETE FROM `livraria`.`pessoa` WHERE (`cpf` = '02649678951');

UPDATE PESSOA
SET endereco = 'OLINDA'
WHERE cpf = '02649678951';

select * from pessoa;


-- Trigger para Gerar o Atributo "data_pedido" na Tabela ENCOMENDA:
DELIMITER //

CREATE TRIGGER gerar_data_pedido
BEFORE INSERT ON ENCOMENDA
FOR EACH ROW
BEGIN
    SET NEW.data_pedido = CURDATE();
END;
//

DELIMITER ;

INSERT INTO ENCOMENDA (id, dt_prevista, status_, cpf_cliente)
VALUES (17, '2023-09-15', 'Pendente', '23456789012');
SELECT * FROM livraria.encomenda;

DELETE FROM ENCOMENDA
WHERE id = 17;
SELECT * FROM livraria.encomenda;


UPDATE ENCOMENDA
SET status_ = 'Entregue'
WHERE id = '17';
SELECT * FROM livraria.encomenda;
-- ------------------------------------------------------------------------------------------------------------------
-- atualizar a qtd_atual quando uma compra for registrada 
DELIMITER //

CREATE TRIGGER item_compra_after_insert
AFTER INSERT ON ITEM_COMPRA FOR EACH ROW
BEGIN
    -- Atualiza a quantidade atual na tabela ITEM_ESTOQUE
    UPDATE ITEM_ESTOQUE
    SET qtd_atual = qtd_atual - NEW.qtd
    WHERE isbn_livro = NEW.isbn_livro;
END;
//
DELIMITER ;


-- Inserir um registro na tabela ITEM_COMPRA
SELECT * FROM livraria.item_estoque;
INSERT INTO ITEM_COMPRA (cod_compra, isbn_livro, qtd, vl_unitario)
VALUES (6, '9784567890123', 2, 12.00);
SELECT * FROM livraria.item_estoque;
-- ----------------------------------------------------------------------------------------------
DELIMITER //

CREATE TRIGGER item_compra_after_update
AFTER UPDATE ON ITEM_COMPRA FOR EACH ROW
BEGIN
    DECLARE change_qtd INT;
    
    -- Calcula a mudança na quantidade com base na atualização
    SET change_qtd = NEW.qtd - OLD.qtd;
    
    -- Atualiza a quantidade atual na tabela ITEM_ESTOQUE para atualizações
    UPDATE ITEM_ESTOQUE
    SET qtd_atual = qtd_atual - change_qtd
    WHERE isbn_livro = NEW.isbn_livro;
END;
//
DELIMITER ;
SELECT * FROM livraria.item_estoque;
SELECT * FROM livraria.item_compra;

-- Atualizar a quantidade do livro com ISBN 
UPDATE ITEM_COMPRA
SET qtd = 6
WHERE isbn_livro = '9783456789012';



 
 -- -----------------------------------------------------------------------------------------------------
 DELIMITER //

CREATE TRIGGER item_compra_after_delete
AFTER DELETE ON ITEM_COMPRA FOR EACH ROW
BEGIN
    -- Atualiza a quantidade atual na tabela ITEM_ESTOQUE para exclusões
    UPDATE ITEM_ESTOQUE
    SET qtd_atual = qtd_atual + OLD.qtd
    WHERE isbn_livro = OLD.isbn_livro;
END;
//
DELIMITER ;

-- Excluir o registro de compra do livro com ISBN '1234567890123' da tabela ITEM_COMPRA.
SELECT * FROM livraria.item_compra;
SELECT * FROM livraria.item_estoque;

DELETE FROM ITEM_COMPRA
WHERE isbn_livro = '9781234567890';

