------------------------------------------------------
-- Aula 01 - Apresentação e revisão - GUIA de ESTUDO
------------------------------------------------------

Este guia visa apresentar um conjunto de passos ou exercícios
( muitas vezes desenvolvido pelo próprio aluno) como forma 
de estudo, prática ou para fixação de conteúdo.

Tente responder à todas as perguntas e faça todos os passos
propostos.

Mas, antes de começar a falar de SQL...

------------------------------------------------------
-- Preparação do ambiente
------------------------------------------------------

É altamente recomendado que vocês tenham um ambiente de trabalho.
Para ver detalhes de como instalar o MSSQL e o cliente SSMS, 
veja aula 01.
Quem não puder instalar o MSSQL, Instale apenas o cliente SSMS
e tente usar o servidor da impacta ou solicite acesso à um 
servidor criado pelo professor na AWS.
Quem não puder nem instalar o MSSQL, nem o cliente SSMS,
tente acompanhar via http://www.sqlfiddle.com/

Pause este guia e prepare seu ambiente de estudo.

------------------------------------------------------
-- Tenha uma metodologia de estudo
------------------------------------------------------

Mantenha-se organizado, salve todo o conteúdo passado pelo
professor em pastas organizadas por aula, por conteúdo,
por tipo de arquivo, o que você achar melhor.

É essencial que cada arquivo, cada vídeo, cada exercícios,
seja refeito, revisto, pelo menos uma vez fora da aula.

Crie um bloco de notas no inicio de cada aula, vá anotando
cada dúvida, cada ponto não entendido, e não saia da aula
sem ter respondido ou pelo menos postado as perguntas ao 
professor. 

Lembre-se, o professor tem o dever de ensinar, mas você
tem o dever de aprender, e os dois só cumprirão seus papéis
se ambos trabalharem juntos.

Não tenha vergonha nem preguiça de dar um passo para trás 
antes de dar dois para frente. Para a construção de uma
pirâmide de conhecimento, se sua base não for forte o 
sufiente, é seu papel reforça-la, rever conceitos, procurar
novos materiais e superar os desafios ( lembre-se
o professor é sempre uma ótima fonte de orientação ).

------------------------------------------------------
-- Saiba onde encontrar a informação
------------------------------------------------------

O material do professor é a referência básica e primeiro 
local de consulta. Os exercícios, as aulas gravadas, 
seus comentários, suas notas coletadas durante as aulas.

Também existem não só vídeos gravadados por todos os 
professores que já ministraram esta disciplina no passado,
basta pesquisar no smartclass ( sistema da faculdade
em www.impacta.com.br > area do aluno > Aulas de graduação )

Existe muito material disponível na internet.
Não há problema se, ao estudar, vocês precisarem 
acessar o google para descobrir o que este ou aquele comando
faz. Cada novo link, documento, ou vídeo com conteúdo
interessante, deve ser arquivado em sua biblioteca pessoal
de estudo.

Seus colegas também são uma ótima referência,
muitos tem ou já tiveram as mesmas dúvidas que você.

Porém, ceda à tentação de procurar por respostas prontas
elas representam atalhos falsos para o conhecimento, e
muitas vezes apenas vão lhe tornar cada mais dependentes 
dos outros e menos de si próprios.

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Revisão
------------------------------------------------------
Conceitos importantes de Linguagem SQL que devem ser revisados
ou entendidos:

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Modelo conceitual 
------------------------------------------------------

-	Modelo conceitual, modelo lógico relacional e modelo físico.
você sabe a diferença entre eles ?
qual a ordem? por que eles estão nesta ordem ?

-	Por que os modelos conceituais devem :
Possuir um propósito ?
Serem uma simplificação da realidade ?
seus elementos devem possuir uma conexão com a realidade ?
Possuirem um padrão visual ?

-	Por que todo modelo deve responder às sequintes questões ?
Qual a Audiência do modelo conceitual ? 
Quais Questões o modelo conceitual deve responder ?
Quais Informações (conceitos) precisam ser guardados ?
Quais destas informações devem estar representadas no modelo.

-	Por que o DER foi escolhido para representar 
os modelos conceituais ?

-	DER é a única forma de representar tais modelos ?

-	No DER, Como é representado uma entidade ?
-	O que é uma entidade ?

-	No DER, Como é representado uma entidade-fraca ?
-	O que é uma entidade-fraca ?

-	No DER, Como é representado um relacionamento ?
-	O que é um relacionamento ?

