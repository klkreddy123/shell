VALIDATE(){
if [ $1 -ne 0 ]
    then
        echo "$2 is $RED failure $NC"
        exit 1
    else
        echo "$2 is $GREEN success $NC"
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

yum install git -y

VALIDATE $? "Installing ... GIT"

yum install postdffix -y

VALIDATE $? "Installing ... Postfix"