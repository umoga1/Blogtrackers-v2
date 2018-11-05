/*  */
$('.blogger-select').on("click", function(){
	
	//$(".blogger-select").removeClass("btn-primary");
	//$(".blogger-select").addClass("text-primary opacity53");
	var blogger = $(this).attr("id");
	$("#"+blogger).addClass("btn-primary");
	var blg = blogger.split("***");
	loadChart(blg[0],blg[1]);
	loadTerms(blg[0],blg[1]);
	loadSentiments(blg[0],blg[1]);

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

function loadChart(blogger,blog_id){
	$(".chart-container").html("images/loading.gif");
	$.ajax({
		url: app_url+"subpages/postingfrequencychart.jsp",
		method: 'POST',
		data: {
			action:"getchart",
			blogger:blogger,
			blog_id:blog_id,
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			$(".chart-container").html(response);
		},
		success: function(response)
		{   
			console.log(response);
			$(".chart-container").html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
	
}


function loadTerms(blogger,blog_id){
	$("#tagcloudbox").html("images/loading.gif");
	
	$.ajax({
		url: app_url+"subpages/postingfrequencyterm.jsp",
		method: 'POST',
		data: {
			action:"getchart",
			blogger:blogger,
			blog_id:blog_id,
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			$("#tagcloudbox").html(response);
		},
		success: function(response)
		{   
			console.log(response);
			$("#tagcloudbox").html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
	
}


function loadSentiments(blogger,blog_id){
	$("#entity_table").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
	
	$.ajax({
		url: app_url+"subpages/postingfrequencysentiment.jsp",
		method: 'POST',
		data: {
			action:"getchart",
			blogger:blogger,
			blog_id:blog_id,
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			$("#entity_table").html(response);
		},
		success: function(response)
		{   
			console.log(response);
			$("#entity_table").delay(3000).html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />").delay(2000).html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
	
}