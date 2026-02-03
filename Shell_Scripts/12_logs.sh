#!/bin/bash
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-scripts"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID -ne 0 ] ; then
echo "please run command with Root User"
exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE()
{

if [ $1 -ne 0 ] ; then
echo "$2.. installation has failed" | tee -a $LOGS_FILE
else
echo "$2.. Success" | tee -a $LOGS_FILE
fi
}

dnf install nginx -y & >> $LOGS_FILE
VALIDATE $? "Nginx"

dnf install mysql -y & >> $LOGS_FILE
VALIDATE $? "MySql"

dnf install nodejs -y & >> $LOGS_FILE
VALIDATE $? "nodejs"
