----------
-- JOIN --
----------

-- 1. Show the matchid and player name for all goals scored by Germany.

SELECT matchid, player
 FROM goal JOIN eteam
 ON goal.teamid = eteam.id
 WHERE goal.teamid = 'GER'

-- 2. Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012

-- 3. Modify it to show the player, teamid, stadium and mdate and for every German goal.
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE goal.teamid = 'ger'

-- 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
  WHERE player LIKE 'Mario%'


-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam on teamid=id
  WHERE gtime<=10

-- 6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
  FROM game JOIN eteam ON (team1=eteam.id)
  WHERE coach = 'Fernando Santos'

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
  FROM game JOIN goal ON (id = matchid)
  WHERE stadium = 'National Stadium, Warsaw'


-- 8. Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id
  WHERE (teamid!='Ger')
  AND (team2 = 'GER' OR team1 = 'GER')

-- 9. Show teamname and the total number of goals scored.
