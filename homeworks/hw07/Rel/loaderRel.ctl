LOAD DATA
INFILE '/home/others/ti1140/MIMUW-ADB/parsed/rel.csv'
INTO TABLE rel
TRUNCATE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id,
    rel,
    label NULLIF label='null',
    type NULLIF type='null',
    uri NULLIF uri='null',
    sort NULLIF sort='null',
    publication_key
)