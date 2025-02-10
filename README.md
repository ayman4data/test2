# What are the optimal skills to become a data analyst
Dive into the data job market! Focusing on data
analyst roles, this project explores top-paying
jobs, in-demand skills, and where high
demand meets high salary in data analytics.
SQL queries? Check them out here: [project_sql folder](/project_sql/) .
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born
desire to pinpoint top-paid and in-demand
streamlining others work to find optimal jobs
Data hails from this YouTuber's course [SQL Course] (https://lukebarousse.com/sql).
It's tacked with insights
on job titles, salaries, locations, and essential
skills.
The questions I wanted to answer through my
SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
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
To identify the top paying job skills, I filtered
data analyst positions by average yearly salary
and location, focusing on remote jobs. This query
highlights the high paying job skills in the
field.

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
**Top Skills for High-Paying Jobs:**
- SQL, Python, and R appear frequently across the top-paying roles, confirming their status as fundamental skills for data analysts.
- Cloud technologies (Azure, AWS, Snowflake, Databricks) are also prevalent, suggesting that cloud experience is highly valued.
- Tableau and Power BI are common visualization tools, highlighting the importance of data presentation skills.

**Job Title & Skill Correlation:**
- Associate Director - Data Insights (AT&T): This role requires a broad skillset, including SQL, Python, R, Azure, Databricks, AWS, Pandas, PySpark, Jupyter, Excel, Tableau, Power BI, and PowerPoint. This suggests that leadership positions demand a diverse set of skills.
- Data Analyst, Marketing (Pinterest): This position uses SQL, Python, R, Hadoop, and Tableau, showing a focus on data analysis within a marketing context.
- Director, Data Analyst (Inclusively): This role requires knowledge of Cloud (Azure, AWS, Snowflake), Databases (Oracle, SAP), and DevOps tools (Jenkins, Bitbucket, Atlassian, Jira, Confluence), indicating an emphasis on data infrastructure and project management.
- Principal Data Analyst (SmartAsset): This role requires SQL, Python, Go, Snowflake, Pandas, NumPy, Excel, Tableau, and Gitlab, which suggests the need for expertise in data analysis, programming, and version control.

**Skill Specialization:**
- Some roles show specialization. For example, the Inclusively role involves DevOps tools, while the Pinterest role mentions Hadoop.

**Actionable Insights for Job Seekers:**
- **Prioritize SQL, Python, and R:** These are foundational skills.
- **Learn Data Visualization:** Master Tableau or Power BI.
- **Consider Cloud Technologies:** Gaining experience with Azure, AWS, Snowflake, or Databricks can open doors to higher-paying jobs.
- **Tailor Skills to Desired Roles:** Research the specific skills required for the job titles you're interested in and focus on developing those skills.
- **Consider supplementary skills** Understanding skills such as excel, Jira, and confluence, will put you ahead of the rest.

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
To identify the most in-demand skills for remote Data Analyst roles, 
I filtered job postings by job title and work-from-home status. 
This query highlights the skills with the highest demand in the field.
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
Here's the breakdown of 
- **SQL Dominates:** SQL is by far the most in-demand skill (demand count of 7291), solidifying its importance as a fundamental skill.
- **Excel Remains Crucial:** Excel is the second most demanded skill with 4611 counts.
- **Python and Tableau are Important:** Python and Tableau are next most popular with a demand count of 4330 and 3745 respectively.
- **Power BI:** Ranks 5th in demand, indicating it's importance as another tool for BI reporting.

In conclusion, a successful data analyst needs a strong foundation in SQL, Python, and data visualization. Experience with cloud technologies can provide a significant advantage. Furthermore, a focus on Excel will also aid in a data analyst's career.

| skills      | demand_count |
|-------------|--------------|
| sql         | 7291         |
| excel       | 4611         |
| python      | 4330         |
| tableau     | 3745         |
| power bi    | 2609         |
| r           | 2142         |
| sas         | 1866         |
| looker      | 868          |
| azure       | 821          |
| powerpoint  | 819          |

*table of top demanded skills for data analysis*
### 4. Top Data Analyst Skills Based On Salary
To identify the most valuable skills, I filtered data analyst positions by average yearly salary and work-from-home status. This query highlights the skills with the highest salaries in the field.
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
- **PySpark Commands Highest Salary:**pyspark has the highest average salary at $208,172. This suggests that expertise in distributed data processing using PySpark is highly valued.
- **Bitbucket Also Highly Valued:** bitbucket has a high average salary of $189,155. Bitbucket suggests an emphasis on software development skills.
- **Cloud Skills are Present, But Not Dominant:** While watson appears, it's important to note this is a more specific skill and might represent a niche area.
- **Emerging Technologies:** Skills such as datarobot, and couchbase appear suggesting that there may be newer technologies that are gaining momentum in the workforce.
- **Familiar Data Science Tools:** jupyter and pandas show up which are commonly used for data science.

