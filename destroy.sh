#!/bin/bash

source ./build-config.sh

docker-compose down

[ -d $FE_PATH ] && rm -rf $FE_PATH
[ -d $BE_PATH ] && rm -rf $BE_PATH