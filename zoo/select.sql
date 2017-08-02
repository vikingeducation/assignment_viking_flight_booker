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
