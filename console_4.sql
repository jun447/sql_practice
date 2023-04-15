alter table employees add column job varchar(20) after hourly_pay ;
select * from employees;
# updating employees table by inserting job column values
update employees set job = 'asst .manager' where employee_id = 5;

select * from employees where hire_date<'2000-02-01';
select * from employees where not job='asst .manager' and not job='manager';
select * from employees where hire_date between '2000-02-01' and '2000-02-28';
select * from employees where job in ('asst .manager','manager');
# wild card characters
select * from employees where first_name like 'r%';
select * from employees where job like '%manager';
select * from employees where hire_date like '2000%';

select * from employees where last_name like '_mith';
select * from employees where employees.job like 'c__k';
select * from employees where hire_date like '____-01-__';

select * from employees where job like '_a%';

select * from employees order by last_name desc ;

select * from transactions order by price,customer_id;
select * from  employees;
select * from employees limit 4,1; #after 4 will return 1 row
# create query for table name expenses having data
# expense_name  amount
# wages         -250000.00
# tax            -50000.00
# repairs         -15000.00

CREATE TABLE expenses (
                          expense_name VARCHAR(50),
                          amount DECIMAL(10, 2)
);

INSERT INTO expenses (expense_name, amount) VALUES
                                                ('wages', -250000.00),
                                                ('tax', -50000.00),
                                                ('repairs', -15000.00);
CREATE TABLE income (
                          income_name VARCHAR(50),
                          amount DECIMAL(10, 2)
);

INSERT INTO income (income_name, amount) VALUES
                                                ('order', 1000000.0),
                                                ('merchandise', 50000.00),
                                                ('services', 125000.00);

SELECT * FROM expenses
UNION
SELECT * FROM income AS Names_of_expenses_and_income;

select first_name,last_name from employees
 UNION all #also return duplicates
 select first_name,last_name from customer;

select * from employees;

 select * from customer;
insert into customer values (5,'John','Doe');
# delete the above inserted row
delete from customer where customer_id=5;

# self join
# join a table with itself
# used to compare rows of the same table
# helps to display a hierarchy of data
alter table customer add referral_id int;
update customer set referral_id=2 where customer_id=4;
# so we will replace the referral_id with the Name of the customer who referred the customer
select a.customer_id ,a.first_name,a.last_name,concat(b.first_name," ",b.last_name) as referred_by
    from customer as a inner join customer as b on a.referral_id=b.customer_id;
select a.customer_id ,a.first_name,a.last_name,concat(b.first_name," ",b.last_name) as referred_by
from customer as a left join customer as b on a.referral_id=b.customer_id;

select a.customer_id ,a.first_name,a.last_name,concat(b.first_name," ",b.last_name) as referred_by
from customer as a right join customer as b on a.referral_id=b.customer_id;

select * from employees;
# adding super_visor_id column to employees table
alter table employees add super_visor_id int;
update employees set super_visor_id=1 where employee_id=5;

select a.employee_id,a.first_name,a.last_name,concat(b.first_name," ",b.last_name) as super_visor
    from employees as a inner join employees as b on a.super_visor_id=b.employee_id;

