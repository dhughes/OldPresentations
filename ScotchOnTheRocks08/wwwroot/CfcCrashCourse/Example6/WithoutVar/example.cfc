<cfcomponent>
	
	<cffunction name="foo" output="true">
		<!--- set x --->
		<cfset x = 42 />
		
		<!--- output x --->
		#x#<br>
		
		<!--- call bar() --->
		<cfset bar() />
		
		<!--- output x --->
		#x#<br>		
	</cffunction>

	<cffunction name="bar" output="true">
		<!--- set x --->
		<cfset x = "test" />
		
		<!--- output x --->
		#x#<br>
	</cffunction>
	
</cfcomponent>