package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL; 
import org.json.JSONObject;
import org.json.JSONArray;

import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.*;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime; 

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
	 
	 String urll = base_url+"_search?size=5";  
	 JSONObject jsonObj2 = new JSONObject("{\r\n" + 
	 		"    \"query\" : {\r\n" + 
	 		"        \"match_all\" : {}\r\n" + 
	 		"    }\r\n" + 
	 		"}");
		
	 
	 String next = this._getTotal(urll, jsonObj2);
	 int tidd = Integer.parseInt(next)+1;
	 
	 
	 System.out.println(tidd);
	 
	 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	 LocalDateTime now = LocalDateTime.now();  
	   //System.out.println(dtf.format(now));  
	 
	 JSONObject param = new JSONObject();
	 param.put("userid",userid);
	 param.put("query", "blogsite_id in ("+params.get("blogs")+")");
	 param.put("tracker_name", params.get("trackername"));
	 param.put("description", params.get("description"));
	 param.put("blogsites_num", blognum);	
	 param.put("tid", tidd);
	 param.put("date_modified",dtf.format(now));
	 param.put("date_created",dtf.format(now));
	 System.out.println(param);
	 
	 //System.out.println(param);
	//JSONObject jsonObj = new JSONObject("{\"userid\":\"wizzletest\",\"query\":\"blogsite_id in (46,62,47,49,66,52,53,65,63,54)\",\"tracker_name\":\"Wizzle\",\"description\":\"Best blogs ever\",\"blogsites_num\":10}");	 
	 String output = "false";
	 String url = base_url+"trackers";	 
	 JSONObject myResponse = this._runUpdate(url, param);
	  System.out.println(myResponse);
	  if(null==myResponse.get("result")) {
		   	  output = "false";
	   }else {
		   String resv = myResponse.get("result").toString();
		   System.out.println(resv);
		   if(resv.equals("created")) {
			   output = "true";
		   }else {
			   output = "false";
		   }
	   } 
	  System.out.println(output);
	  return output;
}


/* Add a new tracker*/
public String _delete(String trackerid) throws Exception {
	
	
	
	ArrayList<?> detail = this._fetch(trackerid);
	 System.out.println(detail);
	 if(detail.size()>0){		
			String res = detail.get(0).toString();		
			JSONObject resp = new JSONObject(res);
			String tid = resp.get("_id").toString();
			//tid = "4qSen2QBCl8_4DKPZSTm";
			String url = base_url+"trackers/"+tid;
			this._runDelete(url);
			return "true";
	 }
	 
	 return "false";

}

/* Add a new tracker*/
public String _update(String trackerid, JSONObject params) throws Exception {
	 String blgs =  params.get("blogs").toString();
	 String[] blogs = blgs.split(",");
	 int blognum = 0;
	 System.out.println("To Merged:"+blgs);
	 
	 
	 String output = "false";
	 ArrayList<?> detail = this._fetch(trackerid);
	 System.out.println(detail);
	 if(detail.size()>0){		
			String res = detail.get(0).toString();		
			JSONObject resp = new JSONObject(res);
			String tid = resp.get("_id").toString(); 
		    String resu = resp.get("_source").toString();
		    JSONObject obj = new JSONObject(resu);		     	     
		    String quer = obj.get("query").toString();
		   		  
		    	
			 quer = quer.replaceAll("blogsite_id in ", "");
			 quer = quer.replaceAll("\\(", "");			 
			 quer = quer.replaceAll("\\)", "");
			 String[] blogs2 = quer.split(",");
			 
			 System.out.println(quer);
			 //System.out.println("Bid"+);
			 
			 if(blogs.length>0) {
				 System.out.println("Bid"+blogs[0]);
			    	String bid = blogs[0].trim();
			    	for(int b=0; b<blogs2.length; b++) {
			    		String b2id = blogs2[b].trim();
			    		 //System.out.println(b2id.equals(bid));
			    		if(b2id.equals(bid)) {
			    			
			    			return "false";
			    		}
			    	}
			  }
			 
			 String mergedblogs = this.mergeArrays(blogs, blogs2);
			 String[] allblogs = mergedblogs.split(",");
			 blognum = allblogs.length;
			 
			 
			 JSONObject param = new JSONObject();
			 //param.put("userid",userid);
			 param.put("query", "blogsite_id in ("+mergedblogs+")");
			 if(params.has("trackername")) {
				 param.put("tracker_name", params.get("trackername"));
			 }
			 if(params.has("description")) {
				 param.put("description", params.get("description"));
			 }
			 
			 if(params.has("userid")) {
				 param.put("userid", params.get("userid"));
			 }
			 
			 param.put("blogsites_num", blognum);
			 
			 //System.out.println(param);
			//JSONObject jsonObj = new JSONObject("{\"userid\":\"wizzletest\",\"query\":\"blogsite_id in (46,62,47,49,66,52,53,65,63,54)\",\"tracker_name\":\"Wizzle\",\"description\":\"Best blogs ever\",\"blogsites_num\":10}");
			 	 
			 String url = base_url+"trackers/"+tid+"/_update";
			 
			 JSONObject jsonObj = new JSONObject("{\r\n" + 
			    		"    \"script\" : \"ctx._source.query = '"+param.get("query")+"'; ctx._source.blogsites_num= '"+param.get("blogsites_num")+"';\",\r\n" + 
			    		"}");
			 JSONObject myResponse = this._runUpdate(url, jsonObj);	
			 //this._delete(trackerid);
			 if(null==myResponse.get("result")) {
				   	  output = "false";
			   }else {
				   String resv = myResponse.get("result").toString();
				   if(resv.equals("updated")) {
					   output = "true";
				   }else {
					   output = "false";
				   }
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


/* Update tracker*/
public JSONObject _runUpdate(String url, JSONObject jsonObj) throws Exception {
	URL obj = new URL(url);
	System.out.println(url);
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
	   return  myResponse;
}


/* Delete tracker*/
public void _runDelete(String url) throws Exception {
	URL obj = new URL(url);
	System.out.println(url);
    HttpURLConnection con = (HttpURLConnection) obj.openConnection(); 
    con.setDoOutput(true);
    con.setDoInput(true);
    con.setRequestMethod("DELETE");    
    OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream());
    int responseCode = con.getResponseCode();  
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

	public String mergeArrays(String[] arr1, String[] arr2){
		String bracketed_result = "";
		String[] merged = new String[arr1.length + arr2.length];
	    System.arraycopy(arr1, 0, merged, 0, arr1.length);
	    System.arraycopy(arr2, 0, merged, arr1.length, arr2.length);
	
	    Set<String> nodupes = new HashSet<String>();
	
	    for(int i=0;i<merged.length;i++){
	        nodupes.add(merged[i]);
	        bracketed_result+=merged[i].trim()+",";
	    }
	
	    String[] nodupesarray = new String[nodupes.size()];
	    int i = 0;
	    Iterator<String> it = nodupes.iterator();
	    while(it.hasNext()){
	        nodupesarray[i] = it.next();
	        
	        i++;
	    }
	
		    return bracketed_result.replaceAll(",$", "");
	}
	


}