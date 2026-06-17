#Objetivo: Este arquivo contém os CRUDs para os DAOs do projeto frequency80cafe
#Autor: Estephano Borovicz
#Data: 11/06/2026
#Versão:1.0

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
      #model -> sql = `call procInsertCategoria('${categoria}','${descricao}', '${imagem}' )`
      delimiter $$
        create procedure procInsertCategoria(IN categoria varchar(45), descricao TEXT, imagem varchar(255))
          BEGIN
            insert into tbl_categoria(
                categoria,
                descricao,
                imagem
            )VALUES(
                categoria,
                descricao,
                imagem
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
      #model -> sql = `call procUpdateCategoriaById('${categoria.id}','$categoria.categoria}','${descricao}', '${imagem}')`
      delimiter $$
        create procedure procUpdateCategoriaById(IN categoria varchar(45), descricao TEXT, imagem varchar(255))
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

      #inserir produto na tbl_imagem
    delimiter $$
      create trigger tgrInsertProduto
		before insert on tbl_produto
			for each row
				begin
					insert into tbl_imagem (
                    id_produto
                    )values(
                    tbl_produto.id
                    );
	end $$
    
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
          
          #-------------------------------------------------------imagem----------------------------------------------------------------
 
  #inserir nova imagem
        #model -> sql = `call procInsertImagem(${imagem.url},${imagem.id_produto}')`
        delimiter $$
          create procedure procInsertImagem(IN url varchar(255), id_produto int)
            BEGIN
              insert into tbl_imagem(
                  url,
                  tbl_imagem.id_produto
              )VALUES(
                  url,
                  id_produto
                  );
        END $$
 
 #listar todos as imagens
      #model -> sql = `select * from vwImagem`
        create view vwImagem  as
          select * from tbl_imagem order by id desc;

      #buscar imagem por id
      #model -> sql = `call procSelectImagemById('${imagem.id}')`
      delimiter $$
        create procedure procSelectImagemById (in id int)
          begin
            select * from tbl_imagem where tbl_imagem.id = id;
        end $$

#atualizar imagem por id
      #model -> sql = `call procUpdateImagemById('${imagem.id}','${imagem.url}','${imagem.id_produto}')`
      delimiter $$
        create procedure procUpdateImagemById(in id int, url varchar(255), id_produto int)
          begin
                update tbl_imagem set
                                        url = new.url,
                                        id_produto = new.id_produto
                          where id = tbl_imagem.id;
        end $$

#deletar imagem por id
 #model -> sql = `call procDeleteImagemById('${imagem.id}')`

      delimiter $$
      create procedure procDeleteImagemById(in id int)
        begin
          delete from tbl_imagem where tbl_imagem.id = id;
        end$$
          

          
      
