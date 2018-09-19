/* ------------------------------------------------------------------------------
 *
 *  # Login form with validation
 *
 *  Specific JS code additions for login_validation.html page
 *
 *  Version: 1.0
 *  Latest update: Aug 5, 2018
 *
 * ---------------------------------------------------------------------------- */

var baseurl = app_url;

$(function() {


	$('#request_form').submit( function(e) {
		e.preventDefault();
		var email = $("input#username").val();
		var password= $("input#password").val();
		if(email=="" || password=="" ){
			return false;
		}
				
		
		var password = $("#password").val(); 
			$.ajax({
				url: 'request',   
				method: 'POST',
				data: {
					email: $("input#username").val(),
					password: $("input#password").val(),
					madeRequest: "yes",
				},
				error: function(response)
				{						
					console.log(response);
				},
				success: function(response)
				{       
					console.log("in console here");
					console.log(response);
				}
			});
		
		return false;
		
	});
	
});
