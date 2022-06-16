#!/bin/sh

echo '--- run yarn install'
yarn --cwd public/

echo '--- run bundle install'
bundle install

echo '--- create docker image and up it'
sudo docker-compose up -d --build