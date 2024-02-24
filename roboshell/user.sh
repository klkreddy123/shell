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


curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE

VALIDATE $? "Installing NodeJS repos"

yum install nodejs -y &>>$LOG_FILE

VALIDATE $? "Installing NodeJS" 

useradd roboshop &>>$LOG_FILE

VALIDATE $? "Adding user"

mkdir /app &>>$LOG_FILE

VALIDATE $? "creating directory"

curl -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>>$LOG_FILE 

VALIDATE $? "downloading user"

cd /app &>>$LOG_FILE

VALIDATE $? "changing directory"

unzip /tmp/user.zip &>>$LOG_FILE

VALIDATE $? "unxipping user"

npm install &>>$LOG_FILE

VALIDATE $? "npm installing"

cp /root/shell/roboshell/user.service /etc/systemd/system/user.service &>>$LOG_FILE

VALIDATE $? "copying user service"

systemctl daemon-reload &>>$LOG_FILE

VALIDATE $? "daemon reload"

systemctl enable user &>>$LOG_FILE

VALIDATE $? "enable user"

systemctl start user &>>$LOG_FILE

VALIDATE $? "start user"

cp /root/shell/roboshell/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE

VALIDATE $? "copy mongo repo"

yum install mongodb-org-shell -y &>>$LOG_FILE

VALIDATE $? "installing mongodb"

mongo --host mongodb.kautomation.online </app/schema/catalogue.js

VALIDATE $? "loading mongodb schema"