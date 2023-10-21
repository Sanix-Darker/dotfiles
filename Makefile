.DEFAULT_GOAL=go

DEV_CONTAINER_NAME = dk-dev-box
HOME_SHARED_DIRECTORY_CODE = code
DEV_CONTAINER = `docker ps | grep ${DEV_CONTAINER_NAME} | head -n1 | cut -d ' ' -f 1`

build-cache: ## build the dev-container
	docker build --tag ${DEV_CONTAINER_NAME} -f Dockerfile .

build: ## build the dev-container and skip the cache
	docker build --tag ${DEV_CONTAINER_NAME} --no-cache -f Dockerfile .

run: ## run the dev-container
	docker run -v "${HOME}/${HOME_SHARED_DIRECTORY_CODE}:/home/dk/${HOME_SHARED_DIRECTORY_CODE}" --privileged -dt ${DEV_CONTAINER_NAME}

exec: ## exec inside an allready build and running dev-container
	docker exec -it "${DEV_CONTAINER}" /bin/bash

start: ## start an already built dev-container
	docker start "${DEV_CONTAINER}"

stop: ## stop the running dev-container
	docker stop "${DEV_CONTAINER}"

go: build run exec ## build, run and exec the container

help: ## print this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {gsub("\\\\n",sprintf("\n%22c",""), $$2);printf "\033[36m%-20s\033[0m \t\t%s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: help go stop exec run start build-cache build
