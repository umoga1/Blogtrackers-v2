<%@page import="java.net.HttpURLConnection"%>
<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="util.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%



Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
ArrayList<?> userinfo = new ArrayList();
String profileimage= "";
String username ="";
String name="";
String phone="";
String date_modified = "";
userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = '"+email+"'");
if (userinfo.size()<1) {
	//response.sendRedirect("login.jsp");
}else{
userinfo = (ArrayList<?>)userinfo.get(0);
try{
	username = (null==userinfo.get(0))?"":userinfo.get(0).toString();
	
	name = (null==userinfo.get(4))?"":(userinfo.get(4).toString());
		
	email = (null==userinfo.get(2))?"":userinfo.get(2).toString();
	phone = (null==userinfo.get(6))?"":userinfo.get(6).toString();
	//date_modified = userinfo.get(11).toString();
	String userpic = userinfo.get(9).toString();
	String[] user_name = name.split(" ");
	username = user_name[0];
	
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
	}catch(Exception e){
		profileimage = "images/default-avatar.png";
	}
}


%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blogtrackers-Home</title>
  <link rel="shortcut icon" href="images/favicons/favicon-48x48.png">
  <link rel="apple-touch-icon" href="images/favicons/favicon-48x48.png">
  <link rel="apple-touch-icon" sizes="96x96" href="images/favicons/favicon-96x96.png">
  <link rel="apple-touch-icon" sizes="144x144" href="images/favicons/favicon-144x144.png">
  <!-- start of bootsrap -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:600,700" rel="stylesheet">
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap-grid.css"/>
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.css"/>
  <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.css" />
  <link rel="stylesheet" href="assets/fonts/fontawesome/css/font-awesome-animation.min.css" />
  <link rel="stylesheet" href="assets/fonts/iconic/css/open-iconic.css" />
 <link rel="stylesheet" href="assets/vendors/bootstrap-daterangepicker/daterangepicker.css" />
 <link rel="stylesheet" href="assets/css/table.css" />
 <link rel="stylesheet" href="assets/vendors/DataTables/dataTables.bootstrap4.min.css" />
<link rel="stylesheet" href="assets/vendors/DataTables/Buttons-1.5.1/css/buttons.dataTables.min.css" />
<link rel="stylesheet" href="assets/css/daterangepicker.css" />

  <link rel="stylesheet" href="assets/css/style.css" />
  <!--end of bootstrap -->
  <script src="assets/js/jquery-3.2.1.slim.min.js"></script>
<script src="assets/js/popper.min.js" ></script>
<script src="pagedependencies/googletagmanagerscript.js"></script>
</head>
<body style="background-color:none;">
<noscript>
<%@include file="subpages/googletagmanagernoscript.jsp" %>
</noscript>
<!-- End Google Tag Manager (noscript) -->
<div class="container-fluid home-top" style="min-height:500px;">

