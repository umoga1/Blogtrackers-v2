<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blogtrackers</title>
  <!-- start of bootsrap -->
  <link rel="shortcut icon" href="images/favicons/favicon.ico">
  <link rel="apple-touch-icon" href="images/favicons/favicon-48x48.png">
  <link rel="apple-touch-icon" sizes="96x96" href="images/favicons/favicon-96x96.png">
  <link rel="apple-touch-icon" sizes="144x144" href="images/favicons/favicon-144x144.png">

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
<!-- <link rel="stylesheet" href="assets/css/bar.css" /> -->
  <!--end of bootsrap -->
  <script src="assets/js/jquery-3.2.1.slim.min.js"></script>
<script src="assets/js/popper.min.js"></script>
</head>
<body>

  <nav class="navbar navbar-inverse bg-primary">
    <div class="container-fluid">
      <ul class="nav d-none d-lg-inline-flex d-xl-inline-flex  main-menu">
        <li><a href="./"><i class="icon-user-plus"></i>Home</a></li>
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
  <img src="https://i.pinimg.com/736x/31/74/48/3174480c49cee70bd03627255f136b83--fat-girls-girls-hbo.jpg" width="50" height="50" alt="" class="border-white" />
  <span>Hayder</span>
  <ul class="profilemenu dropdown-menu dropdown-menu-left">
              <li><a href="#"> My profile</a></li>
              <li><a href="#"> Features</a></li>
              <li><a href="#"> Help</a></li>
              <li><a href="#">Logout</a></li>
  </ul>
  </a>

   </li>
   
   <!-- To logout of Google --> 
    <button onclick="myFunction()">Sign Out</button>
   <script>
      function myFunction() {
      gapi.auth2.getAuthInstance().disconnect();
      location.reload();
   }
   </script>
   
   
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
    </nav>
<div class="container">
<div class="row">
<div class="col-md-6 paddi">
<nav class="breadcrumb">
  <a class="breadcrumb-item text-primary" href="trackerlist.html">MY TRACKER</a>
  <a class="breadcrumb-item text-primary" href="#">Second Tracker</a>
  <a class="breadcrumb-item active text-primary" href="#">Dashboard</a>
  </nav>
<div>Tracking: <button class="btn btn-primary stylebutton1">All Blogs</button></div>
</div>


</div>

<div class="row p0 pt10 pb10 border-top-bottom mt20 mb20">
<div class="col-md-2">
<div class="card curved-card mt10 mb10">
<div class="card-body p20 pt5 pb5">
<h6 class="text-blue mb0"><small>Blogs</small></h6>
<h3 class="text-blue mb0">200</h3>
</div>
</div>
</div>

<div class="col-md-2">
<div class="card curved-card mt10 mb10">
<div class="card-body p20 pt5 pb5">
<h6 class="text-blue mb0"><small>Bloggers</small></h6>
<h3 class="text-blue mb0">58 </h3>
</div>
</div>
</div>

<div class="col-md-2">
<div class="card curved-card mt10 mb10">
<div class="card-body p20 pt5 pb5">
<h6 class="text-blue mb0"><small>Subscribers</small></h6>
<h3 class="text-blue mb0">40,0000</h3>
</div>
</div>
</div>

<div class="col-md-2">
<div class="card curved-card mt10 mb10">
<div class="card-body p20 pt5 pb5">
<h6 class="text-blue mb0"><small>Posts</small></h6>
<h3 class="text-blue mb0">16,0000</h3>
</div>
</div>
</div>

<div class="col-md-2">
  <div class="card curved-card mt10 mb10">
  <div class="card-body p20 pt5 pb5">
<h6 class="text-blue mb0"><small>Frequency</small></h6>
<h3 class="text-blue mb0">1.5 </h3>
</div>
</div>
</div>

<div class="col-md-2">
  <div class="card curved-card mt10 mb10">
  <div class="card-body p20 pt5 pb5">
<h6 class="text-blue mb0"><small>Overall Sentiments</small></h6>
<h3 class="text-blue mb0">Positive </h3>
</div>
</div>
</div>

</div>

<div class="row mb0">
  <div class="col-md-6 mt20 ">
    <div class="card mt20">
      <div class="card-body  p15 pt15 pb15">
        <div><p class="text-primary mt0 float-right">Active <b class="text-blue">Blogs</b> During Past <b>Week</b></p></div>
        <div style="min-height: 490px;">
