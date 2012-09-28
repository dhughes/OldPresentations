
<!--- setup the config bean --->
<cfset ColdSpring = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset ColdSpring.loadBeans("ColdSpring.xml") />
	
<!--- create the reactor factory --->
<cfset Reactor = ColdSpring.getBean("ReactorFactory") />

<!--- create a record --->
<cfset AddressRecord = Reactor.createRecord("Address") />

<cfset AddressRecord.setStreet("123 Some Street") />
<cfset AddressRecord.setCity("Clayton") />
<cfset AddressRecord.setState("NC") />
<cfset AddressRecord.setPostalCode(27527) />
<cfset AddressRecord.setCountry("USA") />
<cfset AddressRecord.save() />

<!--- create a couple customers --->
<cfset CustomerRecord = Reactor.createRecord("Customer") />
<cfset CustomerRecord.setFirstName("Doug") />
<cfset CustomerRecord.setLastName("Hughes") />
<cfset CustomerRecord.setAddress(AddressRecord) />
<cfset CustomerRecord.save() />

<cfset CustomerRecord = Reactor.createRecord("Customer") />
<cfset CustomerRecord.setFirstName("Liz") />
<cfset CustomerRecord.setLastName("Hughes") />
<cfset CustomerRecord.setAddress(AddressRecord) />
<cfset CustomerRecord.save() />

<!--- get an iterator of customers for the address --->
<cfset CustomerIterator = AddressRecord.getCustomerIterator() />

<p>An Array of Customers:</p>
<cfdump var="#AddressRecord.getCustomerIterator().getArray()#" />

<p>A Query of Customers:</p>
<cfdump var="#AddressRecord.getCustomerIterator().getQuery()#" />


