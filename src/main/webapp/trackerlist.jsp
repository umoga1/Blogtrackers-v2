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
}else{

ArrayList<?> userinfo = null;
String profileimage= "";
String username ="";
String name="";
String phone="";
String date_modified = "";

 userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = '"+email+"'");
 //System.out.println(userinfo);
if (userinfo.size()<1) {
	response.sendRedirect("index.jsp");
}else{
userinfo = (ArrayList<?>)userinfo.get(0);
try{
username = (null==userinfo.get(0))?"":userinfo.get(0).toString();
name = (null==userinfo.get(4))?"":(userinfo.get(4).toString());
email = (null==userinfo.get(2))?"":userinfo.get(2).toString();
phone = (null==userinfo.get(6))?"":userinfo.get(6).toString();
String userpic = userinfo.get(9).toString();
String path=application.getRealPath("/").replace('\\', '/')+"images/profile_images/";
String filename = userinfo.get(9).toString();
profileimage = "images/default-avatar.png";
if(userpic.indexOf("http")>-1){
	profileimage = userpic;
}
File f = new File(filename);
if(f.exists() && !f.isDirectory()) { 
	profileimage = "images/profile_images/"+userinfo.get(2).toString()+".jpg";
}
}catch(Exception e){}

String[] user_name = name.split(" ");

Trackers tracker  = new Trackers();
Blogs blg  = new Blogs();
String term =  (null == request.getParameter("term")) ? "" : request.getParameter("term");
ArrayList results = null;
if(term.equals("")){
	results = tracker._list("DESC","",username);
}else{
	results = tracker._search(term,"");
}
String total = tracker._getTotal();
//pimage = pimage.replace("build/", "");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blogtrackers</title>
  <link rel="shortcut icon" href="images/favicons/favicon.ico">
  <link rel="apple-touch-icon" href="images/favicons/favicon-48x48.png">
  <link rel="apple-touch-icon" sizes="96x96" href="images/favicons/favicon-96x96.png">
  <link rel="apple-touch-icon" sizes="144x144" href="images/favicons/favicon-144x144.png">
  <!-- start of bootsrap -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:600,700" rel="stylesheet">
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap-grid.css"/>
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.css"/>
  <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.css" />
  <link rel="stylesheet" href="assets/fonts/iconic/css/open-iconic.css" />
 <link rel="stylesheet" href="assets/vendors/bootstrap-daterangepicker/daterangepicker.css" />
 <link rel="stylesheet" href="assets/css/table.css" />
 <link rel="stylesheet" href="assets/vendors/DataTables/dataTables.bootstrap4.min.css" />
<link rel="stylesheet" href="assets/vendors/DataTables/Buttons-1.5.1/css/buttons.dataTables.min.css" />
<link rel="stylesheet" href="assets/css/daterangepicker.css" />

  <link rel="stylesheet" href="assets/css/style.css" />

  <!--end of bootsrap -->
  <script src="assets/js/jquery-3.2.1.slim.min.js"></script>
<script src="assets/js/popper.min.js" ></script>
</head>
<body>
<div class="modal-notifications">
<div class="row">
<div class="offset-lg-9 col-lg-3 col-md-12 notificationpanel">
  <div id="closeicon" class="cursor-pointer"><i class="fas fa-times-circle"></i></div>
<div class="profilesection col-md-12 mt50">
  <img src="https://i.pinimg.com/736x/31/74/48/3174480c49cee70bd03627255f136b83--fat-girls-girls-hbo.jpg" width="60" height="60" alt="" class="float-left" />
  <div class="float-left" style="margin-left:20px;">
    <h4 class="text-primary m0 bolder"><%=name%></h4>
    <p class="text-primary"><%=email%></p>
  </div>

</div>
<div id="othersection" class="col-md-12 mt100" style="clear:both">
<a class="cursor-pointer profilemenulink" href="notifications.html"><h3 class="text-primary">Notifications <b id="notificationcount" class="cursor-pointer">12</b></h3> </a>
<a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/profile.jsp"><h3  class="text-primary">Profile</h3></a>
<a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/logout"><h3 class="text-primary">Log Out</h3></a>
</div>
</div>
</div>
</div>
  <nav class="navbar navbar-inverse bg-primary">
    <div class="container-fluid mt10">

      <div class="navbar-header d-none d-lg-inline-flex d-xl-inline-flex  col-lg-4">
      <a class="navbar-brand text-center" href="#"><img src="images/blogtrackers.png" /></a>
      </div>
      <!-- Mobile Menu -->
      <nav class="navbar navbar-dark bg-primary float-left d-md-block d-sm-block d-xs-block d-lg-none d-xl-none" id="menutoggle">
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
      </button>
      </nav>
      <!-- <div class="navbar-header ">
      <a class="navbar-brand text-center" href="#"><img src="images/blogtrackers.png" /></a>
      </div> -->
      <!-- Mobile menu  -->
      <div class="col-lg-4 themainmenu"  align="center">
        <ul class="nav main-menu2" style="display:inline-flex; display:-webkit-inline-flex; display:-mozkit-inline-flex;">
          <li><a href="./"><i class="fas fa-home"></i> Home</a></li>
          <li><a href="<%=request.getContextPath()%>/trackerlist.jsp"><i class="far fa-dot-circle"></i> Trackers</a></li>
          <li><a href="#"><i class="far fa-heart"></i> Favorites</a></li>
        </ul>
      </div>

  <div class="col-lg-4">
  <ul class="nav navbar-nav" style="display:block;">
  <li class="dropdown dropdown-user cursor-pointer float-right">
  <a class="dropdown-toggle " id="profiletoggle" data-toggle="dropdown">
    <i class="fas fa-circle" id="notificationcolor"></i>
  <img src="<%=profileimage%>" width="50" height="50" onerror="this.src='images/default-avatar.png'" alt="" class="" />
  <span><%=user_name[0]%></span>
  <!-- <ul class="profilemenu dropdown-menu dropdown-menu-left">
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
      <div class="col-md-12 bg-dark d-md-block d-sm-block d-xs-block d-lg-none d-xl-none p0 mt20">
      <div class="collapse" id="navbarToggleExternalContent">
        <ul class="navbar-nav mr-auto mobile-menu">
              <li class="nav-item active">
                <a class="" href="./">Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="trackerlist.html">Trackers</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">Favorites</a>
              </li>
            </ul>
    </div>
      </div>

      <div class="col-md-12 mt0">
      <input type="search" class="form-control p30 pt5 pb5 icon-big border-none bottom-border text-center blogbrowsersearch nobackground" placeholder="Search Trackers" />
      </div>

    </nav>
<div class="container">


<div class="row mt30">
<div class="col-md-12 ">
<h6 class="float-left text-primary"><%=total%> Trackers</h6>
<h6 class="float-right text-primary">Recent <i class="fas fa-chevron-down"></i><h6/>
</div>
</div>


<div class="card-columns pt0 pb10  mt10 mb50 ">
<% if(results.size()>0){
	String res = null;
	JSONObject resp = null;
	String resu = null;
	JSONObject obj = null;
	String query = null;
	int totalpost = 0;
	String bres = null;
	JSONObject bresp = null;
	String bresu =null;
	JSONObject bobj =null;
	int bpost =0;
	
		for(int i=0; i< results.size(); i++){
			res = results.get(i).toString();			
			resp = new JSONObject(res);
		    resu = resp.get("_source").toString();
		    obj = new JSONObject(resu);
			 
			 query = obj.get("query").toString();
			 query = query.replaceAll("blogsite_id in ", "");
			 query = query.replaceAll("(", "");
			 query = query.replaceAll(")", "");
			 totalpost = 0;
			 if(query.length()>1){
				 blogs = blg._fetch(query);
				 if( blogs.size()>0){
					 for(int k=0; k< blogs.size(); k++){
						 bres = blogs.get(k).toString();			
						 bresp = new JSONObject(bres);
						 bresu = bresp.get("_source").toString();
						 bobj = new JSONObject(bresu);
						 bpost = (Integer)bobj.get("totalposts").toString();
						 totalpost+=bpost;
					 }
				 }
			 }

%>
				<div class="card noborder curved-card mb30" >
				<div class="text-center"><i class="fas fa-ellipsis-h pt40 text-light-color icon-big3 cursor-pointer fa-2x" class="options" title="Options"></i></div>
				<a href="analytics.html"><h1 class="text-primary text-center pt20"><%=obj.get("tracker_name").toString().replaceAll("[^a-zA-Z]", " ") %></h1></a>

				  <div class="card-body">
					<p class="card-text text-center postdate text-primary"><%=obj.get("date_created").toString()%>&nbsp;&nbsp;&nbsp;&nbsp;.&nbsp;&nbsp;&nbsp;&nbsp;5:30 PM</p>
					<div class="text-center">
					<button class="btn btn-default stylebutton5 text-primary p30 pt5 pb5" style="width:100%;">Sports&nbsp;&nbsp;.&nbsp;&nbsp;Science&nbsp;&nbsp;.&nbsp;&nbsp;Art</button>
					</div>
					<p class="mt20 text-primary text-center">
						<%=obj.get("description").toString()%>
					</p>
					<div class="text-center mt20">
					<button class="btn btn-default stylebutton6 text-primary p30 pt5 pb5 text-left" style="width:100%;">
					<h1 class="text-success mb0"><%=obj.get("blogsites_num").toString()%></h1>
					<h5 class="text-primary">Blogs</h5>
					</button>

					</div>

					<div class="text-center mt10">
					<button class="btn btn-default stylebutton6 text-primary p30 pt5 pb5 text-left" style="width:100%;">
					<h1 class="text-success mb0"><%=totalpost%></h1>
					<h5 class="text-primary">Posts</h5>
					</button>

					</div>
					<div class="text-center mt10">
					<button class="btn btn-default stylebutton6 text-primary p30 pt5 pb5 text-left" style="width:100%;">
					<h1 class="text-success mb0">120</h1>
					<h5 class="text-primary">Comments</h5>
					</button>

					</div>
				  </div>

				</div>
<% } %>
<%}else{ %>
<div >No tracker found</div>
<% } %>

</div>
</div>

<!-- <footer class="footer">
  <div class="container-fluid bg-primary mt60">
<p class="text-center text-medium pt10 pb10 mb0">Copyright &copy; Blogtrackers 2017 All Rights Reserved.</p>
</div>
  </footer> -->


 <script type="text/javascript" src="assets/js/jquery-1.11.3.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.js">
</script>


<script>
$(document).ready(function() {

} );
</script>
<!--end for table  -->


<script src="assets/js/generic.js">
</script>

</body>
</html>
<% }} %>
