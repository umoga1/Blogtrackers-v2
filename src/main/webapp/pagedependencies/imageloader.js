var baseurl = app_url;
var requests = new Array();
var z=0;

$(document).ready(function() {
//	console.log("hree");
    //$('.postimage').on('load', function(img){ // image ready
    var img = $('.postimage');
//    console.log(img);
    for(i=0; i<img.length; i++){
    	var id = img[i].id;
		var url = img[i].alt;
		//scrapeImage(id, "https://www.oodaloop.com/");
		getImage(id,url);
				
    }
  
});


function getImage(image_id,url){
	
	var urll=baseurl+'subpages/imageloader.jsp?url='+url;
	var prev = $("#"+image_id).attr('src');
	if(prev==""){
		// remove the dafault image
//		$("#"+image_id).attr('src','https://i.pinimg.com/736x/31/74/48/3174480c49cee70bd03627255f136b83--fat-girls-girls-hbo.jpg');
		
//		$("#"+image_id).attr('src','');
//		console.log($("#"+image_id).attr('src'));
		z++;
		requests[z] = $.ajax({ type: "GET",
		url:urll,
		async: true,
		success : function(data)
		{
			
			var meta = $(data).find('meta');//.attr("content");
			for(i=0; i<meta.length; i++){
				if(meta[i].name=="twitter:image" ){
					$("#"+image_id).attr('src',meta[i].content);
//					console.log($("#"+image_id).attr('src'));
					
//					return true;
				}
//				else if ($("#"+image_id).attr('src') === "unknown" || $("#"+image_id).attr('src') === "") 
//				{
//					console.log(i);
//					$("#"+image_id).css("display","none");
////				$("#"+image_id).attr('src','https://i.pinimg.com/736x/31/74/48/3174480c49cee70bd03627255f136b83--fat-girls-girls-hbo.jpg');
//				}
				
//				else{
				
//				var html = meta[i].outerHTML;
//					var og = html.indexOf('property="og:image"');
//					if(og>-1){
//						var con = html.split("content=");
//						if(con.length>1){
//							content =  con[1].split('"');	
//			
//						
////							$("#"+image_id).attr('src',content[1]);
////							console.log($("#"+image_id).attr('src'));
////							if ($("#"+image_id).attr('src') === "" || $("#"+image_id).attr('src') === "https://i.pinimg.com/736x/31/74/48/3174480c49cee70bd03627255f136b83--fat-girls-girls-hbo.jpg")
////								{
////								$("#"+image_id).addClass("hidden");
////								}
//							return false;
//						}
//					}
//					else{
//						var nurl = extractRootDomain(url);
//						var pre = "";
//						if(url.indexOf("https")>-1){
//							pre = "https://";
//						}else{
//							pre = "http://";
//						}
//						
//						if(url.indexOf("www")>-1){
//							pre += "www.";
//						}else{
//							pre += "";
//						}
//						
//						nurl = pre+""+nurl;
//						console.log(nurl);
////						scrapeImage(image_id, nurl)
//					}
				
			
//			}
			}
		
		}
	});
}
//	return false;
}

function scrapeImage(image_id, url){	
	var prev = $("#"+image_id).attr('src')
	console.log(prev);
	if(prev==""){
	$("#"+image_id).attr('src','');
//	$("#"+image_id).attr('src','https://i.pinimg.com/736x/31/74/48/3174480c49cee70bd03627255f136b83--fat-girls-girls-hbo.jpg');
//	$("#"+image_id).addClass("hidden");
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
	}
	return false;		
}


function extractHostname(url) {
    var hostname;
    //find & remove protocol (http, ftp, etc.) and get hostname

    if (url.indexOf("://") > -1) {
        hostname = url.split('/')[2];
    }
    else {
        hostname = url.split('/')[0];
    }

    //find & remove port number
    hostname = hostname.split(':')[0];
    //find & remove "?"
    hostname = hostname.split('?')[0];

    return hostname;
}

//To address those who want the "root domain," use this function:
function extractRootDomain(url) {
    var domain = extractHostname(url),
        splitArr = domain.split('.'),
        arrLen = splitArr.length;

    //extracting the root domain here
    //if there is a subdomain 
    if (arrLen > 2) {
        domain = splitArr[arrLen - 2] + '.' + splitArr[arrLen - 1];
        //check to see if it's using a Country Code Top Level Domain (ccTLD) (i.e. ".me.uk")
        if (splitArr[arrLen - 2].length == 2 && splitArr[arrLen - 1].length == 2) {
            //this is using a ccTLD
            domain = splitArr[arrLen - 3] + '.' + domain;
        }
    }
    return domain;
}

