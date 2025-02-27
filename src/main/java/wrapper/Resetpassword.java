
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

import util.Mailing;
import authentication.DbConnection;

/**
 * Servlet implementation class Login
 * @author Adewale
 */
@SuppressWarnings("unused")
@WebServlet("/forgotpassword")
public class Resetpassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Resetpassword() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		response.sendRedirect("forgotpassword.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		
		//authentication.Login auth = new authentication.Login();
		DbConnection dbinstance = new DbConnection();
		String submitted = request.getParameter("recover");
		PrintWriter pww = response.getWriter();
        HttpSession session = request.getSession();
		String app_url = request.getContextPath();
		
                //pww.write(email+":"+username+":"+pass+":"+submitted);
                    if(submitted!=null && submitted.equals("yes")){
                    	try {
			String email = request.getParameter("email");
			//System.out.println(email);
                        ArrayList prev = dbinstance.query("SELECT * FROM usercredentials WHERE Email = '"+email+"'");
                       // prev = (ArrayList)prev.get(0);
                      //  System.out.println(prev);
                        String[] receivers = {email};
                        if(prev.size()>0){
                        	prev = (ArrayList)prev.get(0);
                            double ran = Math.random();
                            String pass = dbinstance.md5Funct(ran+"");
                            pass = pass.substring(0,8);
                            boolean updated = dbinstance.updateTable("UPDATE usercredentials SET password  = '"+pass+"' WHERE Email = '"+email+"'");
                                if(updated){
                                session.setAttribute("success_message","A mail has been sent to "+email+" containing your login information");
                                try{
                                    Mailing.postMail(receivers, "Blogtrackers - Password Reset Information", "Hello "+prev.get(0)+", <br/><br/> Please note that your password has been changed to <b>"+pass+"</b>. <br/>You are strongly advised to change your password after first login. <br/>Kindly login at <a href='http://blogtrackers.host.ualr.edu/Blogtrackers/login.jsp'> Blogtrackers </a><br/><br/> Thanks for using Blogtrackers"); 
                                    response.sendRedirect("forgotpassword.jsp");
                                }catch(Exception e){
                                	response.setContentType("text/html");
                                    response.sendRedirect("login.jsp");
                                }
                            }else{
                                 session.setAttribute("error_message","invalid operation");
                                 response.sendRedirect("forgotpassword.jsp");
                                
                            }
                        }else{
                            session.setAttribute("error_message","invalid email address");
                            response.sendRedirect("forgotpassword.jsp");
 
                        }
                        
                    	}catch(Exception e) {
                    		session.setAttribute("error_message","invalid operation");
                    		response.setContentType("text/html");
                            response.sendRedirect("forgotpassword.jsp");
                    	}
                        
                    }
                    

		
	}
}
