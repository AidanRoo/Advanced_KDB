#!/bin/bash
#Reverse order from start.sh - as logical to stop feed first
#Variables which check if the proceeses are running if line count is found to be greater than 0 then the process is running
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

#Stopping the Feed Handler
if [[ "$checkFeed">"0"  ]]
then
          echo "The Feedhandler is running, do you wish to stop it? (y/n)"
          read stopFeed
                if [ "$stopFeed" = "y" ]; then
                kill -9 $feedPort
                echo "The Feedhandler has been stopped"
                fi
else
  echo "The Feedhandler is NOT running"
fi

#Stopping the Complex Event Process
if [[ "$checkCep">"0"  ]]
then
          echo "The CEP is running, do you wish to stop it? (y/n)"
          read stopCep
                if [ "$stopCep" = "y" ]; then
                kill -9 $cepPort
                echo "The CEP has been stopped"
                fi
else
  echo "The CEP is NOT running"
fi

#Stopping the RDB for aggegation data
if [[ "$checkRdbAgg">"0"  ]]
then
          echo "The RDB for aggregation data is running, do you wish to stop it? (y/n)"
          read stopRdbAgg
                if [ "$stopRdbAgg" = "y" ]; then
                kill -9 $rdbAggPort
                echo "The RDB for aggregation data has been stopped"
                fi
else
  echo "The RDB for Aggregation data is NOT running"
fi

#Stopping RDB for Trade and Quote data
if [[ "$checkRdbTaq">"0"  ]]
then
          echo "The RDB for Trade and Quote data is running, do you wish to stop it? (y/n)"
          read stopRdbTaq
                if [ "$stopRdbTaq" = "y" ]; then
                kill -9 $rdbTaqPort
                echo "The RDB for Trade and Quote data has been stopped"
                fi
else
  echo "The RDB for Trade and Quote data is NOT running"
fi

#Stop tickerplant process
if [[ "$checkTick">"0"  ]]
then
          echo "The Tickerplant is running, do you wish to stop it? (y/n)"
          read stopTick
                if [ "$stopTick" = "y" ]; then
                kill -9 $tickPort
                echo "The Tickerplant has been stopped"
                fi
else
  echo "The Tickerplant is NOT running"
fi

echo "+--------- Processes Stopped ---------+";