-	No DER, Como é representado um atributo ?
-	O que é um atributo ?

-	No DER, Como é representado um atributo multivalorado?
-	O que é um atributo multivalorado?

-	No DER, Como é representado um atributo composto?
-	O que é um atributo composto?

-	No DER, Como é representado um atributo chave?
-	O que é um atributo chave?

-	No DER, Como é representado um atributo derivado ou calculado?
-	O que é um atributo derivado ou calculado?

-	No DER, Como é representado a cardinalidade?
-	O que é a cardinalidade ?

-	No DER, Como é representado a participação total/parcial?
-	O que é a participação total/parcial ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Modelo Relacional 
------------------------------------------------------

- Por que chamamos o próximo passo de detalhamento 
do modelo conceitual de modelo relacional ?

- O que são as relações neste modelo ?

Sobre as regras de mapeamento do modelo conceitual 
para o modelo relacional:
- Para cada exemplo solicitado, tente idealiza-lo e mapeá-lo.
Use o exemplo idealizado ou busque um exemplo simples 
em seu material de estudo ou na internet, ou solicite 
mais material de estudo ao professor.
Mapeio, tente entender por que ele é assim, na dúvida, 
pesquise mais um pouco e tire suas dúvidas com o professor.


Passo 1: entidade normal → tabela, atributos simples → colunas
- Consegue imaginar uma entidade normal com atributos normais ?
- Como uma entidade normal é mapeada ?

Passo 2: entidade fraca → nova tabela, PK composta, com FK 
- Consegue imaginar uma entidade fraca com atributos normais ?
- Como uma entidade fraca é mapeada ?

Passo 3: cardinalidade 1:1 → PK de uma* como FK na outra + atrib
Consegue 
- Consegue imaginar duas entidades normais com cardinalidade 1-1?
- Como tal relacionamento é mapeado ?

Passo 4: cardinalidade 1:N → PK do 1 como FK na do N + atrib
- Consegue imaginar duas entidades normais com cardinalidade 1-N?
- Como tal relacionamento é mapeado ?

Passo 5: cardinalidade N:N → nova tabela, PK ambas como FK + atrib
- Consegue imaginar duas entidades normais com cardinalidade N-N?
- Como tal relacionamento é mapeado ?

Passo 6: atributo multivalorado → nova tabela, com FK
- Consegue imaginar uma entidade normal com atributo multivalorado ?
- Como tal atributo é mapeado ?

Passo 7: ordem >=3 → nova tabela, PK todas como FK + atrib
- Consegue imaginar 3 entidades normais relacionadas ( ordem > 3 )?
- Como tal atributo é mapeado ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Normalização
------------------------------------------------------

- O que é normalização ?
- Por que ela é importante ?
- O que são anomalias ?
- O que são tuplas espúrias ?
- O que significa um modelo estar normalizado ?
- O que significa um modelo estar desnormalizado ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Tipos de dados
------------------------------------------------------

- O que é 'tipar' um dado ?
- Por que diz-se que um dos primeiros passos para se sair
do modelo lógico relacional para o físico é aprender
a tipar corretamente seus dados ?
- Por que é importante sempre escolher o tipo de dados
mais enxuto ou econômico ?
- Os dados ocupam espaço no disco em forma de bytes,
o que são bytes ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Tipos de dados - Numéricos
------------------------------------------------------

Sobre tipos numéricos:
-	Cite um tipo de dado ideal para guardar:
números pequenos, de 0 a 255
números médios de -32,768 a 32,767
Números grandes de 2^31 (-2,147,483,648) a 2^31-1 (2,147,483,647)
Números MUITO grandes de -2^63 a 2^63-1 (+/- 9 quintillion)
Números binários 1, 0 or NULL

- Num tipo decimal e/ou numeric, o que significam a precisão 
e a escala, como em NUMERIC( 10,2 )

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Tipos de dados - Textuais
------------------------------------------------------

Sobre tipos textuais:
- Qual a diferença entre CHAR e VARCHAR ?
- O que são tipos de dados unicode como eles são representados ?
- Qual a diferença entre tipos unicode e não unicode ?
- O que é o argumento ao char ou varchar, como em VARCHAR(10) ?
- O que representa o MAX como em VARCHAR(MAX) ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Tipos de dados - Data e hora
------------------------------------------------------

