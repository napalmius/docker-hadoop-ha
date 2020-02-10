#!/bin/bash

namedir=`echo $HDFS_CONF_dfs_namenode_name_dir | perl -pe 's#file://##'`
if [ ! -d $namedir ]; then
  echo "Namenode name directory not found: $namedir"
  exit 2
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 2
fi

if [ "`ls -A $namedir`" == "" ]; then
  echo "Formatting namenode name directory: $namedir"
  echo "$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode $PRE_RUN_ARGS -force"
  $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode $PRE_RUN_ARGS -force
fi

echo "About to init zkfc $INIT_NODE"
if [ $INIT_NODE ]; then
  $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR zkfc -formatZK
fi

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start zkfc

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode
