#!/bin/bash
echo 'Dont run this script!!'
exit 255

# move current file directory
cd `dirname $0`

# Check file size each directories
du -d 1

# Check crontab
diff -u <(crontab -l) crontab.ini

# Update crontab
crontab ceontab.ini

# Use yesterday to command arg
./bin/python -m report.main --date `date +"%Y-%m-%d" --date '1 days ago'`

# Redirect
command >> file 2>&1
command 1>file 2>&1
