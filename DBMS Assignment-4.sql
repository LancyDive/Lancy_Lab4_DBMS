create database eCommerce;
use eCommerce;
create table supplier(supp_id int primary key,supp_name varchar(50) not null,supp_city varchar(50),supp_phone varchar(10) not null);
create table customer(cus_id int primary key,cus_name varchar(50) not null,cus_phone varchar(10) not null,cus_city varchar(50),cus_gender char);
create table category(cat_id int primary key,cat_name varchar(50) not null);
create table product(pro_id int primary key,pro_name varchar(50) not null default "Dummy",pro_desc varchar(60),cat_id int references category);
create table supplier_pricing(pricing_id int primary key,pro_id int references product,supp_id int references supplier,supp_price int default 0);
create table orderr(ord_id int primary key,ord_amount int not null,ord_date date,cus_id int references cutomer,pricing_id int references supplier_pricing);
create table rating(rat_id int primary key,ord_id int references orderr,rat_ratstars int not null);

insert into supplier values(1,"Rajesh Retails","Delhi","1234567890");
insert into supplier values(2,"Appario Ltd","Mumbai","2589631470");
insert into supplier values(3,"Knome products","Banglore","9785462315");
insert into supplier values(4,"Bansal Retails","Kochi","8975463285");
insert into supplier values(5,"Mittal Ltd.","Lucknow","7898456532");

select * from supplier;

insert into customer values(1,"AAKASH","9999999999","DELHI",'M');
insert into customer values(2,"AMAN","9785463215","NOIDA",'M');
insert into customer values(3,"NEHA","9999999999","MUMBAI",'F');
insert into customer values(4,"MEGHA","9994562399","KOLKATA",'F');
insert into customer values(5,"PULKIT","7895999999","LUCKNOW",'M');

select * from customer;

insert into category values(1,"BOOKS");
insert into category values(2,"GAMES");
insert into category values(3,"GROCERIES");
insert into category values(4,"ELECTRONICS");
insert into category values(5,"CLOTHES");

