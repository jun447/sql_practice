#  Views
# a virtual table based on the result-set of an SQL statement
# - The fields in a view are fields from one or more real tables in the database
# They're not real tables, but can be interacted with as if they were
# - Views are used to limit the amount of data that's returned to the user
# - Views can be used to combine data from multiple tables
# - Views can be used to hide data that the user shouldn't see
# - Views can be used to present data in a different way than it's stored in the database
# - Views can be used to restrict access to data in the database
# - Views can be used to present data in a different way than it's stored in the database
create view employees_attenance as
    select first_name,last_name from employees;
select * from employees_attenance;
drop view employees_attenance;
select * from customer;
select * from transactions;
select * from employees;
# adding email column in customers table
alter table customer add email varchar(50);
# updating customers table
update customer set email="FFish@gmai1.com" where customer_id=1;
update customer set email="LLobster@gmail.com" where customer_id=2;
update customer set email="BBass@gmai1.com" where customer_id=3;
update customer set email="PPuff@gmail.com" where customer_id=4;

# creating a view
create view customer_email as
    select email from customer;
select * from customer_email;

# inserting data into customer table
insert into customer () values ("5","Pearl","Krabs",NULL,"PKrabs@gmail.com");

# INDEX (B Tree data structure)
# Indexes are used to find values within a specific column more quickly
# MySQL normally searches sequentially through a column
# The longer the column, the more expensive the operation is
# UPDATE takes more time, SELECT takes less time
show index from customer;
# creating index on last_name column
create index last_name_index on customer(last_name);
select * from customer where last_name="Puff";
# multi column index on first_name and last_name
create index first_last_name_index on customer(first_name,last_name);
select * from customer where first_name="Pearl" and last_name="Krabs";
# dropping an index
alter table customer drop index last_name_index;
drop index last_name_index on customer;
# subquery
#   a query within another query
#   query(query)
#   a subquery is a query that's nested inside another query
select first_name,last_name,hourly_pay,
       (select avg(hourly_pay) from employees ) as AvgPay from employees;

select first_name,last_name,hourly_pay  from employees
        where hourly_pay > (select avg(hourly_pay) from employees );

select first_name,last_name from customer
        where customer_id in
              (select distinct customer_id from transactions where customer_id is not null);
select first_name,last_name from customer
        where customer_id in
              (select distinct customer_id from transactions where customer_id is not null);

# adding column to transactions table
alter table transactions add transaction_date date;
# updating transactions table
update transactions set transaction_date="2023-01-01" where transaction_id=1000;
update transactions set transaction_date="2023-01-01" where transaction_id=1001;
update transactions set transaction_date="2023-01-02" where transaction_id=1002;
update transactions set transaction_date="2023-01-02" where transaction_id=1003;
update transactions set transaction_date="2023-01-03" where transaction_id=1004;
update transactions set transaction_date="2023-01-03" where transaction_id=1005;
update transactions set transaction_date="2023-01-03" where transaction_id=1006;
# GROUP BY -
# aggregate all rows by a specific column
# often used with aggregate functions
# ex. SUM(), MAX(), MIN(), AVG(), COUNT()
# how much ammount of transactions were made on each day
select transaction_date, sum(price) from transactions group by transaction_date;
select customer_id, sum(price) from transactions group by customer_id;
select customer_id, count(price) from transactions group by customer_id
    having count(price) > 1 and customer_id is not null;

# ROLLUP, extension of the GROUP BY clause
# produces another row and shows the GRAND TOTAL (super-aggregate value)

select transaction_date,sum(price) from transactions group by transaction_date with rollup;

select transaction_date,count(transaction_id) from transactions group by transaction_date with rollup;

# count of transactions per customers
select customer_id,count(transaction_id) as "# Of Orders"
        from transactions group by customer_id with rollup;

select employee_id,sum(hourly_pay) as "Hourly Pay" from employees group by employee_id with rollup;

# ON delete cascade - delete all the rows in the child table that have a matching value in the parent table
# ON delete set null - set the foreign key column to NULL in the child table
# ON delete set default - set the foreign key column to the default value in the child table
# ON delete restrict - prevent the deletion of the parent row if there is a matching row in the child table
# ON delete no action - same as restrict

