-- AULA 01

CREATE TABLE CLIENTES3
(
    CPF VARCHAR(11),
    NOME VARCHAR(100),
    ENDERECO1 VARCHAR(150),
    ENDERECO2 VARCHAR(150),
    BAIRRO VARCHAR(50),
    CIDADE VARCHAR(50),
    ESTADO VARCHAR(2),
    CEP VARCHAR(8),
    IDADE INT,
    SEXO VARCHAR(1),
    LIMITE_CREDITO FLOAT,
    VOLUME_COMPRA FLOAT,
    PRIMEIRA_COMPRA NUMBER(1)
);

CREATE TABLE VENDEDORES
(
    MATRICULA VARCHAR(5),
    NOME VARCHAR(100),
    PERCENTUAL_COMISSAO FLOAT
);

ALTER TABLE VENDEDORES ADD CONSTRAINT PK_VENDEDORES PRIMARY KEY (MATRICULA);

DROP TABLE CLIENTES3

-- AULA 02

INSERT INTO PRODUTOS (PRODUTO, NOME, EMBALAGEM, TAMANHO, SABOR, PRECO_LISTA) VALUES ( '1040107', 'Light - 350 ml - Melancia', 'Lata', '350', 'Melancia', 4.56)

SELECT * FROM PRODUTOS

INSERT INTO VENDEDORES (MATRICULA, NOME, PERCENTUAL_COMISSAO) VALUES ('00233', 'Jo�o Geraldo da Fonseca', 0.10)

SELECT * FROM VENDEDORES

UPDATE VENDEDORES SET NOME = 'Ronaldo Naz�rio da Silva' WHERE MATRICULA = '00233'

ALTER TABLE PRODUTOS ADD CONSTRAINT PK_PRODUTOS PRIMARY KEY (PRODUTO);

INSERT INTO TB_CLIENTES (
    CPF, NOME, ENDERECO1, ENDERECO2, 
    BAIRRO, CIDADE, ESTADO, CEP, IDADE, 
    SEXO, LIMITE_CREDITO, VOLUME_COMPRA, 
    PRIMEIRA_COMPRA, DATA_NASCIMENTO
) VALUES (
    '00388934777', 'Jo�o da Silva', 'Rua Projetada A n�mero 10', 
    NULL , 'VILA ROMAN', 'TR�S RIOS', 'RJ', '22222222', 53, 'M', 
    20000.00, 2000, 0, TO_DATE('12/10/1965','MM/DD/YYYY')
);