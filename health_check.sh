#!/bin/bash

# LCCC Cybersecurity NOC - System Health Monitor

# Author: Emily Benson

 

# Define the log file location

LOG_FILE="system_health.log"

 

# 1. Generate Timestamp

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

 

# 2. Gather Telemetry

# Get the root partition (/) disk usage percentage and strip the % sign

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

 

# Get the 1-minute CPU load average from uptime

CPU_LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | awk '{print $1}')

 

# Get available RAM in Megabytes

RAM_FREE=$(free -m | awk 'NR==2 {print $7}')

 

# 3. Evaluation Logic

# Check if the disk is over 80% full

THRESHOLD=80

 

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then

    # If the usage is greater than or equal to the threshold

    STATUS="[WARNING] Disk usage is critically high at ${DISK_USAGE}%!"

else

    # If the usage is safely below the threshold

    STATUS="[OK] Disk usage is stable at ${DISK_USAGE}%."

fi

 

# 4. Format and Write to Log (Append Mode)

# The >> operator appends data to the bottom of the file without erasing history

echo "----------------------------------------" >> "$LOG_FILE"

echo "NOC Health Report - $TIMESTAMP" >> "$LOG_FILE"

echo "CPU Load (1m) : $CPU_LOAD" >> "$LOG_FILE"

echo "Free RAM      : ${RAM_FREE}MB" >> "$LOG_FILE"

echo "Disk Status   : $STATUS" >> "$LOG_FILE"

echo "----------------------------------------" >> "$LOG_FILE"

 

# Provide visual feedback in the terminal for the operator

echo "Health check executed. Results securely logged to $LOG_FILE"