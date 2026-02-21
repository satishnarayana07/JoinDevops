#!/bin/bash
START_TIME=$(date +%s)
USERID=$(id -u)
LOGS_FOLDER="/var/log/logs/"
SCRIPT_NAME=$(echo $0|cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
MONGODB_HOST=mongodb.sandarshantv.online
SCRIPT_DIR=$PWD
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m" 
N="\e[0m"

mkdir -p $LOGS_FOLDER
echo "Script strated at $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ] ; then
echo -e " $R ERROR: $Y please run as Root user..like using $G 'sudo' $N"
exit 1
fi

VALIDATE()
{
if [ $1 -ne 0 ] ; then
echo -e " $2 $R not installed " |tee -a $LOGS_FILE
else
echo -e "$2 is $G successfully installed"  | tee -a $LOGS_FILE
fi
}
###### catalogue.sh #################

dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "Disbale node js"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "Enable nodejs"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "Install nodejs"

id roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
VALIDATE $? "Add user"
else
echo -e "user already exists..$Y SKIPPING $N"| tee -a $LOG_FILE
fi

mkdir /app 
VALIDATE $? "create /app"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
VALIDATE $? "Downloaded code"

cd /app 
VALIDATE $? "Move to /app"

rm -rf /app/* $>>$LOG_FILE
VALIDATE $? "Remove old code"

unzip /tmp/catalogue.zip &>>$LOG_FILE
VALIDATE $? "unzip the code"

cd /app 
VALIDATE $? "Changed Directory"

npm install &>>$LOG_FILE
VALIDATE $? "install Dependencies"

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
VALIDATE $? "created systemctl service"

systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "Reload Files"

systemctl enable catalogue &>>$LOG_FILE
VALIDATE $? "enabling catalogue"

systemctl start catalogue &>>$LOG_FILE
VALIDATE $? "Catalouge Started"

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "Copy mongo.repo"

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "Install mongodb client"

INDEX=$(mongosh mongodb.sandarshantv.online --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')")
if [ $INDEX -le 0 ]; then
mongosh --host $MONGODB_HOST </app/db/master-data.js &>>$LOG_FILE
VALIDATE $? "Load Products"
else
echo -e "Products already exist..$Y SKIPPING $N"
fi

systemctl restart catalogue
VALIDATE $? "Restart catalogue"

END_TIME=$(date +%s)
TOTAL_TIME=$(($END_TIME-$START_TIME))
echo -e "Script executed in: $Y $TOTAL_TIME Seconds $N"














