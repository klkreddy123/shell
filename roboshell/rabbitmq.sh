#!/bin/bash

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 application is $RED failure $NOCOLOR"
    else
        echo -e "$2 application is $GREEN success $NOCOLOR"
fi

}

DATE=$(date +%F)
RED="\e[31m"
GREEN="\e[32m"
NOCOLOR="\e[0m"
SCRIPT_NAME=$0
LOG_FILE=/tmp/$SCRIPT_NAME-$DATE.log
USER=$(id -u)
if [ $USER -ne 0 ]
    then
        echo "logged in users is not root user"
        exit 1
fi

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

yum install rabbitmq-server -y 

systemctl enable rabbitmq-server 

systemctl start rabbitmq-server 

rabbitmqctl add_user roboshop roboshop123

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

