LOAD DATA
INFILE '/home/others/ti1140/MIMUW-ADB/parsed/title.csv'
INTO TABLE title
TRUNCATE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id,
    title,
    bibtex NULLIF bibtex='null',
    aux,
    label NULLIF label='null',
    type NULLIF type='null',
    publication_key
)
