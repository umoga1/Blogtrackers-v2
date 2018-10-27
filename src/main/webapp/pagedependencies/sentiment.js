

$('.blogpost_link').on("click", function(){

	var post_id = $(this).attr("id");
	//alert(post_id);
	loadChart(post_id);

});

function loadChart(postid){
	var post_id = postid;
	post_id= post_id.split("-");
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
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
	

}

function loadPost(date){

	$("#postConainer").html("images/loading.gif");
	//grab all id of blog and perform an ajax request
	$.ajax({
		url: app_url+"subpages/sentimentpost.jsp",
		method: 'POST',
		data: {
			action:"getpost",
			key:"date",
			value:date,
			source:"sentiment",
			section:"influential_blogpost",
			blog_ids:$("#blog_ids").val(),
		},
		error: function(response)
		{						
			console.log(response);
			//$("#carouseller").html(response);
		},
		success: function(response)
		{   
			//console.log(response);
			$("#postConainer").html(response);
			
			var first = $('.blogpost_link')[0];
			cosole.log(first);
			var post_id = $(first).attr("id");
			loadChart(post_id);ss		
		}
	});
	
}

