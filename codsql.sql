CREATE DATABASE myDB;
USE myDB;

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10, 2)
);

CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    data_pedido DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE ItensPedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- Inserir dados
INSERT INTO Clientes (nome, email) VALUES
('João Silva', 'joao@email.com'),
('Maria Oliveira', 'maria@email.com');

INSERT INTO Produtos (nome, preco) VALUES
('Notebook', 3500.00),
('Mouse', 50.00),
('Teclado', 120.00);

INSERT INTO Pedidos (id_cliente, data_pedido) VALUES
(1, '2025-04-15'),
(2, '2025-04-16');

INSERT INTO ItensPedido (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 2, 1),
(2, 3, 1);

SELECT p.id_pedido, c.nome AS cliente, p.data_pedido
FROM Pedidos p
JOIN Clientes c ON p.id_cliente = c.id_cliente;

SELECT i.id_pedido, pr.nome AS produto, i.quantidade
FROM ItensPedido i
JOIN Produtos pr ON i.id_produto = pr.id_produto;

SELECT c.nome AS cliente, p.id_pedido, pr.nome AS produto, i.quantidade, pr.preco,
       (i.quantidade * pr.preco) AS total_item
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
JOIN ItensPedido i ON p.id_pedido = i.id_pedido
JOIN Produtos pr ON i.id_produto = pr.id_produto;
