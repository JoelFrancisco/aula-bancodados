CREATE TABLE aluno (
	id_aluno int IDENTITY not null,
	nm_aluno varchar(50) not null,
	email varchar(50) not null,
)
go

CREATE TABLE avaliacao (
	id_avaliacao int IDENTITY not null,
	dt_abertura datetime not null,
	dt_fechamento datetime not null,
)
go

CREATE TABLE avaliacao_aluno (
	id_avaliacao_aluno int IDENTITY not null,
	id_avaliacao int not null,
	id_aluno int not null,
	dt_inicio  datetime not null,
	dt_fim datetime not null,
)
go

CREATE TABLE resposta_aberta (
	id_resposta_aberta int IDENTITY not null,
	id_avaliacao_aluno int not null,
	id_questao_item int not null,
	ds_resposta_aberta varchar(max) not null,
)
go

CREATE TABLE resposta_fechada (
	id_resposta_fechada int IDENTITY not null,
	id_questao_item int not null,
	id_avaliacao_aluno int not null,
	dt_resposta datetime not null,
)
go

CREATE TABLE questao (
	id_questao int IDENTITY not null,
	id_avaliacao int not null,
	ds_questao varchar(max) not null,
	tp_questao int not null,
)
go

CREATE TABLE questao_item (
	id_questao_item int IDENTITY not null,
	id_questao int not null,
	nm_questao_item varchar(max) not null,
	is_correta bit not null,
)
go

-- pks

ALTER TABLE aluno
	ADD CONSTRAINT pk_aluno
	PRIMARY KEY (id_aluno)
GO

ALTER TABLE avaliacao
	ADD CONSTRAINT pk_avaliacao
	PRIMARY KEY (id_avaliacao)
GO

ALTER TABLE avaliacao_aluno
	ADD CONSTRAINT pk_avaliacao_aluno
	PRIMARY KEY (id_avaliacao_aluno)
GO

ALTER TABLE resposta_aberta
	ADD CONSTRAINT pk_resposta_aberta
	PRIMARY KEY (id_resposta_aberta)
GO

ALTER TABLE resposta_fechada
	ADD CONSTRAINT pk_resposta_fechada
	PRIMARY KEY (id_resposta_fechada)
GO

ALTER TABLE questao
	ADD CONSTRAINT pk_questao
	PRIMARY KEY (id_questao)
GO

ALTER TABLE questao_item
	ADD CONSTRAINT pk_questao_item
	PRIMARY KEY (id_questao_item)
GO

-- fks

ALTER TABLE avaliacao_aluno
	ADD CONSTRAINT fk_avaliacao_aluno_1
	FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id_avaliacao);
GO

ALTER TABLE avaliacao_aluno
	ADD CONSTRAINT fk_avaliacao_aluno_2
	FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno);
GO

ALTER TABLE resposta_fechada
	ADD CONSTRAINT fk_resposta_fechada_1
	FOREIGN KEY (id_avaliacao_aluno) REFERENCES avaliacao_aluno(id_avaliacao_aluno);
GO

ALTER TABLE resposta_fechada
	ADD CONSTRAINT fk_resposta_fechada_2
	FOREIGN KEY (id_questao_item) REFERENCES questao_item(id_questao_item);
GO

ALTER TABLE resposta_aberta
	ADD CONSTRAINT fk_resposta_aberta_1
	FOREIGN KEY (id_questao_item) REFERENCES questao_item(id_questao_item);
GO

ALTER TABLE resposta_aberta
	ADD CONSTRAINT fk_resposta_aberta_2
	FOREIGN KEY (id_avaliacao_aluno) REFERENCES avaliacao_aluno(id_avaliacao_aluno);
GO

ALTER TABLE questao_item
	ADD CONSTRAINT fk_item_questao_1
	FOREIGN KEY (id_questao) REFERENCES questao(id_questao);
GO

ALTER TABLE questao
	ADD CONSTRAINT fk_questao_1
	FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id_avaliacao);
GO

-- checks

ALTER TABLE questao
	ADD CONSTRAINT chk_tp_questao
	CHECK (tp_questao in (1,2,3))
GO

