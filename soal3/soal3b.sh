#!/bin/bash

TGL_NOW="$(date +"%d-%m-%Y")"
mkdir "$TGL_NOW"
cd "$TGL_NOW"

{

for ((i=1; i<24; i=i+1))
do
    if [ $i -lt 10 ]
    then
        wget -c https://loremflickr.com/320/240/kitten -O Koleksi_0$i -P /
    else
        wget -c https://loremflickr.com/320/240/kitten -O Koleksi_$i
    fi
done

declare -A filecksums

test 0 -eq $# && set -- *

for file in "$@"
do
    [[ -f "$file" ]] && [[ ! -h "$file" ]] || continue

    cksum=$(cksum <"$file" | tr ' ' _)

    if [[ -n "${filecksums[$cksum]}" ]] && [[ "${filecksums[$cksum]}" != "$file" ]]
    then
        echo "Found '$file' is a duplicate of '${filecksums[$cksum]}'" >&2
        rm -f "$file"
    else
        filecksums[$cksum]="$file"
    fi
done
} 2>Foto.log
