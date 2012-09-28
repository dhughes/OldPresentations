
<cfcomponent hint="I am the database agnostic custom Record object for the Customer object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.Scratch.Record.CustomerRecord" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getFullName">
		<cfreturn getFirstName() & " " & getLastName() />
	</cffunction>
	
	<!--- firstName --->
	<cffunction name="getfirstName" hint="I set the firstName value ." access="public" output="false" returntype="string">
		<cfreturn "Foo" />
			
	</cffunction>
	
</cfcomponent>
	
