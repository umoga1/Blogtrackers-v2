var baseurl = app_url;
var requests = new Array();
var z=0;

$(document).ready(function() {
	console.log("hree");
    //$('.postimage').on('load', function(img){ // image ready
    var img = $('.postimage');
    for(i=0; i<img.length; i++){
    	var id = img[i].id;
		var url = img[i].alt;
		//scrapeImage(id, url);
		getImage(id,url);
				
    }
  
});


function getImage(image_id,url){
	z++;
	var urll=baseurl+'subpages/imageloader.jsp?url='+url;
		requests[z] = $.ajax({ type: "GET",
		url:urll,
		async: true,
		success : function(data)
		{
			
			var meta = $(data).find('meta');//.attr("content");
			for(i=0; i<meta.length; i++){
				if(meta[i].name=="twitter:image" ){
					$("#"+image_id).attr('src',meta[i].content);
					return false;
				}else{
				
				var html = meta[i].outerHTML;
					var og = html.indexOf('property="og:image"');
					if(og>-1){
						var con = html.split("content=");
						if(con.length>1){
							content =  con[1].split('"');						
							$("#"+image_id).attr('src',content[1]);
							return false;
						}
					}
				}
			}
		
		}
	});
	return false;
}

function scrapeImage(image_id, url){	
	$.get(baseurl+'subpages/imageloader.jsp?url='+url, 
		function(data) {
			var meta = $(data).find('meta');//.attr("content");
			for(i=0; i<meta.length; i++){
				
				if(meta[i].name=="twitter:image" ){
					$("#"+image_id).attr('src',meta[i].content);
					return false;
				}else{
				
				var html = meta[i].outerHTML;
					var og = html.indexOf('property="og:image"');
					if(og>-1){
						var con = html.split("content=");
						if(con.length>1){
							content =  con[1].split('"');						
							$("#"+image_id).attr('src',content[1]);
							return false;
						}
					}
				}
			}
			
		  
		});		
}

