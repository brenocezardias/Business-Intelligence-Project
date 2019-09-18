/*Script de criação das tabelas, PK's e FK's do modelo relacional e do modelo dimensional*/

/*Criação da tabela de Escolas*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'pense_escola' )
CREATE TABLE dbo.pense_escola(
	id_escola INT NOT NULL
)

/*Criação da PK da tabela de Escolas*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.pense_escola')
			  and name='pk_pense_escola(id_escola)')
begin
ALTER TABLE dbo.pense_escola   
ADD CONSTRAINT [pk_pense_escola(id_escola)] PRIMARY KEY CLUSTERED (id_escola)
end

/*Criação da tabela de Turmas*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'pense_turma' )
CREATE TABLE dbo.pense_turma(
	id_turma  INT NOT NULL,
	id_escola INT NOT NULL
)

/*Criação da PK da tabela de Turmas*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.pense_turma')
			  and name='pk_pense_turma(id_turma)')
begin
ALTER TABLE dbo.pense_turma   
ADD CONSTRAINT [pk_pense_turma(id_turma)] PRIMARY KEY CLUSTERED (id_turma)
end

/*Criação da FK da tabela de Turmas com a tabela de Escolas*/
if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.pense_turma')
   and name='fk_pense_turma_X_pense_escola(id_escola)')
begin
   alter table dbo.pense_turma with nocheck add constraint [fk_pense_turma_X_pense_escola(id_escola)]
   foreign key(id_escola) references dbo.pense_escola(id_escola)
end

/*Criação da tabela de Regiões*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'pense_regiao' )
CREATE TABLE dbo.pense_regiao(
	id_regiao INT NOT NULL,
	nm_regiao VARCHAR(100) NOT NULL
)

/*Criação da PK da tabela de Regiões*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.pense_regiao')
			  and name='pk_pense_regiao(id_regiao)')
begin
ALTER TABLE dbo.pense_regiao   
ADD CONSTRAINT [pk_pense_regiao(id_regiao)] PRIMARY KEY CLUSTERED (id_regiao)
end

/*Criação da Tabela de Federações*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'pense_federacao' )
CREATE TABLE dbo.pense_federacao(
	id_federacao INT NOT NULL,
	nm_federacao VARCHAR(100) NOT NULL,
	id_regiao	 INT NOT NULL
)

/*Criação da PK da tabela de Federações*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.pense_federacao')
			  and name='pk_pense_federacao(id_federacao)')
begin
ALTER TABLE dbo.pense_federacao   
ADD CONSTRAINT [pk_pense_federacao(id_federacao)] PRIMARY KEY CLUSTERED (id_federacao)
end

/*Criãção da FK da tabela de federações com a Tabela de Regiões*/
if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.pense_federacao')
   and name='fk_pense_federacao_X_pense_regiao(id_regiao)')
begin
   alter table dbo.pense_federacao with nocheck add constraint [fk_pense_federacao_X_pense_regiao(id_regiao)]
   foreign key(id_regiao) references dbo.pense_regiao(id_regiao)
end

/*Criação da tabela de Municípios*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'pense_municipio' )
CREATE TABLE dbo.pense_municipio(
	id_municipio		 INT NOT NULL,
	nm_municipio		 VARCHAR(100) NOT NULL,
	fl_municipio_capital INT,
	id_federacao		 INT NOT NULL
)

/*Criação da PK da tabela de Municípios*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.pense_municipio')
			  and name='pk_pense_municipio(id_municipio)')
begin
ALTER TABLE dbo.pense_municipio   
ADD CONSTRAINT [pk_pense_municipio(id_municipio)] PRIMARY KEY CLUSTERED (id_municipio)
end

/*Criação da FK da tabela de Municípios com a tabela de Federações*/
if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.pense_municipio')
   and name='fk_pense_municipio_X_pense_federacao(id_federacao)')
begin
   alter table dbo.pense_municipio with nocheck add constraint [fk_pense_municipio_X_pense_regiao(id_regiao)]
   foreign key(id_federacao) references dbo.pense_federacao(id_federacao)
end

/*Criação da tabela de Alunos*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'pense_aluno' )
CREATE TABLE dbo.pense_aluno(
	id_aluno	 INT NOT NULL,
	id_municipio INT NOT NULL,
	id_turma	 INT NOT NULL
)

/*Criação da PK da tabela de alunos*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.pense_aluno')
			  and name='pk_pense_aluno(id_aluno)')
begin
ALTER TABLE dbo.pense_aluno   
ADD CONSTRAINT [pk_pense_aluno(id_aluno)] PRIMARY KEY CLUSTERED (id_aluno)
end

/*Criação da FK da tabela de Alunos com a tabela de municípios*/
if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.pense_aluno')
   and name='fk_pense_aluno_X_pense_municipio(id_municipio)')
