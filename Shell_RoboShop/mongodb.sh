#!/bin/bash
START_TIME=$(date +%s)
USERID=$(id -u)
LOGS_FOLDER="/var/log/logs/"
SCRIPT_NAME=$(echo $0|cut -d "." -f1)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

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

##### Mongo DB #####

cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOGS_FILE
VALIDATE $? "copying mongo.repo"

dnf install mongodb-org -y &>>$LOGS_FILE
VALIDATE $? "Mongodb Repository"

systemctl enable mongod &>>$LOGS_FILE
VALIDATE $? "Mongodb enabled"

systemctl start mongod &>>$LOGS_FILE
VALIDATE $? "Mongodb started"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>$LOGS_FILE
VALIDATE $? "allowing remote connections"

systemctl restart mongod &>>$LOGS_FILE
VALIDATE $? "Restarted MongoDB"

END_TIME=$(date +s)
TOTAL_TIME=$(($END_TIME-$START_TIME))
echo -e "script executed in: $Y $TOTAL_TIME seconds $N"
