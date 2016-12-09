#!/bin/bash

echo ""

if [ ! -e "./hadoop-2.7.3.tar.gz" ]; then
    echo "cant find hadoop tar, downloading...\n"
    wget http://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
fi

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t zhjiee/hadoop:1.0 .

echo ""
