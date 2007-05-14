<cfcomponent displayname="ListenerRegistry" hint="I register listeners for messages." output="false">

<cffunction name="init" returntype="ModelGlue.unity.listener.ListenerRegistry" access="public" output="false">
	<cfset variables._listeners = structNew() />
	<cfreturn this />
</cffunction>

<cffunction name="addListener" returntype="void" access="public" hint="I register a given Controller instance's method to listen for a given message." output="false">
	<cfargument name="message" type="string" required="true" />
	<cfargument name="target" type="any" required="true" />
	<cfargument name="method" type="string" required="true" />
	<cfargument name="async" type="boolean" required="true" />
	
	<cfset var listener = "" />
	
	<cfset listener = createObject("component", "ModelGlue.unity.listener.Listener").init(arguments.target, arguments.method, arguments.async) />
	
	<cfif not structKeyExists(variables._listeners, arguments.message)>
		<cfset variables._listeners[arguments.message] = arrayNew(1) />
	</cfif>

	<cfset arrayAppend(variables._listeners[arguments.message], listener) />
</cffunction>

<cffunction name="getListeners" access="public" hint="I return listeners for a given message." output="false">
	<cfargument name="message" type="string" required="true" />
	
	<cftry>
		<cfreturn variables._listeners[arguments.message] />
		<cfcatch>
			<cfreturn arrayNew(1) />
		</cfcatch>
	</cftry>	
</cffunction>

</cfcomponent>