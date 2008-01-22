<cfcomponent displayName="RequestLog" output="false" hint="I am a log populated during the request cycle.">
  <cffunction name="Init" access="public" returnType="any" output="false" hint="I build a new RequestLog.">
    <cfset variables.log = arrayNew(1) />

    <cfreturn this />
  </cffunction>

  <cffunction name="Add" access="public" returnType="void" hint="I add an entry to the log.">
  	<cfargument name="time" type="numeric" required="true" hint="I am the time of this entry." />
  	<cfargument name="type" type="string" required="true" hint="I am the type of this entry." />
  	<cfargument name="message" type="string" required="true" hint="I am the message of this entry." />
  	<cfargument name="tag" type="string" required="true" hint="I am ModelGlue.xml tag related to this entry." />
  	<cfargument name="status" type="string" required="true" hint="I am the status of this entry." />

  	<cfset arrayAppend(variables.log, arguments) />
  </cffunction>

  <cffunction name="getLog" access="public" returnType="array" hint="I return the log's contents.">
  	<cfreturn duplicate(variables.log) />
  </cffunction>
</cfcomponent>