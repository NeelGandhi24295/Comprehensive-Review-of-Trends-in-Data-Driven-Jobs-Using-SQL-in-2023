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
- **Pandas & Matplotlib**: Data visualization for the project was realized using this most in-demand Python libraries.

# Analysis
Each query in this project was designed to explore particular aspects of the data analyst job market. Here's my approach to each question

### 1. Top Paying Data Analyst Jobs

To pinpoint the top-paying roles, I filtered data analyst positions by average yearly salary and location. This query illuminates lucrative opportunities in the field.

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
![Top Paying Roles](SQL_JOB_POSTINGS_PROJECT/1_top_paying_roles.png)
Here are observations from the top 10 data analyst job roles based on salary in 2023

* **Salary Range Variation**: The top 10 highest-paying data analyst roles in 2023 offer a wide salary range, ranging from $184,000 to $650,000. This underscores the significant earning potential within the field.

* **Diverse Employers**: Major companies such as SmartAsset, Meta, and AT&T offer lucrative salaries, highlighting the diverse range of employers across various industries that value data analytics expertise.

* **Job Title Diversity**: The job titles within the top-paying data analyst roles vary greatly, ranging from Data Analyst to Director of Analytics. This diversity reflects the broad spectrum of roles and specializations available within the field of data analytics.

  
### 2. Skills for Top Paying Jobs
To grasp the essential skills for the highest-paying positions, I merged job postings with skill data, offering insights into the attributes that employers prioritize for well-compensated roles.
``` SQL
SELECT 
    sjd.job_id,
    sd.skills,
    sd.type,
    cd.name,
    jpf.salary_year_avg,
    jpf.job_title_short
FROM
    skills_job_dim AS sjd
        INNER JOIN
    job_postings_fact AS jpf ON jpf.job_id = sjd.job_id
        INNER JOIN
    skills_dim AS sd ON sd.skill_id = sjd.skill_id
        INNER JOIN
    company_dim AS cd ON cd.company_id = jpf.company_id
WHERE
    jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_location = 'Anywhere'
ORDER BY jpf.salary_year_avg DESC
LIMIT 10;
```
Based on the top 10 highest-paying data analyst jobs in 2023, the most demanded skills are:

* **SQL** is the leader with a count of 8
* **Python** is the most in-demand programming language with a count of 7
* **Tableau** is also the most sought-after visualization tool for the role, with a count of 6. Other skills such as R, Snowflake, Pandas, and Excel demonstrate diverse demand levels.
![Skill count for 10 Top Paying Roles](SQL_JOB_POSTINGS_PROJECT/Skill_count_top_paying_jobs.png)
 
### 3. In-Demand Skills for Data Analysts
This query aided in pinpointing the skills that appear most frequently in job postings, guiding attention towards skills one must acquire for the data analyst role.
``` SQL
SELECT 
    skills, COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
        INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
Here’s a look at the most in-demand skills for data analysts in 2023.

* SQL and Excel retain their foundational importance, highlighting the necessity for robust skills in data processing and spreadsheet management.

* Programming languages and visualization tools such as Python, Tableau, and Power BI are indispensable, pointing to the growing significance of technical proficiencies in data narration and decision-making support.

| Skills     | Demand Count |
|------------|--------------|
| SQL        | 7291         |
| Excel      | 4611         |
| Python     | 4330         |
| Tableau    | 3745         |
| Power BI   | 2609         |


### 4. Skills Based on Salary
This breakdown will help you understand the skills you need to secure a high-paying salary, to stand out in the competitive market for data analyst positions.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
        INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY demand_count DESC , avg_salary DESC
LIMIT 25;
```

| Skills        | Average Salary ($) |
|---------------|--------------------|
| pyspark       | 208,172            |
| bitbucket     | 189,155            |
| couchbase     | 160,515            |
| watson        | 160,515            |
| datarobot     | 155,486            |
| gitlab        | 154,500            |
| swift         | 153,750            |
| jupyter       | 152,777            |
| pandas        | 151,821            |
| elasticsearch | 145,000            |

