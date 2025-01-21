--Criando a tabela
CREATE TABLE TBL_CTRL_ACESSO (
	[LOGIN] VARCHAR(60) NOT NULL
	, [SENHA] VARBINARY(MAX) NOT NULL
	, [DICA_SENHA] VARBINARY(MAX) NULL
	, CONSTRAINT PK_CTRL_ACESSO PRIMARY KEY ( [LOGIN] )
)
GO
--Criando a chave assim�trica ( poderia ser sim�trica )
CREATE ASYMMETRIC KEY ChaveAssimetrica001
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76';
GO

--criando a fun��o de criptografia 2-way
CREATE FUNCTION FN_ENCRYPT ( @conteudo VARCHAR(MAX) )
RETURNS VARBINARY(MAX) AS 
BEGIN
	Declare @key_ID INT = (select AsymKey_ID('ChaveAssimetrica001'))
	DECLARE @result VARBINARY(MAX)

	SELECT @result = EncryptByAsymKey(@key_ID, @conteudo)

	RETURN @result
END
GO
--Testando a fun��o de criptografia
select dbo.FN_ENCRYPT('oi')
GO
--Criando fun��o de decriptografia
CREATE FUNCTION FN_DECRYPT ( @valorCriptografado VARBINARY(MAX) )
RETURNS VARCHAR(MAX) AS
BEGIN
	Declare @key_ID INT = (select AsymKey_ID('ChaveAssimetrica001'))
	DECLARE @result VARBINARY(MAX)

	SELECT @result = DecryptByAsymKey(@key_ID, @valorCriptografado, N'!@@QW#E#$R%dreud76')

	RETURN CONVERT(VARCHAR(MAX),@result)
END
GO
--Testando a fun��o de decriptografia
select dbo.FN_DECRYPT(dbo.FN_ENCRYPT('oi'))
GO
--Criando fun��o de criptografia 1-way HASH
CREATE FUNCTION FN_HASH ( @conteudo VARCHAR(MAX) )
RETURNS VARBINARY(MAX) AS 
BEGIN
	DECLARE @result VARBINARY(MAX)
	DECLARE @SALT VARCHAR(60) = 'salzinho'
	DECLARE @Conteudo_com_sal VARCHAR(MAX) = @conteudo + @SALT
	SELECT @result = HASHBYTES('SHA2_512', @Conteudo_com_sal)

	RETURN @result
END
GO
--Testando a fun��o de criptografia de HASH
select dbo.FN_HASH('oi')
GO

--Inserindo valores nas tabelas para testes:
INSERT INTO TBL_CTRL_ACESSO ( [LOGIN], [SENHA], [DICA_SENHA] )
VALUES ( 'Jos�', dbo.FN_HASH('senha'), dbo.FN_ENCRYPT('aquela l�') )
GO
--Testando valores brutos inseridos na tabela
select * from TBL_CTRL_ACESSO
GO
--Testando valores decriptografados lidos da tabela
select	[login]
		,[senha]
		,CONVERT(VARCHAR,dbo.FN_DECRYPT([dica_senha])) as [dica_senha] 
from TBL_CTRL_ACESSO
GO


--Criando a Procedure de login:
CREATE PROCEDURE PR_LOGIN( @login VARCHAR(60), @senha VARCHAR(60), @Autenticado BIT OUTPUT )
AS BEGIN
	SET @Autenticado = 0 --Por padr�o ele � 0, s� vira 1 se for validado.
	SELECT 	@Autenticado = 1
	FROM TBL_CTRL_ACESSO
	WHERE	[LOGIN] = @login
			AND [SENHA] = dbo.FN_HASH(@senha)
	RETURN @Autenticado
END
GO
--testando procedure de login
DECLARE @result BIT
	--autenticado
	EXEC PR_LOGIN 'jos�', 'senha', @result OUTPUT
	SELECT CASE WHEN @result = 1 then 'Autenticado' else 'N�o autenticado' end
	--n�o autenticado
	EXEC PR_LOGIN 'jos�', 'senha errada', @result OUTPUT
	SELECT CASE WHEN @result = 1 then 'Autenticado' else 'N�o autenticado' end
GO
-- CRIANDO PROCEDURE PARA ESQUECI SENHA
CREATE PROCEDURE PR_ESQUECI_SENHA( @login VARCHAR(60), @dica_senha VARCHAR(60) OUTPUT )
AS BEGIN
	SELECT 	@dica_senha = dbo.FN_DECRYPT(DICA_SENHA)
	FROM	TBL_CTRL_ACESSO
	WHERE	[LOGIN] = @login
END
GO
--Testando a procedure esqueci senha
DECLARE @result VARCHAR(60) 
EXEC PR_ESQUECI_SENHA 'jos�', @result OUTPUT
SELECT 'Sua dica da senha �: "' + @result + '"'
GO







