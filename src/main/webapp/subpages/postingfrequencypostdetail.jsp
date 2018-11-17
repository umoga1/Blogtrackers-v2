<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="util.*"%>
<%@page import="java.io.File"%>
<%@page import="util.Blogposts"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Object date_start = (null == request.getParameter("date_start")) ? "" : request.getParameter("date_start");
Object date_end = (null == request.getParameter("date_end")) ? "" : request.getParameter("date_end");

Object blogger = (null == request.getParameter("blogger")) ? "" : request.getParameter("blogger");

Object blog_id = (null == request.getParameter("blog_id")) ? "" : request.getParameter("blog_id");
Object action = (null == request.getParameter("action")) ? "" : request.getParameter("action");
Object sort = (null == request.getParameter("sort")) ? "" : request.getParameter("sort");

String bloggerstr = blogger.toString().replaceAll("_"," ");

Blogposts post  = new Blogposts();
ArrayList allentitysentiments = new ArrayList(); 


String dt = date_start.toString();
String dte = date_end.toString();
String year_start="";
String year_end="";	

if(action.toString().equals("gettotal")){
%>	
<%=post._searchRangeTotalByBlogger("date", dt, dte, blogger.toString())%>
<%}else if(action.toString().equals("gettotalinfluence")){%>
<%=post._searchRangeAggregateByBloggers("date", dt, dte, blogger.toString())%>	
<% }else{
ArrayList allauthors=post._getBloggerByBloggerName("date",dt, dte,blogger.toString(),sort.toString(),"DESC");
%>

<%
                                if(allauthors.size()>0){							
									String tres = null;
									JSONObject tresp = null;
									String tresu = null;
									JSONObject tobj = null;
									int j=0;
									int k=0;
									for(int i=0; i< 1; i++){
										tres = allauthors.get(i).toString();	
										tresp = new JSONObject(tres);
										tresu = tresp.get("_source").toString();
										tobj = new JSONObject(tresu);
										k++;
									%>                                    
                                    <h5 class="text-primary p20 pt0 pb0"><%=tobj.get("title")%></h5>
										<div class="text-center mb20 mt20">
											<button class="btn stylebuttonblue">
												<b class="float-left ultra-bold-text"><%=tobj.get("blogger")%></b> <i
													class="far fa-user float-right blogcontenticon"></i>
											</button>
											<button class="btn stylebuttonnocolor"><%=tobj.get("date")%></button>
											<button class="btn stylebuttonorange">
												<b class="float-left ultra-bold-text"><%=tobj.get("num_comments")%> comments</b><i
													class="far fa-comments float-right blogcontenticon"></i>
											</button>
										</div>
										<div style="height: 600px;">
										<div class="p20 pt0 pb20 text-blog-content text-primary"
											style="height: 550px; overflow-y: scroll;">
											<%=tobj.get("post")%>
										</div>
										</div>                      
                     		<% }} %>
                               
<% } %>