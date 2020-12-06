create or replace function resetSaison() returns void  as $$
DECLARE 
  v_tab_equipe text;
  v_tab_rencontre text;
  query1 text;
  query2 text;
  query3 text;
 BEGIN
 	SELECT Concat('save_', 'equipe_', date_part('year', now())) 
 	INTO   v_tab_equipe
 	FROM   equipe;
	 SELECT Concat('save_', 'rencontre_', date_part('year', now())) 
 	INTO   v_tab_rencontre
 	FROM   rencontre;
	query1 := format('create table if not exists %I as (select * from equipe)', lower(v_tab_equipe));
	query2 := format('create table if not exists %I as (select * from rencontre)', lower(v_tab_rencontre));
	query3 := format('truncate equipe, rencontre');
	EXECUTE query1;
	EXECUTE query2;
	EXECUTE query3;
  end;
$$ language plpgsql;

---Utilisation de la procédure
--select * from resetSaison;