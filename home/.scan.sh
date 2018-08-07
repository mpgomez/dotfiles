#!/bin/bash

scan_comand="sudo clamscan --recursive=yes --exclude-dir=/proc --exclude-dir=/sys -i / > ${HOME}/scan_report.txt"
mkdir -p ${HOME}/scans
result_location="${HOME}/scans/scan_results$( date +'%s').txt"
echo "Going to run ${scan_comand}"
results=$($scan_comand)
echo "$results" > ${result_location}
infected=$(cat ${result_location} | grep Infected) 
echo "Infected: $infected. See report at ${result_location}"

zenity --warning --text="The scan has finished, please review it at ${result_location}. ${infected}"
