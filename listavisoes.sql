-- SCHEMA: lista-visoes

-- DROP SCHEMA IF EXISTS "lista-visoes" ;

CREATE SCHEMA IF NOT EXISTS "lista-visoes"
    AUTHORIZATION postgres;

CREATE TABLE fornecedor
 (
  fnome varchar(20),
  cidade varchar(20),
  fid integer NOT NULL,
  CONSTRAINT id PRIMARY KEY (fid)
 );
 CREATE TABLE projeto
 (
  jid integer NOT NULL,
  jnome varchar(20),
  cidade varchar(20),
  CONSTRAINT j_pkey PRIMARY KEY (jid)
 );
 CREATE TABLE peca
 (
  pid integer NOT NULL,
  pnome varchar(20),
  cor varchar(20),
  CONSTRAINT p_pkey PRIMARY KEY (pid)
 );
 CREATE TABLE fpj
 (
  fid integer NOT NULL,
  pid integer NOT NULL,
  jid integer NOT NULL,
 qtd integer NOT NULL,
  CONSTRAINT p_pkey1 PRIMARY KEY (fid,pid,jid),
  constraint fk_1 foreign key(fid) references fornecedor(fid),
  constraint fk_2 foreign key(pid) references peca(pid),
  constraint fk_3 foreign key(jid) references projeto(jid) 
);
 insert into fornecedor values ('Maria','Fortaleza',1);
 insert into fornecedor values('Lucia','São Paulo',2);
 insert into fornecedor values('João','Fortaleza',3);
 insert into fornecedor values('Ana','Rio de Janeiro',4);
 insert into fornecedor values('Pedro','Teresina',5);
 insert into peca values (1,'peca1','preto');
 insert into peca values(2,'peca2','branco');
 insert into peca values(3,'peca3','preto');
 insert into projeto values (1,'projeto1','Fortaleza');
 insert into projeto values(2,'projeto2','São Paulo');
 insert into projeto values(3,'projeto3','Teresina');
 insert into projeto values (4,'projeto4','Fortaleza');
 insert into projeto values(5,'projeto5','São Paulo');
 insert into projeto values(6,'projeto6','Teresina');
 insert into fpj values (3,3,3,300);
 insert into fpj values(2,1,4,500);
 insert into fpj values(2,1,5,450);
 insert into fpj values (2,1,1,300);
 insert into fpj values(3,2,5,200);
 insert into fpj values(1,2,6,100);
 insert into fpj values(3,1,3,200);

CREATE VIEW peca1_id AS
SELECT PID
FROM PECA
WHERE PNOME = 'peca1';

CREATE VIEW projeto1_id AS
SELECT JID
FROM PROJETO
WHERE JNOME = 'projeto1';

CREATE VIEW max_qtd_projeto1 AS
SELECT MAX(QTD) AS max_quantidade
FROM FPJ
WHERE JID = (SELECT JID FROM projeto1_id);

CREATE VIEW avg_qtd_peca1 AS
SELECT AVG(QTD) AS avg_quantidade
FROM FPJ
WHERE PID = (SELECT PID FROM peca1_id);

CREATE VIEW avg_qtd_peca1_por_projeto AS
SELECT JID, AVG(QTD) AS avg_quantidade
FROM FPJ
WHERE PID = (SELECT PID FROM peca1_id)
GROUP BY JID;

CREATE VIEW projetos_peca1_acima_media_max AS
SELECT JID
FROM avg_qtd_peca1_por_projeto
WHERE avg_quantidade > (SELECT max_quantidade FROM max_qtd_projeto1)
  AND avg_quantidade > (SELECT avg_quantidade FROM avg_qtd_peca1);

CREATE VIEW pecas_projetos_quantidades AS
SELECT
    P.PID,
    P.PNOME,
    COUNT(DISTINCT FPJ.JID) AS total_projetos,
    SUM(FPJ.QTD) AS quantidade_total_usada
FROM
    PECA P
LEFT JOIN
    FPJ ON P.PID = FPJ.PID
GROUP BY
    P.PID, P.PNOME;

CREATE VIEW quantidade_por_projeto AS
SELECT
    P.PID,
    P.PNOME,
    J.JID,
    J.JNOME,
    SUM(FPJ.QTD) AS quantidade_usada_por_projeto
FROM
    PECA P
JOIN
    FPJ ON P.PID = FPJ.PID
JOIN
    PROJETO J ON FPJ.JID = J.JID
GROUP BY
    P.PID, P.PNOME, J.JID, J.JNOME;

CREATE VIEW quantidades_max_min_peca AS
SELECT
    P.PNOME,
    MAX(FPJ.QTD) AS quantidade_maxima,
    MIN(FPJ.QTD) AS quantidade_minima
FROM
    PECA P
JOIN
    FPJ ON P.PID = FPJ.PID
GROUP BY
    P.PNOME;

CREATE VIEW quantidades_max_min_peca_excluido_F1 AS
SELECT
    P.PNOME,
    MAX(FPJ.QTD) AS quantidade_maxima,
    MIN(FPJ.QTD) AS quantidade_minima
FROM
    PECA P
JOIN
    FPJ ON P.PID = FPJ.PID
WHERE
    FPJ.FID <> 1  -- Exclui as entregas do fornecedor F1
GROUP BY
    P.PNOME;

SELECT * FROM pecas_projetos_quantidades;

SELECT * FROM quantidade_por_projeto;

SELECT * FROM quantidades_max_min_peca;

SELECT * FROM quantidades_max_min_peca_excluido_F1;

SELECT * FROM projetos_peca1_acima_media_max;