<div class="map-container map-choropleth"></div>
        </div>
          </div>
    </div>
  </div>

  <div class="col-md-6 mt20">
    <div class="card mt20">
      <div class="card-body  p30 pt5 pb5">
        <div><p class="text-primary mt10 float-right">Active <b class="text-blue">Blogs</b> During Past <b>Week</b></p></div>
        <div class="chart-container" >
        <div class="chart" id="d3-bar-vertical">
                      </div>
        </div>
          </div>
    </div>
  </div>
</div>

<div class="row mb20 mt20 pb30 bottom-border">
  <div class="col-md-3 pt10 pb0">
  <h5 class="text-primary text-center">Language Distribution </h5>
  <div class="chart-container pt20"  style="max-height:140px;">
    <div class="chart" align="center"  id="languagedistribution"></div>
  </div>
  </div>

  <div class="col-md-3 pt10 pb0">
  <h5 class="text-primary text-center">Blog Distribution </h5>
  <div class="chart-container pt20" style="max-height:140px;">
    <div class="chart" align="center" id="blogdistribution"></div>
  </div>
  </div>

  <div class="col-md-3 pt10 pb0">
  <h5 class="text-primary text-center">Blogger Distribution </h5>
  <div class="chart-container pt20" style="max-height:140px;">
    <div class="chart" align="center" id="bloggerdistribution"></div>
  </div>
  </div>

  <div class="col-md-3 pt10 pb0">
  <h5 class="text-primary text-center">Post Distribution </h5>
  <div class="chart-container pt20" style="max-height:140px;">
    <div class="chart" align="center" id="postdistribution"></div>
  </div>
  </div>

</div>

<div class="row mb50">
  <div class="col-md-12 mt10 ">
    <div class="card mt20">
      <div class="card-body  p0 pt40 pb40">
        <div style="min-height: 450px;">
    <div class="p15 pb5 pt0" role="group">
    Export Options
  </div>
          <table id="DataTables_Table_0_wrapper" class="display nowrap" style="width:100%">
                  <thead>
                      <tr>
                          <th>Blog</th>
                          <th>Posts</th>
                          <th>Subscribers</th>
                          <th>Frequency</th>
                          <th>Sentiments</th>
                          <th>Language</th>
                          <th>Location</th>

                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscribers</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

                      </tr>
                      <tr>
                          <td>Blog</td>
                          <td>Posts</td>
                          <td>Subscriber</td>
                          <td>Frequency</td>
                          <td>Sentiments</td>
                          <td>Language</td>
                          <td>Location</td>

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
<p class="text-center text-medium pt10 pb10 mb0">Copyright &copy; Blogtrackers 2017 All Rights Reserved.</p>
</div>
  </footer> -->


 <script type="text/javascript" src="assets/js/jquery-1.11.3.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.js">
</script>


<!-- Start for tables  -->
<script type="text/javascript" src="assets/vendors/DataTables/dataTables.min.js"></script>
<script type="text/javascript" src="assets/vendors/DataTables/dataTables.bootstrap4.min.js"></script>
<script src="assets/vendors/DataTables/buttons-1.5.1/js/buttons.flash.min.js"></script>
<script src="assets/vendors/DataTables/Buttons-1.5.1/js/dataTables.buttons.min.js"></script>
<script src="assets/vendors/DataTables/pdfmake-0.1.32/pdfmake.min.js"></script>
<script src="assets/vendors/DataTables/pdfmake-0.1.32/vfs_fonts.js"></script>
<script src="assets/vendors/DataTables/buttons-1.5.1/js/buttons.html5.min.js"></script>
<script src="assets/vendors/DataTables/buttons-1.5.1/js/buttons.print.min.js"></script>

<script>
$(document).ready(function() {
    $('#DataTables_Table_0_wrapper').DataTable( {
        "scrollY": 430,
        "scrollX": true,
         "pagingType": "simple",
         dom: 'Bfrtip',
      buttons:{
        buttons: [
            { extend: 'pdfHtml5',orientation: 'potrait', pageSize: 'LEGAL', className: 'btn-primary stylebutton1'},
            {extend:'csv',className: 'btn-primary stylebutton1'},
            {extend:'excel',className: 'btn-primary stylebutton1'},
            // {extend:'copy',className: 'btn-primary stylebutton1', text: 'Copy'},
            {extend:'print',className: 'btn-primary stylebutton1'},
        ]
      }
    } );
} );
</script>
<!--end for table  -->

