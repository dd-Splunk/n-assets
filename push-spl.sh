#!/bin/bash
APP=${PWD##*/} 
APP_FILE=${APP}.spl
APP_LOCATION=/tmp/${APP_FILE}
source .env
git add *
git commit -m "latest push"
git archive -v --format=tar --prefix=$APP/ -o  $APP_FILE main
echo "Uploading ${APP_FILE} ..."
docker cp $APP_FILE so1:$APP_LOCATION
echo "Asking Splunk to install ${APP_FILE} ..."
curl -X POST -k -u admin:$SPLUNK_PASSWORD https://$SPLUNK_HOST:8089/services/apps/local \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -d "name=${APP_LOCATION}&update=True&filename=True"
echo "Done."
#