
package wrapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import util.Trackers;
import util.Blogposts;

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
                        
		}
	
		else if(action.equals("update")) {
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
		   		
		}else if(action.equals("delete")) {	
			try {
				String output = trk._delete(tracker_id);
				pww.write("true");
			}catch(Exception e) {
				 pww.write("false"); 
			 }	
		}else if(action.equals("removeblog")) {
			String ids= request.getParameter("blog_ids").replaceAll("\\<.*?\\>", "");
			try {
				String output = trk._removeBlogs(tracker_id,ids,username);
				pww.write(output);
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
									"	<td align=\"center\">"+bj.get("influence")+"</td>\r\n" + 
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
}


