#!/bin/bash

mkdir -/tmp/hadoop/dfs/journalnode/hacluster

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR journalnode
