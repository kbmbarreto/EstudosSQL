create schema clinica_medica;
use clinica_medica;

create table if not exists clinica_medica.funcionarios (
	Codigo_Funcionario int not null auto_increment,
    Nome_Completo varchar(50) not null,
    Numero_RG varchar(12) null,
    Orgao_Emissor varchar(6) null,
    Numero_CPF varchar(14) null,
    Endereco varchar(50) null,
    Numero varchar(15) null,
    Complemento varchar(30) null,
    Bairro varchar(40) null,
    Cidade varchar(40) null,
    Estado varchar(2) null,
    Telefone varchar(20) null,
    Celular varchar(20) null,
    Numero_CTPS varchar(20) null,
    Numero_PIS varchar(20) null,
    Data_Nascimento date null,
    primary key (Codigo_Funcionario),
    index Idx_Nome (Nome_Completo asc),
    index Idx_CPF (Numero_CPF asc)
)
engine = InnoDB;

create table if not exists clinica_medica.usuarios (
	Registro_Usuario int not null auto_increment,
    Identificacao_Usuario varchar(20) null,
    Senha_Acesso varchar(10) null,
    Cadastro_Funcionario varchar(1) null default 'N',
    Cadastro_Usuario varchar(1) null default 'N',
    Cadastro_Paciente varchar(1) null default 'N',
    Cadastro_Especialidade varchar(1) null default 'N',
    Cadastro_Medico varchar(1) null default 'N',
    Cadastro_Convenio varchar(1) null default 'N',
    Agendamento_Consulta varchar(1) null default 'N',
    Cancelamento_Consulta varchar(1) null default 'N',
    Modulo_Administrativo varchar(1) null default 'N',
    Modulo_Agendamento varchar(1) null default 'N',
    Modulo_Atendimento varchar(1) null default 'N',
    primary key (Registro_Usuario)
)
engine = InnoDB;

create table if not exists clinica_medica.especialidade (
	Codigo_Especialidade int not null auto_increment,
    Descricao_Especialidade varchar(45) null,
    primary key (Codigo_Especialidade)
)
engine = InnoDB;

create table if not exists clinica_medica.medicos (
	Codigo_Medico int not null auto_increment,
    Nome_Medico varchar(50) null,
    Codigo_Especialidade int not null,
    CRM varchar(20) null,
    primary key (Codigo_Medico, Codigo_Especialidade asc),
    constraint fk_medicos_especialidade1
		foreign key (Codigo_Especialidade)
		references clinica_medica.especialidade (Codigo_Especialidade)
		on delete no action
		on update no action
)
engine = InnoDB;

create table if not exists clinica_medica.convenios (
	Codigo_Convenio int not null auto_increment,
    Empresa_Convenio varchar(45) null,
    CNPJ varchar(18) null,
    Telefone varchar(20) null,
    primary key (Codigo_Convenio)
)
engine = InnoDB;

create table if not exists clinica_medica.pacientes (
	Codigo_Paciente int not null auto_increment,
    Nome varchar(50) null,
    Numero_RG varchar(12) null,
    Orgao_Emissor varchar(6) null,
    Numero_CPF varchar(14) null,
    Endereco varchar(50) null,
    Numero varchar(15) null,
    Complemento varchar(30) null,
    Bairro varchar(40) null,
    Cidade varchar(40) null,
    Estado varchar(2) null,
    Telefone varchar(20) null,
    Celular varchar(20) null,
    Data_Nascimento date null,
    Sexo varchar(1) null,
    Tem_Convenio varchar(1) null,
    Codigo_Convenio int not null,
    Senha_Acesso varchar(10),
    primary key (Codigo_Paciente, Codigo_Convenio),
    index fk_pacientes_convenios1_idx (Codigo_Convenio asc),
    constraint fk_pacientes_convenios1
		foreign key (Codigo_Convenio)
        references clinica_medica.convenios (Codigo_Convenio)
        on delete no action
        on update no action
)
engine = InnoDB;

create table if not exists clinica_medica.agenda_consulta (
	registro_Agenda int not null auto_increment,
    Codigo_Usuario int not null,
    Codigo_Paciente int not null,
    Codigo_Medico int not null,
    Data date null,
    Hora varchar(5) null,
    Retorno varchar(1) null default 'N',
    Cancelado varchar(1) null default 'N',
    Motivo_Cancelamento text null,
    primary key (Registro_Agenda, Codigo_Usuario, Codigo_Medico, Codigo_Paciente),
    index fk_agenda_consulta_pacientes1_idx (Codigo_Paciente asc),
    index fk_agenda_consulta_medicos1_idx (Codigo_Medico asc),
	index fk_agenda_consulta_usuarios1_idx (Codigo_Usuario asc),
    constraint fk_agenda_consulta_pacientes1
		foreign key (Codigo_Paciente)
        references clinica_medica.pacientes (Codigo_Paciente)
        on delete no action
        on update no action,
	constraint fk_agenda_consulta_medicos1
		foreign key (Codigo_Medico)
        references clinica_medica.medicos (Codigo_Medico)
        on delete no action
        on update no action,
	constraint fk_agenda_consulta_usuarios1
		foreign key (Codigo_Usuario)
        references clinica_medica.usuarios (Registro_Usuario)
        on delete no action
        on update no action
)
engine = InnoDB;

create table if not exists clinica_medica.prontuario_paciente (
	Registro int not null auto_increment,
    Registro_Agenda int not null,
    Historico text null,
    Receituario text null,
    Exames text null,
    primary key (Registro, Registro_Agenda),
    index fk_prontuario_paciente_agenda_consulta1_idx (Registro_Agenda asc),
    constraint fk_prontuario_paciente_agenda_consulta1
		foreign key (Registro_Agenda)
        references clinica_medica.agenda_consulta (Registro_Agenda)
        on delete no action
        on update no action
)
engine = InnoDB;