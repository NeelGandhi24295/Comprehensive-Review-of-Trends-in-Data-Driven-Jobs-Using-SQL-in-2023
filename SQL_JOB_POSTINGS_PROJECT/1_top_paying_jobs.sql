/*
Question: What are the top paying data analyst jobs?
	- Identify the top 10 highest - paying DATA ANALYST roles that are available
    -Focuses pn job postings with specified salaries (remove null)
    -Why? Highlight the top paying opportunities for Data Analysts
*/

SELECT 
	job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name,
    job_id
FROM
	job_postings_fact
LEFT JOIN company_dim ON
company_dim.company_id = job_postings_fact.company_id 

Where job_title_short = 'Data Analyst' AND salary_year_avg is NOT Null AND job_location ='Anywhere'
Order by salary_year_avg DESC
limit 10;
    