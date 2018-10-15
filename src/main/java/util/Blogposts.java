package util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL; 
import org.json.JSONObject;
import java.util.*;

import authentication.DbConnection;

import org.json.JSONArray;

import java.io.OutputStreamWriter;


import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class Blogposts {

	HashMap<String, String> hm = DbConnection.loadConstant();		

//	String base_url = hm.get("elasticIndex")+"post1/"; //- For live deployment
	String base_url = hm.get("elasticIndex")+"blogposts/"; // - For testing server 
	
	String totalpost;
	String date;

	public ArrayList _list(String order, String from, String sortby) throws Exception {
		int size = 5;

		int fr = 0;
		JSONObject jsonObj = new JSONObject("{\r\n" + 
				"    \"query\": {\r\n" + 
				"        \"match_all\": {}\r\n" + 
				"    },\r\n" + 
				"	\"sort\":{\r\n" + 
				"		\""+sortby+"\":{\r\n" + 
				"			\"order\":\""+order+"\"\r\n" + 
				"			}\r\n" + 
				"		}\r\n" + 
				"}");

		if(!from.equals("")) {
			fr = Integer.parseInt(from)*size;
			jsonObj = new JSONObject("{\r\n" + 
					"    \"query\": {\r\n" + 
					"        \"match_all\": {}\r\n" + 
					"    },\r\n" + 	  		
					"  	\"from\":"+fr+"," + 
					"	\"size\":"+size+"," + 
					"   \"sort\":{\r\n" + 
					"		\""+sortby+"\":{\r\n" + 
					"			\"order\":\""+order+"\"\r\n" + 
					"			}\r\n" + 
					"		},\r\n" + 
					"}");

		}


		String url = base_url+"_search?size="+size+"&from="+fr;   
		return this._getResult(url, jsonObj);
	}

	public String _getTotal() {
		return this.totalpost;
	}


	
	public ArrayList _getBloggerByBlogId(String field,String greater, String less,String blog_ids) throws Exception {
		String url = base_url+"_search?size=200";
		String[] args = blog_ids.split(","); 
		JSONArray pars = new JSONArray(); 
		ArrayList<String> ar = new ArrayList<String>();	
		for(int i=0; i<args.length; i++){
			pars.put(args[i].replaceAll(" ", ""));
		}

		String arg2 = pars.toString();
		//String que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"blogsite_id\":"+arg2+"}}}},\"sort\":{\"date\":{\"order\":\"ASC\"}}}";
		String que="{\r\n" + 
				"  \"query\": {\r\n" + 
				"    \"bool\": {\r\n" + 
				"      \"must\": [\r\n" + 
				"        {\r\n" + 
				"		  \"constant_score\":{\r\n" + 
				"					\"filter\":{\r\n" + 
				"							\"terms\":{\r\n" + 
				"							\"blogsite_id\":"+arg2+"\r\n" + 
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
		ArrayList result =  this._getResult(url, jsonObj);
		return this._getResult(url, jsonObj);
	}
	
	public String _getDate(String blog_ids,String type) throws Exception {
		String url = base_url+"_search?size=1";
		String dt = "";
		String[] args = blog_ids.split(","); 
		JSONArray pars = new JSONArray(); 
		ArrayList<String> ar = new ArrayList<String>();	
		for(int i=0; i<args.length; i++){
			pars.put(args[i].replaceAll(" ", ""));
		}

		String arg2 = pars.toString();
		String que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"blogsite_id\":"+arg2+"}}}},\"sort\":{\"date\":{\"order\":\"DESC\"}}}";		
		
		if(type.equals("first")) {
			que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"blogsite_id\":"+arg2+"}}}},\"sort\":{\"date\":{\"order\":\"ASC\"}}}";
		}

		JSONObject jsonObj = new JSONObject(que);
		ArrayList result =  this._getResult(url, jsonObj);
		if(result.size()>0) {
			String bres = result.get(0).toString();
			JSONObject bresp = new JSONObject(bres);
			String bresu = bresp.get("_source").toString();
			JSONObject bobj = new JSONObject(bresu);
			String[] date=bobj.get("date").toString().split(" ");
			dt = date[0];
		}
		return dt;
	}

	public ArrayList _search(String term,String from,String sortby) throws Exception {

		int size = 5;
		int fr = 0;
		JSONObject jsonObj = new JSONObject("{\r\n" + 
				"  \"query\": {\r\n" + 
				"        \"query_string\" : {\r\n" + 
				"            \"fields\" : [\"title\",\"blogger\",\"post\"],\r\n" + 
				"            \"query\" : \""+term+"\"\r\n" + 
				"        }\r\n" + 
				"  },\r\n" + 
				"   \"sort\":{\r\n" + 
				"		\""+sortby+"\":{\r\n" + 
				"			\"order\":\"DESC\"\r\n" + 
				"			}\r\n" + 
				"		}\r\n" + 
				"}");


		if(!from.equals("")) {
			fr = Integer.parseInt(from)*size;
			jsonObj = new JSONObject("{\r\n" + 
					"  \"query\": {\r\n" + 
					"        \"query_string\" : {\r\n" + 
					"            \"fields\" : [\"title\",\"blogger\",\"post\"],\r\n" + 
					"            \"query\" : \""+term+"\"\r\n" + 
					"        }\r\n" + 
					"  },\r\n" +
					"  	\"from\":"+from+"," + 
					"	\"size\":"+size+"," + 
					"   \"sort\":{\r\n" + 
					"		\""+sortby+"\":{\r\n" + 
					"			\"order\":\"DESC\"\r\n" + 
					"			}\r\n" + 
					"		},\r\n" + 
					"}");
		}

		if(from.equals("date")) {
			jsonObj = new JSONObject("{\r\n" + 
					"  \"query\": {\r\n" + 
					"        \"query_string\" : {\r\n" + 
					"            \"fields\" : [\"title\",\"blogger\",\"post\"],\r\n" + 
					"            \"query\" : \""+term+"\"\r\n" + 
					"        }\r\n" + 
					"  },\r\n" +
					"   \"sort\":{\r\n" + 
					"		\"blogpost_id\":{\r\n" + 
					"			\"order\":\"DESC\"\r\n" + 
					"			}\r\n" + 
					"		},\r\n" + 
					" \"range\":{\r\n" + 
					"		\"date\":{\r\n" + 
					"			\"lte\":\""+from+"\",\r\n" + 
					"			\"gte\":\""+0+"\"\r\n" + 
					"			}\r\n" + 
					"		}\r\n" + 
					"}");
		}
		String url = base_url+"_search?size="+size+"&from="+fr; 
		//System.out.println(url);
		return this._getResult(url, jsonObj);
	}

	public ArrayList _getPostByBlogger(String blogger)throws Exception {
		JSONObject jsonObj = new JSONObject("{\r\n" + 
				"  \"query\": {\r\n" + 
				"        \"query_string\" : {\r\n" + 
				"            \"fields\" : [\"blogger\"],\r\n" + 
				"            \"query\" : \""+blogger+"\"\r\n" + 
				"        }\r\n" + 
				"  },\r\n" + 
				"   \"sort\":{\r\n" + 
				"		\"date\":{\r\n" + 
				"			\"order\":\"DESC\"\r\n" + 
				"			}\r\n" + 
				"		}\r\n" + 
				"}");
		String url = base_url+"_search?size=10";
		return this._getResult(url, jsonObj);
	}
	
	/* Fetch posts by blog ids*/
	public String _getTotalByBlogId(String blog_ids,String from) throws Exception {
		String url = base_url+"_search?size=1";
		String[] args = blog_ids.split(","); 
		JSONArray pars = new JSONArray(); 
		for(int i=0; i<args.length; i++){
			pars.put(args[i].replaceAll(" ", ""));
		}

		String arg2 = pars.toString();
		String que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"blogsite_id\":"+arg2+"}}}}}";

		JSONObject jsonObj = new JSONObject(que);
		ArrayList result =  this._getResult(url, jsonObj);
		return this.totalpost;
	}
	
	/* Fetch posts by blog ids*/
	public String _getTotalByBlogger(String blogger,String field,String greater, String less) throws Exception {
		String url = base_url+"_search?size=1";
		//String que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"blogger\":"+blogger+"}}}}}";

		//JSONObject jsonObj = new JSONObject(que);
		
		JSONObject jsonObj = new JSONObject("{\r\n" + 
				"  \"query\": {\r\n" + 
				"        \"query_string\" : {\r\n" + 
				"            \"fields\" : [\"blogger\"],\r\n" + 
				"            \"query\" : \""+blogger+"\"\r\n" + 
				"        }\r\n" + 
				"  },\r\n" +
				"   \"sort\":{\r\n" + 
				"		\"blogpost_id\":{\r\n" + 
				"			\"order\":\"DESC\"\r\n" + 
				"			}\r\n" + 
				"		},\r\n" + 
				" \"range\":{\r\n" + 
				"		\"date\":{\r\n" + 
				"			\"lte\":\""+greater+"\",\r\n" + 
				"			\"gte\":\""+less+"\"\r\n" + 
				"			}\r\n" + 
				"		}\r\n" + 
				"}");
		
		return this._getTotal(url, jsonObj);
	}

	/* Fetch posts by blog ids*/
	public ArrayList _getPostByBlogId(String blog_ids,String from) throws Exception {
		String url = base_url+"_search?size=10";
		String[] args = blog_ids.split(","); 
		JSONArray pars = new JSONArray(); 
		ArrayList<String> ar = new ArrayList<String>();	
		for(int i=0; i<args.length; i++){
			pars.put(args[i].replaceAll(" ", ""));
		}

		String arg2 = pars.toString();
		String que = "{\"query\": {\"constant_score\":{\"filter\":{\"terms\":{\"blogsite_id\":"+arg2+"}}}}}";

		JSONObject jsonObj = new JSONObject(que);
		ArrayList result =  this._getResult(url, jsonObj);
		return this._getResult(url, jsonObj);
	}





	public String _searchRangeTotal(String field,String greater, String less, String blog_ids) throws Exception {
		String[] args = blog_ids.split(","); 
		JSONArray pars = new JSONArray(); 
		ArrayList<String> ar = new ArrayList<String>();	
		for(int i=0; i<args.length; i++){
			pars.put(args[i].replaceAll(" ", ""));
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
				"							\"blogsite_id\":"+arg2+"\r\n" + 
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
	

	public String _searchRangeTotalByBLogger(String field,String greater, String less, String blogger) throws Exception {
		String[] args = blogger.split(","); 
		JSONArray pars = new JSONArray(); 
		ArrayList<String> ar = new ArrayList<String>();	
		for(int i=0; i<args.length; i++){
			pars.put(args[i].replaceAll(" ", ""));
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
				"							\"blogger\":"+arg2+"\r\n" + 
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

	public String _searchRangeTotal(String field,String greater, String less, String date_from, String date_to, String blog_ids) throws Exception {
		String[] args = blog_ids.split(","); 
		JSONArray pars = new JSONArray(); 
		ArrayList<String> ar = new ArrayList<String>();	
		for(int i=0; i<args.length; i++){
			pars.put(args[i].replaceAll(" ", ""));
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
				"							\"blogsite_id\":"+arg2+"\r\n" + 
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
		JSONObject jsonObj = new JSONObject("{\r\n" + 
				"  \"query\": {\r\n" + 
				"    \"constant_score\":{\r\n" + 
				"			\"filter\":{\r\n" + 
				"					\"terms\":{\r\n" + 
				"							\"blogpost_id\":[\""+ids+"\"]\r\n" + 
				"							}\r\n" + 
				"					}\r\n" + 
				"				}\r\n" + 
				"    }\r\n" + 
				"}");


		String url = base_url+"_search?size=20";
		return this._getResult(url, jsonObj);

	}
	
	public ArrayList _getPost(String key, String value) throws Exception {
		JSONObject jsonObj = new JSONObject("{\r\n" + 
				"  \"query\": {\r\n" + 
				"    \"constant_score\":{\r\n" + 
				"			\"filter\":{\r\n" + 
				"					\"terms\":{\r\n" + 
				"							\""+key+"\":[\""+value+"\"]\r\n" + 
				"							}\r\n" + 
				"					}\r\n" + 
				"				}\r\n" + 
				"    }\r\n" + 
				"}");


		String url = base_url+"_search?size=10";
		return this._getResult(url, jsonObj);

	}

	public ArrayList _getResult(String url, JSONObject jsonObj) throws Exception {
		ArrayList<String> list = new ArrayList<String>();
		try {
		URL obj = new URL(url);
	    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	    
	    con.setDoOutput(true);
	    con.setDoInput(true);
	   
	    con.setRequestProperty("Content-Type", "application/json; charset=utf-32");
	    con.setRequestProperty("Content-Type", "application/json");
	    con.setRequestProperty("Accept-Charset", "UTF-32");
	    con.setRequestProperty("Accept", "application/json");
	    con.setRequestMethod("POST");
	    
	    DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	    
	    
	    //OutputStreamWriter wr1 = new OutputStreamWriter(con.getOutputStream());
	    wr.write(jsonObj.toString().getBytes());
	    wr.flush();
	    
	    int responseCode = con.getResponseCode();  
	    BufferedReader in = new BufferedReader(
	         new InputStreamReader(con.getInputStream()));
	    String inputLine;
	    StringBuffer response = new StringBuffer();
	    
	    while ((inputLine = in.readLine()) != null) {
	     	response.append(inputLine);
	     	//System.out.println(inputLine);
	     	
	     }
	     in.close();
	     
	     JSONObject myResponse = new JSONObject(response.toString());
	    
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
		}catch(Exception ex) {}
	     return list;
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
	
	public JSONArray _sortJson(JSONArray yearsarray) {
	JSONArray sortedyearsarray = new JSONArray();
	List<String> jsonList = new ArrayList<String>();
	for (int i = 0; i < yearsarray.length(); i++) {
	    jsonList.add(yearsarray.get(i).toString());
	}
	
	Collections.sort( jsonList, new Comparator<String>() {
	    public int compare(String a, String b) {
	        String valA = new String();
	        String valB = new String();

	        try {
	            valA = (String) a;
	            valB = (String) b;
	        } 
	        catch (Exception e) {
	            //do something
	        }
	        return valA.compareTo(valB);
	    }
	});
	
	for (int i = 0; i < yearsarray.length(); i++) {
	    sortedyearsarray.put(jsonList.get(i));
	}
		return sortedyearsarray;
	}

}