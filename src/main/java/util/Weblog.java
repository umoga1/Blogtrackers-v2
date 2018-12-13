package util;

import java.util.ArrayList;

import authentication.*;

public class Weblog {
	public String  _addBlog(String username, String blog, String status) {
		String url = "";
		
		ArrayList bloggers = new DbConnection().query("SELECT * FROM user_blog WHERE userid='"+username+"' AND url ='"+blog+"'");
		
		if(bloggers.size() > 0) {
			
		}else {
		if(!(blog==null || blog =="")) {
			
			System.out.println("username is "+username+"blog of the owner is "+blog+ "Crawling status is "+status);
			url = "INSERT INTO user_blog(userid, url,status) VALUES('"+username+"', '"+blog+"', '"+status+"')";

			boolean done = new DbConnection().updateTable(url);
			System.out.println(done);
			if(done) {
				return url + "successfully added to Blogtrackers";
			}
		}
		return "Error while adding blog";
	}
		return null;
	}
}
