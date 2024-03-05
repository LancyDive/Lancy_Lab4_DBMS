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

=========================================
created a 'displaySupplierDetails' procedures
==============================================
call displaySupplierDetails();