<!-- <script src="http://d3js.org/d3.v3.min.js"></script> -->
<script type="text/javascript" src="assets/vendors/d3/d3.min.js"></script>
<script type="text/javascript" src="assets/vendors/d3/d3_tooltip.js"></script>
<script>
$(function () {

    // Initialize chart
    barVertical('#d3-bar-vertical', 456);

    // Chart setup
    function barVertical(element, height) {


        // Basic setup
        // ------------------------------

        // Define main variables
        var d3Container = d3.select(element),
            margin = {top: 5, right: 10, bottom: 20, left: 40},
            width = d3Container.node().getBoundingClientRect().width - margin.left - margin.right,
            height = height - margin.top - margin.bottom - 5;

           var formatPercent = d3.format("");

        // Construct scales
        // ------------------------------

        // Horizontal
        var x = d3.scale.ordinal()
            .rangeRoundBands([0, width], .72, .5);

        // Vertical
        var y = d3.scale.linear()
            .range([height, 0]);

        // Color
        var color = d3.scale.category20c();



        // Create axes
        // ------------------------------

        // Horizontal
        var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

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


                // Create tooltip
                    // ------------------------------



        // Load data
        // ------------------------------



        data = [
              {letter:"Monday", frequency:2550},
              {letter:"Tuesday", frequency:800},
              {letter:"Wednesday", frequency:500},
              {letter:"Thursday", frequency:1700},
              {letter:"Friday", frequency:1900},
              {letter:"Saturday", frequency:1500},
              {letter:"Sunday", frequency:3000},
          ];


          // Create tooltip
          var tip = d3.tip()
                 .attr('class', 'd3-tip')
                 .offset([-10, 0])
                 .html(function(d) {
                     return d.letter+" ("+d.frequency+")";
                 });

             // Initialize tooltip
             svg.call(tip);


            // Pull out values
            data.forEach(function(d) {
                d.frequency = +d.frequency;
            });



            // Set input domains
            // ------------------------------

            // Horizontal
            x.domain(data.map(function(d) { return d.letter; }));

            // Vertical
            y.domain([0, d3.max(data, function(d) { return d.frequency; })]);


            //
            // Append chart elements
            //

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
                .call(yAxis)


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


            // Add bars
            svg.selectAll(".d3-bar")
                .data(data)
                .enter()
                .append("rect")
                    .attr("class", "d3-bar")
                    .attr("x", function(d) { return x(d.letter); })
                    .attr("width", x.rangeBand())
                    .attr("y", function(d) { return y(d.frequency); })
                    .attr("height", function(d) { return height - y(d.frequency); })
                    .style("fill", function(d) { return "#58707E"; })
                    .on('mouseover', tip.attr('class', 'tooltip-inner in').show)
                    .on('mouseout', tip.hide);





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


            // Layout
            // -------------------------

            // Main svg width
            container.attr("width", width + margin.left + margin.right);

            // Width of appended group
            svg.attr("width", width + margin.left + margin.right);


            // Axes
            // -------------------------

            // Horizontal range
            x.rangeRoundBands([0, width], .1, .5);

            // Horizontal axis
            svg.selectAll('.d3-axis-horizontal').call(xAxis);


            // Chart elements
            // -------------------------

            // Line path
            svg.selectAll('.d3-bar').attr("x", function(d) { return x(d.letter); }).attr("width", x.rangeBand());
        }
    }
});


</script>



