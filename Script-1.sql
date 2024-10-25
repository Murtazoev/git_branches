set search_path to something ;
 
-- Start for students table
create table students(
	student_id serial primary key,
	student_name varchar(100) not null unique ,
	username varchar(100) not null unique ,
	bio varchar(1000) ,
	mobile varchar(20) not null unique,
	has_picture bool not null
);

insert into something.students(student_name , username , bio , mobile , has_picture)
	values ('User Userovic 1' , 'user_1' , 'I am a user 1' , '000000000' , false) ,
			('User Userovic 2' , 'user_2' , 'I am a user 2' , '000000001' , true) ,
			('User Userovic 3' , 'user_3' , 'I am a user 3' , '000000002' , false) ,
			('User Userovic 4' , 'user_4' , 'I am a user 4' , '000000003' , true) ,
			('User Userovic 5' , 'user_5' , 'I am a user 5' , '000000004' , false) ,
			('User Userovic 6' , 'user_6' , 'I am a user 6' , '000000005' , true) ,
  			('User Userovic 7' , 'user_7' , 'I am a user 7' , '000000006' , false) ;


select *
from something.students

truncate something.students restart identity;

-- end of Student part 



-- Start of lessons part
create table lessons(
	lesson_id serial primary key,
	lesson_name varchar(100) unique not null,
	lesson_date timestamp ,
	attendance bool
) ;

insert into lessons (lesson_name , lesson_date , attendance)
values ('lesson_6' , '10.23.2024' , true) ;

truncate lessons restart identity ;

select *
from lessons ;
-- End of lessons part



-- Start of scores
	
create table scores(
	score_id serial,
	user_id serial references students(student_id) ,
	lesson_id serial references lessons(lesson_id) ,
	score int default 0
);

insert into scores(user_id , lesson_id , score)
values ('1' , '7' , null) ;

select * from scores;

truncate scores restart identity;

drop table scores;

-- End of scores


-- Start my_results

create view my_results as
select
	student_id,
	student_name,
	username,
	mobile,
 	count(lessons.attendance = true),
 	(select avg(score) from scores where user_id = 1)  as avg_score
from
	students , lessons
where
	student_id = 1
group by
	student_id,
	student_name,
	username,
	mobile;
	
select * from my_results;

drop view my_results;
-- End my_results