- Como representar Data e hora juntos ?
- Como representar apenas a Data ?
- Como representar apenas a Hora ?
- Qual o formato ou padrão recomendado para digitar datas
para evitar problemas com padrões e nacionalidades ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - nome com 4 partes
------------------------------------------------------

- O que quer dizer que um objeto no banco de dados
é referenciado ou possui 4 partes em seu nome ?
- O que é um servidor ou instância ?
- O que é um database ?
- O que é um schema ?
- O que é um objeto ( como uma tabela, mas não só tabelas )? 

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - fator de nulidade
------------------------------------------------------

- Como representar que um campo não é obrigatório ?
- Como representar que um campo é obrigatório e portanto
deve sempre ser preenchido com um valor ?
- Um pode ser obrigatório e não obrigatório ao mesmo tempo ?
- O que é um dado NULO ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - valores auto-incrementais
------------------------------------------------------

- O que são campos auto-incrementais ?
- Como representá-los ?
- Quais são os 2 argumentos passados como parâmetros, como em
identity(10,10) ?
- Um campo auto-incremental pode ser nulo ?
	Se você não sabe, Como você faria para testar e descobrir ?
- É possível forçar um valor em um campo auto-incremental,
ou seja, inserir o que você quiser ? como ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Qual o limite de colunas auto-incrementais por tabela ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Numa coluna, qual o valor padrão para o fator de nulidade ?
	ou seja, se você não definir nada, qual função prevalece:
	obrigatório ou não obrigatório ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Tabelas
------------------------------------------------------

A estrutura básica para armazenamento de dados
- por que ela é muitas vezes comparada com uma planilha em excel ?
- o que são as colunas ? qual o outro nome dado à elas?
- o que são as linhas ? qual o outro nome dado à elas?
- É possível existir 'meia linha',
	em outras palavras, é possível existir uma linha incompleta ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Como cada linha é definida na criação da tabela ?
- Toda coluna tem que ser tipada e seu fator de nulidade 
	deve ser preenchido ?
- Existe uma ordem para a noeação das colunas, ou elas
	podem ser definidas em qualquer ordem ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Constraints
------------------------------------------------------

- O que significa dizer que constraints são restrições
para o devido preenchimento de dados em uma tabela ?
- Quais são os 5 contraints mais comummente vistos ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - Primary key
------------------------------------------------------

- Qual imposição de preenchimento uma chave primária
impõe sobre a tabela onde ela é aplicada ?
- Quantas chaves primárias uma tabela pode ter ?
- Como você simularia uma violação da regra de preenchimento 
	de chave primária ?
- Toda tabela obrigatóriamente precisa de uma chave primária ?
	Se você não sabe, Como você faria para testar e descobrir ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - FOREIGN KEY
------------------------------------------------------

- Qual imposição de preenchimento uma chave estrangeira
impõe sobre a tabela onde ela é aplicada ?
- Quantas chaves estrangeiras uma tabela pode ter ?
- Como você simularia uma violação da regra de preenchimento 
	de chave estrangeira ?
- Toda tabela obrigatóriamente precisa de uma chave estrangeira ?
- Toda chave estrangeira tem preenchimento obrigatório ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Toda chave estrangeira precisa obrigatóriamente estar
	associada à uma chave primária ?
- A relação entre chave estrangeira e primária é chamada de
	regra de integridade referencial, ela obrigátóriamente 
	tem que ocorrer entre tabelas diferentes ?
	Imagine e implemente um caso em que ambas ocorram na
	mesma tabela ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - UNIQUE
------------------------------------------------------

- Qual imposição de preenchimento uma regra de unicidade
impõe sobre a tabela onde ela é aplicada ?
- Quantas regras de unicidade uma tabela pode ter ?
- Como você simularia uma violação da regra de preenchimento 
	de regra de unicidade ?
- Toda tabela obrigatóriamente precisa de uma regra de unicidade?
- Toda regra de unicidade tem preenchimento obrigatório ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Quais as diferenças entre uma chave primária 
	e uma regra de unicidade ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - CHECK
------------------------------------------------------

- Qual imposição de preenchimento uma regra de verificação
impõe sobre a tabela onde ela é aplicada ?
- Quantas regra de verificação uma tabela pode ter ?
- Como você simularia uma violação da regra de preenchimento 
	de regra de verificação ?
- Toda tabela obrigatóriamente precisa de uma regra de verificação?
- Toda regra de verificação tem preenchimento obrigatório ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Uma mesma coluna pode possuir múltiplas regras de verificação ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Que tipo de instruções ou condições é possível usar
	em uma regra de verificação ?
