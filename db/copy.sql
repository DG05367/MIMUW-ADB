\copy publication FROM '/home/diogo/uni/MIMUW-ADB/dataset/parsed/publication.csv' WITH CSV HEADER NULL AS 'null' QUOTE '''';
\copy person FROM '/home/diogo/uni/MIMUW-ADB/dataset/parsed/person.csv' WITH CSV HEADER NULL AS 'null' QUOTE '''';
\copy person_publication_relation FROM '/home/diogo/uni/MIMUW-ADB/dataset/parsed/person_publication.csv' WITH CSV HEADER NULL AS 'null' QUOTE '''';
\copy title FROM '/home/diogo/uni/MIMUW-ADB/dataset/parsed/title.csv' WITH CSV HEADER NULL AS 'null' QUOTE '''';
\copy cite FROM '/home/diogo/uni/MIMUW-ADB/dataset/parsed/cite.csv' WITH CSV HEADER NULL AS 'null' QUOTE '''';
\copy rel FROM '/home/diogo/uni/MIMUW-ADB/dataset/parsed/rel.csv' WITH CSV HEADER NULL AS 'null' QUOTE '''';
\copy series FROM '/home/diogo/uni/MIMUW-ADB/dataset/parsed/series.csv' WITH CSV HEADER NULL AS 'null' QUOTE '''';
