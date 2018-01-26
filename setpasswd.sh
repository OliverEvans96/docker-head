#!/bin/bash

# From https://unix.stackexchange.com/a/232083
# Read password from stdin securely

unset -v password # make sure it's not exported
set +a            # make sure variables are not automatically exported

printf "Password: "
IFS= read -rs password < /dev/tty &&
    echo "$password" | openssl passwd -1 -stdin > passwd.txt
password=""

# Without IFS=, read would strip leading and trailing blanks from the password you type.
# 
# Without -r, it would process backslashes as a quoting character.
# 
# You want to make sure you only ever read from the terminal.
# 
# echo can't be used reliably. In bash, printf is builtin so that command line wouldn't show in the output of ps.
# 
# You need to quote $password as otherwise the split+glob operator is applied to it.
