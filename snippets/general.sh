#!/bin/bash
echo 'Dont run this script!!'
exit 255

# move current file directory
cd `dirname $0`

script_dir_path=$(cd $(dirname $0) && pwd)
cd $script_dir_path

# See http://qiita.com/m-yamashita/items/889c116b92dc0bf4ea7d?utm_source=Qiita%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%B9&utm_campaign=a349fbe9d6-Qiita_newsletter_146_03_11_2015&utm_medium=email&utm_term=0_e44feaa081-a349fbe9d6-10307105
# $B%7%s%\%j%C%/%j%s%/$NCf$K$$$k>l9g(B
case "${OSTYPE}" in
  freebsd*|darwin*)
    scriptDirPath=$(dirname $(greadlink -f $0))
    ;;
  linux*)
    scriptDirPath=$(dirname $(readlink -f $0))
    ;;
esac


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

# loop
for i in {00..23};do
    echo $i
done
