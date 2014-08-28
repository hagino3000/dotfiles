#!/bin/bash

# Check crontab
diff -u <(crontab -l) crontab.ini

# Update crontab
# crontab ceontab.ini
