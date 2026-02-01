#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ] ; then
echo "please run installation command with Root User"
exit 1
fi

VALIDATE()
 {
    if [ $1 -ne 0 ] ; then
    echo "$2 .. installation has failed"
    exit 1
    else
    echo "$2..installation is successful"
    fi

}

dnf install nginx -y
VALIDATE $? "Nginx"

dnf install mysql -y
VALIDATE $? "MySql"

dnf install nodejs -y
VALIDATE $? "installating nodejs"
