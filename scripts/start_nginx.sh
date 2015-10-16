#!/usr/bin/env bash

# export HTML=/Users/booyaa/Dropbox/Coding/docker/ProfessorOwl/dockerfiles/nginx/usr/share/nginx/html/bar.html
# export CONF=/Users/booyaa/Dropbox/Coding/docker/ProfessorOwl/dockerfiles/nginx/etc/nginx/conf.d
# docker run --rm -v $CONF:/etc/nginx/conf.d -v $HTML:/usr/share/nginx/html/index.html -p 80:80 nginx
docker run --rm -p 80:80 prowl_web
