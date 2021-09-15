-- ######################################### --
--  ------------ CONTROLE DE SENHAS -----------
-- ######################################### --
-- Este banco de dados foi desenvolvido para um sistema de Controle  
--de senhas. 
--
-- ********************************* --
--   Sistema de Controle de senhas   --
-- ********************************* --

Create database ControleSenhas
go

Use ControleSenhas
go

-- ********************************************** --
--  Sistema de Controle armazenamento de senhas   --
-- ********************************************** --

Create table Senhas
(
	IDSenha int identity primary key not null,
	Descricao varchar (75) not null,
	EnderecoVirtual varchar (100),
	Usuario varchar (75) not null,
	Senha varchar (75) not null,
	Observacoes varchar (100)
)

-- ######################## --
--  CRIAÇÃO DAS PROCEDURES  --
-- ######################## --

-- ******************* --
--  Procedures Senhas  --
-- ******************* --

-- Procedure para cadastro de Senhas --

create proc ProcCadastrarSenha
@Descricao varchar(75),
@EnderecoVirtual varchar(100),
@Usuario varchar(75),
@Senha varchar(75),
@Observacoes varchar(100)
as
insert into Senhas (Descricao, EnderecoVirtual, Usuario, Senha, Observacoes) values (@Descricao, 
@EnderecoVirtual, @Usuario, @Senha, @Observacoes)
go

-- Procedure para exibir Senhas --

create proc ProcExibirSenhas
as
select * from Senhas
order by IDSenha desc
go

-- Procedure para editar Senhas --

create proc ProcEditarSenhas
@IDSenha int,
@Descricao varchar (75),
@EnderecoVirtual varchar (100),
@Usuario varchar (75),
@Senha varchar (75),
@Observacoes varchar (100)
as 
update Senhas set Descricao = @Descricao, EnderecoVirtual = @EnderecoVirtual, 
Usuario = @Usuario, Senha = @Senha, Observacoes = @Observacoes where IDSenha = @IDSenha
go

-- Procedure para excluir Senhas --

create proc ProcExcluirSenhas
@IDSenha int
as
delete from Senhas where IDSenha = @IDSenha
go

-- Procedure para pesquisar Senhas --

create proc ProcPesquisarSenhas
@PesquisarSenhas varchar(75)
as
select * from Senhas where Descricao like @PesquisarSenhas + '%'
go