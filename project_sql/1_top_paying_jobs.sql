/*
What are the top paying data analyst jobs?
- Identify top 10 highest paying data analyst roles that are availabe remotely
- Focuses on job postings with specified salaries (remove nulls)
- Why? Highlight top paying opportunities for data analysts, offering insights into employment opportunities
*/

SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg,
    job_schedule_type,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg
LIMIT 10;