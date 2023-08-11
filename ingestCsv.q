//load in schemas
system"l /home/arooney1_kx_com/Advanced_KDB/tick/sym.q";
args:.Q.opt .z.x; 

filepath: `$(raze ":",args[`csv]);
a:(upper(0!meta `$(first args[`tab]))`t;enlist",") 0: filepath;

//Open connection to tickerplant
h:hopen `$":",.z.x 0;

 //Append Records
![0N;"" sv  ("Appending ";string(count a);" records to the Tickerplant!")];
neg[h](".u.upd";`$(first args[`tab]);value flip a);
neg[h][];
exit 0
