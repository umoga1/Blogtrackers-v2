$(document).ready(function(){
$('.addblogbtn').on("click",function(){
$('.containeraddblog').removeClass("hidesection");
$('.createblog').addClass("hidesection");
})	

$('.cancelbtn').on("click",function(e){
	e.preventDefault();
	$('.containeraddblog').addClass("hidesection");
	$('.createblog').removeClass("hidesection");	
	 $('.blogtitle').val("");
	$('.blogurl').val("");
});

$('.createbtn').on("click",function(e){
	e.preventDefault();
	blogname = $('.blogtitle').val();
	blogurl = $('.blogurl').val();
	var urlregex = /(http|https):\/\/(\w+:{0,1}\w*)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%!\-\/]))?/;
	var pattern = new RegExp('^(https?:\\/\\/)?'+ // protocol
			  '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ '((\\d{1,3}\\.){3}\\d{1,3}))'+'(\\:\\d+)?'+'(\\/[-a-z\\d%@_.~+&:]*)*'+ '(\\?[;&a-z\\d%@_.,~+&:=-]*)?'+ '(\\#[-a-z\\d_]*)?$','i'); // fragment locator
		
		if(blogname === "")
	{
	toastr.error("Enter Blog Name","Error");	
	}
	else if(blogurl === "")
	{
	toastr.error("Enter Blog URL","Error");	
	}
	else if(!pattern.test(blogurl))
		{
		toastr.error("Invalid Blog URL","Error");
		}
	else
		{
		$.ajax({
			url:app_url+"blogsite/create",
			method:"POST",
			async:true,
			data:{
				blogname:blogname,
				blogurl:blogurl
			},
			error:function(response){
				
			},
			success:function(response){
				if(response=="success"){
					toastr.success("Blog successfully added");
					location.reload();
				}else{
					toastr.error("Blog not added","Error");	
				}
			}
		})
		}
	
});


	$('.deletebtn').on("click",function(e){
		e.preventDefault();
		id = $(this).id();
			$.ajax({
				url:app_url+"blogsite/delete",
				method:"POST",
				async:true,
				data:{
					blogsite_id:id
				},
				error:function(response){
					
				},
				success:function(response){
					if(response=="success"){
						toastr.success("Blog successfully deleted");
						location.reload();
					}else{
						toastr.error("Blog could not be deleted added","Error");	
					}
				}
			});
	
		
	});


});