create database course;

create table course_user (
    id serial primary key,
    name varchar(255),
    email varchar(255)
);

insert into course_user (name, email) VALUES ('Alex Reshetnyk', 'alex@reshetnyk.com');
insert into course_user (name, email) VALUES ('test user', 'test@dummy.com');

select * from course_user;