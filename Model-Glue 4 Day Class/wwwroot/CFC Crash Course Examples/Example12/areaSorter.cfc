<cfcomponent implements="sorter">

	<cffunction name="sort" access="public" hint="I sort the given array" returntype="array">
		<cfargument name="array" required="yes" type="array" />
		<cfset var x = 0 />
		<cfset var holder = 0 />
		<cfset var sorted = false />
		
		<cfset y = 0 />
		
		<cfloop condition="NOT #sorted#">
			<cfset sorted = true />
			<!--- loop over the array --->
			<cfloop from="1" to="#ArrayLen(arguments.array)-1#" index="x">
				
				<!--- check this and the next element to see which is larger. --->
				<cfif arguments.array[x].getArea() GT arguments.array[x+1].getArea()>
					<cfset holder = arguments.array[x] />
					<cfset arguments.array[x] = arguments.array[x+1] />
					<cfset arguments.array[x+1] = holder />
					<cfset sorted = false />
				</cfif>
			</cfloop>
		
		</cfloop>		
		
		<cfreturn arguments.array /> 
	</cffunction>
	
</cfcomponent>