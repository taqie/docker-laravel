#!/bin/bash

docker build -t taqie/laravel:latest .
docker push taqie/laravel
