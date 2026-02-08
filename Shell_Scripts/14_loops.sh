#!/bin/bash
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-scripts"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID -ne 0 ] ; then
echo "plase run this command with Root user"
exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE ()
{
    if [ $1 -ne 0 ] ; then
    echo "$2...installation has failed" |tee -a $LOGS_FILE
    else 
    echo "$2...installation is successful" |tee -a $LOGS_FILE
    fi
 }

    for package in $@
    do
    dnf install $package -y & >> $LOGS_FILE
    VALIDATE $? "$package"
    done

