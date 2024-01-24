LOAD DATA
INFILE '/home/others/ti1140/MIMUW-ADB/parsed/person.csv'
INSERT INTO TABLE person
TRUNCATE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
   id SEQUENCE(MAX, 1),
   person,
   bibtex NULLIF bibtex='null',
   orcid NULLIF orcid='null',
   label NULLIF label='null',
   type NULLIF type='null'
)
