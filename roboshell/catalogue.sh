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

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>>$LOG_FILE 

VALIDATE $? "downloading catalogue"

cd /app &>>$LOG_FILE

VALIDATE $? "changing directory"

unzip /tmp/catalogue.zip &>>$LOG_FILE

VALIDATE $? "unxipping catalogue"

npm install &>>$LOG_FILE

VALIDATE $? "npm installing"

cp /root/shell/roboshell/catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE

VALIDATE $? "copying catalogue service"

systemctl daemon-reload &>>$LOG_FILE

VALIDATE $? "daemon reload"

systemctl enable catalogue &>>$LOG_FILE

VALIDATE $? "enable catalogue"

systemctl start catalogue &>>$LOG_FILE

VALIDATE $? "start catalogue"

cp /root/shell/roboshell/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE

VALIDATE $? "copy mongo repo"

yum install mongodb-org-shell -y &>>$LOG_FILE

VALIDATE $? "installing mongodb"
