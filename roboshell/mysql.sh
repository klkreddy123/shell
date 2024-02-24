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

yum module disable mysql -y &>>$LOG_FILE

VALIDATE $? "disable module mysql"

cp /root/shell/roboshell/mysql.repo /etc/yum.repos.d/mysql.repo &>>$LOG_FILE

VALIDATE $? "copying mysql repo"

yum install mysql-community-server -y &>>$LOG_FILE

VALIDATE $? "installing mysql server"

systemctl enable mysqld &>>$LOG_FILE

VALIDATE $? "enable mysql server"

systemctl start mysqld &>>$LOG_FILE

VALIDATE $? "start mysql server" 

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE

VALIDATE $? "set mysql password" 


