-- Window Functions part 2 : LAG, LEAD, running totals, moving averages
-- NEXT_MONTH & LAG Functions in SQL
-- - LAG helps us peek at the previous row’s value → great for comparing trends, changes, or growth.
-- - NEXT_MONTH lets us check the next row’s value → useful for forecasting or spotting what’s coming next.
-- Use cases explored:
-- - Employee salaries with next and previous comparisons.
-- - Daily product sales with previous/next day units sold.
-- - Social media follower growth month‑on‑month with percentage gains using CTEs.
-- Key takeaway:
-- LAG = look back
-- NEXT_MONTH = look forward


USE insurance_practice;

SHOW TABLES;

SELECT * FROM policies;

SELECT *,
LAG(premium) OVER (PARTITION BY policy_type ORDER BY start_date ASC) AS premium_lag,
LEAD(premium) OVER (PARTITION BY policy_type ORDER BY start_date ASC) AS premium_lead
FROM policies;


CREATE TABLE social_media_followers (
	user_id INT,
	user_name VARCHAR(100),
	month DATE,
    linkedin_followers INT,
    twitter_followers INT,
    instagram_followers INT,
    youtube_followers INT
);
USE insurance_practice;
INSERT INTO social_media_follower
(user_id, user_name, month, linkedin_followers, twitter_followers, instagram_followers, youtube_followers)
VALUES
-- Employee 1 : Alice
(1, 'Alice', '2026-06-01', 500, 1200, 5000, 800),
(1, 'Alice', '2026-06-02', 503, 1205, 5015, 802),
(1, 'Alice', '2026-06-03', 505, 1208, 5030, 805),
(1, 'Alice', '2026-06-04', 508, 1210, 5042, 807),
(1, 'Alice', '2026-06-05', 512, 1215, 5060, 810),
(1, 'Alice', '2026-06-06', 515, 1218, 5078, 812),
(1, 'Alice', '2026-06-07', 518, 1222, 5095, 815),
(1, 'Alice', '2026-06-08', 520, 1225, 5110, 817),
(1, 'Alice', '2026-06-09', 523, 1229, 5128, 820),
(1, 'Alice', '2026-06-10', 526, 1232, 5145, 823),

-- Employee 2 : Bob
(2, 'Bob', '2026-06-01', 850, 1800, 7200, 1500),
(2, 'Bob', '2026-06-02', 852, 1805, 7212, 1503),
(2, 'Bob', '2026-06-03', 855, 1810, 7228, 1507),
(2, 'Bob', '2026-06-04', 858, 1813, 7240, 1510),
(2, 'Bob', '2026-06-05', 861, 1818, 7260, 1514),
(2, 'Bob', '2026-06-06', 865, 1822, 7275, 1518),
(2, 'Bob', '2026-06-07', 868, 1827, 7290, 1521),
(2, 'Bob', '2026-06-08', 870, 1830, 7305, 1524),
(2, 'Bob', '2026-06-09', 874, 1835, 7322, 1528),
(2, 'Bob', '2026-06-10', 878, 1840, 7340, 1532);

SHOW TABLES;

-- Running total example:
-- option 1: using sub-query
SELECT *,
LAG(total_followers) OVER (PARTITION BY user_id ORDER BY total_followers DESC) AS PREV_MONTH,
LEAD(total_followers) OVER (PARTITION BY user_id ORDER BY total_followers DESC) AS NEXT_MONTH
FROM (SELECT *,
linkedin_followers + twitter_followers + instagram_followers + youtube_followers AS total_followers
FROM social_media_followers) AS tmp_2;

-- option 2: using CTE
WITH CTE_1 AS (SELECT *,
linkedin_followers + twitter_followers + instagram_followers + youtube_followers AS total_followers
FROM social_media_followers), 
CTE_2 AS (SELECT *,
LEAD(total_followers,1,total_followers) OVER (PARTITION BY user_id ORDER BY month DESC) AS PREV_MONTH,
LAG(total_followers,1,total_followers) OVER (PARTITION BY user_id ORDER BY month DESC) AS NEXT_MONTH
FROM CTE_1)
SELECT *,
ROUND((total_followers - NEXT_MONTH) * 100 / PREV_MONTH, 2) AS percentage_change FROM CTE_2;

-- Moving Average (Rolling Average)

-- To calculate a moving average (or rolling average) in SQL, use window functions with the ROWS BETWEEN clause, which is the most efficient and standard approach.

SELECT * 
FROM social_media_followers;

SELECT *,
AVG(total_followers) OVER (ORDER BY total_followers 
							ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as 7_days_rolling_avg
FROM (SELECT *,
linkedin_followers + twitter_followers + instagram_followers + youtube_followers AS total_followers
FROM social_media_followers) AS temp_tbl;




WITH CTE_1 AS (SELECT *,
linkedin_followers + twitter_followers + instagram_followers + youtube_followers AS total_followers
FROM social_media_followers)
SELECT *,
AVG(total_followers) OVER (ORDER BY total_followers 
							ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as 7_days_rolling_avg
FROM CTE_1;