package fh;

import com.kx.c;
import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.Arrays;

public class FeedHandler {
    public static void main(String[] args) throws Exception {
		String filepath = "/home/arooney1_kx_com/Advanced_KDB/API/javatrade.csv";
        c c = null;
        try{

	        System.out.println("Trying to connect to tickerplant...");
			c = new c("localhost", 5010);
            System.out.println("Connected to tickerplant");

	        try{
		        BufferedReader br = Files.newBufferedReader(Paths.get(filepath));
		        String delimiter = ",";               
		        String line;
		        int i = 0;
		        while ((line = br.readLine()) != null) {
		                    
		            String record[] = line.split(delimiter);
		            
		            String sym = record[0];
		            double price = Double.parseDouble(record[1]);
		            int size = Integer.parseInt(record[2]);

		            Object[] tradeData = new Object[] {sym, price, size};
		            //Send row value over to the TP
		            c.ks(".u.upd", "trade", tradeData);
		            System.out.println("Record appended to tickerplant");
		            i += 1;            
		        }
		        br.close();
		    } catch (IOException ex) {
		    	System.out.println("Error reading CSV file...");
	        ex.printStackTrace();
	        } 
	    } catch (Exception e){
            System.out.println("Error connecting to tickerplant...");
            e.printStackTrace();
            System.exit(1);
        } finally {
            try{if(c!=null)c.close();}catch(java.io.IOException e){}
        }
    }               
}
