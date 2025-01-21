--Create database consultorio
--go
--use consultorio
--go


CREATE TABLE Paciente (
	ID INT NOT NULL IDENTITY(1,1)
	, Nome VARCHAR(50) NOT NULL
	, Telefone INT NULL
	, CONSTRAINT PK_Paciente PRIMARY KEY nonclustered ( ID )
)
GO
CREATE TABLE Sala (
	Numero INT NOT NULL 
	, CONSTRAINT PK_Sala PRIMARY KEY ( Numero )
)
GO
	CREATE TABLE Medico (
	ID INT NOT NULL IDENTITY(1,1)
	, CRM VARCHAR(10) NOT NULL
	, Nome VARCHAR(50) NOT NULL
	, Especialidade VARCHAR(30) NULL
	, CONSTRAINT PK_Medico PRIMARY KEY ( ID )
)
GO
	CREATE TABLE Consulta (
	ID INT NOT NULL IDENTITY(1,1)
	, ID_Paciente INT NOT NULL
	, ID_Medico INT NOT NULL
	, Numero_Sala INT NOT NULL
	, DataHora DATETIME NOT NULL
	, Duracao TINYINT NOT NULL
	, CONSTRAINT PK_Consulta PRIMARY KEY ( ID )
	, CONSTRAINT FK_ConsultaMedico FOREIGN KEY ( Id_medico ) REFERENCES Medico( ID )
	, CONSTRAINT FK_ConsultaPaciente FOREIGN KEY ( Id_paciente ) REFERENCES paciente( ID )
	, CONSTRAINT FK_ConsultaSala FOREIGN KEY ( Numero_Sala ) REFERENCES Sala( Numero )
)
GO


