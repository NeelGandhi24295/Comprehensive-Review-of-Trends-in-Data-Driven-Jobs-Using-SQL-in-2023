/* -- What skills are required for the top-paying data analyst role
 --- USE the top 10 highest paying data analyst jobs from the first query 
 -- Add the specific skills required for these roles 
 */
 
    WITH top_jobs AS (
    SELECT 
        job_id
    FROM 
        job_postings_fact
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_location = 'Anywhere'
 
),
job_id_interest AS (
    SELECT 
        sjd.job_id, 
        sd.skills,
        jpf.salary_year_avg,
        jpf.job_title_short,
        name AS company_name
    FROM 
        skills_job_dim As sjd
    INNER JOIN 
        skills_dim AS sd ON sjd.skill_id = sd.skill_id
    INNER JOIN
        job_postings_fact AS jpf ON jpf.job_id = sjd.job_id  
	INNER JOIN
        company_dim AS cd ON jpf.company_id = cd.company_id
    WHERE 
        sjd.job_id IN (SELECT job_id FROM top_jobs)
)
SELECT 
    job_id_interest.job_id, 
    job_id_interest.skills,
    job_id_interest.salary_year_avg,
	job_id_interest.company_name,
    job_id_interest.job_title_short
    
FROM 
    job_id_interest
ORDER BY 
    job_id_interest.salary_year_avg DESC;
    
 /* Top Skills:

SQL: Most frequently required skill, mentioned in 84 job postings.
Python: Second most common skill, mentioned in 55 job postings.
R: Appears in 32 job postings.
SAS: Listed in 20 job postings.
The most sought-after skills for data analyst roles in 2023 are SQL and Python, followed by R and SAS. 
Other programming languages and tools like JavaScript, Java, and C++ also have some demand but are less frequently listed. 
This highlights the importance of proficiency in SQL and Python for aspiring data analysts.