- Quantas instruções ou condições é possível usar
	em uma regra de verificação ?
- Imagine o código para a criação de uma regra de verificação 
	com múltiplas condições, implemente-a.

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DEFAULT
------------------------------------------------------

- Qual imposição de preenchimento uma regra de valor padrão
impõe sobre a tabela onde ela é aplicada ?
- Quantas regras de valor padrão uma tabela pode ter ?
- Como você simularia uma violação da regra de valor padrão
- Toda tabela obrigatóriamente precisa de uma regra de valor padrão?
- Toda regra de verificação tem preenchimento obrigatório ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Imagine um exemplo de uma regra de valor padrão, implemente-a. 

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DDL
------------------------------------------------------

Rode os seguintes comandos, identifique as colunas, os tipos de dados
as regras(constraints), as colunas com preenchimento obrigatório,
as colunas com preenchimento padrão ou automático.

CREATE TABLE Aluno
( 
Matricula int not null IDENTITY (500, 1)
, Nome varchar(20) 
, CONSTRAINT pkAluno 
   PRIMARY KEY (Matricula)
);

CREATE TABLE Prova
( 
idProva int NOT NULL  IDENTITY (1, 1)
, Matricula int  NOT NULL
, Nota decimal(4,2) NOT NULL
, CONSTRAINT pkProva PRIMARY KEY (idProva)
, CONSTRAINT fkProva FOREIGN KEY (Matricula)
  REFERENCES Aluno(Matricula)
);

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - INSERT
------------------------------------------------------

- É possível inserir apenas parte da linha, por exemplo,
	só preencher os campos que você quer ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Existe uma ordem específica para declarar as colunas ?
- O número de colunas declaradas e de valores fornecidos
	tem que ser o mesmo ?
- Qual o problema deste código ?
	create table tbl ( idade int, salario numeric(11,2) )
	insert into tbl ( salario, idade )
	values ( 22, 4000 )
- Como você corrigiria ?
- É possível inserir, em um campo com chave estrangeira
	um valor ainda não declarado na respectiva chave primaria ?
- Uma linha inserida precisa obedecar À todas as regras
	definidas na criação da tabela ?
- Consegue imaginar algum cenário em que uma regra 
	possa ser violada sob alguma condição ?
- Após um insert, como faço para descobrir os valores 
	preenchidos automaticamente pelo sistema, em especial
	como faço para recuperar um ID auto-incremental ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DELETE
------------------------------------------------------

- É possível expluir apenas parte da linha, por exemplo,
	só excluir uma coluna com valores indesejáveis ?
	Se você não sabe, Como você faria para testar e descobrir ?
- Existe uma ordem específica para declarar as colunas 
	que eu quero que sejam excluídas ?
	Ex: delete nome, idade from aluno
	Se você não sabe, Como você faria para testar e descobrir ?
- É possível excluir dados de múltiplas tabelas ao mesmo tempo ?
- É possível consultar dados de múltiplas tabelas, mesmo que eu
	só exclua de apenas uma ?
	Se você não sabe, Como você faria para testar e descobrir ?
- É possível excluir uma linha cujo valor da chave primária
	esteja sendo utilizada em uma coluna com uma chave estrangeira
	associada à ela ?
	Se você não sabe, Como você faria para testar e descobrir ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - UPDATE
------------------------------------------------------

- O comando de Update tem a capacidade de aumentar ou de 
	reduzir a quantidade de linhas de uma tabela ?
- O comando de update tem que obedecer à todas as regras
	de inserção e de remoção definidos na tabela?
- Seja as seguintes tabelas:
	CREATE TABLE A ( A INT NOT NULL PRIMARY KEY )
	CREATE TABLE B ( B INT NOT NULL PRIMARY KEY
					, A INT NOT NULL FOREIGN KEY REFERENCES A (A)	)
	INSERT INTO A (A) VALUES ( 1 )
	INSERT INTO B (B,A) VALUES ( 1, 1 )
- Algum destes updates roda ? por que sim / por que não ?
	UPDATE B SET A = 2 WHERE B = 1
	UPDATE A SET A = 2 WHERE A = 1
- Sem inserir nem excluir linhas, 
	como você atualizaria o valor da primeira linha da tabela A
	coluna A, para 2 ? explique sua resposta.
