## kdb+ Tickerplant Runbook 

#Section 1
The key processes (q1-4) of the tickerplant can be started by running:
$Advanced_KDB/scripts/start.sh

You can see which processes are currently running by running:
$Advanced_KDB/scripts/test.sh

You can then stop the same processes by running:
$Advanced_KDB/scripts/stop.sh


You can manually run the same processes in turn by opening a terminal for each process and following the below section, but this ensure to set the Advanced_KDB and tpPort variables: 
export Advanced_KDB="$(dirname pwd)" && export tpPort=5010

1) To start tickerplant
export Advanced_KDB="$(dirname pwd)" && export tpPort=5010
q $Advanced_KDB/tick.q sym . -p $tpPort

*Please ensure there is a space character between the period and port flag otherwise the sym file will be written to a -p directory.
*Otherwise the latter commands will not work as expected 

2) To start RDBs
export Advanced_KDB="$(dirname pwd)" && export tpPort=5010
q $Advanced_KDB/tick/rdbTAQ.q localhost:$tpPort -p 5013

export Advanced_KDB="$(dirname pwd)" && export tpPort=5010
q $Advanced_KDB/tick/rdbAgg.q localhost:$tpPort -p 5014

3)To start feedhandler 
export Advanced_KDB="$(dirname pwd)" && export tpPort=5010
q $Advanced_KDB/tick/feed.q -p 5015

4) To start CEP:
export Advanced_KDB="$(dirname pwd)" && export tpPort=5010
q $Advanced_KDB/tick/cep.q localhost:$tpPort -p 5016

5) Logging script found in 
Advanced_KDB/logging.q

Correspondent logs can be found in /log directory

The below is not automated by the scripts, you will have to manually run each:
7) To run log replay 
q logReplay.q sym<date>

8) To run the CSV ingestion process
q ingestCsv.q :5010 -p 5018 -tab trade -csv /home/arooney1_kx_com/Advanced_KDB/trade.csv

You will know this is successful by opening and connection to TAQ RDB and searching for a specific symbol found only in the csv:
q)h:hopen 5013
q)h"select from trade where sym=`KX"

9) To run EOD 
q tick/eod.q sym<date>

10)Has been emailed to marker, but can also be found at: 
https://fdplc-my.sharepoint.com/:w:/g/personal/arooney1_firstderivatives_com/EQhruxSECEhMrL24crDywk0BunE4yBpEO7iohEp1i_ufLw?CID=35b2b982-9797-ff99-737e-a83f42aa3068
Please contact me if access is required

_________________________________________
****************Section 2****************
_________________________________________
Has been emailed to marker, but can also be found:
https://fdplc-my.sharepoint.com/:w:/g/personal/arooney1_firstderivatives_com/EQhruxSECEhMrL24crDywk0BunE4yBpEO7iohEp1i_ufLw?CID=35b2b982-9797-ff99-737e-a83f42aa3068

_________________________________________
****************Section 3****************
_________________________________________

1) Python
The Python API leverages PyKX to make the connection to the tickerplant. 

To run the API:
Make sure the relevant processes are up; tickerplant and TAQ RDB
cd into the API directory: /home/arooney1_kx_com/Advanced_KDB/API
python csvIngest.py

This will push 10 rows of trade data to the tickerplant from a file named pytrade.csv.
You can sanity check the records have been opened by:
- Opening a q terminal
- h:hopen 5013
- h"select from trade where sym=`PY"
2) Java
To run the API:
Make sure the relevant processes are up; tickerplant and TAQ RDB
cd into the Java directory: /home/arooney1_kx_com/Advanced_KDB/API/Java
Then run:
javac -sourcepath "src/main/java" -d . src/main/java/fh/FeedHandler.java
java -cp . fh.FeedHandler

This will push 10 rows of trade data to the tickerplant from a file named javatrade.csv.
You can sanity check the records have been appended by:
- Opening a q terminal
- h:hopen 5013
- h"select from trade where sym=`JAVA" 
