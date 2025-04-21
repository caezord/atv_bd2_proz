CREATE DATABASE IF NOT EXISTS vendas;
USE vendas;

CREATE TABLE IF NOT EXISTS produto (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(100)    NOT NULL,
  preco        DECIMAL(10,2)   NOT NULL
);

CREATE TABLE IF NOT EXISTS pedido (
  id_pedido    INT AUTO_INCREMENT PRIMARY KEY,
  data_pedido  DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS item_pedido (
  id_item      INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido    INT               NOT NULL,
  id_produto   INT               NOT NULL,
  quantidade   INT               NOT NULL,
  FOREIGN KEY (id_pedido)  REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

DELIMITER $$
CREATE PROCEDURE relatorio_diario_produtos(
  IN p_data_inicio DATE,
  IN p_data_fim    DATE
)
BEGIN
  SELECT 
    DATE(p.data_pedido)     AS dia,
    SUM(ip.quantidade)      AS total_produtos
  FROM pedido p
  JOIN item_pedido ip
    ON p.id_pedido = ip.id_pedido
  WHERE DATE(p.data_pedido) BETWEEN p_data_inicio AND p_data_fim
  GROUP BY DATE(p.data_pedido)
  ORDER BY DATE(p.data_pedido);
END $$
DELIMITER ;
