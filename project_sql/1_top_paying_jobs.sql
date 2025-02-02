/*Question: What are the top—paying data analyst jobs?
— Identify the top 10 highest—paying Data Analyst roles that are available remotely.
— Focuses on job postings with specified salaries (remove nulls).
— Why? Highlight the top-paying opportunities for Data Analysts, offering insights 
into employment
*/
SELECT  job_id ,
job_title,
job_location,
salary_year_avg,
job_posted_date,
name AS company_name
FROM 
    job_postings_fact jpf
LEFT JOIN company_dim cd ON jpf.company_id=cd.company_id
WHERE
     job_title_short='Data Analyst' AND
     job_location = 'Anywhere' AND
     salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10
--for data scientist in dubai
SELECT  job_id ,
job_title,
job_location,
salary_year_avg,
job_posted_date,
name AS company_name
FROM 
    job_postings_fact jpf
LEFT JOIN company_dim cd ON jpf.company_id=cd.company_id
WHERE
     --job_title_short='Data Scientist' AND
     job_location LIKE 'United Arab Emirates' AND
     salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 1000

