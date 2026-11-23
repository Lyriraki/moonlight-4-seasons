-- SQL sample: DDL, DML, join, CTE
CREATE TABLE IF NOT EXISTS users (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(255) UNIQUE,
    age         INTEGER DEFAULT 0,
    is_active   BOOLEAN DEFAULT TRUE,
    created_at  TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (name, email, age)
VALUES ('Alex', 'alex@example.com', 21),
       ('Sara', 'sara@example.com', 25);

/* Get active users together with their order counts */
WITH order_counts AS (
    SELECT user_id, COUNT(*) AS total_orders, SUM(amount) AS revenue
    FROM orders
    WHERE status = 'paid' AND created_at >= '2026-01-01'
    GROUP BY user_id
)
SELECT u.id, u.name, COALESCE(oc.total_orders, 0) AS orders
FROM users AS u
LEFT JOIN order_counts oc ON oc.user_id = u.id
WHERE u.is_active = TRUE
  AND u.age BETWEEN 18 AND 60
  AND u.email LIKE '%@example.com'
ORDER BY orders DESC, u.name ASC
LIMIT 10;

UPDATE users SET age = age + 1 WHERE id = 1;
DELETE FROM users WHERE email IS NULL;
