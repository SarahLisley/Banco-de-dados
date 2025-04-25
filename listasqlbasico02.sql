-- SCHEMA: lista-sql-basico02

-- DROP SCHEMA IF EXISTS "lista-sql-basico02" ;

CREATE SCHEMA IF NOT EXISTS "lista-sql-basico02"
    AUTHORIZATION postgres;

--1. Os nomes dos personagens que possuem dragões cujo nome começa 
--2. com a letra S. 
SELECT p.nome
FROM Personagens p
JOIN Dragoes d ON p.id = d.id_personagem
WHERE d.nome LIKE 'S%';

--3. Os nomes dos dragões que não possuem dono. 
SELECT d.nome
FROM Dragoes d
WHERE d.id_personagem IS NULL;

--4. Os nomes dos personagens e os nomes das batalhas que eles venceram. 
SELECT p.nome, b.nome AS nome_batalha
FROM Personagens p
JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
JOIN Batalhas b ON pb.id_batalha = b.id
WHERE pb.resultado = 'Vitória';

--5. Os nomes dos personagens, os nomes e as datas das batalhas em que participaram 
--e o resultado dessas batalhas. Ordene os resultados da batalha mais recente para a 
--mais antiga. 
SELECT p.nome, b.nome AS nome_batalha, b.data, pb.resultado
FROM Personagens p
JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
JOIN Batalhas b ON pb.id_batalha = b.id
ORDER BY b.data DESC;

--6. Os nomes dos personagens que participaram de batalhas, suas casas e os 
--resultados das batalhas. Ordene o resultado em ordem alfabética do nome.
SELECT p.nome, p.casa, pb.resultado
FROM Personagens p
JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
ORDER BY p.nome ASC;

--7. Os nomes dos personagens e as relações que eles têm com outros personagens. 
SELECT p1.nome AS personagem, p2.nome AS relacionado, rf.relacao
FROM Relacoes_Familiares rf
JOIN Personagens p1 ON rf.id_personagem1 = p1.id
JOIN Personagens p2 ON rf.id_personagem2 = p2.id;

--8. Os ids dos personagens que participaram de batalhas e possuem dragões. 
SELECT DISTINCT p.id
FROM Personagens p
JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
JOIN Dragoes d ON p.id = d.id_personagem;

--9. Os nomes dos personagens que participaram de batalhas e possuem dragões. 
SELECT DISTINCT p.nome
FROM Personagens p
JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
JOIN Dragoes d ON p.id = d.id_personagem;

--10. Os ids dos personagens que possuem dragões, mas não participaram de nenhuma 
--batalha. 
SELECT p.id
FROM Personagens p
JOIN Dragoes d ON p.id = d.id_personagem
LEFT JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
WHERE pb.id_personagem IS NULL;

--11. Os ids dos personagens que participaram de batalhas em "King's Landing" ou 
--nasceram antes do ano 090. 
SELECT DISTINCT p.id
FROM Personagens p
JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
JOIN Batalhas b ON pb.id_batalha = b.id
WHERE b.localizacao = 'King''s Landing' OR p.data_nascimento < '090-01-01';

--12. Os nomes dos personagens que participaram de batalhas em "King's Landing" ou 
--nasceram antes do ano 090.
SELECT DISTINCT p.nome
FROM Personagens p
JOIN Participantes_Batalhas pb ON p.id = pb.id_personagem
JOIN Batalhas b ON pb.id_batalha = b.id
WHERE b.localizacao = 'King''s Landing' OR p.data_nascimento < '090-01-01';
