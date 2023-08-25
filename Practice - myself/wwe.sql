select * from wwe


create table wwe(
id int,
name varchar(20),
finishers varchar(20)
	)
	
drop table wwe

insert into wwe
values
(1,'undertaker','tombstone'),
(2,'hbk','sweet chin'),
(3,'hhh','pedigree'),
(4,'stone cold','stunner'),
(5,'rock','rock bottom')


--update stmnt

update wwe
set name = CONCAT('The', name)



-- nickname table

create table wwe_nickname(
	id int,
	name varchar(10),
	nick_name varchar(20),
	foreign key(name) references wwe(name)
)

drop table wwe_nickname

insert into wwe_nickname
values
(1,'undertaker','dead man'),
(2,'hbk','show stopper'),
(3,'hhh','game'),
(4,'stone cold','rattle snake'),
(5,'rock','people champ')


select * from wwe_nickname


-- foreign key


