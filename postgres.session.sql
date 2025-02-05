CREATE table march_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE  EXTRACT(MONTH FROM job_posted_date)=3
    
SELECT 
    COUNT(job_id) number_of_jobs,
    case
         when job_location = 'Anywhere' THEN 'Remot'
        when job_location = 'New York, NY' THEN 'Local'
        else 'On Site' 
        end AS location_bracket
FROM job_postings_fact
WHERE job_title_short= 'Data Analyst'
GROUP BY location_bracket

SELECT COUNT(job_title_short),
    case
    when salary_year_avg between 20000 and 35000 THEN 'Low'
    when salary_year_avg between 35001 and 55000 THEN 'Medium'
    else 'High'
    end AS income_bucket
FROM job_postings_fact
WHERE job_title_short ='Data Analyst'
GROUP BY income_bucket ,job_title_short
SELECT salary_year_avg FROM job_postings_fact
WHERE job_title_short ='Data Analyst'
ORDER BY salary_year_avg 
LIMIT 1000

CREATE table march_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE  EXTRACT(MONTH FROM job_posted_date)=3
    
SELECT 
    COUNT(job_id) number_of_jobs,
    case
         when job_location = 'Anywhere' THEN 'Remot'
        when job_location = 'New York, NY' THEN 'Local'
        else 'On Site' 
        end AS location_bracket
FROM job_postings_fact
WHERE job_title_short= 'Data Analyst'
GROUP BY location_bracket

SELECT COUNT(job_title_short),
    case
    when salary_year_avg between 20000 and 35000 THEN 'Low'
    when salary_year_avg between 35001 and 55000 THEN 'Medium'
    else 'High'
    end AS income_bucket
FROM job_postings_fact
WHERE job_title_short ='Data Analyst'
GROUP BY income_bucket ,job_title_short
SELECT salary_year_avg FROM job_postings_fact
WHERE job_title_short ='Data Analyst'
ORDER BY salary_year_avg 
LIMIT 1000

with company_job_count AS (
    SELECT 
            company_id,
            count(*) as total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name,
company_job_count.total_jobs FROM company_dim left JOIN company_job_count
on company_dim.company_id = company_job_count.company_id
ORDER BY total_jobs desc
LIMIT 10



SELECT * FROM skills_job_dim JOIN skills_dim
on skills_job_dim.skill_id=skills_dim.skill_id
GROUP BY skills_dim.skill_id
LIMIT 1000

SELECT
    s.skills,
    skill_counts.skill_id,
    skill_counts.count
FROM
    (SELECT
        skill_id,
        COUNT(*) AS count
     FROM
        skills_job_dim
     GROUP BY
        skill_id
     ORDER BY
        count DESC
     LIMIT 5) AS skill_counts
JOIN
    skills_dim s
ON
    skill_counts.skill_id = s.skill_id;

SELECT * FROM (
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs) q1
    WHERE job_title_short ='Data Analyst' and salary_year_avg>70000
    ORDER BY salary_year_avg DESC