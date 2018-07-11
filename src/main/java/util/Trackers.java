package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL; 
import org.json.JSONObject;
import org.json.JSONArray;

import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;

public class Trackers {

String base_url = "http://144.167.115.218:9200/trackers/";
String totalpost;		    
	   
public ArrayList _list(String order, String from, String userid, String size) throws Exception {
	 	 JSONObject jsonObj = new JSONObject("{\r\n" + 
	 		"  \"query\": {\r\n" + 
	 		"        \"query_string\" : {\r\n" + 
	 		"            \"fields\" : [\"userid\"],\r\n" + 
	 		"            \"query\" : \""+userid+"\"\r\n" + 
	 		"        }\r\n" + 
	 		"  },\r\n" + 
	 		"   \"sort\":{\r\n" + 
	 		"		\"tid\":{\r\n" + 
	 		"			\"order\":\"DESC\"\r\n" + 
	 		"			}\r\n" + 
	 		"		}\r\n" + 
	 		"}");
	

    if(!from.equals("")) {
    	jsonObj = new JSONObject("{\r\n" + 
    			"  \"query\": {\r\n" + 
    			"        \"query_string\" : {\r\n" + 
    			"            \"fields\" : [\"userid\"],\r\n" + 
    			"            \"query\" : \""+userid+"\"\r\n" + 
    			"        }\r\n" + 
    			"  },\r\n" + 
    			"   \"sort\":{\r\n" + 
    			"		\"tid\":{\r\n" + 
    			"			\"order\":\"DESC\"\r\n" + 
    			"			}\r\n" + 
    			"		},\r\n" + 
    			" \"range\":{\r\n" + 
    			"		\"tid\":{\r\n" + 
    			"			\"lte\":\""+from+"\",\r\n" + 
		  		"			\"gte\":\""+0+"\"\r\n" + 
    			"			}\r\n" + 
    			"		}\r\n" + 
    			"}");
    }
	 
     String url = base_url+"_search?size="+size;     
     return this._getResult(url, jsonObj);
   
   }

public String _getTotal() {
	return this.totalpost;
}

public JSONObject getMyTrackedBlogs(String userid) throws Exception{
	String res = null;
	JSONObject resp = null;
	String resu = null;
	JSONObject obj = null;	
	ArrayList result = this._list("DESC","", userid,"100");
	
	JSONObject content = new JSONObject();
	for(int i=0; i< result.size(); i++){
		res = result.get(i).toString();			
		resp = new JSONObject(res);
	    resu = resp.get("_source").toString();
	    obj = new JSONObject(resu);
	    String id = obj.get("tid").toString();
	    String query = obj.get("query").toString();
		query = query.replaceAll("blogsite_id in ", "");
		query = query.replaceAll("\\(", "");			 
		query = query.replaceAll("\\)", "");
		
		 if(!query.equals("")){
			 String[] allque = query.split(",");
			 if( allque.length>0){
				 for(int k=0; k< allque.length; k++){
					 String blog_id = allque[k].trim();
					 content.put(blog_id, blog_id);
				 }
			 }
		 }
	}
	
	return content;
}


public ArrayList _search(String term,String from) throws Exception {
	 JSONObject jsonObj = new JSONObject("{\r\n" + 
	 		"  \"query\": {\r\n" + 
	 		"        \"query_string\" : {\r\n" + 
	 		"            \"fields\" : [\"tracker_name\"],\r\n" + 
	 		"            \"query\" : \""+term+"\"\r\n" + 
	 		"        }\r\n" + 
	 		"  },\r\n" + 
	 		"   \"sort\":{\r\n" + 
	 		"		\"tid\":{\r\n" + 
	 		"			\"order\":\"DESC\"\r\n" + 
	 		"			}\r\n" + 
	 		"		}\r\n" + 
	 		"}");
	
	 
    String url = base_url+"_search?size=10";
    if(!from.equals("")) {
    	jsonObj = new JSONObject("{\r\n" + 
    			"  \"query\": {\r\n" + 
    			"        \"query_string\" : {\r\n" + 
    			"            \"fields\" : [\"tracker_name\"],\r\n" + 
    			"            \"query\" : \""+term+"\"\r\n" + 
    			"        }\r\n" + 
    			"  },\r\n" + 
    			"   \"sort\":{\r\n" + 
    			"		\"tid\":{\r\n" + 
    			"			\"order\":\"DESC\"\r\n" + 
    			"			}\r\n" + 
    			"		},\r\n" + 
    			" \"range\":{\r\n" + 
    			"		\"tid\":{\r\n" + 
    			"			\"lte\":\""+from+"\",\r\n" + 
		  		"			\"gte\":\""+0+"\"\r\n" + 
    			"			}\r\n" + 
    			"		}\r\n" + 
    			"}");
    }
    
    return this._getResult(url, jsonObj);
}



public String getTotalTrack(String blogsite_id) throws Exception {
	 JSONObject jsonObj = new JSONObject("{\r\n" + 
	 		"  \"query\": {\r\n" + 
	 		"        \"query_string\" : {\r\n" + 
	 		"            \"fields\" : [\"query\"],\r\n" + 
	 		"            \"query\" : \""+blogsite_id+",\"\r\n" + 
	 		"        }\r\n" + 
	 		"  },\r\n" + 
	 		"   \"sort\":{\r\n" + 
	 		"		\"tid\":{\r\n" + 
	 		"			\"order\":\"DESC\"\r\n" + 
	 		"			}\r\n" + 
	 		"		}\r\n" + 
	 		"}");
	
	 
    String url = base_url+"_search?size=10";
    
    
    return this._getTotal(url, jsonObj);
}


public ArrayList _fetch(String ids) throws Exception {
	 ArrayList result = new ArrayList();
	 
	 JSONObject query = new JSONObject(); 
	 JSONObject jsonObj = new JSONObject("{\r\n" + 
	 		"  \"query\": {\r\n" + 
	 		"    \"constant_score\":{\r\n" + 
	 		"			\"filter\":{\r\n" + 
	 		"					\"terms\":{\r\n" + 
	 		"							\"tid\":[\""+ids+"\"]\r\n" + 
	 		"							}\r\n" + 
	 		"					}\r\n" + 
	 		"				}\r\n" + 
	 		"    }\r\n" + 
	 		"}");
	 
	 
   String url = base_url+"_search/";
   return this._getResult(url, jsonObj);
}

/* Add a new tracker*/
public String _add(String userid, JSONObject params) throws Exception {
	 String blgs =  params.get("blogs").toString();
	 String[] blogs = blgs.split(",");
	 int blognum = 0;
	 if(!blgs.equals("")) {
		 blognum = blogs.length;
	 }
	 
	 JSONObject param = new JSONObject();
	 param.put("userid",userid);
	 param.put("query", "blogsite_id in ("+params.get("blogs")+")");
	 param.put("tracker_name", params.get("trackername"));
	 param.put("description", params.get("description"));
	 param.put("blogsites_num", blognum);
	 
	 System.out.println(param);
	//JSONObject jsonObj = new JSONObject("{\"userid\":\"wizzletest\",\"query\":\"blogsite_id in (46,62,47,49,66,52,53,65,63,54)\",\"tracker_name\":\"Wizzle\",\"description\":\"Best blogs ever\",\"blogsites_num\":10}");
	 
	 String output = "false";
  String url = base_url+"trackers";
  URL obj = new URL(url);
  HttpURLConnection con = (HttpURLConnection) obj.openConnection();
  
  con.setDoOutput(true);
  con.setDoInput(true);
 
  con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
  con.setRequestProperty("Accept", "application/json");
  con.setRequestMethod("POST");
  
  OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
  wr.write(param.toString());
  wr.flush();
  
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
   System.out.println(myResponse);
   if(null!=myResponse.get("result")) {
	   	  output = "false";
   }else {
	   String res = myResponse.get("hits").toString();
	   if(res.equals("created")) {
		   output = "true";
	   }else {
		   output = "false";
	   }
   }
   
  return  output;
}



public ArrayList _getResult(String url, JSONObject jsonObj) throws Exception {
	URL obj = new URL(url);
    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
    
    con.setDoOutput(true);
    con.setDoInput(true);
   
    con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
    con.setRequestProperty("Accept", "application/json");
    con.setRequestMethod("POST");
    
    OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
    wr.write(jsonObj.toString());
    wr.flush();
    
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
     ArrayList<String> list = new ArrayList<String>(); 
     
     if(null!=myResponse.get("hits")) {
	     String res = myResponse.get("hits").toString();
	     JSONObject myRes1 = new JSONObject(res);
	      String total = myRes1.get("total").toString();
	      this.totalpost = total;
	    
	     JSONArray jsonArray = new JSONArray(myRes1.get("hits").toString()); 
	     
	     if (jsonArray != null) { 
	        int len = jsonArray.length();
	        for (int i=0;i<len;i++){ 
	         list.add(jsonArray.get(i).toString());
	        } 
	     }
     }
     
     return list;
}

public String _getTotal(String url, JSONObject jsonObj) throws Exception {
	String total  = "0";
	URL obj = new URL(url);
    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
    
    con.setDoOutput(true);
    con.setDoInput(true);
   
    con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
    con.setRequestProperty("Accept", "application/json");
    con.setRequestMethod("POST");
    
    OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
    wr.write(jsonObj.toString());
    wr.flush();
    
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
     ArrayList<String> list = new ArrayList<String>(); 
     
     if(null!=myResponse.get("hits")) {
	     String res = myResponse.get("hits").toString();
	     JSONObject myRes1 = new JSONObject(res);
	      total = myRes1.get("total").toString();  
     }
     
     return total;
}


}