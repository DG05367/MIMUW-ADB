parse-all:
	python3 python/xmlparser.py publication ./dataset/dblp.xml
	python3 python/xmlparser.py person ./dataset/dblp.xml
	python3 python/xmlparser.py series ./dataset/dblp.xml
	python3 python/xmlparser.py title ./dataset/dblp.xml
	python3 python/xmlparser.py rel ./dataset/dblp.xml
	python3 python/xmlparser.py cite ./dataset/dblp.xml
	python3 python/xmlparser.py personpublication ./dataset/dblp.xml

init:
	psql -d zbd < db/init.sql

copy-all:
	psql -d zbd < db/copy.sql