
--Nome: Eugênio G. Diniz
--RA: 210033-4


CREATE TABLE TB_ACESSO (
    Login VARCHAR(50) NOT NULL,    Senha VARCHAR(200) NOT NULL,    senha_dica VARCHAR(200) NOT NULL);

CREATE FUNCTION fn_encrypt(@text VARCHAR(200))
	RETURNS VARCHAR(200) AS BEGIN
    				RETURN HASHBYTES('SHA1', @text);
END;


CREATE FUNCTION fn_decrypt(@hash VARCHAR(200))
	RETURNS VARCHAR(200) AS BEGIN
    				RETURN CAST(HASHBYTES('SHA1', @hash) AS VARCHAR(200));
END;


CREATE FUNCTION fn_hash1(@text VARCHAR(200))
	RETURNS VARCHAR(200) AS BEGIN
    				DECLARE @salt VARCHAR(200) = 'O5@187E6$32E<#/$@10';
    					RETURN ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), @text, 1, CONVERT(varbinary(32), salt));
END;

CREATE PROCEDURE sp_authenticate    @login VARCHAR(50),    @senha VARCHAR(200) AS BEGIN
    DECLARE @senha_crpt VARCHAR(200) = dbo.fn_encrypt(@senha);
    
IF EXISTS 
(SELECT 1 FROM TB_ACESSO
 WHERE Login = @login
 AND Senha = @senha_crpt)
BEGIN
SELECT 1;
END
ELSE BEGIN
SELECT 0;
END END;


CREATE PROCEDURE senha_dica_123aaa
    @login VARCHAR(50)
AS BEGIN
    DECLARE @senha_crpt VARCHAR(200);
    DECLARE @senha_dcrpt VARCHAR(200);
    
    SELECT @senha_crpt = senha_dica_123aaa
    FROM TB_ACESSO
    WHERE Login = @login;
    
    SET @senha_dcrpt = CONVERT(VARCHAR(255), DECRYPTBYKEY(descr_dica));
    
    SELECT @senha_dcrpt;
END;