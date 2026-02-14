#!/bin/bash
set -e

trap 'echo "there is error in $LINENO, command: $BASH_COMMAND"' ERR

USERID=$(id -u)
LOGS_FOLDER="/var/log/logs/"
LOGS_FILE="$LOGS_FOLDER/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m" 
N="\e[0m"

if [ $USERID -ne 0 ] ; then
echo -e " $R ERROR: $Y please run as Root user..like using $G 'sudo' $N"
exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
if [ $1 -ne 0 ] ; then
echo -e " $2 $R not installed " |tee -a $LOGS_FILE
else
echo -e "$2 is $G successfully installed"  | tee -a $LOGS_FILE
fi
}


for package in "$@"; do
echo "checking for $package.." |tee -a $LOGS_FILE

if rpm -q "$package" &>>$LOGS_FILE; then
echo -e "Required software $package has already available "| tee -a $LOGS_FILE
else
echo "installing $package now.."|tee -a $LOGS_FILE
dnf install "$package" -y &>>$LOGS_FILE
VALIDATE $? $package
fi
done

echo "script completed $(date)"|tee -a $LOGS_FILE