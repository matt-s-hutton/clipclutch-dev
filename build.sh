#!/bin/bash
source ~/.bash_profile
source ./build-config.sh

touch .env
echo "NGINX_VOLUME_PATH=$FE_PATH" >> .env
echo "API_VOLUME_PATH=$BE_PATH" >> .env
echo "API_CONTAINER_NAME=$CLIPCLUTCH_SERV_CONTAINER_NAME" >> .env
echo "API_DOCKERFILE_NAME=$CLIPCLUTCH_SERV_DOCKERFILE_NAME" >> .env

docker-compose build

[ ! -d $FE_PATH ] && mkdir $FE_PATH
[ ! -d $BE_PATH ] && mkdir $BE_PATH

pushd $CLIPCLUTCH_PATH

ng build --output-path $FE_PATH

popd

cp -r $CLIPCLUTCH_SERV_PATH $BE_PATH
cp -r $CLIPCLUTCH_SERV_LIB_PATH $BE_PATH

docker-compose -f docker-compose.yml up -d

rm .env