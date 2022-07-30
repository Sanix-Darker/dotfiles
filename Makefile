.DEFAULT_GOAL=go

.PHONY: build
build:
	docker build --tag dev-container -f Dockerfile .

.PHONY: build-no-cache
build-no-cache:
	docker build --tag dev-container --no-cache -f Dockerfile .

.PHONY: run
run:
	docker run -v "${HOME}/code:/home/dk/code" --privileged -dt dev-container

.PHONY: exec
exec:
	docker exec -it "$$(docker ps | grep dev-container | head -n1 | cut -d " " -f 1)" /bin/bash

start:
	docker start "$$(docker ps -a | grep dev-container | head -n1 | cut -d " " -f 1)"

stop:
	docker stop "$$(docker ps | grep dev-container | head -n1 | cut -d " " -f 1)"

.PHONY: go
go: build run exec
