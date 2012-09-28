<!--- setup the config bean --->
<cfset exampleNumber = 1 />
<cfset Config = CreateObject("Component", "reactor.config.config").init("Reactor.xml") />
<cfset Config.setProject("mg4dayExample#exampleNumber#") />
<cfset Config.setDsn("ReactorExamples") />
<cfset Config.setType("mssql") />
<cfset Config.setMapping("/Reactor Examples/Example #exampleNumber#/data") />
<cfset Config.setMode("always") />
	
<!--- create the reactor factory --->
<cfset Reactor = CreateObject("Component", "reactor.ReactorFactory").init(Config) />

<cfdump var="#Reactor#" />