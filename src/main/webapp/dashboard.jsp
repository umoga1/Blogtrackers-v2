<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="util.*"%>
<%@page import="java.io.File"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.net.URI"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	Object tid = (null == request.getParameter("tid")) ? "" : request.getParameter("tid");

	Object user = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object date_start = (null == request.getParameter("date_start")) ? "" : request.getParameter("date_start");
	Object date_end = (null == request.getParameter("date_end")) ? "" : request.getParameter("date_end");
	Object single = (null == request.getParameter("single_date")) ? "" : request.getParameter("single_date");

	//System.out.println(date_start);
	if (email == null || email == "") {
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

		Trackers tracker = new Trackers();
		Terms term = new Terms();
		if (tid != "") {
			detail = tracker._fetch(tid.toString());
			System.out.println(detail);
		} else {
			detail = tracker._list("DESC", "", user.toString(), "1");
			System.out.println(detail);
		}
		
		
		boolean isowner = false;
		JSONObject obj = null;
		String ids = "";

		if (detail.size() > 0) {
			String res = detail.get(0).toString();

			JSONObject resp = new JSONObject(res);

			String resu = resp.get("_source").toString();
			obj = new JSONObject(resu);
			String tracker_userid = obj.get("userid").toString();
			if (tracker_userid.equals(user.toString())) {
				isowner = true;
				String query = obj.get("query").toString();
				query = query.replaceAll("blogsite_id in ", "");
				query = query.replaceAll("\\(", "");
				query = query.replaceAll("\\)", "");
				ids = query;
			}
		}
		userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = '" + email + "'");
		//System.out.println(userinfo);
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

			Date today = new Date();
			SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MMM d, yyyy");
			SimpleDateFormat DATE_FORMAT2 = new SimpleDateFormat("yyyy-MM-dd");

			SimpleDateFormat DAY_ONLY = new SimpleDateFormat("dd");
			SimpleDateFormat MONTH_ONLY = new SimpleDateFormat("MM");
			SimpleDateFormat WEEK_ONLY = new SimpleDateFormat("dd");
			SimpleDateFormat YEAR_ONLY = new SimpleDateFormat("yyyy");

			Date dstart = new SimpleDateFormat("yyyy-MM-dd").parse("2013-01-01");

			String day = DAY_ONLY.format(today);
			String month = MONTH_ONLY.format(today);
			String year = YEAR_ONLY.format(today);

			String dispfrom = DATE_FORMAT.format(dstart);
			String dispto = DATE_FORMAT.format(today);

			String dst = DATE_FORMAT2.format(dstart);
			String dend = DATE_FORMAT2.format(today);

			//ArrayList posts = post._list("DESC","");
			ArrayList sentiments = senti._list("DESC", "", "id");
			String totalpost = "0";

			String possentiment = "0";
			String negsentiment = "0";

			if (!date_start.equals("") && !date_end.equals("")) {
				totalpost = post._searchRangeTotal("date", date_start.toString(), date_end.toString(), ids);
				possentiment = post._searchRangeTotal("sentiment", "0", "10", ids);
				negsentiment = post._searchRangeTotal("sentiment", "-10", "-1", ids);

				Date start = new SimpleDateFormat("yyyy-MM-dd").parse(date_start.toString());
				Date end = new SimpleDateFormat("yyyy-MM-dd").parse(date_end.toString());

				dispfrom = DATE_FORMAT.format(start);
				dispto = DATE_FORMAT.format(end);
				termss = term._searchByRange("date", date_start.toString(), date_end.toString(), ids);
			} else if (single.equals("day")) {
				String dt = year + "-" + month + "-" + day;
				totalpost = post._searchRangeTotal("date", dt, dt, ids);
			} else if (single.equals("month")) {
				String dt = year + "-" + month + "-" + day;
				String dte = year + "-" + month + "-31";
				totalpost = post._searchRangeTotal("date", dt, dte, ids);
			} else if (single.equals("year")) {
				String dt = year + "-01-01";
				String dte = year + "-12-31";
				totalpost = post._searchRangeTotal("date", dt, dte, ids);
			} else {

				totalpost = post._getTotalByBlogId(ids, "");
				possentiment = post._searchRangeTotal("sentiment", "0", "10", ids);
				negsentiment = post._searchRangeTotal("sentiment", "-10", "-1", ids);
				termss = term._fetch(ids);
			}

			ArrayList blogs = blog._fetch(ids);
			int totalblog = blogs.size();
			//pimage = pimage.replace("build/", "");

			JSONObject sentimentblog = new JSONObject();;
			if (sentiments.size() > 0) {

				for (int p = 0; p < sentiments.size(); p++) {
					String bstr = sentiments.get(p).toString();
					JSONObject bj = new JSONObject(bstr);
					bstr = bj.get("_source").toString();
					bj = new JSONObject(bstr);
					String id = bj.get("blogsite_id").toString();
					//if(!sentimentblog.has(id)){
					sentimentblog.put(id, id);
					// }
				}
			}

			JSONArray topterms = new JSONArray();
			if (termss.size() > 0) {

				for (int p = 0; p < termss.size(); p++) {
					String bstr = termss.get(p).toString();
					JSONObject bj = new JSONObject(bstr);
					bstr = bj.get("_source").toString();
					bj = new JSONObject(bstr);
					String frequency = bj.get("frequency").toString();
					String tm = bj.get("term").toString();
					JSONObject cont = new JSONObject();
					cont.put("key", tm);
					cont.put("frequency", frequency);
					topterms.put(cont);
				}
			}

			//System.out.println("senti"+ sentimentblog);
			JSONObject language = new JSONObject();
			JSONObject bloggers = new JSONObject();

			ArrayList looper = new ArrayList();
			ArrayList langlooper = new ArrayList();

			if (blogs.size() > 0) {
				String bres = null;
				JSONObject bresp = null;

				String bresu = null;
				JSONObject bobj = null;
				int m = 0;
				int n = 0;
				for (int k = 0; k < blogs.size(); k++) {
					bres = blogs.get(k).toString();
					bresp = new JSONObject(bres);
					bresu = bresp.get("_source").toString();
					bobj = new JSONObject(bresu);
					String lang = bobj.get("language").toString();
					String blogger = bobj.get("blogsite_owner").toString();
					String blogname = bobj.get("blogsite_name").toString();
					String sentiment = "1";// bobj.get("sentiment").toString();
					String posting = bobj.get("totalposts").toString();

					JSONObject content = new JSONObject();

					String durl = bobj.get("blogsite_url").toString();//"";
					try {
						URI uri = new URI(bobj.get("blogsite_url").toString());
						String domain = uri.getHost();
						if (domain.startsWith("www.")) {
							durl = domain.substring(4);
						} else {
							durl = domain;
						}
					} catch (Exception ex) {
					}

					if (bloggers.has(blogger)) {
						content = new JSONObject(bloggers.get(blogger).toString());
						int valu = Integer.parseInt(content.get("value").toString()) + 1;
						content.put("blog", blogname);
						content.put("id", bobj.get("blogsite_id").toString());
						content.put("blogger", blogger);
						content.put("sentiment", sentiment);
						content.put("postingfreq", posting);
						content.put("totalposts", bobj.get("totalposts").toString());
						content.put("value", valu);
						content.put("blogsite_url", bobj.get("blogsite_url").toString());
						content.put("blogsite_domain", durl);
						bloggers.put(blogger, content);
					} else {
						int valu = 1;
						content.put("blog", blogname);
						content.put("id", bobj.get("blogsite_id").toString());
						content.put("blogger", blogger);
						content.put("sentiment", sentiment);
						content.put("postingfreq", posting);
						content.put("value", valu);
						content.put("totalposts", bobj.get("totalposts").toString());
						content.put("blogsite_url", bobj.get("blogsite_url").toString());
						content.put("blogsite_domain", durl);
						bloggers.put(blogger, content);
						looper.add(m, blogger);
						m++;
					}
					//Object ex = language.get(lang);
					if (language.has(lang)) {
						int val = Integer.parseInt(language.get(lang).toString()) + 1;
						language.put(lang, val);
					} else {
						//  	int val  = Integer.parseInt(ex.toString())+1;
						language.put(lang, 1);
						langlooper.add(n, lang);
						n++;
					}

				}

			}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Blogtrackers - Dashboard</title>
<!-- start of bootsrap -->
<link rel="shortcut icon" href="images/favicons/favicon-48x48.png">
<link rel="apple-touch-icon" href="images/favicons/favicon-48x48.png">
<link rel="apple-touch-icon" sizes="96x96"
	href="images/favicons/favicon-96x96.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="images/favicons/favicon-144x144.png">

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
<link rel="stylesheet"
	href="assets/vendors/DataTables/Buttons-1.5.1/css/buttons.dataTables.min.css" />
<link rel="stylesheet" href="assets/css/daterangepicker.css" />
<link rel="stylesheet" href="assets/css/style.css" />
<!-- <link rel="stylesheet" href="assets/css/bar.css" /> -->
<!--end of bootsrap -->
<link rel="stylesheet" href="assets/css/toastr.css">

<script src="assets/js/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/toastr.js"></script>

<!-- <script src="assets/js/jquery-3.2.1.slim.min.js"></script>-->
<script src="assets/js/popper.min.js"></script>
<script src="pagedependencies/googletagmanagerscript.js"></script>
</head>
<body>
<%@include file="subpages/googletagmanagernoscript.jsp" %>
	<div class="modal-notifications">
		<div class="row">
			<div class="col-lg-10 closesection"></div>
			<div class="col-lg-2 col-md-12 notificationpanel">
				<div id="closeicon" class="cursor-pointer">
					<i class="fas fa-times-circle"></i>
				</div>
				<div class="profilesection col-md-12 mt50">
					<div class="text-center mb10">
						<img src="<%=profileimage%>" width="60" height="60"
							onerror="this.src='images/default-avatar.png'" alt="" />
					</div>
					<div class="text-center" style="margin-left: 0px;">
						<h6 class="text-primary m0 bolder profiletext"><%=name%></h6>
						<p class="text-primary profiletext"><%=email%></p>
					</div>

				</div>
				<div id="othersection" class="col-md-12 mt10" style="clear: both">
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
				</div>
			</div>
		</div>
	</div>



	<nav class="navbar navbar-inverse bg-primary">
		<div class="container-fluid mt10 mb10">

			<div class="navbar-header d-none d-lg-inline-flex d-xl-inline-flex  col-lg-3">
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
				<ul class="nav navbar-nav" style="display: block;">
					<li class="dropdown dropdown-user cursor-pointer float-right">
						<a class="dropdown-toggle " id="profiletoggle"
						data-toggle="dropdown"> <i class="fas fa-circle"
							id="notificationcolor"></i> <img src="<%=profileimage%>"
							width="50" height="50"
							onerror="this.src='images/default-avatar.png'" alt="" class="" />
							<span class="bold-text"><%=user_name[0]%></span> <!-- <ul class="profilemenu dropdown-menu dropdown-menu-left">
              <li><a href="#"> My profile</a></li>
              <li><a href="#"> Features</a></li>
              <li><a href="#"> Help</a></li>
              <li><a href="#">Logout</a></li>
  </ul> -->
					</a>

					</li>
				</ul>
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
		<!-- <div class="profilenavbar" style="visibility:hidden;"></div> -->


	</nav>


	<div class="container">
		<div class="row">
			<div class="col-md-6 ">
				<nav class="breadcrumb">
					<a class="breadcrumb-item text-primary"
						href="<%=request.getContextPath()%>/trackerlist.jsp">My	Trackers</a> <a class="breadcrumb-item text-primary"
						href="<%=request.getContextPath()%>/edittracker.jsp"><%=obj.get("tracker_name").toString()%></a>
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
							<input type="radio" name="options" value="day"
							class="option-only" autocomplete="off"> Day
						</label> <label class="btn btn-primary btn-sm nobgnoborder"> <input
							type="radio" class="option-only" name="options" value="week"
							autocomplete="off">Week
						</label> <label class="btn btn-primary btn-sm nobgnoborder"> <input
							type="radio" class="option-only" name="options" value="month"
							autocomplete="off"> Month
						</label> <label class="btn btn-primary btn-sm text-center nobgnoborder">Year
							<input type="radio" class="option-only" name="options"
							value="year" autocomplete="off">
						</label>
						<!-- <label class="btn btn-primary btn-sm nobgnoborder" id="custom">Custom</label> -->
					</div>

				</div>
			</div>

		</div>

		<div class="row p0 pt20 pb20 border-top-bottom mt20 mb20">
			<div class="col-md-2">
				<div class="card nocoloredcard mt10 mb10">
					<div class="card-body p0 pt5 pb5">
						<h5 class="text-primary mb0">
							<i class="fas fa-file-alt icondash"></i>Blogs
						</h5>
						<h3 class="text-blue mb0 countdash dash-label"><%=totalblog%></h3>
					</div>
				</div>
			</div>

			<div class="col-md-2">
				<div class="card nocoloredcard mt10 mb10">
					<div class="card-body p0 pt5 pb5">
						<h5 class="text-primary mb0">
							<i class="fas fa-user icondash"></i>Bloggers
						</h5>
						<h3 class="text-blue mb0 countdash dash-label"><%=bloggers.length()%></h3>
					</div>
				</div>
			</div>

			<div class="col-md-2">
				<div class="card nocoloredcard mt10 mb10">
					<div class="card-body p0 pt5 pb5">
						<h5 class="text-primary mb0">
							<i class="fas fa-file-alt icondash"></i>Posts
						</h5>
						<h3 class="text-blue mb0 countdash dash-label"><%=totalpost%></h3>
					</div>
				</div>
			</div>

			<div class="col-md-2">
				<div class="card nocoloredcard mt10 mb10">
					<div class="card-body p0 pt5 pb5">
						<h5 class="text-primary mb0">
							<i class="fas fa-comment icondash"></i>Comments
						</h5>
						<h3 class="text-blue mb0 countdash dash-label">3</h3>
					</div>
				</div>
			</div>


			<div class="col-md-4">
				<div class="card nocoloredcard mt10 mb10">
					<div class="card-body p0 pt5 pb5">
						<h5 class="text-primary mb0">
							<i class="fas fa-clock icondash"></i>History
						</h5>
						<h3 class="text-blue mb0 countdash dash-label"><%=dispfrom%>
							-
							<%=dispto%></h3>
					</div>
				</div>
			</div>

		</div>

		<div class="row mb0">
			<div class="col-md-6 mt20 ">
				<div class="card card-style mt20">
					<div class="card-body  p15 pt15 pb15">
						<div>
							<p class="text-primary mt0 float-left">
								Most Active Location <select
									class="text-primary filtersort sortbyblogblogger"><option
										value="blogs">Blogs</option>
									<option value="bloggers">Bloggers</option></select>of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div style="min-height: 490px;">
							<div class="map-container map-choropleth"></div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-6 mt20">
				<div class="card  card-style  mt20">
					<div class="card-body  p30 pt5 pb5">
						<div>
							<p class="text-primary mt10 float-left">
								Language Usage of <select
									class="text-primary filtersort sortbyblogblogger"><option
										value="blogs">Blogs</option>
									<option value="bloggers">Bloggers</option></select> of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div class="min-height-table" style="min-height: 500px;">
							<div class="chart-container">
								<div class="chart" id="languageusage"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row mb0">
			<div class="col-md-12 mt20">

				<div class="card  card-style  mt20">
					<div class="card-body  p30 pt5 pb5">
						<div>
							<p class="text-primary mt10 float-left">
								Posting Frequency of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div class="min-height-table" style="min-height: 300px;">
							<div class="chart-container">
								<div class="chart" id="postingfrequency"></div>
							</div>
						</div>
					</div>
				</div>


			</div>
		</div>

		<div class="row mb0">
			<div class="col-md-6 mt20 ">
				<div class="card card-style mt20">
					<div class="card-body  p30 pt5 pb5">
						<div>
							<p class="text-primary mt10">
								Top Keywords of <select
									class="text-primary filtersort sortbyblogblogger"><option
										value="blogs">Blogs</option>
									<option value="bloggers">Bloggers</option></select> of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div class="tagcloudcontainer" style="min-height: 420px;"></div>
					</div>
				</div>
				<div class="float-right">
					<a href="keywordtrend.jsp"><button
							class="btn buttonportfolio2 mt10">
							<b class="float-left semi-bold-text">Keyword Trend Analysis </b>
							<b class="fas fa-search float-right icondash2"></b>
						</button></a>
				</div>
			</div>

			<div class="col-md-6 mt20">
				<div class="card card-style mt20">
					<div class="card-body  p30 pt5 pb5">
						<div>
							<p class="text-primary mt10">
								Sentiment Usage of <select
									class="text-primary filtersort sortbyblogblogger"><option
										value="blogs">Blogs</option>
									<option value="bloggers">Bloggers</option></select> of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div style="min-height: 420px;">
							<div class="chart-container">
								<div class="chart" id="sentimentbar"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="float-right">
					<a
						href="<%=request.getContextPath()%>/sentiment.jsp?tid=<%=obj.get("tid").toString()%>"><button
							class="btn buttonportfolio2 mt10">
							<b class="float-left semi-bold-text">Sentiment Analysis </b> <b
								class="fas fa-adjust float-right icondash2"></b>
						</button></a>
				</div>
			</div>
		</div>

		<div class="row mb0">
			<div class="col-md-6 mt20">
				<div class="card card-style mt20">
					<div class="card-body   p30 pt5 pb5">
						<div>
							<p class="text-primary mt10 float-left">
								Blog Distribution of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div class="min-height-table" style="min-height: 500px;">
							<div class="chart-container">
								<div class="chart" id="bubblesblog"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="float-right">
					<a href="blogportfolio.jsp"><button
							class="btn buttonportfolio2 mt10">
							<b class="float-left semi-bold-text">Blog Portfolio Analysis</b>
							<b class="fas fa-file-alt float-right icondash2"></b>
						</button></a>
				</div>

			</div>

			<div class="col-md-6 mt20">
				<div class="card card-style mt20">
					<div class="card-body p30 pt5 pb5">
						<div>
							<p class="text-primary mt10 float-left">
								Blogger Distribution of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div class="min-height-table" style="min-height: 450px;">
							<div class="chart-container">
								<div class="chart" id="bubblesblogger"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="float-right">
					<a href="bloggerportfolio.jsp"><button
							class="btn buttonportfolio2 mt10">
							<b class="float-left semi-bold-text">Blogger Portfolio
								Analysis </b> <b class="fas fa-user float-right icondash2"></b>
						</button></a>
				</div>

			</div>

		</div>

		<div class="row mb0">
			<div class="col-md-6 mt20">
				<div class="card card-style mt20">
					<div class="card-body   p30 pt5 pb5">
						<div>
							<p class="text-primary mt10 float-left">
								Most Active <select
									class="text-primary filtersort sortbyblogblogger"><option
										value="blogs">Blogs</option>
									<option value="bloggers">Bloggers</option></select> of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div class="min-height-table" style="min-height: 500px;">
							<div class="chart-container">
								<div class="chart" id="postingfrequencybar"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="float-right">
					<a href="postingfrequency.jsp"><button
							class="btn buttonportfolio2 mt10">
							<b class="float-left semi-bold-text">Posting Frequency
								Analysis</b> <b class="fas fa-comment-alt float-right icondash2"></b>
						</button></a>
				</div>

			</div>

			<div class="col-md-6 mt20">
				<div class="card card-style mt20">
					<div class="card-body p30 pt5 pb5">
						<div>
							<p class="text-primary mt10 float-left">
								Most Influential <select
									class="text-primary filtersort sortbyblogblogger"><option
										value="blogs">Blogs</option>
									<option value="bloggers">Bloggers</option></select> of Past <select
									class="text-primary filtersort sortbytimerange"><option
										value="week">Week</option>
									<option value="month">Month</option>
									<option value="year">Year</option></select>
							</p>
						</div>
						<div class="min-height-table" style="min-height: 500px;">
							<div class="chart-container">
								<div class="chart" id="influencebar"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="float-right">
					<a href="influence.jsp"><button
							class="btn buttonportfolio2 mt10">
							<b class="float-left semi-bold-text">Influence Analysis </b> <b
								class="fas fa-exchange-alt float-right icondash2"></b>
						</button></a>
				</div>

			</div>

		</div>

		<div class="row mb50">
			<div class="col-md-12 mt20 ">
				<div class="card card-style mt20">
					<div class="card-body  p5 pt10 pb10">

						<div style="min-height: 420px;">
							<div>
								<p class="text-primary p15 pb5 pt0">
									List of Top Domains of <select
										class="text-primary filtersort sortbyblogblogger"><option
											value="blogs">Blogs</option>
										<option value="bloggers">Bloggers</option></select> of Past <select
										class="text-primary filtersort sortbytimerange"><option
											value="week">Week</option>
										<option value="month">Month</option>
										<option value="year">Year</option></select>
								</p>
							</div>
							<!--   <div class="p15 pb5 pt0" role="group">
          Export Options
          </div> -->
							<table id="DataTables_Table_0_wrapper" class="display"
								style="width: 100%">
								<thead>
									<tr>
										<th>Domain</th>
										<th>Frequency</th>

									</tr>
								</thead>
								<tbody>
									<%
										if (bloggers.length() > 0) {
													//System.out.println(bloggers);
													for (int y = 0; y < bloggers.length(); y++) {
														String key = looper.get(y).toString();
														JSONObject resu = bloggers.getJSONObject(key);
									%>
									<tr>
										<td class=""><%=resu.get("blogsite_domain")%></td>
										<td><%=resu.get("value")%></td>
									</tr>
									<%
										}
}
									%>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<%-- <%--  <div class="col-md-6 mt20">
    <div class="card card-style mt20">
      <div class="card-body  p5 pt10 pb10">
        <div class="min-height-table"style="min-height: 420px;">
          <!-- <div class="dropdown show"><p class="text-primary p15 pb5 pt0">List of Top URLs of <a class=" dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false" id="blogbloggermenu1" role="button">Blogs</a> of Past <b>Week</b></p>
            <div class="dropdown-menu" aria-labelledby="blogbloggermenu1">
               <a class="dropdown-item" href="#">Action</a>
               <a class="dropdown-item" href="#">Another action</a>
               <a class="dropdown-item" href="#">Something else here</a>
             </div>
          </div> -->

<div class="dropdown show text-primary p15 pb20 pt0">List of Top URLs of <select class="text-primary filtersort sortbyblogblogger"><option value="blogs">Blogs</option><option value="bloggers">Bloggers</option></select> of Past <select class="text-primary filtersort sortbytimerange"><option value="week">Week</option><option value="month">Month</option><option value="year">Year</option></select>

 

</div>

          <!-- Example split danger button -->

         <!--  <div class="p15 pb5 pt0" role="group">
          Export Options
          </div> -->
                <table id="DataTables_Table_1_wrapper" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>URL</th>
                                <th>Frequency</th>


                            </tr>
                        </thead>
                        <tbody>
                        <% if(bloggers.length()>0){
							//System.out.println(bloggers);
							for(int y=0; y<bloggers.length(); y++){
								String key = looper.get(y).toString();
								 JSONObject resu = bloggers.getJSONObject(key);
						%>
						<tr>
                              <td><%=resu.get("blogsite_url")%></td>
                              <td><%=resu.get("value")%></td>
                        </tr>
						<% }} %>
                            
                            

                        </tbody>
                    </table>
        </div>
          </div>
    </div>
  </div> --%>
		</div>



	</div>

	<form action="" name="customformsingle" id="customformsingle"
		method="post">
		<input type="hidden" name="tid" value="<%=tid%>" /> <input
			type="hidden" name="single_date" id="single_date" value="" />
	</form>

	<form action="" name="customform" id="customform" method="post">
		<input type="hidden" name="tid" value="<%=tid%>" /> <input
			type="hidden" name="date_start" id="date_start" value="" /> <input
			type="hidden" name="date_end" id="date_end" value="" />
	</form>

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
	<!-- date range scripts -->
	<script src="assets/vendors/bootstrap-daterangepicker/moment.js"></script>
	<script
		src="assets/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
	<!--End of date range scripts  -->
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
	
  // datatable setup
    $('#DataTables_Table_1_wrapper').DataTable( {
        "scrollY": 430,
        "scrollX": false,
         "pagingType": "simple"
      /*    ,
         dom: 'Bfrtip',
         "columnDefs": [
      { "width": "80%", "targets": 0 }
    ],
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

// table set up 2
    $('#DataTables_Table_0_wrapper').DataTable( {
        "scrollY": 430,
        "scrollX": false,
         "pagingType": "simple"
    /*      ,
         dom: 'Bfrtip',

         "columnDefs": [
      { "width": "80%", "targets": 0 }
    ],
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
	
	 $('#printdoc').on('click',function(){
			print();
		}) ;
  $(document)
             .ready(
                 function() {
                   // date range configuration
   var cb = function(start, end, label) {
          //console.log(start.toISOString(), end.toISOString(), label);
          //$('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
          $('#reportrange input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')).trigger('change');
        };

        var optionSet1 =
             {   startDate: moment().subtract(90, 'days'),
                 endDate: moment(),
                 minDate: '01/01/1947',
                 maxDate: moment(),
                 maxSpan: {
                     days: 50000
                 },
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
      //$('#reportrange span').html(moment().subtract( 500, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'))
     $('#reportrange, #custom').daterangepicker(optionSet1, cb);
     $('#reportrange, #custom')
     .on(
         'show.daterangepicker',
         function() {
         	console
               .log("show event fired"); 
         });
  $('#reportrange')
     .on(
         'hide.daterangepicker',
         function() {
           /* console
               .log("hide event fired"); */
         });
  $('#reportrange, #custom')
     .on(
         'apply.daterangepicker',
         function(ev, picker) {
            console
               .log("apply event fired, start/end dates are "
                   + picker.startDate
                       .format('MMMM D, YYYY')
                   + " to "
                   + picker.endDate
                       .format('MMMM D, YYYY')); 
            	console.log("applied");
            	
            	var start = picker.startDate.format('YYYY-MM-DD');
            	var end = picker.endDate.format('YYYY-MM-DD');
            	//console.log("End:"+end);
            	
            	$("#date_start").val(start);
            	$("#date_end").val(end);
            	//toastr.success('Date changed!','Success');
            	$("form#customform").submit();
         });
  $('#reportrange')
     .on(
         'cancel.daterangepicker',
         function(ev, picker) {
           console.log("cancel event fired"); 
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
	<!-- <script src="http://d3js.org/d3.v3.min.js"></script> -->
	<script type="text/javascript" src="assets/vendors/d3/d3.min.js"></script>
	<script src="assets/vendors/wordcloud/d3.layout.cloud.js"></script>
	<script type="text/javascript" src="assets/vendors/d3/d3_tooltip.js"></script>
	<!--start of language bar chart  -->
	<script>
$(function () {

    // Initialize chart
    languageusage('#languageusage', 455);

    // Chart setup
    function languageusage(element, height) {

      // Basic setup
      // ------------------------------

      // Define main variables
      var d3Container = d3.select(element),
          margin = {top: 5, right: 50, bottom: 20, left: 60},
          width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
          height = height - margin.top - margin.bottom - 5;

         var formatPercent = d3.format("");

      // Construct scales
      // ------------------------------

      // Horizontal
      var y = d3.scale.ordinal()
          .rangeRoundBands([height,0], .2, .5);

      // Vertical
      var x = d3.scale.linear()
          .range([0,width]);

      // Color
      var color = d3.scale.category20c();



      // Create axes
      // ------------------------------

      // Horizontal
      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom")
          .ticks(6);

      // Vertical
      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left")
          //.tickFormat(formatPercent);



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


      //         // Create tooltip
      //             // ------------------------------
      //
      //
      //
      // // Load data
      // // ------------------------------
      //
      //
      //
      data = [
    	  <%if (langlooper.size() > 0) {
						for (int y = 0; y < langlooper.size(); y++) {
							String key = langlooper.get(y).toString();%>
    		{letter:"<%=key%>", frequency:<%=language.get(key)%>},
    		<%}
					}%>

	 ];
      /*
      data = [
            {letter:"English", frequency:2550},
            {letter:"Russian", frequency:800},
            {letter:"Spanish", frequency:500},
            {letter:"French", frequency:1700},
            {letter:"Arabic", frequency:1900},
            {letter:"Unknown", frequency:1500}
        ];
      */
      //
      //
      //   // Create tooltip
        var tip = d3.tip()
               .attr('class', 'd3-tip')
               .offset([-10, 0])
               .html(function(d) {
                   return d.letter+" ("+d.frequency+")";
               });

           // Initialize tooltip
           svg.call(tip);

      //
      //     // Pull out values
      //     data.forEach(function(d) {
      //         d.frequency = +d.frequency;
      //     });
      //
      //
      //
      //     // Set input domains
      //     // ------------------------------
      //
      //     // Horizontal
          y.domain(data.map(function(d) { return d.letter; }));

          // Vertical
          x.domain([0,d3.max(data, function(d) { return d.frequency; })]);
      //
      //
      //     //
      //     // Append chart elements
      //     //
      //
      //     // Append axes
      //     // ------------------------------
      //
          // Horizontal
          svg.append("g")
              .attr("class", "d3-axis d3-axis-horizontal d3-axis-strong")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);

          // Vertical
          var verticalAxis = svg.append("g")
              .attr("class", "d3-axis d3-axis-vertical d3-axis-strong")
              .style("color","yellow")
              .call(yAxis);
      //
      //
      //     // Add text label
      //     verticalAxis.append("text")
      //         .attr("transform", "rotate(-90)")
      //         .attr("y", 10)
      //         .attr("dy", ".71em")
      //         .style("text-anchor", "end")
      //         .style("fill", "#999")
      //         .style("font-size", 12)
      //         // .text("Frequency")
      //         ;
      //
      //
      //     // Add bars
          svg.selectAll(".d3-bar")
              .data(data)
              .enter()
              .append("rect")
                  .attr("class", "d3-bar")
                  .attr("y", function(d) { return y(d.letter); })
                  .attr("height", y.rangeBand())
                  .attr("x", function(d) { return 0; })
                  .attr("width", function(d) { return x(d.frequency); })
                  .style("fill", function(d) {
                  maxvalue = d3.max(data, function(d) { return d.frequency; });
                  if(d.frequency == maxvalue)
                  {
                    return "0080CC";
                  }
                  else
                  {
                    return "#78BCE4";
                  }

                })
                  .on('mouseover', tip.show)
                  .on('mouseout', tip.hide);


                  // svg.selectAll(".d3-bar")
                  //     .data(data)
                  //     .enter()
                  //     .append("rect")
                  //         .attr("class", "d3-bar")
                  //         .attr("x", function(d) { return x(d.letter); })
                  //         .attr("width", x.rangeBand())
                  //         .attr("y", function(d) { return y(d.frequency); })
                  //         .attr("height", function(d) { return height - y(d.frequency); })
                  //         .style("fill", function(d) { return "#58707E"; })
                  //         .on('mouseover', tip.show)
                  //         .on('mouseout', tip.hide);





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


            // // Layout
            // // -------------------------
            //
            // // Main svg width
            container.attr("width", width + margin.left + margin.right);

            // Width of appended group
            svg.attr("width", width + margin.left + margin.right);
            //
            //
            // // Axes
            // // -------------------------
            //
            // // Horizontal range
           x.range([0,width]);
            //
            // // Horizontal axis
            svg.selectAll('.d3-axis-horizontal').call(xAxis);
             // svg.selectAll('.d3-bar-vertical').call(yAxis);

            //
            // // Chart elements
            // // -------------------------
            //
            // // Line path
           svg.selectAll('.d3-bar').attr("width", function(d) { return x(d.frequency); });
        }
    }
});
</script>

	<!-- End of language bar chart  -->

	<!-- start of influence bar chart  -->
	<script>
$(function () {

    // Initialize chart
    influencebar('#influencebar', 450);

    // Chart setup
    function influencebar(element, height) {

      // Basic setup
      // ------------------------------

      // Define main variables
      var d3Container = d3.select(element),
          margin = {top: 5, right: 50, bottom: 20, left: 60},
          width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
          height = height - margin.top - margin.bottom - 5;

         var formatPercent = d3.format("");

      // Construct scales
      // ------------------------------

      // Horizontal
      var y = d3.scale.ordinal()
          .rangeRoundBands([height,0], .5, .40);

      // Vertical
      var x = d3.scale.linear()
          .range([0,width]);

      // Color
      var color = d3.scale.category20c();



      // Create axes
      // ------------------------------

      // Horizontal
      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom")
          .ticks(6);

      // Vertical
      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left")
          //.tickFormat(formatPercent);



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


      //         // Create tooltip
      //             // ------------------------------
      //
      //
      //
      // // Load data
      // // ------------------------------
      //
      //
      //
      data = [
    	  <%if (bloggers.length() > 0) {
						//System.out.println(bloggers);
						int q = 0;
						for (int y = 0; y < bloggers.length(); y++) {
							String key = looper.get(y).toString();
							JSONObject resu = bloggers.getJSONObject(key);
							String id = resu.get("id").toString();

							int size = Integer.parseInt(resu.get("totalposts").toString());
							if (sentimentblog.has(id) && q < 10) {
								q++;%>
			{letter:"<%=resu.get("blog")%>", frequency:<%=size%>, name:"<%=resu.get("blogger")%>", type:"blogger"},
			 <%}
						}
					}%>
            //{letter:"Blog 5", frequency:2550, name:"Obadimu Adewale", type:"blogger"},
            
        ];
      //
      //
      //   // Create tooltip
        var tip = d3.tip()
               .attr('class', 'd3-tip')
               .offset([-10, 0])
               .html(function(d) {
                 if(d.type === "blogger")
                 {
                   return d.letter+" ("+d.frequency+")<br/> Blogger: "+d.name;
                 }

                 if(d.type === "blog")
                 {
                   return d.letter+" ("+d.frequency+")<br/> Blog: "+d.name;
                 }

               });

           // Initialize tooltip
           svg.call(tip);

      //
      //     // Pull out values
      //     data.forEach(function(d) {
      //         d.frequency = +d.frequency;
      //     });
      //
      //
      //
      //     // Set input domains
      //     // ------------------------------
      //
      //     // Horizontal
          y.domain(data.map(function(d) { return d.letter; }));

          // Vertical
          x.domain([0,d3.max(data, function(d) { return d.frequency; })]);
      //
      //
      //     //
      //     // Append chart elements
      //     //
      //
      //     // Append axes
      //     // ------------------------------
      //
          // Horizontal
          svg.append("g")
              .attr("class", "d3-axis d3-axis-horizontal d3-axis-strong")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);

          // Vertical
          var verticalAxis = svg.append("g")
              .attr("class", "d3-axis d3-axis-vertical d3-axis-strong")
              .style("color","yellow")
              .call(yAxis);
      //
      //
      //     // Add text label
      //     verticalAxis.append("text")
      //         .attr("transform", "rotate(-90)")
      //         .attr("y", 10)
      //         .attr("dy", ".71em")
      //         .style("text-anchor", "end")
      //         .style("fill", "#999")
      //         .style("font-size", 12)
      //         // .text("Frequency")
      //         ;
      //
      //
      //     // Add bars
          svg.selectAll(".d3-bar")
              .data(data)
              .enter()
              .append("rect")
                  .attr("class", "d3-bar")
                  .attr("y", function(d) { return y(d.letter); })
                  .attr("height", y.rangeBand())
                  .attr("x", function(d) { return 0; })
                  .attr("width", function(d) { return x(d.frequency); })
                  .style("fill", function(d) {
                  maxvalue = d3.max(data, function(d) { return d.frequency; });
                  if(d.frequency == maxvalue)
                  {
                    return "0080CC";
                  }
                  else
                  {
                    return "#78BCE4";
                  }

                })
                  .on('mouseover', tip.show)
                  .on('mouseout', tip.hide);


                  // svg.selectAll(".d3-bar")
                  //     .data(data)
                  //     .enter()
                  //     .append("rect")
                  //         .attr("class", "d3-bar")
                  //         .attr("x", function(d) { return x(d.letter); })
                  //         .attr("width", x.rangeBand())
                  //         .attr("y", function(d) { return y(d.frequency); })
                  //         .attr("height", function(d) { return height - y(d.frequency); })
                  //         .style("fill", function(d) { return "#58707E"; })
                  //         .on('mouseover', tip.show)
                  //         .on('mouseout', tip.hide);





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


            // // Layout
            // // -------------------------
            //
            // // Main svg width
            container.attr("width", width + margin.left + margin.right);

            // Width of appended group
            svg.attr("width", width + margin.left + margin.right);
            //
            //
            // // Axes
            // // -------------------------
            //
            // // Horizontal range
           x.range([0,width]);
            //
            // // Horizontal axis
            svg.selectAll('.d3-axis-horizontal').call(xAxis);
             // svg.selectAll('.d3-bar-vertical').call(yAxis);

            //
            // // Chart elements
            // // -------------------------
            //
            // // Line path
           svg.selectAll('.d3-bar').attr("width", function(d) { return x(d.frequency); });
        }
    }
});
</script>

	<!--  End of influence bar -->

	<!-- start of posting frequency  -->
	<script>
