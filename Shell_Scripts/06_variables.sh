#!/bin/bash
####  special Variables ###
echo "all args passed to the script: $@"
echo "number of variables passed to the script: $#"
echo "script name: $0"
echo "present working directory: $pwd"
echo " who is running script: $USER"
echo "home directory of current user: $HOME"
echo "PID of the script: $$"
sleep 100 &
echo "PID of the last background process: $!"
echo "all args passed: $*"