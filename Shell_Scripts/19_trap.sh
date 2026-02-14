#!/bin/bash
set -e

trap 'echo "there is error in $LINENO, command: $BASH_COMMAND"' ERR

echo "hello world"
echo "I am learning shell"
echoo "printing error here"
echo "no error int this"