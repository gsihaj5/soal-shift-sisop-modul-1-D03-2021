# soal-shift-sisop-modul-1-D03-2020

# LAPORAN PENGERJAAN SOAL SHIFT

# ============== NO 1 ===============

## PENYELESAIAN

```bash
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

```

## DESKRIPSI

### soal a

Dari Soal nomor 1 Penyelesaian dimulai dari yang problem yang paling dasar yaitu membaca setiap line dari syslog.log

### soal b

penyelesaian dari poin (b) dilakukan dengan cara mencari semua line yang mengandung kata ERROR menggunakan fungsi grep.

dari pola setiap line, data dari message bisa di dapat dengan mengambil karakter ke 8 sampai dengan (jumlah katata -1)

kemudian dari setiap pesan yang didapat di lakukan check apakah sudah di push ke dalam array, jika belum maka tinggal di
tambahkan

jika ada pesan yang sama maka counter dari setiap pesan di tambahkan

### soal d

kemudian yang dilakukan selanjutnya adalah me-append info yang di dapat ke file error_message.csv

dari file csv hal selanjutya yang dilakukan adalah membersihkan line yang tidak perlu dan sorting berdasarkan kolom ke 2

### soal c

di soal c yang dilakukan adalah iterasi ke semua line syslog dengan command cat

dari tiap line nya diambil nama dan tipe dari log nya "ERROR" / "INFO"

proses nya sama seperti poin B melakukan check pada tiap nama dan append jika tidak ada, jika ada menambah counter "
ERROR" / "INFO"

### soal e

melakukan append dari data yang diperoleh kemudian membersihkan line yang tidak perlu.

kemudian melakukan sorting

### KENDALA DAN KESULITAN

1. tidak terbiasa dengan syntax yang aneh apalagi menggunakan regex
1. masih belum terbiasa dengan kemampuan dari tiap command
1. masih kurang paham tentang scope yang ada di dalam shell
1. di soal pin yang e timbul behaviour aneh dari command yang dijalankan, sepertinya trailing whitespace tapi jika
   dilakukan cat command yang keluar adalah sbb

   (./keanehan_command.png "This is a sample image.")
