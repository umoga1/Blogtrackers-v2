package handler;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import com.google.common.net.MediaType;

@Path("/request")
public class ResponseHandler {

	@GET
	@Produces()
	public String sayHello() {
		String response = "<?xml version='1.0'?>"+
							"<hello>Hello XML</hello>";
		return response;
		
	}
}
