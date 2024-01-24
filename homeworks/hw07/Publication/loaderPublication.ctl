LOAD DATA
INFILE '/home/others/ti1140/MIMUW-ADB/parsed/publication.csv'
INSERT INTO TABLE publication
TRUNCATE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    key,
    type,
    mdate NULLIF mdate='null',
    publtype NULLIF publtype='null',
    reviewid NULLIF reviewid='null',
    rating NULLIF rating='null',
    cdate NULLIF cdate='null',
    address NULLIF address='null',
    booktitle NULLIF booktitle='null',
    pages NULLIF pages='null',
   publ_year NULLIF publ_year='null',
    journal NULLIF journal='null',
    volume NULLIF volume='null',
    num NULLIF num='null',
   publ_month NULLIF publ_month='null',
    url NULLIF url='null',
    ee NULLIF ee='null',
    school NULLIF school='null',
    publisher NULLIF publisher='null',
    note NULLIF note='null',
    cdrom NULLIF cdrom='null',
    crossref NULLIF crossref='null',
    isbn NULLIF isbn='null',
    chapter NULLIF chapter='null',
    publnr NULLIF publnr='null'
)