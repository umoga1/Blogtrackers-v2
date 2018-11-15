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

ArrayList allauthors=post._getBloggerByBloggerName("date",dt, dte,blogger.toString(),sort.toString(),"DESC");
%>
    <table id="DataTables_Table_0_wrapper" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Post title</th>
                                <th>Influence Score</th>
                            </tr>
                        </thead>
                        <tbody>
                                <%
                                if(allauthors.size()>0){							
									String tres = null;
									JSONObject tresp = null;
									String tresu = null;
									JSONObject tobj = null;
									int j=0;
									int k=0;
									for(int i=0; i< allauthors.size(); i++){
										tres = allauthors.get(i).toString();	
										tresp = new JSONObject(tres);
										tresu = tresp.get("_source").toString();
										tobj = new JSONObject(tresu);
										k++;
									%>
                                    <tr>
                                        <td><a  class="blogpost_link" id="<%=tobj.get("blogpost_id")%>" >#<%=(k)%>: <%=tobj.get("title") %></a></td>
                                        <td align="center"><%=tobj.get("influence_score") %></td>
                                    </tr>
                                    <% }} %>
                                </tbody>
                            </table>

