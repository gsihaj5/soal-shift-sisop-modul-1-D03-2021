#!/bin/bash

errorFile=error_message.csv
userFile=user_statistic.csv

echo ERROR,Count > errorFile;
echo Username,INFO,ERROR > userFile

getErrorMessage(){
    index=0
    result="";
    for i in $@
    do
        index=$(($index+1));
        if [ $index -ge 8 ] && [ $index -le $1 ]
        then
            result="${result} ${i}"
        fi
    done
}

grep ERROR ~/Documents/ITS/sisop/seslab1/_soalShift/soal1/syslog.log | while read line
do
    count=`echo "$line" | wc -w`

    getErrorMessage $count "$line" 
    echo $result
done