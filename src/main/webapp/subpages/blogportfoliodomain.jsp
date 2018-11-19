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
	String date_start = (null == request.getParameter("date_start")) ? "" : request.getParameter("date_start");
	String date_end = (null == request.getParameter("date_end")) ? "" : request.getParameter("date_end");
	String blog_id = (null == request.getParameter("blog_id")) ? "" : request.getParameter("blog_id");
	

	if (user == null || user == "") {
		response.sendRedirect("index.jsp");
	} else {

			ArrayList<?> userinfo = null;
			String profileimage = "";
			String username = "";
			ArrayList outlinks = new ArrayList();
			
			Trackers tracker = new Trackers();
			Outlinks outl = new Outlinks();
		
			String ids = blog_id;
		

			outlinks = outl._searchByRange("date",date_start, date_end, ids);
			
		
			JSONObject outerlinks = new JSONObject();
			ArrayList outlinklooper = new ArrayList();
			if (outlinks.size() > 0) {
				int mm=0;
				for (int p = 0; p < outlinks.size(); p++) {
					String bstr = outlinks.get(p).toString();
					JSONObject bj = new JSONObject(bstr);
					bstr = bj.get("_source").toString();
					bj = new JSONObject(bstr);
					String link = bj.get("link").toString();
					
					JSONObject content = new JSONObject();
					String maindomain="";
					try {
						URI uri = new URI(link);
						String domain = bj.get("link").toString();
						if (domain.startsWith("www.")) {
							maindomain = domain.substring(4);
						} else {
							maindomain = domain;
						}
					} catch (Exception ex) {}
					maindomain = bj.get("domain").toString();
						if (outerlinks.has(link)) {
							content = new JSONObject(outerlinks.get(link).toString());
							
							int valu = Integer.parseInt(content.get("value").toString());
							valu++;
							
							content.put("value", valu);
							content.put("link", link);
							content.put("domain", maindomain);
							outerlinks.put(link, content);
						} else {
							int valu = 1;
							content.put("value", valu);
							content.put("link", link);
							content.put("domain", maindomain);
							outerlinks.put(link, content);
							outlinklooper.add(mm, link);
							mm++;
						}		
					
			}

		}
%>


									<%
										if (outlinklooper.size() > 0) {
													//System.out.println(bloggers);
													for (int y = 0; y < outlinklooper.size(); y++) {
														String key = outlinklooper.get(y).toString();
														JSONObject resu = outerlinks.getJSONObject(key);
									%>
									<tr>
									
										<td class=""><a href="<%=resu.get("link")%>" target="_blank"><%=resu.get("link")%></a></td>
									
										<td><%=resu.get("value")%></td>
									</tr>
									<% }}} %>