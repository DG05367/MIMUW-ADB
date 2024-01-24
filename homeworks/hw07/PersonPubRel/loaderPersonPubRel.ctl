LOAD DATA
INFILE '/home/others/ti1140/MIMUW-ADB/parsed/person_publication_relation.csv'
INTO TABLE person_publication_relation
TRUNCATE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    relation_id,
    role,
    person_id,
    publication_id
)