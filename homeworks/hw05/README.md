To get the information to a file I use \o {filepath}

Results in hw05.txt

Query: 

EXPLAIN ANALYZE
SELECT p.person,
COUNT(*) AS total_publications
FROM person_publication_relation pr
JOIN person p ON pr.person_id = p.id
WHERE p.person = 'Marcelo Bertalmo'
GROUP BY p.person;

Optimization: Indexing

CREATE INDEX idx_person_publication_relation_person_id ON person_publication_relation (person_id);

CREATE INDEX idx_person_id ON person (id);

Difference made:
Before Indexing: Execution Time: 1284.367 ms
After Indexing: Execution Time: 303.430 ms