- É possível atualizar dados de múltiplas tabelas ao mesmo tempo ?
- É possível consultar dados de múltiplas tabelas, mesmo que eu
	só atualize de apenas uma ?
	Se você não sabe, Como você faria para testar e descobrir ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DDL
------------------------------------------------------
Sejam os seguintes comandos:
	CREATE TABLE Aluno
	( 
	Matricula int not null IDENTITY (500, 1)
	, Nome varchar(20) 
	, CONSTRAINT pkAluno 
	   PRIMARY KEY (Matricula)
	);

	CREATE TABLE Prova
	( 
	idProva int NOT NULL  IDENTITY (1, 1)
	, Matricula int  NOT NULL
	, Nota decimal(4,2) NOT NULL
	, CONSTRAINT pkProva PRIMARY KEY (idProva)
	, CONSTRAINT fkProva FOREIGN KEY (Matricula)
	  REFERENCES Aluno(Matricula)
	);

- Simule a inserção dos seguintes valores:
Tabela: Aluno				Tabela: Prova
Matricula	Nome			idProva		Matricula	Nota		
----------	-------			-------		-----------	--------
500			José			1			500			9
501			Pedro			2			500			8
							3			501			0

- Simule a exclusão de José e todos os dados associados à ele:

- Simule a atualização da única nota de Pedro de 0 para 10.

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL
------------------------------------------------------

- Qual o papel individual de cada parte do comando select ?
	SELECT		
	FROM		
	WHERE		
	GROUP BY	
	HAVING		
	ORDER BY	
- Qual a ordem se interpretação ou execução do select ?
- Por que a ordem de escrita e de execução são diferentes ?
- Por que é importante entender a ordem de execução
	se você sempre vai escrever na ordem se escrita ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - Apelidos
------------------------------------------------------

- Todas estas formas são possíveis de serem utilizadas para
	apelidar colunas ?
	SELECT '10' AS Quantidade
	SELECT '10' Quantidade
	SELECT Quantidade = '10'
	SELECT 10 'Quantidade'
	SELECT 10 [Quantidade]
	SELECT 10 "Quantidade"
- Para que serve um apelido de coluna utilizado na instrução SELECT  ?

- Todas estas formas são possíveis de serem utilizadas para
	apelidar tabelas ?
CREATE TABLE A ( A INT )
  SELECT  *   FROM A AS Tabela;
  SELECT  *   FROM A Tabela;
  SELECT  *   FROM A "Tabela";
  SELECT  *   FROM A [Tabela];
  SELECT  *   FROM Tabela = A;
  SELECT  *   FROM Tabela as A;
- Para que serve um apelido de coluna utilizado na instrução SELECT  ?

- Todas estas formas são possíveis de serem utilizadas para
	utilizar um apelido de uma tabela ?
CREATE TABLE A ( A INT )
  SELECT  tabela.*   FROM A AS Tabela;
  SELECT  tabela.A   FROM A AS Tabela;
  SELECT  *			 FROM A AS Tabela;
  SELECT  *.A		 FROM A AS Tabela;

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - DISTINCT
------------------------------------------------------

- Para que serve o comando distinct, de um exemplo ?
- Eu só posso passar única uma coluna para devolver valores únicos ?
- Algo é atualizado ou alterado na tabela após o uso 
	de um select simples com a instrução distinct ?
- Complete a frase:
	O número de linhas retornadas pelo DISTINCT é equivalente AO...
- Quando um distinct é útil ? pense em alguma situação.

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - ORDER BY
------------------------------------------------------

- Por que é útil ou para que seria importante definir a ordem
	em que os dados são apresentados ?
- Como o ORDER BY resolve quando duas colunas são passadas
	nos argumentos, como em ORDER BY nome, idade.
- Pense e implemente um exemplo de
	ordem crescente e outro de decrescente
- Todas estas formas são válidas para determinar uma ordenação ?
	Tente enteder como cada uma funciona ou roda.
CREATE TABLE C ( C1 INT, C2 INT )
INSERT INTO C(C1,c2) VALUES (1,10 ), (1,20),(1,30),(2,10),(2,20),(3,30),(4,10)
  SELECT  *		FROM C	ORDER BY C1, C2 --nomeando as colunas
  SELECT  C1,C2 FROM C	ORDER BY C1, C2 --nomeando as colunas
  SELECT  C1,C2 FROM C	ORDER BY C2, C1 --ordem invertida
  SELECT  C1,C2 FROM C	ORDER BY C1 DESC, C2 ASC--Um ASC e um DESC
  SELECT  C1,C2 FROM C	ORDER BY 1, 2 --por posição e não coluna
  SELECT  C2,C1 FROM C	ORDER BY 1, 2 --por posição e não coluna - invertida
  SELECT  C1 as primeira, C2 as segunda 
	FROM C	ORDER BY primeira, segunda --por apelidos

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - TOP
------------------------------------------------------

- Por que limitar a quantidade de linhas de um select ?
	justifique os cenários em que isso é útil.
- O que é retornado quando alguém estabelece um SELECT TOP 0 ?
	Se você não sabe, Como você faria para testar e descobrir ?
- É possível devolver 10 de uma coluna e 20 de outra 
	em um mesmo select ?
- Com o comando TOP é possível definir que você 
	só quer os dados da 10ª à 20ª linha ?
- Existe alguma forma possível para definir que você 
	só quer os dados da 10ª à 20ª linha ?
	Se você não sabe, Como você faria para testar e descobrir ?
	Dica ( comando offset )

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - WHERE
------------------------------------------------------
Seja o seguinte conjunto de código:
			create table venda (
				nota_fiscal int not null
				, data datetime not null
				, atendente nvarchar(50) null
				, constraint PK_venda PRIMARY KEY ( nota_fiscal)
			)
			GO
			create table Produto (
				ID int not null
				, nome nvarchar(50) not null
				, preco decimal(10,4) not null
				, constraint PK_produto PRIMARY KEY ( ID )
			)
			GO
			create table ItemVenda (
				NF int not null
				, idProduto int not null
				, preco decimal(10,4) not null
				, qtde int not null
				, constraint PK_Itemvenda PRIMARY KEY ( NF, idProduto )
				, constraint FK_itemvenda_notafiscal FOREIGN KEY (NF) REFERENCES venda( nota_fiscal )
				, constraint FK_Itemvenda_produto FOREIGN KEY ( idProduto) REFERENCES produto ( id )
			)
			GO
			INSERT INTO venda(nota_fiscal, data, atendente) 
			values (1112, '20110312', 'Marco' ), (3002, '20110314', 'Marco' ), (7134, '20110421', 'Marco' ), (7135, '20110501', 'Pedro' )
			GO
			INSERT INTO produto(ID, nome, preco) 
			VALUES ( 1, 'Lapis', 0.25), ( 2, 'Caneta', 0.50), ( 9, 'Caderno', 5.00), ( 10, 'Borracha', 0.50)
			GO
			INSERT INTO ItemVenda(NF, idProduto, preco, qtde)
			VALUES (1112, 1, 0.22, 230), (1112,2,0.50,10), (1112,9,5.50,1), (3002, 9, 4.50,20)
			GO
- Encontre uma maneira mais simples de realizar este filtro
	que retornaria os mesmos resultados.
	SELECT * FROM Venda 
	WHERE data >= '20000101' AND data <= '20211231'
R:
- Encontre uma maneira mais simples de realizar este filtro
	que retornaria os mesmos resultados.
	SELECT * FROM produto
	WHERE ID = 1 OR ID = 2 OR ID = 9 or ID = 20
R:
- Encontre uma maneira mais simples de realizar este filtro
	que retornaria os mesmos resultados.
	SELECT * FROM produto
	WHERE ID <> 1 AND ID = 2 AND ID <> 9 AND ID <> 20
R:
- Independente de quantas linhas existam nesta tabela
	quantas linhas seriam devolvidas após este filtro ?
	SELECT * FROM Venda 
	WHERE atendente = 'marco' AND atendente = 'Pedro'
R:	
- Na instrução like, qual o significado do filtro, 
	pense em um exemplo de uso para cada caso. 
	'%'	quando usado à esquerda de um char, ex: '%.com.br'
	'%'	quando usado à direita de um char, ex: 'google.%'
	'%'	quando usado no meio de uma palavra, ex: 'www.%.com.br'
	'%'	quando usado nos dois lados, ex: '%google%'
	'[1..9][0..9][3..7]' quando usado para filtrar números
		, ex: '103'
	'[A..Z]%' quando usado para filtrar o primeiro char maiúsculo
		, ex: 'Avião'

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - JOIN
------------------------------------------------------

