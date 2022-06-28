clean_docker_container 
clean_docker_images 
docker ps
cd ..
docker-compose api up
docker ps
docker logs backend_api_1 
docker-compose run postgresql
docker-compose stop postgresql
docker-compose down postgresql
docker-compose run postgresql
docker-compose up --build
docker-compose down
docker-compose up --build
docker-compose run api
docker ps
docker-compose run api
cd api/
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
cd database/migrate && go run autoMigrate.go
cd ..
v
cd ..
v
cd ..
nv docker-compose.yml 
cd api/
cd database/migrate && go run autoMigrate.go
v
cd ../..
v
docker ps
docker stop backend_postgresql_1 backend_redis_1 backend_mongodb_1 
clean_docker_container 
ll
rf jeveu-backend 
cd ..
docker-compose run api
cd api/
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
cd database/migrate && go run autoMigrate.go
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
cd api
cd ../../
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
docker-compose run api
docker run -p 5003:5003 -it jeveu-backend:latest 
v
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
docker run -p 5003:5003 -it jeveu-backend:latest 
docker ps
docker images
v
docker-compose run api
v
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
docker-compose run api
docker ps
clean_docker_container 
clean_docker_images 
ll
touch Makefile
nv Makefile 
clean_docker_container 
clean_docker_images 
make db
nv Makefile 
clean_docker_container 
clean_docker_images 
make api
clean_docker_container 
clean_docker_images 
nv Makefile 
clean_docker_container 
clean_docker_images 
make api
[Anv Makefile 
nv Makefile 
clean_docker_images 
clean_docker_container 
make api
clean_docker_container 
clean_docker_images 
nv Makefile 
clean_docker_container 
clean_docker_images 
ll
cd ..
docker-compose run databases
v
nv Makefile 
cd api/
nv Makefile 
make api
v
clean_docker_images 
clean_docker_container 
make api
cd ../ && docker-compose down
nv docker-compose.yml 
clean_docker_container 
clean_docker_images 
docker-compose run api
v
clean_docker_container 
clean_docker_images 
docker-compose run api
cp ./api/.env ./api/database/migrate/
cat ./api/database/migrate/.env
clean_docker_container 
clean_docker_images 
docker-compose run api
ll
cp docker-compose.yml docker-compose-databases.yml 
cp docker-compose.yml docker-compose-api.yml 
rf docker-compose.yml 
v
docker-compose -f ./docker-compose-databases.yml up
docker-compose -f ./docker-compose-databases.yml down
ll
nv Makefile 
docker-compose -f ./docker-compose-databases.yml up -d
docker-compose -f ./docker-compose-api.yml up
docker-compose down 
docker-compose -f ./docker-compose-api.yml down
docker-compose -f ./docker-compose-databases.yml down
v
docker-compose -f ./docker-compose-databases.yml down
docker-compose -f ./docker-compose-api.yml down
cat Makefile 
make databases 
make api
nv Makefile 
make start-api 
v
make databases 
make start-api 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
docker ps
clean_docker_container 
clean_docker_images 
cat docker-compose-databases.yml 
cat docker-compose-api.yml 
nv Makefile 
make start-api
cd api/database/migrate && go run autoMigrate.go
clean_docker_container 
clean_docker_images 
cd ../../
cd ..
make help
make --help
make ls
cat Makefile 
make database 
make migrate 
make build-api 
nv Makefile 
clean_docker_container 
clean_docker_images 
cat Makefile 
make database
nv Makefile 
make migrate 
make build-api 
make start-api 
nv Makefile 
clean_docker_container 
clean_docker_images 
cat Makefile 
make database 
make build-api 
docker-compose network ls
docker-compose network
docker ps
docker network ls
nv Makefile 
make start-api 
docker ps
cat docker-compose-api.yml 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
nv Makefile 
make start-api 
nv
nv Makefile 
docker-compose -f docker-compose-databases.yml down
clean_docker_container 
clean_docker_images 
make start-api 
docker-compose -f docker-compose-databases.yml down
clean_docker_images 
clean_docker_container 
cat Makefile 
nv Makefile 
make database && make build-api && make start-api
make database && make build-api
make start-api
nv start_api.sh
clean_docker_images 
clean_docker_container 
bash start_api.sh 
clean_docker_images 
clean_docker_container 
clean_docker_images 
rf start_api.sh 
ll
rf docker-compose-api.yml 
git status
touch .gitignore
nv .gitignore
nv Makefile 
clean_docker_container 
clean_docker_images 
make database && make build-api
clean_docker_container 
clean_docker_images 
make database 
make build-api 
make start-api 
v
cat Makefile 
cp Makefile Makefile 
cp Makefile ./api/
nv Makefile 
cd api/
nv Makefile 
clean_docker_images 
clean_docker_container 
cat Makefile 
nv Makefile 
cd ..
cat Makefile 
make database 
cd api/
ls
make migrate 
make build-api 
make start-api 
docker ps
docker stop backend_redis_1 
docker stop backend_postgresql_1 
docker ps
docker stop backend_mongodb_1 
clean_docker_container 
clean_docker_images 
docker images
docker rmi jeveu/backend:latest backend_api:latest hello-world:latest 
clean_docker_images 
clean_docker_container 
cd ..
git status
git add -A
git status
git commit -m "feat: deploy databases + backend"
gi status
git status
git push
pip3 install httpie
pip3 uninstall httpie
apt install httpie
sudo apt install httpie
https httpie.io/hello
http httpie.io/hello
sudo apt upgrade httpie
http httpie.io/hello
curl http://127.0.0.1:5003
curl http://0.0.0.0:5003
curl http://localhost:5003
v
docker ps
git status
git diff database/dbConnect.go
git status
curl http://127.0.0.1:5003
curl http://127.0.0.1:5003/api/v1/users
curl -X POST -H 'Content-type: application/json' http://127.0.0.1:5003/api/v1/users -d '{"FirstName": "sanix", "LastName": "darker"}'
docker-compose run api
docker-compose run api --build
cd api/
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
docker-compose run api --build
cd database/
cd migrate/
go run autoMigrate.go 
mv .env .endaasd
go run autoMigrate.go 
ll
rf .endaasd 
rf .env
cp .env.sample .env
go run autoMigrate.go 
createdb
go run autoMigrate.go 
cd ../../
docker-compose run api --build
createdb -p 5432 -h 127.0.0.1 -U superuser -e jeveu
createdb -p 5432 -h 127.0.0.1 -U postgres -e jeveu
docker-compose run api --build
docker ps
cd logs/
ls
rf *
cd ..
docker-compose run api --build
ll logs/
docker-compose run api --build
clean_docker_container 
clean_docker_images 
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
docker images
docker rmi backend_api:latest 
docker rmi jeveu-backend:latest 
docker rmi quay.io/toucantoco/http_data_service:*
docker rmi quay.io/toucantoco/http_data_service:1.0.1
docker rmi quay.io/toucantoco/http_data_service:1.0.2
docker rmi quay.io/toucantoco/http_data_service:1.0.3
docker rmi quay.io/toucantoco/http_data_service:1.0.4
docker rmi quay.io/toucantoco/http_data_service:1.0.5
docker rmi quay.io/toucantoco/http_data_service:1.0.6
docker rmi quay.io/toucantoco/http_data_service:1.0.7
docker ps
docker images
docker rmi quay.io/toucantoco/http_data_service:latest 
export PGPASSWORD="postgres"
createdb -p 5432 -h 127.0.0.1 -U postgres -e jeveu
createdb -p 5432 -h 0.0.0.0 -U postgres -e jeveu
docker ps
createdb -p 5432 -h 127.0.0.1 -U postgres -e jeveu
docker build --no-cache -t jeveu-backend:latest -f Dockerfile .
go run main.go 
cd database/
cd migrate/
go run autoMigrate.go 
cd ../
cd ..
go run main.go 
go build -o jeveu-backend
./jeveu-backend 
cd ACTUALC/
cd github/
cd jeveu/
git push
git rebase master
git status
rf CONTRIBUTORS.md 
git status
git add -A
git commit -m "clean: clean contributor markdown file"
git rebase master
v
git status
v docker-compose.yml 
nv docker-compose.yml 
git status
git add docker-compose.yml 
git add backend/
git status
git rebase --continue 
ll
v docker-compose.yml 
vim docker-compose.yml 
git status
cd backend/
ls
v
cd data/
ll
tree -L 3
tree -L 2
tree -L 5
cd api/
ls
cd ..
tree -L 2
cd data/mongo/
ls
cd ../../
cd ..
git status
git push --force
ll
ll -l
ls -al
cd backend/
ll -l
nv .gitignore 
cd api/
ll -al
nv .gitignore 
cd ../../
cd backend/
cd logs/
ll
rf *
ll
git status
git rm start\:2022-04-30T14\:27\:44Z.log 
git rm "start:2022-04-30T14:35:33Z.log"
git status
cd ..
git status
git add -A
git commit -m "clean: clean logs from .gitignore"
git status
it push
git push
ll logs
ls
mkdir logs
cd ..
ll
cd
htop
htop
cd ACTUALC/
cd toucantoco/
cd laputa/
git checkout master
git pull --prune
cd ..
cd tucana/
git checkout ma
git checkout master
git status
git diff
git status
git restore src/api/
git status
git stash
git checkout master
git pull --prune
cd ..
cd weaverbird/
git status
git checkout master 
git pull --prune
cd ..
cd toucan-connectors
git checkout master
git pull --prune
cd ..
cd laputa/
v
ee
nvim -c "normal '\''0"
vim -c "normal '\''0"
vim -c "normal ''0"
nvim -c "normal ''0"
nv ~/.vimrc 
nv ~/.config/nvim/init.vim 
v
nvim
vim
nvim .
nvim
v
nvim
nvim .
nvim
nvim .
nvim
nvim .
nvim
nv ~/.bash_aliases 
source ~/.bash_aliases 
v
de
cd ..
cd weaverbird/
git status
v
cd server/
v
ee
v
cd ..
nv src/lib/translators/mongo.ts 
v src/lib/translators/mongo.ts 
ee
it branch
git branch
git status
git checkout latest-monthly
git pull origin latest-monthly
git pull --prune origin latest-monthly
git pull --prune origin monthly
cat requirements/prod.txt  | grep pandas
curl 'https://api-daily-toucan.toucantoco.com/new-template-analytics/query-preview/instance?limit=50&offset=0&stage=staging'   -H 'authority: api-daily-toucan.toucantoco.com'   -H 'accept: */*'   -H 'accept-language: en-US,en;q=0.9,fr;q=0.8'   -H 'authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhbmdlLnNhYWRqaW9AdG91Y2FudG9jby5jb20iLCJpYXQiOjE2NTE0NzcxNTEsImV4cCI6MTY1MTUyMDM1MX0.nFRKgvzffBgk0pilXTNz9e9BfQH4X9ZW-hRuOwVGT0o'   -H 'cache-control: no-cache'   -H 'content-type: application/json'   -H 'cookie: hubspotutk=3bdac1d6eafd3c09dee0543dd20f076e; _gcl_au=1.1.901147202.1645011825; messagesUtk=afbecf7ad34445429cafc0d2f232ddce; _hjSessionUser_2417347=eyJpZCI6IjVkMjdmMjlhLWU0NjUtNTIwZS1hYWRmLWIwNDM5MDIwMGI4YyIsImNyZWF0ZWQiOjE2NDUwMTE4MjYxNTksImV4aXN0aW5nIjp0cnVlfQ==; _gid=GA1.2.1071962240.1651472480; _ga_YHS1QTL8PS=GS1.1.1651472490.6.0.1651472490.0; _ga=GA1.2.853701399.1644854185; access_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhbmdlLnNhYWRqaW9AdG91Y2FudG9jby5jb20iLCJpYXQiOjE2NTE0NzcxNTEsImV4cCI6MTY1MTUyMDM1MX0.nFRKgvzffBgk0pilXTNz9e9BfQH4X9ZW-hRuOwVGT0o; _uetsid=47aa8e70c9f011ecb0fadb51997c4069; _uetvid=a9469e408dae11ecb957f11dc40f00d8; mp_713432798ff5ba40903208da3dc8447a_mixpanel=%7B%22distinct_id%22%3A%20%2217ef8f30ad0bc5-0f60e358e310a4-1b2b1204-1fa400-17ef8f30ad1da1%22%2C%22%24device_id%22%3A%20%2217ef8f30ad0bc5-0f60e358e310a4-1b2b1204-1fa400-17ef8f30ad1da1%22%2C%22%24search_engine%22%3A%20%22google%22%2C%22%24initial_referrer%22%3A%20%22https%3A%2F%2Fwww.google.com%2F%22%2C%22%24initial_referring_domain%22%3A%20%22www.google.com%22%7D; _clck=x361f3|1|f14|0; __hstc=104589215.3bdac1d6eafd3c09dee0543dd20f076e.1644854185386.1650889103527.1651479438111.10; __hssrc=1; _clsk=1rub8j0|1651481318395|3|1|h.clarity.ms/collect'   -H 'origin: https://daily-toucan.toucantoco.com'   -H 'pragma: no-cache'   -H 'referer: https://daily-toucan.toucantoco.com/'   -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="101", "Google Chrome";v="101"'   -H 'sec-ch-ua-mobile: ?0'   -H 'sec-ch-ua-platform: "Linux"'   -H 'sec-fetch-dest: empty'   -H 'sec-fetch-mode: cors'   -H 'sec-fetch-site: same-site'   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.41 Safari/537.36'   --data-raw '{"domain":"users_input","name":"instance","type":"HttpAPI","load":true,"live_data":false,"parameters":{},"url":"users?deleted=true&field=username&field=lastView&field=createdAt&field=privileges&field=roles&field=deleted&field=deletedAt&field=groups"}'   --compressed
echo '{"data":[{"username":"iamtheadminmofo","roles":["ADMIN"],"groups":[],"privileges":{},"lastView":null,"createdAt":null,"deleted":null,"deletedAt":null},{"username":"toucanuser","roles":["USER"],"groups":[{"name":"ParisManager","id":"5c9ba8de6f79ea0e3144afc1"}],"privileges":{"go-inside":["view"],"delivery-team":["view"],"support-tech":["view"],"kibana-analytics":["view"],"product-dev":["view"],"customersuccess":["view"],"wttj":["view"],"ambassadeurs":["view"],"sdr":["view"],"care-team":["view"],"calling-killers":["view"],"infra":["view"],"aircall-analytics":["view"],"delivery":["view"],"ops":["view"],"opscsm":["view"],"opsalliance":["view"],"pod-embedded":["view"],"so6":["view"],"toucan-analytics-tokars":["view"],"explore-config-v2":["view"],"toucan-analytics-premium":["view"],"toucan-analytics":["view"],"demo":["view"],"Sales-europe":["view"]},"lastView":{"$date":1637916753408.0},"createdAt":null,"deleted":null,"deletedAt":null},{"username":"toucanadmin","roles":["ADMIN"],"groups":[{"name":"ParisManager","id":"5c9ba8de6f79ea0e3144afc1"}],"privileges":{},"lastView":null,"createdAt":null,"deleted":null,"deletedAt":null},{"username":"romain.chiudini@ardian.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"],"delivery-team":["none"],"support-tech":["none"],"kibana-analytics":["none"],"product-dev":["none"],"customersuccess":["none"]},"lastView":null,"createdAt":{"$date":1562317128427.0},"deleted":null,"deletedAt":null},{"username":"matt@firstmarkcap.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"],"delivery-team":["none"],"support-tech":["none"],"kibana-analytics":["none"],"product-dev":["none"],"customersuccess":["none"]},"lastView":{"$date":1563500681379.0},"createdAt":{"$date":1563301853088.0},"deleted":null,"deletedAt":null},{"username":"stephan@upneo.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"],"delivery-team":["none"],"support-tech":["none"],"kibana-analytics":["none"],"product-dev":["none"],"customersuccess":["none"]},"lastView":{"$date":1563562932102.0},"createdAt":{"$date":1563561000198.0},"deleted":null,"deletedAt":null},{"username":"maxime@balderton.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"],"delivery-team":["none"],"support-tech":["none"],"kibana-analytics":["none"],"product-dev":["none"],"customersuccess":["none"],"wttj":["none"]},"lastView":{"$date":1568650712710.0},"createdAt":{"$date":1564486285734.0},"deleted":null,"deletedAt":null},{"username":"aymeric.de-cardes@apax.fr","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"],"delivery-team":["none"],"support-tech":["none"],"kibana-analytics":["none"],"product-dev":["none"],"customersuccess":["none"],"wttj":["none"]},"lastView":{"$date":1566325291116.0},"createdAt":{"$date":1564686834463.0},"deleted":null,"deletedAt":null},{"username":"nid@idinvest.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1568742415258.0},"createdAt":{"$date":1567079380170.0},"deleted":null,"deletedAt":null},{"username":"kirill@taliscapital.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1567169042410.0},"createdAt":{"$date":1567079439371.0},"deleted":null,"deletedAt":null},{"username":"jean-francois.cochy@cathay.fr","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1568098638927.0},"createdAt":{"$date":1567092679949.0},"deleted":null,"deletedAt":null},{"username":"andreas@sapphireventures.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1567597443113.0},"createdAt":{"$date":1567160235784.0},"deleted":null,"deletedAt":null},{"username":"reza@partechpartners.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1567506369993.0},"createdAt":{"$date":1567504776400.0},"deleted":null,"deletedAt":null},{"username":"jdc@roundfield.net","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1576143157320.0},"createdAt":{"$date":1567534605195.0},"deleted":null,"deletedAt":null},{"username":"nb@ringcp.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1569583174789.0},"createdAt":{"$date":1567590769614.0},"deleted":null,"deletedAt":null},{"username":"jd.nitlech@iriscapital.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1567704215798.0},"createdAt":{"$date":1567703907445.0},"deleted":null,"deletedAt":null},{"username":"nicolas.rose@xange.fr","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":null,"createdAt":{"$date":1567771485594.0},"deleted":null,"deletedAt":null},{"username":"rodolphe@alven.co","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":null,"createdAt":{"$date":1567794282137.0},"deleted":null,"deletedAt":null},{"username":"partners@sapphireventures.com","roles":["USER"],"groups":[],"privileges":{"go-inside":["view"]},"lastView":{"$date":1568471091976.0},"createdAt":{"$date":1568470019173.0},"deleted":null,"deletedAt":null},{"username":"n.bailly1989@gmail.com","roles":["USER"],"groups":[],"privileges":{"ambassadeurs":["none"],"care-team":["none"],"customersuccess":["none"],"go-inside":["none"],"demo":["none"],"kibana-analytics":["none"],"product-dev":["none"],"delivery-team":["none"],"sdr":["none"],"support-tech":["none"],"wttj":["none"]},"lastView":{"$date":1580115452267.0},"createdAt":{"$date":1579772659813.0},"deleted":null,"deletedAt":null},{"username":"c.charroin@tbs-education.org","roles":["USER"],"groups":[],"privileges":{"calling-killers":["none"],"aircall-analytics":["none"],"ambassadeurs":["none"],"care-team":["none"],"customersuccess":["none"],"go-inside":["none"],"demo":["none"],"infra":["none"],"kibana-analytics":["none"],"ops":["none"],"opsalliance":["none"],"opscsm":["none"],"delivery":["none"],"product-dev":["none"],"delivery-team":["none"],"sdr":["none"],"support-tech":["none"],"toucan-analytics":["none"],"toucan-analytics-premium":["none"],"wttj":["none"]},"lastView":{"$date":1593000297266.0},"createdAt":{"$date":1593000263795.0},"deleted":null,"deletedAt":null},{"username":"dcoignet@dg4sales.com","roles":["USER"],"groups":[],"privileges":{"Sales-europe":["view"]},"lastView":{"$date":1604337910097.0},"createdAt":{"$date":1603971513517.0},"deleted":false,"deletedAt":null},{"username":"edfourcadepro@gmail.com","roles":["USER"],"groups":[],"privileges":{"sales-us":["none"],"Sales-europe":["view"]},"lastView":{"$date":1619822307186.0},"createdAt":{"$date":1604432359271.0},"deleted":false,"deletedAt":null},{"username":"webinarcro@toucantoco.com","roles":["USER"],"groups":[],"privileges":{"Sales-europe":["own"],"sales-us":["own"],"salesforce":["own"],"sales-performance":["own"],"ambassadeurs":["view"],"care-team":["view"],"aircall-analytics":["view"],"go-inside":["view"],"mdr":["view"],"opscsm":["view"],"delivery-team":["view"],"delivery":["view"]},"lastView":{"$date":1615912111265.0},"createdAt":{"$date":1615376745362.0},"deleted":false,"deletedAt":null},{"username":"alexis.richeux@gmail.com","roles":["USER"],"groups":[],"privileges":{"care-team":["view"],"csm":["none"]},"lastView":null,"createdAt":{"$date":1615563263107.0},"deleted":false,"deletedAt":null},{"username":"leorousseliere19022011@gmail.com","roles":["USER"],"groups":[],"privileges":{"sales-performance":["view"],"product-dev":["view"],"delivery":["view"],"ops-embed":["view"],"alliance":["view"]},"lastView":{"$date":1616643377564.0},"createdAt":{"$date":1616165991209.0},"deleted":false,"deletedAt":null},{"username":"alexis.richelieu@toucantoco.com","roles":["USER"],"groups":[],"privileges":{},"lastView":null,"createdAt":{"$date":1624625609939.0},"deleted":true,"deletedAt":{"$date":1624625633567.0}},{"username":"revops@toucantoco.com","roles":["USER"],"groups":[{"name":"ParisManager","id":"5c9ba8de6f79ea0e3144afc1"},{"name":"RevOps","id":"611a923b0c5b3b720648676a"}],"privileges":{"sales-performance":["own"],"csm":["own"]},"lastView":{"$date":1632162648547.0},"createdAt":{"$date":1629136509285.0},"deleted":false,"deletedAt":null},{"username":"mbourbigot1@gmail.com","roles":["USER"],"groups":[],"privileges":{},"lastView":{"$date":1630667446498.0},"createdAt":{"$date":1630667262196.0},"deleted":false,"deletedAt":null},{"username":"sophie+temp@toucantoco.com","roles":["USER"],"groups":[],"privileges":{"demo":["own"]},"lastView":{"$date":1632480672475.0},"createdAt":{"$date":1632477859880.0},"deleted":false,"deletedAt":null},{"username":"automation-revops-data@toucantoco.com","roles":["USER"],"groups":[{"name":"RevOps","id":"611a923b0c5b3b720648676a"},{"name":"portfolio","privileges":{},"use_group_privileges":false,"id":"625811cd8ddb498580ebf3e8"}],"privileges":{"sales-performance":["contribute"],"pipeline-generation":["contribute"]},"lastView":null,"createdAt":null,"deleted":false,"deletedAt":null},{"username":"thomas.garin+forensic@toucantoco.com","roles":["ADMIN"],"groups":[],"privileges":{},"lastView":null,"createdAt":{"$date":1643102302853.0},"deleted":false,"deletedAt":null},{"username":"raphael.vignes@laposte.net","roles":["USER"],"groups":[{"name":"ParisManager","id":"5c9ba8de6f79ea0e3144afc1"},{"name":"FranceManager","id":"5c9ba8de6f79ea0e3144afc2"},{"name":"RevOps","id":"611a923b0c5b3b720648676a"},{"name":"portfolio","privileges":{},"use_group_privileges":false,"id":"625811cd8ddb498580ebf3e8"}],"privileges":{"portfolio-perf":["own"],"sales-performance":["contribute"]},"lastView":{"$date":1651489196550.0},"createdAt":null,"deleted":false,"deletedAt":null}],"meta":{"count":33,"offset":0,"limit":50,"total_rows":33,"query_generation_time":null,"data_conversion_time":null,"df_memory_size":2240,"warnings":{},"types":{"username":"string","roles":"unknown","groups":"unknown","privileges":"unknown","lastView":"unknown","createdAt":"unknown","deleted":"long","deletedAt":"unknown"}}}' | jq
./env/bin/python3.8 
de
cd ..
cd weaverbird/
cd server/
ee
make format
make test
./env/bin/python3 -m pytest tests/
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py
tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_pandas] -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_pandas] -s -vv
git status
git diff tests/backends/fixtures/rank/pandas.json 
mv tests/backends/fixtures/rank/pandas.json tests/backends/fixtures/rank/simple.json
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_simple] -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline -s -vv
git diff tests/backends/fixtures/rank/simple.json 
git status
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_simple] -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_simple] -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_group_by] -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_simple] -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_group_by] -s -vv
./env/bin/python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline -s -vv
git status
git checkout -b feat/mongo-translator-rank
git status
git add -p
git status
git add src/weaverbird/
git add tests/backends/
git status
make format && make lint
git status
ll
cd ..
ll
cat docker-compose.yml 
docker-compose up --build
docker ps
clean_docker_container 
clean_docker_images 
docker-compose up
docker-compose down
ee
cd server/
ee
git status
git commit -m "feat(python-mongo-translator): rank step"
git status
git push
git push --set-upstream origin feat/mongo-translator-rank
make test
pytest tests/backends/pandas_executor/test_pandas_executor_steps.py -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/rank_simple]
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py -s -vv
python3 -m pytest tests/backends/ -s -vv
git status
git add tests/backends/
git status
git commit --amend
git push --force
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_mongo_simple] -s -vv
python3 -m pytest tests/backends/ -s -vv
git status
git diff
git add -p
git commit --amend
git push --force
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_mongo_simple] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_mongo_simple_standard] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_mongo_simple_dense] -s -vv
git status
git restore tests/
git status
rf tests/backends/fixtures/rank/mongo_simple_*
git status
python3 -m pytest tests/backends/ -s -vv
git status
git add -p
git commit --amend
git push --force
python3 -m pytest tests/backends/ -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/rank_mongo_simple] -s -vv
python3 -m pytest tests/backends/ -s -vv
git status
git add tests/backends/
git status
git commit --amend
git push --force
git status
git checkout master 
git pull --prune
git checkout -b feat/mongo-translator-delete
git status
python3 -m pytest tests/backends/ -s -vv
python -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/delete_simple] -s -vv
python -m pytest tests/backends/ -s -vv
make format && make lint
git status
git add src/weaverbird/backends/
git status
git add tests/backends/
git status
git commit -m "feat(python-mongo-translator): delete step"
git push
git push --set-upstream origin feat/mongo-translator-delete
git status
git checkout master 
git pull --prune
git checkout -b feat/mongo-translator-substring
make format
python3 -m pytest tests/backends/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/substring_simple] -s -vv
make format
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/substring_simple] -s -vv
make format && make lint
python3 -m pytest tests/backends/ -s -vv
git status
git add src/weaverbird/backends/mongo_translator/steps/substring.py 
git add -p
git status
git commit -m "feat(python-mongo-translator): extract substring step"
git push
git push --set-upstream origin feat/mongo-translator-substring
git checkout feat/mongo-translator-rank
python3 -m pytest tests/backends/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_group_by] -s -vv
git status
git diff
git status
python3 -m pytest tests/backends/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_simple] -s -vv
git status
git diff
git status
git restore src/
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/rank_simple] -s -vv
git restore src/
git status
make format
make lint
it status
git status
git add -p
git statis
git status
got commit -m "doc: added missing docstring"
git commit -m "doc: added missing docstring"
git push
ee
v
e
ee
python3
git status
git restore laputa/app/etl/
git status
make format
git status
git checkout monthly
git status
git stash
git status
git checkout monthly
git pull --prune
git checkout -b fix/refresh_data
git status
git stash pop
git status
make format && make lint
git status
git add -p
git status
git commit -m "fix: fix a check error on ToDictWorker"
git push
git push --set-upstream origin fix/refresh_data
pytest tests/app/etl/test_loader.py -s -vv
pytest tests/app/etl/test_loader_multiprocess.py -s -vv
git status
git reset 
git status
git restore laputa/
git restore tests/
git status
cat laputa/common/parameters/config.yml | grep secret_ua
cd
docker ps
docker ps -a
laputa_run 
./env/bin/pip3 install -r requirements/prod.txt 
laputa_run 
cd
cd ACTUALC/
cd toucantoco/
cd tucana/
yarn 
cd
tucana_run 
ee
cd
tc_indus02
cd ACTUALC/
cd toucantoco/
cd ..
cd github/
cd broken_link_checker/
git pull --prune
git status
git stash
git status
git merge --abort 
git status
git pull --prune
v
git pull origin fix-makefile-dependencies
git status
git merge --abort 
git status
git diff
git stash
git status
git branch
git checkout fix-makefile-dependencies
v
de
cd ..
rf broken_link_checker/
git clone git@github.com:osscameroon/broken_link_checker.git
cd broken_link_checker/
git checkout patch
git rebase main 
v
ee
make install-deps 
de
rf blc_venv/
make install-deps 
git branch
git pull --prune
git checkout main 
git pull --prune
git status
git merge --abort 
git pull --prune
git checkout patch
cd ../
cd broken_link_checker/
git stash
git status
git add broken_link_checker/checker.py 
git rebase --continue 
git status
git checkout main 
make run link='google.com'
make run link='https://google.com'
make run link='http://example.com'
make run link='http://elhmn.com'
make run link='https://elhmn.com'
git branch
git checkout patch
make run link='https://elhmn.com'
cd Ac
cd ACTUALC/
cd github/
mkdir jdg
cd jdg
v TODO.txt
sudo apt-get autoremove gimp gimp-plugin-registry
sudo add-apt-repository ppa:otto-kesselgulasch/gimp
sudo apt-get update
sudo apt-get install gimp
sudo apt-get install libgimp2.0
sudo apt-get install libgegl-0.4-0
sudo apt-get install libopenexr23
sudo snap install gimp --channel=edge
wget https://downloads.tuxfamily.org/godotengine/3.4.4/Godot_v3.4.4-stable_x11.64.zip
xdg-open .
./Godot_v3.4.4-stable_x11.64 
cd
cd ACTUALC/github/broken_link_checker 
git checkout main 
git pull --prune
ll
xdg-open .
git checkout -b v2
ll
rf broken_link_checker/
md blc
cd ..
v
cd ACTUALC/github/broken_link_checker 
v
make install-deps 
ll
rf blc_venv/
rf README-PYPI.md 
ll
make install-deps 
rf blc_venv/
make install-deps 
rf blc_venv/
make install-deps 
rf blc_venv/
make install-deps 
rf blc_venv/
make install-deps 
./blc_env/bin/python3
./blc_venv/bin/python3
./blc_venv/bin/python3 -m blc --help
./blc_venv/bin/python3 -m blc https://elhmn.com
make format
make lint
make format
rf blc_venv/
make install-deps 
make format
./blc_venv/bin/python3 -m isort blc/__main__.py
./blc_venv/bin/python3 -m black blc/__main__.py
make format
v
nv asddsa
v asddsa
v
make run https://elhmn.com
make run 'https://elhmn.com'
make run --help
make run '--help'
cat Makefile 
$(PYTHON) -m blc --help
./blc_venv/bin/python3 -m blc --help
./blc_venv/bin/python3 -m blc https://elhmn.com
./blc_venv/bin/python3 -m blc https://elhmsadasdasn.com
./blc_venv/bin/python3 -m blc https://example.com
git status
git add -A
git commit -m "feat: erase and refactor using BeautifullSoup"
git status
cd
cd ACTUALC/toucantoco/laputa/Makefile 
cat ACTUALC/toucantoco/laputa/Makefile 
cd ACTUALC/
cd github/broken_link_checker 
v
ee
v
git pull --prune
cd server/
ee
./env/bin/python3
cd
mkdir godot
cd godot
mkdir games
cd ../..
cd
cd ACTUALC/
cd
cd ACTUALC/toucantoco/laputa
git checkout 
git status
git stash
git checkout master
git pull --prune
cd ..
cd tucana/
git pull --prun
git pull --prune
cd ..
cd weaverbird/
git checkout master 
git pull --prune
cd ..
cd toucan-connectors
git pull --prune
git status
git merge --abort
git status
cd ../
llll
ll
cd http_data_service/
git pull --prune
v
cd ..
cd weaverbird/
v
git pull --prune
git checkout mongo-extract-date
v
git checkout master 
git pull --prune
cd -- server/doc
cd ..
ee
v
cd
cd ACTUALC/toucantoco/http_data_service 
git branch
git status
git stash pop
git stash
git status
git cd benchmark_tools/
cd benchmark_tools/
ll
cd dataservice-after-load/
ls
v script
v script.js 
k6 run script.js 
v
k6 run script.js 
ll
cd ..
ll
source varsk6local 
cd dataservice-after-load/
k6 run script.js 
tc_indus02
ee
make format
v
ee
make format
python3 -m pytest tests/backends/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/split_simple] -s -vv
git status
make format
git checkout -b feat/mongo-translator-split
git add -p
git status
git add src/weaverbird/backends/mongo_translator/steps/
git status
git commit -m "feat(mongo-translator): added split step"
git push
git push --set-upstream origin feat/mongo-translator-split
make format && make lint
git status
git checkout master 
make format
python3
make format
make format && make lint
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py -s -vv
python3 -m pytest tests/backends/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/evolution_perc_groups] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/evolution_abs_groups] -s -vv
python3 -m pytest tests/backends/pandas_executor/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/evolution_abs_groups] -s -vv
python3 -m pytest tests/backends/pandas_executor/ -s -vv
git status
python3 -m pytest tests/backends/pandas_executor/ -s -vv
python3 -m pytest tests/backends/mongo_translator/ -s -vv
git status
make format && make lint
git status
git checkout -b feat/mongo-translator-evolution
git status
git add src/weaverbird/backends/mongo_translator/steps/
git status
git add -p
git status
git commit -m "feat(python-mongo-translator): evolution step"
git push
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline -s -vv
git status
git add -p
git status
git add tests/backends/
git commit --amend
git push --force
git push --set-upstream origin feat/mongo-translator-evolution
make format
git add -p
git commit --amend
git push --force
git checkout master 
make format
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/ -s -vv
git status
git checkout -b feat/mongo-translator-duplicate
gt status
git status
git add src/weaverbird/backends/
git add -p
git status
git commit -m "feat(python-mongo-translator): added duplicate step"
git status
git push
git push --set-upstream origin feat/mongo-translator-duplicate
git status
git checkout master 
git pull --prune
git checkout -
git rebase master 
make format
git status
git add src/weaverbird/
git status
git rebase --continue 
git status
git push --force
git status
git branch
git checkout master 
git pull --prune
git checkout feat/mongo-translator-evolution 
git rebase master 
make format
git rebase --continue 
git status
git add src/weaverbird/
git status
git rebase --continue 
git status
git push --force
cd
cd ACTUALC/
cd
cd ACTUALC/github/broken_link_checker 
v
ee
v
ll
cat example.com_internal_links.txt 
cat elhmn.com_internal_links.txt 
./blc_venv/bin/python3 -m blc https://example.com
./blc_venv/bin/python3 -m blc https://elhmn.com
python
./blc_venv/bin/python3 -m blc https://example.com
ll
rf *.txt
git status
git restore requirements.txt
git restore prod-requirements.txt
git status
cat example.com_report.json |jq
git rm --cached example.com_*txt
git rm --cached elhmn.com_*txt
git status
git rm --cached elhm.com_*txt
git rm --cached elhm*txt
git status
git add -p
ll
rf example.com_report.json 
./blc_venv/bin/python3 -m blc https://elhmn.com
ll
cat elhmn.com_report.json | jq
git status
git commit -m "clean: clean + add a recursive check on the url"
git status
ll
rf elhmn.com_report.json 
ll
git status
ll
ll blc
ll
ll blc
less blc/__main__.py 
./blc_venv/bin/python3 -m blc https://elhmn.com
cat elhmn.com_report.json | jq
git status
git add -A
git commit -m "feat: add count good/bad"
git push
ll
ll blc
./blc_venv/bin/python3 -m blc https://elhmn.com
cat elhmn.com_report.json | jq
ll
rf elhmn.com_report.json 
ll
ll blc
./blc_venv/bin/python3 -m blc https://elhmn.com
cat elhmn.com_report.json | jq
git push
git push --set-upstream origin v2
ll
v README.md 
rf README.md 
git status
git add -A
git commit --amend
git push --force
ll
./blc_venv/bin/python3 -m blc https://osscameroon.com
./blc_venv/bin/python3 -m blc https://www.osscameroon.com
./blc_venv/bin/python3 -m blc https://blog.osscameroon.com
./blc_venv/bin/python3 -m blc osscameroon.com
./blc_venv/bin/python3 -m blc http://osscameroon.com
./blc_venv/bin/python3 -m blc http://osscameroon.com/
./blc_venv/bin/python3 -m blc http://osscameroon.com/projects
./blc_venv/bin/python3 -m blc http://osscameroon.com/projectsff
./blc_venv/bin/python3 -m blc http://osscameroon.cor
v
./blc_venv/bin/python3 -m blc http://osscameroon.cor
v
./blc_venv/bin/python3 -m blc http://osscameroon.cor
v
./blc_venv/bin/python3 -m blc http://osscameroon.cor
v
./blc_venv/bin/python3 -m blc http://osscameroon.cor
ll
cat www.osscameroon.com_report.json | jq
cat osscameroon.cor_report.json | jq
v
./blc_venv/bin/python3 -m blc http://osscameroon.cor
./blc_venv/bin/python3 -m blc http://osscameroon.comm
./blc_venv/bin/python3 -m blc http://osscameroon.com
./blc_venv/bin/python3 -m blc https://osscameroon.com
v
v dd.py
./blc_venv/bin/pip3 install requests_html
./blc_venv/bin/python3 ./dd.py http://example.com
./blc_venv/bin/python3 ./dd.py https://osscameroon.com
cd
cd backend/
cd api/
cd ..
make database 
cd api/
cat Makefile 
make start-api 
make build-api 
make start-api 
docker ps
ll
go run main.go 
cd ACTUALC/
cd
cd ACTUALC/github/jeveu/data 
cd ..
cd backend/
ls
cat Makefile 
cd api/
v
gin --appPort 5003 --port 5003
go get github.com/codegangsta/gin
go get -d github.com/codegangsta/gin
gin --appPort 5003 --port 5003
docker ps
fuser -k 5003/tcp
sudo fuser -k 5003/tcp
gin --appPort 5003 --port 5003
gin --appPort 5004 --port 5003
gin --appPort 5003 --port 5002
gin --appPort 5001 --port 5002
make dev
git status
ll
file gin-bin 
which gin 
rf gin-bin 
make dev
git status
git add -p
git status
git commit -m "feat: add a debug on reload mode"
git push
ee
python3 -m pytest tests/backends/mongo_translator/ -s -vv
git status
python3 -m pytest tests/backends/mongo_translator/ -s -vv
git status
git restore tests/backends/fixtures/evolution/perc_groups.json
git restore tests/backends/fixtures/evolution/perc_groups_mongo.json
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/ -s -vv
git status
git add -p
git status
git commit
git status
git push
git checkout master 
git pull --prune
git checkout -
git rebase master 
git status
git add src/weaverbird/
git status
git rebase --continue 
git status
git push --force
cd ..
cd src/
ls
v
cd ../laputa/
v
cd ..
cd weaverbird/
cd src/
cd lib/
cd translators/
git blame mongo.ts
cd ..
cd ../..
cd server/
v
python
git checkout master 
git pull --prune
git checkout -b feat/mongo-translator-compareText
make format
ee
make format
ee
make format
git status
make format
python3 -m pytest tests/backends/ -s -vv
git status
git add src/weaverbird/backends/mongo_translator/steps/
git status
git add -p
git status
git commit -m "feat(python-mongo-translator): comparetext step"
git push
git push --set-upstream origin feat/mongo-translator-compareText
make format
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/trim_single_column] -s -vv
python3 -m pytest tests/backends/mongo_translator/ -s -vv
git status
python3 -m pytest tests/backends/ -s -vv
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/pandas_executor/ -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/sql_translator/test_sql_postgres_translator_steps.py -s -vv
code .
python3 -m pytest tests/backends/pandas_executor/ -s -vv
python3 -m pytest tests/steps/test_waterfall.py -s -vv
cd tests/
cd steps/
python3 -m pytest ./test_waterfall.py -s -vv
../../env/bin/python3 -m pytest ./test_waterfall.py -s -vv
cd ../../
python3 -m pytest tests/steps/test_waterfall.py -s -vv
python3 -m pytest tests/steps/test_waterfall.py::test_with_groups -s -vv
python3 -m pytest tests/steps/test_waterfall.py -s -vv
python3 -m pytest tests/backends/pandas_executor/ -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_with_groups] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_bug_drill] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py -s -vv
git status
make format
git restore tests/steps/test_waterfall.py
git status
python3 -m pytest tests/backends/ -s -vv
git status
git checkout master 
git status
git checkout -b tests/waterfall-fixtures
git add tests/backends/fixtures/waterfall/
git status
git commit -m "test: added missing waterfall fixtures"
git push
git push --set-upstream origin tests/waterfall-fixtures
git branch
git checkout feat/mongo-translator-waterfall 
git status
git stash
git status
git rebase tests/waterfall-fixtures
git status
git stash pop
git status
git add src/weaverbird/backends/
git status
git commit -m "feat(python-mongo-translator): added waterfall step"
git push
git push --set-upstream origin feat/mongo-translator-waterfall
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_with_groups] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
./env/bin/pip3 install ipdb
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/pandas_executor/ -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/mongo_translator/ -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
git status
make format && make lint
git add -p
git status
git restore --staged src/
git status
git restore --staged tests/
git status
git log
git add src/
git status
git commit --amend
git status
git add tests/backends/fixtures/waterfall/simple.json -p
git status
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
git staut
sgit status
git status
git add tests/backends/fixtures/waterfall/simple.json -p
git status
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
git status
git add tests/backends/fixtures/waterfall/simple.json -p
git status
git commit
git status
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_withgroups] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_with_groups] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
git status
git diff src/weaverbird
git restore src/
git status
git diff tests/backends/fixtures/waterfall/simple.json 
git restore tests/backends/fixtures/waterfall/simple.json 
git status
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
git status
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_simple] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_with_groups] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_with_groups] -s -vv
git status
git diff tests/backends/fixtures/waterfall/with_groups.json 
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_with_groups] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_with_groups] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_with_groups] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_with_groups] -s -vv
git status
git log
git status
git add tests/backends/fixtures/waterfall/with_groups.json -p
git status
git commit
git status
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_with_aggregation] -s -vv
python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py::test_mongo_translator_pipeline[/waterfall_with_aggregation] -s -vv
git status
git log
git add tests/backends/fixtures/waterfall/with_aggregation.json -p
git commit
git status
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/bug_drill] -s -vv
python3 -m pytest tests/backends/pandas_executor/test_pandas_executor_steps.py::test_pandas_execute_pipeline[/waterfall_bug_drill] -s -vv
git status
git stash
git branch
git checkout tests/waterfall-fixtures
git status
rf tests/backends/fixtures/waterfall/bug_drill.json 
rf tests/backends/fixtures/waterfall/bug_duplicate_rows.json 
git status
git commit --amend
git push --force
git checkout -
git status
git rebase tests/waterfall-fixtures
git stash
git status
git rebase tests/waterfall-fixtures
git status
git checkout -
rf tests/backends/fixtures/waterfall/with_aggregation.json 
rf testests/backends/fixtures/waterfall/bug_drill.json 
rf tests/backends/fixtures/waterfall/bug_duplicate_rows.json 
git status
git commit --amend
git status
git add tests/
git commit --amend
git push --force
git checkout -
git rebase tests/waterfall-fixtures
git status
git checkout -
git status
git log
git reflog
rf tests/backends/fixtures/waterfall/bug_drill.json 
git status
git add tests/
git commit --amend
git push --force
git checkout -
git status
git push --force
rf tests/backends/fixtures/waterfall/bug_drill.json 
rf tests/backends/fixtures/waterfall/bug_duplicate_rows.json 
git status
git add tests/backends/
git status
git commit -m "test: clean unecessary overkilled fixtures"
git push
git rebase tests/waterfall-fixtures 
git status
git push --force
git status
git branch 
git checkout feat/mongo-translator-trim 
git status
make format && make lint
python3 -m pytest We should have these informations : -s -vv
- all the links tested
- all the links succeeded
- all the links failed
Asking this because some websites like osscameroon.com is built using React, therefore, the requests.get is not going to "load" the page and its links... just some small html and a div like <div id="root"></div> (as far as i can remember, didn't touch react since a long time) where the JS binding file is supposed to render the SPA.
PS: "NOT TESTED on my end", I may be wrong, but i think you should check the 'content' result you fetch from PWA.
How to deal with this ?
using a JScrawler... or if you want to don't change your actual code loggic, use requests_html is your way to go... (it will download a chromium binary that will be called to render pages in background).

Not sure i may available this night for a session of live coding, but feel free to share your questions here in the chat @pythonbrad !

python3 -m pytest tests/backends/mongo_translator/test_mongo_translator_steps.py -s -vv
git status
git add -p
git commit -m "fix: columns are required, no need for an 'or' check"
git push
git status
git add src/weaverbird/backends/
git status
git add tests/backends/
git status
git stash
git status
git checkout master 
git pull --prune
git checkout -b feat/mongo-translator-trim
git stash pop
git status
git add -p
make format
ee
make format
git status
git commit -m "feat(python-mongo-translator): added trim step"
git tatus
git status
git push
git push --set-upstream origin feat/mongo-translator-trim
git checkout master 
git pull --prune
git checkout -b feat/mongo-translator-waterfall
python
make format
git status
make format && make lint
make format
ll
cd ..
ll
docker-compose up
clean_docker_container 
docker-compose up
clean_docker_container 
docker-compose up
docker-compose down
htop
cd
pip install -i https://test.pypi.org/simple/ blc
blc --version
cd ACTUALC/
cd
cd ACTUALC/github/broken_link_checker 
git status
git rf example.com_*
git rm --cachec example.com_*
git rm --cached example.com_*
git rm --cached example.com_*.txt
git rm --cached example.com_external_links.txt
git rm --cached example.com_internal_links.txt
git status
git add dd
git add dd.py 
git add -p
git status
git commit -m "feat: experiments"
git checkout main 
git pull --prune
make run link='elhmn.com'
git checkout patch
make run link='elhmn.com'
make run link='example.com'
make run link='http://example.com'
cd
cd ACTUALC/toucantoco/tucana/
git pull --prune
tucana_run 
cd ACTUALC/
cd
cd ACTUALC/toucantoco/laputa/
git pull --prune
cd
laputa_run 
clean_docker_container 
clean_docker_images 
laputa_run 
cd
de
ll ~/.*
ll -f ~/.*
ll -p ~/.*
ll -p ~/.* | grep -v
ll -p | grep -v ~/.*
ll -p | grep -v ~/
ll -p | grep -v .
ll -p | grep -v ./.
ls -F | grep -v /
ls -F | grep -v ~/
ls -F | grep -v ~/.
ls -F | grep -v ~/.*
nv ~/.bash_aliases 
v ~/.bash_aliases 
source ~/.fzf.bash 
v ACTUALC/github/tidi 
cd ACTUALC/github/tidi 
v
git clone git@github.com:Sanix-Darker/dotfiles.git
source ~/.bash_aliases 
tc_indus0
tc_indus02
source ~/.bash_aliases 
tc_indus02
source ~/.bash_aliases 
tc_indus02
source ~/.bash_aliases 
tc_indus02
source ~/.bash_aliases 
tc_indus02
source ~/.bash_aliases 
tc_indus02
source ~/.bash_aliases 
tc_indus02
ll
ll -a
ls -al
bat .vimrc 
sudo apt install bat
ls -al
bat .vimrc 
batcat vimrc
batcat 
batcat --version
batcat --help
ll
cat .zshrc
batcat .zshrc
ls -al
batcat .vimrc 
ls -al
cd .vim/
ls
cd autoload/
ls
cd ..
cd colors/
ls
delta onedark.vim ../autoload/onedark.vim 
cd ..
ls
cd plugged/
ls
cd ..
cd undo/
s
ls
ll
batcat %home%dk%.gitconfig
file %home%dk%.gitconfig
cd ..
ls
ll colors/
cd ..
cd -
ll autoload/
cat buflist.txt 
cd ..
nvim --headless +PlugInstall +qall
ll -l ~.bash*
ll -l ~/.bash*
batcat ~/.bash_logout 
ls -al
batcat .yarnrc
ll -l ~/.git*
ls -al ~/.bash
ls -al ~/.bash*
ll -l ~/.git*
source ~/.bash_aliases 
cat .gitconfig 
nv ~/.gitconfig 
cd ACTUALC/github/s2c 
git commit --amend
git log
cd -
source ~/.bash_aliases 
ls -al
cat .zshrc 
ll
ls -al
cd .gittar/
ls
cd github/
lsl
ls
cd ../
cd github/
cd preactjs-templates/
v
cd ..
cd -
cd
cd ACTUALC/github/ckp 
git log
git log -p
cd
ll
cat .actrc 
cat .fzf.bash 
date
echo date
$(echo date)
source ~/.bash_aliases 
ll dotfiles/
_push_dot_files 
ll dotfiles/
ls -al dotfiles/
_push_dot_files 
source ~/.bash_aliases 
_push_dot_files 
source ~/.bash_aliases 
_push_dot_files 
cp ~/.config/nvim/init.vim ~/dotfiles/
ls -al dotfiles/
rf ~/dotfiles/init.vim 
cd $HOME/dotfiles
cd -
source ~/.bash_aliases 
_push_dot_files 
git status
ll
git reset
git status
rf .bash*
rf .vim*
git status
rf init.vim 
rf .gitconfig 
git status
ll
cd
source ~/.bash_aliases 
_push_dot_files 
cd
_push_dot_files 
source ~/.bash_aliases 
cd
_push_dot_files 
git status
sleep 1;alert
echo "doum";alert
apt list
apt list | wc -l
sudo apt install silversearcher-ag
source ~/.bash_aliases 
_install_dev_stack 
ll
cd
nv ~/.config/nvim/init.vim 
cd ACTUALC/toucantoco/weaverbird 
v
nv ~/.config/nvim/init.vim 
cd
cd dotfiles/
v
echo FZF_DEFAULT_COMMAND
echo $FZF_DEFAULT_COMMAND
v
nv ~/.config/nvim/init.vim 
nv ~/.vimrc 
cd
cd /
cat etc/vim/vimrc 
cat etc/vim/vetc/vim/vimrc.tiny 
cd home/dk/ACTUALC/github/s2c 
v
ag --hidden --ignore .git -f -g "import"
ag --hidden --ignore .git -f -g "im"
ag --hidden --ignore .git -f -g "i"
ag --hidden --ignore .git -f -g "LICEN"
nv ~/.config/nvim/init.vim 
nv ~/.vimrc
cd ~/.config/nvim/
ls
ls -al
nv init.vim 
source ~/.bash_aliases 
nv init.vim 
nv ~/.fzf.bash 
source ~/.fzf.bash 
cd ACTUALC/github/s2c 
cd -
nv ~/.vimrc 
cd ACTUALC/github/weaverbird_bumper 
v
cd ..
ls
cd d-exe-action
v
nv ~/.vimrc 
v
cd -
nv ~/.config/nvim/init.vim 
ls
cd broken_link_checker/
v
sudo snap install universal-ctags
v
## dotfiles management
DOT_DIR="$HOME/dotfiles"
# Assuming we already have the dotfiles directory
# on our workspace
_set_dot_files(){
    cp $DOT_DIR/init.vim ~/.config/nvim/;     cp $DOT_DIR/.vimrc ~/.vimrc;     cp $DOT_DIR/.vim_autoload_onedark.vim ~/.vim/autoload/onedark.vim;     cp $DOT_DIR/.vim_colors_onedark.vim ~/.vim/colors/onedark.vim
    nvim --headless +PlugInstall +qall
    cp $DOT_DIR/.bashrc ~/.bashrc;     cp $DOT_DIR/.bash_aliases ~/.bash_aliases;     cp $DOT_DIR/.bash_history ~/.bash_history;     cp $DOT_DIR/.bash_logout ~/.bash_logout
    cp $DOT_DIR/.gitconfig ~/.gitconfig; }
_push_dot_files(){
    cp ~/.config/nvim/init.vim $DOT_DIR;     cp ~/.vimrc $DOT_DIR;     cp ~/.vim/autoload/onedark.vim $DOT_DIR/.vim_autoload_onedark.vim;     cp ~/.vim/colors/onedark.vim $DOT_DIR/.vim_colors_onedark.vim
    cp ~/.bashrc $DOT_DIR;     cp ~/.bash_aliases $DOT_DIR;     cp ~/.bash_history $DOT_DIR;     cp ~/.bash_logout $DOT_DIR
    cp ~/.gitconfig $DOT_DIR;     cd $DOT_DIR;     git stash && git pull --prune && git stash pop;     sleep 1;     git add -A && git commit -m "feat: updates for $(echo date)";     git push; }
_pull_dot_files(){     if [[ ! -d $DOT_DIR ]];     then         git clone git@github.com:Sanix-Darker/dotfiles.git ~/;     else         cd $DOT_DIR;         git pull;     fi; }
docker ps
docker images
docker run -it ubuntu:latest bash
clean_docker_container 
docker run -it ubuntu:latest bash
clean_docker_container 
docker run -it ubuntu:latest bash
clean_docker_container 
docker run -it ubuntu:latest bash
clean_docker_container 
docker run -it ubuntu:latest bash
cd -
cd ACTUALC/github/s2c 
v
ctags .
ctags
ctags s2c/client.py 
ctags -R --languages=python --exclude=.git s2c/client.py 
ctags -R --languages=python --exclude=.git s2c/.
ctags -R --languages=python --exclude=.git .
ctags --help
ctags --help | grep help
nv ~/.config/nvim/init.vim 
v
nv ~/.config/nvim/init.vim 
v
v .
nv ~/.config/nvim/init.vim 
nvim .
nv ~/.config/nvim/init.vim 
nv .
nv ~/.config/nvim/init.vim 
v
nv .
_push_dot_files 
cd
nv ~/.bash_aliases 
docker ps
docker run -it 80e4794757af bash
clean_docker_container 
docker run -it ubuntu:latest bash
glances
glances --help
glances --light
glances --enable-light
glances --browser
glances --server
cd ACTUALC/
cd github/osscameroon/yotas 
v
htop
cd ..
cd je
cd jeveu/
v
cd backend/
cd api/
v
ls
v
cd
nv ~/.config/nvim/init.vim 
cd ACTUALC/github/s2c 
v
cd
nv ~/.vimrc 
cd ~/.vim/
ls
md bundle
git clone https://github.com/ycm-core/YouCompleteMe
cd YouCompleteMe/
python3 install.py --all
cd third_party/ycmd/
ls
cd ..
rf YouCompleteMe/
cd ../
cd
sleep 2;alert
type alert
nv ~/.config/nvim/init.vim 
cd backend/
git log -p 
cd ACTUALC/github/osscameroon/yotas 
git log -p
cat ~/.gitignore
cat ~/.gitconfig 
git log -p
ll
diff LICENSE README.md 
delta LICENSE README.md 
cd
nv ~/.bash_aliases 
htop
ping www.google.com
ee
cat Makefile 
python
./blc_venv/bin/python3 -m blc --help
./blc_venv/bin/python3 -m blc https://example.com
./blc_venv/bin/python3 -m blc https://osscameroon.com
ll
rf blog.osscameroon.com_report.json 
ll
git status
rf dd.py 
git status
git add -A
git commit -m "feat: refacto and use requests_html instead of the simple request for JS rendering websites"
git push
vim --version
/usr/bin/vim --version
/usr/bin/vi --version
_push_dot_files 
git clone https://github.com/simnalamburt/vim-mundo.git     ~/.vim/bundle/mundo
git status
de
_push_dot_files 
cd
tree
tree -L 2
cd ~/.vim/
tree
tree -L2
tree -L 2
tree -L 1
tree -L 2 -I undo
tree -L 3 -I undo
tree -L 2 -I undo
cd
_push_dot_files 
cd
cd ACTUALC/github/broken_link_checker 
./blc_venv/bin/python3 -m blc http://example.com
_push_dot_files 
cd
_push_dot_files 
source ~/.bash_aliases 
cd
_push_dot_files 
cd -
git status
cd
source ~/.bash_aliases 
_push_dot_files 
cd -
v
cd
source ~/.bash_aliases 
_push_dot_files 
source ~/.bash_aliases 
_push_dot_files 
ll -al
cd
source ~/.bash_aliases 
_push_dot_files 
cd -
cat .vimrc 
cd -
htop
ls
git status
git diff
exit
python
git status
git diff
git status
git restore laputa/api/
git status
exit
git status
tree -L 1
glances
nv ~/.vimrc 
v
cd ACTUALC/
cd github/s2c 
v
_push_dot_files 
nv ~/.bash_aliases 
source ~/.bash_aliases 
_push_dot_files 
cd
cd ACTUALC/github/broken_link_checker 
git status
gitstash
git stash
git status
git reset
git status
git checkout
git status
git branch
git checkout v2
git status
rf example.com_*
rf osscameroon.co*
git status
ll
v
ee
v
./blc_venv/bin/pip3 install jedi
v
sudo apt-get update && sudo apt-get install -y exuberant-ctags
nv ~/.vimrc 
nv
nv ~/.vimrc 
v
cd
de
cd ACTUALC/toucantoco/weaverbird 
v
cd -
cd ACTUALC/github/broken_link_checker 
v
ee
v
de
nv ~/.config/nvim/init.vim 
nv ~/.vimrc 
ee
v
de
cd
cd ACTUALC/
cd toucantoco/laputa 
ee
v
de
nv ~/.vimrc
v
ee
nv .
v
ee
v
