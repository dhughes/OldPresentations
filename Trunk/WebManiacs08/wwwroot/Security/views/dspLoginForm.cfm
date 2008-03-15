<cfset myself = viewstate.getValue("myself") />
<cfset xe.SubmitLoginForm = viewstate.getValue("xe.SubmitLoginForm") />
<cfset username = viewstate.getValue("userName") />

<h1>Login</h1>
<cfform name="login" action="#myself##xe.SubmitLoginForm#" method="post" >
	<p>Username:
		<cfinput type="text" name="username" value="#username#" />
	</p>
	<p>Password:
		<cfinput type="password" name="password" value="" label="Password" />
	</p>
	
	<cfinput type="submit" name="Login" value="Login" />
</cfform>