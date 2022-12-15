#!/bin/bash

logFile=~/.sshLog.txt
#logFile=./file.txt

if [[ ! -e ${logFile} ]]; then
    touch ${logFile}
fi

if [ "$1" == "" ] || [ $# -gt 1 ]; 
then
    if ! [ -s ${logFile} ];then
        echo "ssh log file is empty"
        exit
    fi
    
    HEIGHT=20
    WIDTH=40
    CHOICE_HEIGHT=9
    BACKTITLE="This is made, because you are super lazy!!!!"
    TITLE="SSHko"
    MENU="Choose one of the following ssh connections:"

    readarray rows < ${logFile}
    #rows2=$(nl ${logFile})

    choices=();
    for key in "${!rows[@]}";
    do
        #choices+=($($key+1) "${rows[$key]}");
        choices+=($key "${rows[$key]}");
    done;

    CHOICE=$(whiptail --clear \
                    --backtitle "$BACKTITLE" \
                    --title "$TITLE" \
                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    -- "${choices[@]}"   \
                    2>&1 >/dev/tty)

    clear
    if [[ ! $CHOICE == "" ]]
    then
        sshHost=${rows[$CHOICE]}
        echo "$CHOICE You chose ${sshHost}"
        ssh ${sshHost}
            #ssh ${sshHost}
    fi
else
    sshHost=$1;
    # echo ${sshHost} >> ${logFile}
    if ! grep -Fxq "$sshHost" ${logFile}
    then
        echo ${sshHost} >> ${logFile}
    fi

    ssh ${sshHost}
fi
