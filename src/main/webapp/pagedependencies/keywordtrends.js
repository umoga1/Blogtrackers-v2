// delete all blog from tracker action


$('.select-term').on("click", function(){

	$(".select-term").removeClass("abloggerselected");
	$(this).addClass("abloggerselected");
	
	var date_start = $("#date_start").val();
	var date_end = $("#date_end").val();
	var term = $(this).attr("id");
	
	var tm = term.replaceAll("_"," ");
	
	$(".active-term").html(tm);
	
	
	//loadInfluence(bloog,blg[1]);
	$("#term").val(tm);
	loadStat(tm);
	loadChart(tm);
	loadTable(date_start,date_end);
});



function loadStat(term){
	$(".blog-mentioned").html("<img src='images/loading.gif' />");
	$(".post-mentioned").html("<img src='images/loading.gif' />");
	$(".blogger-mentioned").html("<img src='images/loading.gif' />");
	//$(".top-location").html("<img src='images/loading.gif' />");
	$.ajax({
		url: app_url+"subpages/keywordtrendchart.jsp",
		method: 'POST',
		data: {
			action:"getstats",
			term:term,
			date_start:$("#date_start").val(),
			date_end:$("#date_end").val(),
		},
		error: function(response)
		{						
			console.log(response);
			//$("#overall-chart").html(response);
		},
		success: function(response)
		{   
		
		response = response.trim();
		console.log(response);
		var data = JSON.parse(response);
		$(".blog-mentioned").html(data.blogmentioned);
		$(".post-mentioned").html(data.postmentioned);
		$(".blogger-mentioned").html(data.bloggermentioned);
		//$(".top-location").html(data.toplocation);
		//$("#overall-chart").delay(3000).html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />").delay(2000).html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
}

function loadChart(term){
	$("#main-chart").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
	$.ajax({
		url: app_url+"subpages/keywordtrendchart.jsp",
		method: 'POST',
		data: {
			action:"getchart",
			term:term,
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

		$("#main-chart").delay(3000).html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />").delay(2000).html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
}


function loadTable(date_start,date_end){
	$("#post-list").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
	$("#blogpost_detail").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
		
		$.ajax({
			url: app_url+'subpages/keywordtrendchart.jsp',
			method: 'POST',
			data: {
				action:"gettable",
				term:$("#term").val(),
				date_start:date_start,
				date_end:date_end,
			},
			error: function(response)
			{						
				console.log(response);		
			},
			success: function(response)
			{   
				$("#combined-div").html(response);
			}
		});
	}