<script>
// languagedistribution
$(function () {

    // Initialize chart
    donutBasic('#languagedistribution', 45);

    // Chart setup
    function donutBasic(element, radius) {


        // Basic setup
        // ------------------------------

        // Colors
        var color = d3.scale.category20();


        // Create chart
        // ------------------------------

        // Add SVG element
        var container = d3.select(element).append("svg");

        // Add SVG group
        var svg = container
            .attr("width", radius * 2)
            .attr("height", radius * 2)
            .append("g")
                .attr("transform", "translate(" + radius + "," + radius + ")");


                var tip = d3.tip()
                       .attr('class', 'd3-tip')
                       .offset([-10, 0])
                       .html(function(d) {
                       if(d === null)
                       {
                         return "No Information Available";
                       }
                       else if(d !== null) {
                        return d.language+" ("+d.size+")";
                         }
                       // return "here";
                       });


        // Construct chart layout
        // ------------------------------

        // Arc
        var arc = d3.svg.arc()
            .outerRadius(radius)
            .innerRadius(radius / 1.45);

        // Pie
        var pie = d3.layout.pie()
            .sort(null)
            .value(function(d) { return d.size; });


        // Load data
        // ------------------------------

        data = [{"language":"English","size":200},{"language":"German","size":50},{"language":"Unknown","size":80}];
        // d3.csv("pies_basic.csv", function(error, data) {

            // Pull out values
            data.forEach(function(d) {
                d.size = +d.size;
            });


            //
            // Append chart elements
            //

            // Add a label for the pie chart
          // var getKey = function( obj, value ) {
	        //    var inverse = _.invert( obj );
	        //     return _.get( inverse, value, false );
          //   };
              locationvalue = d3.max(data, function(d) { return d.size; });
             console.log(data[locationvalue]);
            svg.append("text")
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .style("font-weight", 500)
                .text(function() {
                  d = null;
                  return d3.max(data, function(d) { return d.size; })
                  ; });

            // Bind data
            var g = svg.selectAll(".d3-arc")
                .data(pie(data))
                .enter()
                .append("g")
                    .attr("class", "d3-arc");

            // Add arc path
            g.append("path")
                .attr("d", arc)
                .style("stroke", "#fff")
                .style("fill", function(d) { return color(d.data.size); })
                .transition()
                    .ease("linear")
                    .duration(1800)
                    .attrTween("d", tweenPie);

            // Add text labels
            g.append("text")
                .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                .attr("dy", ".35em")
                .style("fill", "#fff")
                .style("font-size", 10)
                .style("text-anchor", "middle")
                //.text(function(d) { return d.data.language; });

                svg.selectAll(".d3-arc").data(data)
                .on("mouseover",tip.attr('class', 'tooltip-inner in').show)
                .on("mouseout",tip.hide)
                //.on("click",function(d){console.log(d.date)});

                function tweenPie(b) {
                    b.innerRadius = 0;
                    var i = d3.interpolate({startAngle: 0, endAngle: 0}, b);
                    return function(t) { return arc(i(t)); };
                }

                svg.call(tip)


        // });
    }
});

</script>


<script>

$(function () {

    // Initialize chart
    donutBasic('#blogdistribution', 45);

    // Chart setup
    function donutBasic(element, radius) {


        // Basic setup
        // ------------------------------

        // Colors
        var color = d3.scale.category20();


        // Create chart
        // ------------------------------

        // Add SVG element
        var container = d3.select(element).append("svg");

        // Add SVG group
        var svg = container
            .attr("width", radius * 2)
            .attr("height", radius * 2)
            .append("g")
                .attr("transform", "translate(" + radius + "," + radius + ")");


                var tip = d3.tip()
                       .attr('class', 'd3-tip')
                       .offset([-10, 0])
                       .html(function(d) {
                       if(d === null)
                       {
                         return "No Information Available";
                       }
                       else if(d !== null) {
                        return d.blog+" ("+d.size+")";
                         }
                       // return "here";
                       });


        // Construct chart layout
        // ------------------------------

        // Arc
        var arc = d3.svg.arc()
            .outerRadius(radius)
            .innerRadius(radius / 1.45);

        // Pie
        var pie = d3.layout.pie()
            .sort(null)
            .value(function(d) { return d.size; });


        // Load data
        // ------------------------------

        data = [{"blog":"Notonato","size":25000},{"blog":"Trump","size":16000},{"blog":"Nato","size":8500}];
        // d3.csv("pies_basic.csv", function(error, data) {

            // Pull out values
            data.forEach(function(d) {
                d.size = +d.size;
            });


            //
            // Append chart elements
            //

            // Add a label for the pie chart
            svg.append("text")
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .style("font-weight", 500)
                .text(function() { return d3.max(data, function(d) { return d.size; }); });

            // Bind data
            var g = svg.selectAll(".d3-arc")
                .data(pie(data))
                .enter()
                .append("g")
                    .attr("class", "d3-arc");

            // Add arc path
            g.append("path")
                .attr("d", arc)
                .style("stroke", "#fff")
                .style("fill", function(d) { return color(d.data.size); })
                .transition()
                    .ease("linear")
                    .duration(1800)
                    .attrTween("d", tweenPie);

            // Add text labels
            g.append("text")
                .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                .attr("dy", ".35em")
                .style("fill", "#fff")
                .style("font-size", 10)
                .style("text-anchor", "middle")
                //.text(function(d) { return d.data.language; });

                svg.selectAll(".d3-arc").data(data)
                .on("mouseover",tip.attr('class', 'tooltip-inner in').show)
                .on("mouseout",tip.hide)
                //.on("click",function(d){console.log(d.date)});

                function tweenPie(b) {
                    b.innerRadius = 0;
                    var i = d3.interpolate({startAngle: 0, endAngle: 0}, b);
                    return function(t) { return arc(i(t)); };
                }

                svg.call(tip)


        // });
    }
});

