package util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;

import org.json.JSONObject;
import java.util.*;

import authentication.DbConnection;

import org.json.JSONArray;

import java.io.OutputStreamWriter;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class Comment {
	HashMap<String, String> hm = DbConnection.loadConstant();
	
	public String _getCommentById(String blog_ids) {
		String count = "";
		blog_ids = blog_ids.replaceAll(",$", "");
		blog_ids = blog_ids.replaceAll(", $", "");
		blog_ids = "("+blog_ids+")";
		
		try {
			ArrayList response = DbConnection.query("SELECT sum(comment_count) from comments where blogsite_id in "+blog_ids+" ");		
			if(response.size()>0){
			 	ArrayList hd = (ArrayList)response.get(0);
				count = hd.get(0).toString();
			}
		}catch(Exception e){
			System.out.print("Error in getBlogPostById");
		}
		return count;
	}

}
