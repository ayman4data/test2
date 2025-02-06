# What are the optimal skills to become a data analyst
Dive into the data job market! Focusing on data
analyst roles, this project explores top-paying
jobs, in—demand skills, and where high
demand meets high salary in data analytics.
SQL queries? Check them out here: [project_sql folder](/project_sql/) .
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born
desire to pinpoint top-paid and in-demand
streamlining others work to find optimal jobs
Data hails from my [SQL Course] (https://
lukebarousse.com/sql). It's tacked with insights
on job titles, salaries, locations, and essential
skills.
The questions I wanted to answer through my
SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn
# Toots I Used
For my deep dive into the data analyst job market,
I harnessed the power Of several key toots:
- **SQL:** The backbone of my analysis, allowing me to
query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management
system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database
management and executing SQL queries.
- **Git & GitHub:** Essential for version control and
sharing my SQL scripts and analysis, ensuring
collaboration and project tracking.
# The Analysis
Each query for this project aimed at investigating
specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered
data analyst positions by average yearly salary
and location, focusing on remote jobs. This query
highlights the high paying opportunities in the
field.
```SQL
SELECT
    job_id ,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact jpf
LEFT JOIN company_dim cd 
ON jpf.company_id=cd.company_id
WHERE
     job_title_short='Data Analyst' AND
     job_location = 'Anywhere' AND
     salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown Of the top data analyst jobs
in 2023:
- **Wide Salary Range:** Top 10 paying data
analyst roles span from $184,000 to $650,000,
indicating significant salary potential in the
field.
- **Diverse Employers:** Companies like
SmartAsset, Meta, and AT&T are among those
offering high salaries, showing a broad interest
across different industries.
- **Job Title Variety:** There's a high diversity
in job titles, from Data Analyst to Director of
Analytics, reflecting varied roles and
specializations within data analytics.

| job_title                                           | salary_year_avg |
|-----------------------------------------------------|-------------------|
| Data Analyst                                        | 650000.0          |
| Director of Analytics                               | 336500.0          |
| Associate Director- Data Insights                   | 255829.5          |
| Data Analyst, Marketing                             | 232423.0          |
| Data Analyst (Hybrid/Remote)                        | 217000.0          |
| Principal Data Analyst (Remote)                     | 205000.0          |
| Director, Data Analyst - HYBRID                     | 189309.0          |
| Principal Data Analyst, AV Performance Analysis     | 189000.0          |
| Principal Data Analyst                              | 186000.0          |
| ERM Data Analyst                                    | 184000.0          |

*Table of the highest paying jobs in data
analyst job postings*
### 2. Skills For Top Paying Jobs

```SQL
WITH top_paying_jobs AS(
    SELECT
        job_id ,
        job_title,
        salary_year_avg,
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
)
SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs 
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```

| Skill        | Average Salary    |
|--------------|-------------------|
| sql          | \$216,207.33      |
| python       | \$221,422.17      |
| r            | \$221,084.17      |
| tableau      | \$219,708.90      |
| azure        | \$227,712.83      |
| snowflake    | \$219,109.67      |
| pandas       | \$218,716.67      |
| excel        | \$218,716.67      |
| go           | \$192,333.33      |
| aws          | \$227,712.83      |

*Table of the highest paying skills in data
analyst job postings*
### 3. Top Demanded Skills For Data Analytics
```SQL
SELECT 
    skills ,
    COUNT(skills_job_dim.job_id) demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND 
    job_work_from_home is TRUE
GROUP BY skills
ORDER BY demand_count DESC
limit 10;
```
### 4. Top Data Analyst Skills Based On Salary
```SQL
SELECT 
    skills ,
    ROUND(AVG(salary_year_avg),0) avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg is NOT NULL AND 
    job_work_from_home is TRUE
GROUP BY skills
ORDER BY avg_salary DESC
limit 10;
```
### 5. Top Optimal Skills To Learn
```SQL
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills ,
        COUNT(skills_job_dim.job_id) demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        salary_year_avg is NOT NULL AND 
        job_work_from_home is TRUE
    GROUP BY skills_dim.skill_id
),average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills ,
        ROUND(AVG(salary_year_avg),0) avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        salary_year_avg is NOT NULL AND 
        job_work_from_home is TRUE
    GROUP BY skills_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    avg_salary,
    demand_count
FROM skills_demand 
INNER JOIN average_salary ON skills_demand.skill_id=average_salary.skill_id
WHERE demand_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC;
```

# What I Learned
# Conclusions