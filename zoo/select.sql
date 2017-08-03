------------------
-- SELECT Basics--
------------------
-- 1. show the population of Germany
SELECT population FROM world
  WHERE name = 'germany'

-- 2. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world
  WHERE name IN ('sweden', 'norway', 'denmark');

-- 3. show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

-----------------------
-- SELECT from World --
-----------------------
-- 1. show the name, continent and population of all countries.
SELECT name, continent, population FROM world

-- 2. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name FROM world
WHERE population >= 200000000

-- 3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp / population as 'per capita gdp'
FROM world
WHERE population >= 200000000

-- 4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population / 1000000 as popx1mil
FROM world
WHERE continent = 'South America'

-- 5. Show the name and population for France, Germany, Italy
SELECT name, population
FROM world
WHERE name IN ('france', 'germany', 'italy')

-- 6. Show the countries which have a name that includes the word 'United'
SELECT name
FROM world
WHERE name LIKE '%united%'

-- 7. Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area
FROM world
WHERE area > 3000000
OR population > 250000000

-- 8. Exclusive OR (XOR). Show the countries that are big by area or big by population but not both. Show name, population and area.
SELECT name, population, area
FROM world
WHERE area > 3000000
XOR population > 250000000

-- 9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
SELECT name, ROUND(population / 1000000, 2) as pop, ROUND(gdp / 1000000000, 2) as gdp
FROM world
WHERE continent = 'south america'

-- 10. Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND((gdp/population) / 1000) * 1000 AS 'per capita gdp per trills'
FROM world
WHERE gdp > 1000000000000

-- 11. Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital
  FROM world
  WHERE LENGTH(capital) = LENGTH(name)

-- 12. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name, capital
  FROM world
  WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital

-- 13. Find the country that has all the vowels and no spaces in its name.
SELECT name
   FROM world
  WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %'

-----------------------
-- SELECT from Nobel --
-----------------------

-- 1. Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

-- 2. Show who won the 1962 prize for Literature.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature'

-- 3. Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'albert einstein'

-- 4. Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner
FROM nobel
WHERE subject = 'peace'
AND yr >= 2000

-- 5. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'literature'
AND yr BETWEEN 1980 AND 1989

-- 6.
-- Show all details of the presidential winners:
-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

-- 7. Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

-- 8. Show the Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT *
FROM nobel
WHERE subject = 'chemistry'
AND yr = 1984
OR subject = 'physics'
AND yr = 1980

-- 9. Show the winners for 1980 excluding the Chemistry and Medicine
SELECT *
FROM nobel
WHERE subject NOT IN ('chemistry', 'medicine')
AND yr = 1980

-- 10. Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
SELECT *
FROM nobel
WHERE subject = 'medicine'
AND yr < 1910
OR subject = 'literature'
AND yr > 2003

-- 11. Find all details of the prize won by PETER GRÜNBERG
SELECT *
FROM nobel
WHERE winner = 'peter grünberg'

-- 12. Find all details of the prize won by EUGENE O'NEILL
SELECT *
FROM nobel
WHERE winner LIKE 'eugene o\'neill'

-- 13. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'sir%'
ORDER BY yr DESC, winner

-- 14. Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject
  FROM nobel
  WHERE yr=1984
  ORDER BY subject IN ('Physics','Chemistry'), subject, winner
