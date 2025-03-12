WITH SelectCTE
AS
(
select sum(totaldue) total, 
YEAR(orderdate ) order_year
from sales.SalesOrderHeader
group by YEAR(orderdate ))
SELECT total Total,order_year [Year],
LAG(total) over (order by order_year) [Prev. Year],
total-LAG(total) over (order by order_year)  [Difference],
format((total-LAG(total) over (order by order_year))*100.0/total,'N2') 
YoY
from SelectCTE


create function gdaf()
returns table
AS
return(
WITH SelectCTE
AS
(
select sum(totaldue) total, 
YEAR(orderdate ) order_year
from sales.SalesOrderHeader
group by YEAR(orderdate ))
SELECT total Total,order_year [Year],
LAG(total) over (order by order_year) [Prev. Year],
total-LAG(total) over (order by order_year)  [Difference],
format((total-LAG(total) over (order by order_year))*100.0/total,'N2') 
YoY
from SelectCTE)

select*from dbo.gdaf()