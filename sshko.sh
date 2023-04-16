#!/bin/bash

logFile=~/.sshLog.txt
#logFile=./file.txt

if [[ ! -e ${logFile} ]]; then
    touch ${logFile}
fi

if [ "$1" == "" ] || [ $# -gt 1 ]; then
    if ! [ -s ${logFile} ]; then
        echo "ssh log file is empty"
        exit
    fi

    HEIGHT=20
    WIDTH=40
    CHOICE_HEIGHT=9
    BACKTITLE="This is made, because you are super lazy!!!!"
    TITLE="SSHko"
    MENU="Choose one of the following ssh connections:"

    arr=()
    val=()
    key=0
    while IFS= read -r line || [[ "$line" ]]; do
        arr+=($key "$line")
        val+=("$line")
        ((key = key + 1))
    done <${logFile}

    for key in "${!arr[@]}"; do
        echo ${arr[$key]}
    done

    echo ${#arr[@]}

    CHOICE=$(dialog --clear --title "$TITLE" --backtitle "$BACKTITLE"\
        --menu "$MENU" $HEIGHT $WIDTH $CHOICE_HEIGHT "${arr[@]}" \
        2>&1 >/dev/tty)
    clear
    if [[ ! $CHOICE == "" ]]; then
        sshHost=${val[$CHOICE]}
        echo "$CHOICE You chose ${sshHost}"
        ssh ${sshHost}
        exit
    fi
else
    sshHost=$1
    # echo ${sshHost} >> ${logFile}
    if ! grep -Fxq "$sshHost" ${logFile}; then
        echo ${sshHost} >>${logFile}
    fi

    ssh ${sshHost}
    exit
fi
