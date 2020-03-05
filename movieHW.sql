------------------------------------------------------------------------------------------------------------------

-- Normal Mode:

-- (#1) Select all columns and rows from the movies table
SELECT *
FROM movies;

-- (#2) Select only the title and id of the first 10 rows
SELECT title, id
FROM movies.movies
LIMIT
10;

-- (#3) Find the movie with the id of 485
SELECT title
FROM movies
WHERE id=485;

-- (#4) Find the id (only that column) of the movie Made in America (1993)
SELECT id
FROM movies
WHERE title="Made in America (1993)";

-- (#5) Find the first 10 sorted alphabetically
SELECT title
FROM movies
order by title
limit 10;

-- (#6)Find all movies from 2002
SELECT title
FROM movies
WHERE title
LIKE '%(2002)%';

-- (#7) Find out what year the Godfather came out
SELECT title
FROM movies
WHERE title
LIKE '%Godfather, The %';

-- (#8) Without using joins find all the comedies
-- was not sure if you wanted JUST comedies OR movies with comedy included in the genre
SELECT title, genres
FROM movies.movies
where genres LIKE "%comedy%";

-- (#9) Find all comedies in the year 2000
SELECT title, genres
FROM movies
WHERE genres LIKE "%comedy%" and title LIKE "%(2000)%";

-- (#10) Find any movies that are about death and are a comedy
SELECT title, genres
FROM movies
WHERE genres LIKE "%comedy%" and title LIKE "%death%";

-- (#11) Find any movies from either 2001 or 2002 with a title containing super
SELECT title
FROM movies
WHERE title LIKE "%Super%" and title LIKE "%(2002)%"
  OR title LIKE "%super%" AND title LIKE "%(2001)%";

-- (#12) Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth, at least, plus an id field.

CREATE TABLE `movies`.`actors`
(
  `id` INT NOT NULL AUTO_INCREMENT,
  `fullName` VARCHAR
(45) NULL,
  `charName` VARCHAR
(45) NULL,
  `DOB` DATE NULL,
  `movieID` INT NULL,
  PRIMARY KEY
(`id`));

-- (#13) Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
insert into actors
  (fullName, charName, DOB, movieID)
values
  ("Robin Williams", "Genie", "1951-07-21", "588"),
  ("Linda Larkin", "Jasmine", "1970-03-20", "588"),
  ("Scott Weinger", "Aladdin", "1975-10-05", "588"),
  ("Jonathan Freeman", "Jafar", "1950-02-05", "588"),
  ("Frank Welker", "Abu", "1946-03-12", "588"),
  ("Gilbert Gottfried", "Iago", "1955-02-28", "588"),
  ("Douglas Seale", "The Sultan", "1913-10-28", "588"),
  ("Corey Burton", "Necklace Merchant", "1955-08-03", "588"),
  ("Jim Cummings", "Razoul, Farouk", "1952-11-03", "588"),
  ("Lea Salonga", "Jasmine", "1971-02-22", "588");

insert into actors
  (fullName, charName, DOB, movieID)
values
  ("Robin Williams", "Alan Parish", "1951-07-21", "2"),
  ("Kirsten Dunst", "Judy Shepherd", "1982-04-30", "2"),
  ("Bonnie Hunt", "Sarah Whittle", "1961-09-22", "2"),
  ("Bradley Pierce", "Pete Shepherd", "1983-10-23", "2"),
  ("Jonathan Hyde", "Van Pelt | Sam Parrish", "1948-05-21", "2"),
  ("Patricia Clarkson", "Carol Parrish", "1959-12-29", "2"),
  ("James Handy", "Exterminator", "1913-10-28", "2"),
  ("Gillian Barber", "Mrs. Thomas", "1958-02-22", "2"),
  ("Cyrus Thiedeke", "Caleb", "1952-11-03", "2"),
  ("Malcom Stewart", "Jim Shepherd", "1948-05-25", "2");

insert into actors
  (fullName, charName, DOB, movieID)
values
  ("Julia Ormond", "Sabrina Fairchild", "1965-01-04", "7"),
  ("Harrison Ford", "Linus Larrabee", "1942-07-13", "7"),
  ("Greg Kinnear", "David Larrabee", "1963-06-17", "7"),
  ("Nancy Marchand", "Maude Larrabee", "1928-06-19", "7"),
  ("John Wood", "Fairchild", "1930-07-05", "7"),
  ("Lauren Holly", "Elizabeth Tyson", "1963-10-28", "7"),
  ("Richard Crenna", "Patrick Tyson", "1926-11-30", "7"),
  ("Angie Dickinson", "Ingrid Tyson", "1931-09-30", "7"),
  ("Fannie Ardant", "Irene", "1949-03-22", "7"),
  ("Dana Ivey", "Mack", "1941-08-12", "7");

-- (#14) Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating

--adding new column
ALTER TABLE movies 
ADD MPAA_RATING varchar(255)

--updating ratings
--1
UPDATE movies
SET MPAA_RATING = 'PG'
WHERE id = '7';

--2
UPDATE movies
SET MPAA_RATING = 'G'
WHERE id = '1';

--3
UPDATE movies
SET MPAA_RATING = 'PG'
WHERE id = '2';

--4
UPDATE movies
SET MPAA_RATING = 'PG'
WHERE id = '7';

--5
UPDATE movies
SET MPAA_RATING = 'G'
WHERE id = '34';
------------------------------------------------------------------------------------------------------------------

-- WITH JOINS!

-- (#15) Find all the ratings for the movie Godfather, show just the title and the rating

SELECT m.title, r.rating
FROM movies m
  LEFT JOIN ratings r on m.id = r.movie_id
WHERE title LIKE '%Godfather, The %'

-- (#16) Order the previous objective by newest to oldest

SELECT m.title, r.rating, r.timestamp
FROM movies m
  LEFT JOIN ratings r on m.id = r.movie_id
WHERE title LIKE '%Godfather, The %'
ORDER BY timestamp DESC

-- (#17) Find the comedies from 2005 and get the title and imdb_id from the links table

SELECT m.title, l.imdb_id
FROM movies m
  LEFT JOIN links l on m.id = l.imdb_id
WHERE title LIKE '%(2005)%' AND genres LIKE "%comedy%"


-- (#18) Find all movies that have no ratings

SELECT m.title, r.rating
FROM Movies.movies m
  LEFT JOIN ratings r ON m.id = r.movie_id
WHERE ISNULL(r.rating)


------------------------------------------------------------------------------------------------------------------

-- Complete the following aggregation objectives:

-- (#19) Get the average rating for a movie

SELECT AVG(rating) as avgRating
FROM ratings
WHERE movie_id="2"

-- (#20) Get the total ratings for a movie

SELECT SUM(rating) as ratingSum
FROM ratings
WHERE movie_id="2"

-- (#21) Get the total movies for a genre

SELECT COUNT(title) as titleCount
FROM movies
WHERE genres LIKE "%comedy%"

-- (#22) Get the average rating for a user

SELECT AVG(rating) as avgRating
FROM ratings
WHERE user_id="1"

-- (#23) Find the user with the most ratings

SELECT user_id, COUNT(rating) as mostRates
FROM ratings
GROUP BY user_id
ORDER BY mostRates DESC

-- (#24) Find the user with the highest average rating

SELECT AVG(rating) as average
FROM ratings
GROUP BY user_id
HAVING average = (
	SELECT MAX(average)
FROM (
		SELECT AVG(rating) as average
  FROM ratings
  GROUP BY user_id
	) as maxAvgRating
)

-- (#25) Find the user with the highest average rating with more than 50 reviews

SELECT user_id, ROUND(AVG(rating),2) as avgRating, COUNT(rating) as ratingCount
FROM ratings
GROUP BY `user_id`
HAVING ratingCount > 50
ORDER BY avgRating DESC

-- (#26) Find the movies with an average rating over 4

SELECT movie_id, ROUND(AVG(rating),2) as avgRating
FROM ratings
GROUP BY movie_id
HAVING avgRating > 4
ORDER BY avgRating DESC

------------------------------------------------------------------------------------------------------------------
--HARD MODE!!!

-- (#1) Use concat and research about internet movie database to produce a valid url from the imdbid

-- (#2) Use concat and research about the movie database to produce a valid url from tmdbid

-- (#3) Get the ratings for The Unusuals and convert the timestamp into a human readable date time

-- (#4) Using SQL normalize the tags in the tags table. Make them lowercased and replace the spaces with -

-- (#5) Create a new field on the movies table for the year. Using an update query and a substring method update that column for every movie with the year found in the title column.

-- (#6) Once you have completed the new year column go through the title column and strip out the year.

-- (#7) Create a new column in the movies table and store the average review for each and every movie.