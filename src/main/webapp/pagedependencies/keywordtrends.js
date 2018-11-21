// delete all blog from tracker action


$('.select-term').on("click", function(){


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
	$("#total-influence").html("<img src='images/loading.gif' />");
	$("#total-post").html("<img src='images/loading.gif' />");
	$("#total-sentiment").html("<img src='images/loading.gif' />");
	$("#top-keyword").html("<img src='images/loading.gif' />");
	$.ajax({
		url: app_url+"subpages/keywordtrendschart.jsp",
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
		
		
		var data = JSON.parse(response);
		$("#total-influence").html(data.totalinfluence);
		$("#total-post").html(data.totalpost);
		$("#total-sentiment").html(data.totalsentiment);
		$("#top-keyword").html(data.topterm);
		//$("#overall-chart").delay(3000).html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />").delay(2000).html(response);
			/* $.getScript("assets/js/generic.js", function(data, textStatus, jqxhr) {	
			  });*/
		}
	});
}

function loadChart(term){
	$("#main-chart").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
	$.ajax({
		url: app_url+"subpages/keywordtrendschart.jsp",
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
	$("#url-table").html("<img style='position: absolute;top: 50%;left: 50%;' src='images/loading.gif' />");
		
		$.ajax({
			url: app_url+'subpages/keywordtrendtable.jsp',
			method: 'POST',
			data: {
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
				$("#url-table").html(response);
			}
		});
	}






