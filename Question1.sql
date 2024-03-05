create database eCommerce;
use eCommerce;

create table supplier(supp_id int primary key,supp_name varchar(50) not null,supp_city varchar(50),supp_phone varchar(10) not null);
create table customer(cus_id int primary key,cus_name varchar(50) not null,cus_phone varchar(10) not null,cus_city varchar(50),cus_gender char);
create table category(cat_id int primary key,cat_name varchar(50) not null);
create table product(pro_id int primary key,pro_name varchar(50) not null default "Dummy",pro_desc varchar(60),cat_id int references category);
create table supplier_pricing(pricing_id int primary key,pro_id int references product,supp_id int references supplier,supp_price int default 0);
create table orderr(ord_id int primary key,ord_amount int not null,ord_date date,cus_id int references cutomer,pricing_id int references supplier_pricing);
create table rating(rat_id int primary key,ord_id int references orderr,rat_ratstars int not null);
