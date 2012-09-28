<cfcomponent>
	<cffunction name="Init">
		<cfargument name="wsdl" />
		<cfset variables.wsdl = arguments.wsdl />
		<cfreturn this />
	</cffunction>

	<cffunction name="GetQuote">
		<cfargument name="symbol">
		<cfset var svc = createObject("webservice", variables.wsdl) />
		<cfset var result = createObject("component", "StockQuoteResult").init() />

		<Cfset result.setSymbol(arguments.symbol) />
		<cfset result.setResult(svc.getQuote(arguments.symbol)) />

		<cfreturn result />
	</cffunction>
</cfcomponent>