$(function () {

    // Initialize chart
    postingfrequencybar('#postingfrequencybar', 450);

    // Chart setup
    function postingfrequencybar(element, height) {

      // Basic setup
      // ------------------------------

      // Define main variables
      var d3Container = d3.select(element),
          margin = {top: 5, right: 50, bottom: 20, left: 60},
          width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
          height = height - margin.top - margin.bottom - 5;

         var formatPercent = d3.format("");

      // Construct scales
      // ------------------------------

      // Horizontal
      var y = d3.scale.ordinal()
          .rangeRoundBands([height,0], .5, .40);

      // Vertical
      var x = d3.scale.linear()
          .range([0,width]);

      // Color
      var color = d3.scale.category20c();



      // Create axes
      // ------------------------------

      // Horizontal
      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom")
          .ticks(6);

      // Vertical
      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left")
          //.tickFormat(formatPercent);



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


      //         // Create tooltip
      //             // ------------------------------
      //
      //
      //
      // // Load data
      // // ------------------------------
      //
      //
      //
      data = [
    		 <%if (bloggers.length() > 0) {
						int p = 0;
						//System.out.println(bloggers);
						for (int y = 0; y < bloggers.length(); y++) {
							String key = looper.get(y).toString();
							JSONObject resu = bloggers.getJSONObject(key);
							int size = Integer.parseInt(resu.get("postingfreq").toString());
							if (size > 200 && p < 10) {
								p++;%>
    			{letter:"<%=resu.get("blog")%>", frequency:<%=size%>, name:"<%=resu.get("blogger")%>", type:"blogger"},
    			 <%}
						}
					}%>
            //{letter:"Blog 5", frequency:2550, name:"Obadimu Adewale", type:"blogger"},
            
        ];
      //
      //
      //   // Create tooltip
        var tip = d3.tip()
               .attr('class', 'd3-tip')
               .offset([-10, 0])
               .html(function(d) {
                 if(d.type === "blogger")
                 {
                   return d.letter+" ("+d.frequency+")<br/> Blogger: "+d.name;
                 }

                 if(d.type === "blog")
                 {
                   return d.letter+" ("+d.frequency+")<br/> Blog: "+d.name;
                 }

               });

           // Initialize tooltip
           svg.call(tip);

      //
      //     // Pull out values
      //     data.forEach(function(d) {
      //         d.frequency = +d.frequency;
      //     });
      //
      //
      //
      //     // Set input domains
      //     // ------------------------------
      //
      //     // Horizontal
          y.domain(data.map(function(d) { return d.letter; }))

          // Vertical
          x.domain([0,d3.max(data, function(d) { return d.frequency; })]);
      //
      //
      //     //
      //     // Append chart elements
      //     //
      //
      //     // Append axes
      //     // ------------------------------
      //
          // Horizontal
          svg.append("g")
              .attr("class", "d3-axis d3-axis-horizontal d3-axis-strong")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);

          // Vertical
          var verticalAxis = svg.append("g")
              .attr("class", "d3-axis d3-axis-vertical d3-axis-strong")
              .style("color","yellow")
              .call(yAxis)
              .selectAll("text")
   			.attr("y", -25)
    			.attr("x", 40)
    		.attr("dy", ".75em")
    		.attr("transform", "rotate(-70)")
              ;
      //
      //
      //     // Add text label
      //     verticalAxis.append("text")
      //         .attr("transform", "rotate(-90)")
      //         .attr("y", 10)
      //         .attr("dy", ".71em")
      //         .style("text-anchor", "end")
      //         .style("fill", "#999")
      //         .style("font-size", 12)
      //         // .text("Frequency")
      //         ;
      //
      //
      //     // Add bars
          svg.selectAll(".d3-bar")
              .data(data)
              .enter()
              .append("rect")
                  .attr("class", "d3-bar")
                  .attr("y", function(d) { return y(d.letter); })
                  .attr("height", y.rangeBand())
                  .attr("x", function(d) { return 0; })
                  .attr("width", function(d) { return x(d.frequency); })
                  .style("fill", function(d) {
                  maxvalue = d3.max(data, function(d) { return d.frequency; });
                  if(d.frequency == maxvalue)
                  {
                    return "0080CC";
                  }
                  else
                  {
                    return "#78BCE4";
                  }

                })
                  .on('mouseover', tip.show)
                  .on('mouseout', tip.hide);


                  // svg.selectAll(".d3-bar")
                  //     .data(data)
                  //     .enter()
                  //     .append("rect")
                  //         .attr("class", "d3-bar")
                  //         .attr("x", function(d) { return x(d.letter); })
                  //         .attr("width", x.rangeBand())
                  //         .attr("y", function(d) { return y(d.frequency); })
                  //         .attr("height", function(d) { return height - y(d.frequency); })
                  //         .style("fill", function(d) { return "#58707E"; })
                  //         .on('mouseover', tip.show)
                  //         .on('mouseout', tip.hide);





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


            // // Layout
            // // -------------------------
            //
            // // Main svg width
            container.attr("width", width + margin.left + margin.right);

            // Width of appended group
            svg.attr("width", width + margin.left + margin.right);
            //
            //
            // // Axes
            // // -------------------------
            //
            // // Horizontal range
           x.range([0,width]);
            //
            // // Horizontal axis
            svg.selectAll('.d3-axis-horizontal').call(xAxis);
             // svg.selectAll('.d3-bar-vertical').call(yAxis);

            //
            // // Chart elements
            // // -------------------------
            //
            // // Line path
           svg.selectAll('.d3-bar').attr("width", function(d) { return x(d.frequency); });
        }
    }
});
</script>
	<!-- end of posting frequency  -->
	<!--  Start of sentiment Bar Chart -->
	<script>
