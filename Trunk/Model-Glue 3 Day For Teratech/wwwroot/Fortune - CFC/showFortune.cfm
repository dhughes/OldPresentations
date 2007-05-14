
<cfset Fortune = CreateObject("Component", "Fortune").init(datasource, username, password) />
<cfset fortune = Fortune.getFortune(form.categoryId) />


<h1>Your Fortune...</h1>

<p>
	<pre><cfoutput>#fortune#</cfoutput></pre>
</p>

<p><a href="index.cfm">Start over</a></p>
