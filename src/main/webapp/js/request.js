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
				url: baseurl+'request',    
				method: 'POST',
				dataType: 'json',
				data: {
					email: $("input#username").val(),
					password: $("input#password").val(),
					remember: $("input#remember_me").val(),
					login: "yes",
				},
				error: function(response)
				{						
					console.log("got here");
					$("#error_message-box").html('Invalid username/password');
					$("#loggin").html(btntext);
		
				},
				success: function(response)
				{       
					var login_status = response;
					if(login_status === "invalid"){
						$("#error_message-box").html('Invalid username/password');
						$("#loggin").html(btntext);
					}else if(login_status == "success"){
						toastr.success('Login successfull!','Success');
						window.location.href = baseurl+"index.jsp";
					}else if(login_status == "confirmed"){
						window.location.href = baseurl+"index.jsp";
					}
					return false;
				}
			});
		
		return false;
		
	});
	
});
