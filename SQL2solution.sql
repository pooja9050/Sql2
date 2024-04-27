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


#626. Exchange Seats
# Write your MySQL query statement below using Mod function
SELECT (
    CASE
       WHEN MOD(id, 2) != 0 AND id != cnts THEN id+1
       WHEN MOD(id,2) != 0 AND id = cnts THEN id
       ELSE id -1
    END
) AS 'id', student FROM Seat, (SELECT COUNT(*) AS cnts FROM Seat) AS seat_counts
Order by id;

#Using Bitwise operator
SELECT s1.id, COALESCE (s2.student , s1.student) AS student 
FROM Seat s1 LEFT JOIN Seat s2 ON (s1.id + 1)^1-1 = s2.id 
ORDER BY s1.id 
