$(document).ready(function(){
	
$('.edittrackerpopaction').on("click",function(e){
e.preventDefault();	
ShowAnElement('.edittrackerpop');
ShowAnElement('.modalbackdrop');
})


$('.closedialog').on("click",function(e){
e.preventDefault();	
HideAnElement('.edittrackerpop');
HideAnElement('.modalbackdrop');
})
	
});


function HideAnElement(className)
{
$(className).addClass("hidden");	
}

function ShowAnElement(className)
{
$(className).removeClass("hidden");	
}