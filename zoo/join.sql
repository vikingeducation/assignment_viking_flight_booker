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
