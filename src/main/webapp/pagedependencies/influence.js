// delete all blog from tracker action
$('.blogger-select').on("click", function(e){

		var blogger = $(e).attr("id");
		blogger = blogger.replaceAll("_"," ");
		// put this block of code in the ajax success request	
		
		//grab all id of blog and perform an ajax request
		$.ajax({
			url: app_url+'blogpost',
			method: 'POST',
			data: {
				action:"fetchpost",
				key:"blogger",
				value:blogger,
				source:"influence",
				section:"influential_table"
			},
			error: function(response)
			{						
				console.log(response);		
			},
			success: function(response)
			{   
				$("#influential-post-box").html(response);
			}
		});

});


$('.blogpost_link').on("click", function(){

	var post_id = $(this).attr("id");
	//alert(post_id);
	console.log(post_id);
	$("#blogpost_detail").html("images/loading.gif");
	//grab all id of blog and perform an ajax request
	$.ajax({
		url: app_url+'tracker',
		method: 'POST',
		data: {
			action:"fetchpost",
			key:"blogpost_id",
			value:post_id,
			source:"influence",
			section:"detail_table"
		},
		error: function(response)
		{						
			console.log(response);
			$("#blogpost_detail").html(response);
		},
		success: function(response)
		{   
			console.log(response);
			$("#blogpost_detail").html(response);
		}
	});
	

});

