package handler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import authentication.DbConnection;
import util.Trackers;

/**
 * Servlet implementation class CreateTracker
 */
@WebServlet("/api/deletetracker")
public class DeleteTracker extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteTracker() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 *  * @ params
	 * 
	 String tracker_id
	 String userid 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String usession = (null==request.getHeader("session"))?"":request.getHeader("session").trim();
		String key= (null == session.getAttribute("key")) ? "" : session.getAttribute("key").toString();
		
		PrintWriter pww = response.getWriter();
		pww.write("In delete tracker endpoint \n");
		String data = "";   
	    StringBuilder builder = new StringBuilder();
	    BufferedReader reader = request.getReader();
	    String line;
	    while ((line = reader.readLine()) != null) {
	        builder.append(line);
	    }
	    data = builder.toString();
	    JSONObject object = null;
	    try {
	    	object = new JSONObject(data);	
	    	
	    }catch (Exception e) {
			// TODO: handle exception
	    	pww.write("error");
		}
	    
	    pww.write(object.getInt("userid"));
	    if(usession.equals(key) && !key.equals("")){ //check if supplied session key is valid
			pww.write("\n Validated the user session \n");
	    }
	    
	    String userid = object.getString("userid");
	    
	    pww.write("The userid is "+userid);
	    
	    try {
	    	object = new JSONObject(data);	
	    	Trackers t = new Trackers();
	    	t._delete(object.getString("tracker_id"));
	    	pww.write("success");
	    }catch (Exception e) {
	    	pww.write("error");
		}
    	
	    //ArrayList prev = new DbConnection().query("SELECT * FROM trackers WHERE tracker_name='"+trackerName+"' AND userid= '"+userid+"'");
		
	  
	    
		// TODO Auto-generated method stub
	}

}
