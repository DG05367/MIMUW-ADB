\copy publications FROM '../dataset/parsed/publication.csv' csv NULL AS 'null' QUOTE '''';
\copy person FROM '../dataset/parsed/person.csv' csv NULL AS 'null' QUOTE '''';
\copy author_editor_role FROM '../dataset/parsed/person_publication.csv' csv NULL AS 'null' QUOTE '''';
\copy title FROM '../dataset/parsed/title.csv' csv NULL AS 'null' QUOTE '''';
\copy cite FROM '../dataset/parsed/cite.csv' csv NULL AS 'null' QUOTE '''';
\copy rel FROM '../dataset/parsed/rel.csv' csv NULL AS 'null' QUOTE '''';
\copy series FROM '../dataset/parsed/series.csv' csv NULL AS 'null' QUOTE '''';
