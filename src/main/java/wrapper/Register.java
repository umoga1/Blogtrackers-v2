
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

import authentication.DbConnection;

/**
 * 
 * Servlet implementation class Register
 * @author Adedayo Ayodele
 * 
 */
@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Register() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
		response.setContentType("text/html");    
		response.sendRedirect("register.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		//System.out.println("post request");
		String email = request.getParameter("email").replaceAll("\\<.*?\\>", "");
        String name = request.getParameter("name").replaceAll("\\<.*?\\>", "");
        String password = request.getParameter("password").replaceAll("\\<.*?\\>", "");
        String type ="";// request.getParameter("user_type").replaceAll("\\<.*?\\>", "");
        String submitted = request.getParameter("register");
        String signin = request.getParameter("signin");
        
        DbConnection dbinstance = new DbConnection();
                
		PrintWriter pww = response.getWriter();
		HttpSession session = request.getSession();
		
		if(submitted.equals("yes"))
		{			
			
			ArrayList login = dbinstance.query("SELECT Email FROM usercredentials where Email = '"+email+"' ");
		
			if(login.size()>0)
			{
				  response.setContentType("text/html");
	              pww.write("exists"); 
	              
	              if(signin.equals("yes")) {
	                  session.setAttribute("email",email);
	              }
	              
			}
			else
			{

				 
				
				String digest =dbinstance.md5Funct(password);
				String query_string ="insert into usercredentials (UserName, Email, Password, MessageDigest, user_type,first_name,last_name,phone_number,address,profile_picture,last_updated,added_by,date_added ) VALUES ('"+email+"','"+email+"','"+password+"','"+digest+"','"+type+"','"+name+"','','','','','','','')";
				//System.out.println(query_string);
				boolean inserted = dbinstance.updateTable(query_string);  
				 if(inserted) {
					 if(signin.equals("yes")) {
		                  session.setAttribute("email",email);
		              }
		              
					 response.setContentType("text/html");
		             pww.write("success"); 
				 }else {
					 if(signin.equals("yes")) {
		                  session.setAttribute("email",email);
		              }
		              
					 response.setContentType("text/html");
		             pww.write("success"); 
				 }
				
			}
                        
		}


	}
}
