------------ SQL ZOO ----------------

-- JOIN operation

SELECT matchid, player FROM goal
  WHERE teamid = 'GER'

SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012

SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
  JOIN eteam ON (teamid = eteam.id)
  WHERE teamid = 'GER'

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
  JOIN eteam ON (teamid = eteam.id)
  WHERE player LIKE 'Mario%'

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON goal.teamid = eteam.id
 WHERE gtime<=10

SELECT mdate, teamname
  FROM game JOIN eteam ON game.team1 = eteam.id
  WHERE coach = 'Fernando Santos'

SELECT player
  FROM game JOIN goal ON game.id = goal.matchid
  WHERE stadium = 'National Stadium, Warsaw'

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id
    WHERE (team1='GER' OR team2='GER')
      AND teamid != 'GER'

SELECT teamname, COUNT(teamname)
 FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname
 ORDER BY teamname

SELECT stadium, COUNT(stadium)
  FROM game JOIN goal ON game.id = goal.matchid
  GROUP BY stadium

SELECT matchid, mdate, COUNT(*)
 FROM game JOIN goal ON goal.matchid = game.id
 WHERE (team1 = 'POL' OR team2 = 'POL')
 GROUP BY goal.matchid, game.mdate

SELECT matchid, mdate, COUNT(*)
 FROM game JOIN goal ON goal.matchid = game.id
 WHERE teamid = 'GER'
 GROUP BY goal.matchid, game.mdate

SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY id, team1, team2, mdate

/*MORE JOIN OPERATIONS*/
SELECT id, title
 FROM movie
 WHERE yr=1962

 SELECT yr
 FROM movie
 WHERE title='Citizen Kane'

 SELECT id, title, yr
 FROM movie
 WHERE title LIKE '%Star Trek%'

 SELECT id
 FROM actor
 WHERE name LIKE '%Glenn Close%'

 SELECT id
 FROM movie
 WHERE title LIKE '%Casablanca%'

 SELECT name
  FROM casting JOIN actor ON actorid = id
  WHERE movieid=11768

  SELECT name
 FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid=movie.id
 WHERE title = 'Alien'

 SELECT title
  FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid=movie.id
  WHERE name = 'Harrison Ford'

  SELECT title
 FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid=movie.id
 WHERE name = 'Harrison Ford' AND ord != '1'


 SELECT title, name
 FROM casting JOIN actor ON actorid = actor.id JOIN movie ON movieid=movie.id
 WHERE ord = '1' and yr = 1962

 SELECT yr,COUNT(title) FROM
   movie JOIN casting ON movie.id=movieid
          JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr
 HAVING COUNT(title)>2

 SELECT title,name
   FROM casting JOIN movie ON (movieid=movie.id)
                 JOIN actor ON actorid=actor.id
   WHERE ord=1 AND movie.id IN (
       SELECT movieid FROM casting
       WHERE actorid = (
             SELECT id FROM actor
             WHERE name='Julie Andrews'))

SELECT name 
  FROM casting JOIN actor ON casting.actorid = actor.id
  WHERE ord = 1
  GROUP BY actor.id, actor.name
  HAVING COUNT(*) >= 30

SELECT title, COUNT(actorid)
  FROM movie JOIN casting ON movie.id = casting.movieid
  WHERE yr = 1978
  GROUP BY movieid, title
  ORDER BY COUNT(actorid) DESC, title

SELECT name
  FROM movie JOIN casting ON movie.id=casting.movieid 
    JOIN actor ON actor.id = casting.actorid
  WHERE movieid IN(SELECT movieid
    FROM actor JOIN casting ON id=actorid
    WHERE name = 'Art Garfunkel') AND name != 'Art Garfunkel'
  
--- SUM AND COUNT

SELECT SUM(population)
  FROM world

SELECT DISTINCT continent
  FROM world

SELECT SUM(gdp)
  FROM world
  WHERE continent = 'Africa'

SELECT COUNT(name)
  FROM world
  WHERE area > 1000000

SELECT SUM(population) as "Total"
  FROM world
  WHERE name IN('Estonia', 'Latvia', 'Lithuania')
  
SELECT continent, COUNT(name)
  FROM world
  GROUP BY continent

SELECT continent, COUNT(name)
  FROM world
  WHERE population > 10000000
  GROUP BY continent

SELECT continent
  FROM world
  GROUP BY continent
  HAVING SUM(population) >= 100000000

-- SELECT WITHIN SELECT 

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

SELECT name
  FROM world
  WHERE continent = 'Europe' 
    AND gdp/population > (SELECT gdp/population
      FROM world
    WHERE name = 'United Kingdom')

SELECT name, continent
  FROM world
  WHERE continent IN(SELECT DISTINCT continent
  FROM world
  WHERE name = 'Argentina' OR name = 'Australia')
  ORDER BY name

SELECT name, population
  FROM world
  WHERE population > (SELECT population
  FROM world
  WHERE name = 'Canada') 
  AND population < (SELECT population
  FROM world
  WHERE name = 'Poland')

SELECT name, 
       CONCAT(
         ROUND(
           population/(SELECT population 
             FROM world
             WHERE name = 'Germany')*100
         ) 
       ,'%') AS "% of GER pop"
  FROM world
  WHERE continent = 'Europe'

-- SELF JOIN 

SELECT COUNT(*)
  FROM stops

SELECT id
  FROM stops
  WHERE name = 'Craiglockhart'

SELECT id, name
  FROM stops JOIN route ON stops.id = route.stop 
  WHERE num = '4' AND company = 'LRT'  

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num



