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
<%@page import="java.time.LocalDateTime"%>
	
<%
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	Object tid = (null == request.getParameter("tid")) ? "" : request.getParameter("tid");

	Object user = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object date_start = (null == request.getParameter("date_start")) ? "" : request.getParameter("date_start");
	Object date_end = (null == request.getParameter("date_end")) ? "" : request.getParameter("date_end");
	Object single = (null == request.getParameter("single_date")) ? "" : request.getParameter("single_date");
	String sort =  (null == request.getParameter("sortby")) ? "blog" : request.getParameter("sortby").toString().replaceAll("[^a-zA-Z]", " ");

	
	//System.out.println(date_start);
	if (user == null || user == "") {
		response.sendRedirect("index.jsp");
	} else {

		ArrayList<?> userinfo = null;
		String profileimage = "";
		String username = "";
		String name = "";
		String phone = "";
		String date_modified = "";
		ArrayList detail = new ArrayList();
		ArrayList termss = new ArrayList();
		ArrayList outlinks = new ArrayList();
		ArrayList influentialp = new ArrayList();

		Trackers tracker = new Trackers();
		Terms term = new Terms();
		Outlinks outl = new Outlinks();
		if (tid != "") {
			detail = tracker._fetch(tid.toString());
			//System.out.println(detail);
		} else {
			detail = tracker._list("DESC", "", user.toString(), "1");
			//System.out.println("List:"+detail);
		}
		
		
		boolean isowner = false;
		JSONObject obj = null;
		String ids = "";
		String trackername="";
		if (detail.size() > 0) {
			//String res = detail.get(0).toString();
			ArrayList resp = (ArrayList<?>)detail.get(0);

			String tracker_userid = resp.get(0).toString();
			trackername = resp.get(2).toString();
			//if (tracker_userid.equals(user.toString())) {
				isowner = true;
				String query = resp.get(5).toString();//obj.get("query").toString();
				query = query.replaceAll("blogsite_id in ", "");
				query = query.replaceAll("\\(", "");
				query = query.replaceAll("\\)", "");
				ids = query;
			//}
		}
		
		userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = '" + email + "'");
		if (userinfo.size() < 1 || !isowner) {
			response.sendRedirect("index.jsp");
		} else {
			userinfo = (ArrayList<?>) userinfo.get(0);
			try {
					username = (null == userinfo.get(0)) ? "" : userinfo.get(0).toString();
	
					name = (null == userinfo.get(4)) ? "" : (userinfo.get(4).toString());
					email = (null == userinfo.get(2)) ? "" : userinfo.get(2).toString();
					phone = (null == userinfo.get(6)) ? "" : userinfo.get(6).toString();
					String userpic = userinfo.get(9).toString();
					String path = application.getRealPath("/").replace('\\', '/') + "images/profile_images/";
					String filename = userinfo.get(9).toString();
	
					profileimage = "images/default-avatar.png";
					if (userpic.indexOf("http") > -1) {
						profileimage = userpic;
					}
	
					File f = new File(filename);
					if (f.exists() && !f.isDirectory()) {
						profileimage = "images/profile_images/" + userinfo.get(2).toString() + ".jpg";
					}
			} catch (Exception e) {
			
			}

			String[] user_name = name.split(" ");
			Blogposts post = new Blogposts();
			Blogs blog = new Blogs();
			Sentiments senti = new Sentiments();

			//Date today = new Date();
			SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MMM d, yyyy");
			SimpleDateFormat DATE_FORMAT2 = new SimpleDateFormat("yyyy-MM-dd");

			SimpleDateFormat DAY_ONLY = new SimpleDateFormat("dd");
			SimpleDateFormat MONTH_ONLY = new SimpleDateFormat("MM");
			SimpleDateFormat SMALL_MONTH_ONLY = new SimpleDateFormat("mm");
			SimpleDateFormat WEEK_ONLY = new SimpleDateFormat("dd");
			SimpleDateFormat YEAR_ONLY = new SimpleDateFormat("yyyy");
			
			String stdate = post._getDate(ids,"first");
			String endate = post._getDate(ids,"last");
			
			Date dstart = new SimpleDateFormat("yyyy-MM-dd").parse(stdate);
			Date today = new SimpleDateFormat("yyyy-MM-dd").parse(endate);

			Date nnow = new Date();  
			  
			String day = DAY_ONLY.format(today);
			
			String month = MONTH_ONLY.format(today);
			String smallmonth = SMALL_MONTH_ONLY.format(today);
			String year = YEAR_ONLY.format(today);

			String dispfrom = DATE_FORMAT.format(dstart);
			String dispto = DATE_FORMAT.format(today);
			
			String historyfrom = DATE_FORMAT.format(dstart);
			String historyto = DATE_FORMAT.format(today);

			String dst = DATE_FORMAT2.format(dstart);
			String dend = DATE_FORMAT2.format(today);

			//ArrayList posts = post._list("DESC","");
			ArrayList sentiments = senti._list("DESC", "", "id");
			String totalpost = "0";
			ArrayList allauthors = new ArrayList();

			String possentiment = "0";
			String negsentiment = "0";
			String ddey = "31";
			String dt = dst;
			String dte = dend;
			String year_start="";
			String year_end="";
			if(!single.equals("")){
				month = MONTH_ONLY.format(nnow); 
				day = DAY_ONLY.format(nnow); 
				year = YEAR_ONLY.format(nnow); 
				//System.out.println("Now:"+month+"small:"+smallmonth);
				if(month.equals("02")){
					ddey = (Integer.parseInt(year)%4==0)?"28":"29";
				}else if(month.equals("09") || month.equals("04") || month.equals("05") || month.equals("11")){
					ddey = "30";
				}
			}
			
			if (!date_start.equals("") && !date_end.equals("")) {
				totalpost = post._searchRangeTotal("date", date_start.toString(), date_end.toString(), ids);
				//possentiment = post._searchRangeTotal("sentiment", "0", "10", ids);
				//negsentiment = post._searchRangeTotal("sentiment", "-10", "-1", ids);

				Date start = new SimpleDateFormat("yyyy-MM-dd").parse(date_start.toString());
				Date end = new SimpleDateFormat("yyyy-MM-dd").parse(date_end.toString());
				
				dt = date_start.toString();
				dte = date_end.toString();
				
				historyfrom = DATE_FORMAT.format(start);
				historyto = DATE_FORMAT.format(end);
				termss = term._searchByRange("date", date_start.toString(), date_end.toString(), ids);
				outlinks = outl._searchByRange("date", date_start.toString(), date_end.toString(), ids);
				//liwcpost = 
				allauthors=post._getBloggerByBlogId("date",date_start.toString(), date_end.toString(),ids);
			} else if (single.equals("day")) {
				 dt = year + "-" + month + "-" + day;
				
				//dispfrom = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dt));
				//dispto = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dt));			
				totalpost = post._searchRangeTotal("date", dt, dt, ids);
				termss = term._searchByRange("date", dt, dt, ids);
				outlinks = outl._searchByRange("date", dt, dt, ids);

				allauthors=post._getBloggerByBlogId("date",dt, dt,ids,"influence_score","DESC");
					
			} else if (single.equals("week")) {
				
				 dte = year + "-" + month + "-" + day;
				int dd = Integer.parseInt(day)-7;
				
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DATE, -7);
				Date dateBefore7Days = cal.getTime();
				dt = YEAR_ONLY.format(dateBefore7Days) + "-" + MONTH_ONLY.format(dateBefore7Days) + "-" + DAY_ONLY.format(dateBefore7Days);
				
				
				//dispfrom = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dt));
				//dispto = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dte));			
				totalpost = post._searchRangeTotal("date", dt, dte, ids);
				termss = term._searchByRange("date", dt, dte, ids);
				outlinks = outl._searchByRange("date", dt, dte, ids);

				allauthors=post._getBloggerByBlogId("date",dt, dte,ids,"influence_score","DESC");
				
					
			} else if (single.equals("month")) {
				dt = year + "-" + month + "-01";
				dte = year + "-" + month + "-"+day;	
				//dispfrom = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dt));
				//dispto = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dte));
				
				totalpost = post._searchRangeTotal("date", dt, dte, ids);
				termss = term._searchByRange("date", dt, dte, ids);
				outlinks = outl._searchByRange("date", dt, dte, ids);

				allauthors=post._getBloggerByBlogId("date",dt, dte,ids,"influence_score","DESC");
				
				
			} else if (single.equals("year")) {
				dt = year + "-01-01";
				dte = year + "-12-"+ddey;
				//dispfrom = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dt));
				//dispto = DATE_FORMAT.format(new SimpleDateFormat("yyyy-MM-dd").parse(dte));
				
				totalpost = post._searchRangeTotal("date", dt, dte, ids);
				termss = term._searchByRange("date", dt, dte, ids);
				outlinks = outl._searchByRange("date", dt, dte, ids);
				allauthors=post._getBloggerByBlogId("date",dt, dte,ids,"influence_score","DESC");
				
				
				
			} else {
				dt = dst;
				dte = dend;
				totalpost = post._getTotalByBlogId(ids, "");
				//possentiment = post._searchRangeTotal("sentiment", "0", "10", ids);
				//negsentiment = post._searchRangeTotal("sentiment", "-10", "-1", ids);			
				termss = term._searchByRange("date", dst, dend, ids);
				outlinks = outl._searchByRange("date",dst, dend, ids);
				
				allauthors=post._getBloggerByBlogId("date",dst, dend,ids,"influence_score","DESC");
				
				
			}
			
			//System.out.println("Terms here:"+termss);
			
			ArrayList blogs = blog._fetch(ids);
			int totalblog = blogs.size();
			
		
			
			//System.out.println("grapgh yeres"+yearsarray);
		    JSONObject authors = new JSONObject();
		    JSONArray sentimentpost = new JSONArray();
		    JSONArray sentimentpost2 = new JSONArray();
		    
		    JSONArray authorcount = new JSONArray();
			ArrayList authorlooper = new ArrayList();
			
			
	if(allauthors.size()>0){
		String tres = null;
		JSONObject tresp = null;
		String tresu = null;
		JSONObject tobj = null;
	
		for(int i=0; i< allauthors.size(); i++){
					tres = allauthors.get(i).toString();			
					tresp = new JSONObject(tres);
				    tresu = tresp.get("_source").toString();
				    tobj = new JSONObject(tresu);	
				    sentimentpost.put(tobj.get("blogpost_id").toString());	
				    if(i<1){
				    	sentimentpost2.put(tobj.get("blogpost_id").toString());	
				    }
			}
		} 
			
			
			JSONObject graphyearspos = new JSONObject();
			JSONObject graphyearsneg = new JSONObject();
		    JSONArray yearsarray = new JSONArray();
		    
			String[] yst = dt.split("-");
			String[] yend = dte.split("-");
			year_start = yst[0];
			year_end = yend[0];
			int ystint = Integer.parseInt(year_start);
			int yendint = Integer.parseInt(year_end);
			if(single.equals("month")){
				//int diff = post.monthsBetweenDates(DATE_FORMAT2.parse(dt), DATE_FORMAT2.parse(dte));
				//ystint=0;
				//yendint = diff;
			}
			
			int b=0;
			for(int y=ystint; y<=yendint; y++){
					/*
					   String dtu = post.addMonth(DATE_FORMAT2.parse(dt), b).toString();
					   String dtue = post.addMonth(DATE_FORMAT2.parse(dte), b+1).toString();
					*/  
					   String dtu = y + "-01-01";
					   String dtue = y + "-12-31";
					   String totu = post._searchRangeTotal("date",dtu, dtue,ids);
					 	
					   
					   ArrayList sentimentor = new Liwc()._searchByRange("date", dtu, dtue, sentimentpost);
						int allposemo =0;
						int allnegemo =0;
						if(sentimentor.size()>0){
							for(int v=0; v<sentimentor.size();v++){
								//if(v<1){
									String bstr = sentimentor.get(v).toString();
									JSONObject bj = new JSONObject(bstr);
									bstr = bj.get("_source").toString();
									bj = new JSONObject(bstr);
									//System.out.println("result eree"+bj);
									int posemo = Integer.parseInt(bj.get("posemo").toString());
									int negemo = Integer.parseInt(bj.get("negemo").toString());
									allposemo+=posemo;
									allnegemo+=negemo;
								//}
								
							}
						}
						
						
						possentiment=allposemo+"";
						negsentiment=allnegemo+"";
					   
					   graphyearspos.put(y+"",allposemo);
					   graphyearsneg.put(y+"",allnegemo);
			    	   yearsarray.put(b,y);	
			    	   b++;
			}
			
			
			//JSONArray sortedyearsarray = yearsarray;//post._sortJson(yearsarray);
			

			JSONArray topterms = new JSONArray();
		
			
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
						String domain = uri.getHost();
						if (domain.startsWith("www.")) {
							maindomain = domain.substring(4);
						} else {
							maindomain = domain;
						}
					} catch (Exception ex) {}

					
					if (outerlinks.has(maindomain)) {
						content = new JSONObject(outerlinks.get(maindomain).toString());
						
						int valu = Integer.parseInt(content.get("value").toString());
						valu++;
						
						content.put("value", valu);
						content.put("link", link);
						content.put("domain", maindomain);
						outerlinks.put(maindomain, content);
					} else {
						int valu = 1;
						content.put("value", valu);
						content.put("link", link);
						content.put("domain", maindomain);
						outerlinks.put(maindomain, content);
						outlinklooper.add(mm, maindomain);
						mm++;
					}				
				
				}
			}

			//System.out.println("senti"+ sentimentblog);
			
			JSONObject bloggers = new JSONObject();

			ArrayList looper = new ArrayList();
			

			String allpost = "0";
			float totalinfluence = 0;
			String mostactiveblog="";
			String mostactivebloglink="";
			String mostactiveblogposts="0";
			String mostactiveblogid="0";
			
			String mostactiveblogger="";
			String secondactiveblogger="";
			
			String secondactiveblog = "";
			String secondactiveid = "";
			
			String mostusedkeyword = "";
			String fsid = "";


			ArrayList mostactive= blog._getMostactive(ids);
			if(mostactive.size()>0){
				mostactiveblog = mostactive.get(0).toString();
				mostactivebloglink = mostactive.get(1).toString();
				mostactiveblogposts = mostactive.get(2).toString();
				mostactiveblogid = mostactive.get(3).toString();
				fsid = mostactiveblogid;
				if(mostactive.size()>4){
					secondactiveblog = mostactive.get(4).toString();
					secondactiveid = mostactive.get(7).toString();
					fsid = mostactiveblogid+","+secondactiveid;
				}
			}
			

			int highestfrequency = 0;
			JSONObject keys = new JSONObject();
			if (termss.size() > 0) {			
				for (int p = 0; p < termss.size(); p++) {
					String bstr = termss.get(p).toString();
					JSONObject bj = new JSONObject(bstr);
					bstr = bj.get("_source").toString();
					bj = new JSONObject(bstr);
					String frequency = bj.get("frequency").toString();
					int freq = Integer.parseInt(frequency);
					
					String tm = bj.get("term").toString();
					if(freq>highestfrequency){
						highestfrequency = freq;
						mostusedkeyword = tm;
					}
					JSONObject cont = new JSONObject();
					cont.put("key", tm);
					cont.put("frequency", frequency);
					if(!keys.has(tm)){
						keys.put(tm,tm);
						topterms.put(cont);
					}
				}
			}
			
			ArrayList sentimentor =new ArrayList();
			
			int death =0;
			int work =0;
			int leisure =0;
			int religion =0;
			int home =0;
			int money =0;
			int focuspast=0;
			int focuspresent =0;
			int focusfuture=0;
			int affiliation=0;
			int achieve=0;
			int risk=0;
			int reward =0;
			int power=0;
			int insight=0;
			int differ=0;
			int cause=0;
			int discrep=0;
			int certain=0;
			int tentat=0;
			int analytic=0;
			int tone=0;
			int clout=0;
			int authentic=0;
			int posemo=0;
			int negemo=0;
			int anger=0;
			int anx=0;
			int sad=0;
					
		
				ArrayList sentimentor2 = new Liwc()._searchByRange("date", dt, dte, sentimentpost2);
				
				if(sentimentor2.size()>0){
					for(int v=0; v<sentimentor2.size();v++){
						String bstr = sentimentor2.get(v).toString();
						JSONObject bj = new JSONObject(bstr);
						bstr = bj.get("_source").toString();
						bj = new JSONObject(bstr);
						//System.out.println("result eree"+bj);
						death += Integer.parseInt(bj.get("death").toString());
						work += Integer.parseInt(bj.get("work").toString());
						leisure+=Integer.parseInt(bj.get("leisure").toString());
						religion+=Integer.parseInt(bj.get("religion").toString());
						home+=Integer.parseInt(bj.get("home").toString());
						money+=Integer.parseInt(bj.get("money").toString());
						
						focuspast+=Integer.parseInt(bj.get("focuspast").toString());
						focuspresent+=Integer.parseInt(bj.get("focuspresent").toString());
						focusfuture+=Integer.parseInt(bj.get("focusfuture").toString());
						affiliation+=Integer.parseInt(bj.get("affiliation").toString());
						achieve+=Integer.parseInt(bj.get("achieve").toString());
						risk+=Integer.parseInt(bj.get("risk").toString());
						reward+=Integer.parseInt(bj.get("reward").toString());
						power+=Integer.parseInt(bj.get("power").toString());
						insight+=Integer.parseInt(bj.get("insight").toString());
						differ+=Integer.parseInt(bj.get("differ").toString());
						cause+=Integer.parseInt(bj.get("cause").toString());
						discrep+=Integer.parseInt(bj.get("discrep").toString());
						certain+=Integer.parseInt(bj.get("certain").toString());
						tentat+=Integer.parseInt(bj.get("tentat").toString());
						analytic+=Integer.parseInt(bj.get("analytic").toString());
						tone+=Integer.parseInt(bj.get("tone").toString());
						clout+=Integer.parseInt(bj.get("clout").toString());
						authentic+=Integer.parseInt(bj.get("authentic").toString());
						posemo+=Integer.parseInt(bj.get("posemo").toString());
						negemo+=Integer.parseInt(bj.get("negemo").toString());
						anger+=Integer.parseInt(bj.get("anger").toString());
						anx+=Integer.parseInt(bj.get("anx").toString());
						sad+=Integer.parseInt(bj.get("sad").toString());
					}
			} 
						
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Blogtrackers - Sentiment Analysis</title>
<link rel="shortcut icon" href="images/favicons/favicon-48x48.png">
<link rel="apple-touch-icon" href="images/favicons/favicon-48x48.png">
<link rel="apple-touch-icon" sizes="96x96"
	href="images/favicons/favicon-96x96.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="images/favicons/favicon-144x144.png">
