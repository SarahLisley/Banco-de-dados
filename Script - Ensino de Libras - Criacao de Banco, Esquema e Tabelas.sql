CREATE DATABASE ensino_de_libras;
	
CREATE SCHEMA ensino_de_libras
    AUTHORIZATION postgres;

SET SCHEMA 'ensino_de_libras';

CREATE TABLE Niveis (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL UNIQUE,
	descricao VARCHAR(200) NOT NULL,
	status VARCHAR(50) NOT NULL
);

CREATE TABLE Modulos (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	descricao VARCHAR(200) NOT NULL,
	status VARCHAR(50) NOT NULL,
	id_nivel INT NOT NULL,
	FOREIGN KEY (id_nivel) REFERENCES Niveis(id),
	UNIQUE (id_nivel, nome) -- Para cada nível, os módulos devem ter nomes únicos
);

CREATE TABLE Unidades (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	descricao VARCHAR(200) NOT NULL,
	status VARCHAR(50) NOT NULL,
	id_modulo INT NOT NULL,
	FOREIGN KEY (id_modulo) REFERENCES Modulos(id),
	UNIQUE (id_modulo, nome) -- Para cada módulo, as unidades devem ter nomes únicos
);

CREATE TABLE Usuarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(100) NOT NULL,
	data_nascimento DATE NOT NULL,
	nivel_inicial VARCHAR(50),
	foto_perfil TEXT,
	FOREIGN KEY (nivel_inicial) REFERENCES Niveis(nome)
);

CREATE TABLE Progresso_nos_Niveis (
    id_usuario INT NOT NULL,
    id_nivel INT NOT NULL,
    data_conclusao DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_nivel) REFERENCES Niveis(id),
    UNIQUE (id_usuario, id_nivel) -- Cada usuário só pode concluir um nível uma vez
);

CREATE TABLE Progresso_nos_Modulos (
    id_usuario INT NOT NULL,
    id_modulo INT NOT NULL,
    data_conclusao DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_modulo) REFERENCES Modulos(id),
    UNIQUE (id_usuario, id_modulo) -- Cada usuário só pode concluir um módulo uma vez
);

CREATE TABLE Progresso_nas_Unidades (
    id_usuario INT NOT NULL,
    id_unidade INT NOT NULL,
    data_conclusao DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_unidade) REFERENCES Unidades(id),
    UNIQUE (id_usuario, id_unidade) -- Cada usuário só pode concluir uma unidade uma vez
);

CREATE TABLE Desafios (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
	descricao VARCHAR(200) NOT NULL,
	tempo_limite VARCHAR(50) NOT NULL,
	id_modulo INT NOT NULL,
	FOREIGN KEY (id_modulo) REFERENCES Modulos(id)
);

CREATE TABLE Videos (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
	url_video TEXT NOT NULL UNIQUE, -- Adicionar URL do vídeo
	descricao VARCHAR(200) NOT NULL,
	nivel_dificuldade VARCHAR(50) NOT NULL,
	id_unidade INT NOT NULL,
	FOREIGN KEY (id_unidade) REFERENCES Unidades(id) -- Uma unidade é composta por um ou mais vídeos
);

CREATE TABLE Exercicios (
	id SERIAL PRIMARY KEY,
	pontuacao_total INT NOT NULL,
	categoria VARCHAR(100) NOT NULL,
	id_unidade INT NOT NULL,
	FOREIGN KEY (id_unidade) REFERENCES Unidades(id)
);

CREATE TABLE Questionarios (
	id SERIAL PRIMARY KEY,
	tempo_limite INT NOT NULL,
	pontuacao_total INT NOT NULL,
	id_unidade INT NOT NULL,
	FOREIGN KEY (id_unidade) REFERENCES Unidades(id)
);

CREATE TABLE Questoes (
	id SERIAL PRIMARY KEY,
	pergunta VARCHAR(200) NOT NULL,
	opcao_1 VARCHAR(100) NOT NULL,
	opcao_2 VARCHAR(100) NOT NULL,
	opcao_3 VARCHAR(100) NOT NULL,
	opcao_4 VARCHAR(100) NOT NULL,
	opcao_correta VARCHAR(100) NOT NULL,
	id_exercicio INT NOT NULL, -- Questão pertence a um exercício
	id_questionario INT, -- Questão pode pertencer a um questionário
	FOREIGN KEY (id_exercicio) REFERENCES Exercicios(id),
	FOREIGN KEY (id_questionario) REFERENCES Questionarios(id)
)

CREATE TABLE Respostas_do_Usuario (
	id_usuario INT NOT NULL,
	id_questao INT NOT NULL,
	resposta_usuario VARCHAR(100) NOT NULL,
	data_resposta TIMESTAMP NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
	FOREIGN KEY (id_questao) REFERENCES Questoes(id),
	UNIQUE (id_usuario, id_questao)
);

CREATE TABLE Certificados (
	id SERIAL PRIMARY KEY,
	nivel_concluido VARCHAR(50) NOT NULL,
	data_conclusao DATE NOT NULL,
	codigo_autenticacao VARCHAR(100) NOT NULL UNIQUE,
	id_usuario INT NOT NULL,
	FOREIGN KEY (nivel_concluido) REFERENCES Niveis(nome),
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Conquistas (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL UNIQUE,
	descricao VARCHAR(200) NOT NULL,
	data_obtida DATE NOT NULL,
	url_imagem_conquista TEXT NOT NULL UNIQUE,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE FeedBacks (
	id SERIAL PRIMARY KEY,
	descricao VARCHAR(200) NOT NULL,
	categoria VARCHAR(100) NOT NULL,
	data_envio DATE NOT NULL,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Notificacoes (
	id SERIAL PRIMARY KEY,
	descricao VARCHAR(200) NOT NULL,
	horario_preferivel TIME NOT NULL,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Sinais (
	id SERIAL PRIMARY KEY,
	significado VARCHAR(200) NOT NULL,
	categoria VARCHAR(50) NOT NULL,
	exemplo_uso VARCHAR(200),
	url_imagem TEXT NOT NULL UNIQUE
);

CREATE TABLE Artigos_de_Ajuda (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(100) NOT NULL,
	descricao VARCHAR(200) NOT NULL,
	categoria VARCHAR(100) NOT NULL -- Categoria = Dúvidas
);