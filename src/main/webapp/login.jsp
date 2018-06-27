<%@page import="authentication.*"%>
<%
Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

if (email != null && email != "") {
	response.sendRedirect("dashboard.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="600561618290-lmbuo5mamod25msuth4tutqvkbn91d6v.apps.googleusercontent.com"/>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Blogtrackers - Login</title>
<link rel="shortcut icon" href="images/favicons/favicon.ico">
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
<link rel="stylesheet"
	href="assets/vendors/DataTables/Buttons-1.5.1/css/buttons.dataTables.min.css" />
<link rel="stylesheet" href="assets/css/daterangepicker.css" />

<link rel="stylesheet" href="assets/css/style.css" />

<link rel="stylesheet" href="assets/css/toastr.css">
<!--end of bootsrap -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/popper.min.js"></script>

<!-- JavaScript to be reviewed thouroughly by me -->
<script type="text/javascript" src="assets/js/validate.min.js"></script>
	<script type="text/javascript" src="assets/js/uniform.min.js"></script>
	
<script type="text/javascript" src="assets/js/toastr.js"></script>

  <script>
  <!-- update system url here -->
  var app_url = "http://localhost:8080/Blogtrackers/";
  //var app_url = "http://144.167.115.218:8080/Blogtrackers/";
  </script>
  <script src="https://apis.google.com/js/platform.js"></script>
  
<script type="text/javascript" src="js/login_validation.js?v=1897"></script>

</head>

<body>
	<nav class="navbar navbar-inverse bg-primary">
		<div class="container-fluid">

			<div class="navbar-header col-md-12">
				<a class="navbar-brand text-center col-md-12" href="./"><img
					src="images/blogtrackers.png" /></a>
			</div>


		</div>
	</nav>
	
	<div class="loginbox">
		<div class="row d-flex align-items-stretch">
			<div
				class="col-md-8 card m0 p0 borderradiusround nobordertopright noborderbottomright">
				<div
					class="card-body p40 pt40 pb5 borderradiusround nobordertopright noborderbottomright"
					style="background-color: #f4f5f6;">
					<p class="text-primary mb30" style="font-size: 26px;">
						Login or <b>Register</b>
					</p>
					<form id="login_form"  class=""  method="post">
						<div class="form-group">
							<div class="form-login-error">
                                <p id="error_message-box" style="color:red"></p>
							</div>
							<input type="email"
								class="form-control curved-form-login text-primary"
								 id="username" required="required" required aria-describedby="emailHelp"
								placeholder="Email">
							 <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
						</div>
						<br />
						<div class="form-group">
							<input type="password"
								class="form-control curved-form-login text-primary"
								  required="required" required id="password" placeholder="Password" >
							 <div class="invalid-feedback">Please enter your password</div>
						<!--	<div class="valid-feedback">Looks Good</div> -->
						</div>
						<br />
						<div class=""  id="loggin2"></div>
						<div>
						<p class="float-left pt10"><input type="checkbox" class="remembercheckbox"/>Remember Me</p>
						<p class="pt10 text-primary float-right">
							<small class="bold-text">Forgot your <a href="<%=request.getContextPath()%>/forgotpassword.jsp"><b>Password?</b></a></small>
						</p>
						
						</div>
						<div class="clearfloat"  id="loggin">
							<button type="submit" class="btn btn-primary loginformbutton mt10"
								style="background: #28a745;">Login</button>
							<!-- &nbsp;&nbsp;or Login with &nbsp;&nbsp;
							<button type="button" class="btn btn-rounded big-btn2 " id="glogin" >
								<i class="fab fa-google icon-small text-primary" ></i>
							</button><span></span> -->
							
							<!-- <i class="float-left googleicon pl0 pr10"></i>  -->
							
							<button type="button" id="glogin" class="btn buttonportfolio3 mt10 pt10 pb10 pl40">
							
							
							<b class="float-left bold-text">Sign in with Google </b></button>
 					</div>
						
						<p class="pb20 mt30 text-primary">
							Dont have an account yet? <a href="<%=request.getContextPath()%>/register"><b>Register
									Now</b></a></small>
						</p>
					</form>


 
  



				</div>

			</div>
			<div
				class="col-md-4 card m0 p0 bg-primary borderradiusround nobordertopleft noborderbottomleft othersection">
				<div
					class="card-body borderradiusround nobordertopleft noborderbottomleft p10 pt20 pb5 robotcontainer2">

				</div>
			</div>

		</div>
	</div>
<script>
/*
client id: 600561618290-lmbuo5mamod25msuth4tutqvkbn91d6v.apps.googleusercontent.com
secret: fxBw8tsZsREjMZ6VNC2HQ7O8

*/
var googleUser = {};
var startApp = function() {
  gapi.load('auth2', function(){
    // Retrieve the singleton for the GoogleAuth library and set up the client.
    auth2 = gapi.auth2.init({
      client_id: '600561618290-lmbuo5mamod25msuth4tutqvkbn91d6v.apps.googleusercontent.com',
      cookiepolicy: 'single_host_origin',
      // Request scopes in addition to 'profile' and 'email'
      //scope: 'additional_scope'
    });
    attachSignin(document.getElementById('glogin'));
  });
};

function attachSignin(element) {
 // console.log(element.id);
  auth2.attachClickHandler(element, {},
      function(googleUser) {
        var profile = googleUser.getBasicProfile();
   //     console.log(profile+"Here");
	//console.log(profile.getImageUrl());
  
       	register(profile.getEmail(),profile.getName(),profile.getImageUrl()); 
       
      }, function(error) {
        
      });
}

function onSignIn(googleUser) {
  var profile = googleUser.getBasicProfile();
  //console.log(profile.getImageUrl());
  register(profile.getEmail(),profile.getName(),profile.getImageUrl()); 
}

function register(email,name,pic){
	$("#loggin").html('<button type="button" class="btn btn-primary loginformbutton" style="background: #28a745;">Loggin in ...</button>');
	
	$.ajax({
			url: baseurl+'register',
			method: 'POST',
			//dataType: 'json',
			data: {
				email: email,
				name: name,
				profile_picture: pic,
				password: "",
				register: "yes",
				signin: "yes",
			},
			error: function(response)
			{						
				
			},
			success: function(response)
			{       			
				toastr.success('Login successfull!','Success');
				window.location.href = baseurl+"dashboard.jsp";
			}
		});
}


 startApp();
</script>
</body>
</html>
