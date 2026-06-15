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





#-------------------------------------------------------admin----------------------------------------------------------------
 
  #inserir novo admin
        #model -> sql = `call procInsertAdmin(${admin.nome_usuario}, '${emai}', '${senha}', '${jwt}')`
        delimiter $$
          create procedure procInsertAdmin(IN nome_usuario varchar(255), email varchar(255), senha varchar(512), jwt varchar (255))
            BEGIN
              insert into tbl_admin(
                  nome_usuario,
                  email,
                  senha,
                  jwt
              )VALUES(
                  nome_usuario,
                  email,
                  senha,
                  jwt
                  );
        END $$
 
 #listar todos os admins cadastrados
      #model -> sql = `select * from vwAdmin`
        create view vwAdmin  as
          select id, nome_usuario, email, jwt
                    from tbl_admin order by id desc;

      #buscar admin por id
      #model -> sql = `call procSelectAdminById('${admin.id}')`
      delimiter $$
        create procedure procSelectAdmById (in id int)
          begin
            select nome, email, jwt from tbl_admin where tbl_admin.id = id;
        end $$

#atualizar admin por id
      #model -> sql = `call procUpdateAdminById('${admin.id}','${admin.nome_usuario}','${admin.email}','${admin.senha}','${admin.jwt}')`
      delimiter $$
        create procedure procUpdateAdminById(in id int, nome_usuario varchar(255), 
                                email varchar(255), senha varchar(512), jwt varchar (255))
          begin
                update tbl_produto set
                                        nome_usuario = new.nome_usuario,
                                        email        = new.email,
                                        senha        = new.senha,
                                        jwt          = new.jwt
                          where id = tbl_produto.id;
        end $$

#deletar admin por id
 #model -> sql = `call procDeleteAdminById('${admin.id}')`

      delimiter $$
      create procedure procDeleteAdminById(in id int)
        begin
          delete from tbl_admin where tbl_admin.id = id;
        end$$
    
##POST login admin!!!!!

#------------------------------------------------------categoria-------------------------------------------------------------

#inserir nova categoria
      #model -> sql = `call procInsertCategoria(${categoria})`
      delimiter $$
        create procedure procInsertCategoria(IN categoria varchar(45))
          BEGIN
            insert into tbl_categoria(
                categoria
            )VALUES(
                categoria
        );
      END $$
	#inserir nova categoria na tabela intermediária
    delimiter $$
      create trigger tgrInsertCategoria
		before insert on tbl_categoria
			for each row
				begin
					insert into tbl_produto_categoria (
                    id_categoria
                    )values(
                    tbl_categoria.id
                    );
	end $$
                
#listar todos as categorias cadastradas
      #model -> sql = `select * from vwCategoria`
        create view vwCategoria  as
          select * from tbl_categoria order by id desc;
    
#buscar categoria por id
#model -> sql = `call procSelectCategoriaById('${categoria.id}')`
delimiter $$
  create procedure procSelectCategoriaById (in id int)
    begin
      select * from tbl_categoria where tbl_categoria.id = id;
	end $$

#atualizar categoria por id
      #model -> sql = `call procUpdateCategoriaById('${categoria.id}','$categoria.categoria}')`
      delimiter $$
        create procedure procUpdateCategoriaById(in id int, categoria varchar(45))
          begin
                update tbl_categoria set
                                        tbl_categoria.categoria = new.categoria
                          where id = tbl_categoria.id;
          end $$
          
		create trigger tgrUpdateCategoriaById
			before update on tbl_categoria
				for each row
					begin
						update tbl_produto_categoria set 
							id_categoria = tbl_categoria.id;
					end $$

#deletar categoria por id
#model -> sql = `call procDeleteCategoriaById('${categoria.id}')`
      delimiter $$
      create procedure procDeleteCategoriaById(in id int)
        begin
          delete from tbl_categoria where tbl_categoria.id = id;
        end$$
        
	  delimiter $$
      create trigger tgrDeleteCategoriaById
      before delete on tbl_categoria
        for each row
          begin 
            delete from tbl_produto_categoria where id_categoria = old.id_categoria;
          end $$
          
          #------------------------------------------------------produto-------------------------------------------------------------

#inserir novo produto
      #model -> sql = `call procInsertProduto('${produto.nome}','${produto.descricao}', '${produto.preco}')`
      delimiter $$
        create procedure procInsertProduto(IN nome varchar(100), descricao text, preco decimal(5,2))
          BEGIN
            insert into tbl_produto(
                tbl_produto.nome,
                tbl_produto.descricao,
                tbl_produto.preco
            )VALUES(
                nome,
                descricao,
                preco
        );
      END $$
    
#listar todos os produtos cadastrados
      #model -> sql = `select * from vwCategoria`
        create view vwProduto  as
          select * from tbl_produto order by id desc;
    
#buscar produto por id
#model -> sql = `call procSelectProdutoById('${produto.id}')`
delimiter $$
  create procedure procSelectProdutoById (in id int)
    begin
      select * from tbl_produto where tbl_produto.id = id;
end $$

#atualizar produto por id
      #model -> sql = `call procUpdateProdutoById('${produto.nome}','${produto.descricao}', '${produto.preco}')`
      delimiter $$
        create procedure procUpdateProdutoById(IN nome varchar(100), descricao text, preco decimal(5,2))
          begin
                update tbl_produto set
                                        tbl_produto.nome = nome,
                                        tbl_produto.descricao = descricao,
                                        tbl_produto.preco = preco
                                        
                          where id = tbl_produto.id;
          end $$
          
		create trigger tgrUpdateProdutoById
			before update on tbl_produto
				for each row
					begin
						update tbl_produto_categoria set 
							id_produto = tbl_produto.id;
					end $$

#deletar produto por id
#model -> sql = `call procDeleteProdutoById('${produto.id}')`
      delimiter $$
      create procedure procDeleteProdutoById(in id int)
        begin
          delete from tbl_produto where tbl_produto.id = id;
        end$$
        
	  delimiter $$
      create trigger tgrDeleteProdutoById
      before delete on tbl_produto
        for each row
          begin 
            delete from tbl_produto_categoria where id_produto = old.id_produto;
          end $$
          
      
