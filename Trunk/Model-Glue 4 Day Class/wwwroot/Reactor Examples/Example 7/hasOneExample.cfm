
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
<cfset CustomerRecord.getAddress().setStreet("123 Some Street") />
<cfset CustomerRecord.getAddress().setCity("Clayton") />
<cfset CustomerRecord.getAddress().setState("NC") />
<cfset CustomerRecord.getAddress().setPostalCode(27527) />
<cfset CustomerRecord.getAddress().setCountry("USA") />

<!--- save the customer --->
<cfset CustomerRecord.save() />
<cfset customerId = CustomerRecord.getCustomerId() />

<!--- reset the customer record and load the record we saved --->
<cfset CustomerRecord = 0 />
<cfset CustomerRecord = Reactor.createRecord("Customer").load(customerId=customerId) />

<cfoutput>
	<p>Customer Address:</p>
	
	<p>
	#CustomerRecord.getFirstName()# #CustomerRecord.getLastName()#<br />
	#CustomerRecord.getAddress().getStreet()#<br />
	#CustomerRecord.getAddress().getCity()#, #CustomerRecord.getAddress().getState()# #CustomerRecord.getAddress().getPostalCode()# #CustomerRecord.getAddress().getCountry()#
	</p>
</cfoutput>