begin
   alter table dbo.pense_aluno with nocheck add constraint [fk_pense_aluno_X_pense_municipio(id_municipio)]
   foreign key(id_municipio) references dbo.pense_municipio(id_municipio)
end

/*Criação da FK da tabela de Alunos com a tabela de Turmas*/
if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.pense_aluno')
   and name='fk_pense_aluno_X_pense_turma(id_turma)')
begin
   alter table dbo.pense_aluno with nocheck add constraint [fk_pense_aluno_X_pense_turma(id_turma)]
   foreign key(id_turma) references dbo.pense_turma(id_turma)
end

/*Criação da tabela de Respotas dos Alunos*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'pense_aluno_resposta' )
CREATE TABLE dbo.pense_aluno_resposta(
	id_aluno_resposta INT IDENTITY (1,1) NOT NULL,
	id_aluno		  INT NOT NULL,
	VB01002			  INT,
	VB01003			  INT,
	VB01016			  INT,
	VB03010A		  INT,
	VB04001			  INT,
	VB07004			  INT,
	VB07006			  INT,
	VB07007			  INT,
	VB07008			  INT,
	VB07009			  INT,
	VB07010			  INT,
	VB12001			  INT,
	VB12002			  INT,
	VB09003			  INT,
	VB09010			  INT
)

/*Criação da PK da tabela de respostas dos Alunos*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.pense_aluno_resposta')
			  and name='pk_pense_aluno_resposta(id_aluno_resposta)')
begin
ALTER TABLE dbo.pense_aluno_resposta   
ADD CONSTRAINT [pk_pense_aluno_resposta(id_aluno_resposta)] PRIMARY KEY CLUSTERED (id_aluno_resposta)
end

/*Criação da FK da tabela de Respostas coma a tabela de Alunos*/
if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.pense_aluno_resposta')
   and name='fk_pense_aluno_resposta_X_pense_aluno(id_aluno)')
begin
   alter table dbo.pense_aluno_resposta with nocheck add constraint [fk_pense_aluno_resposta_X_pense_aluno(id_aluno)]
   foreign key(id_aluno) references dbo.pense_aluno(id_aluno)
end

/*Script de criação das tabelas de Dimensão*/

