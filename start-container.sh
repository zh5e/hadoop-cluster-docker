#!/bin/bash

# the default node number is 3
N=${1:-3}

DATA_PATH=~/workproc/data/hdfs_DockData
hadoop_master="hadoop-master"


NETWORK="bridge"
docker network inspect hadoop
if [ $? != 0 ];then
    docker network create --driver=bridge hadoop
    if [ $? == 0 ]; then
        NETWORK="hadoop"
    fi
else
    NETWORK="hadoop"
fi

# start hadoop master container
docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
docker run -itd \
    --net=${NETWORK} \
    -p 50070:50070 \
    -p 8088:8088 \
    --name ${hadoop_master} \
    --hostname ${hadoop_master} \
    -v ${DATA_PATH}"/namenode":/root/hdfs/namenode \
    zh5e/hadoop:1.0 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	slave_name="hadoop-slave"${i}
	docker rm -f ${slave_name} &> /dev/null
	echo "start hadoop-slave$i container..."

    docker run -itd \
        --net=${NETWORK} \
	    --name ${slave_name} \
	    --hostname ${slave_name} \
        -v ${DATA_PATH}"/datanode${i}":/root/hdfs/datanode \
	    zh5e/hadoop:1.0 &> /dev/null
	i=$(( $i + 1 ))
done

# get into hadoop master container
docker exec -it hadoop-master bash