</script>

<!-- Blogger pie -->
<script>

$(function () {

    // Initialize chart
    donutBasic('#bloggerdistribution', 45);

    // Chart setup
    function donutBasic(element, radius) {


        // Basic setup
        // ------------------------------

        // Colors
        var color = d3.scale.category20();


        // Create chart
        // ------------------------------

        // Add SVG element
        var container = d3.select(element).append("svg");

        // Add SVG group
        var svg = container
            .attr("width", radius * 2)
            .attr("height", radius * 2)
            .append("g")
                .attr("transform", "translate(" + radius + "," + radius + ")");


                var tip = d3.tip()
                       .attr('class', 'd3-tip')
                       .offset([-10, 0])
                       .html(function(d) {
                       if(d === null)
                       {
                         return "No Information Available";
                       }
                       else if(d !== null) {
                        return d.blogger+" ("+d.size+")";
                         }
                       // return "here";
                       });


        // Construct chart layout
        // ------------------------------

        // Arc
        var arc = d3.svg.arc()
            .outerRadius(radius)
            .innerRadius(radius / 1.45);

        // Pie
        var pie = d3.layout.pie()
            .sort(null)
            .value(function(d) { return d.size; });


        // Load data
        // ------------------------------

        data = [{"blogger":"Adigun Adekunle","size":12003},{"blogger":"Sean Pierce","size":10000},{"blogger":"Allen Burry","size":4500}];
        // d3.csv("pies_basic.csv", function(error, data) {

            // Pull out values
            data.forEach(function(d) {
                d.size = +d.size;
            });


            //
            // Append chart elements
            //

            // Add a label for the pie chart
            svg.append("text")
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .style("font-weight", 500)
                .text(function() { return d3.max(data, function(d) { return d.size; }); });

            // Bind data
            var g = svg.selectAll(".d3-arc")
                .data(pie(data))
                .enter()
                .append("g")
                    .attr("class", "d3-arc");

            // Add arc path
            g.append("path")
                .attr("d", arc)
                .style("stroke", "#fff")
                .style("fill", function(d) {
                  return color(d.data.size);
                // maxsize =   d3.max(data, function(d) { return d.size; });
                // if(d.data.size == maxsize)
                // {
                //   return "#17394C";
                // }
                // else
                //   {
                //     return "#A2B0B7";
                //   }

                })
                .transition()
                    .ease("linear")
                    .duration(1800)
                    .attrTween("d", tweenPie);

            // Add text labels
            g.append("text")
                .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                .attr("dy", ".35em")
                .style("fill", "#fff")
                .style("font-size", 10)
                .style("text-anchor", "middle")
                //.text(function(d) { return d.data.language; });

                svg.selectAll(".d3-arc").data(data)
                .on("mouseover",tip.attr('class', 'tooltip-inner in').show)
                .on("mouseout",tip.hide)
                //.on("click",function(d){console.log(d.date)});

                function tweenPie(b) {
                    b.innerRadius = 0;
                    var i = d3.interpolate({startAngle: 0, endAngle: 0}, b);
                    return function(t) { return arc(i(t)); };
                }

                svg.call(tip)


        // });
    }
});

