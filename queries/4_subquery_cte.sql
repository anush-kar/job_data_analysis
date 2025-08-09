-- SELECT *
-- FROM ( --subquery starts
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 1
--     LIMIT 10
-- ) AS january_jobs;

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    LIMIT 10
)
SELECT *
FROM january_jobs;

-- companies that give jobs with no degree required
SELECT
    company_id,
    name AS company_name
FROM
    company_dim
WHERE
    company_id IN(
        SELECT
            company_id
        FROM
            job_postings_fact
        WHERE
            job_no_degree_mention = true
    )

/*
find the companies with the most job openings
    get the total no of job postings per company id (job_posting_fact)
    return total no of jobs with companmy name (company_dim)
*/

WITH company_job_count AS (
    SELECT
        company_id,
        count(*) AS number_of_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY
        number_of_jobs DESC
)
SELECT
    company_dim.name AS company_name,
    company_job_count.number_of_jobs
FROM
    company_dim
LEFT JOIN
    company_job_count
    ON company_dim.company_id = company_job_count.company_id
ORDER BY
    number_of_jobs DESC