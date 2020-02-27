NAME = retrosynthesis

default:
	flask run --host=0.0.0.0 --port=80

run:
	gunicorn -b 0.0.0.0:5000 app:app -D
	http-server

stop:
	ps ax | grep gunicorn

install:
	pip install -r requirements.txt
	sudo apt-get install python-rdkit librdkit1 rdkit-data

pull:
	git pull

deploy:
	(git pull | egrep 'up to date') || make rebuild

rebuild: pull stop build run