$(function () {

    // Initialize chart
    sentimentbar('#sentimentbar', 400);

    // Chart setup
    function sentimentbar(element, height) {

      // Basic setup
      // ------------------------------

      // Define main variables
      var d3Container = d3.select(element),
          margin = {top: 5, right: 50, bottom: 20, left: 60},
          width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
          height = height - margin.top - margin.bottom - 5;

         var formatPercent = d3.format("");

      // Construct scales
      // ------------------------------

      // Horizontal
      var y = d3.scale.ordinal()
          .rangeRoundBands([height,0], .6, .8);

      // Vertical
      var x = d3.scale.linear()
          .range([0,width]);

      // Color
      var color = d3.scale.category20c();



      // Create axes
      // ------------------------------

      // Horizontal
      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom")
          .ticks(6);

      // Vertical
      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left")
          //.tickFormat(formatPercent);



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


      //         // Create tooltip
      //             // ------------------------------
      //
      //
      //
      // // Load data
      // // ------------------------------
      //
      //
      //
      data = [
            {letter:"Negative", frequency:<%=negsentiment%>},
            {letter:"Positive", frequency:<%=possentiment%>}
        ];
      //
      //
      //   // Create tooltip
        var tip = d3.tip()
               .attr('class', 'd3-tip')
               .offset([-10, 0])
               .html(function(d) {
                   return d.letter+" ("+d.frequency+")";
               });

           // Initialize tooltip
           svg.call(tip);

           var color = d3.scale.linear()
                   .domain([0,1])
                   .range(["#FF7D7D", "#72c28e"]);


      //
      //     // Pull out values
      //     data.forEach(function(d) {
      //         d.frequency = +d.frequency;
      //     });
      //
      //
      //
      //     // Set input domains
      //     // ------------------------------
      //
      //     // Horizontal
          y.domain(data.map(function(d) { return d.letter; }));

          // Vertical
          x.domain([0,d3.max(data, function(d) { return d.frequency; })]);
      //
      //
      //     //
      //     // Append chart elements
      //     //
      //
      //     // Append axes
      //     // ------------------------------
      //
          // Horizontal
          svg.append("g")
              .attr("class", "d3-axis d3-axis-horizontal d3-axis-strong")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis);

          // Vertical
          var verticalAxis = svg.append("g")
              .attr("class", "d3-axis d3-axis-vertical d3-axis-strong")
              .style("color","yellow")
              .call(yAxis);
      //
      //
      //     // Add text label
      //     verticalAxis.append("text")
      //         .attr("transform", "rotate(-90)")
      //         .attr("y", 10)
      //         .attr("dy", ".71em")
      //         .style("text-anchor", "end")
      //         .style("fill", "#999")
      //         .style("font-size", 12)
      //         // .text("Frequency")
      //         ;
      //
      //
      //     // Add bars
          svg.selectAll(".d3-bar")
              .data(data)
              .enter()
              .append("rect")
                  .attr("class", "d3-bar")
                  .attr("y", function(d) { return y(d.letter); })
                  .attr("height", y.rangeBand())
                  .attr("x", function(d) { return 0; })
                  .attr("width", function(d) { return x(d.frequency); })
                  .style("fill", function(d,i) { return color(i);   })
                  .on('mouseover', tip.show)
                  .on('mouseout', tip.hide);


                  // svg.selectAll(".d3-bar")
                  //     .data(data)
                  //     .enter()
                  //     .append("rect")
                  //         .attr("class", "d3-bar")
                  //         .attr("x", function(d) { return x(d.letter); })
                  //         .attr("width", x.rangeBand())
                  //         .attr("y", function(d) { return y(d.frequency); })
                  //         .attr("height", function(d) { return height - y(d.frequency); })
                  //         .style("fill", function(d) { return "#58707E"; })
                  //         .on('mouseover', tip.show)
                  //         .on('mouseout', tip.hide);





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


            // // Layout
            // // -------------------------
            //
            // // Main svg width
            container.attr("width", width + margin.left + margin.right);

            // Width of appended group
            svg.attr("width", width + margin.left + margin.right);
            //
            //
            // // Axes
            // // -------------------------
            //
            // // Horizontal range
           x.range([0,width]);
            //
            // // Horizontal axis
            svg.selectAll('.d3-axis-horizontal').call(xAxis);
             // svg.selectAll('.d3-bar-vertical').call(yAxis);

            //
            // // Chart elements
            // // -------------------------
            //
            // // Line path
           svg.selectAll('.d3-bar').attr("width", function(d) { return x(d.frequency); });
        }
    }
});
</script>

	<script type="text/javascript">
