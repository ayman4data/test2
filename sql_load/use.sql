SELECT 
    name,job_health_insurance,
    EXTRACT(MONTH from job_posted_date) AS MONTH,
    EXTRACT(YEAR from job_posted_date) AS YEAR,
    COUNT(*)
FROM
    job_postings_fact JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id

WHERE
   job_health_insurance='true'AND
   EXTRACT(YEAR from job_posted_date) =2023 AND
    EXTRACT(MONTH from job_posted_date) IN (4,5,6)
GROUP BY 
   name, job_health_insurance, MONTH, YEAR
ORDER BY
    MONTH

