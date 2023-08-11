#!/bin/bash

#Variables which check if the proceeses are running, if line count is found to be greater than 0 then the process is running, if so return process ID
export checkTick=$(ps -ef | grep -v grep |grep "tick.q"|wc -l)
export checkRdbTaq=$(ps -ef | grep -v grep |grep "rdbTAQ.q"|wc -l)
export checkRdbAgg=$(ps -ef | grep -v grep |grep "rdbAgg.q"|wc -l)
export checkCep=$(ps -ef | grep -v grep |grep "cep.q"|wc -l)
export checkFeed=$(ps -ef | grep -v grep |grep "feed.q"|wc -l)
#Below variables call the process ID of above processes
export tickPort=$(ps -ef | grep -v grep |grep "tick.q"|awk '{print $2}')
export rdbTaqPort=$(ps -ef | grep -v grep |grep "rdbTAQ.q"|awk '{print $2}')
export rdbAggPort=$(ps -ef | grep -v grep |grep "rdbAgg.q"|awk '{print $2}')
export cepPort=$(ps -ef | grep -v grep |grep "cep.q"|awk '{print $2}')
export feedPort=$(ps -ef | grep -v grep |grep "feed.q"|awk '{print $2}')

#Check if tickerplant is running, if so return process ID
if [[ "$checkTick">"0"  ]]
then
  echo "Tickerplant is running, Process ID: "$tickPort
else
  echo "The tickerplant is NOT running"
fi

#Check if the RDB for Trade and Quote data is running, if so return process ID
if [[ "$checkRdbTaq">"0"  ]]
then
  echo "The Trade and Quote RDB is running, Process ID:  "$rdbTaqPort
else
  echo "The Trade-Quote RDB is NOT running"
fi

#Check if the RDB for Aggregation data is running, if so return process ID
if [[ "$checkRdbAgg">"0"  ]]
then
  echo "The Aggregation RDB is running, Process ID: "$rdbAggPort
else
  echo "The Aggregation RDB is NOT running"
fi

#Check if Complex Event Handler is running, if so return process ID
if [[ "$checkCep">"0"  ]]
then
  echo "The CEP is running, Process ID: "$cepPort
else
  echo "The CEP is NOT running"
fi

#Check if feedhandler is running, if so return process ID
if [[ "$checkFeed">"0"  ]]
then
  echo "The feedhandler is running, Process ID: "$feedPort
else
  echo "The feedhandler is NOT running"
fi
