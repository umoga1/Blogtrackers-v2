
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
                        
		}else if(action.equals("update")) {
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
			
		}

	}
}


