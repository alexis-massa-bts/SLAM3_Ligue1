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

--Update
update score set played=0, points=0, won=0, draw=0, lost=0, scored=0, taken=0 where 1=1;