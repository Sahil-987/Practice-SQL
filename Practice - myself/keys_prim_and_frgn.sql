               /* Primary key */
			   
	
-- table : 1
	
create table student_admission(
roll_no integer primary key,
name varchar(50),
city varchar(50)
)

drop table student_admission cascade

insert into student_admission
values
(1,'md asif','faizabad'),
(2,'mohd asif hashmi','lucknow'),
(3,'mohd waris','chandigarh'),
(4,'mohd haris','kanpur'),
(5,'mohd monis','rampur'),
(6,'mohd sahil','kanpur'),
(7,'mudassir','lucknow'),
(8,'praduman','handua')



select * from student_admission


-- table : 2

create table student_courses(
subject varchar(50),
roll_no int,
FOREIGN KEY(roll_no) REFERENCES student_admission(roll_no)
)

drop table student_courses


insert into student_courses
values
('dbms',1),
('networks',2),
('C',3),
('TAFL',4),
('TAFL',5),
('TAFL',5),
('TAFL',7),
('TAFL',8)



select * from student_courses



///////////////////////////////////////////////////////

-- Rough work


