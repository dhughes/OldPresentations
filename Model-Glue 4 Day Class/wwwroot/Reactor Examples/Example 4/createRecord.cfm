
<!--- setup the config bean --->
<cfset ColdSpring = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset ColdSpring.loadBeans("ColdSpring.xml") />
	
<!--- create the reactor factory --->
<cfset Reactor = ColdSpring.getBean("ReactorFactory") />

<!--- create a record --->
<cfset CustomerRecord = Reactor.createRecord("Customer") />

<!--- populate the customer --->
<cfset CustomerRecord.setFirstName("Doug") />
<cfset CustomerRecord.setLastName("Hughes") />

<cfoutput>
	<p>
	FirstName: #CustomerRecord.getFirstName()#<br />
	LastName: #CustomerRecord.getLastName()#
	</p>
</cfoutput>

<!--- save the customer --->
<cfset CustomerRecord.save() />
<cfset customerId = CustomerRecord.getCustomerId() />

<!--- reset the customer record and load the record we saved --->
<cfset CustomerRecord = 0 />
<cfset CustomerRecord = Reactor.createRecord("Customer").load(customerId=customerId) />

<cfoutput>
	<p>
	CustomerId: #CustomerRecord.getCustomerId()#<br />
	FirstName: #CustomerRecord.getFirstName()#<br />
	LastName: #CustomerRecord.getLastName()#
	</p>
</cfoutput>

