/* What are the most in demand skills for data analysts
Join job_postings to inner join table similar to query-2
Identify the top-5 in demand skills for a data analyst 
focus on all job_postings 
*/
 
SELECT 
	skills,
    count(skills_job_dim.job_id) AS demand_count
FROM
	job_postings_fact
INNER JOIN
skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
	job_title_short ='Data Analyst' 
Group by 
	skills
order BY
	demand_count DESC
limit 5;