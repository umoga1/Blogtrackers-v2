<script>
<% if(email.toString().equalsIgnoreCase(null) || email.toString().equalsIgnoreCase(""))
	{ %>
	Cookies.set('loggedinstatus', false , {path : '/'});
	<%} else {%>
	Cookies.set('loggedinstatus', true , {path : '/'});	
	<%}%>
	console.log(Cookies.get('loggedinstatus'))
</script>