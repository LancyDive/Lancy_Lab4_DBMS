select * from supplier where supp_id in (
select supp_id from supplier_pricing 
group by supp_id
having count(supp_id) > 1
order by supp_id
)
