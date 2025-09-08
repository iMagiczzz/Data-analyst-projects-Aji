-- Sales amounts are >2,000 and boxes are <100
Select * from sales
where Amount >2000 and boxes <100;

-- sales each salespersons had in the month of January 2022
select sum(s.Amount) as Sales, p.Salesperson from sales s
join people p on p.SPID = s.SPID
where s.SaleDate between '2022-01-01' and '2022-01-31'
group by p.Salesperson
order by p.Salesperson asc;

-- which product sales more between Milk Bars and Eclairs

select pr.Product, sum(s.Amount) as 'Total Amount' from sales s
join products pr on pr.pid = s.pid
where pr.product in ('Milk Bars','Eclairs')
group by pr.Product
order by 'Total Amount' desc;

-- Which product sold more boxes in the first 7 days of February 2022 between Milk Bars and Eclairs

select pr.Product, sum(s.boxes) as 'Total boxes' from sales s
join products pr on pr.pid = s.pid
where pr.product in ('Milk Bars','Eclairs') and s.SaleDate between '2022-02-01' and '2022-02-07'
group by pr.Product
order by 'Total boxes' desc;

-- Which shipments had under 100 customers & under 100 boxes and did any of them occur on Wednesday?
-- Shipments with under 100 customers and under 100 boxes
select * from sales
where customers < 100 and boxes < 100;
-- Shipments that occurred on Wednesday (weekday = 2)
select *, weekday(SaleDate) as Weekday from sales
where customers < 100 and boxes < 100 and weekday(SaleDate) = 2;

-- What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?

select distinct p.Salesperson from sales s
join people p on p.SPID = s.SPID
where s.amount >= 1 and s.SaleDate between '2022-01-01' and '2022-01-07'
order by p.Salesperson asc;

-- Which salespersons did not make any shipments in the first 7 days of January 2022?

select distinct p.Salesperson from sales s
join people p on p.SPID = s.SPID
where s.amount = 0 and s.amount = '' and s.SaleDate between '2022-01-01' and '2022-01-07'
order by p.Salesperson asc;

-- How many times we shipped more than 1.000 boxes in each month?

select date_format(s.SaleDate, '%Y-%m') as Dates , COUNT(*) as 'Shipments over 1000 boxes' from sales s
where s.boxes > 1000
group by Dates
order by Dates asc;

-- Did we ship at least one box of "After Nines" to "New Zealand" on all the months?

select date_format(s.SaleDate, '%Y-%m') as Dates, count(*) as 'Shipments Count' from sales s
join products pr on pr.PID = s.PID
join geo g on g.GEOID = s.GEOID
where pr.product = 'After Nines' and g.Geo = 'New Zealand' and s.amount > 0
group by Dates
order by Dates asc;

-- India or Australia? Who buys more chocolate boxes on a monthly basis?

select g.Geo, date_format(s.SaleDate, '%Y-%m') as Dates, sum(s.boxes) as 'Total boxes' from sales s
join products pr on pr.PID = s.PID
join geo g on g.GEOID = s.GEOID
where g.Geo in ('India','Australia') and pr.category in ('Bars','Bites')
group by g.Geo, Dates
order by Dates asc;