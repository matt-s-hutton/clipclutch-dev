#!/bin/bash
docker-compose build

source ~/.bash_profile
source ./build-config.sh

[ ! -d $FE_PATH ] && mkdir $FE_PATH
[ ! -d $BE_PATH ] && mkdir $BE_PATH

pushd $CLIPCLUTCH_PATH

ng build --output-path $FE_PATH

popd

cp $CLIPCLUTCH_SERV_PATH $BE_PATH
cp $CLIPCLUTCH_SERV_CONF_PATH $BE_PATH
cp -r $CLIPCLUTCH_SERV_LIB_PATH $BE_PATH

NGINX_VOLUME_PATH=$FE_PATH docker-compose -f docker-compose.yml up -d
