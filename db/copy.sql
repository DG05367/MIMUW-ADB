\copy publication FROM '../dataset/parsed/publication.csv' WITH CSV NULL AS 'null' QUOTE '''';
\copy person FROM '../dataset/parsed/person.csv' WITH CSV NULL AS 'null' QUOTE '''';
\copy title FROM '../dataset/parsed/title.csv' WITH CSV NULL AS 'null' QUOTE '''';
\copy cite FROM '../dataset/parsed/cite.csv' WITH CSV NULL AS 'null' QUOTE '''';
\copy rel FROM '../dataset/parsed/rel.csv' WITH CSV NULL AS 'null' QUOTE '''';
\copy series FROM '../dataset/parsed/series.csv' WITH CSV NULL AS 'null' QUOTE '''';
\copy person_publication_relation FROM '../dataset/parsed/person_publication_relation.csv' WITH CSV NULL AS 'null' QUOTE '''';