/*Criação da tabela de Dimensão do primeiro tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_1' )
CREATE TABLE dbo.DIM_resp_tp_1(
	id_resposta_tp_1 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do primeiro tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_1')
			  and name='pk_DIM_resp_tp_1(id_resposta_tp_1)')
begin
ALTER TABLE dbo.DIM_resp_tp_1   
ADD CONSTRAINT [pk_DIM_resp_tp_1(id_resposta_tp_1)] PRIMARY KEY CLUSTERED (id_resposta_tp_1)
end

/*Criação da tabela de Dimensão do segundo tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_2' )
CREATE TABLE dbo.DIM_resp_tp_2(
	id_resposta_tp_2 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do segundo tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_2')
			  and name='pk_DIM_resp_tp_2(id_resposta_tp_2)')
begin
ALTER TABLE dbo.DIM_resp_tp_2   
ADD CONSTRAINT [pk_DIM_resp_tp_2(id_resposta_tp_2)] PRIMARY KEY CLUSTERED (id_resposta_tp_2)
end

/*Criação da tabela de Dimensão do terceiro tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_3' )
CREATE TABLE dbo.DIM_resp_tp_3(
	id_resposta_tp_3 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do terceiro tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_3')
			  and name='pk_DIM_resp_tp_3(id_resposta_tp_3)')
begin
ALTER TABLE dbo.DIM_resp_tp_3   
ADD CONSTRAINT [pk_DIM_resp_tp_3(id_resposta_tp_3)] PRIMARY KEY CLUSTERED (id_resposta_tp_3)
end

/*Criação da tabela de Dimensão do quarto tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_4' )
CREATE TABLE dbo.DIM_resp_tp_4(
	id_resposta_tp_4 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do quarto tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_4')
			  and name='pk_DIM_resp_tp_4(id_resposta_tp_4)')
begin
ALTER TABLE dbo.DIM_resp_tp_4   
ADD CONSTRAINT [pk_DIM_resp_tp_4(id_resposta_tp_4)] PRIMARY KEY CLUSTERED (id_resposta_tp_4)
end

/*Criação da tabela de Dimensão do quinto tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_5' )
CREATE TABLE dbo.DIM_resp_tp_5(
	id_resposta_tp_5 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do quinto tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_5')
			  and name='pk_DIM_resp_tp_5(id_resposta_tp_5)')
begin
ALTER TABLE dbo.DIM_resp_tp_5   
ADD CONSTRAINT [pk_DIM_resp_tp_5(id_resposta_tp_5)] PRIMARY KEY CLUSTERED (id_resposta_tp_5)
end

/*Criação da tabela de Dimensão do sexto tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_6' )
CREATE TABLE dbo.DIM_resp_tp_6(
	id_resposta_tp_6 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do sexto tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_6')
			  and name='pk_DIM_resp_tp_6(id_resposta_tp_6)')
begin
ALTER TABLE dbo.DIM_resp_tp_6   
ADD CONSTRAINT [pk_DIM_resp_tp_6(id_resposta_tp_6)] PRIMARY KEY CLUSTERED (id_resposta_tp_6)
end

/*Criação da tabela de Dimensão do sétimo tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_7' )
CREATE TABLE dbo.DIM_resp_tp_7(
	id_resposta_tp_7 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do sétimo tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_7')
			  and name='pk_DIM_resp_tp_7(id_resposta_tp_7)')
begin
ALTER TABLE dbo.DIM_resp_tp_7   
ADD CONSTRAINT [pk_DIM_resp_tp_7(id_resposta_tp_7)] PRIMARY KEY CLUSTERED (id_resposta_tp_7)
end

/*Criação da tabela de Dimensão do oitavo tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_8' )
CREATE TABLE dbo.DIM_resp_tp_8(
	id_resposta_tp_8 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do oitavo tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_8')
			  and name='pk_DIM_resp_tp_8(id_resposta_tp_8)')
begin
ALTER TABLE dbo.DIM_resp_tp_8   
ADD CONSTRAINT [pk_DIM_resp_tp_8(id_resposta_tp_8)] PRIMARY KEY CLUSTERED (id_resposta_tp_8)
end

/*Criação da tabela de Dimensão do nôno tipo de resposta*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'DIM_resp_tp_9' )
CREATE TABLE dbo.DIM_resp_tp_9(
	id_resposta_tp_9 INT NOT NULL,
	nm_resposta		 VARCHAR(100) NOT NULL
)

/*Criação da PK da Dimensão do nôno tipo de resposta*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.DIM_resp_tp_9')
			  and name='pk_DIM_resp_tp_9(id_resposta_tp_9)')
begin
ALTER TABLE dbo.DIM_resp_tp_9   
ADD CONSTRAINT [pk_DIM_resp_tp_9(id_resposta_tp_9)] PRIMARY KEY CLUSTERED (id_resposta_tp_9)
end

/*Script de criação da tabela FATO*/
If Not Exists (Select *
			   From INFORMATION_SCHEMA.TABLES 
			   Where TABLE_SCHEMA = 'dbo' 
			   And TABLE_NAME = 'FATO_aluno' )
CREATE TABLE dbo.FATO_aluno(
	id_aluno		  INT NOT NULL,
	id_municipio	  INT,
	id_federacao	  INT,
	id_regiao		  INT,
	id_turma		  INT,
	id_escola		  INT,
	VB01002			  INT,
	VB01003			  INT,
	VB01016			  INT,
	VB03010A		  INT,
	VB04001			  INT,
	VB07004			  INT,
	VB07006			  INT,
	VB07007			  INT,
	VB07008			  INT,
	VB07009			  INT,
	VB07010			  INT,
	VB12001			  INT,
	VB12002			  INT,
	VB09003			  INT,
	VB09010			  INT
)
/*Criação da PK da tabela de alunos*/
if not exists(select 1
			  from sys.objects
			  where parent_object_id = object_id('dbo.FATO_aluno')
			  and name='pk_FATO_aluno(id_aluno)')
begin
ALTER TABLE dbo.FATO_aluno   
ADD CONSTRAINT [pk_FATO_aluno(id_aluno)] PRIMARY KEY CLUSTERED (id_aluno)
end

/*Criação da FK da tabela de Alunos com a tabela de municípios*/
if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_X_pense_municipio(id_municipio)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_X_pense_municipio(id_municipio)]
   foreign key(id_municipio) references dbo.pense_municipio(id_municipio)
end

if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_X_pense_federacao(id_federacao)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_X_pense_federacao(id_federacao)]
   foreign key(id_federacao) references dbo.pense_federacao(id_federacao)
end

if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_X_pense_regiao(id_regiao)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_X_pense_regiao(id_regiao)]
   foreign key(id_regiao) references dbo.pense_regiao(id_regiao)
end

if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB01002_X_DIM_resp_tp_1(id_resposta_tp_1)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB01002_X_DIM_resp_tp_1(id_resposta_tp_1)]
   foreign key(VB01002) references dbo.DIM_resp_tp_1(id_resposta_tp_1)
