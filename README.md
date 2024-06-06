# Introduction
SQL is indispensable for data management and analysis in today's applications and businesses, offering simplicity, compatibility, scalability, integrity, security, and robust querying. Learning SQL is essential for aspiring data analysts. Leveraging on the  dataset provided by lukebarousse, this project delves into 2023 job postings for various data-related roles. It tackles critical data analytics inquiries: top-paying jobs, sought-after skills, and the relationship between demand and salary. Explore the SQL queries driving these insights at [SQL_JOB_POSTINGS_PROJECT](/SQL_JOB_POSTINGS_PROJECT/).
# Background
- Such an enriching dataset can be used to answer various questions related to several roles; with this desire in mind, this project aims to answer questions such as top-paid jobs and in-demand skills for the role of a data analyst.
- Data hails from [SQL_COURSE](https://www.lukebarousse.com/sql). It has insights into job titles, salaries, locations, and essential skills.

## The Questions I wanted to answer through my SQL Queries were:
 1. What are the top-paying data analyst jobs?
 2. What skills are required for these top-paying jobs?
 3. What skills are most in demand for data analysts?
 4. Which skills are associated with higher salaries?
 5. What are the most optimal skills to learn?

# Tools USED
- **MY SQL Workbench**: The cornerstone of my analysis, enabling me to query the database and unveil pivotal insights.
- **Git & GitHub**: Essential for sharing my SQL scripts and analysis.

# Analysis
Each query in this project was designed to explore particular aspects of the data analyst job market. Here's my approach to each question

#### 1. Top Paying Data Analyst Jobs

To pinpoint the top-paying roles, I filtered remote data analyst positions by average yearly salary and location. This query illuminates lucrative opportunities in the field.

``` sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
