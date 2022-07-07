#!/bin/bash

## To run this bash script, place it in your john/run folder.
## Ensure you have all the files text files in the folder:
##    md5len6.txt,
##    md5len8.txt,
##    md5len10.txt,
##    md5len12.txt,
##    md5len14.txt
## Run the script using;
##    bash ./runJohnBrute.sh [Name of Folder to Create/Store Results Files]

## Time out
TIMEOUT=600;

## Files/hashes that will be tested
fileNames=("md5_len6" "md5_len8" "md5_len10" "md5_len12" "md5_len14" "md5_len16")
timedOutputNames=()
outputNames=()

## Check for correct number of command line args
if [[ $# -ne 1 ]];
then
    echo "Usage: bash $0 [Name of Folder to Create/Store Results Files]"
    echo "    E.g. bash $0 BruteTest1"
    exit 2
fi

# Make folder to store results in
mkdir $1

## Create output names for each file
for i in "${fileNames[@]}"
do
	timedOutputName+=("TIMED_BRUTE_$i")
	outputNames+=("OUTPUT_BRUTE_$i")
done

## Try running john the ripper and output results to file
for ((i=0;i<${#fileNames[@]};++i)); do

	## Print to command line a running message
        echo -----------------------------------
        echo TESTING: ${fileNames[i]}.txt
        echo -----------------------------------
	echo This might take several minutes... Please wait...

	## Run john with timeout, save results into file. Save pot file under new name to keep pot file. 
	time timeout $TIMEOUT ./john --incremental --format=RAW-MD5 ${fileNames[i]}.txt &> $1/${timedOutputNames[i]}.txt; mv john.pot $1/TIMED_POT_BRUTE_${fileNames[i]}.pot
	wc -l $1/TIMED_POT_BRUTE_${fileNames[i]}.pot

	time timeout $TIMEOUT ./john --incremental --format=RAW-MD5 ${fileNames[i]}a.txt &> $1/${timedOutputNames[i]}a.txt; mv john.pot $1/TIMED_POT_BRUTE_${fileNames[i]}a.pot
	wc -l $1/TIMED_POT_BRUTE_${fileNames[i]}a.pot


	time timeout $TIMEOUT ./john --incremental --format=RAW-MD5 ${fileNames[i]}b.txt &> $1/${timedOutputNames[i]}b.txt; mv john.pot $1/TIMED_POT_BRUTE_${fileNames[i]}b.pot
	wc -l $1/TIMED_POT_BRUTE_${fileNames[i]}b.pot


	time timeout $TIMEOUT ./john --incremental --format=RAW-MD5 ${fileNames[i]}c.txt &> $1/${timedOutputNames[i]}c.txt; mv john.pot $1/TIMED_POT_BRUTE_${fileNames[i]}c.pot
	wc -l $1/TIMED_POT_BRUTE_${fileNames[i]}c.pot
	

	time timeout $TIMEOUT ./john --incremental --format=RAW-MD5 ${fileNames[i]}d.txt &> $1/${timedOutputNames[i]}d.txt; mv john.pot $1/TIMED_POT_BRUTE_${fileNames[i]}d.pot
	wc -l $1/TIMED_POT_BRUTE_${fileNames[i]}d.pot


	## Uncomment the following 3 lines if you also want to test without a 10 sec timeout
	# echo Running John the Ripper with no timeout-- this will take several min...
	# time ./john --incremental --format=RAW-MD5 ${fileNames[i]}.txt &> $1/${outputNames[i]}.txt ; mv john.pot $1/POT_BRUTE_${fileNames[i]}.pot
	# wc -l $1/POT_BRUTE_${fileNames[i]}.pot
done

