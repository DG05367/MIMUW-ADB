To get the information to a file I use \o {filepath}

1. All information about an author:

This querie finds all the information about the author with id = 5;

I use EXPLAIN ANALYZE to get information about the querie.

EXPLAIN ANALYZE
SELECT *
FROM person
LEFT JOIN person_publication_relation ON person.id = person_publication_relation.person_id
LEFT JOIN publication ON person_publication_relation.publication_id = publication.key
WHERE person.id = 5;

The result is on hw03_1.txt 

2. All information about a publication:

EXPLAIN ANALYZE
SELECT *
FROM publication
LEFT JOIN person_publication_relation ON publication.key = person_publication_relation.publication_id
LEFT JOIN person ON person_publication_relation.person_id = person.id
LEFT JOIN series ON publication.key = series.publication_key
LEFT JOIN rel ON publication.key = rel.publication_key
LEFT JOIN title ON publication.key = title.publication_key
LEFT JOIN cite ON publication.key = cite.publication_key
WHERE publication.key = 'reference/vision/RamanathD14a';

The result is on hw03_2.txt 

3. All titles related to a publication

EXPLAIN ANALYZE
SELECT *
FROM title
WHERE publication_key = 'homepages/165/4664';

4. Get a list of publications that have a relation:

EXPLAIN ANALYZE
SELECT *
FROM publication
LEFT JOIN rel ON publication.key = rel.publication_key
WHERE rel.rel = 'Zenododata/10/JacobFTBT19j';

5. Retrieve the series for book type publications:

EXPLAIN ANALYZE
SELECT series.series, publication.*
FROM series
LEFT JOIN publication ON series.publication_key = publication.key
WHERE publication.type = 'book';

