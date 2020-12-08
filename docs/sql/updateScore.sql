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

--Utilisation
select * from updateScore();
--Verification
select * from score;