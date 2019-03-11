//console.log("Window is loading ");

$(window).load(function(){	
	
})

$("body").removeClass("loaded");
$(document).ready(function(e)
{
$('a').on("click",function(e){
if(!$(this).hasClass("dropdown-toggle"))
{
	$("body").removeClass('loaded');	
}


});
	 
$("body").addClass("loaded");
	
	
$(function () {
$('[data-toggle="tooltip"]').tooltip()
  })	
  $(".profiletoggle").click(function(e){
  e.preventDefault();
  $(".modal-notifications").css( { transition: "transform 0.80s",
                  transform:  "translate(0px,0px)"} );

  });
	
	
	
	 $("#profiletoggle").click(function(e){
		  e.preventDefault();
		  $("body").addClass("loaded");
		  $(".modal-notifications").css( { transition: "transform 0.80s",
		                  transform:  "translate(0px,0px)"} );

		  }) ;

  $("#closeicon, .closesection").click(function(e){
  e.preventDefault();
  $(".modal-notifications").css( { transition: "transform 0.80s",
                  transform:  "translate(8000px,0px)"} );

  }) ;
});
