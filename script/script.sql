#drop database if exists db_frequency80cafe;
create database if not exists db_frequency80cafe;
use db_frequency80cafe;

create table tbl_admin (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL
);

create table tbl_produto (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(5, 2) NOT NULL
);

create table tbl_categoria (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(45) NOT NULL
);

create table tbl_produto_categoria (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_produto INT NOT NULL,

    CONSTRAINT FK_CATEGORIA_PRODUTO_CATEGORIA
    FOREIGN KEY (id_categoria)
    REFERENCES tbl_categoria (id),
    
    CONSTRAINT FK_PRODUTO_PRODUTO_CATEGORIA
    FOREIGN KEY (id_produto) 
    REFERENCES tbl_produto (id)
);

create table tbl_imagem (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(255) NOT NULL,
    id_produto INT NOT NULL,

    CONSTRAINT FK_IMAGEM_PRODUTO
    FOREIGN KEY (id_produto)
    REFERENCES tbl_produto (id)
);

select * from tbl_produto;