# ON DELETE SET NULL = When a FK is deleted,replace FK with NULL
# ON DELETE CASCADE When a FK is deleted,delete row
delete from customer where customer_id=4;
alter table transactions drop foreign key fk_customer_id;
alter table transactions add constraint fk_customer_id foreign key (customer_id)
    references customer(customer_id) on delete set null;
# insert poppy puff back in to customer table
insert into customer () values ("4","Poppy","Puff",2,"PPuff@gmail.com");
alter table transactions drop foreign key fk_customer_id;
alter table transactions add constraint fk_customer_id foreign key (customer_id)
    references customer(customer_id) on delete cascade;
# updating transactions table
update transactions set customer_id=4 where transaction_id=1005;
delete from customer where customer_id=4;

# Stored Procedures
# - A stored procedure is a prepared SQL code that you can save,
#       so the code can be reused over and over again
select distinct first_name,last_name from transactions
        inner join customer on transactions.customer_id=customer.customer_id;
# creating a stored procedure
delimiter //
create procedure get_customers()
    begin
        select * from customer;
    end //
delimiter ;
call get_customers();
drop procedure get_customers;
# creating a stored procedure with parameters
delimiter //
create procedure get_customers_by_id(id int)
    begin
        select * from customer where customer_id=id;
    end //
delimiter ;

call get_customers_by_id(1);
# creating a stored procedure with two parameters first_name and last_name
delimiter //
create procedure get_customers_by_name(in f_name varchar(50),in l_name varchar(50))
    begin
        select * from customer where first_name=f_name and last_name=l_name;
    end //
delimiter ;
drop procedure get_customers_by_name;
call get_customers_by_name("Pearl","Krabs");
# Trigger
# When an event happens, do something
#     ex. (INSERT, UPDATE, DELETE)
# checks data, handles errors, auditing tables
# adding salary column to employees table
alter table employees add salary decimal(10,2) after hourly_pay;
# updating employees table
update employees set salary=hourly_pay*2080 ;

# creating a trigger
delimiter //
create trigger before_hourly_pay_update
    before update on employees
    for each row
    begin
        set new.salary=new.hourly_pay*2080;
    end //
delimiter ;
# if we increment hourly_pay, salary will be calculated automatically
update employees set hourly_pay=hourly_pay+1;
# what the above trigger does?
# when we update hourly_pay, salary will be calculated automatically
# create trigger
delimiter //
create trigger before_hourly_pay_insert
    before insert on employees
    for each row
    begin
        set new.salary=new.hourly_pay*2080;
    end //
delimiter ;
# what the above trigger does?
# when we insert a new employee, salary will be calculated automatically
# creating table expenses
drop table if exists expenses;
create table expenses (
    expense_id int  primary key,
    expense_name varchar(50) ,
    expense_total decimal(10,2)
);
select * from expenses;
# updating expenses table calulatign total salary of employees
update expenses set expense_total=(select sum(salary) from employees) where expense_name="salaries";
# when ever we delete an employee from employees table, we want to update expenses table
# creating trigger
delimiter //
create trigger after_employee_delete
    after delete on employees
    for each row
    begin
        update expenses set expense_total=expense_total-old.salary where expense_name="salaries";
    end //
delimiter ;
# what the above trigger does?
# when we delete an employee, salary will be deducted from expenses table
# deleting an employee from employees table
delete from employees where employee_id=6;
select * from expenses;
# creating trigger when add new employee
delimiter //
create trigger after_employee_insert
    after insert on employees
    for each row
    begin
        update expenses set expense_total=expense_total+new.salary where expense_name="salaries";
    end //
delimiter ;
# what the above trigger does?
# when we add new employee, salary will be added to expenses table
# inserting new employee
# create trigger
delimiter //
create trigger after_salary_update
    after update on employees
    for each row
    begin
        update expenses set expense_total=expense_total+(new.salary-old.salary) where expense_name="salaries";
    end //
delimiter ;
# what the above trigger does?
# when we update salary, salary will be updated in expenses table
# updating salary
update employees set hourly_pay=100 where employee_id=1;