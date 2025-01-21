● (1) Visão que devolva: Lista com Nome do Paciente
, número do telefone, Data e hora da consulta
, duração da consulta, nome do Médico e Sala 
em que foi feito o atendimento. ( consulta 
idêntica ao exemplo original ).
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
● (2) Função que, dado o nome do paciente
, devolva seu telefone.
Código:

	CREATE OR ALTER FUNCTION FN_PACIENTETELEFONE (
		@NOMEDOPACIENTE VARCHAR(50)
	 )
	 RETURNS INT
	 AS BEGIN
		DECLARE @RETORNO INT	

		SELECT	@RETORNO = TELEFONE	
		FROM	PACIENTE --with(index ([ix_nomePaciente]))
		WHERE	NOME = @NOMEDOPACIENTE

		RETURN @RETORNO 
	 END
	select dbo.FN_PACIENTETELEFONE('Wellington Serafim')

Avaliação cenário inicial:

dbcc freeproccache
dbcc dropcleanbuffers

set statistics time on
set statistics io on

select dbo.FN_PACIENTETELEFONE('Wellington Serafim')

--estatisticas de execução
CPU time = 13 ms, elapsed time = 13 ms.
Table 'Paciente'. Scan count 1, logical reads 3
, physical reads 1, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--olhar plano de execução
custo estimado da sub-árvore 0.005463




Intervenção do DBA ( tunning )
-- eliminar table scan - PK / incide clusterizado
	--CONSTRAINT PK_Paciente PRIMARY KEY nonclustered ( ID )

	ALTER TABLE CONSULTA DROP CONSTRAINT FK_ConsultaPaciente
	ALTER TABLE PACIENTE DROP CONSTRAINT PK_Paciente

	ALTER TABLE PACIENTE 
		add CONSTRAINT PK_Paciente PRIMARY KEY CLUSTERED ( ID )
	ALTER TABLE CONSULTA
		ADD CONSTRAINT FK_ConsultaPaciente FOREIGN KEY ( Id_paciente ) REFERENCES paciente( ID )

--olhar plano de execução
custo estimado da sub-árvore continua 0.005463

--estatististicas de execução....
CPU time = 0 ms, elapsed time = 2 ms.
Table 'Paciente'. Scan count 1, logical reads 5, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

--indice sobre a pesquisa do nome
create index ix_nomePaciente on Paciente ( nome )

--novo indice 
create index ix_nomePaciente2 on Paciente ( nome )
 include (telefone)


--olhar plano de execução

--estatististicas de execução....
   CPU time = 0 ms, elapsed time = 2 ms.
Table 'Paciente'. Scan count 1, logical reads 5, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.





Avaliação cenário final
custo estimado da subarvore caiu para .0032843
   CPU time = 0 ms, elapsed time = 2 ms.
Table 'Paciente'. Scan count 1, logical reads 2
, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.


Conclusão



--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

● (3) Função para, dado o telefone
, devolver o nome do paciente.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

● (4) Procedure que, dado o numero de uma sala 
e um dia, devolva todas as consultas naquele dia
, naquela sala.
Devolva o nome do paciente, nome do médico
, horário e duração da consulta
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

● (5) Procedure que, dado o nome OU CRM do médico
, devolva as últimas 10 consultas que ele realizou.
Apresente o nome do paciente, data, hora e duração
da consulta e número da sala.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
