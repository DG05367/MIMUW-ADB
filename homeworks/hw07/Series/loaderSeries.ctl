LOAD DATA
INFILE '/home/others/ti1140/MIMUW-ADB/parsed/series.csv'
INTO TABLE series
TRUNCATE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id,
    series,
    href NULLIF href='null',
    aux NULLIF aux='null',
    label NULLIF label='null',
    type NULLIF type='null',
    publication_key
)