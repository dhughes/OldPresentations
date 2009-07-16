<cfcomponent implements="sorter">

	<cffunction name="sort" access="public" hint="I sort the given array of shapes" returntype="array">
		<cfargument name="array" required="yes" type="array" />
		<cfset var x = 0 />
		<cfset var holder = 0 />
		<cfset var sorted = false />
		
		<cfset y = 0 />
		
		<cfloop condition="NOT #sorted#">
			<cfset sorted = true />
			<!--- loop over the array --->
			<cfloop from="1" to="#ArrayLen(arguments.array)-1#" index="x">
				
				<!--- check this and the next element to see which comes first. --->
				<cfif getValue(arguments.array[x]) GT getValue(arguments.array[x+1])>
					<cfset holder = arguments.array[x] />
					<cfset arguments.array[x] = arguments.array[x+1] />
					<cfset arguments.array[x+1] = holder />
					<cfset sorted = false />
				</cfif>
			</cfloop>
		
		</cfloop>		
		
		<cfreturn arguments.array /> 
	</cffunction>
	
	<cffunction name="getValue" access="private" hint="I get the value for the shape's color" returntype="numeric">
		<cfargument name="shape" hint="I am the shape" required="yes" type="shape" />
		
		<cfswitch expression="#shape.getColor()#">
			<cfcase value="Red">
				<cfreturn 1 />
			</cfcase>
			<cfcase value="Orange">
				<cfreturn 2 />
			</cfcase>
			<cfcase value="Yellow">
				<cfreturn 3 />
			</cfcase>
			<cfcase value="Green">
				<cfreturn 4 />
			</cfcase>
			<cfcase value="Blue">
				<cfreturn 5 />
			</cfcase>
			<cfcase value="Indigo">
				<cfreturn 6 />
			</cfcase>
			<cfcase value="Violet">
				<cfreturn 7 />
			</cfcase>
		</cfswitch>
		
		
	</cffunction>
	
</cfcomponent>