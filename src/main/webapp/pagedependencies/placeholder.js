$(document).ready(function(){
	// close tracker creation
	$('.closetracker, .canceltracker').click(function(){
		
	$('.token-input').attr("placeholder","Add blog");	
	// delete the element	
	$(this).parent().parent().parent().remove();
	// hide the tooltip
	$(".tooltip").hide();
	// show the notification
	 $.getScript("assets/js/toastr.js", function(data, textStatus, jqxhr) {
		 loadCSS("assets/css/toastr.css");
		 toastr.error("Tracker Creation Canceled","Action Succesful");
	  });
	 
	});	
	
//	show the tooltip
	 $(function () {
		    $('[data-toggle="tooltip"]').tooltip()
		  });
	 
	 // create tracker
	 $('.createtracker').on("click",function(){
	 // grab the tracker name
	 trackername = $(this).parent().parent().find(".newtrackername").val();
	 trackerdescription = $(this).parent().parent().find(".newtrackerdescription").val();
     var blogs = $(this).parent().parent().find(".token span");
     var allblogs = [] ;
     // push into an array
    	 blogs.each(function(i,e)
       {
    		 allblogs[i] = e;
    	    	console.log(e); 
      });
	
     
	 console.log(trackername);	 
	 console.log(trackerdescription);
	 console.log(allblogs);
	 
	 
		 
	 });
	
	 
	 loadCSS = function(href) {

		  var cssLink = $("<link>");
		  $("head").append(cssLink); //IE hack: append before setting href

		  cssLink.attr({
		    rel:  "stylesheet",
		    type: "text/css",
		    href: href
		  });

		};
});