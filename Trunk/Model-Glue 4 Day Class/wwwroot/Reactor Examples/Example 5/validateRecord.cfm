
<!--- setup the config bean --->
<cfset ColdSpring = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
<cfset ColdSpring.loadBeans("ColdSpring.xml") />
	
<!--- create the reactor factory --->
<cfset Reactor = ColdSpring.getBean("ReactorFactory") />

<!--- create a record --->
<cfset CustomerRecord = Reactor.createRecord("Customer") />

<!--- populate the customer but forget to provide the last name --->
<cfset CustomerRecord.setFirstName("Doug has an extreemly long first name which should impress just about anyone but which is difficult when working with older systems.") />

<!--- validate the customer --->
<cfset CustomerRecord.validate() />

<cfoutput>
	<p>Does the customer have errors? #CustomerRecord.hasErrors()#</p>
</cfoutput>

<!--- dump the problems --->
<cfset ErrorCollection = CustomerRecord._getErrorCollection() />

<p>Errors:</p>
<cfdump var="#ErrorCollection.getAsStruct()#" />

<hr />

<!--- fix the record --->
<cfset CustomerRecord.setFirstName("Doug") />
<cfset CustomerRecord.setLastName("Hughes") />

<!--- validate the customer --->
<cfset CustomerRecord.validate() />

<cfoutput>
	<p>Does the customer have errors? #CustomerRecord.hasErrors()#</p>
</cfoutput>