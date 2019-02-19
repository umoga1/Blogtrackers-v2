
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.json.JSONObject;

import util.Blogs;
import authentication.DbConnection;
import java.util.*;

/**
 * 
 * Servlet implementation class Tracker
 * @author Adedayo Ayodele
 * 
 */
@WebServlet("/blogsite")
public class Blogsite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Blogsite() {
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
		 Blogs bs = new Blogs();  
		 
		 PrintWriter pww = response.getWriter();
		 HttpSession session = request.getSession();
			
		String username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username").toString();
		
		String userid = (null == session.getAttribute("userid")) ? "" : session.getAttribute("userid").toString();
		
        String blogsite_name = (null==request.getParameter("blogsite_name"))?"":request.getParameter("blogsite_name").replaceAll("\\<.*?\\>", "");
        String blogsite_url = (null==request.getParameter("blogsite_url"))?"":request.getParameter("blogsite_url");
        String action = (null==request.getParameter("action"))?"":request.getParameter("action");
        String blogsite_id = (null==request.getParameter("blogsite_id"))?"":request.getParameter("blogsite_id");
        
        
		if(action.equals("create"))
		{	
			
			JSONObject param = new JSONObject();
			 param.put("userid",userid);
			 param.put("blogsite_name", blogsite_name);
			 param.put("blogsite_url", blogsite_url);
			 
				
			try {
				String output = bs._add(userid,param);
				pww.write("true"); 
			}catch(Exception ex) {
				pww.write("false"); 
			}
			
			 
		}
		
		if(action.equals("delete"))
		{	
					 
			try {
				 	bs._delete(blogsite_id,userid);
					pww.write("true"); 
			}catch(Exception ex) {
					pww.write("false"); 
			}
		}

	}
	

	

	
}