end

if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB01003_X_DIM_resp_tp_2(id_resposta_tp_2)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB01003_X_DIM_resp_tp_2(id_resposta_tp_2)]
   foreign key(VB01003) references dbo.DIM_resp_tp_2(id_resposta_tp_2)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB01016_X_DIM_resp_tp_5(id_resposta_tp_5)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB01016_X_DIM_resp_tp_5(id_resposta_tp_5)]
   foreign key(VB01016) references dbo.DIM_resp_tp_5(id_resposta_tp_5)
end

if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB03010A_X_DIM_resp_tp_3(id_resposta_tp_3)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB03010A_X_DIM_resp_tp_3(id_resposta_tp_3)]
   foreign key(VB03010A) references dbo.DIM_resp_tp_3(id_resposta_tp_3)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB04001_X_DIM_resp_tp_5(id_resposta_tp_5)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB04001_X_DIM_resp_tp_5(id_resposta_tp_5)]
   foreign key(VB04001) references dbo.DIM_resp_tp_5(id_resposta_tp_5)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB07004_X_DIM_resp_tp_7(id_resposta_tp_7)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB07004_X_DIM_resp_tp_7(id_resposta_tp_7)]
   foreign key(VB07004) references dbo.DIM_resp_tp_7(id_resposta_tp_7)
end

if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB07006_X_DIM_resp_tp_7(id_resposta_tp_7)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB07006_X_DIM_resp_tp_7(id_resposta_tp_7)]
   foreign key(VB07006) references dbo.DIM_resp_tp_7(id_resposta_tp_7)
end

if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB07007_X_DIM_resp_tp_7(id_resposta_tp_7)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB07007_X_DIM_resp_tp_7(id_resposta_tp_7)]
   foreign key(VB07007) references dbo.DIM_resp_tp_7(id_resposta_tp_7)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB07008_X_DIM_resp_tp_4(id_resposta_tp_4)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB07008_X_DIM_resp_tp_4(id_resposta_tp_4)]
   foreign key(VB07008) references dbo.DIM_resp_tp_4(id_resposta_tp_4)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB07009_X_DIM_resp_tp_5(id_resposta_tp_5)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB07009_X_DIM_resp_tp_5(id_resposta_tp_5)]
   foreign key(VB07009) references dbo.DIM_resp_tp_5(id_resposta_tp_5)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB07010_X_DIM_resp_tp_6(id_resposta_tp_6)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB07010_X_DIM_resp_tp_6(id_resposta_tp_6)]
   foreign key(VB07010) references dbo.DIM_resp_tp_6(id_resposta_tp_6)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB12002_X_DIM_resp_tp_7(id_resposta_tp_7)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB12002_X_DIM_resp_tp_7(id_resposta_tp_7)]
   foreign key(VB12002) references dbo.DIM_resp_tp_7(id_resposta_tp_7)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB12001_X_DIM_resp_tp_7(id_resposta_tp_7)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB12001_X_DIM_resp_tp_7(id_resposta_tp_7)]
   foreign key(VB12001) references dbo.DIM_resp_tp_7(id_resposta_tp_7)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB09003_X_DIM_resp_tp_9(id_resposta_tp_9)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB09003_X_DIM_resp_tp_9(id_resposta_tp_9)]
   foreign key(VB09003) references dbo.DIM_resp_tp_9(id_resposta_tp_9)
end


if not exists(select 1
   from sys.foreign_keys 
   where parent_object_id = object_id('dbo.FATO_aluno')
   and name='fk_FATO_aluno_VB09010_X_DIM_resp_tp_8(id_resposta_tp_8)')
begin
   alter table dbo.FATO_aluno with nocheck add constraint [fk_FATO_aluno_VB09010_X_DIM_resp_tp_8(id_resposta_tp_8)]
   foreign key(VB09010) references dbo.DIM_resp_tp_8(id_resposta_tp_8)
end


/*Script de carga das tabelas*/

INSERT INTO dbo.pense_regiao
(	
	id_regiao,
	nm_regiao
)
SELECT DISTINCT
	id_regiao = REGEOGR,
	nm_regiao = case REGEOGR when 1 then 'Norte'
							 when 2 then 'Nordeste'
							 when 3 then 'Sudeste' 
							 when 4 then 'Sul' 
							 when 5 then 'Centro-Oeste'
				end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.pense_federacao
