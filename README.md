改为centos6.8系统

# TODO:

[x] hdfs数据卷映射到主机
- 跨主机部署


# 问题
[ ] 在cenos6.8版本上ssh免密码登录失败，需要手动配置
[ ] 需要手动格式化namenode



# create hadoop network

```
sudo docker network create --driver=bridge hadoop
```

# start container

```
cd hadoop-cluster-docker
sudo ./start-container.sh
```

**output:**

```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
root@hadoop-master:~# 
```
- start 3 containers with 1 master and 2 slaves
- you will get into the /root directory of hadoop-master container

# start hadoop

```
./start-hadoop.sh
```

# run wordcount

```
./run-wordcount.sh
```

**output**

```
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```
