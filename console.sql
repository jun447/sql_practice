# use mydb
rename table mydb.employees to mydb.employees_old;
drop table mydb.employees_old;
 select * from employees;
alter table employees add column phone_number varchar(20);
# rename column phone_number to email
alter table employees rename column phone_number to email;
alter table employees modify column email varchar(30);
alter table employees modify email varchar(30) after last_name;
alter table employees modify hourly_pay varchar(30) first;
# droping email column from employees table
alter table employees drop column email;
alter table employees modify employee_id varchar(30) first;
alter table employees modify hourly_pay varchar(30) after hire_date;
alter table employees modify hourly_pay decimal(10,2);
select * from employees;
# inserting values into employees table
insert into employees values ('1','John','Doe','2000-01-01',10.00);
insert into employees values ('5','Ramwan','Ghori','2000-2-01',5.00);
insert into employees values ('7','Titus','Dngr','2002-3-01',5.00);

insert into employees values ('2','Jane','Doe','2000-01-02',11.00),
                             ('3','John','Smith','2000-01-03',12.00),
                             ('4','Jane','Smith','2000-01-04',13.00);
# just inserting data in employees_id , first_name and last_name
insert into employees (employee_id,first_name,last_name) values ('6','Hassan','Bali');
# nly select employee_id,first_name,last_name from employees;
select first_name,last_name from employees where employee_id = '5';
# how to update particular value in column of table
update employees set first_name = "Ramzan" where employee_id = '5';
select * from employees where first_name = 'Ramzan';
select * from employees where hourly_pay > 5;
select * from employees where hire_date IS NULL;
update employees set hourly_pay = 15.00,hire_date='2023-01-07' where employee_id = '6';
delete from employees where employee_id = '7';
# auto commiy is on by default in mysql so we don't need to commit the changes in table
# but if we want to turn off auto commit then we can do it by using below command
# set autocommit = 0;
# commit;
# rollback;
