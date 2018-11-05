/*  */
$('.blogger-select').on("click", function(){
	
	//$(".blogger-select").removeClass("btn-primary");
	//$(".blogger-select").addClass("text-primary opacity53");
	var blogger = $(this).attr("id");
	$("#"+blogger).addClass("btn-primary");
	var blg = blogger.split("***");
	$(".active-blogger").html(blg[0]);
	$(".active-blog").html(blg[2]);
	loadChart(blg[0],blg[1]);
	loadTerms(blg[0],blg[1]);
	loadSentiments(blg[0],blg[1]);
	loadInfluence(blg[0],blg[1]);
	loadSinglePost(blg[0],blg[1]);

});



$('.blogpost_link').on("click", function(){
	var post_id = $(this).attr("id");
	console.log(post_id);
	$("#blogpost_detail").html("<img src='"+app_url+"images/loading.gif'");
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
	$(".chart-container").html("<img src='"+app_url+"images/loading.gif'");
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

function loadInfluence(blogger,blog_id){
	$("#influence_table").html("<img src='"+app_url+"images/loading.gif'");
	$.ajax({
		url: app_url+"subpages/postingfrequencyinfluence.jsp",
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
			$("#influence_table").html(response);
		},
		success: function(response)
		{   
			console.log(response);
			$("#influence_table").html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
	
}


function loadTerms(blogger,blog_id){
	$("#tagcloudbox").html("<img src='"+app_url+"images/loading.gif'");
	
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
	$("#entity_table").html("<img src='"+app_url+"images/loading.gif'");
	
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
			$("#entity_table").html(response);
			$.getScript("assets/vendors/DataTables/datatables.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/dataTables.bootstrap4.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/buttons.flash.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/dataTables.buttons.min.js", function(data, textStatus, jqxhr) {	});
			 
			 $.getScript("assets/vendors/DataTables/pdfmake-0.1.32/pdfmake.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/pdfmake-0.1.32/vfs_fonts.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/buttons.html5.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/buttons.print.min.js", function(data, textStatus, jqxhr) {	});
	
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
	
}

function loadSinglePost(blogger,blog_id){
	$("#blogpost_detail").html("<img src='"+app_url+"images/loading.gif'");
	
	$.ajax({
		url: app_url+"subpages/postingfrequencypostdetail.jsp",
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
			$("#blogpost_detail").html(response);
		},
		success: function(response)
		{   
			console.log(response);s
			$("#blogpost_detail").html(response);
			 $.getScript("assets/vendors/DataTables/datatables.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/dataTables.bootstrap4.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/buttons.flash.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/dataTables.buttons.min.js", function(data, textStatus, jqxhr) {	});
			 
			 $.getScript("assets/vendors/DataTables/pdfmake-0.1.32/pdfmake.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/pdfmake-0.1.32/vfs_fonts.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/buttons.html5.min.js", function(data, textStatus, jqxhr) {	});
			 $.getScript("assets/vendors/DataTables/Buttons-1.5.1/js/buttons.print.min.js", function(data, textStatus, jqxhr) {	});
	
		}
	});
	
}