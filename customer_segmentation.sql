select * from marketing_campaign;
select count(*) as total from marketing_campaign
--------------------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;
## Update table
update marketing_campaign
set Marital_Status='Single'
where Marital_Status='Alone';

update marketing_campaign
set Marital_Status='In Relationship'
where Marital_status='Married';

update marketing_campaign
set Marital_Status='In Relationship'
where Marital_status='Together';

#update table to add column age group
alter table marketing_campaign
Add Age_Group varchar(10);

update marketing_campaign
set Age_group = case
	when 2015-Year_Birth <30 then '<30'
    when 2015-Year_Birth between 30 and 39 then '30-39'
    when 2015-Year_Birth between 40 and 49 then '40-49'
    else '50+'
 end;   
 
 ##Drop rows
delete from marketing_campaign
where Marital_Status IN ('YOLO','Absurd');
--------------------------------------------------------------------------------------
 select 
	Age_group,
	Marital_status, 
    count(*) as total,
    round(100*count(*) / (select count(*) from marketing_campaign),2) as percent
from marketing_campaign
group by Age_group, Marital_Status
order by total desc;

select
	Case 
		when Age_Group in ('30-39', '40-49', '50+') then '30+'
        else '<30'
	end as Age_Group,
    Marital_Status,
    sum(MntWines) as Wines,
    sum(MntFruits) as Fruits,
    sum(MntMeatProducts) as MeatProducts,
    sum(MntFishProducts) as FishProducts,
    sum(MntSweetProducts) as SweetProducts,
    sum(MntGoldProds) as GoldsProducts
from marketing_campaign
where Marital_status='In relationship'
group by 
	case 
		when Age_Group in ('30-39', '40-49', '50+') then '30+'
        else '<30' end;
        
##segmentation income
select income 
from marketing_campaign 
order by income
limit 1 offset 1105 ;
---------------------------------------------------
#update table
alter table marketing_campaign
add Income_group varchar(10);

update marketing_campaign
set Income_group = case
	when Income <51373 then 'low'
    else 'high'
end;
----------------------------------------------------------------------------------------
##segmentation spend
select 
	(MntWines+MntFruits+MntMeatProducts+MntFishProducts+MntSweetProducts+MntGoldProds) as spend
from marketing_campaign
order by spend
limit 1 offset 1105;

-----------------------------------------------
#update table
alter table marketing_campaign
add spend_group varchar(10);

update marketing_campaign
set spend_group = case
	when (MntWines+MntFruits+MntMeatProducts+MntFishProducts+MntSweetProducts+MntGoldProds) <396 then 'low'
    else 'high'
end;
------------------------------------------------------------------------------------------
##Customer Segmentation ##
select
    Income_Group,
    Spend_group,
    count(*) as total,
    sum(MntWines) as Wines,
    sum(MntFruits) as fruits,
    sum(MntMeatProducts) as meatproducts,
    sum(MntFishProducts) as fishproducts,
    sum(MntSweetProducts) as sweetproducts,
    sum(MntGoldProds) as goldproducts
from marketing_campaign
group by income_group, spend_group;

select
    Income_Group,
    Spend_group,
    count(*) as total,
    round(avg(MntWines),0) as Wines,
    round(avg(MntFruits),0) as fruits,
    round(avg(MntMeatProducts),0) as meatproducts,
    round(avg(MntFishProducts),0) as fishproducts,
    round(avg(MntSweetProducts),0) as sweetproducts,
    round(avg(MntGoldProds),0) as goldproducts
from marketing_campaign
group by income_group, spend_group;

select
    Income_Group,
    Spend_group,
    count(*) as total,
    avg(NumDealsPurchases) as dealspurchase,
    avg(NumWebPurchases) as webpurchase,
    avg(NumCatalogPurchases) as catalogpurchase,
    avg(NumStorePurchases) as storepurchase
from marketing_campaign
group by income_group, spend_group;