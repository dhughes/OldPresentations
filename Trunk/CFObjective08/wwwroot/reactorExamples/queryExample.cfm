<cfset ReactorFactory = CreateObject("Component", "Reactor.ReactorFactory").init(expandPath("config/Reactor.xml"))  />

<cfset tick = getTickCount() />

<cfset CustomerGateway = ReactorFactory.createGateway("Customer") />

<cfset invoiceDetails = CustomerGateway.getInvoiceDetails() />

<cfoutput query="invoiceDetails" group="customerId">
	<h1>#invoiceDetails.firstname# #invoiceDetails.lastname#</h1><br />
	
	<cfoutput group="invoiceId">
		<cfif Len(invoiceDetails.invoiceId)>
			<h2>Invoice #invoiceDetails.invoiceId# / #DateFormat(invoiceDetails.invoiceDate)#</h2>
			
			<cfoutput>
				<p>#invoiceDetails.name# #DollarFormat(invoiceDetails.price)#</p>
			</cfoutput>
		</cfif>
	</cfoutput>
	
	<hr />
</cfoutput>

<!--- how long did it take? --->
<cfoutput>
<p><strong>Total time to run: #getTickCount()-tick# ms</strong></p>
</cfoutput>