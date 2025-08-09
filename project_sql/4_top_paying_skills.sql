/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst positions
- focuses no roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analystsand helps identify the most financially rewarding skills to acquire
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25

/*
Here are some quick trends from the top 25 highest-paying data analyst skills:
-Niche & emerging tech pays big – Rare skills like SVN, Solidity, Golang, and blockchain/crypto tools command the highest salaries due to scarcity.
-AI, ML & Big Data expertise is highly rewarded – Frameworks like PyTorch, TensorFlow, MXNet, Hugging Face, plus big data tools like Kafka and Cassandra drive top pay.
-DevOps & cross-domain skills boost value – Terraform, Ansible, GitLab, Airflow, and VMware show that blending data analytics with cloud, automation, and workflow orchestration increases earning potential.
*/