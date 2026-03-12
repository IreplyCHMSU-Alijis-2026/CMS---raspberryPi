#!/bin/bash

LOG_DIR="/home/vers/signage/logs"
date=$(date '+%Y-%m-%d')
LOG_FILE="$LOG_DIR/health_report_${date}.log"

health() {
    echo "==================== PI HEALTH REPORT ===================="
    echo "$(date '+%Y-%m-%d %H:%M:%S')"
    echo

    echo "===================== SYSTEM INFORMATION ================="
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo

    echo "===================== CPU USAGE ================="
    echo "CPU Load: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')%"
    echo

    echo "===================== MEMORY USAGE ================="
    echo "Memory Usage: $(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')"
    echo

    echo "===================== DISK USAGE ================="
    echo "Disk Usage: $(df -h / | awk 'NR==2{print $5}')"
    echo

    echo "===================== NETWORK ================="
    RX=$(cat /sys/class/net/wlan0/statistics/rx_bytes 2>/dev/null)
    TX=$(cat /sys/class/net/wlan0/statistics/tx_bytes 2>/dev/null)
    echo "Received: $RX bytes"
    echo "Transmitted: $TX bytes"
    echo

    echo "===================== TEMPERATURE ================="
    echo "CPU Temperature: $(vcgencmd measure_temp | cut -d= -f2)"
    echo

    echo "===================== SERVICES STATUS ================="
    echo "SSH Service: $(systemctl is-active ssh)"
    echo

    echo "===================== END OF REPORT ================="
    echo -e "\n\n"
}

# Ensure log directory exists if not create it
mkdir -p "$LOG_DIR"

# Run function and append to log and create the logfile automatically
health >> "$LOG_FILE" 2>&1

find "$LOG_DIR" -name "health_report_*.log" -mtime +7 -delete