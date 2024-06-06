SELECT 
	skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary,
    count(skills_job_dim.job_id) AS demand_count
FROM
	job_postings_fact
INNER JOIN
skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
	job_title_short ='Data Analyst'  
    AND salary_year_avg IS NOT NULL
Group by 
	skills
order BY
    demand_count DESC,
    avg_salary DESC
limit 25;