insert into product values(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
insert into product values(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
insert into product values(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
insert into product values(4,"OATS","Highly Nutritious from Nestle ",3);
insert into product values(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
insert into product values(6,"MILK","1L Toned MIlk",3);
insert into product values(7,"Boat Earphones","1.5Meter long Dolby Atmos",4);
insert into product values(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
insert into product values(9,"Project IGI ","compatible with windows 7 and above",2);
insert into product values(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
insert into product values(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
insert into product values(12,"Train Your Brain","By Shireen Stephen",1);

insert into supplier_pricing values(1,1,2,1500);
insert into supplier_pricing values(2,3,5,30000);
insert into supplier_pricing values(3,5,1,3000);
insert into supplier_pricing values(4,2,3,2500);
insert into supplier_pricing values(5,4,1,1000);
insert into supplier_pricing values(6,12,2,780);
insert into supplier_pricing values(7,12,4,789);
insert into supplier_pricing values(8,3,1,31000);
insert into supplier_pricing values(9,1,5,1450);
insert into supplier_pricing values(10,4,2,999);
insert into supplier_pricing values(11,7,3,549);
insert into supplier_pricing values(12,7,4,529);
insert into supplier_pricing values(13,6,2,105);
insert into supplier_pricing values(14,6,1,99);
insert into supplier_pricing values(15,2,5,2999);
insert into supplier_pricing values(16,5,2,2999);

insert into orderr values(101,1500,"2021-10-06",2,1);
select * from orderr;
insert into orderr values(102,1000,"2021-10-12",3,5);
insert into orderr values(103,30000,"2021-09-16",5,2);
insert into orderr values(104,1500,"2021-10-05",1,1);
insert into orderr values(105,3000,"2021-08-16",4,3);
insert into orderr values(106,1450,"2021-08-18",1,9);
insert into orderr values(107,789,"2021-09-01",3,7);
insert into orderr values(108,780,"2021-09-07",5,6);
insert into orderr values(109,3000,"2021-01-10",5,3);
insert into orderr values(110,2500,"2021-09-10",2,4);
insert into orderr values(111,1000,"2021-09-15",4,5);
insert into orderr values(112,789,"2021-09-16",4,7);
insert into orderr values(113,31000,"2021-09-16",1,8);
insert into orderr values(114,1000,"2021-09-16",3,5);
insert into orderr values(115,3000,"2021-09-16",5,3);
insert into orderr values(116,99,"2021-09-17",2,14);

insert into rating values(1,101,4);
insert into rating values(2,102,3);
insert into rating values(3,103,1);
insert into rating values(4,104,2);
insert into rating values(5,105,4);
insert into rating values(6,106,3);
insert into rating values(7,107,4);
insert into rating values(8,108,4);
insert into rating values(9,109,3);
insert into rating values(10,110,5);
insert into rating values(11,111,3);
insert into rating values(12,112,4);
insert into rating values(13,113,2);
insert into rating values(14,114,1); 
insert into rating values(15,115,1);
insert into rating values(16,116,0);

select count(distinct c.cus_name) as 'Total Customers' , c.cus_gender from customer c
JOIN orderr o ON c.cus_id =o.cus_id
WHERE o.ord_amount >= 3000
 group by c.cus_gender;

set SQL_MODE = '';

select count(cus_name) as 'Total Customers', cus_gender from (
	select * from (
		select C.CUS_NAME, C.CUS_GENDER, O.* from customer c
		inner join 
		`orderr` o
		on c.CUS_ID = o.cus_id
		where o.ord_amount >= 3000
	) as CO
	group by CO.cus_id
) as CO2
group by cus_gender;

select * from orderr o
inner join supplier_pricing sp
on o.pricing_id = sp.pricing_id
inner join product p 
on p.pro_id = sp.pro_id
where cus_id = 2;

select * from supplier where supp_id in (
select supp_id from supplier_pricing 
group by supp_id
having count(supp_id) > 1
order by supp_id
);

select C.CAT_ID, C.CAT_NAME, 
Min(SP_P.MinPrice) as 'MinPrice'
 from Category C inner join (
	select P.*, SP.MinPrice from product P inner join (
		select pro_id, min(SUPP_PRICE) as MinPrice from supplier_pricing 
		group by pro_id
	) as SP
	on P.pro_id = SP.PRO_ID
) as SP_P
on C.CAT_ID = SP_P.CAT_ID
group by SP_P.CAT_ID;

select c.cat_id, c.cat_name, min(sp.supp_price) as price  from category as c
inner join product as p on p.cat_id = c.cat_id 
inner join supplier_pricing as sp on sp.pro_id = p.pro_id
group by c.cat_id;

select p.pro_id, p.pro_name, o.ord_date from product p
inner join supplier_pricing sp
on  p.pro_id = sp.pro_id
inner join orderr o
on sp.pricing_id = o.pricing_id
where o.ord_date > "2021-10-05";

select  cus_name, cus_gender from customer where cus_name like 'A%'
or cus_name like '%A';

select s.supp_name, SP_RO_2.*,

CASE 
	when AverageRating = 5 then 'Excellent Service'
    when AverageRating > 4 then 'Good Service'
    when AverageRating > 2 then 'Average Service'
    else 'Poor Service'
END as 'Type_of_Service'
 from supplier s inner join (
	select supp_id, avg(rat_ratstars) as AverageRating from (
		select sp.supp_id, RO.ord_id, RO.rat_ratstars from supplier_pricing sp inner join (
			select o.ord_id, o.pricing_id, r.rat_ratstars from orderr o 
			inner join rating r
			on o.ord_id = r.ord_id
		) as RO
		on sp.pricing_id = RO.pricing_id	
	) as SP_RO
	group by supp_id
) as SP_RO_2
on s.supp_id = SP_RO_2.supp_id