--Criando um backup total com a op��o de criar um novo cabe�alho
-- e sobrescrevendo-o caso um arquivo como mesmo nome j� existir
BACKUP DATABASE consultorio
TO DISK = 'C:\BD\Backups\Consultorio.bak'
WITH FORMAT, INIT;
GO
--Criando um backup distribuido em 3 arquivos
-- , cada um com sua exclusiva c�pia de espelho:
BACKUP DATABASE consultorio
TO DISK = 'C:\BD\Backups\Consultorio_1a.bak',
DISK = 'C:\BD\Backups\Consultorio_2a.bak',
DISK = 'C:\BD\Backups\Consultorio_3a.bak'
MIRROR TO DISK = 'C:\BD\Backups\Consultorio_1b.bak',
DISK = 'C:\BD\Backups\Consultorio_2b.bak',
DISK = 'C:\BD\Backups\Consultorio_3b.bak'
WITH FORMAT;

--Criando um backup diferencial
BACKUP DATABASE consultorio
TO DISK = 'C:\BD\Backups\Consultorio.bak'
WITH DIFFERENTIAL
GO
--Criando um backup cujo destino � uma fita:
BACKUP DATABASE consultorio
TO TAPE = '\\.\tape0'
MIRROR TO TAPE = '\\.\tape1'
WITH FORMAT,
	MEDIANAME = 'ConsultorioSet0'

--Criando um backup com compress�o de dados
BACKUP DATABASE consultorio
TO DISK = 'C:\BD\Backups\Consultorio.bak'
WITH FORMAT, COMPRESSION

--Criando um backup sem ponto de restaura��o
-- �ltil para n�o interferir na estrat�gia de restaura��o
BACKUP DATABASE consultorio
TO DISK = 'C:\BD\Backups\Consultorio.bak'
WITH COPY_ONLY

--Criando um backup deixando-o n�o operacional ( NORECOVERY )
-- �til em migra��es, para a garantia de n�o 'perder' nada.
BACKUP DATABASE consultorio
TO DISK = 'C:\BD\Backups\Consultorio.bak'
WITH NORECOVERY 

-- Backup com feedback a cada 10% conclu�dos
BACKUP DATABASE consultorio 
TO DISK = 'C:\BD\Backups\Consultorio.log' 
WITH STATS = 10

--Criando chave mestre para criptografia
USE master;  
GO  
CREATE MASTER KEY ENCRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76';
GO 
-- Criando certificado para autentica��o
CREATE CERTIFICATE MeuCertificadoParaBackups 
   WITH SUBJECT = 'Database Encryption Certificate';  
GO 
--Backup com criptografia
BACKUP DATABASE consultorio
TO DISK = 'C:\BD\Backups\Consultorio.bak'
WITH ENCRYPTION (ALGORITHM = AES_256, 
   SERVER CERTIFICATE =  MeuCertificadoParaBackups)

-- Sintaxe � Backup Log
-- op��o NOINIT permite a adi��o de v�rios backups 
-- no mesmo arquivo.
BACKUP LOG Consultorio
TO DISK = 'C:\BD\Backups\Consultorio.log'
WITH NOINIT, FORMAT

-- Backup de logs que expiram em uma data fixa
BACKUP LOG Consultorio
TO DISK = 'C:\BD\Backups\Consultorio.log'
WITH NOINIT, EXPIREDATE = '20210430'

-- Backup de logs que expiram em 7 dias
BACKUP LOG Consultorio
TO DISK = 'C:\BD\Backups\Consultorio.log'
WITH NOINIT, RETAINDAYS = 7

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--Backup de um banco ONLINE
-- N�O aceita futuros restores em continua��o
restore database consultorio 
from disk = 'c:\bd\backups\consultorio.bak'
with RECOVERY, REPLACE
--Backup de um banco OFFLINE 
-- mas que aceita futuros restores em continua��o
restore database consultorio 
from disk = 'c:\bd\backups\consultorio.bak'
with STANDBY = 'c:\bd\consultorio.trn'
--Backup de um banco STANDBY / READONLY 
-- mas que aceita futuros restores em continua��o
restore database consultorio 
from disk = 'c:\bd\backups\consultorio.bak'
with NORECOVERY

--Listar os backups dentro de um arquivo
RESTORE FILELISTONLY 
FROM DISK = 'c:\bd\backups\consultorio.bak'
--Ver detalhes dos bancos
exec sp_helpdb
--Ver detalhes de um banco
exec sp_helpdb 'consultorio_clone'

--Para evitar que um banco seja restaurado sobre
-- os mesmos arquivos f�sicos ( MDF, LDF ) um novo
-- caminho pode ser fornecido.
RESTORE DATABASE consultorio_Clone
FROM DISK = 'c:\bd\backups\consultorio.bak'
WITH NORECOVERY,
MOVE 'consultorio' TO 'c:\bd\mdf\consultorio_Clone.mdf',
MOVE 'consultorio_log' TO 'c:\bd\mdf\consultorio_Clone_log.ldf'





