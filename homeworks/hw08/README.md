1. hash indexes - look up for postgres think where we can use it and make an example

2. functional indexes - both oracle and postgres(possibly)
 - not on a single column or a group of columns but ones created on expressions
 - very specialized
 - come up with a query where such index would help and add it


hash index is a type of index that uses a hash function to map keys to index entries. It is particularly useful for equality queries (e.g., WHERE column = 'some_value')

Example:

EXPLAIN ANALYZE 
SELECT *
FROM cite
WHERE cite = 'journals/jacm/GoldreichMW91';

CREATE INDEX cite_cite_hash_idx ON cite USING HASH (cite);

On this example we can see that the query benefited a lot from the hash index going from a execution time of 29.462ms to 3.150ms




Functional indexes work by allowing you to create an index on the result of a function or expression, rather than on a simple column. When queries involve expressions or functions that transform column values, a functional index can speed up the execution of those queries.

Example:
Find persons that contain "john" in their name. We can create a functional index to index the substring of the person column

CREATE INDEX idx_person_name_substring ON person (SUBSTRING(person FROM 1 FOR 4));

EXPLAIN ANALYZE
SELECT *
FROM person
WHERE SUBSTRING(person FROM 1 FOR 4) = 'John';

Since there are 16067 rows on the results I will only keep the explain analyze version on the results .txt file (hw08_2.txt)
