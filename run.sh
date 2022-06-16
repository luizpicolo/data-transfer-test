#!/bin/sh

echo '--- run yarn install'
yarn --cwd public/

echo '--- run bundle install'
bundle install

echo '--- create docker image and up it'
docker-compose up -d --build

echo '--- update cronjob'
docker-compose run app whenever -w