<% if(userinfo.size()>0){%>
<div class="modal-notifications">
<div class="row">
<div class="col-lg-10 closesection">
	
	</div>
  <div class="col-lg-2 col-md-12 notificationpanel">
    <div id="closeicon" class="cursor-pointer"><i class="fas fa-times-circle"></i></div>
  <div class="profilesection col-md-12 mt50">
    <div class="text-center mb10" ><img src="<%=profileimage%>" onerror="this.src='images/default-avatar.png'"  width="60" height="60" onerror="this.src='images/default-avatar.png'" alt="" /></div>
    <div class="text-center" style="margin-left:0px;">
      <h6 class="text-primary m0 bolder profiletext"><%=name%></h6>
      <p class="text-primary profiletext"><%=email%></p>
    </div>

  </div>
  <div id="othersection" class="col-md-12 mt10" style="clear:both">
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/notifications.jsp"><h6 class="text-primary">Notifications <b id="notificationcount" class="cursor-pointer">12</b></h6> </a>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/profile.jsp"><h6 class="text-primary">Profile</h6></a>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/logout"><h6 class="text-primary">Log Out</h6></a>
  </div>
  </div>

</div>
</div>
  <nav class="navbar navbar-inverse">
    <div class="container-fluid mt10">

      <div class="navbar-header d-none d-lg-inline-flex d-xl-inline-flex  col-lg-3">
      <a class="navbar-brand text-center logohome" href="./">
   
      </a>
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
      <div class="col-lg-6 themainmenu"  align="center">
        <ul class="nav main-menu2" style="display:inline-flex; display:-webkit-inline-flex; display:-mozkit-inline-flex;">
           <li><a class="bold-text" href="<%=request.getContextPath()%>/blogbrowser.jsp"><i class="homeicon"></i> <b class="bold-text ml30">Home</b></a></li>
          <li><a class="bold-text" href="<%=request.getContextPath()%>/trackerlist.jsp"><i class="trackericon"></i><b class="bold-text ml30">Trackers</b></a></li>
          <li><a class="bold-text" href="<%=request.getContextPath()%>/favorites.jsp"><i class="favoriteicon"></i> <b class="bold-text ml30">Favorites</b></a></li>
          
            </ul>
      </div>

  <div class="col-lg-3">
  <ul class="nav navbar-nav" style="display:block;">
  <li class="dropdown dropdown-user cursor-pointer float-right">
  <a class="dropdown-toggle profiletoggle"  data-toggle="dropdown">
    <i class="fas fa-circle" id="notificationcolor"></i>
  <img src="<%=profileimage%>" width="50" height="50" alt="" class="" />
  <span><%=username%></span>
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
                <a class="" href="<%=request.getContextPath()%>/blogbrowser.jsp">Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/trackerlist.jsp">Trackers</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/favorites.jsp">Favorites</a>
              </li>
            </ul>
    </div>
      </div>
    </nav>
    
    <!-- Sticky Menu  -->
<div class="navsticky container-fluid ">
  <nav class="navbar navbar-inverse">
    <div class="container-fluid mt10">

      <div class="navbar-header d-none d-lg-inline-flex d-xl-inline-flex  col-lg-3">
      <a class="navbar-brand text-center logohome" href="./">
   
      </a>
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
      <div class="col-lg-6 themainmenu"  align="center">
        <ul class="nav main-menu2" style="display:inline-flex; display:-webkit-inline-flex; display:-mozkit-inline-flex;">
           <li><a class="bold-text" href="<%=request.getContextPath()%>/blogbrowser.jsp"><i class="homeicon"></i> <b class="bold-text ml30">Home</b></a></li>
          <li><a class="bold-text" href="<%=request.getContextPath()%>/trackerlist.jsp"><i class="trackericon"></i><b class="bold-text ml30">Trackers</b></a></li>
          <li><a class="bold-text" href="<%=request.getContextPath()%>/favorites.jsp"><i class="favoriteicon"></i> <b class="bold-text ml30">Favorites</b></a></li>
          
            </ul>
      </div>

  <div class="col-lg-3">
  <ul class="nav navbar-nav" style="display:block;">
  <li class="dropdown dropdown-user cursor-pointer float-right">
  <a class="dropdown-toggle profiletoggle" id="" data-toggle="dropdown">
    <i class="fas fa-circle" id="notificationcolor"></i>
  <img src="<%=profileimage%>" width="50" height="50" alt="" class="" />
  <span><%=username%></span>
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
                <a class="" href="<%=request.getContextPath()%>/blogbrowser.jsp">Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/trackerlist.jsp">Trackers</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/favorites.jsp">Favorites</a>
              </li>
            </ul>
    </div>
      </div>
    </nav>
</div>
<% }else{ %>

<nav class="navbar navbar-inverse">
<!-- Logo -->
  <div class="navbar-header float-left">
  <a class="navbar-brand text-center logohome" href="./">
  </a>
  </div>

  <nav class="navbar navbar-dark bg-primary float-right d-md-block d-sm-block d-xs-block d-lg-none d-xl-none" >
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
  <span class="navbar-toggler-icon"></span>
  </button>
  </nav>
  
  <!-- Desktop Menu -->
<div class="themainmenu"  align="center">
  <ul class="nav main-menu2 homemainmenuoveride" style="display:inline-flex; display:-webkit-inline-flex; display:-mozkit-inline-flex;">
    <li><a class="bold-text" href="#">Features</a></li>
    <li><a class="bold-text" href="#">Sponsors</a></li>
	<li><a class="bold-text" href="#">Learn</a></li>
	<li class="bg-white loginmenu"><a class="bold-text text-primary" href="<%=request.getContextPath()%>/login.jsp">Login</a></li>
	
  </ul>
</div>

<!-- Mobile menu -->
  <div class="col-md-12 bg-dark d-md-block d-sm-block d-xs-block d-lg-none d-xl-none p0 mt20">
  <div class="collapse" id="navbarToggleExternalContent">
    <ul class="navbar-nav mr-auto mobile-menu">
          <li class="nav-item active">
            <a class="bold-text" href="#">Features <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link bold-text" href="#">Sponsors</a>
          </li>
     

		   <li class="nav-item">
				<a class="nav-link bold-text" href="login.jsp">Login</a>
			</li>         
        </ul>
</div>
</div>
</nav>

<!-- STICKY MENU  -->
<div class="navsticky container-fluid ">
<nav class="navbar navbar-inverse">
 <div class="navbar-header float-left">
  <a class="navbar-brand text-center logohome" href="./">
  </a>
  </div>
  
   <nav class="navbar navbar-dark bg-primary float-right d-md-block d-sm-block d-xs-block d-lg-none d-xl-none" >
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
  <span class="navbar-toggler-icon"></span>
  </button>
  </nav>
  
<div class="themainmenu"  align="center">
  <ul class="nav main-menu2 homemainmenuoveride" style="display:inline-flex; display:-webkit-inline-flex; display:-mozkit-inline-flex;">
    <li><a class="bold-text" href="#">Features</a></li>
    <li><a class="bold-text" href="#">Sponsors</a></li>
	<li><a class="bold-text" href="#">Learn</a></li>
	<li class="bg-white loginmenu"><a class="bold-text text-primary" href="<%=request.getContextPath()%>/login.jsp">Login</a></li>
	
  </ul>
</div>
<!-- Mobile menu -->
  <div class="col-md-12 bg-dark d-md-block d-sm-block d-xs-block d-lg-none d-xl-none p0 mt20">
  <div class="collapse" id="navbarToggleExternalContent">
    <ul class="navbar-nav mr-auto mobile-menu">
          <li class="nav-item active">
            <a class="bold-text" href="#">Features <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link bold-text" href="#">Sponsors</a>
          </li>
     

		   <li class="nav-item">
				<a class="nav-link bold-text" href="login.jsp">Login</a>
			</li>         
        </ul>
</div>
</div>
</nav>
</div>

<% } %>


