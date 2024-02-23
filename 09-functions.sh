VALIDATE(){
if [ $1 -ne 0 ]
    then
        echo "installation is failure"
        exit 1
    else
        echo "installation is success"
fi
}
USER=$(id -u)

if [ $USER -ne 0 ]
then
    echo "logged in user is not root user"
    exit 1
fi

yum install git -y

VALIDATE $?

yum install postfix -y

VALIDATE $?