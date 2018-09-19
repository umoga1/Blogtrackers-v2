package handler;

import javax.print.attribute.standard.Media;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

@Path("/request")
public class Plugin {

	@GET
	@Path("/request")
	@Produces(MediaType.TEXT_XML)
	public String sayHello() {
		String resource = null;
		return resource;
	}
	
	@Produces(MediaType.APPLICATION_JSON)
	public String sayHelloToJSON() {
		String resource = "I am here";
		return resource;
	}
	
	
	@Produces(MediaType.TEXT_HTML)
	public String  sayHelloHTML(@QueryParam("name") String name, @QueryParam("Card no") String Card_no, @QueryParam("amount") int amount) {
		System.out.println("Name is "+name);
		System.out.println("Amount is "+ amount);
		String response = null;
		
		if(amount > 20) {
			System.out.println("Amount is greater than 20");
		}else {
			System.out.println("What is happening ");
			response="You are granted";
		}
		return "<html>"+"<title>"+"Credit card amount for  "+name+ "</title>"+"<body><h1>"+response+"</h1></body>" + "</html>";
	}
	
	
}
