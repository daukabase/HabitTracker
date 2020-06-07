
# Pre-requisites
* Docker running on the host machine.
* Docker compose running on the host machine.

# usage:
+ `docker-compose up -d` to start all containers
+ `docker-compose down` to stop all containers
+ If you need to restart after modifying *docker-compose.yml* restart with `docker-compose down` and `docker-compose up -d`

# Images
+ postgres:9.5-alpine
+ nginx:alpine
+ php71-fpm:latest

# DiplomaProject
+ docker-compose run --rm --no-deps genealogy-server php artisan cache:clear
+ docker-compose run --rm --no-deps genealogy-server chmod -R 777 storage/
+ docker-compose run --rm --no-deps genealogy-server composer dump-autoload
