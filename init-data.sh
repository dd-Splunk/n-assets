#!/bin/bash
DATA_DIR=data
INDEX=vpn
SOURCETYPE=cisco:asa
source .env
for f in `find $DATA_DIR/* -type f -exec basename {} \;`
do
    echo "Uploading $f ..."
    docker cp $DATA_DIR/$f so1:/tmp
    echo "Setting permissions"
    docker exec -u 0 -it so1 chown splunk:splunk /tmp/$f
    echo "Splunk oneShot $f"
    curl  -X POST -k -u admin:$SPLUNK_PASSWORD https://$SPLUNK_HOST:8089/services/data/inputs/oneshot \
        -d "name=/tmp/$f"
done

# echo "Asking Splunk to install ${APP_FILE} ..."
# curl -s -X POST -k -u admin:$SPLUNK_PASSWORD https://$SPLUNK_HOST:8089/services/apps/local \
#     -H 'Content-Type: application/x-www-form-urlencoded' \
#     -d "name=${APP_LOCATION}&update=True&filename=True"
# echo "Restaritng"
# curl -s -X POST -k -u admin:$SPLUNK_PASSWORD https://$SPLUNK_HOST:8089/services/server/control/restart 
# echo "Done."
#