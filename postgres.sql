-- SCHEMA: personagens-t02

-- DROP SCHEMA IF EXISTS "personagens-t02" ;

-- set schema 'personagens';

CREATE SCHEMA IF NOT EXISTS "personagens-t02"
    AUTHORIZATION postgres;

create table personagens (
	nome varchar(50),
	idade integer,
	casa  varchar(100),
	sangue varchar(50)
);
--Comando para excluir uma tabela
drop table personagens;

--inserir preenchendo apenas nome e idade
insert into personagens (nome, idade, casa, sangue)
values ('harry potter', 15, 'grifinória', 'mestiço'), ('Hermione', 18, 'grifinória', 'Nascida-trouxa'), 
('Ron Weasley', 17, 'grifinória', 'Sangue-puro'), ('Draco Malfoy', 18, 'Sonserina', 'Sangue-puro'),
('Luna Lovegood', 16, 'Corvinal', 'Sangue-puro');

--visualizar as tuplas inseridas
select * from personagens; --mostra todas as colunas *

--alterar a coluna na tabela
alter table personagens
rename column idade to idade_anos;

--apagar coluna
alter table personagens
drop column casa;

--adicionar coluna
alter table personagens
add column id_casa integer;

select * from personagens;

--Exercicio: Criar a tabela Casa(id int, nome varchar(30));
--Inserir as tuplas da tabela casa
-- 1 - Grifinoria
-- 2 - Sonserina
-- 3 - Lufa Lufa
-- 4 - Corvinal

create table casa(
	id integer,
	nome varchar (30)
);

--Adicionar restrição de não nulidade nas colunas
alter table casa
alter column nome set not null;

alter table casa
alter column id set not null;

--Restrição de unicidade : UNIQUE
alter table casa
add constraint uk_nome unique(nome);

insert into casa (id, nome)
values (1, 'grifinória'), (2, 'Sonserina'), 
(3, 'Lufa Lufa'), (4, 'Corvinal');

--insert into values (1, 'grifinória'), (2, 'Sonserina');

select * from casa;

--Alterando tipo da coluna
alter table personagens
alter column nome
type varchar(100);

--chave são atributos
--super chave é quando é quando tem atributo extra

--Criar tabela Habilidade
create table habilidade (
	id integer,
	nome varchar(30) unique,
	primary key (id)
);





