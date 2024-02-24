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

yum install nginx -y &>>$LOG_FILE

VALIDATE $? "Installinng nginx"

systemctl enable nginx &>>$LOG_FILE

VALIDATE $? "enable nginx"

systemctl start nginx &>>$LOG_FILE

VALIDATE $? "start nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE

VALIDATE $? "removing  default html"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>>$LOG_FILE

VALIDATE $? "copying web"

cd /usr/share/nginx/html &>>$LOG_FILE

VALIDATE $? "changing directory"

unzip /tmp/web.zip &>>$LOG_FILE

VALIDATE $? "unzip web"

cp /root/shell/roboshell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE

VALIDATE $? "copying roboshop"

systemctl restart nginx &>>$LOG_FILE

VALIDATE $? "restarting nginx"





