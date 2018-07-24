<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="util.Trackers"%>
<%@page import="util.Blogs"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (email == null || email == "") {
		response.sendRedirect("index.jsp");
	} else {
		ArrayList<?> userinfo = null;
		String profileimage = "";
		String username = "";
		String name = "";
		String phone = "";
		String date_modified = "";
		userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = '" + email + "'");
		//System.out.println(userinfo);
		if (userinfo.size() < 1) {
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
			Trackers tracker = new Trackers();
			Blogs blg = new Blogs();
			String term = (null == request.getParameter("term")) ? "" : request.getParameter("term");
			ArrayList results = null;
			if (term.equals("")) {
				results = tracker._list("DESC", "", username, "10");
			} else {
				results = tracker._search(term, "");
			}
			String total = tracker._getTotal();
			ArrayList test = new ArrayList();
			//tracker._add("hello",test);
			//pimage = pimage.replace("build/", "");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Blogtrackers - Tracker List</title>


<link rel="shortcut icon" href="images/favicons/favicon-48x48.png">

<link rel="apple-touch-icon" href="images/favicons/favicon-48x48.png">
<link rel="apple-touch-icon" sizes="96x96"
	href="images/favicons/favicon-96x96.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="images/favicons/favicon-144x144.png">
<!-- start of bootsrap -->
<link rel="stylesheet"
	href="https://cdn.linearicons.com/free/1.0.0/icon-font.min.css">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:600,700"
	rel="stylesheet">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
<link href="assets/fonts/icomoon/styles.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet" href="assets/css/style.css" />

<!--end of bootsrap -->
<script src="assets/js/jquery-3.2.1.slim.min.js"></script>
<script src="assets/js/popper.min.js"></script>

<!-- Base URL  -->
<script src="pagedependencies/baseurl.js">
	
</script>


</head>
<body>
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
		<div class="container-fluid mt10">

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
				<ul class="nav navbar-nav" style="display: block;">
					<li class="dropdown dropdown-user cursor-pointer float-right">
						<a class="dropdown-toggle " id="profiletoggle"
						data-toggle="dropdown"> <i class="fas fa-circle"
							id="notificationcolor"></i> <img src="<%=profileimage%>"
							width="50" height="50"
							onerror="this.src='images/default-avatar.png'" alt="" class="" />
							<span><%=user_name[0]%></span> <!-- <ul class="profilemenu dropdown-menu dropdown-menu-left">
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

		<div class="col-md-12 mt0">
			<input type="search"
				class="form-control p30 pt5 pb5 icon-big border-none bottom-border text-center blogbrowsersearch nobackground"
				placeholder="Search Trackers" />
		</div>

	</nav>
	<div class="container">


		<div class="row mt30">
			<div class="col-md-12 ">
				<h6 class="float-left text-primary"><%=total%>
					Tracker(s)
				</h6>
				<!-- <h6 class="float-right text-primary">Recent <i class="fas fa-chevron-down"></i><h6/> -->
			</div>
		</div>


		<div class="card-columns pt0 pb10  mt10 mb40 ">

			<div class="card noborder curved-card mb30 pt60 pb60">
				<div class="card-body">
					<div class="cursor-pointer">
						<h4 class="text-primary text-center">
							<i class="addnewtracker" data-toggle="tooltip"
								data-placement="top" title="Add New Tracker"></i>
						</h4>

					</div>
				</div>

			</div>

			<%
				if (results.size() > 0) {
							String res = null;
							JSONObject resp = null;
							String resu = null;
							JSONObject obj = null;
							String query = null;
							int totalpost = 0;
							String bres = null;
							JSONObject bresp = null;
							String bresu = null;
							JSONObject bobj = null;
							ArrayList blogs = null;
							int bpost = 0;

							for (int i = 0; i < results.size(); i++) {
								res = results.get(i).toString();
								resp = new JSONObject(res);
								resu = resp.get("_source").toString();
								obj = new JSONObject(resu);
								query = obj.get("query").toString();
								query = query.replaceAll("blogsite_id in ", "");
								query = query.replaceAll("\\(", "");
								query = query.replaceAll("\\)", "");

								totalpost = 0;
								String dt = "";
								if (obj.has("date_created")) {
									String[] ddt = obj.get("date_created").toString().split("T");
									dt = ddt[0];
								}

								if (!query.equals("")) {
									blogs = blg._fetch(query);
									//System.out.println(blogs);
									if (blogs.size() > 0) {
										for (int k = 0; k < blogs.size(); k++) {
											bres = blogs.get(k).toString();
											bresp = new JSONObject(bres);
											bresu = bresp.get("_source").toString();
											bobj = new JSONObject(bresu);
											bpost = Integer.parseInt(bobj.get("totalposts").toString());
											totalpost += bpost;
										}
									}
								}
			%>


			<div class="card noborder curved-card mb30 pt30">
				<div class="">
					<h1
						class="text-primary text-center pt20 edittrackerpopaction cursor-pointer"><%=obj.get("tracker_name").toString().replaceAll("[^a-zA-Z]", " ")%></h1>
				</div>

				<div class="card-body">
					<%--  <p class="card-text text-center postdate text-primary"><%=dt%>&nbsp;&nbsp;&nbsp;&nbsp;.&nbsp;&nbsp;&nbsp;&nbsp;</p> --%>

					<div class="text-center">
						<button
							class="btn btn-default stylebutton5 text-primary p30 pt5 pb5"
							style="width: 100%;">Sports&nbsp;&nbsp;.&nbsp;&nbsp;Science&nbsp;&nbsp;.&nbsp;&nbsp;Art</button>
					</div>
					<p class="mt20 text-primary text-center">

						<%=obj.get("description").toString()%>
					</p>
					<div class="text-center mt20">
						<button
							class="btn btn-default stylebutton6 text-primary p30 pt5 pb5 text-left"
							style="width: 100%;">
							<h1 class="text-success mb0"><%=blogs.size()%></h1>
							<h5 class="text-primary">Blogs</h5>
						</button>

					</div>

					<div class="text-center mt10">
						<button
							class="btn btn-default stylebutton6 text-primary p30 pt5 pb5 text-left"
							style="width: 100%;">
							<h1 class="text-success mb0"><%=totalpost%></h1>
							<h5 class="text-primary">Posts</h5>
						</button>

					</div>
					<div class="text-center mt10">
						<button
							class="btn btn-default stylebutton6 text-primary p30 pt5 pb5 text-left"
							style="width: 100%;">
							<h1 class="text-success mb0">0</h1>
							<h5 class="text-primary">Comments</h5>
						</button>

					</div>
					<div class="pt30 pb20 text-center">
						<a
							href="<%=request.getContextPath()%>/dashboard.jsp?tid=<%=obj.get("tid").toString()%>"><i
							class="navbar-brand text-primary icontrackersize cursor-pointer proceedtoanalytics"
							data-toggle="tooltip" data-placement="top"
							title="Proceed to Analytics"></i></a> <i
							class="text-primary icontrackersize cursor-pointer refreshtracker"
							data-toggle="tooltip" data-action="reload" data-placement="top"
							title="Refresh Tracker"></i> <i
							class="text-primary icontrackersize cursor-pointer deletetracker"
							data-toggle="tooltip" data-placement="top" title="Delete Tracker"></i>
					</div>
				</div>
			</div>
			<%
				}
			%>
			<%
				}
			%>
		</div>










	</div>

	<!-- <div class="modalbackdrop hidden">

</div>

<div class="edittrackerpop hidden">
<div class="container-fluid ">
<div class="container-fluid">
<div class="row bg-white">
<div class="col-md-7 pl100 pt100 pb100">
<h1 class="text-primary" style="font-weight:bolder;">Middle East Tracker</h1>
<div class="mt10">
<button class=" btn btn-primary text-left text-primary bold-text text-white stylebuttonblog"><b>TRACKING</b> <i class="fas fa-trash float-right hidden deleteblog"></i></button>
<button class=" btn text-left text-primary bold-text stylebuttonblogothers"><b>Blog | 334</b> </button>
<button class=" btn text-left text-primary bold-text stylebuttonblogothers"><b>Crawl | 22-07-2018</b></button>
</div>
<div class="mt30 text-primary pr40" style="font-size:18px;">
National Public Radio is an American privately and publicly funded non-profit membership media organization based
in Washington DC. It serves as a national syndicator to a network of over 1,000 public radio stations in the United States.
</div>

<div class="mt30"><button class="btn blogbutton text-primary pt10 pb10 pl20 pr20"><b>Analytics</b><i class="ml10 proceedtoanalytics pl10"></i></button></div>
</div>
<div class="col-md-5 pt100 pb100 pl50 pr50 bg-white border-before">
<i class="cursor-pointer lnr lnr-cross float-right closedialog" data-toggle="tooltip" data-placement="top" title="Close Dialog"></i>

<div class="col-md-10"><h5 class="text-primary ml0">This tracker has the following list of blogs: </h5></div>
<div class="col-md-10 mt20"><input type="search" class="form-control searchblog pt10 pb10 semi-bold-text ml0" placeholder="Search Blogs"/></div>
<div class="bloglist mt10">
  <button class="btn form-control col-md-10 text-primary text-left blogindividual pt10 pb10 pl10 resetdefaultfocus">Science <i class="fas fa-check float-right hidden checkblog"></i></button>
  <button class="btn form-control col-md-10 text-primary text-left blogindividual pt10 pb10 pl10 resetdefaultfocus">Technology <i class="fas fa-check float-right hidden checkblog"></i></button>
  <button class="btn form-control col-md-10 text-primary text-left blogindividual pt10 pb10 pl10 resetdefaultfocus">Politics <i class="fas fa-check float-right hidden checkblog"></i></button>
  <button class="btn form-control col-md-10 text-primary text-left blogindividual pt10 pb10 pl10 resetdefaultfocus">Russia <i class="fas fa-check float-right hidden checkblog"></i></button>
  <button class="btn form-control col-md-10 text-primary text-left blogindividual pt10 pb10 pl10 resetdefaultfocus">Spare <i class="fas fa-check float-right hidden checkblog"></i></button>
</div>

</div>
</div>
</div>

</div> -->


	<!-- <footer class="footer">
  <div class="container-fluid bg-primary mt60">
<p class="text-center text-medium pt10 pb10 mb0">Copyright &copy; Blogtrackers 2017 All Rights Reserved.</p>
</div>
  </footer> -->



<script type="text/javascript" src="assets/js/jquery-1.11.3.min.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="assets/bootstrap/js/bootstrap.js">
</script>
<script type="text/javascript" src="assets/vendors/tags/tagsinput.min.js"></script>
<script type="text/javascript" src="assets/vendors/tags/tokenfield.min.js"></script>
<script type="text/javascript" src="assets/vendors/ui/prism.min.js"></script>
<script type="text/javascript" src="assets/vendors/typeahead/typeahead.bundle.min.js"></script>
<script type="text/javascript" src="assets/js/form_tags_input.js"></script>
<script type="text/javascript" src="assets/vendors/blockui/blockui.min.js"></script>


<script>
$(document).ready(function() {
	  $(function () {
	    $('[data-toggle="tooltip"]').tooltip()
	  })
	  // add new tracker code snippets
	  $('.addnewtracker').on("click",function(e){
	    e.preventDefault();
	    var  trackersetupform = "";
	    trackersetupform += '<div class="card noborder curved-card mb30 pt20 pb20"><div class="card-body"><div class="trackerclose"><i class="lnr lnr-cross closetracker text-primary cursor-pointer" data-toggle="tooltip" data-placement="top" title="Cancel New Tracker"></i></div><div class="cursor-pointer mt20"><textarea class="form-control newtrackername text-primary text-center" placeholder="Tracker Name" rows="2"></textarea></div><div class="cursor-pointer mt20"><textarea class="form-control newtrackerdescription text-primary text-center" placeholder="Description" rows="1"></textarea></div>';
	    //trackersetupform += '<div class="form-group mt20 trackerpage"><label class="text-primary">Add Blog</label><input type="text" class="form-control tokenfield-primary" value="" placeholder="Add Blog" /></div><div class="text-center"><i type="submit" class="fas fa-check text-success createtracker mr20 cursor-pointer" data-toggle="tooltip" data-placement="top" title="Create Tracker"></i> <i class="fas fa-trash-alt text-primary canceltracker cursor-pointer" data-toggle="tooltip" data-placement="top" title="Delete Tracker"></i></div></div></div>';
//trackersetupform += '<div class="text-center mt30"><i type="submit" class="text-success createtracker mr20 cursor-pointer" data-toggle="tooltip" data-placement="top" title="Create Tracker"></i> <i class="text-primary canceltracker cursor-pointer" data-toggle="tooltip" data-placement="top" title="Delete Tracker"></i></div></div></div>';

trackersetupform += '<div class="text-center mt30"><i type="submit" class="text-success createtracker mr20 cursor-pointer" data-toggle="tooltip" data-placement="top" title="Create Tracker"></i> </div></div></div>';
	  
	    $('.card-columns').prepend(trackersetupform);
	  
	  // load the script for form tag input
	  $.getScript("assets/js/form_tags_input.js", function(data, textStatus, jqxhr) {
		 /*  console.log(data); //data returned
		  console.log(textStatus); //success
		  console.log(jqxhr.status); //200
		  console.log('Load was performed.'); */
		  });
	  
	  // create a tracker script
	  $.getScript("pagedependencies/createtracker.js", function(data, textStatus, jqxhr) {
			
			  });
	  
	  });

	/// refresh a tracker
	  $.getScript("pagedependencies/refreshtracker.js", function(data, textStatus, jqxhr) {
			
	  });
	});
</script>

<script src="pagedependencies/edittracker.js">

</script>

	<script src="assets/js/generic.js">
</script>

</body>
</html>
<% }} %>
