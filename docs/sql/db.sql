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


update rencontre set arbitre = 'Mr L''arbitre' where 1 = 1;

--Create score
create table score (
	id_equipe int,
	played int,
	points int,
	won int,
	draw int,
	lost int,
	scored int,
	taken int,
	constraint pk_score primary key(id_equipe),
	constraint fk_equipe foreign key(id_equipe) references equipe(id_equipe)
);

--Insert score
insert into score values(1, 0, 0, 0, 0, 0, 0, 0);
insert into score values(2, 0, 0, 0, 0, 0, 0, 0);
insert into score values(4, 0, 0, 0, 0, 0, 0, 0);
insert into score values(5, 0, 0, 0, 0, 0, 0, 0);
insert into score values(6, 0, 0, 0, 0, 0, 0, 0);
insert into score values(8, 0, 0, 0, 0, 0, 0, 0);
insert into score values(10, 0, 0, 0, 0, 0, 0, 0);
insert into score values(11, 0, 0, 0, 0, 0, 0, 0);
insert into score values(13, 0, 0, 0, 0, 0, 0, 0);
insert into score values(15, 0, 0, 0, 0, 0, 0, 0);
insert into score values(16, 0, 0, 0, 0, 0, 0, 0);
insert into score values(17, 0, 0, 0, 0, 0, 0, 0);
insert into score values(19, 0, 0, 0, 0, 0, 0, 0);
insert into score values(30, 0, 0, 0, 0, 0, 0, 0);
insert into score values(700, 0, 0, 0, 0, 0, 0, 0);
insert into score values(125, 0, 0, 0, 0, 0, 0, 0);
insert into score values(456, 0, 0, 0, 0, 0, 0, 0);
insert into score values(354, 0, 0, 0, 0, 0, 0, 0);
insert into score values(854, 0, 0, 0, 0, 0, 0, 0);
insert into score values(4356, 0, 0, 0, 0, 0, 0, 0);

--Ajout direct
create or replace function ajouter_equipe(p_nom varchar(50), p_stade varchar(50), p_ville varchar(50)) returns void  as $$
DECLARE
	query1 text;
BEGIN
	query1 := 'insert into equipe(nom, stade, ville, points, buts_pour, buts_contre) values(%, %, %, 0, 0, 0)', p_nom, p_stade, p_ville;
	execute query1;
END;
$$ language plpgsql;

--Ajout avec vérifications : déjà 22 équipes / saison débutée
--/!\ Utilise ajouter_equipe() /!\
create or replace function ajout_equipe(p_nom varchar(50), p_stade varchar(50), p_ville varchar(50)) returns void  as $$
DECLARE
	nb_equipe int;
	nb_passee int;
	query1 text;
BEGIN
	query1 := 'select * from ajouter_equipe(%, %, %)', p_nom, p_stade, p_ville;
	
	select count(*)
	into nb_equipe
	from equipe;
	
	select count(*)
	into nb_passee
	from rencontre
	where etat = 'passée';
	
	if nb_equipe = 22 then
		raise notice 'Il y a déjà 22 équipes !';
	elsif nb_passee > 0 then
		raise notice 'La saison est déjà débutée !';
	else
		execute query1;
	end if;
END;
$$ language plpgsql;

create or replace function initRencontres(firstDay date) returns void as $$
declare
	arrEq int array;
	i int;
	j int;
	tmp int;
	nbDecal int;
	eqA int;
	eqB int;
	stmtRencontre text;
	stmt text;
