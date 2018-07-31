package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL; 
import java.io.PrintWriter;

public class ImageLoader {

String base_url = "http://144.167.115.218:9200/blogposts/";
		    
	   
public String getUrl(String source) throws Exception {
    //System.out.println("Here");
	try {
     URL obj = new URL(source);
     HttpURLConnection con = (HttpURLConnection) obj.openConnection();
     
     con.setDoOutput(true);
    // con.setDoInput(true);
     con.setConnectTimeout(30000);
    
     con.setRequestMethod("GET");
     con.setRequestProperty("User-Agent", "Mozilla/5.0");
    
  
     BufferedReader in = new BufferedReader(
          new InputStreamReader(con.getInputStream()));
     String inputLine;
     StringBuffer response = new StringBuffer();
    
     while ((inputLine = in.readLine()) != null) {
     	response.append(inputLine);
     }
     in.close();
     String output = response.toString();
    
     if(output.indexOf("301 Moved Permanently")>-1) {
    	 source = source.replaceFirst("http", "https");
    	 output = this.getUrl(source);
    	 output =  output.replaceAll("<script"," ");
    	 output =  output.replaceAll("javascript"," ");
	     return output;
     }else {
	     output =  output.replaceAll("<script"," ");
	     output =  output.replaceAll("javascript"," ");
	     return output;
     }
	}catch(Exception ex) {
		return "";
	}
   
   }



}