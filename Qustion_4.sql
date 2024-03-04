select count(distinct c.cus_name) as 'Total Customers' , c.cus_gender from customer c
JOIN orderr o ON c.cus_id =o.cus_id
WHERE o.ord_amount >= 3000
 group by c.cus_gender;

or

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
group by cus_gender



