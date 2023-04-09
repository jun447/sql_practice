# create table customer customer_id ,first_name ,last_name
create table customer (
    customer_id int primary key auto_increment,
    first_name varchar(20),
    last_name varchar(20)
);
select * from customer;
# insert values into customers having id auto_increment
insert into customer (first_name, last_name) values ('Fred', 'Fish'),
                                                    ('larry', 'lobseter'),
                                                    ('Bubble', 'Bass');

drop table transactions;
create table transactions(
           transaction_id int primary key auto_increment,
           price decimal(8,2),
           customer_id int,
           foreign key (customer_id) references customer(customer_id)
);
select * from transactions;
# drop an foreign key
alter table transactions drop foreign key transactions_ibfk_1;
# add a foreign key with a name
alter table transactions add constraint fk_customer_id
    foreign key (customer_id) references customer(customer_id);
# setting value of auto_increment
ALTER TABLE transactions  AUTO_INCREMENT = 1000;
# insert values into transactions
insert into transactions (price, customer_id) values (40.00, 3),
                                                     (20.00, 2),
                                                     (30.00, 3),
                                                     (40.00, 1);
insert into transactions (price, customer_id) values (1.00, null);
# inserting into customers
insert into customer (first_name, last_name) values ('Poppy', 'Puff');
# inner join on customer_id and customer_id in transactions table and customer table
select * from transactions inner join customer on transactions.customer_id = customer.customer_id;
select transaction_id,price,first_name,last_name
       from transactions inner join customer on transactions.customer_id = customer.customer_id;
select transaction_id,price,first_name,last_name
       from transactions left join customer on transactions.customer_id = customer.customer_id;
select transaction_id,price,first_name,last_name
       from transactions right join customer on transactions.customer_id = customer.customer_id;
select transaction_id,price,first_name,last_name
       from transactions left outer join customer on transactions.customer_id = customer.customer_id;
select transaction_id,price,first_name,last_name
       from transactions right outer join  customer on transactions.customer_id = customer.customer_id;