CREATE DATABASE estoque_db;
USE estoque_db;

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    quantidade INT,
    preco_unitario DECIMAL(10,2)
);

CREATE TABLE log_alteracoes (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    tipo_acao VARCHAR(10),
    data_acao DATETIME
);

DELIMITER $$

CREATE TRIGGER log_insercao_produto
AFTER INSERT ON produtos
FOR EACH ROW
BEGIN
    INSERT INTO log_alteracoes (id_produto, tipo_acao, data_acao)
    VALUES (NEW.id_produto, 'INSERT', NOW());
END$$

DELIMITER ;

INSERT INTO produtos (nome, quantidade, preco_unitario)
VALUES ('Caderno', 50, 9.90);