<!-- start of bootsrap -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:600,700"
	rel="stylesheet">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap-grid.css" />
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.css" />
<link rel="stylesheet"
	href="assets/fonts/fontawesome/css/fontawesome-all.css" />
<link rel="stylesheet" href="assets/fonts/iconic/css/open-iconic.css" />
<link rel="stylesheet"
	href="assets/vendors/bootstrap-daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="assets/css/table.css" />
<link rel="stylesheet"
	href="assets/vendors/DataTables/dataTables.bootstrap4.min.css" />

<link rel="stylesheet" href="assets/css/daterangepicker.css" />
<link rel="stylesheet" href="assets/css/style.css" />

<!--end of bootsrap -->
<script src="assets/js/jquery-3.2.1.slim.min.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="pagedependencies/googletagmanagerscript.js"></script>
</head>
<body>
<noscript>
<%@include file="subpages/googletagmanagernoscript.jsp" %>
</noscript>
	<div class="modal-notifications">
		<div class="row">
			<div class="col-lg-10 closesection"></div>
			<div class="col-lg-2 col-md-12 notificationpanel">
				<div id="closeicon" class="cursor-pointer">
					<i class="fas fa-times-circle"></i>
				</div>
				<div class="profilesection col-md-12 mt50">
					<%
						if (userinfo.size() > 0) {
					%>
					<div class="text-center mb10">
						<img src="<%=profileimage%>" width="60" height="60"
							onerror="this.src='images/default-avatar.png'" alt="" />
					</div>
					<div class="text-center" style="margin-left: 0px;">
						<h6 class="text-primary m0 bolder profiletext"><%=name%></h6>
						<p class="text-primary profiletext"><%=email%></p>
					</div>
					<%
						}
					%>
				</div>
				<div id="othersection" class="col-md-12 mt10" style="clear: both">
					<%
						if (userinfo.size() > 0) {
					%>
					<a class="cursor-pointer profilemenulink"
						href="<%=request.getContextPath()%>/notifications.jsp"><h6
							class="text-primary">
							Notifications <b id="notificationcount" class="cursor-pointer">12</b>
						</h6> </a> <a class="cursor-pointer profilemenulink"
						href="<%=request.getContextPath()%>/profile.jsp"><h6
							class="text-primary">Profile</h6></a> <a
						class="cursor-pointer profilemenulink"
						href="<%=request.getContextPath()%>/logout"><h6
							class="text-primary">Log Out</h6></a>
					<%
						} else {
					%>
					<a class="cursor-pointer profilemenulink"
						href="<%=request.getContextPath()%>/login"><h6
							class="text-primary">Login</h6></a>

					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<nav class="navbar navbar-inverse bg-primary">
		<div class="container-fluid mt10 mb10">

			<div
				class="navbar-header d-none d-lg-inline-flex d-xl-inline-flex  col-lg-3">
				<a class="navbar-brand text-center logohomeothers" href="./"> </a>
			</div>
			<!-- Mobile Menu -->
			<nav
				class="navbar navbar-dark bg-primary float-left d-md-block d-sm-block d-xs-block d-lg-none d-xl-none"
				id="menutoggle">
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarToggleExternalContent"
					aria-controls="navbarToggleExternalContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			</nav>
			<!-- <div class="navbar-header ">
          <a class="navbar-brand text-center" href="#"><img src="images/blogtrackers.png" /></a>
          </div> -->
			<!-- Mobile menu  -->
			<div class="col-lg-6 themainmenu" align="center">
				<ul class="nav main-menu2"
					style="display: inline-flex; display: -webkit-inline-flex; display: -mozkit-inline-flex;">
					<li><a class="bold-text"
						href="<%=request.getContextPath()%>/blogbrowser.jsp"><i
							class="homeicon"></i> <b class="bold-text ml30">Home</b></a></li>
					<li><a class="bold-text"
						href="<%=request.getContextPath()%>/trackerlist.jsp"><i
							class="trackericon"></i><b class="bold-text ml30">Trackers</b></a></li>
					<li><a class="bold-text"
						href="<%=request.getContextPath()%>/favorites.jsp"><i
							class="favoriteicon"></i> <b class="bold-text ml30">Favorites</b></a></li>

				</ul>
			</div>

			<div class="col-lg-3">
				<%
					if (userinfo.size() > 0) {
				%>

				<ul class="nav navbar-nav" style="display: block;">
					<li class="dropdown dropdown-user cursor-pointer float-right">
						<a class="dropdown-toggle " id="profiletoggle"
						data-toggle="dropdown"> <i class="fas fa-circle"
							id="notificationcolor"></i> <img src="<%=profileimage%>"
							width="50" height="50"
							onerror="this.src='images/default-avatar.png'" alt="" class="" />
							<span><%=username%></span></a>

					</li>
				</ul>
				<%
					} else {
				%>
				<ul class="nav main-menu2 float-right"
					style="display: inline-flex; display: -webkit-inline-flex; display: -mozkit-inline-flex;">

					<li class="cursor-pointer"><a href="login.jsp">Login</a></li>
				</ul>
				<%
					}
				%>
			</div>

		</div>
		<div
			class="col-md-12 bg-dark d-md-block d-sm-block d-xs-block d-lg-none d-xl-none p0 mt20">
			<div class="collapse" id="navbarToggleExternalContent">
				<ul class="navbar-nav mr-auto mobile-menu">
					<li class="nav-item active"><a class=""
						href="<%=request.getContextPath()%>/blogbrowser.jsp">Home <span
							class="sr-only">(current)</span></a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/trackerlist.jsp">Trackers</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/favorites.jsp">Favorites</a></li>
				</ul>
			</div>
		</div>


	</nav>
	<div class="container">
		<!-- start of print section  -->



		<div class="row bottom-border pb20">
			<div class="col-md-6 ">
				<nav class="breadcrumb">
					<a class="breadcrumb-item text-primary"
						href="<%=request.getContextPath()%>/trackerlist.jsp">My	Trackers</a> <a class="breadcrumb-item text-primary"
						href="<%=request.getContextPath()%>/edittracker.jsp"><%=trackername%></a>
					<a class="breadcrumb-item active text-primary" href="#">Dashboard</a>
				</nav>
				<div>
					<button class="btn btn-primary stylebutton1 " id="printdoc">SAVE
						AS PDF</button>
				</div>
			</div>
			<div class="col-md-6 text-right mt10">
				<div class="text-primary demo">
					<h6 id="reportrange">
						Date: <span><%=dispfrom%> - <%=dispto%></span>
					</h6>
				</div>
				<div>
					<div class="btn-group mt5" data-toggle="buttons">
						<label
							class="btn btn-primary btn-sm daterangebutton legitRipple nobgnoborder">
							<input type="radio" name="options" value="day" autocomplete="off">
							Day
						</label> <label class="btn btn-primary btn-sm nobgnoborder"> <input
							type="radio" name="options" value="week" autocomplete="off">Week
						</label> <label class="btn btn-primary btn-sm nobgnoborder nobgnoborder">
							<input type="radio" name="options" value="month"
							autocomplete="off"> Month
						</label> <label class="btn btn-primary btn-sm text-center nobgnoborder">Year
							<input type="radio" name="options" value="year"
							autocomplete="off">
						</label>
						<!--  <label class="btn btn-primary btn-sm nobgnoborder " id="custom">Custom</label> -->
					</div>

					<!-- Day Week Month Year <b id="custom" class="text-primary">Custom</b> -->

				</div>
			</div>
		</div>

		<!-- <div class="row p40 border-top-bottom mt20 mb20">
  <div class="col-md-2">
<small class="text-primary">Selected Blogger</small>
<h2 class="text-primary styleheading">AdNovum <div class="circle"></div></h2>
</div>
  <div class="col-md-10">
  <small class="text-primary">Find Blogger</small>
  <input class="form-control inputboxstyle" placeholder="| Search" />
  </div>
</div> -->





		<div class="row mt20">

			<div class="col-md-12">
				<div class="card card-style mt20">
					<div class="card-body  p30 pt5 pb5">
						<div style="min-height: 250px;">
							<div>
								<p class="text-primary mt10">
									<b>Aggregate</b> of <b class="text-success">Positive</b> and <b
										class="text-danger">Negative</b> Sentiment of post Past <select
										class="text-primary filtersort sortbytimerange"><option
											value="week">Week</option>
										<option value="month">Month</option>
										<option value="year">Year</option></select>
								</p>
							</div>
							<div class="chart-container">
								<div class="chart" id="d3-line-basic"></div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>



		<div class="row m0 mt20 mb50 d-flex align-items-stretch">
			<div
				class="col-md-6 mt20 card card-style nobordertopright noborderbottomright">
				<div class="card-body p0 pt20 pb20" style="min-height: 320px;">
					<p>
						Influential Blog Posts of <b class="text-blue"><%=mostactiveblogger%></b> and <b
							class="text-success"><%=secondactiveblogger%></b>
					</p>
					<!-- <div class="p15 pb5 pt0" role="group">
          Export Options
          </div> -->
          
					<table id="DataTables_Table_0_wrapper" class="display"
						style="width: 100%">
						<thead>
							<tr>
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
										    if(i<10){
										    	color="#CC330"+i;
										    }else if(i>9 && i<99){
										    	color="#EE33"+i;
										    }else{
										    	color="#DDD"+i;
										    }
										    
										    y++;
					    %>
							<tr>
								<td><a syle="cursor:pointer" class="blogpost_link" id="<%=tobj.get("blogpost_id")%>-<%=color%>" style="color:<%=color%>">#<%=(y+1)%>: <%=tobj.get("title").toString() %></a></td>
								<td align="center"><%=tobj.get("blogger").toString() %></td>
							</tr>
						<% }} %>
							
							
						</tbody>
					</table>
				</div>

			</div>

			<div class="col-md-6 mt20 card card-style nobordertopleft noborderbottomleft">
				<div style="" id="mainCarInd" class="pt20">


					<!-- <div class="p20 pt0 pb20 text-blog-content text-primary" style="height:586px;">
          <h5 class="text-primary p20 pt0 pb0 text-center">Personal Content</h5>
          	<div class="personalcontent"></div>
         </div> -->

					<div id="carouselExampleIndicators" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0"
								class="active" data-toggle="tooltip" data-placement="top"
								title="Personal Content"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"
								data-toggle="tooltip" data-placement="top"
								title="Time Orientation"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"
								data-toggle="tooltip" data-placement="top"
								title="Core Drive and Need"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="3"
								data-toggle="tooltip" data-placement="top"
								title="Cognitive Process"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="4"
								data-toggle="tooltip" data-placement="top"
								title="Summary Variable"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="5"
								data-toggle="tooltip" data-placement="top"
								title="Sentiment/Emotion"></li>

						</ol>
						<div class="carousel-inner" id="carouseller">
							<div class="carousel-item active">
								<div class="p20 pt0 pb20 text-blog-content text-primary"
									style="height: 586px;">
									<h5 class="text-primary p20 pt0 pb0 text-center">Personal
										Content</h5>
									<div class="personalcontent"></div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="p20 pt0 pb20 text-blog-content text-primary"
									style="height: 586px;">
									<h5 class="text-primary p20 pt0 pb0 text-center">Time
										Orientation</h5>
									<div class="timeorientation"></div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="p20 pt0 pb20 text-blog-content text-primary"
									style="height: 586px;">
									<h5 class="text-primary p20 pt0 pb0 text-center">Core
										Drive and Need</h5>
									<div class="coredriveandneed"></div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="p20 pt0 pb20 text-blog-content text-primary"
									style="height: 586px;">
									<h5 class="text-primary p20 pt0 pb0 text-center">Cognitive
										Process</h5>
									<div class="cognitiveprocess"></div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="p20 pt0 pb20 text-blog-content text-primary"
									style="height: 586px;">
									<h5 class="text-primary p20 pt0 pb0 text-center">Summary
										Variable</h5>
									<div class="summaryvariable"></div>
								</div>
							</div>
							<div class="carousel-item">
								<div class="p20 pt0 pb20 text-blog-content text-primary"
									style="height: 586px;">
									<h5 class="text-primary p20 pt0 pb0 text-center">Sentiment/Emotion</h5>
									<div class="sentimentemotion"></div>
								</div>
							</div>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleIndicators"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next"
							href="#carouselExampleIndicators" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>

				</div>
			</div>
		</div>




	<form name="date-form" action="">
		<input type="hidden" value="<%=dt%>" id="date_from" />
		<input type="hidden" value="<%=dte%>" id="date_to"/>
	</form>

	</div>


	<!-- <footer class="footer">
  <div class="container-fluid bg-primary mt60">
