$(document).ready(function() {
var trackscount = 0;	

//  show tooltip
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })

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







});








