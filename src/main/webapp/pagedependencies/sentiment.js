

$('.blogpost_link').on("click", function(){

	var post_id = $(this).attr("id");
	//alert(post_id);
	post_id= post_id.split("-");
	console.log(post_id);
	$("#mainCarInd").html("images/loading.gif");
	//grab all id of blog and perform an ajax request
	$.ajax({
		url: app_url+"subpages/sentiment.jsp",
		method: 'POST',
		data: {
			action:"getsentiment",
			key:"blogpost_id",
			value:post_id[0],
			source:"sentiment",
			section:"time_orientation",
			date_from:$("#date_from").val(),
			date_to:$("#date_to").val(),
			postno:post_id[2],
			color:post_id[1]
		},
		error: function(response)
		{						
			console.log(response);
			$("#carouseller").html(response);
		},
		success: function(response)
		{   
			console.log(response);
			$("#mainCarInd").html(response);
		}
	});
	

});

