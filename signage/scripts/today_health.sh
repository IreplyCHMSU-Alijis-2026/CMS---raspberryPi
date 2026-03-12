#!/bin/bash
echo "Enter date (YYYY-MM-DD), e.g., 2026-03-11:"
read -rp "Date: " user_date
if [[ ! $user_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Error: Invalid date format. Please use YYYY-MM-DD." >&2
    exit 1
fi

logfile="/home/vers/signage/logs/health_report_${user_date}.log"
if [[ ! -f "$logfile" ]]; then
    echo "Error: Log file not found at $logfile" >&2
    exit 1
fi

echo -e "\nFetching health logs for date: $user_date\n"

echo "HEALTH LOGS" | awk -v date="$user_date" '{print "==================== " date " | " $0 " ===================="}'

grep -A 100 "^$user_date" "$logfile"
if [ $? -eq 0 ]; then
    echo -e "========================================================================="
fi