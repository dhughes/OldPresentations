<cfset price = viewState.getValue("price") />

<cfoutput>
<form action="index.cfm?event=stockquote" method="post">
Symbol: 
<input type="text" name="symbol" value="#viewState.getValue("symbol")#">
<input type="submit" value="Go">
</form>

<cfif len(price)>
Current Price: #price#
</cfif>
</cfoutput>