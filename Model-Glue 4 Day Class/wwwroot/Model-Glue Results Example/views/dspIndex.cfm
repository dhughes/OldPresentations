<cfset code = viewstate.getValue("code") />
<cfset matchFailed = viewstate.getValue("matchFailed", false) />

<p>Type the code you see below into the text box:</p>

<cfif matchFailed>
	<h1 style="color: red">No Match!!!!</h1>
</cfif>

<cfform action="index.cfm?event=checkCode">
	<p>
		<strong>Code:</strong><br/>
		<cfoutput>#code#</cfoutput>
		<cfinput type="hidden" name="requiredCode" value="#code#" />
	</p>
	
	<p>
		<strong>Type the code:</strong><br />
		<cfinput type="text" name="providedCode" value="" size="32" />
	</p>
	
	<cfinput type="Submit" name="submit" />
</cfform>