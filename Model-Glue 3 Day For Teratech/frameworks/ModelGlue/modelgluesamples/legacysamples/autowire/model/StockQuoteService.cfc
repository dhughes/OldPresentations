<cfcomponent>
	<cffunction name="Init">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="GetQuote">
		<cfargument name="symbol">
		<cfset var svc = createObject("webservice", "http://services.xmethods.net/soap/urn:xmethods-delayed-quotes.wsdl") />
		<cfset var result = createObject("component", "StockQuoteResult").init() />
		
		<Cfset result.setSymbol(arguments.symbol) />
		<cfset result.setResult(svc.getQuote(arguments.symbol)) />

		<cfreturn result />
	</cffunction>
</cfcomponent>