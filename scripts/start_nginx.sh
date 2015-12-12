#!/usr/bin/env bash
docker run --rm --name prowl_web -p 80:80 --log-driver=syslog --log-opt syslog-tag="nginx" prowl_web
