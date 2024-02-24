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
        echo "logged in user is not root user"
        exit 1
fi

yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$LOG_FILE

VALIDATE $? "installing redis"

yum module enable redis:remi-6.2 -y &>>$LOG_FILE

VALIDATE $? "enable redis" 

yum install redis -y &>>$LOG_FILE

VALIDATE $? "Installing redis" 

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/redis.conf /etc/redis/redis.conf &>>$LOG_FILE

VALIDATE $? "configuring redis" 

systemctl enable redis &>>$LOG_FILE

VALIDATE $? "enable redis" 

systemctl start redis &>>$LOG_FILE

VALIDATE $? "start redis" 