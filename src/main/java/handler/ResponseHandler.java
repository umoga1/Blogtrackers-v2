
package handler;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import org.json.JSONObject;

import authentication.DbConnection;
import util.Blogposts;
import util.Trackers;

import java.util.*;

/**
 * 
 * Servlet implementation class Login
 * @author Adewale
 * 
 */
@WebServlet("/request")
public class ResponseHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ResponseHandler() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           

		String username = request.getParameter("email").trim();
		String pass = request.getParameter("password").trim();
		String submitted = request.getParameter("madeRequest");
		
		PrintWriter pww = response.getWriter();
		{			
			ArrayList login = new DbConnection().query("SELECT * FROM usercredentials where Email = '"+username+"' AND Password = '"+pass+"'");
			
			if(login.size()>0)
			{
			  		
				HttpSession session = request.getSession();
				ArrayList userinfo = (ArrayList<?>)login.get(0);
				String user = (null==userinfo.get(0))?"":userinfo.get(0).toString();
				session.setAttribute("email",username);
				session.setAttribute("username",user);
				response.setStatus(200);
				pww.write("success");		
			}
		}
	
	}
	
	public ArrayList getTrackers() {
		ArrayList trackerlist = new ArrayList();
		try {
			trackerlist = new DbConnection().query("select * from trackers where userid = ? ");				
		} catch (Exception ex) {}
		
		return trackerlist;
	}

	//hello there
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		


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