(
	id_federacao,
	id_regiao,
	nm_federacao
)
SELECT DISTINCT
	id_federacao = UFCENSO,
	id_regiao	 = REGEOGR,
	nm_federacao = case UFCENSO when 11 then 'Rondonia'           
								when 12 then 'Acre'				
								when 13 then 'Amazonas'			
								when 14 then 'Roraima'			
								when 15 then 'Para'				
								when 16 then 'Amapa'				
								when 17 then 'Tocantins'			
								when 21 then 'Maranhao'			
								when 22 then 'Piaui'				
								when 23 then 'Ceara'				
								when 24 then 'Rio Grande do Norte'
								when 25 then 'Paraiba'			
								when 26 then 'Pernambuco'			
								when 27 then 'Alagoas'			
								when 28 then 'Sergipe'			
								when 29 then 'Bahia'				
								when 31 then 'Minas Gerais'		
								when 32 then 'Espirito Santo'		
								when 33 then 'Rio de Janeiro'		
								when 35 then 'Sao Paulo'			
								when 41 then 'Parana'				
								when 42 then 'Santa Catarina'		
								when 43 then 'Rio Grande do Sul'	
								when 50 then 'Mato Grosso do Sul'	
								when 51 then 'Mato Grosso'		
								when 52 then 'Goias'				
								when 53 then 'Distrito Federal'	
					end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.pense_municipio
(
	id_municipio,		
	nm_municipio,		
	fl_municipio_capital,
	id_federacao
)
SELECT DISTINCT		
	id_municipio = MUNICIPIO_CAP,
	nm_municipio = case MUNICIPIO_CAP 
									  when 1100205 then 'Porto Velho'     
									  when 1200401 then 'Rio Branco'		
									  when 1302603 then 'Manaus'			
									  when 1400100 then 'Boa Vista'			
									  when 1501402 then 'Belem'				
									  when 1600303 then 'Macapa'			
									  when 1721000 then 'Palmas'			
									  when 2111300 then 'Sao Luis'			
									  when 2211001 then 'Teresina'			
									  when 2304400 then 'Fortaleza'			
									  when 2408102 then 'Natal'				
									  when 2507507 then 'Joao Pessoa'		
									  when 2611606 then 'Recife'			
									  when 2704302 then 'Maceio'			
									  when 2800308 then 'Aracaju'			
									  when 2927408 then 'Salvador'			
									  when 3106200 then 'Belo Horizonte'	
									  when 3205309 then 'Vitoria'			
									  when 3304557 then 'Rio de Janeiro'	
									  when 3550308 then 'Sao Paulo'			
									  when 4106902 then 'Curitiba'			
									  when 4205407 then 'Florianopolis'		
									  when 4314902 then 'Porto Alegre'		
									  when 5002704 then 'Campo Grande'		
									  when 5103403 then 'Cuiaba'			
									  when 5208707 then 'Goiania'			
									  when 5300108 then 'Distrito Federal'
					end,
	fl_municipio_capital = TIPO_MUNIC,
	id_federacao		 = UFCENSO
FROM dbo.PENSE_AMOSTRA1_ALUNO
where MUNICIPIO_CAP <> 0
select * from dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.pense_municipio
(
	id_municipio,
	nm_municipio,
	id_federacao,
	fl_municipio_capital
)
VALUES
(6000001,'Nao é Capital do Amazonas', 13, 2),
(6000002,'Nao é Capital do Tocantins', 17, 2),
(6000003,'Nao é Capital do Maranhão', 21, 2),
(6000004,'Nao é Capital do Piauí', 22, 2),
(6000005,'Nao é Capital do Ceará', 23, 2),
(6000006,'Nao é Capital do Rio Grande do Norte', 24, 2),
(6000007,'Nao é Capital do Paraná', 41, 2),
(6000008,'Nao é Capital de Santa Catarina', 42, 2),
(6000009,'Nao é Capital do Acre', 12, 2),
(6000010,'Nao é Capital de Roraima', 14, 2),
(6000011,'Nao é Capital do Sergipe', 28, 2),
(6000012,'Nao é Capital da Bahia', 29, 2),
(6000013,'Nao é Capital do Rio de Janeiro', 33, 2),
(6000014,'Nao é Capital do Para', 15, 2),
(6000015,'Nao é Capital do Amapá', 16, 2),
(6000016,'Nao é Capital de Pernambuco', 26, 2),
(6000017,'Nao é Capital do Mato Grosso do Sul', 50, 2),
(6000018,'Não é Capital do Espirito Santo',32,2),
(6000019,'Não é Capital de Goiás',52,2),
(6000020,'Não é Capital de Rondônia',11,2),
(6000021,'Não é Capital de Mato Grosso',51,2),
(6000022,'Não é Capital de São Paulo',35,2),
(6000023,'Não é Capital da Paraíba',25,2),
(6000024,'Não é Capital de Alagoas',27,2),
(6000025,'Não é Capital de Minas Gerais',31,2),
(6000026,'Não é Capital do Rio Grande do Sul',43,2)

