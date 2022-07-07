#!/bin/bash

## Check for correct number of command line args
if [[ $# -ne 1 ]];
then
    echo "Usage: bash $0 [path of dictionary]"
    echo "    E.g. bash $0 ~/documents/mydictionary.txt"
    exit 2
fi

# Make folder to store results 


chmod +x runJohnBrute.sh
chmod +x runJohnDictionary.sh
chmod +x runHashcatBrute.sh
chmod +x runHashcatDictionary.sh

./runJohnBrute.sh JTRBruteTest1
./runJohnDictionary.sh JTRDictionaryTest1 $1
./runHashcatBrute.sh HCBruteTest1
./runHashcatDictionary.sh HCDictionaryTest1 $1


