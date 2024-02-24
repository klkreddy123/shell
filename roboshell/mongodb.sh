DATE=$(date %+F)
RED="\e[31m"
GREEN="\e[32m"
NOCOLOR="\e[0m"
SCRIPT_NAME=$0
LOG_FILES=/tmp/$SCRIPT_NAME-$DATE.log
USER= $(id -u)





yum install mongodb-org -y