begin
	arrEq := array(
	select id_equipe
	from equipe
	order by random());
	
	stmt:='';
	stmtRencontre:='';
	nbDecal:=1;
	--raise notice '%', arrEq;
	--BOUCLE DECALAGE
	while nbDecal < array_length(arrEq, 1) loop
		--raise notice '----------------- % --------------------', nbDecal;
		i:=1;
		j:= array_length(arrEq,1);
		while i < j loop
			while i < array_length(arrEq, 1) loop		
				eqA := arrEq[i];
				eqB := arrEq[j];
				--raise notice '%, %, %', eqA, eqB, firstDay;
				stmtRencontre := 'insert into rencontre (id_domicile, id_visiteur, date_match,score_domicile, score_visiteur, arbitre, etat) values (' || eqA || ',' || eqB || ',''' ||  firstDay || ''', 0, 0, '''', ''à venir'');';
				--raise notice '%', stmtRencontre;
				execute stmtRencontre;
				stmt := stmt || chr(10) || stmtRencontre;
				i:=i+1;
				j:=j-1;
			end loop;
		end loop;
		--DECALAGE
		tmp := arrEq[array_length(arrEq,1)];
		for i in reverse array_length(arrEq, 1)..2 loop
			arrEq[i] := arrEq[i-1];
		end loop;
		arrEq[2] := tmp;
		--raise notice '%', arrEq;
		
		nbDecal:=nbDecal+1;
		firstDay := firstDay+7;
	end loop;
	--REDEMMARAGE + FIN BOUCLE DECALAGE
	raise notice '%', stmt;
	execute stmt;
	
end
$$ language plpgsql;

create or replace function resetSaison() returns void  as $$
DECLARE 
  v_tab_equipe text;
  v_tab_rencontre text;
  query1 text;
  query2 text;
  query3 text;
  query4 text
 BEGIN
 	SELECT Concat('save_', 'equipe_', date_part('year', now())) 
 	INTO   v_tab_equipe
 	FROM   equipe;
	SELECT Concat('save_', 'rencontre_', date_part('year', now())) 
 	INTO   v_tab_rencontre
 	FROM   rencontre;
	SELECT Concat('save_', 'score_', date_part('year', now())) 
 	INTO   v_tab_rencontre
 	FROM   rencontre;
	query1 := format('create table if not exists %I as (select * from equipe)', lower(v_tab_equipe));
	query2 := format('create table if not exists %I as (select * from rencontre)', lower(v_tab_rencontre));
	query3 := format('create table if not exists %I as (select * from score)', lower(v_tab_rencontre));
	query4 := format('truncate equipe, rencontre, score');
	EXECUTE query1;
	EXECUTE query2;
	EXECUTE query4;
	EXECUTE query3;
  end;
$$ language plpgsql;

create or replace function saisonTerminee() returns void  as $$
DECLARE
	termine int;
	nb_rencontre int;
	query text;
BEGIN

	select count(*)
	into nb_rencontre
	from rencontre;
	
	select count(*)
	into termine
	from rencontre
	where etat = 'passée';	
	
	query := 'select * from resetsaison()';
		
	if termine <> nb_rencontre then
		raise notice 'saison non terminée !';
	elsif termine = nb_rencontre then
		raise notice 'saison terminée !';
		execute (query);
	end if;
END;
$$ language plpgsql;

create or replace function updateScore() returns void as $$
declare
    i record;
    vis int;
    dom int;
    score1 int;
    score2 int;
    stmt text;
begin
	execute 'update score set played=0, points=0, won=0, draw=0, lost=0, scored=0, taken=0 where 1=1;';
    for i in select * from rencontre where etat = 'passé' loop
        select i.score_domicile into score1 from rencontre;
        select i.score_visiteur into score2 from rencontre;
        select i.id_domicile into dom from rencontre;
        select i.id_visiteur into vis from rencontre;
        if score1 > score2 then
            --raise notice '% : dom > vis : %', dom, vis;
            execute 'update score set points = points+3, won = won+1  where id_equipe = ' || dom || ';';
            execute 'update score set lost = lost + 1 where id_equipe = ' || vis || ';';
        elsif score1 < score2 then
            --raise notice '% : dom < vis : %', dom, vis;
            execute 'update score set points = points+3, won = won+1 where id_equipe = ' || vis || ';';
            execute 'update score set lost = lost + 1 where id_equipe = ' || dom || ';';
        elsif score1 = score2 then
            --raise notice '% : dom = vis : %', dom, vis;
            execute 'update score set points = points + 1, draw = draw+1 where id_equipe = ' || dom || ';';
            execute 'update score set points = points + 1, draw = draw+1 where id_equipe = ' || vis || ';';
        end if;
        execute 'update score set played = played+1, scored = scored + '|| score1 ||', taken = taken+'||score2||' where id_equipe = ' || dom || ';';
        execute 'update score set played = played+1, scored = scored + '|| score2 ||', taken = taken+'||score1||' where id_equipe = ' || vis || ';';
    end loop;
end;
$$ language plpgsql;

