#!/bin/bash
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell_logs/"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID -ne 0 ] ; then
echo "please run this command with Root User"
exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
if [ $1 -ne 0 ] ; then
echo "$2 not installed " |tee -a $LOGS_FILE
else
echo "$2 is successfully installed"  | tee -a $LOGS_FILE
fi
}


for package in $@ 
do
dnf list installed $package &>>$LOGS_FILE
if [ $? -ne 0 ] ; then
echo "$package not installed..installing now" 
dnf install $package -y & >> $LOGS_FILE
VALIDATE $? "$package"
else
echo "$package is already installed"
fi
done 


