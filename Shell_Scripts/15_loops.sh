#!/bin/bash
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell_logs/"
LOGS_FILE="$LOGS_FOLDER/$0.log"

#1.Root use check
if [ $USERID -ne 0 ] ; then
echo "ERROR: please run this command with Root User ..like using 'sudo'"
exit 1
fi

#2.Creae Log Directory
mkdir -p $LOGS_FOLDER

VALIDATE(){
if [ $1 -ne 0 ] ; then
echo "$2 not installed " |tee -a $LOGS_FILE
else
echo "$2 is successfully installed"  | tee -a $LOGS_FILE
fi
}

#loop through arguments
for package in "$@ "
do
dnf list installed "$package" &>>$LOGS_FILE
if [ $? -ne 0 ] ; then
echo "$package not installed..installing now" 
dnf install $package -y &>>$LOGS_FILE
VALIDATE $? "installation of $package"
else
echo "$package is already installed" | tee -a $LOGS_FILE
fi
done 


