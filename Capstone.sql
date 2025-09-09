select * from capstone;

-- Total Customers
select count(*) as total_customers from capstone;

-- Total churned customers
select count(*) as churned_customers
from capstone
where churn = 'yes';

-- Churn Rate
select round(100.0 * sum(case when churn = 'yes' then 1 else 0 end) / count(*), 2) as churn_rate_percentage
from capstone;

-- churn by gender
select gender,
		count(*) as Total_customers,
        sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
        round(100.0 * sum(case when churn = 'yes' then 1 else 0 end) / count(*), 2) as churn_rate
from capstone
group by gender;

-- churn by senior citizen
select (case when seniorcitizen = 1 then 'Yes' else 'No' end) as seniorcitizen,
		count(*) as total_customers,
        sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,
        round(100.0 * sum(case when churn = 'yes' then 1 else 0 end) / count(*), 2) as churn_rate
from capstone
group by seniorcitizen;
        
-- churn by partner & dependents
select partner, dependents,
		count(*) as total_customers,
        sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
        round(100.0 * sum(case when churn = 'yes' then 1 else 0 end) / count(*), 2) as churn_rate
from capstone
group by partner, dependents
order by churn_rate desc;

-- churn by contract type
select contract,
		count(*) as total_customers,
        sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
        round(100.0 * sum(case when churn = 'yes' then 1 else 0 end) / count(*), 2) as churn_rate
from capstone
group by contract;

-- churn by internet service
SELECT InternetService,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM capstone
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- Average charges & Tenure by churn
select churn,
		round(avg(monthlycharges), 2) as avg_monthly_charges,
        round(avg(totalcharges), 2) as avg_total_charges,
        round(avg(tenure), 2) as avg_tenure
from capstone
group by churn
order by churn desc;

-- churn by tenure groups
select
	case
		when tenure between 0 and 12 then '0-12 months'
        when tenure between 13 and 24 then '13-24 months'
        when tenure between 25 and 48 then '25-48 months'
        else '49+ months'
	end as tenure_group,
    count(*) as total_customers,
    sum(case when churn = 'Yes' then 1  else 0 end) as churned_customers,
    round(100.0 * sum(case when churn ='yes' then 1 else 0 end) / count(*), 2) as churn_rate
from capstone
group by tenure_group
order by churn_rate desc;

-- High-Risk segment (Combination of factors)
select contract, InternetService, PaymentMethod,
		count(*) as total_customers,
        sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,
        round(100.0 * sum(case when churn = 'yes' then 1 else 0 end) / count(*), 2) as churn_rate
from capstone
group by contract, internetservice, paymentmethod
order by churn_rate desc;
