select * from orderr o
inner join supplier_pricing sp
on o.pricing_id = sp.pricing_id
inner join product p 
on p.pro_id = sp.pro_id
where cus_id = 2;
