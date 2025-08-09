/*
count number of remote job postings per skill for data analysts only
    -display the top 5 skills by their demand in remote jobs
    -include skill id, name, and count of job postings requiring the skill
*/

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact
        ON skills_to_job.job_id = job_postings_fact.job_id
    WHERE
        job_work_from_home = true
        AND job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)
SELECT
    skills_dim.skill_id,
    skills_dim.skills AS skill_name,
    remote_job_skills.skill_count
FROM
    remote_job_skills
INNER JOIN
    skills_dim
    ON skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY
    remote_job_skills.skill_count DESC
LIMIT 5