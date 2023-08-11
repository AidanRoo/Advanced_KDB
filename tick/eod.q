//Script to run EOD process

//load in sym file
\l sym.q

// define upd
upd:insert

//get then replay log file
lf:first hsym `$(.z.x)
-11!lf;

//extract data from log file
date:value (-10#string[lf])

// save data in each table
a:.Q.hdpf[`.;`:hdb;date;`sym] each tables`.

//creating hdb directory
hdbdir:`$raze[(system"pwd"),"/hdb"];

//compress all data except for time and sym
c:splay:` sv/:' ((hsym hdbdir),'(`$string[date]),/:a),/:' ((cols each a) except\:`time`sym)
{-19!(x;x;17;2;6)} each/: c

//success message then return console
0N!"The HDB partition has been created";
exit 0