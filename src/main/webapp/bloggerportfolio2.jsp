<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="util.Blogposts"%>
<%@page import="java.text.NumberFormat" %>
<%@page import="java.util.Locale" %>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

//if (email == null || email == "") {
	//response.sendRedirect("login.jsp");
//}else{

ArrayList<?> userinfo = new ArrayList();//null;
String profileimage= "";
String username ="";
String name="";
String phone="";
String date_modified = "";

userinfo = new DbConnection().query("SELECT * FROM usercredentials where Email = '"+email+"'");
 //System.out.println(userinfo);
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
}catch(Exception e){}


}

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blogtrackers - Blogger Portfolio</title>
  <link rel="shortcut icon" href="images/favicons/favicon-48x48.png">
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
  <link href="assets/vendors/animations/animate.min.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="assets/css/daterangepicker.css" />
  <link rel="stylesheet" href="assets/css/style.css" />

  <!--end of bootsrap -->
  <script src="assets/js/jquery-3.2.1.slim.min.js" ></script>
<script src="assets/js/popper.min.js"></script>
<script type="text/javascript" src="assets/vendors/animations/animations_css3.js"></script>
  <script src="pagedependencies/googletagmanagerscript.js"></script>
</head>
<body>
<%@include file="subpages/googletagmanagernoscript.jsp" %>
 <div class="modal-notifications">
<div class="row">
<div class="col-lg-10 closesection">
	
	</div>
  <div class="col-lg-2 col-md-12 notificationpanel">
    <div id="closeicon" class="cursor-pointer"><i class="fas fa-times-circle"></i></div>
  <div class="profilesection col-md-12 mt50">
  <% if(userinfo.size()>0){ %>
    <div class="text-center mb10" ><img src="<%=profileimage%>" width="60" height="60" onerror="this.src='images/default-avatar.png'" alt="" /></div>
    <div class="text-center" style="margin-left:0px;">
      <h6 class="text-primary m0 bolder profiletext"><%=name%></h6>
      <p class="text-primary profiletext"><%=email%></p>
    </div>
  <%} %>
  </div>
  <div id="othersection" class="col-md-12 mt10" style="clear:both">
  <% if(userinfo.size()>0){ %>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/notifications.jsp"><h6 class="text-primary">Notifications <b id="notificationcount" class="cursor-pointer">12</b></h6> </a>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/profile.jsp"><h6 class="text-primary">Profile</h6></a>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/logout"><h6 class="text-primary">Log Out</h6></a>
  <%}else{ %>
  <a class="cursor-pointer profilemenulink" href="<%=request.getContextPath()%>/login"><h6 class="text-primary">Login</h6></a>
  
  <%} %>
  </div>
  </div>
</div>
</div>

      <nav class="navbar navbar-inverse bg-primary">
        <div class="container-fluid mt10 mb10">

          <div class="navbar-header d-none d-lg-inline-flex d-xl-inline-flex  col-lg-3">
      <a class="navbar-brand text-center logohomeothers" href="./">
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
  	 <% if(userinfo.size()>0){ %>
  		
	  <ul class="nav navbar-nav" style="display:block;">
		  <li class="dropdown dropdown-user cursor-pointer float-right">
		  <a class="dropdown-toggle " id="profiletoggle" data-toggle="dropdown">
		    <i class="fas fa-circle" id="notificationcolor"></i>
		   
		  <img src="<%=profileimage%>" width="50" height="50" onerror="this.src='images/default-avatar.png'" alt="" class="" />
		  <span><%=username%></span></a>
			
		   </li>
	    </ul>
         <% }else{ %>
         <ul class="nav main-menu2 float-right" style="display:inline-flex; display:-webkit-inline-flex; display:-mozkit-inline-flex;">
        
        	<li class="cursor-pointer"><a href="login.jsp">Login</a></li>
         </ul>
        <% } %>
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

          <!-- <div class="col-md-12 mt0">
          <input type="search" class="form-control p30 pt5 pb5 icon-big border-none bottom-border text-center blogbrowsersearch nobackground" placeholder="Search Trackers" />
          </div> -->

        </nav>
<div class="container analyticscontainer">
<div class="row">
<div class="col-md-6 paddi">
<nav class="breadcrumb">
  <a class="breadcrumb-item text-primary" href="trackerlist.jsp">Trackers</a>
  <a class="breadcrumb-item text-primary" href="#">Second Tracker</a>
  <a class="breadcrumb-item active text-primary" href="dashboard.jsp">Dashboard</a>
  <a class="breadcrumb-item active text-primary" href="bloggerportfolio.jsp">Blogger Portfolio</a>
  </nav>