In conclusion, This query provides valuable insights into the skills that are associated with higher average salaries. Prioritizing PySpark, Bitbucket, and Cloud technologies would be helpful for a data analyst.

| skills          | avg_salary |
|-----------------|-------------|
| pyspark         | 208172      |
| bitbucket       | 189155      |
| watson          | 160515      |
| couchbase       | 160515      |
| datarobot       | 155486      |
| gitlab          | 154500      |
| swift           | 153750      |
| jupyter         | 152777      |
| pandas          | 151821      |
| elasticsearch   | 145000      |

*table of the top Data analyst skills based on salary*
### 5. Top Optimal Skills To Learn
To identify the most in-demand and valuable skills, I filtered data analyst positions by average yearly salary and work-from-home status. This query highlights the skills with the highest salaries and demand in the field.
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
- **SQL's Dominance Remains, but Salary is Lower:** SQL has a significant demand count (398), yet its average salary is relatively lower ($97,237) compared to other skills. This might suggest that while SQL is essential for entry-level positions, it's not enough to command a high salary on its own.
- **Excel's Low Salary Despite High Demand:** A similar trend can be seen with excel, having an average salary of 87288 with a demand count of 256.
- **Power BI and Tableau as essential data visualization tools:**Although the average salary is around $97000 to $99000, the demand is fairly high.
- **"Go" Commands a High Salary with Moderate Demand:** The "go" skill commands a higher average salary ($115,320) with a much lower demand count (27).
- **Confluence with Highest Average Salary:** It has the highest average salary of $114210, with a demand count of 11.

| skill_id | skills       | avg_salary | demand_count |
|----------|--------------|------------|--------------|
| 8        | go           | 115320     | 27           |
| 234      | confluence   | 114210     | 11           |
| 97       | hadoop       | 113193     | 22           |
| 80       | snowflake    | 112948     | 37           |
| 74       | azure        | 111225     | 34           |
| 77       | bigquery     | 109654     | 13           |
| 76       | aws          | 108317     | 32           |
| 4        | java         | 106906     | 17           |
| 194      | ssis         | 106683     | 12           |
| 233      | jira         | 104918     | 20           |

*table of the top 10 most in-demand and valuable skills*

# What I Learned
**1. SQL is Fundamental & Essential (Reinforced!)**
The data clearly demonstrates that SQL is the foundation for a data analyst role. All files and insights pointed to it as the most important skill.
**2. Data Manipulation & Querying**
I learned the basics of querying data using SQL.
SELECT, FROM, WHERE clauses.
Filtering data.
**3. Joining Data (Potentially)**
I have started to explore joining data from multiple tables. which was one of the most challenging parts of SQL
**4. Data Analysis Concepts (High-Level)**
The data reinforces how data analysis is about combining data points to gain meaningful insights.
The importance of combining demand_count (popularity of a skill) with avg_salary to strategically choose skills.
# Conclusions
### Key Takeaways:
- **SQL is the Cornerstone:** SQL consistently emerges as the most in-demand skill (File 2), underpinning almost every data-related role. A solid understanding of SQL is non-negotiable.
- **Python is the Second Pillar:** Python is also in high demand, enabling data manipulation, analysis, and automation.
- **Data Visualization is Key for Communication:** Tableau and Power BI are essential for effectively communicating insights to stakeholders (File 2).
- **Cloud Skills are Increasingly Important:** While not always the top-paying individual skills, cloud platforms like Azure, AWS, and Snowflake are valuable for data analysis roles in modern, cloud-based environments. They may not be the absolute highest paying on their own, but open doors to cloud-based roles and may be a signal for more advanced data engineering skills.
- **'Go' has the Highest Average Salary but the job role is limited.**
- **Confluence's salary is high**
- **Target Roles Require Broader Skills:** The "Associate Director - Data Insights" role is a good example of a high-paying position requiring a diverse skill set (File 1), indicating that leadership roles benefit from versatility.
- **Demand vs. Salary Considerations:** Skills like Excel have high demand but relatively lower average salaries (File 2 & 4). This suggests that while these skills are valuable, they are not sufficient to command top-tier compensation alone.
- **Strategic Skill Prioritization:** Focus on building a strong foundation in SQL, Python, and data visualization. Then, explore cloud technologies and/or domain-specific skills to increase earning potential. Skills such as confluence and go also have high paying salaries that you can target.
### Strategic Recommendations for Data Professionals:
- **Solidify the Fundamentals:** Master SQL, Python, and data visualization tools (Tableau, Power BI).
- **Embrace Cloud Technologies:** Gain experience with cloud platforms to stay relevant in the evolving data landscape.
- **Develop a Specialization:** Consider specializing in a specific domain (e.g., marketing analytics, cloud data engineering) to differentiate yourself.
- **Continuous Learning:** Stay updated on emerging technologies and trends to remain competitive.
- **Business Acumen:** Develop strong communication and business acumen to translate data insights into actionable strategies.
- **Tailor to Target Roles:** Carefully research the specific skills required for your desired job titles and focus on developing those skills.
