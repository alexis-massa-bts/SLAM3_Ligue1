--Create equipe
create table equipe (
    id_equipe int,
    nom varchar(50),
    stade varchar(50),
    ville varchar(15),
    image varchar(50),
    constraint pk_equipe primary key (id_equipe)
);

--Insert equipe
INSERT INTO equipe VALUES (1,'PSG','Parc des prince','Paris','./img/club/psg.jpg');
INSERT INTO equipe VALUES (2,'ASM','Louis II','Monaco', './img/club/asm.png');
INSERT INTO equipe VALUES (3,'ASSE','Geoffroy-Guichard','Saint-etienne', './img/club/asse.jpg');
INSERT INTO equipe VALUES (4,'FCGB','Matmut Atlantique','Bordeaux', './img/club/fcgb.jpg');
INSERT INTO equipe VALUES (5,'OL','Groupama Stadium','Lyon', './img/club/ol.png');
INSERT INTO equipe VALUES (6,'OM','Orange Vélodrome','Marseille', './img/club/om.png');
INSERT INTO equipe VALUES (7,'FCN','La Beaujoire','Nantes', './img/club/fcn.png');
INSERT INTO equipe VALUES (8,'OGC Nice','Allianz Riviera','Nice', './img/club/ogc.png');
INSERT INTO equipe VALUES (9,'Stade Malherbe de Caen','Michel-d-Ornano','Caen', './img/club/caen.jpg');
INSERT INTO equipe VALUES (10,'En Avant de Guingamp','Roudourou','Guingamp', './img/club/guingamp.jpg');
INSERT INTO equipe VALUES (11,'SCO','Raymond-Kopa','Angers', './img/club/sco.jpg');
INSERT INTO equipe VALUES (12,'Montpellier-Herault Sport Club','La Mosson','Montpellier', './img/club/montpellier.png');
INSERT INTO equipe VALUES (13,'TFC','Stadium Municipal','Toulouse', './img/club/tfc.png');
INSERT INTO equipe VALUES (14,'ASC','La Licorne','Amiens', './img/club/asc.png');
INSERT INTO equipe VALUES (15,'Stade Rennais Football Club','Roazhon Park','Rennes', './img/club/rennes.png');
INSERT INTO equipe VALUES (16,'ESTAC','Stade de l Aube','Troyes', './img/club/estac.jpg');
INSERT INTO equipe VALUES (17,'LOSC','Pierre-Mauroy','Lille', './img/club/losc.webp');
INSERT INTO equipe VALUES (18,'DFCO','Gaston-Gérard','Dijon', './img/club/dfco.svg');
INSERT INTO equipe VALUES (19,'FC Metz','Saint-Symphorien','Metz', './img/club/metz.png');
INSERT INTO equipe VALUES (20,'RCS','La Meinau','Strasbourg', './img/club/rcs.png');




--Create rencontre
create table rencontre(
    id_domicile int,
    id_visiteur int,
    date_match date,
    score_domicile int,
    score_visiteur int,
    arbitre varchar(15),
    etat varchar(10), --"à venir" / "en cours" (au cas ou on voudrait faire des matchs en live) / "passée"
    constraint pk_rencontre primary key(id_domicile, id_visiteur),
    constraint fk_dom_equipe foreign key(id_domicile) references equipe(id_equipe),
	constraint fk_vis_equipe foreign key(id_visiteur) references equipe(id_equipe)
);

--Insert rencontre
--/!\ Procédure initrencontres /!\
--Les rencontres commencent au 7 mars 2021
select * from initRencontres('07-04-2021');
