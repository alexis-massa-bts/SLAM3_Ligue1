--Create equipe
create table equipe (
    id_equipe int,
    nom varchar(50),
    stade varchar(50),
    ville varchar(15),
    points int,
    buts_pour int,
    buts_contre int,
    constraint pk_equipe primary key (id_equipe)
);

--Insert equipe
insert into equipe values(1, 'PSG','Parc des prince', 'Paris', 0, 0, 0);
insert into equipe values(2, 'ASM', 'Louis II', 'Monaco', 0, 0, 0);
insert into equipe values(4, 'FCGB', 'Matmut Atlantique', 'Bordeaux', 0, 0, 0);
insert into equipe values(5, 'OL', 'Groupama Stadium', 'Lyon', 0, 0, 0);
insert into equipe values(6, 'OM', 'Orange Vélodrome', 'Marseille', 0, 0, 0);
insert into equipe values(8, 'OGC Nice', 'Allianz Riviera', 'Nice', 0, 0, 0);
insert into equipe values(10, 'En Avant de Guingamp', 'Roudourou', 'Guingamp', 0, 0, 0);
insert into equipe values(11, 'SCO', 'Raymond-Kopa', 'Angers', 0, 0, 0);
insert into equipe values(13, 'TFC', 'Stadium Municipal', 'Toulouse', 0, 0, 0);
insert into equipe values(15, 'Stade Rennais Football Club', 'Roazhon Park', 'Rennes', 0, 0, 0);
insert into equipe values(16, 'ESTAC', 'Stade de l Aube', 'Troyes', 0, 0, 0);
insert into equipe values(17, 'LOSC', 'Pierre-Mauroy', 'Lille', 0, 0, 0);
insert into equipe values(19, 'FC Metz', 'Saint-Symphorien', 'Metz', 0, 0, 0);
insert into equipe values(30, 'ASSE', 'Geoffroy-Guichard', 'Saint-etienne', 0, 0, 0);
insert into equipe values(700, 'FCN', 'La Beaujoire', 'Nantes', 0, 0, 0);
insert into equipe values(125, 'Stade Malherbe de Caen', 'Michel-d-Ornano', 'Caen', 0, 0, 0);
insert into equipe values(456, 'Montpellier-Herault Sport Club', 'La Mosson', 'Montpellier', 0, 0, 0);
insert into equipe values(354, 'ASC', 'La Licorne', 'Amiens', 0, 0, 0);
insert into equipe values(854, 'DFCO', 'Gaston-Gérard', 'Dijon', 0, 0, 0);
insert into equipe values(4356, 'RCS', 'La Meinau', 'Strasbourg', 0, 0, 0);

--Create rencontre
create table rencontre(
    id_domicile int,
    id_visiteur int,
    date_matche date,
    score_domicile int,
    score_visiteur int,
    arbritre varchar(15),
    etat varchar(10), --"à venir" / "en cours" (au cas ou on voudrait faire des matchs en live) / "passée"
    constraint pk_rencontre primary key(id_domicile, id_visiteur),
    constraint fk_equipe foreign key(id_domicile, id_visiteur) references equipe(id_equipe)
);

--Insert rencontre
--/!\ Procédure initrencontres /!\
--Les rencontres commencent au 7 mars 2021
select * from initRencontres('07-04-2021');