// map data
var gdpData = {
  "AF": 16.63,
  "AL": 11.58,
  "DZ": 158.97,
  "AO": 85.81,
  "AG": 1.1,
  "AR": 351.02,
  "AM": 8.83,
  "AU": 1219.72,
  "AT": 366.26,
  "AZ": 52.17,
  "BS": 7.54,
  "BH": 21.73,
  "BD": 105.4,
  "BB": 3.96,
  "BY": 52.89,
  "BE": 461.33,
  "BZ": 1.43,
  "BJ": 6.49,
  "BT": 1.4,
  "BO": 19.18,
  "BA": 16.2,
  "BW": 12.5,
  "BR": 2023.53,
  "BN": 11.96,
  "BG": 44.84,
  "BF": 8.67,
  "BI": 1.47,
  "KH": 11.36,
  "CM": 21.88,
  "CA": 1563.66,
  "CV": 1.57,
  "CF": 2.11,
  "TD": 7.59,
  "CL": 199.18,
  "CN": 5745.13,
  "CO": 283.11,
  "KM": 0.56,
  "CD": 12.6,
  "CG": 11.88,
  "CR": 35.02,
  "CI": 22.38,
  "HR": 59.92,
  "CY": 22.75,
  "CZ": 195.23,
  "DK": 304.56,
  "DJ": 1.14,
  "DM": 0.38,
  "DO": 50.87,
  "EC": 61.49,
  "EG": 216.83,
  "SV": 21.8,
  "GQ": 14.55,
  "ER": 2.25,
  "EE": 19.22,
  "ET": 30.94,
  "FJ": 3.15,
  "FI": 231.98,
  "FR": 2555.44,
  "GA": 12.56,
  "GM": 1.04,
  "GE": 11.23,
  "DE": 3305.9,
  "GH": 18.06,
  "GR": 305.01,
  "GD": 0.65,
  "GT": 40.77,
  "GN": 4.34,
  "GW": 0.83,
  "GY": 2.2,
  "HT": 6.5,
  "HN": 15.34,
  "HK": 226.49,
  "HU": 132.28,
  "IS": 12.77,
  "IN": 1430.02,
  "ID": 695.06,
  "IR": 337.9,
  "IQ": 84.14,
  "IE": 204.14,
  "IL": 201.25,
  "IT": 2036.69,
  "JM": 13.74,
  "JP": 5390.9,
  "JO": 27.13,
  "KZ": 129.76,
  "KE": 32.42,
  "KI": 0.15,
  "KR": 986.26,
  "UNDEFINED": 5.73,
  "KW": 117.32,
  "KG": 4.44,
  "LA": 6.34,
  "LV": 23.39,
  "LB": 39.15,
  "LS": 1.8,
  "LR": 0.98,
  "LY": 77.91,
  "LT": 35.73,
  "LU": 52.43,
  "MK": 9.58,
  "MG": 8.33,
  "MW": 5.04,
  "MY": 218.95,
  "MV": 1.43,
  "ML": 9.08,
  "MT": 7.8,
  "MR": 3.49,
  "MU": 9.43,
  "MX": 1004.04,
  "MD": 5.36,
  "MN": 5.81,
  "ME": 3.88,
  "MA": 91.7,
  "MZ": 10.21,
  "MM": 35.65,
  "NA": 11.45,
  "NP": 15.11,
  "NL": 770.31,
  "NZ": 138,
  "NI": 6.38,
  "NE": 5.6,
  "NG": 206.66,
  "NO": 413.51,
  "OM": 53.78,
  "PK": 174.79,
  "PA": 27.2,
  "PG": 8.81,
  "PY": 17.17,
  "PE": 153.55,
  "PH": 189.06,
  "PL": 438.88,
  "PT": 223.7,
  "QA": 126.52,
  "RO": 158.39,
  "RU": 1476.91,
  "RW": 5.69,
  "WS": 0.55,
  "ST": 0.19,
  "SA": 434.44,
  "SN": 12.66,
  "RS": 38.92,
  "SC": 0.92,
  "SL": 1.9,
  "SG": 217.38,
  "SK": 86.26,
  "SI": 46.44,
  "SB": 0.67,
  "ZA": 354.41,
  "ES": 1374.78,
  "LK": 48.24,
  "KN": 0.56,
  "LC": 1,
  "VC": 0.58,
  "SD": 65.93,
  "SR": 3.3,
  "SZ": 3.17,
  "SE": 444.59,
  "CH": 522.44,
  "SY": 59.63,
  "TW": 426.98,
  "TJ": 5.58,
  "TZ": 22.43,
  "TH": 312.61,
  "TL": 0.62,
  "TG": 3.07,
  "TO": 0.3,
  "TT": 21.2,
  "TN": 43.86,
  "TR": 729.05,
  "TM": 0,
  "UG": 17.12,
  "UA": 136.56,
  "AE": 239.65,
  "GB": 2258.57,
  "US": 0,
  "UY": 40.71,
  "UZ": 37.72,
  "VU": 0.72,
  "VE": 285.21,
  "VN": 101.99,
  "YE": 30.02,
  "ZM": 15.69,
  "ZW": 5.57
};
// add the list of location of craweled blog here
<%JSONObject location = new JSONObject();
					location.put("null", "0, 0");
					location.put("Vatican City", "41.90, 12.45");
					location.put("Monaco", "43.73, 7.41");
					location.put("Salt Lake City", "40.726, -111.778");
					location.put("Kansas City", "39.092, -94.575");
					location.put("US", "37.0902, -95.7129");
					location.put("DE", "51.165691, 10.451526");
					location.put("LT", "55.1694, 23.8813");
					location.put("GB", "55.3781, 3.4360");
					location.put("NL", "52.132633, 5.291266");
					location.put("VE", "6.423750, -66.589729");
					location.put("LV", "56.8796, 24.6032");
					location.put("LV", "56.8796, 24.6032");
					location.put("UA", "48.379433, 31.165581");
					location.put("RU", "61.524010, 105.318756");%>
