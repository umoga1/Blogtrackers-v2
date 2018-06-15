<%@page import="authentication.*"%>
<%@page import="util.Blogposts"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%
Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

if (email == null || email == "") {
	response.sendRedirect("index.jsp");
}else{

  int perpage =12;
  PrintWriter pww = response.getWriter();
 
	try {
		System.out.println("b4");
		String submitted = request.getParameter("load");
	    if(submitted!=null && submitted.equals("yes")){	
	        
	        String cpage = request.getParameter("from");
	        int from = Integer.parseInt(cpage);
	       
			Blogposts post  = new Blogposts();
			String term =  request.getParameter("term");
			ArrayList results = null;
			if(term.equals("")){
				results = post._list("DESC",cpage);
			}else{
				results = post._search(term,cpage);
			}
			
			if(results.size()>0){
				for(int i=0; i< results.size(); i++){
					String res = results.get(i).toString();
					
					JSONObject resp = new JSONObject(res);
				    String resu = resp.get("_source").toString();
				     JSONObject obj = new JSONObject(resu);
				     
				     String pst = obj.get("post").toString();
				     if(pst.length()>120){
				    	 pst = pst.substring(0,120);
				     }
					
		%>
		<div class="card noborder curved-card mb30" >
		<div class="text-center"><i class="fas text-medium pt40 fa-check text-light-color icon-big2 cursor-pointer" title="Select to Track Blog"></i></div>
		<h4 class="text-primary text-center p10 pt20"><a href="<%=request.getContextPath()%>/blogpostpage.jsp?p=<%=obj.get("blogpost_id")%>"><%=obj.get("title") %></a></h4>
		<div class="text-center"><button class="btn btn-primary stylebutton7">TRACKING</button> <button class="btn btn-primary stylebutton8">0 Tracks</button></div>
		  <div class="card-body">
		    <a href="<%=request.getContextPath()%>/blogpostpage.jsp?p=<%=obj.get("blogpost_id")%>"><h5 class="card-title text-primary text-center pb20"><%=pst+"..."%></h5></a>
		    <p class="card-text text-center author mb0 light-text"><%=obj.get("blogger") %></p>
		    <p class="card-text text-center postdate light-text"><%=obj.get("date") %></p>
		  </div>
		 <img class="postimage card-img-top pt30 pb30" id="<%=obj.get("blogpost_id")%>" src=""  alt="<%=obj.get("permalink") %>">
  
		<div class="text-center"><i class="far fa-heart text-medium pb30  favorites-text icon-big favoritestoggle cursor-pointer" data-toggle="tooltip" data-placement="top" title="Add to Favorites"></i></div>
		</div>

		<%}
		}else{ 
			pww.write("empty");
	  }
	}
	} catch (Exception ex) {}		
}
%>            
