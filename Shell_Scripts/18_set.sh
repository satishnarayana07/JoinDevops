#!/bin/bash 

set -e #this will be used to exit the script if any error found

#!/bin/bash 

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


for package in $@
do
dnf list installed $package 2>&1 | tee -a $LOGS_FILE
if [ $? -ne 0 ] ; then
echo -e " $Y $package $R not installed..$B installing now buddy $N"
dnf install $package -y &>>$LOGS_FILE
VALIDATE $? $package 
else
echo -e "Required software $package has already $G available $N"
fi
done
