#!/bin/bash
# readpasswd.sh
# To be used in docker setup script
if [ -e passwd.txt ]
then
    echo "Exists"
else
    echo "Doesn't exist"
fi
