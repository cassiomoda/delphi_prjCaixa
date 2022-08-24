CREATE TABLE unidades_medida(
	codigo varchar(5) NOT NULL PRIMARY KEY,
	nome varchar(255) NOT null
);

INSERT INTO UNIDADES_MEDIDA VALUES ('un', 'Unidade');
INSERT INTO UNIDADES_MEDIDA VALUES ('kg', 'Quilo');

CREATE TABLE tipos_produto(
	nome varchar(255) NOT NULL PRIMARY key
);

INSERT INTO TIPOS_PRODUTO VALUES ('Bebidas');
INSERT INTO TIPOS_PRODUTO VALUES ('Alimentos');
INSERT INTO TIPOS_PRODUTO VALUES ('Brindes');

CREATE TABLE produtos (
	codigo integer NOT NULL PRIMARY KEY,
	nome varchar(255) NOT NULL,
	preco numeric(10,2) NOT NULL,
	codUnidadeMedida varchar(5) NOT NULL,
	tipoProduto varchar(255) NOT NULL,
	CONSTRAINT fk_produto_unidades_medida FOREIGN KEY (codUnidadeMedida) REFERENCES unidades_medida (codigo),
	CONSTRAINT fk_produto_tipo FOREIGN KEY (tipoProduto) REFERENCES tipos_produto (nome)
);

INSERT INTO PRODUTOS VALUES (1, 'Refrigerante', 5.9, 'un', 'Bebidas');
INSERT INTO PRODUTOS VALUES (2, 'Água mineral', 4.0, 'un', 'Bebidas');
INSERT INTO PRODUTOS VALUES (3, 'Cerveja', 8.5, 'un', 'Bebidas');
INSERT INTO PRODUTOS VALUES (4, 'Sanduiche queijo', 20.0, 'un', 'Alimentos');
INSERT INTO PRODUTOS VALUES (5, 'Sanduiche misto', 29.0, 'un', 'Alimentos');
INSERT INTO PRODUTOS VALUES (6, 'Self service', 39.9, 'kg', 'Alimentos');
INSERT INTO PRODUTOS VALUES (7, 'Sobremesa', 45.9, 'kg', 'Alimentos');
INSERT INTO PRODUTOS VALUES (8, 'Boné', 49.9, 'un', 'Brindes');
INSERT INTO PRODUTOS VALUES (9, 'Chaveiro', 14.9, 'un', 'Brindes');

CREATE TABLE contas (
	codigo varchar(255) NOT NULL PRIMARY KEY,
	nome varchar(255),
	DATA timestamp NOT NULL
);

CREATE TABLE itens_conta (
	codConta varchar(255) NOT NULL,
	codProduto integer NOT NULL,
	quantidade numeric(10,2) NOT NULL,
	subTotal numeric(10,2) NOT NULL,
	CONSTRAINT pk_itens_conta PRIMARY KEY (codConta, codProduto),
	CONSTRAINT fk_itens_conta FOREIGN KEY (codConta) REFERENCES contas (codigo),
	CONSTRAINT fk_itens_produto FOREIGN KEY (codProduto) REFERENCES produtos (codigo)
);
