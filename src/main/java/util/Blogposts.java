package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL; 
import org.json.JSONObject;
import org.json.JSONArray;

import java.io.OutputStreamWriter;


import java.util.ArrayList;

public class Blogposts {

String base_url = "http://144.167.115.218:9200/test-migrate/";
String totalpost;		    
	   
public ArrayList _list(String order) throws Exception {
	 ArrayList result = new ArrayList();
	 
	 JSONObject query = new JSONObject();
	 JSONObject param = new JSONObject();
	 
	
	 
	 JSONObject ord = new JSONObject();
	 JSONObject sortby =new JSONObject();
	
	 
	 param.put("match_all",new JSONObject());
	 
	 
	 ord.put("order", order);
	 
	 query.put("query", param);
	 sortby.put("date", ord);
	 
	 
	 query.put("sort", sortby);
	 //auth.put("passwordCredentials", cred);
	 //parent.put("auth", auth);
	 
	 System.out.println(query.toString());
	 
     String url = base_url+"_search/";
     URL obj = new URL(url);
     HttpURLConnection con = (HttpURLConnection) obj.openConnection();
     
     con.setDoOutput(true);
     con.setDoInput(true);
     // optional default is GET
     //con.setRequestMethod("GET");
     
     con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
     con.setRequestProperty("Accept", "application/json");
     con.setRequestMethod("POST");
     
     OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
     wr.write(query.toString());
     wr.flush();
     
     //add request header
     //con.setRequestProperty("User-Agent", "Mozilla/5.0");
     int responseCode = con.getResponseCode();
     
     BufferedReader in = new BufferedReader(
          new InputStreamReader(con.getInputStream()));
     String inputLine;
     StringBuffer response = new StringBuffer();
     while ((inputLine = in.readLine()) != null) {
     	response.append(inputLine);
     }
     in.close();
     
     JSONObject myResponse = new JSONObject(response.toString());
     String res = myResponse.getString("hits");
     JSONObject myRes1 = new JSONObject(res);
     

     
      String total = myRes1.getString("total");
      this.totalpost = total;
    // System.out.println(total);
     //System.out.println("Hits- "+myRes1.getString("hits"));
         
     //JSONArray jsonArray = (JSONArray)myRes1.getString("hits"); 
     ArrayList<String> list = new ArrayList<String>();     
     JSONArray jsonArray = new JSONArray(myRes1.getString("hits")); 
     
     if (jsonArray != null) { 
        int len = jsonArray.length();
        for (int i=0;i<len;i++){ 
         list.add(jsonArray.get(i).toString());
        } 
     }
     
    return  list;
   
   }

public String _getTotal() {
	return this.totalpost;
}
	
public ArrayList _search(String term) throws Exception {
	 ArrayList result = new ArrayList();
	 
	 JSONObject query = new JSONObject();
	
	 
	 
	 JSONObject qstr = new JSONObject();
	 JSONObject fields =new JSONObject();
	
	
	 fields.put("fields", "['blogger','blogger','post']");
	
	
	 qstr.put("fields", fields);
	 qstr.put("query", term);
	 
	 query.put("query", qstr);
	
	 
	 //auth.put("passwordCredentials", cred);
	 //parent.put("auth", auth);
	 
	 System.out.println(query.toString());
	 
    String url = base_url+"_search/";
    URL obj = new URL(url);
    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
    
    con.setDoOutput(true);
    con.setDoInput(true);
    // optional default is GET
    //con.setRequestMethod("GET");
    
    con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
    con.setRequestProperty("Accept", "application/json");
    con.setRequestMethod("POST");
    
    OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
    wr.write(query.toString());
    wr.flush();
    
    //add request header
    //con.setRequestProperty("User-Agent", "Mozilla/5.0");
    int responseCode = con.getResponseCode();
    
    BufferedReader in = new BufferedReader(
         new InputStreamReader(con.getInputStream()));
    String inputLine;
    StringBuffer response = new StringBuffer();
    while ((inputLine = in.readLine()) != null) {
    	response.append(inputLine);
    }
    in.close();
    
    JSONObject myResponse = new JSONObject(response.toString());
    String res = myResponse.getString("hits");
    JSONObject myRes1 = new JSONObject(res);
    

    
     String total = myRes1.getString("total");
   // System.out.println(total);
    //System.out.println("Hits- "+myRes1.getString("hits"));
        
    //JSONArray jsonArray = (JSONArray)myRes1.getString("hits"); 
    ArrayList<String> list = new ArrayList<String>();     
    JSONArray jsonArray = new JSONArray(myRes1.getString("hits")); 
    
    if (jsonArray != null) { 
       int len = jsonArray.length();
       for (int i=0;i<len;i++){ 
        list.add(jsonArray.get(i).toString());
       } 
    }
    
   return  list;
}


}