<%@page import="java.io.PrintWriter"%>
<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="util.*"%>
<%@page import="java.io.File"%>

<%@page import="util.*"%>
<%@page import="java.text.NumberFormat" %>
<%@page import="java.util.Locale" %>

<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
 <%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String username ="";
Blogs blogs  = new Blogs();
Blogposts post  = new Blogposts();
Trackers trackers  = new Trackers();
ArrayList mytrackers = new ArrayList();
ArrayList<?> userinfo = new ArrayList();
userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = 'nihal@gmail.com'");
username = (null==userinfo.get(0))?"":userinfo.get(0).toString();
//post = post._list("DESC","","date"));
%>
<p></p>
</body></html>