$(document).ready(function() {
var trackscount = 0;	

//  show tooltip
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })

 //tracker list handler
$('.blogindividual').on("mouseenter",function(){
$(this).find(".checkblog").removeClass("hidden");
});


$('.blogindividual').on("mouseleave",function(){
  selected = $(this).hasClass("blogindividualactive");
  if(selected)
  {
  // do not hide delete icon
  }
  else if(!selected)
  {
    // hide delete icon
  $(this).find(".checkblog").addClass("hidden").removeClass("blogindividualactive");
  }
});

$('.blogindividual').on("click",function(e){
  selected = $(this).hasClass("blogindividualactive");
  // check selected blog
  if(!selected)
  {
    $(this).find(".blogtracker").removeClass("hidden");
    $(this).addClass("blogindividualactive");
    // remember to pass session id of blog
  }
  // check if a blog is not selected
  else if(selected)
  {
    $(this).find(".blogtracker").addClass("hidden");
    $(this).removeClass("blogindividualactive");
    // remember to pass session id of blog
  }

});

// end of blog individual


//tracker list handler
$('.trackerindividual').on("mouseenter",function(){
$(this).find(".checktracker").removeClass("hidden");
});


$('.trackerindividual').on("mouseleave",function(){
  selected = $(this).hasClass("trackerindividualactive");
  if(selected)
  {
  // do not hide delete icon
  }
  else if(!selected)
  {
    // hide delete icon
  $(this).find(".checktracker").addClass("hidden").removeClass("trackerindividualactive");
  }
});

$('.trackerindividual').on("click",function(e){
  selected = $(this).hasClass("trackerindividualactive");
  // check selected blog
  if(!selected)
  {
    $(this).find(".checktracker").removeClass("hidden");
    $(this).addClass("trackerindividualactive").removeClass("bold-text");
    // remember to pass session id of blog
  }
  // check if a blog is not selected
  else if(selected)
  {
    $(this).find(".checktracker").addClass("hidden");
    $(this).removeClass("trackerindividualactive");
    // remember to pass session id of blog
  }

});

// end of tracker list handler



//tracker list handler
$('.trackerindividual2').on("mouseenter",function(){
$(this).find(".checktracker2").removeClass("hidden");
});


$('.trackerindividual2').on("mouseleave focusout",function(){
  selected = $(this).hasClass("trackerindividual2active");
  if(selected)
  {
  // do not hide delete icon
  }
  else if(!selected)
  {
    // hide delete icon
  $(this).find(".checktracker2").addClass("hidden").removeClass("trackerindividual2active");
  }
});

// focusout effects
$('.trackerindividual2').on("focusout",function(){
  selected = $(this).hasClass("trackerindividual2active");
  if(selected)
  {
  // do not hide delete icon
  }
  else if(!selected)
  {
    // hide delete icon
// $(this).css("background-color","transparent");
// $(this).css("color","white");
  }

});
$('.trackerindividual2').on("click",function(e){
  selected = $(this).hasClass("trackerindividual2active");
  // check selected blog
  if(!selected)
  {
    $(this).find(".checktracker2").removeClass("hidden");
    $(this).addClass("trackerindividual2active");
    // remember to pass session id of blog
  }
  // check if a blog is not selected
  else if(selected)
  {
    $(this).find(".checktracker2").addClass("hidden");
    $(this).removeClass("trackerindividual2active");
    // remember to pass session id of blog
  }

});

// end of tracker list handler





// for the delete on hover for blog buttons
$('.blogselection').on("mouseenter",function(e){
$(this).find(".deleteblog").removeClass("hidden");
});

$('.blogselection').on("mouseleave",function(e){
// check the status of the button whether selecte or //
selected = $(this).hasClass("blogselectionactive");
if(selected)
{
// do not hide delete icon
}
else if(!selected)
{
  // hide delete icon
$(this).find(".deleteblog").addClass("hidden");
}


});

$('.blogselection').on("click",function(e){
  selected = $(this).hasClass("blogselectionactive");
  // check selected blog
  if(!selected)
  {
    $(this).find(".deleteblog").removeClass("hidden");
    $(this).addClass("blogselectionactive");
    // remember to pass session id of blog
  }
  // check if a blog is not selected
  else if(selected)
  {
    $(this).find(".deleteblog").addClass("hidden");
    $(this).removeClass("blogselectionactive");
    // remember to pass session id of blog
  }

});

$('.deleteblog').on("click",function()
{
$(this).parent().remove();
// perform an action that remove the blog from the list
})
// end

  
$('#closetracks').on("click",function(){
$(this).parent().toggle();	
});
  
// handler for each favorites
$(document).on("click",".favoritestoggle",function(e){
// check if it has been favorites
isFavorites = $(this).hasClass('far');
if(isFavorites) // if it is favorites
{
$(this).removeClass("far fa-heart").addClass("fas fa-heart");
$(this).attr("data-original-title","Remove to Favorite");
console.log("You Added to favorites")
// add an jax to favorites the post

}
else if(!isFavorites) // if it does not have favorites
{
$(this).removeClass("fas fa-heart").addClass("far fa-heart");
$(this).attr("data-original-title","Add to Favorite");
console.log("You removed from favorites")
// add an ajax to unfavorite the post

}

});
// end of handler for favorites


//select a blog to track
$(document).on("click",".trackblog",function(e){
// check the status if the blog is tracked
trackingblog = $(this).hasClass("text-success");
if(!trackingblog)
{
// if the blog is being tracked
$(this).addClass("text-success");
$(this).attr("data-original-title","Remove Blog from Tracker");
// adding blog to tracks
console.log("Added blog to be tracked");
// add an ajax to add blog to tracker
trackscount++;
$('#trackscount').html(trackscount);
$('.tracksection').show();
}
else if(trackingblog)
{
// if the blog is being tracked
$(this).removeClass("text-success");
$(this).attr("data-original-title","Add Blog from Tracker");

console.log("Removed blog to be tracked");
// add an ajax to remove blog from tracker
trackscount--;
$('#trackscount').html(trackscount);
$('.tracksection').show();
}
});




// call to action to start tracking blogs
$('#initiatetrack').on("click",function(e){

$('.trackinitiated, .modalbackdrop').show();

// scroll to top

window.scrollTo(0, 0);
	
});

$('.closedialog').on("click",function(e){

$('.trackinitiated, .modalbackdrop').hide();	
	
});




});