</script>

<script>

$(function () {

    // Initialize chart
    donutBasic('#postdistribution', 45);

    // Chart setup
    function donutBasic(element, radius) {


        // Basic setup
        // ------------------------------

        // Colors
        var color = d3.scale.category20();


        // Create chart
        // ------------------------------

        // Add SVG element
        var container = d3.select(element).append("svg");

        // Add SVG group
        var svg = container
            .attr("width", radius * 2)
            .attr("height", radius * 2)
            .append("g")
                .attr("transform", "translate(" + radius + "," + radius + ")");


                var tip = d3.tip()
                       .attr('class', 'd3-tip')
                       .offset([-10, 0])
                       .html(function(d) {
                       if(d === null)
                       {
                         return "No Information Available";
                       }
                       else if(d !== null) {
                        return d.post+" ("+d.size+")";
                         }
                       // return "here";
                       });


        // Construct chart layout
        // ------------------------------

        // Arc
        var arc = d3.svg.arc()
            .outerRadius(radius)
            .innerRadius(radius / 1.45);

        // Pie
        var pie = d3.layout.pie()
            .sort(null)
            .value(function(d) { return d.size; });


        // Load data
        // ------------------------------

        data = [{"post":"Trump is the president","size":1200},{"post":"Nato Launches new staellite","size":1500},{"post":"Facebook makes outstanding amount","size":4500}];
        // d3.csv("pies_basic.csv", function(error, data) {

            // Pull out values
            data.forEach(function(d) {
                d.size = +d.size;
            });


            //
            // Append chart elements
            //

            // Add a label for the pie chart
            svg.append("text")
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .style("font-weight", 500)
                .text(function() { return d3.max(data, function(d) { return d.size ; }); });

            // Bind data
            var g = svg.selectAll(".d3-arc")
                .data(pie(data))
                .enter()
                .append("g")
                    .attr("class", "d3-arc");

            // Add arc path
            g.append("path")
                .attr("d", arc)
                .style("stroke", "#fff")
                .style("fill", function(d) {
                  return color(d.data.size);
                // maxsize =   d3.max(data, function(d) { return d.size; });
                // if(d.data.size == maxsize)
                // {
                //   return "#17394C";
                // }
                // else
                //   {
                //     return "#A2B0B7";
                //   }

                })
                .transition()
                    .ease("linear")
                    .duration(1800)
                    .attrTween("d", tweenPie);

            // Add text labels
            g.append("text")
                .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                .attr("dy", ".35em")
                .style("fill", "#fff")
                .style("font-size", 10)
                .style("text-anchor", "middle")
                //.text(function(d) { return d.data.language; });

                svg.selectAll(".d3-arc").data(data)
                .on("mouseover",tip.attr('class', 'tooltip-inner in').show)
                .on("mouseout",tip.hide)
                //.on("click",function(d){console.log(d.date)});

                function tweenPie(b) {
                    b.innerRadius = 0;
                    var i = d3.interpolate({startAngle: 0, endAngle: 0}, b);
                    return function(t) { return arc(i(t)); };
                }

                svg.call(tip)


        // });
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
  "US": 14624.18,
  "UY": 40.71,
  "UZ": 37.72,
  "VU": 0.72,
  "VE": 285.21,
  "VN": 101.99,
  "YE": 30.02,
  "ZM": 15.69,
  "ZW": 5.57
};

// map marker location by longitude and latitude
var mymarker = [
    {latLng: [41.90, 12.45], name: 'Vatican City'},
    {latLng: [43.73, 7.41], name: 'Monaco'},
    {latLng: [40.726, -111.778], name: 'Salt Lake City'},
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
]
  </script>
<script type="text/javascript" src="assets/vendors/maps/jvectormap/jvectormap.min.js"></script>
<script type="text/javascript" src="assets/vendors/maps/jvectormap/map_files/world.js"></script>
<script type="text/javascript" src="assets/vendors/maps/jvectormap/map_files/countries/usa.js"></script>
<script type="text/javascript" src="assets/vendors/maps/jvectormap/map_files/countries/germany.js"></script>
<script type="text/javascript" src="assets/vendors/maps/vector_maps_demo.js"></script>
</body>
</html>