<div class="text-center mt60 offset-lg-3 col-lg-6 col-md-12" style="font-size:20px;">
<h1 class="text-white text-center bold-text" style="font-size:55px;">Track Blogs</h1>
<p class="text-white text-center mt20" style="width:90%; margin:0 auto;">Monitor and suggest valuable insights in a drill down fashion using content analysis and social network analysis</p>
<form method="search" method="post" autocomplete="off" action="<%=request.getContextPath()%>/blogbrowser.jsp">
<input type="search" placeholder="Search" name="term" class="form-control searchhome bold-text"/>
<button type="submit" class="btn btn-success homebutton mt0 p40 pt10 pb10 mb60 mt40">Start Tracking</button>
</form>
</div>


<div class="robotcontainer">

</div>
</div>

<div class="container bggreyhome mt50 mb50" id="featuresection">
<div class="offset-md-2 col-md-8 offset-md-2">
<h3 class="whyfont text-primary text-center pt30">Why Blogtrackers?</h3>
<p class="text-center text-primary p40 pt10 pb10">Blogtrackers helps sociologists to track and analyze blogs of particular interests by designing and integrating unique features. </p>
</div>
<div class="row">
<div class="col-md-4"><p class="text-center"><i class="navbar-brand text-primary icontrackersize researchbased pt10"></i></p>
<p class="text-center text-primary textwhy mb10">Research Based</p>
<p class="text-center text-primary p20 pt0 pb0">Built to review user behavior in the blogosphere.</p>
</div>
<div class="col-md-4"><p class="text-center"><i class="navbar-brand text-primary icontrackersize userfriendly pt10"></i></p>
<p class="text-center text-primary textwhy mb10">User Friendly</p>
<p class="text-center text-primary p20 pt0 pb0">Easy-to-use interface for the user.</p></div>
<div class="col-md-4"><p class="text-center"><i class="navbar-brand text-primary icontrackersize insights pt10"></i></p>
<p class="text-center text-primary textwhy mb10">Actionable Insights</p>
<p class="text-center text-primary p20 pt0 pb0">Track Blogs at your tips.</p></div>

</div>
<div class="col-md-12 text-center"><button type="submit" class="btn btn-success homebutton mt0 p40 pt10 pb10 mb60 mt40">Start Tracking</button></div>
</div>
<div class="bgwhite">
<div class="container mb50 mt50 " id="whatyoucando">
<div class="offset-md-2 col-md-8 offset-md-2">
<h3 class="sectiontitle text-primary text-center pt30">What Can You Do With It?</h3>
<p class="text-center text-primary p40 pt10 pb10">Blogtrackers helps sociologists to track and analyze blogs of particular interests by designing and integrating unique features. </p>
</div>
<div class="col-md-12 text-center"><button type="submit" class="btn btn-success homebutton mt0 p40 pt10 pb10 mb60 mt40">Start Tracking</button></div>
</div>
</div>

<div class="text-center cursor-pointer helpcontainer">
<a href="<%=request.getContextPath()%>/documentation.jsp" class="navbar-brand cursor-pointer helpicon">
<!-- <i class="text-white" ></i> -->

</a>
 </div>




<script type="text/javascript" src="assets/js/jquery-1.11.3.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.js">
</script>
<script src="assets/js/generic.js">

</script>
</body>
</html>