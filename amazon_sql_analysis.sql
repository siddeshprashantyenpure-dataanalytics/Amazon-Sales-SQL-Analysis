-- create database amazon;

use amazon;

-- alter table amazon_sale change `index` Index_Number int;
-- alter table amazon_sale change `Order ID` Order_ID text;
-- alter table amazon_sale change `Sales Channel` Sales_Channel text;
-- alter table amazon_sale change `ship-service-level` Ship_Service_Level text;
-- alter table amazon_sale change `Courier Status` Courier_Status text;
-- alter table amazon_sale change `currency` Currency text;
-- alter table amazon_sale change `ship-city` Ship_City text;
-- alter table amazon_sale change `ship-state` Ship_State text;
-- alter table amazon_sale change `ship-postal-code` Ship_Postal_Code double;
-- alter table amazon_sale change `ship-country` Ship_Country text;
-- alter table amazon_sale change `promotion-ids` Promotion_Ids text;
-- alter table amazon_sale change `fulfilled-by` Fulfilled_By text;
-- alter table amazon_sale drop column Ship_City;
-- alter table amazon_sale drop column Date;
-- alter table amazon_sale drop column `Unnamed: 22`;

-- =====================================================================================================================================================================================
/*
-- Step 2 : Data Exploration
select * from amazon_sale limit 100;

select count(*) as Total_Orders from amazon_sale;

describe amazon_sale;

-- =========================================================================================================================================================================================
-- Step 3 : Data Quality Check 

-- 1.Check Null Values  
select
	sum(case when Index_Number is null then 1 else 0 end) as Null_Index_Numbers,
    sum(case when Order_ID is null then 1 else 0 end) as Null_Order_ID,
    sum(case when `Status` is null then 1 else 0 end) as Null_Status,
    sum(case when Fulfilment is null then 1 else 0 end) as Null_Fulfilment,
    sum(case when Sales_Channel is null then 1 else 0 end) as Null_Sales_Channel,
    sum(case when Ship_Service_Level is null then 1 else 0 end) as Null_Ship_Service_Level,
    sum(case when Style is null then 1 else 0 end) as Null_Style,
    sum(case when SKU is null then 1 else 0 end) as Null_SKU,
    sum(case when Category is null then 1 else 0 end) as Null_Category,
    sum(case when Size is null then 1 else 0 end) as Null_Size,
    sum(case when ASIN is null then 1 else 0 end) as Null_ASIN,
    sum(case when Courier_Status is null then 1 else 0 end) as Null_Courier_Status,
    sum(case when Qty is null then 1 else 0 end) as Null_Qty,
    sum(case when Currency is null then 1 else 0 end) as Null_Currency,
    sum(case when Amount is null then 1 else 0 end) as Null_Amount,
    sum(case when Ship_State is null then 1 else 0 end) as Null_Ship_State,
    sum(case when Ship_Postal_Code is null then 1 else 0 end) as Null_Ship_Postal_Code,
    sum(case when Ship_Country is null then 1 else 0 end) as Null_Ship_Country,
    sum(case when Promotion_Ids is null then 1 else 0 end) as Null_Promotion_Ids,
    sum(case when B2B is null then 1 else 0 end) as Null_B2B,
    sum(case when Fulfilled_By is null then 1 else 0 end) as Null_Fulfilled_By
from amazon_sale ;

-- 2.Check Empty Values
select
	sum(case when trim(Index_Number) = '' then 1 else 0 end) as Empty_Index_Numbers,
    sum(case when trim(Order_ID) = '' then 1 else 0 end) as  Empty_Order_ID,
    sum(case when trim(`Status`) = '' then 1 else 0 end) as  Empty_Status,
    sum(case when trim(Fulfilment) = '' then 1 else 0 end) as  Empty_Fulfilment,
    sum(case when trim(Sales_Channel) = '' then 1 else 0 end) as  Empty_Sales_Channel,
    sum(case when trim(Ship_Service_Level) = '' then 1 else 0 end) as  Empty_Ship_Service_Level,
    sum(case when trim(Style) = '' then 1 else 0 end) as  Empty_Style,
    sum(case when trim(SKU) = '' then 1 else 0 end) as  Empty_SKU,
    sum(case when trim(Category) = '' then 1 else 0 end) as  Empty_Category,
    sum(case when trim(Size) = '' then 1 else 0 end) as  Empty_Size,
    sum(case when trim(ASIN) = '' then 1 else 0 end) as  Empty_ASIN,
    sum(case when trim(Courier_Status) = '' then 1 else 0 end) as  Empty_Courier_Status,
    sum(case when trim(Qty) = '' then 1 else 0 end) as  Empty_Qty,
    sum(case when trim(Currency) = '' then 1 else 0 end) as  Empty_Currency,
    sum(case when trim(Amount) = '' then 1 else 0 end) as  Empty_Amount,
    sum(case when trim(Ship_State) = '' then 1 else 0 end) as  Empty_Ship_State,
    sum(case when trim(Ship_Postal_Code) = '' then 1 else 0 end) as  Empty_Ship_Postal_Code,
    sum(case when trim(Ship_Country) = '' then 1 else 0 end) as  Empty_Ship_Country,
    sum(case when trim(Promotion_Ids) = '' then 1 else 0 end) as  Empty_Promotion_Ids,
    sum(case when trim(B2B) = '' then 1 else 0 end) as  Empty_B2B,
    sum(case when trim(Fulfilled_By) = '' then 1 else 0 end) as  Empty_Fulfilled_By
from amazon_sale ;

-- 3.Check duplicate values
select Index_Number,
	count(*) as Duplicate_Values
    from amazon_sale
    group by Index_Number
    having count(*) > 1;
    
-- 4.Check invalid values

-- Checking for values which should always be greater than zero
delete from amazon_sale where Amount <= 0 or Qty <= 0;
select * from amazon_sale where Amount <= 0 or Qty <= 0;

-- Checking for distinct state names
update amazon_sale set Ship_State = 'NAGALAND' where Ship_State = 'NL';
update amazon_sale set Ship_State = 'PUNJAB' where Ship_State = 'Punjab/Mohali/Zirakpur';
update amazon_sale set Ship_State = 'RAJASTHAN' where Ship_State = 'Rajshthan';
update amazon_sale set Ship_State = 'RAJASTHAN' where Ship_State = 'RJ';
update amazon_sale set Ship_State = 'PUNJAB' where Ship_State = 'PB';
update amazon_sale set Ship_State = 'ODISHA' where Ship_State = 'orissa';
update amazon_sale set Ship_State = 'ARUNACHAL PRADESH' where Ship_State = 'AR';
delete from amazon_sale where trim(Ship_State) = "";
update amazon_sale set Status = 'Delivered' where Status = 'Shipped - Delivered to Buyer';
update amazon_sale set Status = 'Delivered' where Status = 'Shipped';
update amazon_sale set Status = 'Cancelled' where Status = 'Shipped - Returned to Seller';
update amazon_sale set Status = 'Cancelled' where Status = 'Shipped - Rejected by Buyer';
update amazon_sale set Status = 'Cancelled' where Status = 'Shipped - Returning to Seller';
update amazon_sale set Status = 'Delivered' where Status = 'Shipped - Picked Up';
update amazon_sale set Status = 'Lost' where Status = 'Shipped - Lost in Transit';
update amazon_sale set Status = 'Cancelled' where Status = 'Shipped - Out for Delivery';
select distinct(Status) from amazon_sale;

-- ==========================================================================================================================================================================================================================

-- Step 3 : Analysis 

-- A.Orders :
-- 1.Total Orders
select count(distinct Order_ID) as Total_Orders 
from amazon_sale;

-- 2.Total Revenue
select sum(round(amount,2)) as Total_Revenue 
from amazon_sale 
where Status = 'Delivered';

-- 3.Total Quantity
select sum(Qty) as Total_Quantity 
from amazon_sale;

-- 4.Average Order Value
select round(sum(Amount) / sum(Qty),2) as Average_Order_Value
from amazon_sale;

-- 5.Average Quantity
select round(avg(Qty),2) as Average_Quantity 
from amazon_sale;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- B.Order Status
-- select distinct(`Status`) from amazon_sale;

-- 1.Delivered Orders
select count(`Status`) as Delivered_Orders 
from amazon_sale 
where `Status` = 'Delivered';

-- 2.Cancelled Orders
select count(`Status`) as Cancelled_Orders 
from amazon_sale 
where `Status` = 'Cancelled';

-- 3.Pending Orders
select count(`Status`) as Pending_Orders 
from amazon_sale 
where `Status` = 'Pending';

-- 4.Cancelled %
select 
round(sum(case when Status = 'Cancelled' then 1 else 0 end) /
Count(Status) *100,2) as Total_Cancelled_Order_Percent
from amazon_sale;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- C.Revenue

-- Highest Revenue
select Category,Amount,
	sum(Amount) as Highest_Revenue
    from amazon_sale
    where Status = 'Delivered'
    group by Category
    order by Highest_Revenue desc
    LIMIT 1;

-- Lowest Revenue
select Category,Amount,
	sum(Amount) as Highest_Revenue
    from amazon_sale
    where Status = 'Delivered'
    group by Category
    order by Highest_Revenue asc
    LIMIT 1;
    
-- Average Revenue
select round(avg(Amount),2) from amazon_sale as Average_Revenue where Status = 'Delivered';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- D.Top Selling
-- 1.SKU
select SKU,
	count(Qty) as Total_Units_Sold
    from amazon_sale
    where Status = 'Delivered'
    group by SKU
    order by Total_Units_Sold desc;
    
-- 2.ASIN
select ASIN,
	count(Qty) as Total_Units_Sold
    from amazon_sale
    where Status = 'Delivered'
    group by ASIN
    order by Total_Units_Sold desc;
    
-- 3.Category
select Category,
	count(Qty) as Total_Units_Sold
    from amazon_sale
    where Status = 'Delivered'
    group by Category
    order by Total_Units_Sold desc;
    
-- 4.Style
select Style,
	count(Qty) as Total_Units_Sold
    from amazon_sale
    where Status = 'Delivered'
    group by Style
    order by Total_Units_Sold desc;
    
-- 5.Revenue by Category
select Category,
	sum(Amount) as Revenue
	from amazon_sale
    where Status = 'Delivered'
	group by Category
	order by Amount desc;

-- 6.Quantity by Category
select Category,
	sum(Qty) as Quantity
	from amazon_sale
	where Status = 'Delivered'
	group by Category
	order by Quantity desc;

-- 7.Top Selling Product
select Category as Top_Selling_Product
    from amazon_sale
    where Status = 'Delivered'
    group by Category
    order by sum(Qty) desc
    limit 1;
 
-- 8.Lowest Selling Product
select Category as Low_Selling_Product
    from amazon_sale
    where Status = 'Delivered'
    group by Category
    order by sum(Qty) asc
    limit 1;
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- E.Size Analysis
-- 1.Most Sold Size
select Size,
count(Size) as Quantity
from amazon_sale 
where Status = 'Delivered'
group by Size
order by Quantity desc
limit 1;

-- 2.Revenue by Size
select Amount,Size,
	sum(Amount) as Revenue
    from amazon_sale
    where Status = 'Delivered'
    group by Size
    order by Revenue desc ;

-- 3.Average Order Value by Size
select 
round((sum(Amount) / Count(Order_ID)),2) as Average_Order_Value
from amazon_sale;
	
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- F.Geography Analysis
-- 1.Revenue by State
select Ship_State,Amount,
sum(Amount) as Rev
from amazon_sale
where Status = 'Delivered'
group by Ship_State
order by Rev desc;

-- 2.Orders by State
select Ship_State,
count(Order_ID) as Orders
from amazon_sale
group by Ship_State
order by Orders desc;

-- 3.Contribution %
select Ship_State,
(count(Order_ID)  / (select count(Order_ID) from amazon_sale)*100) as Contri
from amazon_sale
group by Ship_State
order by Contri desc;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- G.Courier Analysis
-- 1.Courier Status Distribution
select Status,
count(Status) as Distribution
from amazon_sale
group by Status
order by Distribution desc;

-- 2.Courier Revenue
select sum(round(amount,2)) as Total_Revenue
from amazon_sale 
where Status = 'Delivered';

-- 3.Cancelled by Courier
select count(`Status`) as Cancelled_Orders 
from amazon_sale 
where `Status` = 'Cancelled';

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- H.B2B Customer Analysis
-- 1.Revenue
select sum(Amount) as B2B_Revenue
from amazon_sale 
where B2B = 'True' and Status = 'Delivered';

-- 2.Orders
select count(*) as B2B_Orders
from amazon_sale 
where B2B = 'True';

-- 3.Average Order Value
select sum(Amount) / count(*) as Average_B2B_Order_Value 
from amazon_sale 
where B2B = 'True' and Status = 'Delivered';

-- 4.Average Quantity
select round(sum(Qty) / count(*),2) as Average_B2B_Quantity from amazon_sale where B2B = 'True';

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- select count(Promotion_Ids) from amazon_sale where trim(Promotion_Ids) != "";
select count(Order_ID) from amazon_sale;

-- I.Promotion Analysis
-- 1.Orders Using Promotion
select count(Order_ID) as Orders_With_Promotion 
from amazon_sale 
where trim(Promotion_Ids) != "";

-- 2.Orders Without Promotion
select count(Order_ID) as Orders_Without_Promotion 
from amazon_sale 
where trim(Promotion_Ids) = " ";

-- 3.Revenue with Promotion
select sum(Amount) as Revenue_With_Promotion 
from amazon_sale 
where trim(Promotion_Ids) != "" and Status = 'Delivered';

-- 4.Revenue without Promotion
select sum(Amount) as Revenue_Without_Promotion 
from amazon_sale 
where trim(Promotion_Ids) = " " and Status = 'Delivered';

-- 5.Average Order Value
select round(sum(Amount) / count(Order_ID),2) as Average_Order_Value
from amazon_sale 
where trim(Promotion_Ids) != "" and Status = 'Delivered';

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- J.Group By Queries
-- 1.Find the total revenue generated by each product category.
select Category,sum(Amount) as Total_Revenue
from amazon_sale
where Status = 'Delivered'
group by Category
order by Total_Revenue desc;

-- 2. Find the total number of orders placed in each state.
select Ship_State,Count(Order_ID) as Total_Orders
from amazon_sale
group by Ship_State
order by Total_Orders desc;

-- 3. Find the total quantity sold for each product size.
select Size,sum(Qty) as Total_Quantity
from amazon_sale
where Status = 'Delivered'
group by Size
order by Total_Quantity desc;

-- 4. Show the top 5 State generating the highest revenue.
select Ship_State,sum(Amount) as Total_Revenue
from amazon_sale
where Status = 'Delivered'
group by Ship_State
order by Total_Revenue desc
limit 5;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- K. Case When Queries
-- 1. Categorize orders as:
	-- Low Value (< ₹500)
    -- Medium Value (₹500–₹2000)
	-- High Value (> ₹2000)
select Order_ID,
case
	when Amount < 500 then "Low_Value"
    when Amount between 500 and 2000 then "Medium_Value"
    when Amount > 2000 then "High_Value"
end as Category
from amazon_sale;    
    
-- 2. Classify orders into:
	-- Cancelled
	-- Delivered
	-- In Transit
	-- Other
select Order_ID,
case
	when Status = 'Delivered' then "Delivered"
    when Status = 'Cancelled' then 'Cancelled'
    when Status = 'Pending' then 'In Transit'
else 'Other' 
end as Order_Classification
from amazon_sale;
    
-- 3. Label states as:
	-- High Revenue
	-- Medium Revenue
	-- Low Revenue
-- based on their total revenue.
select Ship_State,sum(Amount) as Status_Revenue,
case
	when sum(Amount) < 500000 then 'Low Revenue'
    when sum(Amount) between 500000 and 1000000 then 'Medium Revenue'
    when sum(Amount) > 1000000 then 'High Revenue'
end as State_Category
from amazon_sale
where Status = 'Delivered'
group by Ship_State;

-- 4. Categorize products into:
	-- Small Order (Qty = 1)
	-- Medium Order (Qty = 2–4)
	-- Bulk Order (Qty ≥ 5)
select 
case 
	when Qty = 1 then 'Small Order'
    when Qty between 2 and 4 then 'Medium Order'
    when Qty >= 5  then 'Bulk Order'
end as Order_Quantity_Status
from amazon_sale;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- L. Having Queries
-- 1.Find categories with revenue greater than ₹1,00,000.
select Category,sum(Amount) as Revenue
from amazon_sale
where Status = 'Delivered'
group by Category
having sum(Amount) > 1000000;

-- 2. Find states having more than 5000 orders.
select Ship_State,count(Order_ID) as Orders
from amazon_sale
group by Ship_State
having count(Order_ID) > 5000;

-- 3. Find States where average order value is greater than ₹700.
select Ship_State,sum(Amount) / count(Order_ID) as Average_Order_Value
from amazon_sale
where Status = 'Delivered'
group by Ship_State
having (sum(Amount) / count(Order_ID)) > 700;

-- 4. Find product sizes that sold more than 8000 units.
select Size,sum(Qty) as Units_Sold 
from amazon_sale
group by Size
having sum(Qty) > 8000;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- M.Subqueries
-- 1.Find the second highest revenue-generating category.
select Category,sum(Amount) as Second_Highest_Revenue
from amazon_sale
group by Category
order by sum(Amount) desc
limit 1,1;

-- 2.Find products whose revenue is greater than the average product revenue.
select Category,sum(Amount)/count(Qty) as Revenue
from amazon_sale
where Status = 'Delivered'
group by Category
having  Revenue > (select round(sum(Amount) / count(Order_ID),2) from amazon_sale where Status = 'Delivered');

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- N. CTE Queries
-- 1.Using a CTE, calculate revenue by state and display the top 5 states.
with Revenue as(
	select Ship_State,sum(Amount) as State_Revenue
    from amazon_sale
    where Status = 'Delivered'
    group by Ship_State
    order by State_Revenue desc
)

select * from Revenue limit 5;

-- 2.Using a CTE, calculate category-wise revenue and sort it in descending order.
with Revenue as(
	select sum(Amount) as Category_Revenue,Category
    from amazon_sale
    where Status = 'Delivered'
    group by Category
    order by Category_Revenue desc
)

select * from Revenue;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- O.Window Functions
 -- A.ROW_NUMBER()
-- 1.Number orders within each state according to amount.
select Ship_State,Order_ID,Amount,
row_number() over(partition by Ship_State order by Amount desc)
from amazon_sale;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- P.Rank()
-- 1.Rank all categories by total revenue.
select Category,sum(Amount) as Total_Revenue,
rank() over(order by sum(Amount) desc) as Category_Rank
from amazon_sale
group by Category
order by Category_Rank;

-- 2.Rank states by total revenue.
select Ship_State,sum(Amount) as Total_Revenue,
rank() over(order by sum(Amount) desc) as Total_Revenue_Rank
from amazon_sale
group by Ship_State
order by Total_Revenue_Rank;

-- 3.Rank State by total orders.
select Ship_State,Count(Order_ID) as Total_Orders,
rank() over(order by Count(Order_ID) desc) as State_Order_Rank
from amazon_sale
group by Ship_State
order by Total_Orders desc;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q.DENSE_RANK()
-- 1.Display the top 3 revenue-generating categories.
select Category,sum(Amount) as Revenue,
dense_rank() over(order by sum(Amount)) as Category_Dense_Rank
from amazon_sale
group by Category
order by Category_Dense_Rank
limit 3;

-- 2.Rank product sizes by quantity sold.
select Size,sum(Qty),
dense_rank() over(order by sum(Qty)) as Size_Dense_Rank
from amazon_sale
group by Size
order by Size_Dense_Rank;

*/
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- R.LAG()
-- 1.Show each Category sale along with the previous Category sale.
select Category,sum(Qty) as Quantity,
lag(sum(Qty)) over(order by sum(Qty)) as Previous_Category
from amazon_sale
group by Category
order by Quantity;

-- S.LEAD()
-- 1.Compare current and next States revenue difference.
select Ship_State,sum(Amount) as Revenue,
lead(sum(Amount)) over(order by sum(Amount)) as Next_State_Revenue
from amazon_sale
group by Ship_State
order by Revenue;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------