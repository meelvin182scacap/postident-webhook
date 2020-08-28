#!/bin/bash

CONFIG=${1?"Expected 1st argument CONFIG"}
ENVIRONMENT_NAME=${2?"Expected 2st argument ENVIRONMENT_NAME"}
cd `dirname $0`
docker run -p 1080:80 -e CONFIG=$CONFIG -e ENVIRONMENT_NAME=$ENVIRONMENT_NAME front:local
