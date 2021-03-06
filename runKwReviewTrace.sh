#!/bin/bash
echo "***** Number of compilations:"
grep ^compile kwinject.out | wc -l

echo ""
echo "***** Compilers configured:"
grep ^config kwinject.out | awk -F ';' '{print $2}' | awk -F "|" '{print $1}' | sort -u | tee kwvalidatetrace1.log

echo ""
echo "***** Compilers possibly used, but not recognized:"
grep '"executable":' kwinjectTrace.txt| awk -F',' '{print $4}' | awk -F':' '{print $2}' | sed 's/\"//g' | sort -u > kwvalidatetrace2.log
grep -vxF -f kwvalidatetrace1.log kwvalidatetrace2.log | grep -e "cc" -e "cp" -e "pp" -e "gc" -e "gn" -e "g+" -e "++"

rm -f kwvalidatetrace1.log kwvalidatetrace2.log