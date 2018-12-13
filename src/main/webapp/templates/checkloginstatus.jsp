<% Object emailcheck = (null == session.getAttribute("email")) ? "" : session.getAttribute("email"); %> 

<script>
<% if(emailcheck.toString().equalsIgnoreCase(null) || emailcheck.toString().equalsIgnoreCase(""))
	{ %>
	Cookies.set('loggedinstatus', false , {path : '/'});
	<%} else {%>
	Cookies.set('loggedinstatus', true , {path : '/'});	
	<%}%>
	Cookies.set('allfavoritesblogs', "" , {path : '/'});
	//console.log(Cookies.get('loggedinstatus'))
</script>