INSERT INTO dbo.pense_escola
(
	id_escola
)
SELECT DISTINCT 
	id_escola = escola 
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.pense_turma
(
	id_turma,
	id_escola
)
SELECT DISTINCT
	id_turma  = turma,
	id_escola = escola 
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.pense_aluno
(
	id_aluno,	
	id_municipio,
	id_turma
)	
SELECT DISTINCT
	id_aluno = aluno, 
	id_municipio = case when MUNICIPIO_CAP = 0 AND UFCENSO = 13 THEN 6000001
						when MUNICIPIO_CAP = 0 AND UFCENSO = 17 THEN 6000002
						when MUNICIPIO_CAP = 0 AND UFCENSO = 21 THEN 6000003
						when MUNICIPIO_CAP = 0 AND UFCENSO = 22 THEN 6000004
						when MUNICIPIO_CAP = 0 AND UFCENSO = 23 THEN 6000005
						when MUNICIPIO_CAP = 0 AND UFCENSO = 24 THEN 6000006
						when MUNICIPIO_CAP = 0 AND UFCENSO = 41 THEN 6000007
						when MUNICIPIO_CAP = 0 AND UFCENSO = 42 THEN 6000008
						when MUNICIPIO_CAP = 0 AND UFCENSO = 12 THEN 6000009
						when MUNICIPIO_CAP = 0 AND UFCENSO = 14 THEN 6000010
						when MUNICIPIO_CAP = 0 AND UFCENSO = 28 THEN 6000011
						when MUNICIPIO_CAP = 0 AND UFCENSO = 29 THEN 6000012
						when MUNICIPIO_CAP = 0 AND UFCENSO = 33 THEN 6000013
						when MUNICIPIO_CAP = 0 AND UFCENSO = 15 THEN 6000014
						when MUNICIPIO_CAP = 0 AND UFCENSO = 16 THEN 6000015
						when MUNICIPIO_CAP = 0 AND UFCENSO = 26 THEN 6000016
						when MUNICIPIO_CAP = 0 AND UFCENSO = 50 THEN 6000017
						when MUNICIPIO_CAP = 0 AND UFCENSO = 32 THEN 6000018
						when MUNICIPIO_CAP = 0 AND UFCENSO = 52 THEN 6000019
						when MUNICIPIO_CAP = 0 AND UFCENSO = 11 THEN 6000020
						when MUNICIPIO_CAP = 0 AND UFCENSO = 51 THEN 6000021
						when MUNICIPIO_CAP = 0 AND UFCENSO = 35 THEN 6000022
						when MUNICIPIO_CAP = 0 AND UFCENSO = 25 THEN 6000023
						when MUNICIPIO_CAP = 0 AND UFCENSO = 27 THEN 6000024
						when MUNICIPIO_CAP = 0 AND UFCENSO = 31 THEN 6000025
						when MUNICIPIO_CAP = 0 AND UFCENSO = 43 THEN 6000026
						ELSE MUNICIPIO_CAP
					END,
	id_turma = turma
FROM PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.pense_aluno_resposta
(
	id_aluno,		 
	VB01002,			 
	VB01003,			 
	VB01016,		 
	VB03010A,		 
	VB04001,			 
	VB07004,			 
	VB07006,			 
	VB07007,			 
	VB07008,			 
	VB07009,			 
	VB07010,			 
	VB12001,			 
	VB12002,			 
	VB09003,			 
	VB09010
)
SELECT DISTINCT
	id_aluno = aluno,
	VB01002  = VB01002,
	VB01003  = VB01003,
	VB01016  = VB01016,
	VB03010A = VB03010A,
	VB04001  = VB04001,
	VB07004  = VB07004,
	VB07006  = VB07006,
	VB07007  = VB07007,
	VB07008  = VB07008,
	VB07009  = VB07009,
	VB07010  = VB07010,
	VB12001  = VB12001,
	VB12002  = VB12002,
	VB09003  = VB09003,
	VB09010  = VB09010
from dbo.PENSE_AMOSTRA1_ALUNO


