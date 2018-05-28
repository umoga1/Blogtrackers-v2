
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
        String pass = request.getParameter("password").replaceAll("\\<.*?\\>", "");
        String type ="";// request.getParameter("user_type").replaceAll("\\<.*?\\>", "");
        String submitted = request.getParameter("register").replaceAll("\\<.*?\\>", "");
                
		PrintWriter pww = response.getWriter();
		HttpSession session = request.getSession();
		
		if(submitted.equals("yes"))
		{			
			ArrayList login = new DbConnection().query("SELECT * FROM usercredentials where Email = '"+email+"' ");
			
			if(login.size()>0)
			{
				  response.setContentType("text/html");
	              pww.write("exists"); 
	              
			}
			else
			{

				 
				 pass = new DbConnection().md5Funct(pass);
				 new DbConnection().query("INSER INTO usercredentials(Email,first_name,Password,MessageDigest) VALUES('"+email+"','"+name+"', '"+pass+"','"+type+"','')");				
				 response.setContentType("text/html");
	             pww.write("success"); 
				
			}
                        
		}


	}
}
