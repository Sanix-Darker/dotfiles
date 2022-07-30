.DEFAULT_GOAL=go

.PHONY: build
build: ## to build the dev-container
	docker build --tag dev-container -f Dockerfile .

.PHONY: build-no-cache
build-no-cache: ## to build the dev-container and skip the cache
	docker build --tag dev-container --no-cache -f Dockerfile .

.PHONY: run
run: ## to run the dev-container
	docker run -v "${HOME}/code:/home/dk/code" --privileged -dt dev-container

.PHONY: exec
exec: ## to exec inside an allready build and running dev-container
	docker exec -it "$$(docker ps | grep dev-container | head -n1 | cut -d " " -f 1)" /bin/bash

.PHONY: start
start: ## to start an allready built dev-container
	docker start "$$(docker ps -a | grep dev-container | head -n1 | cut -d " " -f 1)"

.PHONY: stop
stop: ## to stop the running dev-container
	docker stop "$$(docker ps | grep dev-container | head -n1 | cut -d " " -f 1)"

.PHONY: go
go: build run exec ## to build, run and exec

.PHONY: help
help: ## to print this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {gsub("\\\\n",sprintf("\n%22c",""), $$2);printf "\033[36m%-20s\033[0m \t\t%s\n", $$1, $$2}' $(MAKEFILE_LIST)
