/load in schemas from sym.q
/system"l tick/",(src:first .z.x,enlist"sym"),".q";

h:neg hopen hsym `$(raze[("localhost:5010")]) //connect to tickerplant

\l logging.q

syms:`MSFT.O`IBM.N`AMZN.N`BA.N`SONY.L /stocks

prices:syms!52.85 251.62 278.50 114.79 178.30 /starting prices

n:2 /number of rows per update

flag:1 /generate 10% of updates for trade and 90% for quote

//create price movements
movement:{[t] rand[0.0001]*prices[t]}

/generate fluctuations for trades
getprice:{[t] prices[t]+:rand[1 -1]*movement[t]; prices[t]}
bid:{[t] prices[t]-movement[t]} /generate bid price
ask:{[t] prices[t]+movement[t]} /generate ask price

/timer function
.z.ts:{
  t:n?syms;
  $[0<flag mod 10;
    h(".u.upd";`quote;(n#.z.N;t;bid'[t];ask'[t];n?1000;n?1000));
    h(".u.upd";`trade;(n#.z.N;t;getprice'[t];n?999))];
  flag+:1; }

/trigger timer every second
\t 1000