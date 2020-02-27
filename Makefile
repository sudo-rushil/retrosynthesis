NAME = retrosynthesis

default:
	flask run --host=0.0.0.0 --port=80

run:
	gunicorn -b 0.0.0.0:5000 app:app -D
	http-server

build:
	docker build -t retrosynthesis .

start:
	docker run -p 5000:5000 -p 80:8080 retrosynthesis

stop:
	ps ax | grep gunicorn

install:
	pip install -r requirements.txt
	conda install -c conda-forge rdkit
	npm install -g http-server

pull:
	git pull

deploy:
	(git pull | egrep 'up to date') || make rebuild

rebuild: pull stop build run
