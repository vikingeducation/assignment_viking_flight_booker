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









