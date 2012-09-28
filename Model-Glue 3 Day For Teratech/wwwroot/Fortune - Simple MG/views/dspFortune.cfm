<cfset fortune = viewstate.getValue("fortune") />

<h1>Your Fortune...</h1>

<p>
	<pre><cfoutput>#fortune#</cfoutput></pre>
</p>

<p><a href="index.cfm">Start over</a></p>
