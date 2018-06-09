<%@page import="java.util.*"%>
<%@ page import="javax.servlet.http.*" %>
<%@page import="util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
	Object url = (null == request.getParameter("url")) ? "" : request.getParameter("url");
	//System.out.println(url);
   if (url!="") {
	   //url="https://www.lindaikejisblog.com/2018/6/kim-kardashians-birthday-message-to-kanye-west-acknowledges-all-hes-been-through-this-year.html";
	   String res = new ImageLoader().getUrl(url.toString());
 %>
 <%=res%>
 <%
   }else{ %>
   empty
 <%          
   }
%>
