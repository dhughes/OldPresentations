<cfset ReactorFactory = CreateObject("Component", "Reactor.ReactorFactory").init(expandPath("config/Reactor.xml"))  />

<cfset tick = getTickCount() />

<!--- get all customers --->
<cfset Customers = ReactorFactory.createGateway("CustomerDetail").getAll() />

<cfoutput query="Customers">
	<h1>#Customers.firstname# #Customers.middleName# #Customers.lastName#</h1>
	
	#Customers.street#<br />
	#Customers.city#,
	#Customers.state#
	#Customers.postalCode#
	#Customers.country#
	<br />

	<hr />
</cfoutput>

<!--- how long did it take? --->
<cfoutput>
<p><strong>Total time to run: #getTickCount()-tick# ms</strong></p>
</cfoutput>