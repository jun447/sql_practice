create table products(
   product_id int,
    product_name varchar(50) unique ,
    price decimal(4,2)
#   adding an check constraint
#     constraint chk_hrly_pay  check(price>10.00)
#  adding an default constraint
#     default 50.00
#     primary key(product_id)
);
# if we forgot to add unique constraint then we can add it later
# alter table products add constraint unique(product_name);
select * from products;
# add 5 products to the table
insert into products values (1,'laptop',100.0),
                            (2,'mobile',500.0),
                            (3,'tablet',300.0),
                            (4,'tv',200.0),
                            (5,'watch',100.0);
ALTER TABLE products MODIFY price decimal(8,2);
# if we forgot to add not null constraint then we can add it later
ALTER TABLE products MODIFY COLUMN price decimal(8,2) NOT NULL;
insert into products values (6,'apple',null);
# if we forgot to add check constraint then we can add it later
ALTER TABLE products ADD CONSTRAINT chk_price CHECK(price>10.00);
# droping check constraint
ALTER TABLE products DROP CONSTRAINT chk_price;
# if we forgot to add default constraint then we can add it later
ALTER TABLE products alter column price set default 50.00;
insert into products(product_id, product_name) values (7,'Protector');

# create table named transactions
create table transactions(
    transaction_id int,
    price decimal(8,2),
    transaction_date datetime default now()
);
select * from transactions;
# add 5 transactions to the table
insert into transactions(transaction_id, price) values (1,100.0),
                                                        (2,500.0),
                                                        (3,300.0),
                                                        (4,200.0),
                                                        (5,100.0);
# if we forgot to add primary key constraint then we can add it later
ALTER TABLE transactions ADD CONSTRAINT pk_transaction_id PRIMARY KEY(transaction_id);
# set primary key to auto increment
ALTER TABLE transactions MODIFY transaction_id int auto_increment;
# set primary key to auto increment=20
ALTER TABLE transactions  AUTO_INCREMENT = 20;
# inserting data after auto increment
insert into transactions(price) values (849.0);

