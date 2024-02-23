DATE=$(date %F)
FILE_NAME=$0
LOG_FILE=/tmp/$FILE_NAME-$DATE.log
VALIDATE(){
if [ $1 -ne 0 ]
    then
        echo -e "$2 is $RED failure $NC"
        exit 1
    else
        echo -e "$2 is $GREEN success $NC"
fi
}

RED="\e[31m"
GREEN="\e[32m"
NC="\e[0m"
USER=$(id -u)

if [ $USER -ne 0 ]
then
    echo "logged in user is not root user"
    exit 1
fi

yum install git -y &>>$LOG_FILE

VALIDATE $? "Installing ... GIT"

yum install postdffix -y &>>$LOG_FILE

VALIDATE $? "Installing ... Postfix"