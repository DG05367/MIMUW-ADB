parse-all:
	python3 python/xmlparser.py publication ./dataset/dblp.xml
	python3 python/xmlparser.py person ./dataset/dblp.xml
	python3 python/xmlparser.py series ./dataset/dblp.xml
	python3 python/xmlparser.py title ./dataset/dblp.xml
	python3 python/xmlparser.py rel ./dataset/dblp.xml
	python3 python/xmlparser.py cite ./dataset/dblp.xml
	python3 python/xmlparser.py personpublication ./dataset/dblp.xml