<div><button class="btn btn-primary stylebutton1 " id="printdoc">SAVE AS PDF</button></div>
</div>

<div class="col-md-6 text-right mt10">
<div class="text-primary demo"><h6 id="reportrange">Date: <span>02/21/18 - 02/28/18</span></h6></div>
<div>
  <div class="btn-group mt5" data-toggle="buttons">
  <!-- <label class="btn btn-primary btn-sm daterangebutton legitRipple nobgnoborder"> <input type="radio" name="options" value="day" autocomplete="off" > Day
  	</label>
    <label class="btn btn-primary btn-sm nobgnoborder"> <input type="radio" name="options" value="week" autocomplete="off" >Week
  	</label>
     <label class="btn btn-primary btn-sm nobgnoborder nobgnoborder"> <input type="radio" name="options" value="month" autocomplete="off" > Month
  	</label>
    <label class="btn btn-primary btn-sm text-center nobgnoborder">Year <input type="radio" name="options" value="year" autocomplete="off" >
  	</label> -->
   <!--  <label class="btn btn-primary btn-sm nobgnoborder " id="custom">Custom</label> -->
  </div>

  <!-- Day Week Month Year <b id="custom" class="text-primary">Custom</b> -->

</div>
</div>
</div>

<div class="row p0 pt40 pb40 border-top-bottom mt20 mb20">
  <div class="col-md-2 animated fadeInLeft">
<small class="text-primary">Selected Blogger</small>
<h2 class="textblue styleheading">AdNovum <div class="circle"></div></h2>
</div>
<div class="offset-md-4 col-md-3 text-right">
<small class="text-primary">Blogsite of <b class="text-blue"><u>Advonum</u></b></small><br/>
<button class="btn buttonportfolio"><b class="float-left">AdNovum</b> <b class="far fa-file-alt float-right iconportfolio"></b></button>
</div>
  <div class="col-md-3">
  <small class="text-primary">Find Blogger</small>
  <input class="form-control inputboxstyle opacity53 inputportfolio" placeholder="| Search" /><i class="fas fa-search searchiconinput"></i>
  </div>
</div>

<div class="row mt40">
<div class="col-md-3">
  <div class="card card-style mt20 opacity53 cursor-pointer">
    <div class="card-body  p30 pt10 pb10">
      <h6 class="card-title mb0">Maximum Influence</h6>
      <h2 class="mb0">649</h2>

        </div>
  </div>
  <a href="">
  <div class="card card-style mt20 opacity53 cursor-pointer">
    <div class="card-body  p30 pt10 pb10">
      <h6 class="card-title mb0">Top Keyword</h6>
      <h2 class="mb0">Krymu</h2>

        </div>
  </div>
</a>
  <div class="card card-style mt20 activebar cursor-pointer" style="">
    <div class="card-body  p30 pt10 pb10">
      <h6 class="card-title mb0">Posts</h6>
      <h2 class="mb0">70</h2>

        </div>
  </div>

  <div class="card card-style mt20 opacity53 cursor-pointer">
    <div class="card-body  p30 pt10 pb10">
      <h6 class="card-title mb0">Overall Sentiment</h6>
      <h2 class="mb0">Positive</h2>

        </div>
  </div>

</div>
<div class="col-md-9">
  <div class="card card-style mt20">
    <div class="card-body  p30 pt5 pb5">
      <div style="min-height: 365px;">
<div><p class="text-primary mt10 float-left"><b class="text-green">Posts</b> Published by <b class="textblue"><u>Advonum</u></b> of Past <select class="text-primary filtersort sortbytimerange"><option value="week">Week</option><option value="month">Month</option><option value="year">Year</option></select></p></div>
<!-- <svg class="linesvg" width="960" height="400"></svg> -->
<!-- <div id="lineplot" style="min-height: 380px;"></div> -->

<div class="chart-container">
  <div class="chart" id="d3-line-basic"></div>
</div>
      </div>
        </div>
  </div>
</div>


</div>


