/**
 * @Author: Adewale Obadimu
 * 
 *<p> This page is responsible for handling the login process using JavaScript
 *
 */

var baseUrl = app_url;

function verifyPassword(element){
	var id = element.id;
	var content = element.value;
	var field = "password";

	var firstPassword = $("#password1").val();
	var secondPassword = $("#password2").val();

	if(firstPassword != secondPassword){
		$("#invalid").html('<span class = "help-block text-danger"><i class="icon-cancel-circle2 position-left"></i>Your password does not match </span>');
		$("#invalid").removeClass("validation-valid-label");
		#("#invalid").prop("#")
	}
}
