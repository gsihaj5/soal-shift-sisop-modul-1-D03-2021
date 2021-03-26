#!/bin/bash

errorFile="error_message.csv"
userFile="user_statistic.csv"

echo ERROR,Count >"$errorFile"
echo Username,INFO,ERROR >"$userFile"

messages=()
messageCount=(0 0 0 0 0 0 0 0 0 0)

getErrorMessage() {
    index=0
    result=""

    # shellcheck disable=SC2068
    for i in $@; do
        index=$(($index + 1))
        if [ $index -ge 8 ] && [ $index -le $1 ]; then
            result="${result} ${i}"
        fi
    done
}

appendAndCount() {
    udahAda=0
    index=0

    for message in "${messages[@]}"; do
        if [ "${message}" = "${result}" ]; then
            udahAda=1
            break
        fi
        index=$(($index + 1))
    done

    if [ $udahAda -eq 0 ]; then
        messages+=("${result}")
    fi

    messageCount[index]=$((${messageCount[index]} + 1))
}

grep ERROR ~/Documents/ITS/sisop/seslab1/_soalShift/soal1/syslog.log | while read line; do
    count=$(echo "$line" | wc -w)

    getErrorMessage $count "$line"
    appendAndCount

    #write
    index=0
    for message in "${messages[@]}"; do
        printf "${message}, ${messageCount[index]}\n" >>"$errorFile"
        index=$(($index + 1))
    done
done

sed -i $errorFile -re '2,362d'

echo 'x' | ex -s -c '2,$!sort -t"," -r -n -k2 -k1' $errorFile

names=()
errorCount=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
infoCount=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)

appendNameAndCount() {
    udahAda=0
    index=0

    for item in "${names[@]}"; do
        if [ "${item}" = "${1}" ]; then
            udahAda=1
            break
        fi
        index=$(($index + 1))
    done

    if [ $udahAda -eq 0 ]; then
        names+=("${1}")
    fi

    if [ "${2}" = "ERROR" ]; then
        errorCount[index]=$((${errorCount[index]} + 1))
    elif [ "${2}" = "INFO" ]; then
        infoCount[index]=$((${infoCount[index]} + 1))
    fi
}

getUsername() {
    index=0
    name=""
    for i in $@; do
        index=$(($index + 1))
        if [ $index -gt $1 ]; then
            name="${i}"
        fi

        if [ $index -gt 6 ] && [ $index -le 7 ]; then
            type=$i
        fi
    done
}

cat ~/Documents/ITS/sisop/seslab1/_soalShift/soal1/syslog.log | while read line; do
    count=$(echo "$line" | wc -w)

    getUsername $count "$line"
    appendNameAndCount ${name##*( \(\)} $type

    index=0
    printf "=========================================\n" >>"$userFile"
    for item in "${names[@]}"; do
        printf "${item}, ${infoCount[index]}, ${errorCount[index]}\n" >>"$userFile"
        index=$(($index + 1))
    done
done

sed -i $userFile -re '2,1749d'
echo 'x' | ex -s -c '2,$!sort' $userFile
