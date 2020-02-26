NAME = retrosynthesis

default:
		flask run --host=0.0.0.0 --port=80

run:
		flask run --host=0.0.0.0 --port=5050

install:
		pip install -r requirements.txt

build:
		docker build -t $(NAME).
		docker network create $(Name).

pull:
		git pull

deploy:
		(git pull | egrep 'up to date') || make rebuild

test:
		python test.py

rebuild: pull stop build run
