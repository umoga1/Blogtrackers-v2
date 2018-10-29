<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="util.*"%>
<%@page import="java.io.File"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.net.URI"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	Object tid = (null == request.getParameter("tid")) ? "" : request.getParameter("tid");
	
	
	Object user = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	String key= request.getParameter("key").replaceAll("\\<.*?\\>", "");
	String value= request.getParameter("value").replaceAll("\\<.*?\\>", "");
	String source = request.getParameter("source").replaceAll("\\<.*?\\>", "");
	String section = request.getParameter("section").replaceAll("\\<.*?\\>", "");
	String year = value;//request.getParameter("date").replaceAll("\\<.*?\\>", "");
	String blogids = request.getParameter("blog_ids");
	
	 String date_start = year + "-01-01";
	 String date_end = year + "-12-31";
	
	 ArrayList allauthors =new Blogposts()._getBloggerByBlogId("date",date_start, date_end,blogids);
		
	
%>



<table id="DataTables_Table_0_wrapper" class="display"
						style="width: 100%">
						<thead>
							<tr>
								<th class="bold-text">SN</th>
								<th class="bold-text">Post title</th>
								<th class="bold-text">Blogger</th>


							</tr>
						</thead>
						<tbody>
							
							<%	int y=0; if(allauthors.size()>0){
								String tres = null;
								JSONObject tresp = null;
								String tresu = null;
								JSONObject tobj = null;
								int j=0;
								int k=0;
								int n = 0;
								for(int i=0; i< allauthors.size(); i++){
									
											tres = allauthors.get(i).toString();			
											tresp = new JSONObject(tres);
										    tresu = tresp.get("_source").toString();
										    tobj = new JSONObject(tresu);
										    
										    String auth = tobj.get("blogger").toString();
										    String color="";
										    if(i%2==0){
										    	color="#CC3300";
										    }else if(i%3 ==0){
										    	color="#EE33FF";
										    }else if(i%7 ==0){
										    	color="#28a745";
										    }else if(i%11 ==0){
										    	color="#3728a7";
										    }else if(i%17 ==0){
										    	color="#17a2b8";
										    }else {
										    	color="#000000";
										    }
										    
										    y++;
					    %>
							<tr>
								<td align="center"><%=(y)%></td>
								<td><a syle="cursor:pointer" class="blogpost_link" id="<%=tobj.get("blogpost_id")%>-<%=color%>-<%=(y)%>" onclick="loadChart('<%=tobj.get("blogpost_id")%>-<%=color%>-<%=(y)%>')" style="color:<%=color%>"><%=tobj.get("title").toString() %></a></td>
								<td align="center"><%=tobj.get("blogger").toString() %></td>
							</tr>
						<% }} %>
							
							
						</tbody>
					</table>

