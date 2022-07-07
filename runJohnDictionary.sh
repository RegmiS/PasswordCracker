#!/bin/bash

## To run this bash script, place it in your john/run folder.
## Ensure you have all the files text files in the folder:
##    md5len6.txt,
##    md5len8.txt,
##    md5len10.txt,
##    md5len12.txt,
##    md5len14.txt
## Run the script using;
##    bash ./runJohnDictionary.sh [Name of Folder to Create/Store Results Files] [Path to the Dictionary]

## Time out
TIMEOUT=600;

## Files/hashes that will be tested
fileNames=("md5_len6" "md5_len8" "md5_len10" "md5_len12" "md5_len14" "md5_len16")
timedDictionaryOutputNames=()
outputDictionaryNames=()

## Check for correct number of command line args
if [[ $# -ne 2 ]];
then
    echo "Usage: bash $0 [folder to create/store results data in] [path to dictionary]"
    echo "    E.g. bash $0 DictionaryTest1 ~/documents/mydictionary.txt"
    exit 2
fi

# Make folder to store results in
mkdir $1

## Create output names for each file
for i in "${fileNames[@]}"
do
	timedOutputDictionaryName+=("TIMED_DICTIONARY_$i")
	outputDictionaryNames+=("OUTPUT_DICTIONARY_$i")
done

## Try running john the ripper and output results to file
for ((i=0;i<${#fileNames[@]};++i)); do

	## Print to command line a running message
	echo -----------------------------------
	echo TESTING: ${fileNames[i]}.txt
	echo -----------------------------------
	echo This might take several minutes... Please wait...

	## Run john with timeout, save results into file. Save pot file under new name to keep pot file. 
	time timeout $TIMEOUT ./john --wordlist=$2 --format=RAW-MD5 --rules ${fileNames[i]}.txt &> $1/${timedOutputDictionaryNames[i]}.txt; mv john.pot $1/TIMED_POT_DICTIONARY_${fileNames[i]}.pot
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}.pot


	time timeout $TIMEOUT ./john --wordlist=$2 --format=RAW-MD5 --rules ${fileNames[i]}a.txt &> $1/${timedOutputDictionaryNames[i]}a.txt; mv john.pot $1/TIMED_POT_DICTIONARY_${fileNames[i]}a.pot
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}a.pot


	time timeout $TIMEOUT ./john --wordlist=$2 --format=RAW-MD5 --rules ${fileNames[i]}b.txt &> $1/${timedOutputDictionaryNames[i]}b.txt; mv john.pot $1/TIMED_POT_DICTIONARY_${fileNames[i]}b.pot
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}b.pot



	time timeout $TIMEOUT ./john --wordlist=$2 --format=RAW-MD5 --rules ${fileNames[i]}c.txt &> $1/${timedOutputDictionaryNames[i]}c.txt; mv john.pot $1/TIMED_POT_DICTIONARY_${fileNames[i]}c.pot
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}c.pot


	time timeout $TIMEOUT ./john --wordlist=$2 --format=RAW-MD5 --rules ${fileNames[i]}d.txt &> $1/${timedOutputDictionaryNames[i]}d.txt; mv john.pot $1/TIMED_POT_DICTIONARY_${fileNames[i]}d.pot
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}d.pot


	## Uncomment the following 3 lines if you also want to test without a 10 sec timeout
	# echo Running John the Ripper with no timeout-- this will take several min...
	# time ./john --wordlist=$2 --format=RAW-MD5 --rules ${fileNames[i]}.txt &> $1/${outputDictionaryNames[i]}.txt ; mv john.pot $1/POT_DICTIONARY_${fileNames[i]}.pot
	# wc -l $1/POT_DICTIONARY_${fileNames[i]}.pot
done

