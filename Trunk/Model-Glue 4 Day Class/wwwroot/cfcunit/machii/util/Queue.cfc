<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="Queue"
	output="false"
	hint="A simple Queue component.">
	
	<!--- PROPERTIES --->
	<cfset variables.queueArray = ArrayNew(1) />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="Queue" output="false"
		hint="Initializes the queue.">
		<cfreturn this />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="put" access="public" returntype="void" output="false"
		hint="Queues the item.">
		<cfargument name="item" type="any" required="true" />
		<cfset ArrayAppend(variables.queueArray, arguments.item) />
	</cffunction>
	
	<cffunction name="get" access="public" returntype="any" output="false"
		hint="Dequeues and returns the next item in the queue.">
		<cfset var nextItem = variables.queueArray[1] />
		<cfset ArrayDeleteAt(variables.queueArray, 1) />
		<cfreturn nextItem />
	</cffunction>
	
	<cffunction name="peek" access="public" returntype="any" output="false"
		hint="Peeks the next item in the queue without removing it.">
		<cfreturn variables.queueArray[1] />
	</cffunction>
	
	<cffunction name="clear" access="public" returntype="void" output="false"
		hint="Clears the queue.">
		<cfset ArrayClear(variables.queueArray) />
	</cffunction>
	
	<cffunction name="getSize" access="public" returntype="numeric" output="false"
		hint="Returns the size of the queue (number of elements).">
		<cfreturn ArrayLen(variables.queueArray) />
	</cffunction>
	
	<cffunction name="isEmpty" access="public" returntype="boolean" output="false"
		hint="Returns whether or not the queue is empty.">
		<cfreturn getSize() EQ 0 />
	</cffunction>
	
</cfcomponent>