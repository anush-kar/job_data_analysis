/*
find job postings from the first quarter that have a salary greater than $70k
    - combine job posting tabkes from the furst quarter of 2023 (jan-mar)
    - get job postings with an avg yearly salary > $70,000 
*/

SELECT 
    quarter1_job_postings.job_id,
    quarter1_job_postings.job_title,
    company_dim.name as company_name,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
INNER JOIN
    company_dim
    ON quarter1_job_postings.company_id = company_dim.company_id
WHERE   
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg DESC
