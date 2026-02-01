#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ] ; then
echo "please run installation commands as a root user"
exit 1
fi

echo "Installing Nginx"
dnf installl nginx -y

if [ $? -ne 0 ] ; then
 echo "Installation of Nginx...Failure"
 else
 echo "Installation of Nginx...Success"
 fi

 echo "Installing mysql"
 dnf install mysql -y

 if [ $? -ne 0 ] ; then
 echo "Installation of mysql ...Failure"
 else
 echo "Installation of mysql ....Success"
 fi

 echo "installing nodejs"
 dnf install nodejs -y

 if [ $? -ne 0 ] ; then
 echo "installation of nodejs ...Failure"
 else
 echo "installation of nodejs...success"
 fi