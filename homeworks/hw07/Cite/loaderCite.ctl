LOAD DATA
INFILE '/home/others/ti1140/MIMUW-ADB/parsed/cite.csv'
INSERT INTO TABLE CITE
TRUNCATE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
   id SEQUENCE(MAX, 1),
   cite,
   label NULLIF label='null',
   type NULLIF type='null',
   reference NULLIF reference='null',
   publication_key 
)
 