// map marker location by longitude and latitude
var mymarker = [
	<%if (blogs.size() > 0) {
						String bres = null;
						JSONObject bresp = null;
						String bresu = null;
						JSONObject bobj = null;
						for (int k = 0; k < blogs.size(); k++) {
							bres = blogs.get(k).toString();
							bresp = new JSONObject(bres);
							bresu = bresp.get("_source").toString();
							bobj = new JSONObject(bresu);
							if (location.has(bobj.get("location").toString())) {%>
	 		{latLng: [<%=location.get(bobj.get("location").toString())%>], name: '<%=bobj.get("location").toString()%>'},
			<%}
						}
					}%>

    
    
    /*
    {latLng: [39.092, -94.575], name: 'Kansas City'},
    {latLng: [25.782, -80.231], name: 'Miami'},
    {latLng: [8.967, -79.458], name: 'Panama City'},
    {latLng: [19.400, -99.124], name: 'Mexico City'},
    {latLng: [40.705, -73.978], name: 'New York'},
    {latLng: [33.98, -118.132], name: 'Los Angeles'},
    {latLng: [47.614, -122.335], name: 'Seattle'},
    {latLng: [44.97, -93.261], name: 'Minneapolis'},
    {latLng: [39.73, -105.015], name: 'Denver'},
    {latLng: [41.833, -87.732], name: 'Chicago'},
    {latLng: [29.741, -95.395], name: 'Houston'},
    {latLng: [23.05, -82.33], name: 'Havana'},
    {latLng: [45.41, -75.70], name: 'Ottawa'},
    {latLng: [53.555, -113.493], name: 'Edmonton'},
    {latLng: [-0.23, -78.52], name: 'Quito'},
    {latLng: [18.50, -69.99], name: 'Santo Domingo'},
    {latLng: [4.61, -74.08], name: 'Bogotá'},
    {latLng: [14.08, -87.21], name: 'Tegucigalpa'},
    {latLng: [17.25, -88.77], name: 'Belmopan'},
    {latLng: [14.64, -90.51], name: 'New Guatemala'},
    {latLng: [-15.775, -47.797], name: 'Brasilia'},
    {latLng: [-3.790, -38.518], name: 'Fortaleza'},
    {latLng: [50.402, 30.532], name: 'Kiev'},
    {latLng: [53.883, 27.594], name: 'Minsk'},
    {latLng: [52.232, 21.061], name: 'Warsaw'},
    {latLng: [52.507, 13.426], name: 'Berlin'},
    {latLng: [50.059, 14.465], name: 'Prague'},
    {latLng: [47.481, 19.130], name: 'Budapest'},
    {latLng: [52.374, 4.898], name: 'Amsterdam'},
    {latLng: [48.858, 2.347], name: 'Paris'},
    {latLng: [40.437, -3.679], name: 'Madrid'},
    {latLng: [39.938, 116.397], name: 'Beijing'},
    {latLng: [28.646, 77.093], name: 'Delhi'},
    {latLng: [25.073, 55.229], name: 'Dubai'},
    {latLng: [35.701, 51.349], name: 'Tehran'},
    {latLng: [7.11, 171.06], name: 'Marshall Islands'},
    {latLng: [17.3, -62.73], name: 'Saint Kitts and Nevis'},
    {latLng: [3.2, 73.22], name: 'Maldives'},
    {latLng: [35.88, 14.5], name: 'Malta'},
    {latLng: [12.05, -61.75], name: 'Grenada'},
    {latLng: [13.16, -61.23], name: 'Saint Vincent and the Grenadines'},
    {latLng: [13.16, -59.55], name: 'Barbados'},
    {latLng: [17.11, -61.85], name: 'Antigua and Barbuda'},
    {latLng: [-4.61, 55.45], name: 'Seychelles'},
    {latLng: [7.35, 134.46], name: 'Palau'},
    {latLng: [42.5, 1.51], name: 'Andorra'},
    {latLng: [14.01, -60.98], name: 'Saint Lucia'},
    {latLng: [6.91, 158.18], name: 'Federated States of Micronesia'},
    {latLng: [1.3, 103.8], name: 'Singapore'},
    {latLng: [1.46, 173.03], name: 'Kiribati'},
    {latLng: [-21.13, -175.2], name: 'Tonga'},
    {latLng: [15.3, -61.38], name: 'Dominica'},
    {latLng: [-20.2, 57.5], name: 'Mauritius'},
    {latLng: [26.02, 50.55], name: 'Bahrain'},
    
    {latLng: [0.33, 6.73], name: 'São Tomé and Príncipe'}
    */
]
  </script>
	<script type="text/javascript"
		src="assets/vendors/maps/jvectormap/jvectormap.min.js"></script>
	<script type="text/javascript"
		src="assets/vendors/maps/jvectormap/map_files/world.js"></script>
	<script type="text/javascript"
		src="assets/vendors/maps/jvectormap/map_files/countries/usa.js"></script>
	<script type="text/javascript"
		src="assets/vendors/maps/jvectormap/map_files/countries/germany.js"></script>
	<script type="text/javascript"
		src="assets/vendors/maps/vector_maps_demo.js"></script>

	<!--word cloud  -->
	<script>

     var frequency_list = [
    	 <%if (topterms.length() > 0) {
						for (int i = 0; i < topterms.length(); i++) {
							JSONObject jsonObj = topterms.getJSONObject(i);
							int size = Integer.parseInt(jsonObj.getString("frequency")) * 10;
							System.out.println("Info" + "Key: " + jsonObj.getString("key") + ", value: " + size);%>
    		{"text":"<%=jsonObj.getString("key")%>","size":<%=size%>},
    	 <%}
					}%>
    	
    	/*	
    	 
    	 {"text":"study","size":40},
    	 {"text":"motion","size":15},
    	 {"text":"forces","size":10},
    	 {"text":"electricity","size":15},
    	 {"text":"movement","size":10},
    	 {"text":"relation","size":5},
    	 {"text":"things","size":10},
    	 {"text":"force","size":5},
    	 {"text":"ad","size":5},
    	 {"text":"energy","size":85},
    	 {"text":"living","size":5},
    	 {"text":"nonliving","size":5},
    	 {"text":"laws","size":15},
    	 {"text":"speed","size":45},
    	 {"text":"velocity","size":30},
    	 {"text":"define","size":5},
    	 {"text":"constraints","size":5},
    	 {"text":"universe","size":10},
    	 {"text":"distinguished","size":5},
    	 {"text":"chemistry","size":5},
    	 {"text":"biology","size":5},
    	 {"text":"includes","size":5},
    	 {"text":"radiation","size":5},
    	 {"text":"sound","size":5},
    	 {"text":"structure","size":5},
    	 {"text":"atoms","size":5},
    	 {"text":"including","size":10},
    	 {"text":"atomic","size":10},
    	 {"text":"nuclear","size":10},
    	 {"text":"cryogenics","size":10},
    	 {"text":"solid-state","size":10},
    	 {"text":"particle","size":10},
    	 {"text":"plasma","size":10},
    	 {"text":"deals","size":5},
    	 {"text":"merriam-webster","size":5},
    	 {"text":"dictionary","size":10},
    	 {"text":"analysis","size":5},
    	 {"text":"conducted","size":5},
    	 {"text":"order","size":5},
    	 {"text":"understand","size":5},
    	 {"text":"behaves","size":5},{"text":"en","size":5},{"text":"wikipedia","size":5},{"text":"wiki","size":5},{"text":"physics-","size":5},{"text":"physical","size":5},{"text":"behaviour","size":5},{"text":"collinsdictionary","size":5},{"text":"english","size":5},{"text":"time","size":35},{"text":"distance","size":35},{"text":"wheels","size":5},{"text":"revelations","size":5},{"text":"minute","size":5},{"text":"acceleration","size":20},{"text":"torque","size":5},{"text":"wheel","size":5},{"text":"rotations","size":5},{"text":"resistance","size":5},{"text":"momentum","size":5},{"text":"measure","size":10},{"text":"direction","size":10},{"text":"car","size":5},{"text":"add","size":5},{"text":"traveled","size":5},{"text":"weight","size":5},{"text":"electrical","size":5},
    	 {"text":"power","size":5}
    	 */
    	 ];
	

     var color = d3.scale.linear()
             .domain([0,1,2,3,4,5,6,10,15,20,80])
             .range(["#17394C", "#F5CC0E", "#CE0202", "#1F90D0", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"]);

     d3.layout.cloud().size([450, 300])
             .words(frequency_list)
             .rotate(0)
             .fontSize(function(d) { return d.size * 1.5; })
             .on("end", draw)
             .start();

     function draw(words) {
         d3.select(".tagcloudcontainer").append("svg")
                 .attr("width", 450)
                 .attr("height", 300)
                 .attr("class", "wordcloud")
                 .append("g")
                 // without the transform, words words would get cutoff to the left and top, they would
                 // appear outside of the SVG area
                 .attr("transform", "translate(155,180)")
                 .selectAll("text")
                 .data(words)
                 .enter().append("text")
                 .style("font-size", function(d) { return d.size + "px"; })
                 .style("fill", function(d, i) { return color(i); })
                 .attr("transform", function(d) {
                     return "translate(" + [d.x + 2, d.y + 3] + ")rotate(" + d.rotate + ")";
                 })

                 .text(function(d) { return d.text; });
     }
 </script>

	<!-- Blogger Bubble Chart -->
	<script>


$(function () {

    // Initialize chart
    bubblesblogger('#bubblesblogger', 470);

    // Chart setup
    function bubblesblogger(element, diameter) {


        // Basic setup
        // ------------------------------

        // Format data
        var format = d3.format(",d");

        // Color scale
        color = d3.scale.category10();

        // Define main variables
        var d3Container = d3.select(element),
            margin = {top: 5, right: 20, bottom: 20, left: 50},
            width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
            height = height - margin.top - margin.bottom;
            diamter = height;




            // Add SVG element
            var container = d3Container.append("svg");

            // Add SVG group
            var svg = container
                .attr("width", diameter + margin.left + margin.right)
                .attr("height",diameter + margin.top + margin.bottom)
                .attr("class", "bubble");

        // Create chart
        // ------------------------------

        // var svg = d3.select(element).append("svg")
        //     .attr("width", diameter)
        //     .attr("height", diameter)
        //     .attr("class", "bubble");



        // Create chart
        // ------------------------------

        // Add tooltip
        var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-5, 0])
            .html(function(d) {
                return d.label+"<br/>"+d.className + ": " + format(d.value);;
            });

        // Initialize tooltip
        svg.call(tip);



        // Construct chart layout
        // ------------------------------

        // Pack
        var bubble = d3.layout.pack()
            .sort(null)
            .size([diameter, diameter])
            .padding(15);



        // Load data
        // ------------------------------



data = {
 "name":"flare",
 "bloggers":[
	<%if (bloggers.length() > 0) {
						//System.out.println(bloggers);
						int k = 0;
						for (int y = 0; y < bloggers.length(); y++) {
							String key = looper.get(y).toString();
							JSONObject resu = bloggers.getJSONObject(key);
							int size = Integer.parseInt(resu.get("value").toString());
							if (size > 0 && k < 15) {
								k++;%>
	{"label":"<%=resu.get("blogger")%>","name":"<%=resu.get("blogger")%>", "size":<%=resu.get("value")%>},
	 <%}
						}
					}%>
 /* {"label":"Blogger 2","name":"Obadimu Adewale", "size":2500},
 {"label":"Blogger 3","name":"Oluwaseun Walter", "size":2800},
 {"label":"Blogger 4","name":"Kiran Bandeli", "size":900},
 {"label":"Blogger 5","name":"Adekunle Mayowa", "size":1400},
 {"label":"Blogger 6","name":"Nihal Hussain", "size":200},
 {"label":"Blogger 7","name":"Adekunle Mayowa", "size":500},
 {"label":"Blogger 8","name":"Adekunle Mayowa", "size":300},
 {"label":"Blogger 9","name":"Adekunle Mayowa", "size":350},
 {"label":"Blogger 10","name":"Adekunle Mayowa", "size":1400}
 */
 ]
}


            //
            // Append chart elements
            //

            // Bind data
            var node = svg.selectAll(".d3-bubbles-node")
                .data(bubble.nodes(classes(data))
                .filter(function(d) { return !d.children; }))
                .enter()
                .append("g")
                    .attr("class", "d3-bubbles-node")
                    .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

            // Append circles
            node.append("circle")
                .attr("r", function(d) { return d.r; })
                .style("fill", function(d,i) {
                  // return color(i);
                  // customize Color
                  if(i<5)
                  {
                    return "#0080cc";
                  }
                  else if(i>=5)
                  {
                    return "#78bce4";
                  }
                })
                .on('mouseover', tip.show)
                .on('mouseout', tip.hide);

            // Append text
            node.append("text")
                .attr("dy", ".3em")
                .style("fill", "#fff")
                .style("font-size", 12)
                .style("text-anchor", "middle")
                .text(function(d) { return d.label.substring(0, d.r / 3); });



        // Returns a flattened hierarchy containing all leaf nodes under the root.
        function classes(root) {
            var classes = [];

            function recurse(name, node) {
                if (node.bloggers) node.bloggers.forEach(function(child) { recurse(node.name, child); });
                else classes.push({packageName: name, className: node.name, value: node.size,label:node.label});
            }

            recurse(null, root);
            return {children: classes};
        }
    }
});
</script>
	<script>


    var color = d3.scale.linear()
            .domain([0,1,2,3,4,5,6,10,15,20,80])
            .range(["#17394C", "#F5CC0E", "#CE0202", "#aaa", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"]);

</script>
	<!-- end of blogger bubble chart -->


	<!-- Blog Bubble Chart -->
	<script>


$(function () {

    // Initialize chart
    bubblesblog('#bubblesblog', 470);

    // Chart setup
    function bubblesblog(element, diameter) {


        // Basic setup
        // ------------------------------

        // Format data
        var format = d3.format(",d");

        // Color scale
        color = d3.scale.category10();

        // Define main variables
        var d3Container = d3.select(element),
            margin = {top: 5, right: 20, bottom: 20, left: 50},
            width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
            height = height - margin.top - margin.bottom;
            diamter = height;




            // Add SVG element
            var container = d3Container.append("svg");

            // Add SVG group
            var svg = container
                .attr("width", diameter + margin.left + margin.right)
                .attr("height",diameter + margin.top + margin.bottom)
                .attr("class", "bubble");

        // Create chart
        // ------------------------------

        // var svg = d3.select(element).append("svg")
        //     .attr("width", diameter)
        //     .attr("height", diameter)
        //     .attr("class", "bubble");



        // Create chart
        // ------------------------------

        // Add tooltip
        var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-5, 0])
            .html(function(d) {
                return d.label+"<br/>"+d.className + ": " + format(d.value);;
            });

        // Initialize tooltip
        svg.call(tip);



        // Construct chart layout
        // ------------------------------

        // Pack
        var bubble = d3.layout.pack()
            .sort(null)
            .size([diameter, diameter])
            .padding(15);



        // Load data
        // ------------------------------



data = {
 "name":"flare",
 "bloggers":[
	 <%if (bloggers.length() > 0) {
						int k = 0;
						//System.out.println(bloggers);
						for (int y = 0; y < bloggers.length(); y++) {

							String key = looper.get(y).toString();
							JSONObject resu = bloggers.getJSONObject(key);
							int size = Integer.parseInt(resu.get("value").toString());
							if (size > 0 && k < 15) {
								k++;%>
		{"label":"<%=resu.get("blog")%>","name":"<%=resu.get("blogger")%>", "size":<%=resu.get("value")%>},
		 <%}
						}
					}%>
 ]
}


            //
            // Append chart elements
            //

            // Bind data
            var node = svg.selectAll(".d3-bubbles-node")
                .data(bubble.nodes(classes(data))
                .filter(function(d) { return !d.children; }))
                .enter()
                .append("g")
                    .attr("class", "d3-bubbles-node")
                    .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

            // Append circles
            node.append("circle")
                .attr("r", function(d) { return d.r; })
                .style("fill", function(d,i) {
                  //return color(i);
                  if(i<5)
                  {
                    return "#0080cc";
                  }
                  else if(i>=5)
                  {
                    return "#78bce4";
                  }
                })
                .on('mouseover',tip.show)
                .on('mouseout', tip.hide);

            // Append text
            node.append("text")
                .attr("dy", ".3em")
                .style("fill", "#fff")
                .style("font-size", 12)
                .style("text-anchor", "middle")
                .text(function(d) { return d.label.substring(0, d.r / 3); });



        // Returns a flattened hierarchy containing all leaf nodes under the root.
        function classes(root) {
            var classes = [];

            function recurse(name, node) {
                if (node.bloggers) node.bloggers.forEach(function(child) { recurse(node.name, child); });
                else classes.push({packageName: name, className: node.name, value: node.size,label:node.label});
            }

            recurse(null, root);
            return {children: classes};
        }
    }
});
</script>
	<script>


    var color = d3.scale.linear()
            .domain([0,1,2,3,4,5,6,10,15,20,80])
            .range(["#17394C", "#F5CC0E", "#CE0202", "#aaa", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"]);

    
  
</script>
	<script>
$(".option-only").on("change",function(e){
	console.log("only changed ");
	var valu =  $(this).val();
	$("#single_date").val(valu);
	$('form#customformsingle').submit();
});

$(".option-only").on("click",function(e){
	console.log("only Click ");
	$("#single_date").val($(this).val());
	//$('form#customformsingle').submit();
});

$(".option-lable").on("click",function(e){
	console.log("Label Click ");
	
	$("#single_date").val($(this).val());
	//$('form#customformsingle').submit();
});
</script>
	<!-- End of blog bubble chart -->

	<!-- posting frequency -->
	<script>

 $(function () {

     // Initialize chart
     lineBasic('#postingfrequency', 300);

     // Chart setup
     function lineBasic(element, height) {


         // Basic setup
         // ------------------------------

         // Define main variables
         var d3Container = d3.select(element),
             margin = {top: 10, right: 10, bottom: 20, left: 50},
             width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
             height = height - margin.top - margin.bottom;


         // var formatPercent = d3.format(",.3f");
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
           [{"date":"2014","close":400},{"date":"2015","close":600},{"date":"2016","close":1300},{"date":"2017","close":1700},{"date":"2018","close":2100}],
           [{"date":"2014","close":350},{"date":"2015","close":700},{"date":"2016","close":1500},{"date":"2017","close":1600},{"date":"2018","close":1250}],
           [{"date":"2014","close":500},{"date":"2015","close":900},{"date":"2016","close":1200},{"date":"2017","close":1200},{"date":"2018","close":2600}]
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
                                .style("stroke-width",2)
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

                           // console.log(data);

                              var mergedarray = [].concat(...data);
                               // console.log(mergedarray)
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




             // Append tooltip
             // -------------------------






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



             svg.selectAll(".circle-point")
             .attr("cx",function(d) { return x(d.date);})
             .attr("cy", function(d){return y(d.close)});


           //
           // // Crosshair
           // svg.selectAll('.d3-crosshair-overlay').attr("width", width);

         }
     }
 });
 </script>

	<!--word cloud  -->
	<script>
     var color = d3.scale.linear()
             .domain([0,1,2,3,4,5,6,10,15,20,80])
             .range(["#17394C", "#F5CC0E", "#CE0202", "#aaa", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"]);

 </script>
</body>
</html>

<% }} %>
