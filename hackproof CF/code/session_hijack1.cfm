<cfset error = "" />

<cfif structKeyExists(form, "username")>
	<cfquery name="getUser" datasource="hackproof">
		SELECT *
		FROM users
		WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar"> AND password = <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfif getUser.recordcount NEQ 1>
		<cfset error = "Username or password are incorrect, please try again.">
		<cfelse>
		<cfset session.firstName = getUser.firstName />
		<cfset session.lastName = getUSer.lastName />
		<cfset session.userName = getUser.username />
		<cfset session.loggedin = createUUID() />

	</cfif>
</cfif>


<cfif NOT structKeyExists(session, "loggedin")>
	<div style="font-weight:bold"><cfoutput>#error#</cfoutput></div>
	<form method="post">
		<fieldset>
			<legend>Login</legend>
			<label for="username">Username: 
				<input type="text" name="username" id="username" />
			</label>
			<br />
			<label for="password">Password:
				<input type="password" name="password" id="password" />
			</label>
			<input type="submit" value="login" />
		</fieldset>
	</form>
	<cfelse>
	<cfoutput>Hi, #session.firstName#!</cfoutput>
</cfif>


<cfdump var="#session#">
