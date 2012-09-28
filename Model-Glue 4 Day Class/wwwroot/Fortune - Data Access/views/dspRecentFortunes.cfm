<cfset fortunes = viewstate.getValue("Fortunes") />

<h1>Recent Fortunes...</h1>

<cfoutput>
	<p><strong>The last #ArrayLen(fortunes)# fortunes...</strong></p>

	<cfloop from="1" to="#ArrayLen(fortunes)#" index="x">
		<p>
			<pre>#fortunes[x]#</pre>
		</p>
		<hr />
	</cfloop>
</cfoutput>