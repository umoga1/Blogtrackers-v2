$(document).ready(function(){


	
// mouse on each blog show the additional option of the blog
$('.edittrackerblogindividual').on("mouseover",function(e){
$(this).addClass("btnselected");
//add the other blog options


//check the status of all checkmarks tooltip
checkstatusofblog = $(this).children(".checkblogleft").children(".checkuncheckblog").hasClass("checkblog");

//console.log(checkstatusofblog)
if(checkstatusofblog)
{
// show other option icons if checked	
$(this).children(".iconsetblogs").children(".setoficons").removeClass("makeinvisible");	
$(this).children(".checkblogleft").children(".checkuncheckblog").attr("data-original-title","Deselect Blog");	
}
else if(!checkstatusofblog)
{
$(this).children(".checkblogleft").children(".checkuncheckblog").attr("data-original-title","Select Blog");	
$(this).children(".iconsetblogs").children(".setoficons").addClass("makeinvisible");	
}

});
	

$('.edittrackerblogindividual').on("mouseout",function(e){



// check if blog has been selected
selected = $(this).children('.checkblogleft').children('.checkuncheckblog').hasClass('checkblog');
//console.log(selected);
if(selected)
{
	// do nothing
$(this).children(".iconsetblogs").children(".setoficons").addClass("makeinvisible");
}
else if(!selected)
{
// hides the other blog options
$(this).children(".iconsetblogs").children(".setoficons").addClass("makeinvisible");	
$(this).removeClass("btnselected");
}


});


// select a blog with check mark track
$('.checkuncheckblog').on("click",function(e){
//check the status of the checkmark	
checked = $(this).hasClass('checkblog');	
//console.log(checked);

// unselect a blog
if(checked)
{
	
$(this).parent().parent().removeClass("btnselected text-success");	
// toast notification you already selected this blog
$(this).removeClass("checkblog");
$(this).addClass("uncheckblog");
toastr.error("Blog Deselected","Removed");

}
// select a blog
else if(!checked)
{
$(this).parent().parent().addClass("btnselected text-success");	
// if not check initially	
$(this).parent().parent().children(".checkblogleft").children(".checkuncheckblog").attr("data-original-title","Deselect Blog");
$(this).addClass("checkblog");
$(this).removeClass("uncheckblog");	
toastr.success("Blog Selected","Selected");
}
	
})


// track blogindividual action 
$('.trackblogindividual').on("click",function(e){
parentelement = $(this).parent().parent();
checkifnottrackingblog = $(this).hasClass('trackbloggrey');
if(checkifnottrackingblog)
{
	$(this).removeClass('trackbloggrey');
	$(this).addClass('trackblogblue');	
	parentelement.addClass('btnsuccess text-success').children(".checkblogleft").children(".checkuncheckblog").addClass('checkblog');
	toastr.success("Blog added to tracker","Success");
	// perform an ajax action to start blog track immediately
}
else if(!checkifnottrackingblog)
	{
	$(this).addClass('trackbloggrey');
	$(this).removeClass('trackblogblue');
	parentelement.removeClass('btnsuccess text-success');
	parentelement.children(".checkblogleft").children(".checkuncheckblog").removeClass('checkblog');
	toastr.error("Blog removed from tracker","Removed");
	// ajax to remove blog from being tracked
	}

})
		

	
});