<div class="row mb0">
  <div class="col-md-6 mt20 ">
    <div class="card card-style mt20">
      <div class="card-body  p5 pt10 pb10">

        <div style="min-height: 420px;">
          <div><p class="text-primary p15 pb5 pt0"><b class="text-blue"><u>Advonum</u></b> Day of the Week Posting Pattern of Past <select class="text-primary filtersort sortbytimerange"><option value="week">Week</option><option value="month">Month</option><option value="year">Year</option></select></p></div>
          <div class="chart" id="d3-bar-horizontal">

          </div>
        </div>
          </div>
    </div>
  </div>

  <div class="col-md-6 mt20">
    <div class="card card-style mt20">
      <div class="card-body  p5 pt10 pb10">
        <div class="min-height-table"style="min-height: 420px;">
          <div><p class="text-primary p15 pb5 pt0"><b class="text-blue"><u>Advonum</u></b> Yearly Posting Pattern of Past <select class="text-primary filtersort sortbytimerange"><option value="week">Week</option><option value="month">Month</option><option value="year">Year</option></select></p></div>
          <div class="chart" id="yearlypattern">

          </div>
        </div>
          </div>
    </div>
  </div>
</div>

<div class="row mb50">
  <div class="col-md-6 mt20 ">
    <div class="card card-style mt20">
      <div class="card-body  p5 pt10 pb10">
        <p class="p15 pb5 pt0 text-primary">List of URLs of <b class="textblue">AdNovum</b></p>
        <div style="min-height: 420px;">
         <!--  <div class="p15 pb5 pt0" role="group">
          Export
          </div> -->
                <table id="DataTables_Table_0_wrapper" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>URL</th>
                                <th>Frequency</th>


                            </tr>
                        </thead>
                        <tbody>
                          <tr>
                              <td>URL</td>
                              <td>1</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>3</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>6</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>5</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>3</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>1</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>2</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>4</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>1</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>2</td>


                          </tr>
                        </tbody>
                    </table>
        </div>
          </div>
    </div>
  </div>

  <div class="col-md-6 mt20">
    <div class="card card-style mt20">
      <div class="card-body  p5 pt10 pb10">
        <p class="p15 pb5 pt0 text-primary">List of URLs of <b class="textblue">AdNovum</b></p>
        <div class="min-height-table"style="min-height: 420px;">
        <!--   <div class="p15 pb5 pt0" role="group">
          Export
          </div> -->
                <table id="DataTables_Table_1_wrapper" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>URL</th>
                                <th>Frequency</th>


                            </tr>
                        </thead>
                        <tbody>
                          <tr>
                              <td>URL</td>
                              <td>1</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>3</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>6</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>5</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>3</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>1</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>2</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>4</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>1</td>


                          </tr>
                          <tr>
                              <td>URL</td>
                              <td>2</td>


                          </tr>

                        </tbody>
                    </table>
        </div>
          </div>
    </div>
  </div>
</div>
</div>


<!-- <footer class="footer">
  <div class="container-fluid bg-primary mt60">
