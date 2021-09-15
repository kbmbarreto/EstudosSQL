-- ######################################### --
--  ------------ BIBLIOTECA CASEIRA -----------
-- ######################################### --
-- Este banco de dados foi desenvolvido para suportar um  
--sistema de cadastro para controle de uma biblioteca caseira.
--
-- ********************************************* --
--  Criação do Banco de dados BibliotecaCaseira  --
-- ********************************************* --

Create database BibliotecaCaseira
go

Use BibliotecaCaseira
go

-- **************************************************** --
--  Biblioteca Caseira - Sistema de Biblioteca Caseira  --
-- **************************************************** --

Create table Autor
(
	IDAutor int identity primary key not null,
	Autor varchar(75) not null,
	Sobre varchar(1000)
)

Create table Editora
(
	IDEditora int identity primary key not null,
	Editora varchar(45) not null
)

Create table Categoria
(
	IDCategoria int identity primary key not null,
	Categoria varchar(45) not null
)

Create table Livro
(
	IDLivro int identity primary key not null,
	Titulo varchar(75) not null,
	Isbn varchar(45),
	Emprestado int,
	Observacoes varchar(100),
	Ano date not null,
	FKCategoria int not null,
	FKAutor int not null,
	FKEditora int not null
)

go

/*Relacionamento entre Livro e Autor */

alter table Livro add constraint FK_B001FKAutor foreign key (FKAutor) 
references Autor (IDAutor)

go

/*Relacionamento entre Livro e Editora */

alter table Livro add constraint FK_B001FKEditora foreign key (FKEditora) 
references Editora (IDEditora)

go

/*Relacionamento entre Livro e Categoria */

alter table Livro add constraint FK_B001FKCategoria foreign key (FKCategoria) 
references Categoria (IDCategoria)

go

-- ############################################# --
--  CRIAÇÃO DAS PROCEDURES - BIBLIOTECA CASEIRA  --
-- ############################################# --

-- ********************** --
--  Procedures Categoria  --
-- ********************** --

-- Procedure para cadastro de categorias --

create proc ProcCadastrarCategoria
@Categoria varchar(45)
as
insert into Categoria (Categoria) values (@Categoria)
go

-- Procedure para consulta de categorias --

create proc ProcExibirCategoria
as
select * from Categoria
order by IDCategoria desc
go

-- Procedure para alterar uma categoria --

create proc ProcEditarCategoria
@IDCategoria int output,
@Categoria varchar(45)
as
update Categoria set Categoria = Categoria where IDCategoria = IDCategoria
go

-- Procedure para excluir uma categoria --

create proc ExcluirCategoria
@IDCategoria int
as
delete from Categoria where
IDCategoria = @IDCategoria
go

-- Procedure para pesquisa de categorias (criar uma variavel para armazenar a busca em um campo) --

create proc ProcPesquisarCategoria
@PesquisarCategoria varchar(45)
as select * from Categoria 
where Categoria like @PesquisarCategoria + '%'
go

-- ******************** --
--  Procedures Editora  --
-- ******************** --

-- Procedure para cadastro de editoras --

create proc ProcCadastrarEditora
@Editora varchar(45)
as
insert into Editora (Editora) values (@Editora)
go

-- Procedure para consulta de editoras --

create proc ProcExibirEditora
as
select * from Editora
order by IDEditora desc
go

-- Procedure para alterar uma editora --

create proc EditarEditora
@IDEditora int output,
@Editora varchar(45)
as
update Editora set Editora = @Editora where IDEditora = @IDEditora
go

-- Procedure para excluir uma editora --

create proc ProcExcluirEditora
@IDEditora int
as
delete from Editora where
IDEditora = @IDEditora
go

-- Procedure para pesquisa de editoras (criar uma variavel para armazenar a busca em um campo) --

create proc ProcPesquisarEditora
@PesquisarEditora varchar(45)
as select * from Editora 
where Editora like @PesquisarEditora + '%'
go

-- ****************** --
--  Procedures Autor  --
--******************* --

-- Procedure para cadastro de autores --

create proc ProcCadastrarAutor
@Autor varchar(75),
@Sobre varchar(1000)
as
insert into Autor (Autor, Sobre) values (@Autor, @Sobre)
go

-- Procedure para consulta de autores --

create proc ProcExibirAutor
as
select * from Autor
order by IDAutor desc
go

-- Procedure para alterar um autor --

create proc ProcEditarAutor
@IDAutor int output,
@Autor varchar(75),
@Sobre varchar(1000)
as
update Autor set Autor = @Autor, Sobre = @Sobre where IDAutor = @IDAutor
go

-- Procedure para excluir um autor --

create proc ProcExcluirAutor
@IDAutor int
as
delete from Autor where
IDAutor = @IDAutor
go

-- Procedure para pesquisa de autores (criar uma variavel para armazenar a busca em um campo) --

create proc ProcPesquisarAutor
@PesquisarAutor varchar(75)
as select * from Autor 
where Autor like @PesquisarAutor + '%'
go

-- ****************** --
--  Procedures Livro  --
-- ****************** --

-- Procedure para cadastro de livros --

create proc ProcCadastrarLivro
@Titulo varchar(75),
@Isbn varchar(45),
@Emprestado int,
@Observacoes varchar(200),
@Ano date,
@FKCategoria int,
@FKAutor int,
@FKEditora int
as
Insert into Livro (Titulo, Isbn, Emprestado, Observacoes, 
Ano, FKCategoria, FKAutor, FKEditora) values (@Titulo, @Isbn, @Emprestado, 
@Observacoes, @Ano, @FKCategoria, @FKAutor, @FKEditora)
go

-- Procedure para consulta de livros --

create proc PROCB001ExibirLivro
as
select IDLivro, Categoria, Autor, Titulo, Editora, Isbn, Ano, Emprestado from Livro
inner join Categoria as cat
on FKCategoria = cat.IDCategoria
inner join Autor as autor
on FKAutor = autor.IDAutor
inner join Editora as edit
on FKEditora = edit.IDEditora
order by IDLivro desc
go

-- Procedure para alterar um livro --

create proc ProcEditarLivro
@IDLivro int output,
@Titulo varchar(75),
@Isbn varchar(45),
@Emprestado int,
@Observacoes varchar(200),
@Ano date,
@FKCategoria int,
@FKAutor int,
@FKEditora int
as
update Livro set Titulo = @Titulo, Isbn = @Isbn, Emprestado = @Emprestado, 
Observacoes = @Observacoes, Ano = @Ano, FKCategoria = @FKCategoria, 
FKAutor = @FKAutor, FKEditora = @FKEditora where IDLivro = @IDLivro
go

-- Procedure para apagar um livro --

create proc ProcExcluirLivro
@IDLivro int
as
delete from Livro where
IDLivro = @IDLivro
go

-- Procedure para pesquisa de livros (criar uma variavel para armazenar a busca em um campo) --

create proc ProcPesquisarLivro
@PesquisarLivro varchar(75)
as select * from Livro 
where Titulo like @PesquisarLivro + '%'
go