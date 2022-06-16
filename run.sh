#!/bin/sh

echo '--- create docker image and up it'
docker-compose up -d --build

echo '--- run yarn install'
docker-compose run app yarn --cwd public/

echo '--- update cronjob'
docker-compose run app whenever -w