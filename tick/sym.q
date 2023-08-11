// schemas used throughout TP
//trade table
trade:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$())

//quote table
quote:([]time:`timespan$();sym:`symbol$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$())

//aggregation metrics
aggregation:([] time: `timespan$(); sym: `$(); maxPrice: `float$(); minPrice: `float$(); volume: `int$(); maxBid: `float$(); minAsk:`float$())

