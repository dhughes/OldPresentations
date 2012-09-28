
<cfcomponent hint="I am the database agnostic custom Gateway object for the Customer object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.ReactorExamples.Gateway.CustomerGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getInvoiceDetails" access="public" hint="I return a query of all customers, their invoices and the products on that invoice" output="false" returntype="query">
		<cfset var invoiceDetails = 0 />
		
		<cfquery name="invoiceDetails" datasource="#_getConfig().getDsn()#">
			SELECT c.customerId, c.firstName, c.lastName, i.invoiceId, i.invoiceDate, p.name, p.price
			FROM Customer as c LEFT JOIN Invoice as i
				ON c.customerId = i.customerId
			LEFT JOIN InvoiceProduct as ip
				ON i.invoiceId = ip.invoiceId
			LEFT JOIN Product as p
				ON ip.productId = p.productId
			ORDER BY c.customerId, i.invoiceId, p.productId
		</cfquery>
		
		<cfreturn invoiceDetails />
	</cffunction>
	
	
</cfcomponent>
	
