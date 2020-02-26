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
	conda install rdkit

build:
	docker build -t $(NAME).
	docker network create $(Name).

pull:
	git pull

deploy:
	(git pull | egrep 'up to date') || make rebuild

rebuild: pull stop build run
