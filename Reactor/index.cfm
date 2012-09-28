
<!--- create the reactorFactory --->
<cfset Reactor = CreateObject("Component",
	"reactor.reactorFactory").init(expandPath("reactor.xml")) />

<cfset customer = reactor.createRecord("Customer").load(customerId=1) />
<cfset invoices = customer.getInvoiceIterator() />

<cfset where = invoices.getAt(2).getProductIterator().getWhere() />
<cfset where.isLike("Product", "name", "lamp") />

<cfdump var="#invoices.getAt(2).getProductIterator().getquery()#" />