#!/bin/bash
echo 'Dont run this script!!'
exit 255

# move current file directory
cd `dirname $0`

script_dir_path=$(cd $(dirname $0) && pwd)
cd $script_dir_path

# See http://qiita.com/m-yamashita/items/889c116b92dc0bf4ea7d?utm_source=Qiita%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%B9&utm_campaign=a349fbe9d6-Qiita_newsletter_146_03_11_2015&utm_medium=email&utm_term=0_e44feaa081-a349fbe9d6-10307105
# シンボリックリンクの中にいる場合
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

# Check EC2 instance meta data
curl http://169.254.169.254/latest/meta-data/

###########################################################
# function
###########################################################
hoge () {
    TABLE=$1
    echo --------------------------------------
    echo Check $TABLE
    echo --------------------------------------
}

hoge table_1
hoge table_2


###########################################################
# For loop
###########################################################
# with list
fuga_types=(aaa bbb ccc)
for fuga_type in ${fuga_types[@]}
do
  echo Start $fuga_type
  # do something
done

# with range
for i in {00..23};do
    echo $i
done

# with date range
START_DATE="20171010"
END_DATE="20171023"

for (( DATE=${START_DATE} ; ${DATE} < ${END_DATE} ; DATE=`date -d "${DATE} 1 day" '+%Y%m%d'` )) ; do
    DF=`date -d ${DATE} '+%Y-%m-%d'`
    D=`date -d ${DATE} '+%Y%m%d'`
    echo make run_hoge TARGET_DATE=${D}
done