It's fascinating how the landscape of technology careers continues to evolve, with certain skill sets becoming increasingly valuable and sought after. 

* Proficiency in big data technologies like PySpark and Couchbase, along with machine learning tools such as DataRobot and Jupyter, certainly commands attention, given the industry's emphasis on data processing and predictive modelling.

* Moreover, the intersection of software development and data analysis is becoming more pronounced, with a premium placed on individuals who can navigate both realms effectively. Skills in development and deployment tools like GitLab, Kubernetes, and Airflow signify a valuable crossover between data analysis and engineering, emphasizing the importance of automation and streamlined data pipeline management.

* Cloud computing expertise is another area of growing significance in the realm of data analytics. As more organizations transition to cloud-based environments for their analytics needs, familiarity with cloud and data engineering tools like Elasticsearch, Databricks, and GCP becomes increasingly valuable. Indeed, proficiency in these areas can significantly enhance one's earning potential in the field of data analytics.

### 5. Most Optimal Skills to Learn
This query sought to identify skills that are not only in high demand but also command top salaries, providing valuable direction for skill development. By analyzing demand and salary data, the goal was to pinpoint areas where investing in expertise could yield significant career returns.
``` sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),
            0) AS avg_salary
FROM
    job_postings_fact
        INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
        INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC , demand_count DESC;
```

| Skill ID | Skills      | Demand Count | Average Salary ($) |
|----------|-------------|--------------|--------------------|
| 8        | go          | 27           | 115,320            |
| 234      | confluence  | 11           | 114,210            |
| 97       | hadoop      | 22           | 113,193            |
| 80       | snowflake   | 37           | 112,948            |
| 74       | azure       | 34           | 111,225            |
| 77       | bigquery    | 13           | 109,654            |
| 76       | aws         | 32           | 108,317            |
| 4        | java        | 17           | 106,906            |
| 194      | ssis        | 12           | 106,683            |
| 233      | jira        | 20           | 104,918            |

Here's a breakdown of the most optimal skills for Data Analysts in 2023:
* In the realm of **programming languages**, Python and R continue to dominate, with 236 and 148 mentions, respectively, in job postings. Despite their prevalence, the average salaries for Python and R hover around $101,397 and $100,499, respectively, suggesting a balance between demand and availability of skills.

*  **Cloud technologies** are experiencing a surge in demand, particularly with platforms like Snowflake, Azure, AWS, and BigQuery. Professionals with expertise in these areas command relatively high salaries, underlining the increasing significance of cloud platforms and big data solutions in data analysis.

*  **Business intelligence (BI) and visualization tools** like Tableau and Looker are essential for deriving actionable insights from data. With 230 mentions, Tableau remains a frontrunner, while Looker follows with 49 mentions. The average salaries for these roles range from $99,288 to $103,795, emphasizing the critical role of visualization in data-driven decision-making.

*  **Database technologies**, both traditional (such as Oracle and SQL Server) and NoSQL, continue to be indispensable for data storage and retrieval. Professionals skilled in these areas command average salaries ranging from $97,786 to $104,534, highlighting the enduring need for robust data management solutions.

# What I Learned
In my journey, I've ramped up my SQL arsenal with formidable skills:

**Advanced Query Crafting**: Expertly merge tables and utilize WITH clauses for sophisticated temp table operations.

**Data Aggregation**: Mastered GROUP BY and wild aggregate functions like COUNT() and AVG() to summarize data effectively.

**Analytical Mastery**: Elevated my problem-solving abilities, transforming inquiries into actionable SQL solutions that provide valuable insights.

### Closing Remarks
This project has been instrumental in elevating my SQL expertise and offering profound insights into the data analyst job landscape. The analysis outcomes are a compass for directing skill enhancement and job pursuit endeavours. Aspiring data analysts can strategically navigate a competitive job market by honing sought-after, high-paying skills. This journey underscores the significance of perpetual learning and staying attuned to evolving trends within the realm of data analytics.
