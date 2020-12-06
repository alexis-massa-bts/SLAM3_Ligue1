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

--Utilisation de la procédure
--select * from saisonTerminee;