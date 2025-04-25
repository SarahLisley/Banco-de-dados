-- SCHEMA: kanban

-- DROP SCHEMA IF EXISTS kanban ;

--01:
CREATE SCHEMA IF NOT EXISTS kanban
    AUTHORIZATION postgres;

--02:
CREATE TABLE public.users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE
);

-- Tabela boards
CREATE TABLE public.boards (
    board_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_by INTEGER REFERENCES public.users(user_id),
    created_at TIMESTAMP WITH TIME ZONE
);

-- Tabela lists
CREATE TABLE public.lists (
    list_id SERIAL PRIMARY KEY,
    board_id INTEGER NOT NULL REFERENCES public.boards(board_id),
    name VARCHAR(100) NOT NULL,
    position INTEGER,
    created_at TIMESTAMP WITH TIME ZONE
);

-- Tabela cards
CREATE TABLE public.cards (
    card_id SERIAL PRIMARY KEY,
    list_id INTEGER NOT NULL REFERENCES public.lists(list_id),
    title VARCHAR(100) NOT NULL,
    description TEXT,
    position INTEGER,
    due_date DATE,
    assigned_to INTEGER REFERENCES public.users(user_id), -- assuming this refers to user
    created_at TIMESTAMP WITH TIME ZONE
);

-- Tabela comments
CREATE TABLE public.comments (
    comment_id SERIAL PRIMARY KEY,
    card_id INTEGER NOT NULL REFERENCES public.cards(card_id),
    user_id INTEGER NOT NULL REFERENCES public.users(user_id),
    content TEXT,
    created_at TIMESTAMP WITH TIME ZONE
);

--03:
INSERT INTO public.users (username, email, password_hash) VALUES
('joao_silva', 'joao.silva@email.com', 'senha123'),
('maria_souza', 'maria.souza@email.com', 'senha456'),
('carlos_oliveira', 'carlos.oliveira@email.com', 'senha789'),
('ana_pereira', 'ana.pereira@email.com', 'senhaabc'),
('pedro_santos', 'pedro.santos@email.com', 'senhaxyz');

-- Inserir dados na tabela boards
INSERT INTO public.boards (name, description, created_by) VALUES
('Projeto A', 'Descrição do Projeto A', 1),
('Projeto B', 'Descrição do Projeto B', 1),
('Projeto C', 'Descrição do Projeto C', 2),
('Projeto D', 'Descrição do Projeto D', 3),
('Projeto E', 'Descrição do Projeto E', 4);

-- Inserir dados na tabela lists
INSERT INTO public.lists (board_id, name, position) VALUES
(1, 'A Fazer', 1),
(1, 'Em Andamento', 2),
(2, 'Concluído', 3),
(3, 'Pendências', 1),
(4, 'Backlog', 1);

-- Inserir dados na tabela cards
INSERT INTO public.cards (list_id, title, description, position, due_date, assigned_to) VALUES
(1, 'Tarefa 1', 'Implementar funcionalidade X', 1, '2024-01-30', 2),
(1, 'Tarefa 2', 'Corrigir bug Y', 2, '2024-02-15', 1),
(2, 'Tarefa 3', 'Testar integração Z', 1, '2024-03-01', 3),
(3, 'Tarefa 4', 'Documentar API', 1, '2024-02-28', 4),
(4, 'Tarefa 5', 'Refatorar código', 1, '2024-03-15', 5);

-- Inserir dados na tabela comments
INSERT INTO public.comments (card_id, user_id, content) VALUES
(1, 2, 'Comentário sobre a tarefa 1'),
(1, 1, 'Outro comentário sobre a tarefa 1'),
(2, 3, 'Comentário sobre a tarefa 2'),
(3, 4, 'Comentário sobre a tarefa 3'),
(4, 5, 'Comentário sobre a tarefa 4');

--04:
-- Tentar inserir um usuário com ID já existente (SEM especificar o user_id)
INSERT INTO public.users (username, email, password_hash) VALUES
('novo_usuario', 'joao.silva@email.com', 'novasenha');  -- Email repetido

--Tentar inserir um usuário com ID já existente (ESPECIFICANDO o user_id)
INSERT INTO public.users (user_id, username, email, password_hash) VALUES
(1, 'novo_usuario', 'novo.usuario@email.com', 'novasenha');

-- duplicar valor da chave viola a restrição de unicidade "users_email_key"

--05:
DELETE FROM public.users WHERE user_id = 1;
--atualização ou exclusão em tabela "users" viola restrição de chave estrangeira "boards_created_by_fkey" em "boards"



