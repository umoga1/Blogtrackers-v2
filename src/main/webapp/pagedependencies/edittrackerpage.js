$(document).ready(function(){

numberofblogs = $('.edittrackerblogindividual').length;
//console.log(numberofblogs);
$('#totalblogcount').html(numberofblogs);
	// count the number of selected blogs on load
countselectedfromdefault =  $('.edittrackerblogindividual').children(".checkblogleft").children(".checkblog").length;
// initialize the count of the selected blog
var blogselectedcount = countselectedfromdefault;
$('#selectedblogcount').html(blogselectedcount);
$(window).on("load",function(){

// check for checked blog

checkedblog = $('.edittrackerblogindividual').children(".checkblogleft").children(".checkuncheckblog"); 
 
if(checkedblog.hasClass('checkblog'))
{
// select active blog in tracker	
$('.edittrackerblogindividual').children(".checkblogleft").has('.checkblog').parent().addClass("btnselected text-success");	

// activate the status of tracking by default 
$('.edittrackerblogindividual').children(".checkblogleft").has('.checkblog').parent().children('.iconsetblogs').children('.trackblogindividual').addClass('trackblogblue').removeClass('trackbloggrey').attr("data-original-title","Untrack Blog");
}

})
	
// mouse on each blog show the additional option of the blog
$('.edittrackerblogindividual').on("mouseover",function(e){
$(this).addClass("btnselected").removeClass("btndefaultlook");
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
$(this).removeClass("btnselected").addClass("btndefaultlook");
}


});


// select a blog with check mark track
$('.checkuncheckblog').on("click",function(e){
//check the status of the checkmark	
checked = $(this).hasClass('checkblog');	
//console.log(checked);

// unselect a blog action
if(checked)
{
	
$(this).parent().parent().removeClass("btnselected text-success");	
// toast notification you already selected this blog
$(this).removeClass("checkblog");
$(this).addClass("uncheckblog");
toastr.error("Blog Deselected","Removed");
// check if selectedcount is not zero
if(blogselectedcount != 0)
{
	blogselectedcount--;
	$('#selectedblogcount').html(blogselectedcount);
}

}
// select a blog action
else if(!checked)
{
$(this).parent().parent().addClass("btnselected text-success");	
// if not check initially	
$(this).parent().parent().children(".checkblogleft").children(".checkuncheckblog").attr("data-original-title","Deselect Blog");
$(this).addClass("checkblog");
$(this).removeClass("uncheckblog");	
toastr.success("Blog Selected","Selected");
blogselectedcount++;
$('#selectedblogcount').html(blogselectedcount);
}
	
})


// track blogindividual action 
$('.trackblogindividual').on("click",function(e){
parentelement = $(this).parent().parent();
checkifnottrackingblog = $(this).hasClass('trackbloggrey');

// track blog action 
if(checkifnottrackingblog)
{
	// put all blog of code in ajax call success
	$(this).removeClass('trackbloggrey');
	$(this).addClass('trackblogblue').attr("data-original-title","Untrack Blog");	
	parentelement.addClass('btnsuccess text-success').children(".checkblogleft").children(".checkuncheckblog").addClass('checkblog').removeClass('uncheckblog');
	toastr.success("Blog added to tracker","Success");
	// increase selected count
	blogselectedcount++;
	$('#selectedblogcount').html(blogselectedcount);
	// perform an ajax action to start blog track immediately
}
// untrack blog action 
else if(!checkifnottrackingblog)
	{
	// put all blog of code in ajax call success
	$(this).addClass('trackbloggrey');
	$(this).removeClass('trackblogblue');
	parentelement.removeClass('btnsuccess text-success');
	parentelement.children(".checkblogleft").children(".checkuncheckblog").removeClass('checkblog').addClass('uncheckblog');
	
	toastr.error("Blog removed from tracker","Removed");
	if(blogselectedcount != 0)
	{
		blogselectedcount--;
		$('#selectedblogcount').html(blogselectedcount);
	}
	// ajax to remove blog from being tracked
	}

})

// refresh blog individual action 
$('.refreshblog').on('click', function(){
eachblogrefresh = $(this);
// should kick in the automated crawler or something 	
	toastr.success("Blog Refreshing","Success");	
});

//delete tracker 
$('.deleteblog').on('click', function(){
	var confirmdeleteofblog = confirm("Are you sure you want to delete");
	eachblogdelete = $(this);
	eachblogdelete.parent().parent().parent().remove();
	// should kick in the automated crawler or something 	
		toastr.error("Blog Delete from Tracker","Success");
		$('.tooltip').hide();
		
		numberofblogs = $('.edittrackerblogindividual').length;
		$('#totalblogcount').html(numberofblogs);
	});
	

// checkallblog or uncheckallblog action
$(".checkuncheckallblog").on("click", function(e){
ischecked = $(this).hasClass("uncheckallblog");

// triggers the selection of all blog 
if(ischecked)
{
	$(this).addClass("checkallblog").removeClass("uncheckallblog");
	$('.edittrackerblogindividual').children('.checkblogleft').children('.checkuncheckblog').addClass("checkblog").removeClass("uncheckblog");
	$('.edittrackerblogindividual').removeClass("btndefaultlook").addClass("btnselected");
	countselectedfromdefault =  $('.edittrackerblogindividual').children(".checkblogleft").children(".checkblog").length;
	$('#selectedblogcount').html(countselectedfromdefault);
//	console.log(ischecked);	
}

// triggers unselection of all blogs
else if(!ischecked)
{
	$(this).removeClass("checkallblog").addClass("uncheckallblog");
	$('.edittrackerblogindividual').children('.checkblogleft').children('.checkuncheckblog').removeClass("checkblog").addClass("uncheckblog");
	// check for untracked blog
//	beentracked = $('.edittrackerblogindividual').children('.iconsetblogs').children(".trackblogindividual").hasClass("trackblogblue");
//	console.log(beentracked);
//	if(!beentracked)
//	{
////		console.log(!beentracked)
//		console.log($('.edittrackerblogindividual').children('.iconsetblogs').children(".trackblogindividual").has("trackbloggrey"));
//		
////		.children('.checkblogleft').children('.checkuncheckblog').removeClass("checkblog").addClass("uncheckblog");
////		$('.edittrackerblogindividual').children('.checkblogleft').children('.checkuncheckblog').removeClass("checkblog").addClass("uncheckblog");
////		console.log(ischecked);
//	}
	$('.edittrackerblogindividual').each(function(el,i){
	untracked = $(this).children('.iconsetblogs').children(".trackblogindividual").hasClass("trackbloggrey");
	if(untracked)
		{
		$(this).children('.iconsetblogs').children(".trackblogindividual").has('.trackbloggrey').parent().parent().children('.checkblogleft').children('.checkuncheckblog').removeClass("checkblog").addClass("uncheckblog")
		}
	})
	
}

});

	
});
