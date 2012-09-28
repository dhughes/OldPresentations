
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

<!--- save the customer --->
<cfset CustomerRecord.save() />

<cfoutput>
	<p>
	FirstName: #CustomerRecord.getFirstName()#<br />
	LastName: #CustomerRecord.getLastName()#<br />
	Full Name: #CustomerRecord.getFullName()#
	</p>
</cfoutput>

