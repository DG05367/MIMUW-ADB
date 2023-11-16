

-- clear tables from previous iteration:

DROP TABLE IF EXISTS person, series, publication, rel, title, person_publication_relation, title_publication_relation, noteurlcite_publication_relation, rel_publication_relation, series_publication_relation;


-- table: publication
CREATE TABLE publication (
    key VARCHAR(250) NOT NULL,
    type VARCHAR(250) NOT NULL,
    mdate VARCHAR(250) NULL,
    publtype VARCHAR(250) NULL,
    reviewid VARCHAR(250) NULL,
    rating VARCHAR(250) NULL,
    cdate VARCHAR(250) NULL,
    address VARCHAR(250) NULL,
    booktitle VARCHAR(250) NULL,
    pages VARCHAR(250) NULL,
    year VARCHAR(250) NULL,
    journal VARCHAR(250) NULL,
    volume VARCHAR(250) NULL,
    number VARCHAR(250) NULL,
    month VARCHAR(250) NULL,
    url VARCHAR(250) NULL,
    ee VARCHAR(250) NULL,
    school VARCHAR(250) NULL,
    publisher VARCHAR(250) NULL,
    note VARCHAR(250) NULL,
    cdrom VARCHAR(250) NULL,
    crossref VARCHAR(250) NULL,
    isbn VARCHAR(250) NULL,
    chapter VARCHAR(250) NULL,
    publnr VARCHAR(250) NULL,
    CONSTRAINT publication_pk PRIMARY KEY (key)
);

-- table: person
CREATE TABLE person (
    id SERIAL  NOT NULL,
    person VARCHAR(250)  NOT NULL,
    bibtex VARCHAR(250) NULL,
    orcid char(19)  NULL,
    label VARCHAR(250) NULL,
    type VARCHAR(250) NULL,
    CONSTRAINT person_pk PRIMARY KEY (id)
);

-- table: series
CREATE TABLE series (
    id SERIAL  NOT NULL,
    series VARCHAR(250)  NOT NULL,
    href VARCHAR(250)  NULL,
    label VARCHAR(250) NULL,
    type VARCHAR(250) NULL,
    publication_key VARCHAR(250)  NOT NULL,
    CONSTRAINT series_pk PRIMARY KEY (id),
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- table: rel
CREATE TABLE rel(
    id SERIAL  NOT NULL,
    rel VARCHAR(250),
    label VARCHAR(250),
    type VARCHAR(250),
    uri VARCHAR(250),
    sort VARCHAR(250),
    publication_key VARCHAR(250)  NOT NULL,
    CONSTRAINT rel_pk PRIMARY KEY (id),
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- table: title
CREATE TABLE title(
    id SERIAL NOT NULL,
    title VARCHAR(250),
    bibtex VARCHAR(250),
    label VARCHAR(250),
    type VARCHAR(250),
    CONSTRAINT title_pk PRIMARY KEY (id),
    publication_key VARCHAR(250)  NOT NULL,
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

CREATE TABLE cite (
    id SERIAL PRIMARY KEY,
    cite VARCHAR(255) REFERENCES publications(key),
    aux VARCHAR(255),
    label VARCHAR(255),
    type VARCHAR(255),
    ref VARCHAR(255),
    publication_key VARCHAR(250)  NOT NULL,
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- RELATIONS

CREATE TABLE person_publication_relation (
    relation_id SERIAL PRIMARY KEY,
    role VARCHAR(10), -- 'author' or 'editor'
    person_id VARCHAR(250) NOT NULL,
    publication_id VARCHAR(250) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (publication_id) REFERENCES publication(key)
);
