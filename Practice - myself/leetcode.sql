
Q- Delete Duplicate Emails ?

Create table If Not Exists Person (Id int, Email varchar(255))

Truncate table Person

insert into Person
values 
('1', 'john@example.com'),
('2', 'bob@example.com'),
('3', 'john@example.com')

select * from Person


-- both are same

select p1, p2 from Person p1
join person p2
on p1.email = p2.email and p1.id > p2.id


select p1 FROM Person p1,Person p2
WHERE p1.Email = p2.Email AND p1.Id > p2.Id