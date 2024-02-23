VALIDATE(){
if [ $1 -ne 0 ]
    then
        echo "$2 is failure"
        exit 1
    else
        echo "$2 is success"
fi
}
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