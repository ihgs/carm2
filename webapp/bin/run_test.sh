#!/bin/bash
cd `dirname $0`
export DOCKER_HOST_IP=$(docker-machine ip)
./rake test
