Create database FastTicket
Go
Use FastTicket
Go

Set ANSI_NULLS On
Go

Set QUOTED_IDENTIFIER On
Go

Create table Acompanhamento
(
	IDAcompanhamento int identity (1,1) NOT NULL,
	Acompanhamento varchar (500) NULL,
	HoraAcompanhamento datetime NULL,
	FKIDChamado int NULL,
	
	primary key clustered 
	(
		IDAcompanhamento ASC
	)
	
	With (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)

On [PRIMARY]
Go

Set ANSI_NULLS ON
Go
Set QUOTED_IDENTIFIER ON
Go

Create table Agente
(
	IDAgente int identity (1,1) NOT NULL,
	NomeAgente varchar (45) NOT NULL,
	Funcao varchar (45) NOT NULL,
	Usuario varchar (45) NOT NULL,
	Senha varchar (45) NOT NULL,

primary key clustered 

	(
		IDAgente ASC
	)
	
	With (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) 

On [PRIMARY]
Go

Set ANSI_NULLS ON
Go

Set QUOTED_IDENTIFIER ON
Go

Create table Chamado
(
	IDChamado int identity (1,1) NOT NULL,
	DataAbertura datetime NOT NULL,
	Assunto varchar (45) NOT NULL,
	Descricao varchar (500) NOT NULL,
	FKCliente int NOT NULL,
	FKNomeAgente int NOT NULL,
	FKStatusChamado int NOT NULL,
	FKProduto int NOT NULL,
	FKAcompanhamento int NULL,

primary key clustered

	(
		IDChamado ASC
	)
	With (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) 

On [PRIMARY]
Go

Set ANSI_NULLS ON
Go

Set QUOTED_IDENTIFIER ON
Go

Create table Cliente
(
	IDCliente int identity (1,1) NOT NULL,
	Cnpj varchar (45) NOT NULL,
	Cliente varchar (50) NOT NULL,
	FKTipoContrato int NULL,

primary key clustered 

	(
		IDCliente ASC
	)
	
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) 

On [PRIMARY]
Go

Set ANSI_NULLS ON
Go

Set QUOTED_IDENTIFIER ON
Go

Create table Contato
(
	IDContato int identity (1,1) NOT NULL,
	Nome varchar (60) NOT NULL,
	Telefone varchar (32) NULL,
	Email varchar (60) NULL,
	FKCliente int NULL,

primary key clustered 

	(
		IDContato ASC
	)
	
	With (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)

On [PRIMARY]
Go

Set ANSI_NULLS ON
Go

Set QUOTED_IDENTIFIER ON
Go

Create table Contrato
(
	IDContrato int identity (1,1) NOT NULL,
	TipoContrato varchar (45) NOT NULL,

primary key clustered 

	(
		IDContrato ASC
	)

	With (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)

On [PRIMARY]
Go

Set ANSI_NULLS ON
Go

Set QUOTED_IDENTIFIER ON
Go

Create table Produto
(
	IDProduto int identity (1,1) NOT NULL,
	Produto varchar (45) NOT NULL,

primary key clustered 

	(
		IDProduto ASC
	)

	With (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

)

On [PRIMARY]
Go

Set ANSI_NULLS ON
Go

Set QUOTED_IDENTIFIER ON
Go

Create table Status
(
	IDStatus int identity (1,1) NOT NULL,
	StatusChamado varchar (40) NOT NULL,
	HoraStatus datetime NULL,

primary key clustered 

	(
		IDStatus ASC
	)

	With (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

) 

On [PRIMARY]
Go

Alter table Chamado with check add constraint FKChamadoAcompanhamento Foreign Key (FKAcomnpanhamento)
References Acompanhamento (IDAcompanhamento)
Go

Alter table Chamado check constraint FKChamadoAcompanhamento
Go

Alter table Chamado with check add constraint FKChamadoAgente Foreign Key (FKNomeAgente)
References Agente (IDAgente)
Go

Alter table Chamado check constraint FKChamadoAgente
Go

Alter table Chamado with check add constraint FKChamadoCliente Foreign Key(FKCliente)
References Cliente (IDCliente)
Go

Alter table Chamado check constraint FKChamadoCliente
Go

Alter table Chamado with check add constraint FKChamadoProduto Foreign Key (FKProduto)
References Produto (IDProduto)
Go

Alter table Chamado check constraint FKChamadoProduto
Go

Alter table Chamado with check add constraint FKChamadoStatus Foreign Key (FKStatusChamado)
References Status (IDStatus)
Go

Alter table Chamado check constraint FKChamadoStatus
Go

Alter table Cliente with check add constraint FKClienteContrato Foreign Key (FKTipoContrato)
References Contrato (IDContrato)
Go

Alter table Cliente check constraint FKClienteContrato
Go

Alter table Contato with check add constraint FKContatoCliente Foreign Key (FKCliente)
References Cliente (IDCliente)
Go

Alter table Contato check constraint FKContatoCliente
Go