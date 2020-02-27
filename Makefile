NAME = retrosynthesis

default:
	flask run --host=0.0.0.0 --port=80

run:
	gunicorn -b 0.0.0.0:5050 app:app -D
	http-server

build:
	docker build -t retrosynthesis . --no-cache

start:
	docker run -d -p 5050:5050 -p 8080:8080 retrosynthesis

stop:
	docker rm $(docker stop $(docker ps -a -q  --filter ancestor=retrosynthesis))

install:
	pip install -r requirements.txt --no-cache-dir

installother:
	conda install -c conda-forge rdkit
	npm install -g http-server

pull:
	git pull

deploy:
	(git pull | egrep 'up to date') || make rebuild

rebuild: pull stop build run
