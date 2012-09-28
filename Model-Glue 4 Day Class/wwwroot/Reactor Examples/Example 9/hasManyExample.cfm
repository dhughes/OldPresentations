
<!--- setup the config bean --->
<cfset ColdSpring = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset ColdSpring.loadBeans("ColdSpring.xml") />
	
<!--- create the reactor factory --->
<cfset Reactor = ColdSpring.getBean("ReactorFactory") />

<!--- create a few products --->
<cfset ProductRecord1 = Reactor.createRecord("Product") />
<cfset ProductRecord1.setName("Alagad Image Component") />
<cfset ProductRecord1.setDescription("A nice image component") />
<cfset ProductRecord1.setPrice(150) />
<cfset ProductRecord1.save() />

<cfset ProductRecord2 = Reactor.createRecord("Product") />
<cfset ProductRecord2.setName("Alagad Captcha Component") />
<cfset ProductRecord2.setDescription("A nice captcha component") />
<cfset ProductRecord2.setPrice(75) />
<cfset ProductRecord2.save() />

<cfset ProductRecord3 = Reactor.createRecord("Product") />
<cfset ProductRecord3.setName("Alagad Zip Component") />
<cfset ProductRecord3.setDescription("A nice zip component") />
<cfset ProductRecord3.setPrice(50) />
<cfset ProductRecord3.save() />

<!--- create a customer --->
<cfset CustomerRecord = Reactor.createRecord("Customer") />
<cfset CustomerRecord.setFirstName("Doug") />
<cfset CustomerRecord.setLastName("Hughes") />

<!--- create a new invoice for the customer --->
<cfset InvoiceRecord = CustomerRecord.getInvoiceIterator().add() />
<cfset InvoiceRecord.setCustomer(CustomerRecord) />

<!--- save the customer (changes will cascade) --->
<cfset CustomerRecord.save() />

<!--- create an invoice --->
<cfset InvoiceRecord.getProductIterator().add(ProductRecord1) />
<cfset InvoiceRecord.getProductIterator().add(ProductRecord2) />
<cfset InvoiceRecord.getProductIterator().add(ProductRecord3) />
<cfset InvoiceRecord.save() />

<p>An Array of Products on the invoice:</p>
<cfdump var="#InvoiceRecord.getProductIterator().getArray()#" />

<p>A Query of Products on the invoice:</p>
<cfdump var="#InvoiceRecord.getProductIterator().getQuery()#" />

