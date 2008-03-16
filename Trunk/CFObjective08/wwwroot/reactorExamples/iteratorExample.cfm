<cfset ReactorFactory = CreateObject("Component", "Reactor.ReactorFactory").init(expandPath("config/Reactor.xml"))  />

<cfset tick = getTickCount() />

<!--- get all customers --->
<cfset Customers = ReactorFactory.createIterator("Customer") />

<cfloop from="1" to="#Customers.getRecordCount()#" index="w">
	<!--- get the first customer --->
	<cfset Customer = Customers.getAt(w) />

	<!--- output all the invoices and products for that customer --->	
	<cfoutput>
		<h1>#Customer.getFirstName()# #Customer.getLastName()#</h1>
		
		<cfset Invoices = Customer.getInvoiceIterator() />
		
		<cfloop from="1" to="#invoices.getRecordCount()#" index="x">
			<cfset Invoice = Invoices.getAt(1) />
			<h2>Invoice #Invoice.getInvoiceId()# / #DateFormat(Invoice.getInvoiceDate())#</h2>
			
			<cfset Products = Invoice.getProductIterator() />
			<cfloop from="1" to="#Products.getRecordCount()#" index="y">
				<cfset Product = Products.getAt(y) />
				<p>#Product.getName()# #DollarFormat(Product.getPrice())#</p>
			</cfloop>
		</cfloop>
		
	</cfoutput>
	<hr />
</cfloop>

<!--- how long did it take? --->
<cfoutput>
<p><strong>Total time to run: #getTickCount()-tick# ms</strong></p>
</cfoutput>