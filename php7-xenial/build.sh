#!/usr/bin/env bash

docker build --pull -t revenuewire/php-app:7-xenial .
docker push revenuewire/php-app:7-xenial