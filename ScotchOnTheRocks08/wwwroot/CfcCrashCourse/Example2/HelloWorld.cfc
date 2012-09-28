<cfcomponent hint="This component is a Hello World example.">
	
	<cffunction name="sayHello"
		returntype="string"
		access="remote"
		output="false"
		hint="This method returns the string 'Hello World!'">
		
		<cfreturn "Hello World! (Try browsing directly to me)" />
	</cffunction>
	
</cfcomponent>