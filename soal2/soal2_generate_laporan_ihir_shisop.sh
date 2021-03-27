#!/bin/bash

#untuk 2a
awk -F '\t' 'NR>1 {costprice=$18-$21; profper=($21/costprice)*100; print $1, profper}' Laporan-TokoShiSop.tsv > datafull.txt
awk 'BEGIN {max=0;idne=0}{if($2>max) max=$2}{if($2==max) idne=$1} END {print "Transaksi terakhir dengan profit percentage terbesar yaitu ",idne," dengan persentase ", max}' datafull.txt >> hasil.txt

#untuk 2b
awk -F '\t' 'NR>1 {OFS="-"; print $1,$3,$7}' Laporan-TokoShiSop.tsv > data2b.txt
awk -F '-' 'BEGIN {print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain"} {if($4==17) print $5} END {print "----------------------\n"}' data2b.txt >> hasil.txt

#untuk 2c
awk -F '\t' 'NR>1 {if($8=="Consumer") print $1, $18}' Laporan-TokoShiSop.tsv > trydataconsumer.txt
awk -F '\t' 'NR>1 {if($8=="Corporate") print $1, $18}' Laporan-TokoShiSop.tsv > trydatacorporate.txt
awk -F '\t' 'NR>1 {if($8=="Home Office") print $1, $18}' Laporan-TokoShiSop.tsv > trydatahome.txt

awk '{sum+=$2} END {print "consumer ", sum}' trydataconsumer.txt >> trycekhasil.txt
awk '{sum+=$2} END {print "corporate ", sum}' trydatacorporate.txt >> trycekhasil.txt
awk '{sum+=$2} END {print "home ", sum}' trydatahome.txt >> trycekhasil.txt

awk 'BEGIN {min=9999999999; segment="sg"} {if($2<min) min=$2}{if($2==min) segment=$1} END {print "Tipe segmen customer yang penjualannya paling sedikit adalah ",segment," dengan ",min, " transaksi"}' trycekhasil.txt >> hasil.txt

#untuk 2d
awk -F '\t' 'NR>1 {if($13=="South") print $13, $21}' Laporan-TokoShiSop.tsv > trysouthprofit.txt
awk -F '\t' 'NR>1 {if($13=="West") print $13, $21}' Laporan-TokoShiSop.tsv > trywestprofit.txt
awk -F '\t' 'NR>1 {if($13=="Central") print $13, $21}' Laporan-TokoShiSop.tsv > trycentralprofit.txt
awk -F '\t' 'NR>1 {if($13=="East") print $13, $21}' Laporan-TokoShiSop.tsv > tryeastprofit.txt

awk '{jumlah+=$2} END {print "South ",jumlah}' trysouthprofit.txt >> trysegprofit.txt
awk '{jumlah+=$2} END {print "West ", jumlah}' trywestprofit.txt >> trysegprofit.txt
awk '{jumlah+=$2} END {print "Central ",jumlah}' trycentralprofit.txt >> trysegprofit.txt
awk '{jumlah+=$2} END {print "East ",jumlah}' tryeastprofit.txt >> trysegprofit.txt

awk 'BEGIN {minpro=9999999999; reg="rg"} {if($2<minpro) minpro=$2}{if($2==minpro) reg=$1} END {print "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah ", reg, " dengan total keuntungan ",minpro}' trysegprofit.txt >> hasil.txt
