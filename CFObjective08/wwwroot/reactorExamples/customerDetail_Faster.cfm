<cfset ReactorFactory = CreateObject("Component", "Reactor.ReactorFactory").init(expandPath("config/Reactor.xml"))  />

<cfset tick = getTickCount() />

<!--- get all customers --->
<cfset Customers = ReactorFactory.createIterator("CustomerDetail") />

<cfloop from="1" to="#Customers.getRecordCount()#" index="w">
	<!--- get the first customer --->
	<cfset Customer = Customers.getAt(w) />

	<!--- output the customer and their address --->	
	<cfoutput>
		<h1>#Customer.getFirstName()# #Customer.getLastName()#</h1>
		
		#Customer.getStreet()#<br />
		#Customer.getCity()#,
		#Customer.getState()#
		#Customer.getPostalCode()#
		#Customer.getCountry()#
		<br />
	</cfoutput>
	<hr />
</cfloop>

<!--- how long did it take? --->
<cfoutput>
<p><strong>Total time to run: #getTickCount()-tick# ms</strong></p>
</cfoutput>