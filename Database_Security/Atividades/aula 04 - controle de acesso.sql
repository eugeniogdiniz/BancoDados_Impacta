use ADM_consultorio --troque pelo banco de sua escolha
go

... tarefa:
Escolha um de seus bancos de dados. 
( n�o vale: master, model, msdb, tempdb )

Logado como um administrador. Via interface, crie um login 
chamado 'teste' sem nenhuma server role al�m de 
public ( a b�sica, j� pr�-definida ).

Mapei-o ao banco escolhido, deixando-o [novamente] 
s� com a database role de public ( a b�sica, j� pr�-definida ).
-- Quem chegou aqui "levante a m�o" na sala de aula


--No console de comando 
-- ( janela padr�o para digitar c�digo SQL ),
--entre no banco escolhido ( use <database> ) e digite:
use ADM_consultorio --troque pelo banco de sua escolha
go
GRANT VIEW SERVER STATE TO [teste]

Por que deu errado ?
Como voc� faria para corrigir este erro ?					...ent�o corrija-o...

use master
go
GRANT VIEW SERVER STATE TO [teste]






grant view server state to teste
...
revoke view server state to teste

execute as login = 'teste'
select SYSTEM_USER
	--DMV para consulta de 'working threads'
	SELECT scheduler_id, current_tasks_count, runnable_tasks_count
	FROM sys.dm_os_schedulers
	WHERE scheduler_id < 255
revert
select SYSTEM_USER
...


use ADM_consultorio --troque pelo banco de sua escolha
go
CREATE OR ALTER PROCEDURE sp_aProcedureMaisSensacional
AS BEGIN
	SELECT 'Hoje �: ' + CONVERT(VARCHAR,GETDATE(),103)
END
GO


execute as login = 'teste'
select SYSTEM_USER
	exec sp_aProcedureMaisSensacional
revert
select SYSTEM_USER






-- tendo certeza de que voc� ainda � o SA
CREATE OR ALTER PROCEDURE sp_umaProcedureQualquer
with execute as owner
as begin
	select SYSTEM_USER
end

uma procedure tem os privilegios
associados ao usu�rio que a executa.
por�m, ao usar with execute as owner
eu uso as permiss�es de quem a criou
ao inv�s de quem a executou.



execute as login = 'teste'
	exec sp_umaProcedureQualquer
revert



