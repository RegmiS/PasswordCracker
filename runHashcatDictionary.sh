#!/bin/bash

## To run this bash script, place it in your john/run folder.
## Ensure you have all the files text files in the folder:
##    md5len6.txt,
##    md5len8.txt,
##    md5len10.txt,
##    md5len12.txt,
##    md5len14.txt
## Run the script using;
##    bash ./runHashcatDictionary.sh [Name of Folder to Create/Store Results Files] [Path to Dictionary]

## Time out
TIMEOUT=600;

## Files/hashes that will be tested
fileNames=("md5_len6" "md5_len8" "md5_len10" "md5_len12" "md5_len14" "md5_len16")
timedOutputNames=()
outputNames=()

## Check for correct number of command line args
if [[ $# -ne 2 ]];
then
    echo "Usage: bash $0 [Name of Folder to Create/Store Results Files] [Path to Dictionary]"
    echo "    E.g. bash $0 HashcatTest1 rockyou.txt"
    exit 2
fi

# Make folder to store results in
mkdir $1

## Create output names for each file
for i in "${fileNames[@]}"
do
	timedOutputName+=("TIMED_DICTIONARY_$i")
	outputNames+=("OUTPUT_DICTIONARY_$i")
done

## Try running hashcat and output results to file
for ((i=0;i<${#fileNames[@]};++i)); do

	## Print to command line a running message
        echo -----------------------------------
        echo TESTING: ${fileNames[i]}.txt
        echo -----------------------------------
	echo Bash script running... This might take several minutes... Please wait...

	## Run hashcat with timeout, save results into file. Save pot file under new name to keep pot file. 
	time timeout $TIMEOUT hashcat -a 0 -m 0 ${fileNames[i]}.txt $2 > $1/${timedOutputNames[i]}.txt; mv ~/.hashcat/hashcat.potfile ./$1/TIMED_POT_DICTIONARY_${fileNames[i]}.potfile
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}.potfile


	time timeout $TIMEOUT hashcat -a 0 -m 0 ${fileNames[i]}a.txt $2 > $1/${timedOutputNames[i]}a.txt; mv ~/.hashcat/hashcat.potfile ./$1/TIMED_POT_DICTIONARY_${fileNames[i]}a.potfile
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}a.potfile



	time timeout $TIMEOUT hashcat -a 0 -m 0 ${fileNames[i]}b.txt $2 > $1/${timedOutputNames[i]}b.txt; mv ~/.hashcat/hashcat.potfile ./$1/TIMED_POT_DICTIONARY_${fileNames[i]}b.potfile
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}b.potfile


	time timeout $TIMEOUT hashcat -a 0 -m 0 ${fileNames[i]}c.txt $2 > $1/${timedOutputNames[i]}c.txt; mv ~/.hashcat/hashcat.potfile ./$1/TIMED_POT_DICTIONARY_${fileNames[i]}c.potfile
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}c.potfile

	
	time timeout $TIMEOUT hashcat -a 0 -m 0 ${fileNames[i]}d.txt $2 > $1/${timedOutputNames[i]}d.txt; mv ~/.hashcat/hashcat.potfile ./$1/TIMED_POT_DICTIONARY_${fileNames[i]}d.potfile
	wc -l $1/TIMED_POT_DICTIONARY_${fileNames[i]}d.potfile

	## Uncomment the following 3 lines if you also want to test without a 10 sec timeout
	# echo Running hachcat with no timeout-- this will take several min...
	# time hashcat -a 0 -m 0 ${fileNames[i]}.txt $2 > $1/${outputNames[i]}.txt ; mv ~/.hashcat/hashcat.potfile ./$1/POT_DICTIONARY_${fileNames[i]}.potfile
	# wc -l $1/POT_DICTIONARY_${fileNames[i]}.potfile
done

