INSERT INTO nivel (nome, descricao, status) VALUES
    ('Iniciante', 'Para iniciantes na língua de sinais', 'Ativo'),
    ('Intermediário', 'Para usuários com conhecimento intermediário', 'Ativo'),
    ('Avançado', 'Para usuários avançados na língua de sinais', 'Ativo');

-- Inserindo dados na tabela Modulos
INSERT INTO Modulos (nome, descricao, status, id_nivel) VALUES
    ('Introdução à Libras', 'Módulo básico de introdução', 'Ativo', 1),
    ('Cumprimentos e Saudações', 'Aprenda a cumprimentar', 'Ativo', 1),
    ('Vocabulário Básico', 'Aprenda palavras do dia a dia', 'Ativo', 1),
    ('Expressões Comuns', 'Frases do cotidiano', 'Ativo', 2),
    ('Conversação', 'Aprimorando a fluência', 'Ativo', 2),
    ('Termos Técnicos', 'Libras para áreas específicas', 'Ativo', 3),
    ('Linguagem Formal', 'Comunicação em contextos formais', 'Ativo', 3),
    ('Interpretação', 'Técnicas de interpretação', 'Ativo', 3),
    ('Sinais Regionais', 'Variações regionais na Libras', 'Ativo', 3),
    ('Sinais Avançados', 'Vocabulário avançado', 'Ativo', 3);

-- Inserindo dados na tabela Unidades
INSERT INTO Unidades (nome, descricao, status, id_modulo) VALUES
    ('Alfabeto e Números', 'Aprenda o alfabeto e números', 'Ativo', 1),
    ('Saudações', 'Saudações e despedidas', 'Ativo', 2),
    ('Cores e Objetos', 'Nomes de cores e objetos', 'Ativo', 3),
    ('Verbos Comuns', 'Uso de verbos no dia a dia', 'Ativo', 3),
    ('Perguntas Frequentes', 'Como fazer perguntas', 'Ativo', 4),
    ('Construindo Frases', 'Estruturas básicas', 'Ativo', 5),
    ('Expressões Corporais', 'Expressão e entonação', 'Ativo', 6),
    ('Sinais Técnicos', 'Libras para profissões', 'Ativo', 7),
    ('Interpretação ao Vivo', 'Simulação de interpretação', 'Ativo', 8),
    ('Comunicação Profissional', 'Uso da Libras no trabalho', 'Ativo', 9);

-- Inserindo dados na tabela Usuarios
INSERT INTO usuario (nome, email, senha, data_nascimento, nivel_inicial, foto_perfil) VALUES
    ('Alice Silva', 'alice@email.com', 'senha123', '1995-08-10', 'Iniciante', NULL),
    ('Bruno Souza', 'bruno@email.com', 'senha123', '1990-05-20', 'Intermediário', NULL),
    ('Carla Mendes', 'carla@email.com', 'senha123', '1985-12-01', 'Avançado', NULL),
    ('Daniel Oliveira', 'daniel@email.com', 'senha123', '2000-06-15', 'Iniciante', NULL),
    ('Eduarda Lima', 'eduarda@email.com', 'senha123', '1998-03-22', 'Iniciante', NULL),
    ('Fernando Rocha', 'fernando@email.com', 'senha123', '1993-07-19', 'Intermediário', NULL),
    ('Gabriela Nunes', 'gabriela@email.com', 'senha123', '1997-11-30', 'Avançado', NULL),
    ('Henrique Santos', 'henrique@email.com', 'senha123', '1992-09-25', 'Intermediário', NULL),
    ('Isabela Castro', 'isabela@email.com', 'senha123', '2001-02-14', 'Iniciante', NULL),
    ('João Pereira', 'joao@email.com', 'senha123', '1996-10-05', 'Intermediário', NULL);

