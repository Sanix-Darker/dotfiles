build:
	docker build --tag dev-container -f Dockerfile .

build-no-cache:
	docker build --tag dev-container --no-cache -f Dockerfile .

run:
	docker run --rm -v "$(echo $HOME)/code:/code" -it dev-container /bin/bash

exec:
	docker exec -it $(docker ps | grep dev-container | head -n1 | cut -d " " -f 1) /bin/bash
