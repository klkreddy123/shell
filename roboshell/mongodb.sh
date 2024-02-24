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
USER= $(id -u)
if [ $USER -ne 0 ]
    then
        echo "logged in users is not root user"
        exit 1
fi


yum install mongodb-org -y &>> $LOG_FILE 

VALIDATE $? "Installing mongodb" 

systemctl enable mongod &>> $LOG_FILE 

VALIDATE $? "Enabling mongodb" 

systemctl start mongod &>> $LOG_FILE

VALIDATE $? "start mongodb"

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf &>> $LOG_FILE 

VALIDATE $? "Edit mongod conf"

systemctl restart mongod &>> $LOG_FILE 

VALIDATE $? "restart mongod"