INSERT INTO dbo.DIM_resp_tp_1
(
	id_resposta_tp_1,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_1 = case when VB01002 = 1  then 1
							when VB01002 = 2  then 2
							when VB01002 = 3  then 3
							when VB01002 = 4  then 4
							when VB01002 = 5  then 5
							when VB01002 = 99 then 99
						end,
	nm_resposta = case 
					when VB01002 = 1  then 'Branca'
				  	when VB01002 = 2  then 'Preta'
				  	when VB01002 = 3  then 'Amarela'
				  	when VB01002 = 4  then 'Parda'
				  	when VB01002 = 5  then 'Indígena'
				  	when VB01002 = 99 then 'Não informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_2
(
	id_resposta_tp_2,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_2 = case when VB01003 = 11 then 11
							when VB01003 = 12 then 12
							when VB01003 = 13 then 13
							when VB01003 = 14 then 14
							when VB01003 = 15 then 15
							when VB01003 = 16 then 16
							when VB01003 = 17 then 17
							when VB01003 = 18 then 18
							when VB01003 = 19 then 19
						end,
	nm_resposta = case 
					when VB01003 = 11 then '11 anos ou menos'
				  	when VB01003 = 12 then '12 anos'
				  	when VB01003 = 13 then '13 anos'
				  	when VB01003 = 14 then '14 anos'
				  	when VB01003 = 15 then '15 anos'
				  	when VB01003 = 16 then '16 anos'
					when VB01003 = 17 then '17 anos'
					when VB01003 = 18 then '18 anos'
					when VB01003 = 19 then '19 anos ou mais'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_3
(
	id_resposta_tp_3,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_3 = case when VB03010A = 1  then 1 
							when VB03010A = 2  then 2 
							when VB03010A = 3  then 3 
							when VB03010A = 4  then 4 
							when VB03010A = 5  then 5 
							when VB03010A = 6  then 6 
							when VB03010A = 7  then 7 
							when VB03010A = 8  then 8 
							when VB03010A = 9  then 9 
							when VB03010A = 99 then 99
						end,
	nm_resposta = case 
					when VB03010A = 1  then 'Até 1 hora por dia'
				  	when VB03010A = 2  then 'Mais de 1 hora até 2 horas por dia'
				  	when VB03010A = 3  then 'Mais de 2 horas até 3 horas por dia'
				  	when VB03010A = 4  then 'Mais de 3 horas até 4 horas por dia'
				  	when VB03010A = 5  then 'Mais de 4 horas até 5 horas por dia'
				  	when VB03010A = 6  then 'Mais de 5 horas até 6 horas por dia'
				  	when VB03010A = 7  then 'Mais de 6 horas até 7 horas por dia'
					when VB03010A = 8  then 'Mais de 7 horas até 8 horas por dia'
					when VB03010A = 9  then 'Mais de 8 horas por dia'
					when VB03010A = 99 then 'Não informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_4
(
	id_resposta_tp_4,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_4 = case when VB07008 = -1   then -1  
							when VB07008 =  1   then  1  
							when VB07008 =  2   then  2  
							when VB07008 =  3   then  3  
							when VB07008 =  4   then  4  
							when VB07008 =  5   then  5  
							when VB07008 =  6   then  6  
							when VB07008 =  7   then  7  
							when VB07008 =  99  then  99 
						end,
	nm_resposta = case 
					when VB07008 = -1   then 'Pulo no questionário'
				  	when VB07008 =  1   then 'A minha cor ou raça'
				  	when VB07008 =  2   then 'A minha religião'
				  	when VB07008 =  3   then 'A aparência do meu rosto'
				  	when VB07008 =  4   then 'A aparência do meu corpo'
				  	when VB07008 =  5   then 'A minha orientação sexual'
				  	when VB07008 =  6   then 'A minha região de origem'
					when VB07008 =  7   then 'Outros motivos/causas'
					when VB07008 =  99  then 'Não informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_5
(
	id_resposta_tp_5,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_5 = case when VB07009 =  1   then  1  
							when VB07009 =  2   then  2  
							when VB07009 =  99  then  99  
						end,
	nm_resposta = case 
					when VB07009 =  1    then 'Sim'
				  	when VB07009 =  2    then 'Não'
				  	when VB07009 =  99   then 'Não Informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_6
(
	id_resposta_tp_6,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_6 = case when VB07010 =  1   then  1  
							when VB07010 =  2   then  2  
							when VB07010 =  3   then  3
							when VB07010 =  99  then  99  
						end,
	nm_resposta = case 
					when VB07010 =  1    then 'Sim'
				  	when VB07010 =  2    then 'Não'
				  	when VB07010 =  3    then 'Não sei o que é bullying'
					when VB07010 =  99   then 'Não informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_7
(
	id_resposta_tp_7,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_7 = case when VB12002 = 1  then 1
							when VB12002 = 2  then 2
							when VB12002 = 3  then 3
							when VB12002 = 4  then 4
							when VB12002 = 5  then 5
							when VB12002 = 99 then 99
						end,
	nm_resposta = case 
					when VB12002 = 1  then 'Nunca'
				  	when VB12002 = 2  then 'Raramente'
				  	when VB12002 = 3  then 'Às vezes'
				  	when VB12002 = 4  then 'Na maioria das vezes'
				  	when VB12002 = 5  then 'Sempre'
				  	when VB12002 = 99 then 'Não informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_8
(
	id_resposta_tp_8,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_8 = case when VB09010 = 1  then 1 
							when VB09010 = 2  then 2 
							when VB09010 = 3  then 3 
							when VB09010 = 4  then 4 
							when VB09010 = 5  then 5 
							when VB09010 = 6  then 6 
							when VB09010 = 7  then 7 
							when VB09010 = 8  then 8 
							when VB09010 = 99 then 99
						end,
	nm_resposta = case 
					when VB09010 = 1  then 'Nenhuma vez nos últimos 12 meses (0 vez)'
				  	when VB09010 = 2  then '1 vez nos últimos 12 meses'
				  	when VB09010 = 3  then '2 a 3 vezes nos últimos 12 meses'
				  	when VB09010 = 4  then '4 a 5 vezes nos últimos 12 meses'
				  	when VB09010 = 5  then '6 a 7 vezes nos últimos 12 meses'
				  	when VB09010 = 6  then '8 a 9 vezes nos últimos 12 meses'
				  	when VB09010 = 7  then '10 a 11 vezes nos últimos 12 meses'
					when VB09010 = 8  then '12 ou mais nos últimos 12 meses'
					when VB09010 = 99 then 'Não informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO

INSERT INTO dbo.DIM_resp_tp_9
(
	id_resposta_tp_9,
	nm_resposta
)
SELECT DISTINCT
	id_resposta_tp_9 = case when VB09003 = 1  then 1 
							when VB09003 = 2  then 2 
							when VB09003 = 3  then 3 
							when VB09003 = 4  then 4 
							when VB09003 = 5  then 5 
							when VB09003 = 6  then 6 
							when VB09003 = 7  then 7 
							when VB09003 = 8  then 8 
							when VB09003 = 99 then 99
						end,
	nm_resposta = case 
					when VB09003 = 1  then 'Nenhuma vez nos últimos 30 dias (0 vez)'
				  	when VB09003 = 2  then '1 vez nos últimos 30 dias'
				  	when VB09003 = 3  then '2 a 3 vezes nos últimos 30 dias'
				  	when VB09003 = 4  then '4 a 5 vezes nos últimos 30 dias'
				  	when VB09003 = 5  then '6 a 7 vezes nos últimos 30 dias'
				  	when VB09003 = 6  then '8 a 9 vezes nos últimos 30 dias'
				  	when VB09003 = 7  then '10 a 11 vezes nos últimos 30 dias'
					when VB09003 = 8  then '12 ou mais nos últimos 30 dias'
					when VB09003 = 99 then 'Não informado'
				  end
FROM dbo.PENSE_AMOSTRA1_ALUNO


INSERT INTO dbo.FATO_aluno
(	
	id_aluno,	
	id_municipio,
	id_federacao,
	id_regiao,	
	id_turma,	
	id_escola,	
	VB01002,		
	VB01003,		
	VB01016,		
	VB03010A,	
	VB04001,		
	VB07004,		
	VB07006,		
	VB07007,		
	VB07008,		
	VB07009,		
	VB07010,	
	VB12001,		
	VB12002,		
	VB09003,		
	VB09010		
)
SELECT DISTINCT
	id_aluno     = pa.id_aluno,
	id_municipio = pa.id_municipio,
	id_federacao = pf.id_federacao,
	id_regiao    = pr.id_regiao,
	id_turma	 = pa.id_turma,
	id_escola    = pe.id_escola,
	VB01002		 = par.VB01002,
	VB01003		 = par.VB01003,
	VB01016		 = par.VB01016,
	VB03010A	 = par.VB03010A,
	VB04001		 = par.VB04001,
	VB07004		 = par.VB07004,
	VB07006		 = par.VB07006,
	VB07007		 = par.VB07007,
	VB07008		 = par.VB07008,
	VB07009		 = par.VB07009,
	VB07010		 = par.VB07010,
	VB12001		 = par.VB12001,
	VB12002		 = par.VB12002,
	VB09003		 = par.VB09003,
	VB09010		 = par.VB09010
FROM dbo.pense_aluno pa
JOIN dbo.pense_municipio pm
	ON pa.id_municipio = pm.id_municipio
JOIN dbo.pense_federacao pf
	ON pm.id_federacao = pf.id_federacao
JOIN dbo.pense_regiao pr
	ON pf.id_regiao = pr.id_regiao
JOIN dbo.pense_aluno_resposta par
	ON pa.id_aluno = par.id_aluno
JOIN dbo.pense_turma pt
	ON pa.id_turma = pt.id_turma
JOIN dbo.pense_escola pe
	ON pt.id_escola = pe.id_escola

