<cfcomponent displayname="Controller" output="false" hint="I am a sample model-glue controller." extends="ModelGlue.Core.Controller">

<!--- Constructor --->
<cffunction name="Init" access="Public" returnType="Controller" output="false" hint="I build a new SampleController">
  <cfargument name="ModelGlue" required="true" type="ModelGlue.ModelGlue" />
  <cfargument name="InstanceName" required="true" type="string" />
  <cfset super.Init(arguments.ModelGlue) />

	<!--- Controllers are in the application scope:  Put any application startup code here. --->

	<!--- This holds an instance of the stockquote service --->
	<cfset variables._stockservice = "" />
		
  <cfreturn this />
</cffunction>

<!--- This "Set" method will automatically be called by ColdSpring --->
<cffunction name="SetStockQuoteService"  access="public" returntype="void" output="false">
	<cfargument name="StockQuoteService" type="any" required="true">
	<cfset variables._stockservice = arguments.StockQuoteService />
</cffunction>
<cffunction name="GetStockQuoteService" access="public" returntype="any" output="false">
	<cfreturn variables._stockservice />
</cffunction>


<!--- Functions specified by <message-listener> tags --->
<cffunction name="OnRequestStart" access="Public" returntype="void" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
</cffunction>

<cffunction name="OnRequestEnd" access="Public" returntype="void" output="false" hint="I am an event handler.">
  <cfargument name="event" type="ModelGlue.Core.Event" required="true">
</cffunction>

<cffunction name="GetGreeting" access="Public" returnType="void" output="false" hint="I am an event handler.">
	<cfargument name="event" type="ModelGlue.Core.Event" required="true">
	<cfset arguments.event.SetValue("Greeting", "Hello, I am the Controller!") />
</cffunction>

<cffunction name="GetStockQuote" access="Public" returnType="void" output="false" hint="I am an event handler.">
	<cfargument name="event" type="ModelGlue.Core.Event" required="true">
	
	<cfset var symbol = arguments.event.GetValue("symbol") />
	<cfset var QuoteGetter = GetStockQuoteService() />
	<cfset var result = "" />
	
	<cfif not len(symbol)>
		<cfset symbol = arguments.event.GetArgument("DefaultSymbol") />
	</cfif>
	
	<cftry>
		<cfset result = getFromCache("stockQuoteResult_" & symbol) />
		<cfset arguments.event.trace("GetQuote()", "Retrieved quote for #symbol# from cache!") />
		<cfcatch>
			<cfset result = QuoteGetter.GetQuote(symbol) />
			<cfset addToCache("stockQuoteResult_" & symbol, result) />
			<cfset arguments.event.trace("GetQuote()", "Added quote for #symbol# to cache!") />
		</cfcatch>
	</cftry>
	
	<cfset arguments.event.setValue("symbol", result.getSymbol()) />
	<cfset arguments.event.setValue("price", result.getResult()) />
	
	<cfif result.getResult() lt 0>
		<cfset arguments.event.addResult("badSymbol") />
	</cfif>
</cffunction>

</cfcomponent>

