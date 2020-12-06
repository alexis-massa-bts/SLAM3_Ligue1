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

--Utilisation 
--select * from ajout_equipe('MASSA FC', 'Bg Stadium', 'Bascous')