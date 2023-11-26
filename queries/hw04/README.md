To get the information to a file I use \o {filepath}

Results in hw04.txt

Before optimization:

EXPLAIN ANALYZE
SELECT DISTINCT p2.*
FROM person p1
JOIN person_publication_relation r1 ON p1.id = r1.person_id
JOIN person_publication_relation r2 ON r1.publication_id = r2.publication_id
JOIN person p2 ON r2.person_id = p2.id
WHERE p1.person = 'Marcelo Bertalmo' AND p2.person != 'Marcelo Bertalmo';


After optimization:

EXPLAIN ANALYZE
SELECT DISTINCT ON (p2.id) p2.*
FROM person_publication_relation r1
JOIN person_publication_relation r2 ON r1.publication_id = r2.publication_id
JOIN person p1 ON r1.person_id = p1.id AND p1.person = 'Marcelo Bertalmo'
JOIN person p2 ON r2.person_id = p2.id AND p2.person <> 'Marcelo Bertalmo';



What was done: 
Using distinct only in IDs improves the search
remove WHERE statement

Difference made:
Execution time before: 2539.518 ms
Execution time after: 2455.740 ms