<p class="text-center text-medium pt10 pb10 mb0">Copyright &copy; 2017 All Rights Reserved.</p>
</div>
  </footer> -->


  <script type="text/javascript" src="assets/js/jquery-1.11.3.min.js"></script>
 <script src="assets/bootstrap/js/bootstrap.js">

 </script>
 <script src="assets/js/generic.js">
 </script>

 <script src="assets/vendors/bootstrap-daterangepicker/moment.js"></script>
 <script src="assets/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
 <!-- Start for tables  -->
 <script type="text/javascript" src="assets/vendors/DataTables/datatables.min.js"></script>
 <script type="text/javascript" src="assets/vendors/DataTables/dataTables.bootstrap4.min.js"></script>
 <script src="assets/vendors/DataTables/Buttons-1.5.1/js/buttons.flash.min.js"></script>
 <script src="assets/vendors/DataTables/Buttons-1.5.1/js/dataTables.buttons.min.js"></script>
 <script src="assets/vendors/DataTables/pdfmake-0.1.32/pdfmake.min.js"></script>
 <script src="assets/vendors/DataTables/pdfmake-0.1.32/vfs_fonts.js"></script>
 <script src="assets/vendors/DataTables/Buttons-1.5.1/js/buttons.html5.min.js"></script>
 <script src="assets/vendors/DataTables/Buttons-1.5.1/js/buttons.print.min.js"></script>

 <script>
 $(document).ready(function() {
	 
	 $('#printdoc').on('click',function(){
			print();
		}) ;
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

     $('#DataTables_Table_0_wrapper').DataTable( {
         "scrollY": 430,
         "scrollX": false,
          "pagingType": "simple"
         /*  ,
          dom: 'Bfrtip'
          ,

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
       	       linkedCalendars: false,
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
 <script type="text/javascript" src="assets/vendors/d3/d3_tooltip.js"></script>
 <script>

 $(function () {

     // Initialize chart
     lineBasic('#d3-line-basic', 300);

     // Chart setup
     function lineBasic(element, height) {


         // Basic setup
         // ------------------------------

         // Define main variables
         var d3Container = d3.select(element),
             margin = {top: 10, right: 10, bottom: 20, left: 30},
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
            .ticks(2)

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

 // data = [
 //   [{"date":"2016","close":1300},{"date":"2017","close":1700},{"date":"2018","close":2100}],
 //   [{"date":"2016","close":1500},{"date":"2017","close":1800}],
 //   [{"date":"2014","close":500},{"date":"2015","close":900},{"date":"2016","close":1200}]
 // ];

 data = [[

  {
    "date": "2015",
    "close": 500
  },
  {
    "date": "2016",
    "close": 100
  },
  {
    "date": "2017",
    "close": 300
  },
  {
    "date": "2018",
    "close": 500
  }
]];

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
                        .style("stroke", "0080CC")
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
                          .style("stroke", "17394C")
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
 $(function () {

     // Initialize chart
     barHorizontal('#d3-bar-horizontal', 390);

     // Chart setup
     function barHorizontal(element, height) {

       // Basic setup
       // ------------------------------

       // Define main variables
       var d3Container = d3.select(element),
           margin = {top: 5, right: 50, bottom: 20, left: 70},
           width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
           height = height - margin.top - margin.bottom - 5;

          var formatPercent = d3.format("");

       // Construct scales
       // ------------------------------

       // Horizontal
       var y = d3.scale.ordinal()
           .rangeRoundBands([height,0], .02, .7);

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
             {letter:"Mon", frequency:2550},
             {letter:"Tue", frequency:800},
             {letter:"Wed", frequency:500},
             {letter:"Thu", frequency:1700},
             {letter:"Fri", frequency:1900},
             {letter:"Sat", frequency:1500},
             {letter:"Sun", frequency:1450}
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

 <!-- Yearly patterns  -->
 <script>
 $(function () {

     // Initialize chart
     yearlypattern('#yearlypattern', 385);

     // Chart setup
     function yearlypattern(element, height) {


         // Basic setup
         // ------------------------------

         // Define main variables
         var d3Container = d3.select(element),
             margin = {top: 10, right: 10, bottom: 20, left: 50},
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

 // data = [
 //   [{"date":"2016","close":1300},{"date":"2017","close":1700},{"date":"2018","close":2100}],
 //   [{"date":"2016","close":1500},{"date":"2017","close":1800}],
 //   [{"date":"2014","close":500},{"date":"2015","close":900},{"date":"2016","close":1200}]
 // ];

 // data = [[
 //
 //  {
 //    "date": "2015",
 //    "close": 500
 //  },
 //  {
 //    "date": "2016",
 //    "close": 100
 //  },
 //  {
 //    "date": "2017",
 //    "close": 300
 //  },
 //  {
 //    "date": "2018",
 //    "close": 500
 //  }
 // ]];

 //console.log(data);
 // data = [];

 data = [
 [
   {
     "date": "Jan",
     "close": 1000
   },
   {
     "date": "Feb",
     "close": 1800
   },
   {
     "date": "Mar",
     "close": 1600
   },
   {
     "date": "Apr",
     "close": 1400
   },
   {
     "date": "May",
     "close": 2500
   },
   {
     "date": "Jun",
     "close": 500
   },
   {
     "date": "Jul",
     "close": 100
   },
   {
     "date": "Aug",
     "close": 500
   },
   {
     "date": "Sep",
     "close": 2300
   },
   {
     "date": "Oct",
     "close": 1500
   },
   {
     "date": "Nov",
     "close": 1900
   },
   {
     "date": "Dec",
     "close": 4170
   }
 ]
 ];

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
                        .style("stroke", "0080CC")
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
                      .style("stroke", "#0080CC")
                      .style("fill","#0080CC")
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
                          .style("stroke", "17394C")
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
             // Crosshair
             //svg.selectAll('.d3-crosshair-overlay').attr("width", width);
         }
     }
 });


 </script>

</body>
</html>
