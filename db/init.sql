

-- clear tables from previous iteration:

DROP TABLE IF EXISTS person, series, publication, rel, title, cite, person_publication_relation;


-- table: publication
CREATE TABLE publication (
    key VARCHAR(2050) NOT NULL,
    type VARCHAR(2050) NOT NULL,
    mdate VARCHAR(2050) NULL,
    publtype VARCHAR(2050) NULL,
    reviewid VARCHAR(2050) NULL,
    rating VARCHAR(2050) NULL,
    cdate VARCHAR(2050) NULL,
    address VARCHAR(2050) NULL,
    booktitle VARCHAR(2050) NULL,
    pages VARCHAR(2050) NULL,
    year VARCHAR(2050) NULL,
    journal VARCHAR(2050) NULL,
    volume VARCHAR(2050) NULL,
    number VARCHAR(2050) NULL,
    month VARCHAR(2050) NULL,
    url VARCHAR(2050) NULL,
    ee VARCHAR(2050) NULL,
    school VARCHAR(2050) NULL,
    publisher VARCHAR(2050) NULL,
    note VARCHAR(2050) NULL,
    cdrom VARCHAR(2050) NULL,
    crossref VARCHAR(2050) NULL,
    isbn VARCHAR(2050) NULL,
    chapter VARCHAR(2050) NULL,
    publnr VARCHAR(2050) NULL,
    CONSTRAINT publication_pk PRIMARY KEY (key)
);

-- table: person
CREATE TABLE person (
    id SERIAL  NOT NULL,
    person VARCHAR(2050)  NOT NULL,
    bibtex VARCHAR(2050) NULL,
    orcid char(19)  NULL,
    label VARCHAR(2050) NULL,
    type VARCHAR(2050) NULL,
    CONSTRAINT person_pk PRIMARY KEY (id)
);

-- table: series
CREATE TABLE series (
    id SERIAL  NOT NULL,
    series VARCHAR(2050)  NOT NULL,
    href VARCHAR(2050)  NULL,
    label VARCHAR(2050) NULL,
    type VARCHAR(2050) NULL,
    publication_key VARCHAR(2050)  NOT NULL,
    CONSTRAINT series_pk PRIMARY KEY (id),
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- table: rel
CREATE TABLE rel(
    id SERIAL  NOT NULL,
    rel VARCHAR(2050),
    label VARCHAR(2050),
    type VARCHAR(2050),
    uri VARCHAR(2050),
    sort VARCHAR(2050),
    publication_key VARCHAR(2050)  NOT NULL,
    CONSTRAINT rel_pk PRIMARY KEY (id),
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- table: title
CREATE TABLE title(
    id SERIAL NOT NULL,
    title VARCHAR(2050),
    bibtex VARCHAR(2050),
    aux VARCHAR(255),
    label VARCHAR(2050),
    type VARCHAR(2050),
    CONSTRAINT title_pk PRIMARY KEY (id),
    publication_key VARCHAR(2050)  NOT NULL,
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

CREATE TABLE cite (
    id SERIAL PRIMARY KEY,
    cite VARCHAR(255) REFERENCES publication(key),
    aux VARCHAR(255),
    label VARCHAR(255),
    type VARCHAR(255),
    ref VARCHAR(255),
    publication_key VARCHAR(2050)  NOT NULL,
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- RELATIONS

CREATE TABLE person_publication_relation (
    relation_id SERIAL PRIMARY KEY,
    role VARCHAR(10), -- 'author' or 'editor'
    person_id SERIAL NOT NULL,
    publication_id VARCHAR(2050) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (publication_id) REFERENCES publication(key)
);
