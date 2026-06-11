#Objetivo: Este arquivo contém os CRUDs para os DAOs do projeto cafeteria
#Autor: Estephano Borovicz
#Data: 11/06/2026
#Versão:1.0

use db_frequency80cafe;
#----------------------------------------select---------------------------------------
#retorna todos os produtos
select * from tbl_produto;

#retorna um produto por id
select * from tbl_produto where tbl_produto.id = '${produto.id}';

#retorna todas as imagens
select * from tbl_imagem;

# retorna todas as imagens vinculadas a um produto
select tbl_imagem.* from tbl_imagem
inner join tbl_produto
on tbl_produto.id = tbl_imagem.id_produto where tbl_produto.id = '${produto.id}';

#retorna todas as categorias
select * from tbl_categoria;

#retorna todas as categorias vinculadas à um produto
select * from tbl_categoria
inner join tbl_produto_categoria
on tbl_categoria.id =  tbl_produto_categoria.id_categoria
inner join tbl_produto
on tbl_produto.id = tbl_produto_categoria.id_produto
where tbl_produto.id = '${produto.id}';

#retorna todos os produtos vinculados a uma categoria
select * from tbl_produto
inner join tbl_produto_categoria
on tbl_produto.id = tbl_produto_categoria.id_produto
inner join tbl_categoria
on tbl_categoria.id = tbl_produto_categoria.id_categoria
where tbl_categoria.id = '${categoria.id}';

# retorna todos os produtos, suas imagens vinculadas e suas categorias?
select tbl_produto.id as id_produto, tbl_produto.nome as nome_produto, 
tbl_produto.descricao as descricao_produto, tbl_produto.preco as preco_produto, 
tbl_imagem.url as url_imagem, tbl_categoria.categoria as categoria_categoria 
from tbl_produto

inner join tbl_imagem
on tbl_produto.id = tbl_imagem.id_produto

inner join tbl_produto_categoria
on tbl_produto.id = tbl_produto_categoria.id_produto

inner join tbl_categoria
on tbl_categoria.id = tbl_produto_categoria.id_categoria;

#------------------------------insert-----------------------------------

 #insert novo admin
 insert into tbl_admin(
 nome_usuario,
 email,
 senha,
 jwt
 )VALUES(
'${admin.nome_usuario}',
'${admin.email}',
'${admin.senha}',
'${admin.jwt}'
 );
 
#insert novo produto
insert into tbl_produto (nome, descricao, preco
)VALUES(
'${produto.nome}',
'${produto.descricao}',
'${produto.preco}'
 );
 
 #insert nova imagem vinculada a um produto
 insert into tbl_imagem (
 url,
 id_produto
 )VALUES(
 '${imagem.url}',
 '${produto.id}'
 );
 
 #insert nova categoria
 insert into tbl_categoria(
 categoria
 )VALUES(
 '${categoria.categoria}'
 );
 
 #---------------------------update---------------------------------
 
 #update produto por id
 update tbl_produto set
                        nome             = '${filme.nome}',
                        descricao        = '${filme.sinopse}',
                        preco            = '${filme.capa}'
                    where id = '${produto.id}';
                    
# update imagem por id
 update tbl_imagem set
                        url             = '${imagem.url}'
                    where id = '${imagem.id}';
                    
# update categoria por id
 update tbl_categoria set
                        categoria       = '${categoria.categoria}'
                    where id = '${categoria.id}';
                    
#------------------------------delete---------------------------------






 
 
 
 
