-- Inserindo dados na tabela Progresso_nos_Niveis
INSERT INTO Progresso_nos_Niveis (id_usuario, id_nivel, data_conclusao) VALUES
    (1, 1, '2025-01-10'),
    (2, 2, '2025-01-20');

-- Inserindo dados na tabela Progresso_nos_Modulos
INSERT INTO Progresso_nos_Modulos (id_usuario, id_modulo, data_conclusao) VALUES
    (1, 1, '2025-01-05'),
    (2, 3, '2025-01-15');

-- Inserindo dados na tabela Progresso_nas_Unidades
INSERT INTO Progresso_nas_Unidades (id_usuario, id_unidade, data_conclusao) VALUES
    (1, 1, '2025-01-03'),
    (2, 2, '2025-01-12');

-- Inserindo dados na tabela Videos
INSERT INTO Videos (titulo, url_video, descricao, nivel_dificuldade, id_unidade) VALUES
    ('Alfabeto', 'url_alfabeto.mp4', 'Aprenda o alfabeto', 'Iniciante', 1),
    ('Saudações', 'url_saudacoes.mp4', 'Cumprimentos básicos', 'Iniciante', 2);

-- Inserindo dados na tabela Desafios
INSERT INTO Desafios (titulo, descricao, tempo_limite, id_modulo) VALUES
    ('Desafio de Alfabeto', 'Acerte todas as letras', '5 min', 1),
    ('Desafio de Números', 'Conte de 1 a 20 em Libras', '5 min', 1);

-- Inserindo dados na tabela Exercicios
INSERT INTO Exercicios (pontuacao_total, categoria, id_unidade) VALUES
    (100, 'Alfabeto', 1),
    (100, 'Números', 2);

-- Inserindo dados na tabela Questionarios
INSERT INTO Questionarios (tempo_limite, pontuacao_total, id_unidade) VALUES
    (10, 50, 1),
    (10, 50, 2);

-- Inserindo dados na tabela Questoes
INSERT INTO Questoes (pergunta, opcao_1, opcao_2, opcao_3, opcao_4, opcao_correta, id_exercicio, id_questionario) VALUES
    ('Qual é o sinal para "A"?', 'Opção A', 'Opção B', 'Opção C', 'Opção D', 'Opção A', 5, NULL);

-- Inserindo dados na tabela Respostas_do_Usuario
INSERT INTO Respostas_do_Usuario (id_usuario, id_questao, resposta_usuario, data_resposta) VALUES
    (1, 4, 'Opção A', '2025-01-08 10:30:00');

-- Inserindo dados na tabela Certificados
INSERT INTO Certificados (nivel_concluido, data_conclusao, codigo_autenticacao, id_usuario) VALUES
    ('Iniciante', '2025-01-15', 'ABC123', 1);

-- Inserindo dados na tabela Conquistas
INSERT INTO Conquistas (titulo, descricao, data_obtida, url_imagem_conquista, id_usuario) VALUES
    ('Primeira Conquista', 'Finalizou o primeiro módulo', '2025-01-05', 'conquista1.jpg', 1);

-- Inserindo dados na tabela FeedBacks
INSERT INTO FeedBacks (descricao, categoria, data_envio, id_usuario) VALUES
    ('Gostei do curso!', 'Elogio', '2025-01-12', 1);

-- Inserindo dados na tabela Notificacoes
INSERT INTO Notificacoes (descricao, horario_preferivel, id_usuario) VALUES
    ('Lembrete para praticar Libras', '08:00:00', 1);

-- Inserindo dados na tabela Sinais
INSERT INTO Sinais (significado, categoria, exemplo_uso, url_imagem) VALUES
    ('Obrigado', 'Expressão', 'Dizer obrigado após um favor', 'obrigado.jpg');

-- Inserindo dados na tabela Artigos_de_Ajuda
INSERT INTO Artigos_de_Ajuda (titulo, descricao, categoria) VALUES
    ('Como começar em Libras?', 'Dicas para iniciantes', 'Guia');