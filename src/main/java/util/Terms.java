package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL; 
import org.json.JSONObject;

import authentication.DbConnection;

import org.json.JSONArray;

import java.io.OutputStreamWriter;


import java.util.ArrayList;
import java.util.HashMap;

public class Terms {

	HashMap<String, String> hm = DbConnection.loadConstant();		
	
	String base_url = hm.get("elasticIndex")+"terms/";
	String totalpost;		    
	   
public ArrayList _list(String order, String from) throws Exception {	 
	 JSONObject jsonObj = new JSONObject("{\r\n" + 
		 		"    \"query\": {\r\n" + 
		 		"        \"match_all\": {}\r\n" + 
		 		"    },\r\n" + 
		 		"	\"sort\":{\r\n" + 
		 		"		\"id\":{\r\n" + 
		 		"			\"order\":\""+order+"\"\r\n" + 
		 		"			}\r\n" + 
		 		"		}\r\n" + 
		 		"}");
	 
	 if(!from.equals("")) {
		  jsonObj = new JSONObject("{\r\n" + 
		  		"    \"query\": {\r\n" + 
		  		"        \"match_all\": {}\r\n" + 
		  		"    },\r\n" + 
		  		"	\"sort\":{\r\n" + 
		  		"		\"id\":{\r\n" + 
		  		"			\"order\":\"DESC\"\r\n" + 
		  		"			}\r\n" + 
		  		"		},\r\n" + 
		  		"	\"range\":{\r\n" + 
		  		"		\"id\":{\r\n" + 
		  		"			\"lte\":\""+from+"\",\r\n" + 
		  		"			\"gte\":\""+0+"\"\r\n" + 
		  		"			}\r\n" + 
		  		"		}\r\n" + 
		  		"}");
		 
	 }
	 
	 
     String url = base_url+"_search?size=100";
     return this._getResult(url, jsonObj);   
    }

public String _getTotal() {
	return this.totalpost;
}



public ArrayList _searchByRange(String field,String greater, String less, String blog_ids) throws Exception {
	
/*
	blog_ids = blog_ids.replaceAll(",$", "");
	blog_ids = blog_ids.replaceAll(", $", "");
	blog_ids = "("+blog_ids+")";
	int size = 20;
	ArrayList response =new ArrayList();
	DbConnection db = new DbConnection();
	String count = "0";	
	System.out.println("SELECT term,frequency,date,blogpostid,id,blogsiteid FROM terms WHERE blogsiteid IN "+blog_ids+" AND date>='"+greater+"' AND date <='"+less+"' GROUP BY(term) ORDER BY frequency DESC LIMIT "+size+"");
	
	try {
		//response = db.queryJSON("SELECT term,frequency,date,blogpostid,id,blogsiteid FROM terms WHERE blogsiteid IN "+blog_ids+" AND date>='"+greater+"' AND date <='"+less+"' GROUP BY(term) ORDER BY frequency DESC LIMIT "+size+"");
		response = db.queryJSON("SELECT term,frequency,date,blogpostid,id,blogsiteid FROM terms WHERE blogsiteid IN "+blog_ids+" GROUP BY(term) LIMIT "+size+"");
		 
		
	}catch(Exception e){
		return response;
	}
	
	
	return response;
	*/
	
	String[] args = blog_ids.split(","); 
	
	 JSONArray pars = new JSONArray(); 
	 ArrayList<String> ar = new ArrayList<String>();	
	 for(int i=0; i<args.length; i++){
		 pars.put(args[i].replaceAll(" ", ""));
	 }
	 String arg2 = pars.toString();
	 /*
	 String que ="{\r\n" + 
	 		"	\"size\":20,\r\n" +
	 		"	\"query\": { \r\n" + 
	 		"			 \"bool\": {\r\n" + 
	 		"				      \"must\": [\r\n" + 
	 		"				      	{\r\n" + 
	 		"						  \"constant_score\":{ \r\n" + 
	 		"									\"filter\":{ \r\n" + 
	 		"											\"terms\":{ \r\n" + 
	 		"												\r\n" + 
	 		"											\""+field+"\":"+arg2+"\r\n"+
	 		"													}\r\n" + 
	 		"											}\r\n" + 
	 		"										} \r\n" + 
	 		"						}, \r\n" + 
	 		"	 		        { \r\n" + 
	 		"	 				  \"range\" : { \r\n" + 
	 		"	 		            \"date\" : { \r\n" + 
	 		"	 		                \"gte\" : "+greater+",\r\n"+
	 		"	 		                \"lte\" : "+less+"\r\n" + 
	 		"	 						}\r\n" + 
	 		"	 					} \r\n" + 
	 		"	 				} \r\n" + 
	 		"	 		      ] \r\n" + 
	 		"	 		    } \r\n" + 
	 		"	 		  } \r\n" + 
	 		"	 		}";
*/
	 
		JSONObject jsonObj  = new JSONObject("{\r\n" + 
				"       \"query\": {\r\n" + 
				"          \"bool\": { \r\n" + 
				"               \"must\": {\r\n" + 
		 		"						  \"constant_score\":{ \r\n" + 
		 		"									\"filter\":{ \r\n" + 
		 		"											\"terms\":{ \r\n" + 
		 		"											\""+field+"\":"+arg2+"\r\n"+
		 		"													}\r\n" + 
		 		"											}\r\n" + 
		 		"										} \r\n" + 
				"                },\r\n" + 
				"                \"filter\": {\r\n" + 
				"                    \"range\" : {\r\n" + 
				"                        \"date\" : {\r\n" + 
				"                            \"gte\": \""+greater+"\",\r\n" + 
				"                            \"lte\": \""+less+"\"\r\n" + 
				"                        }\r\n" + 
				"                    }\r\n" + 
				"                }\r\n" + 
				"            }\r\n" + 
				"        },\r\n" + 
				"		\"sort\":{\r\n" + 
				"		\"frequency\":{\r\n" + 
				"			\"order\":\"DESC\"\r\n" + 
				"			}\r\n" + 
				"		},\r\n" +
				"    	\"aggregations\": {\r\n" + 
		 		"        	\"term\": {\r\n" + 
		 		"            \"terms\": {\r\n" + 
		 		"                \"field\": \"term\",\r\n" + 
		 		"                \"size\": 200\r\n" + 
		 		"            }\r\n" + 
		 		"        	}\r\n" + 
		 		"    	}\r\n"+
				"    }");
		
    String url = base_url+"_search";
    return this._getResult(url,jsonObj);
    
    
}

public ArrayList _search(String term,String from) throws Exception {
	 JSONObject jsonObj = new JSONObject("{\r\n" + 
	 		"  \"query\": {\r\n" + 
	 		"        \"query_string\" : {\r\n" + 
	 		"            \"fields\" : [\"blogsite_name\",\"blogsite_authors\"],\r\n" + 
	 		"            \"query\" : \""+term+"\"\r\n" + 
	 		"        }\r\n" + 
	 		"  },\r\n" + 
	 		"   \"sort\":{\r\n" + 
	 		"		\"blogsite_id\":{\r\n" + 
	 		"			\"order\":\"DESC\"\r\n" + 
	 		"			}\r\n" + 
	 		"		}\r\n" + 
	 		"}");
	
	 
    String url = base_url+"_search?size=200";
    if(!from.equals("")) {
    	jsonObj = new JSONObject("{\r\n" + 
    			"  \"query\": {\r\n" + 
    			"        \"query_string\" : {\r\n" + 
	 		    "            \"fields\" : [\"blogsite_name\",\"blogsite_authors\"],\r\n" +
    			"            \"query\" : \""+term+"\"\r\n" + 
    			"        }\r\n" + 
    			"  },\r\n" + 
    			"   \"sort\":{\r\n" + 
    			"		\"blogpost_id\":{\r\n" + 
    			"			\"order\":\"DESC\"\r\n" + 
    			"			}\r\n" + 
    			"		},\r\n" + 
    			" \"range\":{\r\n" + 
    			"		\"blogpost_id\":{\r\n" + 
    			"			\"lte\":\""+from+"\",\r\n" + 
		  		"			\"gte\":\""+0+"\"\r\n" + 
    			"			}\r\n" + 
    			"		}\r\n" + 
    			"}");
    } 
    
    
    
    return this._getResult(url, jsonObj);
}

public String _searchRangeAggregate(String field,String greater, String less, String terms) throws Exception {
	String[] args = terms.split(","); 
	JSONArray pars = new JSONArray(); 
	ArrayList<String> ar = new ArrayList<String>();	
	for(int i=0; i<args.length; i++){
		pars.put(args[i].toLowerCase());
	}

	String arg2 = pars.toString();
	// String range = "\"range\" : {\"sentiment\" : {\"gte\" : "+greater+",\"lte\" : "+less+"}}";

	
	String que="{\r\n" + 
			"  \"query\": {\r\n" + 
			"    \"bool\": {\r\n" + 
			"      \"must\": [\r\n" + 
			"        {\r\n" + 
			"		  \"constant_score\":{\r\n" + 
			"					\"filter\":{\r\n" + 
			"							\"terms\":{\r\n" + 
			"							\"term\":"+arg2+"\r\n" + 
			"									}\r\n" + 
			"							}\r\n" + 
			"						}\r\n" + 
			"		},\r\n" + 
			"        {\r\n" + 
			"		  \"range\" : {\r\n" + 
			"            \""+field+"\" : {\r\n" + 
			"                \"gte\" : "+greater+",\r\n" + 
			"                \"lte\" : "+less+",\r\n" + 
			"				},\r\n" +
			"			}\r\n" + 
			"		}\r\n" + 
			"      ]\r\n" + 
			"    }\r\n" + 
			"  },\r\n" + 
			"    \"aggs\" : {\r\n" + 
			"        \"total\" : { \"sum\" : { \"field\" : \"frequency\" } }\r\n" + 
			"    }\r\n" + 
			"}";


	JSONObject jsonObj = new JSONObject(que);

	String url = base_url+"_search?size=1";
	return this._getAggregate(url,jsonObj);
}

public String _searchRangeTotal(String field,String greater, String less, String terms) throws Exception {
	String[] args = terms.split(","); 
	JSONArray pars = new JSONArray(); 
	ArrayList<String> ar = new ArrayList<String>();	
	for(int i=0; i<args.length; i++){
		pars.put(args[i].toLowerCase());
	}

	String arg2 = pars.toString();
	// String range = "\"range\" : {\"sentiment\" : {\"gte\" : "+greater+",\"lte\" : "+less+"}}";
	String que="{\r\n" + 
			"  \"query\": {\r\n" + 
			"    \"bool\": {\r\n" + 
			"      \"must\": [\r\n" + 
			"        {\r\n" + 
			"		  \"constant_score\":{\r\n" + 
			"					\"filter\":{\r\n" + 
			"							\"terms\":{\r\n" + 
			"							\"term\":"+arg2+"\r\n" + 
			"									}\r\n" + 
			"							}\r\n" + 
			"						}\r\n" + 
			"		},\r\n" + 
			"        {\r\n" + 
			"		  \"range\" : {\r\n" + 
			"            \""+field+"\" : {\r\n" + 
			"                \"gte\" : "+greater+",\r\n" + 
			"                \"lte\" : "+less+",\r\n" + 
			"				},\r\n" +
			"			}\r\n" + 
			"		}\r\n" + 
			"      ]\r\n" + 
			"    }\r\n" + 
			"  }\r\n" + 
			"}";
	JSONObject jsonObj = new JSONObject(que);

	String url = base_url+"_search";
	return this._getTotal(url,jsonObj);
}


public ArrayList _fetch(String ids) throws Exception {
	 ArrayList result = new ArrayList();
	 String[] args = ids.split(",");
	 
	 JSONArray pars = new JSONArray(); 
	 ArrayList<String> ar = new ArrayList<String>();	
	 for(int i=0; i<args.length; i++){
		 pars.put(args[i].replaceAll(" ", ""));
	 }
	 
	 String arg2 = pars.toString();

	// String que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"blogsiteid\":"+arg2+"}}}}}";
	 String que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"id\":"+arg2+"}}}},\"sort\":{\"date\":{\"order\":\"DESC\"}}}";

		
	JSONObject jsonObj = new JSONObject(que);
	String url = base_url+"_search";
	return this._getResult(url, jsonObj);
	   
}

public ArrayList _getMostUsed(String blog_ids) throws Exception { 
	ArrayList mostactive = new ArrayList();
	ArrayList terms = this._fetch(blog_ids);

	if (terms.size() > 0) {
		String bres = null;
		JSONObject bresp = null;
		
		String bresu = null;
		JSONObject bobj = null;
		bres = terms.get(0).toString();
			bresp = new JSONObject(bres);
			bresu = bresp.get("_source").toString();
			bobj = new JSONObject(bresu);
			mostactive.add(0, bobj.get("term").toString()); 
			mostactive.add(1, bobj.get("frequency").toString());	
	}
	return mostactive;		
}

public ArrayList _getResult(String url, JSONObject jsonObj) throws Exception {
	
	   ArrayList<String> list = new ArrayList<String>(); 
	   try {
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
	   
	  // int responseCode = con.getResponseCode();
	   
	   BufferedReader in = new BufferedReader(
	        new InputStreamReader(con.getInputStream()));
	   String inputLine;
	   StringBuffer response = new StringBuffer();
	   
	   while ((inputLine = in.readLine()) != null) {
	    	response.append(inputLine);
	    }
	    in.close();
	    
	    JSONObject myResponse = new JSONObject(response.toString());
	    
	    if(null!=myResponse.get("hits")) {
		     String res = myResponse.get("hits").toString();
		     JSONObject myRes1 = new JSONObject(res);	    
		     JSONArray jsonArray = new JSONArray(myRes1.get("hits").toString()); 	     
		     if (jsonArray != null) { 
		        int len = jsonArray.length();
		        for (int i=0;i<len;i++){ 
		         list.add(jsonArray.get(i).toString());
		        } 
		     }
	    }
	}catch(Exception ex) {}
	   return  list;
}


public String _getTotal(String url, JSONObject jsonObj) throws Exception {
	String total = "0";
	try {
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
	ArrayList<String> list = new ArrayList<String>(); 
	//System.out.println(myResponse.get("hits"));
	if(null!=myResponse.get("hits")) {
		String res = myResponse.get("hits").toString();
		JSONObject myRes1 = new JSONObject(res);          
		total = myRes1.get("total").toString();              
	}
	}catch(Exception ex) {}
	return  total;
}



public String _getAggregate(String url, JSONObject jsonObj) throws Exception {
	String total = "0";
	try {
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
	ArrayList<String> list = new ArrayList<String>(); 
	//System.out.println(myResponse.get("hits"));
	if(null!=myResponse.get("aggregations")) {
		String res = myResponse.get("aggregations").toString();
		JSONObject myRes1 = new JSONObject(res); 
		
		
		String res2 = myRes1.get("total").toString();
		
		JSONObject myRes2 = new JSONObject(res2);   
		total = myRes2.get("value").toString(); 
	}
	}catch(Exception ex) {}
	return  total;
}


public Integer getTermOcuurence(String term,String start_date,String end_date) {
	String tres = null;
	JSONObject tresp = null;
	String tresu = null;
	JSONObject tobj = null;								
	int alloccurence = 0;
	int k=0;
	Blogposts post = new Blogposts();
	try {
	ArrayList allposts =  post._searchByTitleAndBody(term,"date", start_date,end_date);//term._searchByRange("date",dt,dte, tm,"term","10");
	
	for(int i=0; i< allposts.size(); i++){
		tres = allposts.get(i).toString();	
		tresp = new JSONObject(tres);									
		tresu = tresp.get("_source").toString();
		tobj = new JSONObject(tresu);
		
		
				
				int bodyoccurencece = 0;//ut.countMatches(tobj3.get("post").toString(), mostactiveterm);
				
		        String str = tobj.get("post").toString()+" "+ tobj.get("post").toString();
		        str = str.toLowerCase();
		        term = term.toLowerCase();
		        String findStr = term;
				int lastIndex = 0;
				//int count = 0;

				while(lastIndex != -1){

				    lastIndex = str.indexOf(findStr,lastIndex);

				    if(lastIndex != -1){
				        bodyoccurencece++;
				        alloccurence+=bodyoccurencece;
				        lastIndex += findStr.length();
				    }
				    
				    
				    
				}
		}
	}catch(Exception ex) {}
	return alloccurence;
}


}