use ADM_consultorio --troque pelo banco de sua escolha
go

... tarefa:
Escolha um de seus bancos de dados. 
( não vale: master, model, msdb, tempdb )

Logado como um administrador. Via interface, crie um login 
chamado 'teste' sem nenhuma server role além de 
public ( a básica, já pré-definida ).

Mapei-o ao banco escolhido, deixando-o [novamente] 
só com a database role de public ( a básica, já pré-definida ).
-- Quem chegou aqui "levante a mão" na sala de aula


--No console de comando 
-- ( janela padrão para digitar código SQL ),
--entre no banco escolhido ( use <database> ) e digite:
use ADM_consultorio --troque pelo banco de sua escolha
go
GRANT VIEW SERVER STATE TO [teste]

Por que deu errado ?
Como você faria para corrigir este erro ?					...então corrija-o...

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
	SELECT 'Hoje é: ' + CONVERT(VARCHAR,GETDATE(),103)
END
GO


execute as login = 'teste'
select SYSTEM_USER
	exec sp_aProcedureMaisSensacional
revert
select SYSTEM_USER






-- tendo certeza de que você ainda é o SA
CREATE OR ALTER PROCEDURE sp_umaProcedureQualquer
with execute as owner
as begin
	select SYSTEM_USER
end

uma procedure tem os privilegios
associados ao usuário que a executa.
porém, ao usar with execute as owner
eu uso as permissões de quem a criou
ao invés de quem a executou.



execute as login = 'teste'
	exec sp_umaProcedureQualquer
revert



