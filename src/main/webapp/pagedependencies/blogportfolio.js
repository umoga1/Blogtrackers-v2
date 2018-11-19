// delete all blog from tracker action


$('#blogger-changed').on("change", function(){


	var date_start = $("#date_start").val();
	var date_end = $("#date_end").val();
	var blogger = $(this).val();
	
	var blg = blogger.split("_");
	
	var blog_id = blg[0];
	
	$(".active-blog").html(blg[1]);
	$("#blogid").val(blog_id);
	
	
	//loadInfluence(bloog,blg[1]);

	loadStat(blog_id);
	loadChart(blog_id);
	loadYearlyChart(blog_id)
	loadUrls(date_start,date_end);
});



function loadStat(blog_id){
	$("#total-influence").html("<img src='images/loading.gif' />");
	$("#total-post").html("<img src='images/loading.gif' />");
	$("#total-sentiment").html("<img src='images/loading.gif' />");
	$("#top-keyword").html("<img src='images/loading.gif' />");
	$.ajax({
		url: app_url+"subpages/blogportfoliochart.jsp",
		method: 'POST',
		data: {
			action:"getstats",
			blog_id:blog_id,
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			$("#overall-chart").html(response);
		},
		success: function(response)
		{   
		
		
		var data = JSON.parse(response);
		$("#total-influence").html(data.totalinfluence);
		$("#total-post").html(data.totalpost);
		$("#total-sentiment").html(data.totalsentiment);
		$("#top-keyword").html(data.topterms);
		//$("#overall-chart").delay(3000).html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />").delay(2000).html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
}

function loadChart(blog_id){
	$("#overall-chart").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
	$.ajax({
		url: app_url+"subpages/blogportfoliochart.jsp",
		method: 'POST',
		data: {
			action:"getchart",
			blog_id:blog_id,
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			$("#overall-chart").html(response);
		},
		success: function(response)
		{   

		$("#overall-chart").delay(3000).html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />").delay(2000).html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
}

function loadYearlyChart(blog_id){
	$("#yearlypattern").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
	$.ajax({
		url: app_url+"subpages/blogportfoliochart.jsp",
		method: 'POST',
		data: {
			action:"getyearlychart",
			blog_id:blog_id,
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			$("#yearlypattern").html(response);
		},
		success: function(response)
		{   

		$("#yearlypattern").delay(3000).html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />").delay(2000).html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
}



function loadUrls(date_start,date_end){
	$("#url-table").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
		
		$.ajax({
			url: app_url+'subpages/blogportfoliodomain.jsp',
			method: 'POST',
			data: {
				blog_id:$("#blogid").val(),
				date_start:date_start,
				date_end:date_end,
			},
			error: function(response)
			{						
				console.log(response);		
			},
			success: function(response)
			{   
				$("#url-table").html(response);
			}
		});
	}



function getStat(blog_id){
	$(".total-influence").html("");
	$.ajax({
		url: app_url+"subpages/postingfrequencypostdetail.jsp",
		method: 'POST',
		data: {
			action:"gettotalinfluence",
			blogger:blogger,
			blog_id:blog_id,
			sort:"influence_score",
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			$(".total-influence").html(response);
		},
		success: function(response)
		{   
			console.log(response);
			$(".total-influence").html(response);
				
		}
	});	
}


