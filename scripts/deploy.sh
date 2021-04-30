#!/usr/bin/env bash

mvn clean package

echo "Copy files..."

scp -i ~/.ssh/id_rsa \
    target/portal-1.0-SNAPSHOT.jar \
    upolyakov@192.168.0.51:/home/upolyakov/

echo "Restart server..."

ssh -i ~/.ssh/id_rsa upolyakov@192.168.0.51 << EOF

pidof java portal-1.0-SNAPSHOT.jar | xargs kill -9
nohup java -jar portal-1.0-SNAPSHOT.jar > log.txt &

EOF

echo "By...."