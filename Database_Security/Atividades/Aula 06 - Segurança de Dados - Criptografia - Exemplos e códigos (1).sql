create database Cripto
go
use Cripto
go

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- HASH
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Declare @Salt Varchar(50) = 'FIT'
Declare @pass Varchar(255) = 'teste'
Declare @value Varchar(255) =  @pass + @salt

select HASHBYTES('md5',@value)
-- 0xF49D7CA29D54B25A20F8EE4D695F7748
select HASHBYTES('sha1',@value)
--0x7ECA82E54BFF01456689D9995DBD1241090FF458

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- CHAVE SIMÉTRICA
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

CREATE SYMMETRIC KEY ChaveSimetrica01 
WITH ALGORITHM = AES_256
ENCRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76'

OPEN SYMMETRIC KEY ChaveSimetrica01 DECRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76';

Declare @result varbinary(max)

Declare @key UNIQUEIDENTIFIER = (select Key_GUID('ChaveSimetrica01'))

select @result = EncryptByKey(@key, 'OMG You Killed Kenny');

select CONVERT(VARCHAR,DECRYPTBYKEY(@result))

CLOSE SYMMETRIC KEY ChaveSimetrica01 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- CHAVE ASSIMÉTRICA
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

CREATE ASYMMETRIC KEY ChaveAssimetrica001
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76';
GO

Declare @key_ID INT = (select AsymKey_ID('ChaveAssimetrica001'))

Declare @result VARBINARY(MAX)
SELECT @result = EncryptByAsymKey(@key_ID, 'OMG You Killed Kenny')

select CONVERT(VARCHAR,DecryptByAsymKey(@key_ID, @result, N'!@@QW#E#$R%dreud76'))

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- EXERCÍCIOS
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--Criando a tabela
CREATE TABLE TBL_CTRL_ACESSO (
	[LOGIN] VARCHAR(60) NOT NULL
	, [SENHA] VARBINARY(MAX) NOT NULL
	, [DICA_SENHA] VARBINARY(MAX) NULL
	, CONSTRAINT PK_CTRL_ACESSO PRIMARY KEY ( [LOGIN] )
)
GO
--Criando a chave assimétrica ( poderia ser simétrica )
CREATE ASYMMETRIC KEY ChaveAssimetrica001
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76';
GO

--criando a função de criptografia 2-way
CREATE FUNCTION FN_ENCRYPT ....
GO
--Testando a função de criptografia
select dbo.FN_ENCRYPT('oi')
GO
--Criando função de decriptografia
CREATE FUNCTION FN_DECRYPT ...
GO
--Testando a função de decriptografia
select dbo.FN_DECRYPT(dbo.FN_ENCRYPT('oi'))
GO
--Criando função de criptografia 1-way HASH
CREATE FUNCTION FN_HASH ...
GO
--Testando a função de criptografia de HASH
select dbo.FN_HASH('oi')
GO

--Inserindo valores nas tabelas para testes:
INSERT INTO TBL_CTRL_ACESSO ( [LOGIN], [SENHA], [DICA_SENHA] )
VALUES ( 'José', dbo.FN_HASH('senha'), dbo.FN_ENCRYPT('aquela lá') )
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
CREATE PROCEDURE PR_LOGIN...
GO
--testando procedure de login
DECLARE @result BIT
	--autenticado
	EXEC PR_LOGIN 'josé', 'senha', @result OUTPUT
	SELECT CASE WHEN @result = 1 then 'Autenticado' else 'Não autenticado' end
	--não autenticado
	EXEC PR_LOGIN 'josé', 'senha errada', @result OUTPUT
	SELECT CASE WHEN @result = 1 then 'Autenticado' else 'Não autenticado' end
GO
-- CRIANDO PROCEDURE PARA ESQUECI SENHA
CREATE PROCEDURE PR_ESQUECI_SENHA...
GO
--Testando a procedure esqueci senha
DECLARE @result VARCHAR(60) 
EXEC PR_ESQUECI_SENHA 'josé', @result OUTPUT
SELECT 'Sua dica da senha é: "' + @result + '"'
GO







