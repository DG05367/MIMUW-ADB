-- Table: publication
CREATE TABLE publication (
    key VARCHAR2(2050) NOT NULL,
    type VARCHAR2(2050) NOT NULL,
    mdate VARCHAR2(2050),
    publtype VARCHAR2(2050),
    reviewid VARCHAR2(2050),
    rating VARCHAR2(2050),
    cdate VARCHAR2(2050),
    address VARCHAR2(2050),
    booktitle VARCHAR2(2050),
    pages VARCHAR2(2050),
    year VARCHAR2(2050),
    journal VARCHAR2(2050),
    volume VARCHAR2(2050),
    number VARCHAR2(2050),
    month VARCHAR2(2050),
    url VARCHAR2(2050),
    ee VARCHAR2(2050),
    school VARCHAR2(2050),
    publisher VARCHAR2(2050),
    note VARCHAR2(2050),
    cdrom VARCHAR2(2050),
    crossref VARCHAR2(2050),
    isbn VARCHAR2(2050),
    chapter VARCHAR2(2050),
    publnr VARCHAR2(2050),
    CONSTRAINT publication_pk PRIMARY KEY (key)
);

-- Table: person
CREATE TABLE person (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    person VARCHAR2(2050) NOT NULL,
    bibtex VARCHAR2(2050),
    orcid VARCHAR2(19),
    label VARCHAR2(2050),
    type VARCHAR2(2050),
    CONSTRAINT person_pk PRIMARY KEY (id)
);

-- Table: series
CREATE TABLE series (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    series VARCHAR2(2050) NOT NULL,
    href VARCHAR2(2050),
    aux VARCHAR2(2050),
    label VARCHAR2(2050),
    type VARCHAR2(2050),
    publication_key VARCHAR2(2050) NOT NULL,
    CONSTRAINT series_pk PRIMARY KEY (id),
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- Table: rel
CREATE TABLE rel (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    rel VARCHAR2(2050),
    label VARCHAR2(2050),
    type VARCHAR2(2050),
    uri VARCHAR2(2050),
    sort VARCHAR2(2050),
    publication_key VARCHAR2(2050) NOT NULL,
    CONSTRAINT rel_pk PRIMARY KEY (id),
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- Table: title
CREATE TABLE title (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    title VARCHAR2(2050),
    bibtex VARCHAR2(2050),
    aux VARCHAR2(255),
    label VARCHAR2(2050),
    type VARCHAR2(2050),
    CONSTRAINT title_pk PRIMARY KEY (id),
    publication_key VARCHAR2(2050) NOT NULL,
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- Table: cite
CREATE TABLE cite (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    cite VARCHAR2(255),
    label VARCHAR2(255),
    type VARCHAR2(255),
    ref VARCHAR2(255),
    publication_key VARCHAR2(2050) NOT NULL,
    CONSTRAINT cite_pk PRIMARY KEY (id),
    FOREIGN KEY (publication_key) REFERENCES publication(key)
);

-- Table: person_publication_relation
CREATE TABLE person_publication_relation (
    relation_id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    role VARCHAR2(10), -- 'author' or 'editor'
    person_id NUMBER NOT NULL,
    publication_id VARCHAR2(2050) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (publication_id) REFERENCES publication(key)
);