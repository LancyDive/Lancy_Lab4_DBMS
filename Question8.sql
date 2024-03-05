select p.pro_id, p.pro_name, o.ord_date from product p
inner join supplier_pricing sp
on  p.pro_id = sp.pro_id
inner join orderr o
on sp.pricing_id = o.pricing_id
where o.ord_date > "2021-10-05";
