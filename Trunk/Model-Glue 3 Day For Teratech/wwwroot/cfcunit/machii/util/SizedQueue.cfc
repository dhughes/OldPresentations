<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="SizedQueue" 
	extends="Queue"
	output="false"
	hint="A specialization of Queue to limit size.">
	
	<!--- PROPERTIES --->
	<cfset variables.maxSize = 100 />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="SizedQueue" output="false"
		hint="Initializes the queue.">
		<cfargument name="maxSize" type="numeric" required="false" default="100" />
		
		<cfset super.init() />
		<cfset setMaxSize(arguments.maxSize) />
		
		<cfreturn this />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="put" access="public" returntype="void" output="false"
		hint="Queues the item.">
		<cfargument name="item" type="any" required="true" />
		
		<cfif NOT isFull()>
			<cfset super.put(arguments.item) />
		<cfelse>
			<cfthrow message="Max size of SizedQueue is #getMaxSize()# and has been exceeded." />
		</cfif>
	</cffunction>
	
	<cffunction name="setMaxSize" access="public" returntype="void" output="false"
		hint="Sets the maximum size of the queue.">
		<cfargument name="maxSize" type="numeric" required="true" />
		<cfset variables.maxSize = arguments.maxSize />
	</cffunction>
	<cffunction name="getMaxSize" access="public" returntype="numeric" output="false"
		hint="Returns the maximum size of the queue.">
		<cfreturn variables.maxSize />
	</cffunction>
	
	<cffunction name="isFull" access="public" returntype="boolean" output="false"
		hint="Returns whether or not the queue is full.">
		<cfreturn getSize() EQ getMaxSize() />
	</cffunction>
	
</cfcomponent>