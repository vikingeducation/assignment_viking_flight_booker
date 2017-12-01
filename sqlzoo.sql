-- 1
select count(distinct id) from stops

-- 2
select id from stops where name = 'Craiglockhart'

-- 3
select id, name from stops join route on stops.id = route.stop where num = '4' and company = 'LRT'

-- 4
SELECT company, num, COUNT()
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT() = 2

-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

-- 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

-- 7
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

-- 8
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'

-- 9
SELECT DISTINCT  stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'

-- 10

SELECT DISTINCT a.num, a.company, stopb.name, c.num, c.company
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN (route c JOIN route d ON (c.company = d.company AND c.num = d.num))
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
  JOIN stops stopc on (c.stop=stopc.id)
  JOIN stops stopd on (d.stop=stopd.id)
WHERE stopa.name='Craiglockhart' AND stopd.name='Sighthill' AND stopb.name  = stopc.name
ORDER BY CAST(a.num AS int), stopb.id
