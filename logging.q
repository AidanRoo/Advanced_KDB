//Logging functions

\d .log 

//Connection Opened
.z.po:{.log.out[raze[("Connection Opened \nUsername:\n", string[.z.u],"\nMemory Details:\n", string[.Q.s[.Q.w[]]])]]}

//Connection Closed
.z.pc:{if[x<>0;.u.del[;x]each .u.t;.log.out[raze[("Connection Closed \n",string[x],"\nUsername:\n",string[.z.u],"\nMemory Details:\n",string[Q.s[.Q.w[]]])]]]};

//Direct to standard out and error
.log.out: {-1 x};
.log.err: {-2 x};
