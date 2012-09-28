
<cfcomponent hint="I am the database agnostic custom Record object for the Customer object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.mg4dayExample10.Record.CustomerRecord" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getFullName" output="false" returntype="string">
		<cfreturn getFirstName() & " " & getLastName() />
	</cffunction>
	
</cfcomponent>
	