- Por que você acha que existem tantos tipos de joins ?
- Nomeie alguns destes tipos ?
- Reveja a aula dos joins e tente entender o motivo
	dos joins serem explicados utilizando a teoria
	de conjuntos para as junções.
	( imagem: https://www.securesolutions.no/wp-content/uploads/2014/07/joins-1.jpg)	

- O join é realizado pela tabela ?
		ON aluno and prova ?
	OU o join é realizado entre colunas ?
		ON aluno.matricula = prova.matricula
	OU o join é realizado entre as linhas cujos valores 
	são idênticos entre as colunas citadas para conferência ?
		ON aluno.matricula = prova.matricula
Tabela: Aluno				Tabela: Prova
Matricula	Nome			idProva		Matricula	Nota		
----------	-------			-------		-----------	--------
500			José			1			500			9
501			Pedro			2			500			8
502			Maria			3			501			0
- Qual a quantidade de linhas do join citado ?
		ON aluno.matricula = prova.matricula
	Como você faria para testar se sua resposta está correta ?
- O resultado do seguinte comando:
		SELECT * FROM ALUNO join PROVA ON aluno.matricula = prova.matricula
	Seria este ?
		Matricula	Nome	idProva		Matricula	Nota		
		---------	------	-------		-----------	--------
		500			José	1			500			9
		500			José	2			500			8
		501			Pedro	3			501			0
	Por que José foi listado duas vezes e Pedro só uma ?
	Por que maria naõ foi listada nenhuma vez ?
- Existe alguma forma de trazer uma listagem que inclua
	a Maria, mesmo que não apareçam valores para as Provas
		Matricula	Nome	idProva		Matricula	Nota		
		---------	------	-------		-----------	--------
		500			José	1			500			9
		500			José	2			500			8
		501			Pedro	3			501			0
		502			Maria	NULL		NULL		NULL
	Escreva este comando
R:
- Agora, existiria alguma forma de só listar os alunos
	que não tem prova alguma, como a maria ?
	Talvez aplicando algum tipo de filtro ?
		Matricula	Nome	idProva		Matricula	Nota		
		---------	------	-------		-----------	--------
		502			Maria	NULL		NULL		NULL
	Escreva este comando
R:

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - GROUP BY 
------------------------------------------------------

- Partindo do seguinte conjunto de dados:	
		Matricula	Nome	idProva		Matricula	Nota		
		---------	------	-------		-----------	--------
		500			José	1			500			9
		500			José	2			500			8
		501			Pedro	3			501			0
		502			Maria	NULL		NULL		NULL
	E obter um resultado como:
		Nome	Media
		-------	--------
		José	8.5
		Pedro	0
	Eu preciso agrupar as duas notas de josé em uma única
	recuperando a média das mesmas.
	Como ficaria o comando:
R:
- Para as outras funções de agrupamento listadas
	pense em um exemplo real de uso para cada uma:
	- SUM
	- AVG
	- MIN
	- MAX
	- COUNT

- Ao agrupar por uma coluna o número de linhas
	resultante será idêntico ao número único de valores ?
	ou seja:
	Número de linhas de: SELECT DISTINCT valor FROM tabela
	será igual ao de: SELECT valor FROM tabela GROUP BY valor ?
	Justifique sua resposta:
R: 
	Como você faria para testar se sua resposta está correta ?
R: 

- Ao agrupar por múltiplas colunas, como em "pais, cidade"
	a resposta dada acima também seria válida ?
	ou seja:
	Número de linhas de: SELECT DISTINCT pais,cidade FROM tabela
	será igual ao de: SELECT pais,cidade FROM tabela GROUP BY pais.cidade ?
	Justifique sua resposta:
R: 
	Como você faria para testar se sua resposta está correta ?
R: 

- Ao agrupar valores, o que acontece com os NULOS?
	por exemplo, ao usar incluir a maria na query do primeiro 
	exemplo, como ficaria sua média ?

------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - Having
------------------------------------------------------

- Por que na estrutura do SELECT temos duas instruções
	diferentes para filtros ( where e having ),
	qual a diferença entre elas ?
- Sua resposta pode ter citado a diferença entre dados 'brutos'
	dados 'agrupados' de onde vem ou são criados tais dados ?
- Todos os tipos de filtros ou operadores do where também 
	estão presentes no Having ?
	Se sua resposta for "não sei", como você testaria
	para garantir que sua resposta fique mais certeira.

- Sejam os seguintes dados:
		Matricula	Nome	idProva		Matricula	Nota		
		---------	------	-------		-----------	--------
		500			José	1			500			9
		500			José	2			500			8
		501			Pedro	3			501			0
		502			Maria	NULL		NULL		NULL
	E obter um resultado como:
		Nome	Media
		-------	--------
		José	8.5
		Pedro	0
	Ao calcular a média, é possível só devolver quem 
	não alcançou a média 7 por não ter ido bem na prova ?
R:
- E se, agora você tivesse que também devolver quem 
	não alcançou a média 7 por não ter ido bem na prova
	ou não fez nenhuma prova, como ficaria o select final ?
R:
	Como você faria para testar seu select e ter certeza do resultado ?
R:

----------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - Funções Internas
----------------------------------------------------------

Existem inúmeras funções internas, porém algumas são tão
úteis que dizermos que fazem parte do dia-a-dia de muitos DBAs.

-Descubra o significado e idealize um uso real para cada uma delas:
	-Funções de texto
		SELECT SUBSTRING('nome', 3, 2) from produto
		SELECT nome,  left(nome, 4) FROM produto
		SELECT nome,  right(nome, 4) FROM produto
		SELECT nome, lower(nome) FROM produto
		SELECT nome, upper(nome) FROM produto
		SELECT nome, ltrim(nome) from produto
		SELECT nome, len(nome) from produto
		SELECT nome, replace(nome,'a','') from produto
		SELECT nome, charindex('a',nome,0) from produto
	- Funções numéricas
		select FLOOR(preco/2) from produto
		select CEILING(preco/2) from produto
		select ROUND(preco/2,2) from produto
	- Funções de data
		SELECT data, Dateadd(yy, 1, data), Dateadd(mm, -2, data) from venda
		SELECT Datediff( year, data, GETDATE() ) from venda
		SELECT Year(data) FROM venda
		SELECT datepart(Year,venda) FROM venda
	- Funções de conversão
		SELECT GETDATE() AS Dt1
			, CAST(GETDATE() AS varchar(30)) AS DtCast
			, CONVERT(varchar(30), GETDATE(), 112) AS DtConvert
		SELECT	'Produto: '+ CAST(id as varchar)  as  IdProduto, 
				'Nome: ' + nome as nomeProduto
		FROM Produto

------------------------------------------------------------------
-- Guia de estudo - Linguagem SQL - DQL - Sub-Selects ( básicos )
------------------------------------------------------------------

Um subSelect depois que resolvido pode ser substituido pelo 
dado básico que ele devolve.

- Sejam os dados:
		Matricula	Nome	idProva		Matricula	Nota		
		---------	------	-------		-----------	--------
		500			José	1			500			9
		500			José	2			500			8
		501			Pedro	3			501			0
		502			Maria	NULL		NULL		NULL
	Como descobrir quem tirou uma nota maior que a pior nota
	de josé ?
	Primeiro, descubra qual a pior nota de josé 
	( dica, ele pode ter várias, melhor agrupa-las e pegar a menor ).
R:
	Depois baseado no seguinte select simples, que lista
	todos os alunos, exceto o josé.
		SELECT	nome 
		from	aluno inner join nota 
				on aluno.matricula = nota.matricula
		where	aluno.nome <> 'josé'
				and aluno.nota > ...
	Inclua o seu sub-select ( no lugar dos ... ) 
	para filtrar a nota mínima destes alunos e finalmente 
	descobrir se algúem mais conseguiu uma nota maior que a 
	menor nota do josé. 
	Como ficou seu select ?
R:
- Agora, imagine que a maria realizou uma prova...
		Matricula	Nome	idProva		Matricula	Nota		
		---------	------	-------		-----------	--------
		500			José	1			500			9
		500			José	2			500			8
		501			Pedro	3			501			0
		502			Maria	4			502			10
Seu select do exercício anterior trouxe a maria,
	pois constatou-se que ela sim, tem uma nota superior
	à menor das notas de josé.
R:
- Para inserir um novo aluno, Marco, que já realizou uma
	prova em sequência, foi utilizado o seguinte comando:
	INSERT INTO ALUNO ( nome ) values ( 'Marco' )
	INSERT INTO PROVA ( Matricula, nota )
		VALUES ( (SELECT matricula FROM ALUNO WHERE nome = 'Marco'), 3 )
	como o sub-select foi usado ?
	qual o valor que ele retornou e que foi usado para inserir na prova ?
R:
- Como você re-escreveria o seguinte comando para inserir marco 
	e sua respectiva prova, sem chutar ou fixar a matricula
	recebida na inserção do aluno ? 
R:
	Como você faria para testar se sua resposta está correta ?
R:

