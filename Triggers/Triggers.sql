CREATE DATABASE ex_triggers_07
GO
USE ex_triggers_07
GO
CREATE TABLE cliente (
codigo		INT			NOT NULL,
nome		VARCHAR(70)	NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE venda (
codigo_venda	INT				NOT NULL,
codigo_cliente	INT				NOT NULL,
valor_total		DECIMAL(7,2)	NOT NULL
PRIMARY KEY (codigo_venda)
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo)
)
GO
CREATE TABLE pontos (
codigo_cliente	INT					NOT NULL,
total_pontos	DECIMAL(4,1)		NOT NULL
PRIMARY KEY (codigo_cliente)
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo)
)
 
SELECT * FROM cliente
SELECT * FROM venda
SELECT * FROM pontos



CREATE TRIGGER t_teste ON venda
FOR DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é possível excluir produto', 16, 1)
END


CREATE TRIGGER t_venda ON venda
FOR UPDATE
AS 
BEGIN
  SELECT * FROM venda
END



CREATE TRIGGER t_atualiza ON venda
INSTEAD OF UPDATE
AS

DECLARE @codigo INT 
SET @codigo = (SELECT MAX(c.codigo) FROM cliente c)

BEGIN
	SELECT c.nome, v.valor_total FROM cliente c, venda v
	WHERE c.codigo = v.codigo_cliente
	AND  c.codigo = @codigo
END