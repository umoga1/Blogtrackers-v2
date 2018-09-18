
package wrapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import org.json.JSONObject;

import util.Trackers;
import util.Blogposts;
import authentication.DbConnection;
import java.util.*;

/**
 * 
 * Servlet implementation class Register
 * @author Adedayo Ayodele
 * 
 */
@WebServlet("/tracker")
public class Tracker extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Tracker() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
		response.setContentType("text/html");    
		response.sendRedirect("trackerlist.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		 Trackers trk = new Trackers();  
		 Blogposts bp = new Blogposts();  
		 
		 PrintWriter pww = response.getWriter();
		 HttpSession session = request.getSession();
			
		String username = session.getAttribute("username").toString();
		
        String tracker_name = (null==request.getParameter("name"))?"":request.getParameter("name").replaceAll("\\<.*?\\>", "");
        String description = (null==request.getParameter("description"))?"":request.getParameter("description").replaceAll("\\<.*?\\>", "");
        String blogs = (null==request.getParameter("blogs"))?"":request.getParameter("blogs").replaceAll("\\<.*?\\>", "");
        String tracker_id = (null==request.getParameter("tracker_id"))?"":request.getParameter("tracker_id").replaceAll("\\<.*?\\>", "");
		
        String query = "";
		String action = (null==request.getParameter("action"))?"":request.getParameter("action");
		
		if(action.equals("create"))
		{	
			/*
			if(blogs.length()<1) {
				 response.setContentType("text/html");				 
			     pww.write("blog cannot be empty"); 
			}else {
			 			
			 JSONObject param = new JSONObject();
			 param.put("trackername", tracker_name);
			 param.put("description", description);
			 param.put("blogs", blogs);			 
			 String output =  "false";
			 try {
				 output = trk._add(username, param);
				 response.setContentType("text/html");				 
			     pww.write(output); 
			 }catch(Exception e) {}		 
				 response.setContentType("text/html");				 
			     pww.write(output); 
			}       
			*/
			String userName = (String) session.getAttribute("username");
			String userid = (String) session.getAttribute("user");
			     	
			//String keyword = request.getParameter("keyword");
			String trackerName=tracker_name.trim();//request.getParameter("title");
			if(!trackerName.trim().isEmpty()){

				String trackerDescription=description;//request.getParameter("descr");
				String createdDate= getDateTime();
				String selected = blogs;//request.getParameter("sites");
				//session.setAttribute("searched", "about "+keyword);
				//selected = selected.tr
				String[] selectedSite = selected.split(","); 
				String listString = "";
				if(selectedSite.length>0){
					for (int i = 0; i < selectedSite.length; i++) { 
						listString += selectedSite[i] + ",";
					}
					listString="blogsite_id in ("+listString.substring(0, listString.length()-1)+")";
				}else{
					listString="blogsite_id in (0)";
				}
				//TrackerDialog dialog= new TrackerDialog();
				//dialog.addTracker(userName, trackerName, createdDate, null, listString, trackerDescription, selectedSite.length);
				ArrayList prev = new DbConnection().query("SELECT * FROM trackers WHERE tracker_name='"+trackerName+"' AND userid= '"+userid+"'");
				//System.out.println("Previous:"+trackerName+" "+prev);
				if(prev!=null && prev.size()>0) {
					pww.write("tracker already exist");
				}else {	
				   query="INSERT INTO trackers(userid,tracker_name,date_created,date_modified,query,description,blogsites_num) VALUES('"+userid+"', '"+trackerName+"', '"+createdDate+"', "+ null+", '"+listString+"', '"+trackerDescription+"', '"+selectedSite.length+"')";
					boolean done = new DbConnection().updateTable(query);
					if(done) {
					  	ArrayList trackers = new DbConnection().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
	                	session.setAttribute("trackers", trackers+"");
	                	session.setAttribute("initiated_search_term", "");
						response.setContentType("text/html");
						pww.write("success");
					}else {
						response.setContentType("text/html");
						pww.write("full failure");
					}
				}
			}
			else{
				response.setContentType("text/html");
				pww.write("Trackername cannot be empty");
			}
		}
	
		else if(action.equals("update")) {
			 String[] bloggs = blogs.split(",");
			/*
			 JSONObject param = new JSONObject();		
			 param.put("blogs", blogs);			 
			 String output =  "false";
			 try {
				 output = trk._update(tracker_id, param);		
				 response.setContentType("text/html");				 
			     pww.write(output); 
			 }catch(Exception e) {
				 System.out.println("Error");
				 pww.write("false"); 
			 }		
		   	*/
			try {
				ArrayList tracker =null;
				String blog_id = request.getParameter("blog_id");
				
				DbConnection db = new DbConnection();
				String addendum="";
					 tracker = db.query("SELECT query FROM trackers WHERE tid='"+tracker_id+"'");
					 if(tracker.size()>0){
						 	ArrayList hd = (ArrayList)tracker.get(0);
							String que = hd.get(0).toString();
							
							 que = que.replaceAll("blogsite_id in ", "");
							 que = que.replaceAll("\\(", "");			 
							 que = que.replaceAll("\\)", "");
							 String[] blogs2 = que.split(",");
							 
							 
							 String mergedblogs = this.mergeArrays(bloggs, blogs2);
							 String[] allblogs = mergedblogs.split(",");
							 int blognum = allblogs.length;
							
														 
							addendum = "blogsite_id in ("+mergedblogs+")";//"blogsite_id in ("+addendum+blog_id+")";				
							db.updateTable("UPDATE trackers SET query='"+addendum+"', tracker_name='"+tracker_name+"', decription='"+description+"', blogsites_num = '"+blognum+"' WHERE  tid='"+tracker_id+"'");	
						
					 }
					
				
				
	        	pww.write("success");
	        	
			}catch(Exception ex) {
				pww.write("false"); 
			}
		}else if(action.equals("delete")) {
			/*
			try {
				String output = trk._delete(tracker_id);
				pww.write("true");
			}catch(Exception e) {
				 pww.write("false"); 
			 }*/	
			try {
					String tid = request.getParameter("tracker_id");
					new DbConnection().updateTable("DELETE FROM trackers WHERE  tid='"+tracker_id+"'");						
					String userid = (String) session.getAttribute("user");
					ArrayList trackers = new DbConnection().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
		        	//session.setAttribute("trackers", trackers);
		       		pww.write("true");
				}catch(Exception ex) {
					 pww.write("false"); 
				}			
				
		}else if(action.equals("removeblog")) {
			String ids= request.getParameter("blog_ids").replaceAll("\\<.*?\\>", "");
			/*
			try {
				String output = trk._removeBlogs(tracker_id,ids,username);
				pww.write(output);
			}catch(Exception e) {
				 pww.write("false"); 
			 }	
			 */
			try {
			DbConnection db = new DbConnection();
			String[] bloggs = ids.split(",");
			JSONObject jblog = new JSONObject();
			String output = "false";
			
			for(int k=0; k<bloggs.length; k++) {
				jblog.put(bloggs[k], bloggs[k]);
			}
			 
			ArrayList detail = new DbConnection().query("SELECT * FROM trackers WHERE tid='"+tracker_id+"'");
        	
			 if(detail.size()>0){
				 	ArrayList hd = (ArrayList)detail.get(0);
					String que = hd.get(0).toString();
					
					 que = que.replaceAll("blogsite_id in ", "");
					 que = que.replaceAll("\\(", "");			 
					 que = que.replaceAll("\\)", "");
					 String[] blogs2 = que.split(",");
					 
					 String mergedblogs = "";	
					 int blogcounter=0;
					 for(int j=0; j<blogs2.length; j++) {
						 if(!jblog.has(blogs2[j])) {
							 if(j<(blogs2.length-1))
								 mergedblogs+=blogs2[j]+",";
							 else
								 mergedblogs+=blogs2[j];
							 blogcounter++;
						 }
					 }
					 			
					que =  "blogsite_id in ("+mergedblogs+")";			 
					db.updateTable("UPDATE trackers SET query='"+que+"', blogsites_num = '"+blogcounter+"' WHERE  tid='"+tracker_id+"'");	
					pww.write("success");
			 }else {
				 pww.write("false");
			 }
			}catch(Exception e) {
				 pww.write("false"); 
			}	
			 
			 			
		}else if(action.equals("fetchpost")) {
			String key= request.getParameter("key").replaceAll("\\<.*?\\>", "");
			String value= request.getParameter("value").replaceAll("\\<.*?\\>", "");
			String source = request.getParameter("source").replaceAll("\\<.*?\\>", "");
			String section = request.getParameter("section").replaceAll("\\<.*?\\>", "");
			String output="";
			try {
				ArrayList posts = bp._getPost(key,value);
				if(posts.size()>0){
					//pww.write(posts+"");
					if(source.equals("influence") && section.equals("detail_table")) {

						for (int p = 0; p < posts.size(); p++) {
							String bstr = posts.get(p).toString();
							JSONObject bj = new JSONObject(bstr);
							bstr = bj.get("_source").toString();
							bj = new JSONObject(bstr);
							//System.out.println(bj.get("body"));
							
							output+="<h5 class='text-primary p20 pt0 pb0'>#1: "+bj.get("title").toString()+"</h5>" + 
									"					<div class='text-center mb20 mt20'>" + 
									"						<button class='btn stylebuttonblue'>" + 
									"							<b class='float-left ultra-bold-text'>"+bj.get("blogger").toString()+"</b> <i" + 
									"								class='far fa-user float-right blogcontenticon'></i>" + 
									"						</button>" + 
									"						<button class='btn stylebuttonnocolor'>"+bj.get("date").toString()+"</button>" + 
									"						<button class='btn stylebuttonorange'>" + 
									"							<b class='float-left ultra-bold-text'>"+bj.get("num_comments").toString()+" comments</b><i" + 
									"								class='far fa-comments float-right blogcontenticon'></i>" + 
									"						</button>" + 
									"					</div>" + 
									"					<div class='p20 pt0 pb20 text-blog-content text-primary'" + 
									"						style='height: 600px; overflow-y: scroll;'>" + 
									"						"+bj.get("post").toString()+""+ 
									"						</div>";
									
							
						}
						
						
						pww.write(output+"");
					}else if(source.equals("influence") && section.equals("influential_table")) {
						output+="<p>\r\n" + 
								"Influential Blog Posts of <b class=\"text-blue\">"+value+"</b> and <b\r\n" + 
								"					</p>\r\n" + 
								"					<table id=\"DataTables_Table_0_wrapper\" class=\"display\"\r\n" + 
								"						style=\"width: 100%\">\r\n" + 
								"						<thead>\r\n" + 
								"							<tr>\r\n" + 
								"								<th class=\"bold-text text-primary\">Post title</th>\r\n" + 
								"								<th class=\"bold-text text-primary\">Influence Score</th>\r\n" + 
								"\r\n" + 
								"\r\n" + 
								"		</tr>\r\n" + 
								"	</thead>\r\n" + 
								"<tbody>";
						for (int p = 0; p < posts.size(); p++) {
							String bstr = posts.get(p).toString();
							JSONObject bj = new JSONObject(bstr);
							bstr = bj.get("_source").toString();
							bj = new JSONObject(bstr);
							
							output+="<tr>\r\n" + 
									"	<td><a href=\"#\" class=\"blogpost_link\" id=\""+bj.get("blogpost_id")+"\" >#"+(p+1)+": "+bj.get("title")+"</a></td>\r\n" + 
									"	<td align=\"center\">"+bj.get("influence_score")+"</td>\r\n" + 
									"</tr>";
						}
						
						output+="</tbody></table>";
						pww.write(output+"");
					}
				}else {
					pww.write("No Post found");
				}	
			}catch(Exception e) {
				 pww.write("error"); 
			 }	
			
		}

	}
	
	private String mergeArrays(String[] arr1, String[] arr2){
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
	
	private String getDateTime() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		return dateFormat.format(date);
	}
	
}


