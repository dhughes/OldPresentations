<cfcomponent hint="I am a hello world component">
	
	<cffunction name="sayHello"
		returntype="string"
		access="public"
		output="false"
		hint="This method returns the string 'Hello World!'">
		
		<cfreturn "Hello World!" />
	</cffunction>
	
</cfcomponent>