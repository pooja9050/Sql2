#178. Rank Scores
# Write your MySQL query statement below using window function
Select s.score, Dense_Rank() Over(Order by score DESC) AS 'rank'
FROM Scores s;

#alternative approach using correlated subquery
SELECT s1.score,
       (
           SELECT COUNT(DISTINCT s2.score) 
           FROM Scores s2 
           WHERE s2.score >= s1.score
       ) AS `rank`
FROM Scores s1
ORDER BY s1.score DESC;

#using Inner join
SELECT s1.score, COUNT(DISTINCT s2.score) AS `rank`
FROM scores s1
INNER JOIN scores s2 ON s1.score <= s2.score
GROUP BY s1.id, s1.score
ORDER BY s1.score DESC;
