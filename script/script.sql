DROP DATABASE IF EXISTS pi_cafeteria_ds2t_db;
CREATE DATABASE IF NOT EXISTS pi_cafeteria_ds2t_db;

use pi_cafeteria_ds2t_db;

create table tbl_admin (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL)
    ;

create table tbl_produto (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(5,2) NOT NULL,
    status TINYINT NOT NULL)
    ;

create table tbl_categoria (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(45) NOT NULL)
    ;

    CREATE TABLE tbl_produto_categoria (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        id_categoria INT NOT NULL,
        id_produto INT NOT NULL),

        CONSTRAINT FK_CATEGORIA_PRODUTO_CATEGORIA
        FOREIGN KEY (id_categoria)
        REFERENCES tbl_categoria (id)

        CONSTRAINT FK_PRODUTO_PRODUTO_CATEGORIA
        FOREIGN KEY (id_produto)
        REFERENCES tbl_produto (id)
        
        ;