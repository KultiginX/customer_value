-- select RiskID, count(customerNo) as "count" from iw_customer group by riskID order by count desc
-- select * from iw_customer
-- select * from iw_sales


select  a.riskid, 
sum(b.sum_without_vat) as "sum_of_sum_reveue", 
sum(c.return_sum) as "sum_return", 
sum(b.order_amount) as "sum_order_cost", 
sum(c.return_amount) as "sum_return_cost",
sum(b.sum_without_vat-coalesce(c.return_sum,0)- coalesce(b.order_amount,0)- coalesce(c.return_amount,0)) as "profit"
from
(select distinct customerNo, RiskID from iw_customer) a 

left join 
(select customerNo, SUM(amount) as "Sum_without_VAT",
count(orderNo)*9.5 as "order_amount"  
from iw_sales  group by customerNo) b
on a.customerNo=b.customerNo

left join 
(select customerNo, sum(line_amount) As "return_sum", 
count(returnNo)*5.8 As "return_amount" 
from iw_return_line group by customerNo) c
on b.customerNo=c.customerNo

where a.riskid in (13432486, 22681115, 58621705, 91704136) 

group by a.riskid
