-- Criação da tabela de Usuários
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    nivel_inicial VARCHAR(50),
    foto_perfil BYTEA
);

-- Criação da tabela de Níveis
CREATE TABLE Nivel (
    id_nivel SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    status VARCHAR(50)
);

-- Criação da tabela de Módulos
CREATE TABLE Modulo (
    id_modulo SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    status VARCHAR(50),
    id_nivel INT NOT NULL,
    FOREIGN KEY (id_nivel) REFERENCES Nivel(id_nivel)
);

-- Criação da tabela de Unidades
CREATE TABLE Unidade (
    id_unidade SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    conteudo TEXT,
    status VARCHAR(50),
    id_modulo INT NOT NULL,
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo)
);

-- Criação da tabela de Exercícios
CREATE TABLE Exercicio (
    id_exercicio SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    descricao TEXT,
    pontuacao_maxima INT,
    id_unidade INT NOT NULL,
    FOREIGN KEY (id_unidade) REFERENCES Unidade(id_unidade)
);

-- Criação da tabela de Questionários
CREATE TABLE Questionario (
    id_quiz SERIAL PRIMARY KEY,
    id_unidade INT NOT NULL,
    pergunta TEXT,
    opcoes_resposta TEXT[],
    resposta_correta TEXT,
    tempo_limite INT,
    pontuacao_total INT,
    FOREIGN KEY (id_unidade) REFERENCES Unidade(id_unidade)
);

-- Criação da tabela de Sinal
CREATE TABLE Sinal (
    id_sinal SERIAL PRIMARY KEY,
    significado_sinal TEXT,
    imagem_sinal BYTEA,
    categoria VARCHAR(255)
);

-- Criação da tabela de Vídeos
CREATE TABLE Video (
    id_video SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    descricao TEXT,
    nivel_dificuldade VARCHAR(50),
    id_modulo INT NOT NULL,
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo)
);

-- Criação da tabela de Conquistas
CREATE TABLE Conquista (
    id_conquista SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    descricao TEXT,
    imagem BYTEA,
    data_obtida DATE
);

-- Criação da tabela de Desafios
CREATE TABLE Desafio (
    id_desafio SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    descricao TEXT,
    tempo_limite INT,
    id_modulo INT NOT NULL,
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo)
);

-- Criação da tabela de Artigos de Ajuda
CREATE TABLE ArtigoAjuda (
    id_artigo SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    conteudo TEXT,
    categoria VARCHAR(255)
);

-- Criação da tabela de Feedback
CREATE TABLE Feedback (
    id_feedback SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    categoria VARCHAR(50),
    descricao TEXT,
    data_envio DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Criação da tabela de Notificações
CREATE TABLE Notificacao (
    id_notificacao SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    descricao TEXT,
    horario_envio_preferivel TIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    tema varchar(255)
);

-- Criação da tabela de Certificados
CREATE TABLE Certificado (
    id_certificado SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    nivel_concluido VARCHAR(255),
    data_conclusao DATE,
    codigo_autenticacao VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

--Relacionamentos Muitos-para-Muitos:

--Questão <-> Usuário: O relacionamento entre Questão (dentro de Questionario) e Usuário (através da interação "responde") é de muitos-para-muitos. É necessário criar uma tabela intermediária.

--Módulo <-> Desafio: O relacionamento entre Módulo e Desafio é de muitos-para-muitos. É necessário criar uma tabela intermediária.

--Módulo <-> Video: O relacionamento entre Módulo e Video é de muitos-para-muitos. É necessário criar uma tabela intermediária.

--Unidade <-> Exercicio: O relacionamento entre Unidade e Exercicio é de muitos-para-muitos. É necessário criar uma tabela intermediária.

--Ação: Crie as tabelas intermediárias: Usuario_Questao, Modulo_Desafio, Modulo_Video, Unidade_Exercicio

-- Tabela para o relacionamento N:N entre Usuário e Questão
CREATE TABLE Usuario_Questao (
    id_usuario INT NOT NULL,
    id_quiz INT NOT NULL,
    resposta_usuario TEXT, -- Armazena a resposta do usuário
    data_resposta TIMESTAMP, -- Armazena a data e hora da resposta
    PRIMARY KEY (id_usuario, id_quiz),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_quiz) REFERENCES Questionario(id_quiz)
);

-- Tabela para o relacionamento N:N entre Módulo e Desafio
CREATE TABLE Modulo_Desafio (
    id_modulo INT NOT NULL,
    id_desafio INT NOT NULL,
    PRIMARY KEY (id_modulo, id_desafio),
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo),
    FOREIGN KEY (id_desafio) REFERENCES Desafio(id_desafio)
);

    -- Tabela para o relacionamento N:N entre Módulo e Video
CREATE TABLE Modulo_Video (
    id_modulo INT NOT NULL,
    id_video INT NOT NULL,
    PRIMARY KEY (id_modulo, id_video),
    FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo),
    FOREIGN KEY (id_video) REFERENCES Video(id_video)
);

-- Tabela para o relacionamento N:N entre Unidade e Exercício
CREATE TABLE Unidade_Exercicio (
    id_unidade INT NOT NULL,
    id_exercicio INT NOT NULL,
    PRIMARY KEY (id_unidade, id_exercicio),
    FOREIGN KEY (id_unidade) REFERENCES Unidade(id_unidade),
    FOREIGN KEY (id_exercicio) REFERENCES Exercicio(id_exercicio)
);

--Relacionamento Questão <-> Sinal:
--Falta: A conexão entre a tabela Questao (embutida na tabela Questionario) e a tabela Sinal não está implementada.
--Ação: Crie uma tabela intermediária entre Questionario e Sinal:

CREATE TABLE Questao_Sinal (
    id_quiz INT NOT NULL,
    id_sinal INT NOT NULL,
    PRIMARY KEY (id_quiz, id_sinal),
    FOREIGN KEY (id_quiz) REFERENCES Questionario(id_quiz),
    FOREIGN KEY (id_sinal) REFERENCES Sinal(id_sinal)
);
