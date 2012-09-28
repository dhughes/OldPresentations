<cfcomponent>
	
	<cffunction name="foo" output="true">
		<!--- set x --->
		<cfset var x = 42 />
		
		<!--- output x --->
		#x#<br>
		
		<!--- call bar() --->
		<cfset bar() />
		
		<!--- output x --->
		#x#<br>		
	</cffunction>

	<cffunction name="bar" output="true">
		<!--- set x --->
		<cfset var x = "test" />
		
		<!--- output x --->
		#x#<br>
	</cffunction>
	
</cfcomponent>