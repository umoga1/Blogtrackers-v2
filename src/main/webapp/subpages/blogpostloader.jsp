<%@page import="authentication.*"%>
<%@page import="util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%
  Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
  Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
  String sort =  (null == request.getParameter("sortby")) ? "date" : request.getParameter("sortby");


  Trackers trackers  = new Trackers();
  JSONObject myblogs = new JSONObject();
  Blogs blogs  = new Blogs();
  int perpage =12;
  PrintWriter pww = response.getWriter();
 
	try {

		String submitted = request.getParameter("load");		
	    if(submitted!=null && submitted.equals("yes")){	
	        
	        String cpage = request.getParameter("from");
	        int from = Integer.parseInt(cpage);
	       
			Blogposts post  = new Blogposts();
			String term =  request.getParameter("term");
			ArrayList results = null;
						
			
			

			if(term.equals("")){
				results = post._list("DESC","",sort);
			}else{
				results = post._search(term,"",sort);
			}
			
			myblogs = trackers.getMyTrackedBlogs(username.toString());
			
			if(results.size()>0){
				String res = null;
				JSONObject resp = null;
				String resu = null;
				JSONObject obj = null;
				int totalpost = 0;
				String bres = null;
				JSONObject bresp = null;
				String bresu =null;
				JSONObject bobj =null;
					for(int i=0; i< results.size(); i++){
						String blogtitle="";
					
						 res = results.get(i).toString();
						
						 resp = new JSONObject(res);
					     resu = resp.get("_source").toString();
					     obj = new JSONObject(resu);
					     String blogid = obj.get("blogsite_id").toString();
					     String[] dt = obj.get("date").toString().split("T");
					     
					     String pst = obj.get("post").toString().replaceAll("[^a-zA-Z]", " ");
					     if(pst.length()>120){
					    	 pst = pst.substring(0,120);
					     }

						 ArrayList blog = blogs._fetch(blogid);

						 if( blog.size()>0){
									 bres = blog.get(0).toString();			
									 bresp = new JSONObject(bres);
									 bresu = bresp.get("_source").toString();
									 bobj = new JSONObject(bresu);
									 blogtitle = bobj.get("blogsite_name").toString();
									 
							 }
					     String totaltrack  = trackers.getTotalTrack(blogid);
					     %>
		<div class="card noborder curved-card mb30" >

		<div class="curved-card selectcontainer border-white">
		<% if(!username.equals("") || username.equals("")){ %>
		 <div class="text-center"><i class="fas text-medium pt40 fa-check text-light-color icon-big2 cursor-pointer trackblog blog_id_<%=blogid%>" data-toggle="tooltip" data-placement="top"  title="Select to Track Blog"></i></div>
		<% } %>
		  <h4 class="text-primary text-center p10 pt20 posttitle"><a class="blogname-<%=blogid%>" href="<%=request.getContextPath()%>/blogpostpage.jsp?p=<%=obj.get("blogpost_id")%>"><%=blogtitle%></a></h4>
		  
		 <div class="text-center mt10 mb10 trackingtracks"><% if(myblogs.has(blogid)){ %><button class="btn btn-primary stylebutton7">TRACKING</button><% } %> <button class="btn btn-primary stylebutton8"><%=totaltrack%> Tracks</button></div>
		 

		 
		  <div class="card-body">
		    <a href="<%=request.getContextPath()%>/blogpostpage.jsp?p=<%=obj.get("blogpost_id")%>"><h4 class="card-title text-primary text-center pb20 bold-text post-title"><%=obj.get("title").toString().replaceAll("[^a-zA-Z]", " ") %></h4></a>
		    <p class="card-text text-center author mb0 light-text"><%=obj.get("blogger") %></p>
		    <p class="card-text text-center postdate light-text"><%=dt[0]%></p>
		  </div>
		  
		  <div class="<%=obj.get("blogpost_id")%>">
		  <input type="hidden" class="post-image" id="<%=obj.get("blogpost_id")%>" name="pic" value="<%=obj.get("permalink") %>">
		  </div>
		  
		  <div class="text-center"><i class="far fa-heart text-medium pb30  favorites-text icon-big favoritestoggle cursor-pointer" data-toggle="tooltip" data-placement="top" title="Add to Favorites"></i></div>
		</div>
		
		</div>
		


		

		<%}
		}else{ 
			pww.write("empty");
	  }
	}
} catch (Exception ex) {}		

%>            
