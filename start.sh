#! /bin/bash
#Load in Config values
source config.sh

# first lets start with the TICKERPLANT
read -ep "Do you wish to start the tickerplant (Y\N)? " -i "Y" startTp;
	# If Y, then start up the tickerplant
if [[ $startTp == "Y" ]]; then
	tpPid=$(pgrep -f 'tick.q');
        if [[ "" -ne "$tpPid" ]]; then
                kill -9 $tpPid;
        fi
	q tick.q sym . -p $tpPort 1>> $Advanced_KDB/logs/tickerplant.log 2>&1 & 
fi

# We will now start the RDB for Trade and Quote data
read -ep "Do you wish to start the RDB for Trade and Quote data (Y\N)? " -i "Y" startRdbTaq;
        # If Y, then start up the first RDB
if [[ $startRdbTaq == "Y" ]]; then
        rdbTaqPid=$(pgrep -f 'tick/rdbTAQ.q :$tpPort -p 5013');
        if [[ "" -ne "$rdbTaqPid" ]]; then
                kill -9 $rdbTaqPid;
        fi
	q tick/rdbTAQ.q :$tpPort -p 5013 &
fi

# Next, the aggregation RDB
read -ep "Do you wish to start the RDB for aggregation metrics (Y\N)? " -i "Y" startRdbAgg;
        # If Y, then start up the second RDB
if [[ $startRdbAgg == "Y" ]]; then
	rdbAggPid=$(pgrep -f 'tick/rdbAgg.q :$tpPort -p 5014');
        if [[ "" -ne "$rdbAggPid" ]]; then
                kill -9 $rdbAggPid;
        fi
        q tick/rdbAgg.q :$tpPort -p 5014 &
fi

# Next, the feedhandler
read -ep "Do you wish to start the Feed (Y\N)? " -i "Y" startFeed;
        # If Y, then start up the feed
if [[ $startFeed == "Y" ]]; then
        feedPid=$(pgrep -f 'feed.q');
        if [[ "" -ne "$feedPid" ]]; then
                kill -9 $feedPid;
        fi
	q tick/feed.q  -p 5015 &
fi

# Finally the CEP
read -ep "Do you wish to start the CEP (Y\N)? " -i "Y" startCep;
        # If Y, then start up the CEP
if [[ $startCep == "Y" ]]; then
	cepPid=$(pgrep -f 'cep.q');
        if [[ "" -ne "$cepPid" ]]; then
                kill -9 $cepPid;
        fi
        q tick/cep.q :$tpPort -p 5016 &
fi

echo "+--------- Processes Started ---------+";
