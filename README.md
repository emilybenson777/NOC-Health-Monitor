# NOC Automated Health Monitor

## Project Overview

This Bash script acts as an automated System Administrator for our cybersecurity hardware nodes. It interrogates the Linux kernel for CPU, RAM, and Disk metrics, evaluates storage thresholds, and appends a formatted report to a local, persistent log file.

## Prerequisites

- A Linux environment (Ubuntu, Parrot OS, WSL, etc.)
- Standard GNU utilities (pre-installed on most distributions)

## Setup & Execution

1. Clone this repository to your local machine.
2. Navigate into the directory and make the script executable:

   chmod +x health_check.sh

3. Run the script:

   ./health_check.sh

## Automation (Cron)

To run this script automatically, it must be scheduled using the Linux cron daemon.

To run the health check every hour at the top of the hour, add the following entry to your crontab using `crontab -e`:

    0 * * * * /home/emilybenson/chapter24_noc_health_monitor/health_check.sh

This cron entry runs the script at minute 0 of every hour.