<p class="text-center text-medium pt10 pb10 mb0">Copyright &copy; Blogtrackers 2017 All Rights Reserved.</p>
</div>
  </footer> -->


	<script type="text/javascript" src="assets/js/jquery-1.11.3.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.js">
 </script>
	<script src="assets/js/generic.js">
 </script>
	<script src="assets/vendors/bootstrap-daterangepicker/moment.js"></script>
	<script
		src="assets/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!-- Start for tables  -->
	<script type="text/javascript"
		src="assets/vendors/DataTables/datatables.min.js"></script>
	<script type="text/javascript"
		src="assets/vendors/DataTables/dataTables.bootstrap4.min.js"></script>
	<script
		src="assets/vendors/DataTables/Buttons-1.5.1/js/buttons.flash.min.js"></script>
	<script
		src="assets/vendors/DataTables/Buttons-1.5.1/js/dataTables.buttons.min.js"></script>
	<script src="assets/vendors/DataTables/pdfmake-0.1.32/pdfmake.min.js"></script>
	<script src="assets/vendors/DataTables/pdfmake-0.1.32/vfs_fonts.js"></script>
	<script
		src="assets/vendors/DataTables/Buttons-1.5.1/js/buttons.html5.min.js"></script>
	<script
		src="assets/vendors/DataTables/Buttons-1.5.1/js/buttons.print.min.js"></script>

	<script>
 $(document).ready(function() {
	 
	/*  function PrintElem(elem)
	 {
	     var mywindow = window.open('', 'PRINT', 'height=400,width=600');

	     mywindow.document.write('<html><head><title>' + document.title  + '</title>');
	     mywindow.document.write('</head><body >');
	     mywindow.document.write('<h1>' + document.title  + '</h1>');
	     mywindow.document.write(document.getElementById(elem).innerHTML);
	     mywindow.document.write('</body></html>');

	     mywindow.document.close(); // necessary for IE >= 10
	     mywindow.focus(); // necessary for IE >= 10*/

	   /*  mywindow.print();
	     mywindow.close();

	     return true;
	 } */
 
	$('#printdoc').on('click',function(){
		print();
	}) 
	
	 $(function () {
		    $('[data-toggle="tooltip"]').tooltip()
		  })
		  
     $('#DataTables_Table_1_wrapper').DataTable( {
         "scrollY": 430,
          "pagingType": "simple",
         /*  dom: 
        	   'Bfrtip', 
                    "columnDefs": [
                 { "width": "80%", "targets": 0 }
               ]  */
  /*    ,
       buttons:{
         buttons: [
             { extend: 'pdfHtml5',orientation: 'potrait', pageSize: 'LEGAL', className: 'btn-primary stylebutton1'},
             {extend:'csv',className: 'btn-primary stylebutton1'},
             {extend:'excel',className: 'btn-primary stylebutton1'},
            // {extend:'copy',className: 'btn-primary stylebutton1', text: 'Copy to Clipboard'},
             {extend:'print',className: 'btn-primary stylebutton1'},
         ]
       } */
     } );

     $('#DataTables_Table_0_wrapper').DataTable( {
         "scrollY": 320,
          "pagingType": "simple",
        /*   dom: 'Bfrtip',

                    "columnDefs": [
                 { "width": "80%", "targets": 0 }
               ] */
    /*  ,
       buttons:{
         buttons: [
             { extend: 'pdfHtml5',orientation: 'potrait', pageSize: 'LEGAL', className: 'btn-primary stylebutton1'},
             {extend:'csv',className: 'btn-primary stylebutton1'},
             {extend:'excel',className: 'btn-primary stylebutton1'},
            // {extend:'copy',className: 'btn-primary stylebutton1', text: 'Copy to Clipboard'},
             {extend:'print',className: 'btn-primary stylebutton1'},
         ]
       } */
     } );
 } );
 </script>
	<!--end for table  -->
	<script>
 $(document).ready(function() {
	 
		 
   $(document)
   						.ready(
   								function() {
   	var cb = function(start, end, label) {
           //console.log(start.toISOString(), end.toISOString(), label);
           $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
           $('#reportrange input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')).trigger('change');
         };

         var optionSet1 =
       	      {   startDate: moment().subtract(29, 'days'),
       	          endDate: moment(),
       	          minDate: '01/01/1947',
       	          maxDate: moment(),
       			  showDropdowns: true,
       	          showWeekNumbers: true,
       	          timePicker : false,
   				  timePickerIncrement : 1,
   				  timePicker12Hour : true,
   				  dateLimit: { days: 50000 },
          	          ranges: {

          	        	'This Year' : [
   						moment()
   								.startOf('year'),
   						moment() ],
   				'Last Year' : [
   						moment()
   								.subtract(1,'year').startOf('year'),
   						moment().subtract(1,'year').endOf('year') ]
       	          },
       	          opens: 'left',
       	          applyClass: 'btn-small bg-slate-600 btn-block',
       	          cancelClass: 'btn-small btn-default btn-block',
       	          format: 'MM/DD/YYYY',
       			  locale: {
       	          applyLabel: 'Submit',
       	          //cancelLabel: 'Clear',
       	          fromLabel: 'From',
       	          toLabel: 'To',
       	          customRangeLabel: 'Custom',
       	          daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
       	          monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
       	          firstDay: 1
       	        }

       	      };


   	// if('${datepicked}' == '')
   	// {
     //   $('#reportrange span').html(moment().subtract('days', 500).format('MMMM D') + ' - ' + moment().format('MMMM D'));
     //   $('#reportrange').daterangepicker(optionSet1, cb);
   	// }
     //
   	// else{
   		// $('#reportrange span').html('${datepicked}');
       $('#reportrange span').html(moment().subtract( 500, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'))
   		$('#reportrange, #custom').daterangepicker(optionSet1, cb);
   		$('#reportrange')
   		.on(
   				'show.daterangepicker',
   				function() {
   				/* 	console
   							.log("show event fired"); */
   				});
   $('#reportrange')
   		.on(
   				'hide.daterangepicker',
   				function() {
   					/* console
   							.log("hide event fired"); */
   				});
   $('#reportrange')
   		.on(
   				'apply.daterangepicker',
   				function(ev, picker) {
   					/* console
   							.log("apply event fired, start/end dates are "
   									+ picker.startDate
   											.format('MMMM D, YYYY')
   									+ " to "
   									+ picker.endDate
   											.format('MMMM D, YYYY')); */
   				});
   $('#reportrange')
   		.on(
   				'cancel.daterangepicker',
   				function(ev, picker) {
   					/* console
   							.log("cancel event fired"); */
   				});
   $('#options1').click(
   		function() {
   			$('#reportrange').data(
   					'daterangepicker')
   					.setOptions(
   							optionSet1,
   							cb);
   		});
   $('#options2').click(
   		function() {
   			$('#reportrange').data(
   					'daterangepicker')
   					.setOptions(
   							optionSet2,
   							cb);
   		});
   $('#destroy').click(
   		function() {
   			$('#reportrange').data(
   					'daterangepicker')
   					.remove();
   		});
   		//}
   								});
                 // set attribute for the form
       //$('#trackerform').attr("action","ExportJSON");
       //$('#dateform').attr("action","ExportJSON");


   //$('#config-demo').daterangepicker(options, function(start, end, label) { console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); });
 });
 </script>
	<script type="text/javascript" src="assets/vendors/d3/d3.min.js"></script>
	<script src="assets/vendors/wordcloud/d3.layout.cloud.js"></script>
	<script type="text/javascript" src="assets/vendors/d3/d3_tooltip.js"></script>
	<script src="assets/vendors/radarchart/radarChart.js"></script>
	<script>
$(function () {
    /* Radar chart design created by Nadieh Bremer - VisualCinnamon.com */

    //////////////////////////////////////////////////////////////
    //////////////////////// Set-Up //////////////////////////////
    //////////////////////////////////////////////////////////////

    var margin = {top: 100, right: 100, bottom: 100, left: 100},
      width = Math.min(450, window.innerWidth - 10) - margin.left - margin.right,
      height = Math.min(width, window.innerHeight - margin.top - margin.bottom - 20);



    //////////////////////////////////////////////////////////////
    ////////////////////////// Data //////////////////////////////
    //////////////////////////////////////////////////////////////

    var personalcontent = [
          [//iPhone
          {axis:"Death",value:<%=death%>},
          {axis:"Work",value:<%=work%>},
          {axis:"Leisure",value:<%=leisure%>},
          {axis:"Religion",value:<%=religion%>},
          {axis:"Home",value:<%=home%>},
          {axis:"Money",value:<%=money%>}
          ]
        ];
	

        var timeorientation = [
              [//iPhone
              {axis:"Past Focus",value:<%=focuspast%>},
              {axis:"Present Focus",value:<%=focuspresent%>},
              {axis:"Future Focus",value:<%=focusfuture%>}
              ]
            ];

            var coredriveandneed = [
                  [//iPhone
                  {axis:"Affiliation",value:<%=affiliation%>},
                  {axis:"Achievement",value:<%=achieve%>},
                  {axis:"Risk/Prevention Focus",value:<%=risk%>},
                  {axis:"Reward Focus",value:<%=reward%>},
                  {axis:"Power",value:<%=power%>},
                  ]
                ];
        
                var cognitiveprocess = [
                      [//iPhone
                      {axis:"Insight",value:<%=insight%>},
                      {axis:"Differentiation",value:<%=differ%>},
                      {axis:"Cause",value:<%=cause%>},
                      {axis:"Discrepancies",value:<%=discrep%>},
                      {axis:"Certainty",value:<%=certain%>},
                      {axis:"Tentativeness",value:<%=tentat%>}
                      ]
                    ];

                    var summaryvariable = [
                          [//iPhone
                          {axis:"Analytical Thinking",value:<%=analytic%>},
                          {axis:"Emotional Tone",value:<%=tone%>},
                          {axis:"Clout",value:<%=clout%>},
                          {axis:"Authentic",value:<%=authentic%>}
                          ]
                        ];

                        var sentimentemotion = [
                              [//iPhone
                              {axis:"Positive Emotion",value:<%=posemo%>},
                              {axis:"Sadness",value:<%=sad%>},
                              {axis:"Negative Emotion",value:<%=anger%>},
                              {axis:"Anger",value:<%=anger%>},
                              {axis:"Anxiety",value:<%=anx%>}
                              ]
                            ];
    //////////////////////////////////////////////////////////////
    //////////////////// Draw the Chart //////////////////////////
    //////////////////////////////////////////////////////////////

    var color = d3.scale.ordinal()
      .range(["#EDC951","#CC333F","#00A0B0"]);

    var radarChartOptions1 = {
      w: width,
      h: height,
      margin: margin,
      maxValue: 0.5,
      levels: 5,
      roundStrokes: true,
      color: color
    };
    var radarChartOptions2 = {
      w: width,
      h: height,
      margin: margin,
      maxValue: 0.5,
      levels: 5,
      roundStrokes: true,
      color: color
    };
    var radarChartOptions3 = {
      w: width,
      h: height,
      margin: margin,
      maxValue: 0.5,
      levels: 5,
      roundStrokes: true,
      color: color
    };
    var radarChartOptions4 = {
      w: width,
      h: height,
      margin: margin,
      maxValue: 0.5,
      levels: 5,
      roundStrokes: true,
      color: color
    };
    var radarChartOptions5 = {
      w: width,
      h: height,
      margin: margin,
      maxValue: 0.5,
      levels: 5,
      roundStrokes: true,
      color: color
    };
    var radarChartOptions6 = {
      w: width,
      h: height,
      margin: margin,
      maxValue: 0.5,
      levels: 5,
      roundStrokes: true,
      color: color
    };
    //Call function to draw the Radar chart

      RadarChart(".personalcontent", personalcontent, radarChartOptions1);
      RadarChart(".timeorientation", timeorientation, radarChartOptions2);
      RadarChart(".coredriveandneed", coredriveandneed, radarChartOptions3);
      RadarChart(".cognitiveprocess", cognitiveprocess, radarChartOptions4);
      RadarChart(".summaryvariable", summaryvariable, radarChartOptions5);
      RadarChart(".sentimentemotion", sentimentemotion, radarChartOptions6);

});
  </script>
	<script>
 $(function () {

     // Initialize chart
     lineBasic('#d3-line-basic', 200);

     // Chart setup
     function lineBasic(element, height) {


         // Basic setup
         // ------------------------------

         // Define main variables
         var d3Container = d3.select(element),
             margin = {top: 5, right: 10, bottom: 20, left: 50},
             width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
             height = height - margin.top - margin.bottom;


         var formatPercent = d3.format("");
         // Format data
         // var parseDate = d3.time.format("%d-%b-%y").parse,
         //     bisectDate = d3.bisector(function(d) { return d.date; }).left,
         //     formatValue = d3.format(",.0f"),
         //     formatCurrency = function(d) { return formatValue(d); }



         // Construct scales
         // ------------------------------

         // Horizontal
         var x = d3.scale.ordinal()
             .rangeRoundBands([0, width], .72, .5);

         // Vertical
         var y = d3.scale.linear()
                .range([height, 0]);



         // Create axes
         // ------------------------------

         // Horizontal
         var xAxis = d3.svg.axis()
             .scale(x)
             .orient("bottom")
            .ticks(9)

           // .tickFormat(formatPercent);


         // Vertical
         var yAxis = d3.svg.axis()
             .scale(y)
             .orient("left")
             .ticks(6);



         // Create chart
         // ------------------------------

         // Add SVG element
         var container = d3Container.append("svg");

         // Add SVG group
         var svg = container
             .attr("width", width + margin.left + margin.right)
             .attr("height", height + margin.top + margin.bottom)
             .append("g")
                 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");



         // Construct chart layout
         // ------------------------------

         // Line


         // Load data
         // ------------------------------

         // data = [[{"date": "Jan","close": 120},{"date": "Feb","close": 140},{"date": "Mar","close":160},{"date": "Apr","close": 180},{"date": "May","close": 200},{"date": "Jun","close": 220},{"date": "Jul","close": 240},{"date": "Aug","close": 260},{"date": "Sep","close": 280},{"date": "Oct","close": 300},{"date": "Nov","close": 320},{"date": "Dec","close": 340}],
         // [{"date":"Jan","close":10},{"date":"Feb","close":20},{"date":"Mar","close":30},{"date": "Apr","close": 40},{"date": "May","close": 50},{"date": "Jun","close": 60},{"date": "Jul","close": 70},{"date": "Aug","close": 80},{"date": "Sep","close": 90},{"date": "Oct","close": 100},{"date": "Nov","close": 120},{"date": "Dec","close": 140}],
         // ];
         data = [	
         	[<% for(int q=0; q<yearsarray.length(); q++){ 
      		  		String yer=yearsarray.get(q).toString(); 
      		  		int vlue = Integer.parseInt(graphyearspos.get(yer).toString());
      		  %>{"date":"<%=yer%>","close":<%=vlue%>},
      		<% } %>],
      		[<% for(int q=0; q<yearsarray.length(); q++){ 
  		  		String yer=yearsarray.get(q).toString(); 
  		  		int vlue = Integer.parseInt(graphyearsneg.get(yer).toString());
  		  %>{"date":"<%=yer%>","close":<%=vlue%>},
  		<% } %>]     	
         	];
         //console.log(data);
         // data = [];

         // data = [
         // [
         //   {
         //     "date": "Jan",
         //     "close": 1000
         //   },
         //   {
         //     "date": "Feb",
         //     "close": 1800
         //   },
         //   {
         //     "date": "Mar",
         //     "close": 1600
         //   },
         //   {
         //     "date": "Apr",
         //     "close": 1400
         //   },
         //   {
         //     "date": "May",
         //     "close": 2500
         //   },
         //   {
         //     "date": "Jun",
         //     "close": 500
         //   },
         //   {
         //     "date": "Jul",
         //     "close": 100
         //   },
         //   {
         //     "date": "Aug",
         //     "close": 500
         //   },
         //   {
         //     "date": "Sep",
         //     "close": 2300
         //   },
         //   {
         //     "date": "Oct",
         //     "close": 1500
         //   },
         //   {
         //     "date": "Nov",
         //     "close": 1900
         //   },
         //   {
         //     "date": "Dec",
         //     "close": 4170
         //   }
         // ]
         // ];

         // console.log(data);
         var line = d3.svg.line()
         .interpolate("monotone")
              //.attr("width", x.rangeBand())
             .x(function(d) { return x(d.date); })
             .y(function(d) { return y(d.close); });
             // .x(function(d){d.forEach(function(e){return x(d.date);})})
             // .y(function(d){d.forEach(function(e){return y(d.close);})});



         // Create tooltip
         var tip = d3.tip()
                .attr('class', 'd3-tip')
                .offset([-10, 0])
                .html(function(d) {
                if(d === null)
                {
                  return "No Information Available";
                }
                else if(d !== null) {
                 return d.date+" ("+d.close+")<br/> Click for more information";
                  }
                // return "here";
                });

                var color = d3.scale.linear()
                        .domain([0,1,2,3,4,5,6,10,15,20,80])
                        .range(["#CE0202", "#28A745", "#CE0202", "#aaa", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"]);
            // Initialize tooltip
            //svg.call(tip);


           // Pull out values
           // data.forEach(function(d) {
           //     d.frequency = +d.close;
           //
           // });


                     // Pull out values
                     // data.forEach(function(d) {
                     //     // d.date = parseDate(d.date);
                     //     //d.date = +d.date;
                     //     //d.date = d.date;
                     //     d.close = +d.close;
                     // });

                     // Sort data
                     // data.sort(function(a, b) {
                     //     return a.date - b.date;
                     // });


                     // Set input domains
                     // ------------------------------

                     // Horizontal
           //  console.log(data[0])


                   // Vertical
         // extract max value from list of json object
         // console.log(data.length)
             var maxvalue =
             data.map(function(d){
               var mvalue = [];
               if(data.length > 1)
             {
               d.forEach(function(f,i){
               mvalue[i] = f.close;

               })
             return d3.max(mvalue);
             }

             //console.log(mvalue);
             });



         ////console.log(data)
         if(data.length == 1)
         {
           var returnedvalue = data[0].map(function(e){
           return e.date
           });

         // for single json data
         x.domain(returnedvalue);
         // rewrite x domain

         var maxvalue2 =
         data.map(function(d){
         return d3.max(d,function(t){return t.close});
         });
         y.domain([0,maxvalue2]);
         }
         else if(data.length > 1)
         {
         //console.log(data.length);
         //console.log(data);

         var returnedata = data.map(function(e){
         // console.log(k)
         var all = []
         e.forEach(function(f,i){
         all[i] = f.date;
         //console.log(all[i])
         })
         return all
         //console.log(all);
         });
         // console.log(returnedata);
         // combines all the array
         var newArr = returnedata.reduce((result,current) => {
         return result.concat(current);
         });

         //console.log(newArr);
         var set = new Set(newArr);
         var filteredArray = Array.from(set);
         //console.log(filteredArray.sort());
         // console.log(returnedata);
         x.domain(filteredArray);
         y.domain([0, d3.max(maxvalue)]);
         }




                     //
                     // Append chart elements
                     //




         // svg.call(tip);
                      // data.map(function(d){})
                      if(data.length == 1)
                      {
                        // Add line
                      var path = svg.selectAll('.d3-line')
                                .data(data)
                                .enter()
                                .append("path")
                                .attr("class", "d3-line d3-line-medium")
                                .attr("d", line)
                                // .style("fill", "rgba(0,0,0,0.54)")
                                .style("stroke-width", 2)
                                .style("stroke", "17394C")
                                 .attr("transform", "translate("+margin.left/4.7+",0)");
                                // .datum(data)

                       // add point
                        circles = svg.selectAll(".circle-point")
                                  .data(data[0])
                                  .enter();


                              circles
                              // .enter()
                              .append("circle")
                              .attr("class","circle-point")
                              .attr("r",3.4)
                              .style("stroke", "#4CAF50")
                              .style("fill","#4CAF50")
                              .attr("cx",function(d) { return x(d.date); })
                              .attr("cy", function(d){return y(d.close)})

                              .attr("transform", "translate("+margin.left/4.7+",0)");

                              svg.selectAll(".circle-point").data(data[0])
                              .on("mouseover",tip.show)
                              .on("mouseout",tip.hide)
                              .on("click",function(d){console.log(d.date)});
                                                 svg.call(tip)
                      }
                      // handles multiple json parameter
                      else if(data.length > 1)
                      {
                        // add multiple line

                        var path = svg.selectAll('.d3-line')
                                  .data(data)
                                  .enter()
                                  .append("path")
                                  .attr("class", "d3-line d3-line-medium")
                                  .attr("d", line)
                                  // .style("fill", "rgba(0,0,0,0.54)")
                                  .style("stroke-width", 2)
                                  .style("stroke", function(d,i) { return color(i);})
                                  .attr("transform", "translate("+margin.left/4.7+",0)");




                       // add multiple circle points

                           // data.forEach(function(e){
                           // console.log(e)
                           // })

                           console.log(data);

                              var mergedarray = [].concat(...data);
                               console.log(mergedarray)
                                 circles = svg.selectAll(".circle-point")
                                     .data(mergedarray)
                                     .enter();

                                       circles
                                       // .enter()
                                       .append("circle")
                                       .attr("class","circle-point")
                                       .attr("r",3.4)
                                       .style("stroke", "#4CAF50")
                                       .style("fill","#4CAF50")
                                       .attr("cx",function(d) { return x(d.date)})
                                       .attr("cy", function(d){return y(d.close)})

                                       .attr("transform", "translate("+margin.left/4.7+",0)");
                                       svg.selectAll(".circle-point").data(mergedarray)
                                      .on("mouseover",tip.show)
                                      .on("mouseout",tip.hide)
                                      .on("click",function(d){console.log(d.date)});
                                 //                         svg.call(tip)

                               //console.log(newi);


                                     svg.selectAll(".circle-point").data(mergedarray)
                                     .on("mouseover",tip.show)
                                     .on("mouseout",tip.hide)
                                     .on("click",function(d){console.log(d.date)});
                                                        svg.call(tip)










                      }


         // show data tip


                     // Append axes
                     // ------------------------------

                     // Horizontal
                     svg.append("g")
                         .attr("class", "d3-axis d3-axis-horizontal d3-axis-strong")
                         .attr("transform", "translate(0," + height + ")")
                         .attr("transform", "translate(0," + y(0) + ")")
                         .call(xAxis);

                     // Vertical
                     var verticalAxis = svg.append("g")
                         .attr("class", "d3-axis d3-axis-vertical d3-axis-strong")
                         .call(yAxis);





                     // Add text label
                     verticalAxis.append("text")
                         .attr("transform", "rotate(-90)")
                         .attr("y", 10)
                         .attr("dy", ".71em")
                         .style("text-anchor", "end")
                         .style("fill", "#999")
                         .style("font-size", 12)
                         // .text("Frequency")
                         ;


         // Resize chart
         // ------------------------------

         // Call function on window resize
         $(window).on('resize', resize);

         // Call function on sidebar width change
         $('.sidebar-control').on('click', resize);

         // Resize function
         //
         // Since D3 doesn't support SVG resize by default,
         // we need to manually specify parts of the graph that need to
         // be updated on window resize
         function resize() {

           // Layout variables
           width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right;
           //
           //
           // // Layout
           // // -------------------------
           //
           // // Main svg width
           container.attr("width", width + margin.left + margin.right);
           //
           // // Width of appended group
           svg.attr("width", width + margin.left + margin.right);
           //
           //
           // // Axes
           // // -------------------------
           //
           // // Horizontal range
           x.rangeRoundBands([0, width],.72,.5);
           //
           // // Horizontal axis
           svg.selectAll('.d3-axis-horizontal').call(xAxis);
           //
           //
           // // Chart elements
           // // -------------------------
           //
           // // Line path
           svg.selectAll('.d3-line').attr("d", line);


           if(data.length == 1)
           {
             svg.selectAll(".circle-point").attr("circle",circles)
             .attr("cx",function(d) { return x(d.date);})
             .attr("cy", function(d){return y(d.close)});
           }
           else if(data.length > 1)
           {
             svg.selectAll(".circle-point").attr("circle",circles)
             .attr("cx",function(d) { return x(d.date);})
             .attr("cy", function(d){return y(d.close)});
           }
         }
     }
 });
 </script>

	<script>
  $('.carousel').carousel({
      interval: false
  });
  </script>

 <script src="pagedependencies/baseurl.js?v=3"></script>
 
<script src="pagedependencies/sentiment.js?v=1339"></script>


</body>
</html>

<% }} %>
