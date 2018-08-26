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
				blogger:blogger,
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
