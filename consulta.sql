-- SCHEMA: entrega02

-- DROP SCHEMA IF EXISTS entrega02 ;

CREATE SCHEMA IF NOT EXISTS public
    AUTHORIZATION postgres;

select * from usuario

INSERT INTO public.usuario (id_usuario, nome, email, senha, data_nascimento, nivel_inicial, foto_perfil) VALUES
    (1, 'Alice Silva', 'alice@email.com', 'senha123', '1995-08-10', 'Iniciante', NULL),
    (2, 'Bruno Souza', 'bruno@email.com', 'senha123', '1990-05-20', 'Intermediário', NULL),
    (3, 'Carla Mendes', 'carla@email.com', 'senha123', '1985-12-01', 'Avançado', NULL),
    (4, 'Daniel Oliveira', 'daniel@email.com', 'senha123', '2000-06-15', 'Iniciante', NULL),
    (5, 'Eduarda Lima', 'eduarda@email.com', 'senha123', '1998-03-22', 'Iniciante', NULL),
    (6, 'Fernando Rocha', 'fernando@email.com', 'senha123', '1993-07-19', 'Intermediário', NULL),
    (7, 'Gabriela Nunes', 'gabriela@email.com', 'senha123', '1997-11-30', 'Avançado', NULL),
    (8, 'Henrique Santos', 'henrique@email.com', 'senha123', '1992-09-25', 'Intermediário', NULL),
    (9, 'Isabela Castro', 'isabela@email.com', 'senha123', '2001-02-14', 'Iniciante', NULL),
    (10,'João Pereira', 'joao@email.com', 'senha123', '1996-10-05', 'Intermediário', NULL);

CREATE TABLE public.Usuarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(100) NOT NULL,
	data_nascimento DATE NOT NULL,
	nivel_inicial VARCHAR(50),
	foto_perfil TEXT,
	FOREIGN KEY (nivel_inicial) REFERENCES Niveis(nome)
);

DELETE FROM  public.usuario;