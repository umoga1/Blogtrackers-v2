<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="util.Blogposts"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%
Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
Object id = (null == request.getParameter("p")) ? "" : request.getParameter("p");

Blogposts post  = new Blogposts();
ArrayList<?> userinfo = null;
String profileimage= "";
String username ="";
String name="";
String phone="";
String date_modified = "";

 userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = '"+email+"'");
 ArrayList detail = post._fetch(id.toString());
 //System.out.println(userinfo);
if (userinfo.size()<1 || detail.size()<1 ) {
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
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blogtrackers - Blog Post Page</title>
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
<!-- Base URL  -->
  <script src="pagedependencies/baseurl.js">
  </script>
  
</head>
<body style="background-color:#ffffff;">
 <!--  <nav class="navbar navbar-inverse bg-primary">
    <div class="container-fluid">
      <ul class="nav d-none d-lg-inline-flex d-xl-inline-flex  main-menu">
        <li><a href="<%=request.getContextPath()%>/dashboard.jsp"><i class="icon-user-plus"></i>Home</a></li>
        <li><a href="trackerlist.html"><i class="icon-cog5"></i> Trackers</a></li>
        <li><a href="#"><i class="icon-help"></i> Favorites</a></li>

      </ul>
  <nav class="navbar navbar-dark bg-primary float-left d-md-block d-sm-block d-xs-block d-lg-none d-xl-none">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
  <span class="navbar-toggler-icon"></span>
  </button>
  </nav>
  <div class="navbar-header d-none d-lg-inline-flex d-xl-inline-flex ">
  <a class="navbar-brand text-center" href="#"><img src="images/blogtrackers.png" /></a>
  </div>
  	<ul class="nav navbar-nav">
  <li class="dropdown dropdown-user cursor-pointer">
  <a class="dropdown-toggle" data-toggle="dropdown">
  <img src="<%=profileimage%>" width="50" height="50" onerror="this.src='images/default-avatar.png'" alt="" class="border-white" />
  <span><%=user_name[0]%></span>
  <ul class="profilemenu dropdown-menu dropdown-menu-left">
   <li><a href="<%=request.getContextPath()%>/profile.jsp"> My profile</a></li>
              <li><a href="#"> Features</a></li>
              <li><a href="#"> Help</a></li>
              <li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
  </ul>
  </a>

   </li>
        </ul>
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
    </nav> -->
    
<div class="modal-notifications">
<div class="row">
  <div class="offset-lg-10 col-lg-2 col-md-12 notificationpanel">
    <div id="closeicon" class="cursor-pointer"><i class="fas fa-times-circle"></i></div>
  <div class="profilesection col-md-12 mt50">
    <div class="text-center mb10" ><img src="<%=profileimage%>" width="60" height="60" onerror="this.src='images/default-avatar.png'" alt="" /></div>
    <div class="text-center" style="margin-left:0px;">
      <h6 class="text-primary m0 bolder profiletext"><%=name%></h6>
      <p class="text-primary profiletext"><%=email%></p>
    </div>

  </div>
  <div id="othersection" class="col-md-12 mt10" style="clear:both">
  <a class="cursor-pointer profilemenulink" href="notifications.html"><h6 class="text-primary">Notifications <b id="notificationcount" class="cursor-pointer">12</b></h6> </a>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/profile.jsp"><h6  class="text-primary">Profile</h6></a>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/logout"><h6 class="text-primary">Log Out</h6></a>
  </div>
  </div>
</div>
</div>
    <nav class="navbar navbar-inverse bg-primary">
          <div class="container-fluid mt10 mb10">

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
          <li><a href="<%=request.getContextPath()%>/dashboard.jsp"><i class="fas fa-home"></i> Home</a></li>
          <li><a href="trackerlist.html"><i class="far fa-dot-circle"></i> Trackers</a></li>
          <li><a href="favorites.html"><i class="far fa-heart"></i> Favorites</a></li>
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
                  <a class="nav-link" href="favorites.html">Favorites</a>
                </li>
              </ul>
      </div>
        </div>

<% if(detail.size()>0){
		
			String res = detail.get(0).toString();
			
			JSONObject resp = new JSONObject(res);
		    String resu = resp.get("_source").toString();
		     JSONObject obj = new JSONObject(resu);
		     
		     
		     String pst = obj.get("post").toString().replaceAll("[^a-zA-Z]", " ");
		     
 %>
<div class="container">
        <div class="row pt30 pb30 m20 mt0 mb0 d-none d-lg-block d-xl-block">
        <div class="col-lg-12 d-none d-lg-block d-xl-block">
        <div class="stickyoptions">
         <button class="btn btn-rounded"><i title="Track Blogsite" class="far fa-dot-circle icon-small text-primary"></i></button>
          <button class="btn btn-rounded"><i title="Add to Favorites" class="far fa-heart icon-small text-primary"></i></button>
           <a href="<%=obj.get("permalink") %>" target="_blank"> <button class="btn btn-rounded"><i title="View Post" class="fas fa-external-link-alt icon-small text-primary"></i></button></a>
        </div>
        <h1 class="text-center text-white post-title-font"><%=obj.get("title") %></h1>
        <p class="p10 pt40 pb10 text-center"><button class="btn btn-primary stylebuttonpostpage text-white mr10 mt10"><%=obj.get("blogger") %></button>
         <button class="btn btn-primary stylebuttonpostpage text-white mr10 mt10">02-01-2018, 5:30pm</button>
          <button class="btn btn-primary stylebuttonpostpage text-white mr10 mt10">National Public Radio</button> <button class="btn btn-primary stylebuttonpostpage text-white mr10 mt10"><%=obj.get("num_comments") %> comment(s)</button>
          <button class="btn btn-primary stylebuttonposttracking mr10 mt10">TRACKING</button>
          <button class="btn btn-primary stylebuttonposttracks mt10">2 Tracks</button></p>
      </div>
    </div>
    </div>
    </div>
      </nav>
    
<div class="container-fluid pl0 pr0 d-none d-lg-block d-xl-block">
  <div id="<%=obj.get("blogpost_id")%>" alt="<%=obj.get("permalink") %>"  style="background-image:;"  class="postimgfull postimage">
  </div>

</div>

<div class="container">



<!--For small and medium devices  -->
<div class="row pb50 mt0 mb0 d-md-block d-sm-block d-xs-block d-lg-none d-xl-none">
  <div class="container-fluid pl0 pr0 ml0 mr0 pb20">
  <div id="<%=obj.get("blogpost_id")%>" alt="<%=obj.get("permalink") %>"
  style="background-image:" class="postimgfull postimage">
  </div>
    </div>
<div class="col-md-12 d-md-block d-sm-block d-xs-block d-lg-none d-xl-none">
<a href="blogpostpage.html"><h3 class="text-center text-primary"><%=obj.get("title").toString().replaceAll("[^a-zA-Z]", " ")%></h3></a>
<div class="text-center mt20">
 <button class="btn btn-rounded"><i class="far fa-dot-circle icon-small text-primary"></i></button>
  <button class="btn btn-rounded"><i class="far fa-heart icon-small text-primary"></i></button>
</div>

<p class="text-center">
  <button class="btn btn-primary stylebuttonpostpage mr10 mt10"><%=obj.get("blogger") %></button>
  <button class="btn btn-primary stylebuttonpostpage mr10 mt10">02-01-2018, 5:30pm</button>

  <button class="btn btn-primary stylebuttonposttracking mr10 mt10">TRACKING</button>
  <button class="btn btn-primary stylebuttonposttracks mt10">553 Tracks</button></p>
<p class="text-primary"><%=obj.get("post") %></p>


<div class="<%=obj.get("blogpost_id")%>">
  <input type="hidden" class="postimage" id="<%=obj.get("blogpost_id")%>" name="pic" value="<%=obj.get("permalink") %>">
</div>


<div class="text-center mt50 mt50">
  <button class="btn btn-primary stylebuttonpostpage mr10 mt10">National Public Radio</button>
  <button class="btn btn-primary stylebuttonpostpage mr10 mt10"><%=obj.get("num_comments") %> comment(s)</button>
</div>
</div>
</div>
<!--end  -->



<!-- Post content For large devices  -->
<div class="row pt80 pb80 m20 mt0 mb0 d-none d-lg-block d-xl-block">
<div class="col-lg-12 d-none d-lg-block d-xl-block">
<p class="text-primary post-content">
<%=pst %>
</p>

</div>
</div>
<!--end  -->

<% 
}
%>










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

<script src="pagedependencies/imageloader2.js?v=8978989898"></script>

</body>
</html>
<% } %>
