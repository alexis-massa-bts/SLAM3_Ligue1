--Procédure préparant la saison :
--param : date de début de la saison
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

--Utilisation de la procédure
--select * from initRencontres('07-04-2021');