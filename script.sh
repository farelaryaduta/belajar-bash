#!/bin/bash

LOG_DIR="/mnt/d/logs"

LOG_FILE=$(find $LOG_DIR -name "*.log" -mtime -1)
ERROR_PATTERNS=("ERROR" "FATAL" "CRITICAL")
REPORT_FILE="/mnt/d/logs/logs_report_analysis.txt"

echo "Analysing all the log files..." > "$REPORT_FILE"
echo "==============================" >> "$REPORT_FILE"

echo -e "\nList of the log files that has been updated in the last 24 Hours : " >> "$REPORT_FILE"
echo "$LOG_FILE" >> "$REPORT_FILE"


for LOG_FILE in $LOG_FILE; do
    echo -e "\n" >> "$REPORT_FILE"
    echo "=============================================" >> "$REPORT_FILE"
    echo "============$LOG_FILE===========" >> "$REPORT_FILE"
    echo "=============================================" >> "$REPORT_FILE"
    for PATTERN in "${ERROR_PATTERNS[@]}"; do

        echo -e "\nFound the list of the $PATTERN $LOG_FILE right here :" >> "$REPORT_FILE"
        grep "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"
        
        echo -e "\nNumber of an $PATTERN in $LOG_FILE :"  >> "$REPORT_FILE"

        ERROR_COUNT=$(grep -c "$PATTERN" "$LOG_FILE")
        grep -c "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"

        if [ "$ERROR_COUNT" -gt 10 ]; then
            echo -e "\nWARNING!!! TOO MANY $PATTERN errors in the log file in $LOG_FILE. NEED ACTION RIGHT NOW!!!"
        fi
    done    
done

echo "Log has been Analysed, and Saved into : $REPORT_FILE"