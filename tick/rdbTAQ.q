/q tick/r.q [host]:port[:usr:pwd] [host]:port[:usr:pwd]
/2008.09.09 .k ->.q

\p 5013
.z.ws:{neg[.z.w] .Q.s[select from trade where sym=`$x]};
/load in logging
system raze["l ",getenv[`Advanced_KDB],"/logging.q"]

if[not "w"=first string .z.o;system "sleep 1"];

/upd:{if[x=`aggregation; x insert y]}
upd:{if[x in `trade`quote; x insert y]}

/ get the ticker plant and history ports, defaults are 5010,5012
.u.x:.z.x,(count .z.x)_(":5010";":5012");

/ end of day: save, clear, hdb reload
.u.end:{t:tables`.;t@:where `g=attr each t@\:`sym;.Q.hdpf[`$":",.u.x 1;`:.;x;`sym];@[;`sym;`g#] each t;};

/ init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{(.[;();:;].)each x;if[null first y;:()];-11!y;system "cd ",1_-10_string first reverse y};
/ HARDCODE \cd if other than logdir/db

/ connect to ticker plant for (schema;(logcount;log))
.u.rep .(hopen `$":",.u.x 0)"((.u.sub[`quote;`];.u.sub[`trade;`]);`.u `i`L)";